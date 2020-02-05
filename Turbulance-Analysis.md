# Data Sorting

In this documentation, we will walk through the data processing and sorting for analyzing SAVANT project data.

## 0. Getting Started

The original data was collected and quality controlled by NCAR. All the datasets are grouped into 24-hour interval based on ==Coordinated Universal Time (UTC)== time zone, in `.nc`file format. In order to extract the relevant datasets we are interested in, please utilize `NC Toolkit`provided for this project. The time variable will be adjusted to ==Central Standard Time (CST)==. All the datasets will be saved in `.csv` UTF-8 format.

## 1. Data Selection

After extracting all dataset variables, we collect the related data points based on the following rules.

### 1.1 Variables

In order to perform calculations based on Jielun's Analysis, the following variables are being extracted:

| Variable Format | Description | Category |
| --------------- | ----------- | -------- |
| `u_<height>_m`  |             |          |
| `v_<height>_m`  |             |          |
| `w_<weight>_m`  |             |          |

For more details, please visit the SAVANT dataset description list.



---

### Data Excluded

Based on [Jielun's CASE-99 analysis]( [https://journals.ametsoc.org/doi/pdf/10.1175/1520-0477%282002%29083%3C0555%3ACACIOT%3E2.3.CO%3B2](https://journals.ametsoc.org/doi/pdf/10.1175/1520-0477(2002)083<0555%3ACACIOT>2.3.CO%3B2), in order to perform numerical analysis for turbulence regimes and turbulence intermittency in the stable boundary layers, the ideal weather condition should be stable and dry. Hence, we filter the experimental data based on the following criteria.

### 0. Concerns

After reviewing Jielun's analysis performed on CASE-99, which were published in 2002, 2003, 2012, and 2016, I was not able to find any comments on data selection. According to weather history, there were dates during the data collection period for CASE-99 where extreme weather conditions occurred. 

In addition, after examining the publications listed under [CASE-99 Publications](https://www.eol.ucar.edu/node/387/publications) page, only vague descriptions on 

### 1. Weather Conditions

The following rules are being applied to separate the observation datasets into different groups.

#### 1.1 Precipitation

Precipitation brings high humidity condition during the experiments. The precipitation will lead to high thermal exchange post the precipitation period. This can cause instability environmental condition which is not suitable for our study. Hence, the following condition is being used in order to filter out instability period. `Precip.` is the variable of measured precipitation represented in the hourly climate data.

```bash
Precip. > 0.00 in
```

#### 1.2 Weather Condition

Since the precipitation resolution is only `0.01 in` collected from the hourly weather station. Sometimes, light rain or short storm was not able to be properly reflected on hourly precipitation collection. Therefore, regular expression method is being used in order to sort out these un-measurable sampling periods. In the hourly climate data, variable `Condition` is used for observers to record current weather condition at the given time. Hence, the following condition is being used in order to filter out instability period.

```bash
Condition == 'Rain'|'Wintry Mix'|'Storm'|'Snow'
```

Note that, for `Condition == 'Rain`, `Light Rain`, `Heavy Rain` are all included since these condition all contains the token `Rain`.

#### 1.3 Related Thermal Instable Period

Post precipitation period, as the sensors are covered with moisture, according to technicians, 2 hours are usually needed for the surface of the sensors to dry out. During the drying period, the accuracy of the data may be affected due to local thermal exchange. Therefore, in order to avoid potential data corruptions, data from the hour before the starting of precipitation, along with 2 hours post the precipitation periods are being removed. For example:

<Insert a picture of the workbook to illustrate it.>

### 2. Corrupted Datasets

During the data collection period, sensors can be offline, or malfunction during operation. Under some occasions, we witness that on the same tower, sensors at certain height can have missing data samples. For example:

<Insert a picture of the workbook to illustrate it.>

In order to maintain the data integrity, at the time when one or more sensor at a given tower is missing, all data samples being collected at the time will be removed.







---

### Criteria For Instability

>  For a continuously varying distribution of density and velocity (with the lighter layers uppermost, so that the fluid is [RT-stable](https://en.wikipedia.org/wiki/Rayleigh–Taylor_instability)), the dynamics of the KH instability is described by the [Taylor–Goldstein equation](https://en.wikipedia.org/wiki/Taylor–Goldstein_equation) and its onset is given by the [Richardson number](https://en.wikipedia.org/wiki/Richardson_number)![{\displaystyle Ri}](https://wikimedia.org/api/rest_v1/media/math/render/svg/0b39e6e2306008a61f3bc93256aab0ac596c87d1). Typically the layer is unstable for![{\displaystyle Ri<0.25}](https://wikimedia.org/api/rest_v1/media/math/render/svg/a4ba4043e62c448a1289ae8be7d05ea99d7cadab). These effects are common in cloud layers. The study of this instability is applicable in plasma physics, for example in [inertial confinement fusion](https://en.wikipedia.org/wiki/Inertial_confinement_fusion) and the [plasma](https://en.wikipedia.org/wiki/Plasma_(physics))–[beryllium](https://en.wikipedia.org/wiki/Beryllium) interface.
>
> ​																																																													— [Wikipedia]( [https://en.wikipedia.org/wiki/Kelvin%E2%80%93Helmholtz_instability](https://en.wikipedia.org/wiki/Kelvin–Helmholtz_instability) )

