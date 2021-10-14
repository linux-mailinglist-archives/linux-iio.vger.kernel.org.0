Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F389C42D4BB
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 10:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhJNI1D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 04:27:03 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:40458 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhJNI1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 04:27:02 -0400
Received: from [192.168.224.11] (ert768.prtnl [192.168.224.11])
        by sparta.prtnl (Postfix) with ESMTP id 559AC44A024F;
        Thu, 14 Oct 2021 10:24:54 +0200 (CEST)
Subject: Re: [PATCH v5 0/4] iio: chemical: Add support for Sensirion SCD4x CO2
 sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20211008101706.755942-1-roan@protonic.nl>
 <20211010165919.51f06938@jic23-huawei> <20211013183828.521f043f@jic23-huawei>
From:   Roan van Dijk <roan@protonic.nl>
Message-ID: <3ecfe246-b942-0c1e-08e6-17eff4c5cc16@protonic.nl>
Date:   Thu, 14 Oct 2021 10:24:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211013183828.521f043f@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 13-10-2021 19:38, Jonathan Cameron wrote:
> On Sun, 10 Oct 2021 16:59:19 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On Fri,  8 Oct 2021 12:17:02 +0200
>> Roan van Dijk <roan@protonic.nl> wrote:
>>
>>> This series adds support for the Sensirion SCD4x sensor.
>>>
>>> The driver supports continuous reads of temperature, relative humdity and CO2
>>> concentration. There is an interval of 5 seconds between readings. During
>>> this interval the drivers checks if the sensor has new data available.
>>>
>>> The driver is based on the scd30 driver. However, The scd4x has become too
>>> different to just expand the scd30 driver. I made a new driver instead of
>>> expanding the scd30 driver. I hope I made the right choice by doing so?
>>
>> Applied to the togreg branch of iio.git with the issues Randy mentioned tidied
>> up. Pushed out as testing for 0-day to see if it can find anything we missed
> 
> And indeed - I missed a bunch of places where explicit __be16 types should have
> been used.
> 
> I've applied the following fixup, shout if it's wrong.
>
Thank you Jonathan for applying this fixup. No need to shout :) Your 
changes should fix the issue.

However, I have a question about something else. The co2 concentration 
is an IIO_CHAN_INFO_RAW, but doesn't have a scale or offset at this 
moment. Is an _scale always required for an _raw in the ABI? I could not 
find anything in the documentation if there is a rule for this. Someone 
mentioned this to me, so I want to check if I did this right.

The sensor returns the actual co2 value upon reading, like 450 ppm. We 
can set an offset of this co2 value with the calibration_forced_value 
through the ABI, but this offset is handled internally by the sensor. So 
there isn't anything with scaling or an offset needed at the driver side.

Was I right by making it of type RAW? If needed we could make it more 
like the scd30 driver, keeping it of type RAW but with scale = 1. What 
should I do or is it fine as it is?

Sorry for not asking this earlier.

Thanks,

Roan

> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> index 09b34201c42b..ebebcb117ba2 100644
> --- a/drivers/iio/chemical/scd4x.c
> +++ b/drivers/iio/chemical/scd4x.c
> @@ -263,7 +263,7 @@ static int scd4x_write_and_fetch(struct scd4x_state *state, enum scd4x_cmd cmd,
>   static int scd4x_read_meas(struct scd4x_state *state, uint16_t *meas)
>   {
>   	int i, ret;
> -	uint16_t buf[3];
> +	__be16 buf[3];
>   
>   	ret = scd4x_read(state, CMD_READ_MEAS, buf, sizeof(buf));
>   	if (ret)
> @@ -282,12 +282,13 @@ static int scd4x_wait_meas_poll(struct scd4x_state *state)
>   	int ret;
>   
>   	do {
> +		__be16 bval;
>   		uint16_t val;
>   
> -		ret = scd4x_read(state, CMD_GET_DATA_READY, &val, sizeof(val));
> +		ret = scd4x_read(state, CMD_GET_DATA_READY, &bval, sizeof(bval));
>   		if (ret)
>   			return -EIO;
> -		val = be16_to_cpu(val);
> +		val = be16_to_cpu(bval);
>   
>   		/* new measurement available */
>   		if (val & 0x7FF)
> @@ -333,7 +334,7 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
>   {
>   	struct scd4x_state *state = iio_priv(indio_dev);
>   	int ret;
> -	uint16_t tmp;
> +	__be16 tmp;
>   
>   	switch (mask) {
>   	case IIO_CHAN_INFO_RAW:
> @@ -405,17 +406,18 @@ static ssize_t calibration_auto_enable_show(struct device *dev,
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>   	struct scd4x_state *state = iio_priv(indio_dev);
>   	int ret;
> -	uint16_t val;
> +	__be16 bval;
> +	u16 val;
>   
>   	mutex_lock(&state->lock);
> -	ret = scd4x_read(state, CMD_GET_ASC, &val, sizeof(val));
> +	ret = scd4x_read(state, CMD_GET_ASC, &bval, sizeof(bval));
>   	mutex_unlock(&state->lock);
>   	if (ret) {
>   		dev_err(dev, "failed to read automatic calibration");
>   		return ret;
>   	}
>   
> -	val = (be16_to_cpu(val) & SCD4X_READY_MASK) ? 1 : 0;
> +	val = (be16_to_cpu(bval) & SCD4X_READY_MASK) ? 1 : 0;
>   
>   	return sprintf(buf, "%d\n", val);
>   }
> 
> 
>>
>> Thanks,
>>
>> Jonathan
>>
>>>
>>> Changes since v5:
>>> scd4x.c:
>>>    - Fix bug in trigger_handler
>>>
>>> Changes since v4:
>>> scd4x.c:
>>>    - Minor fixes in documentation
>>>    - Reorder trigger_handler so memcpy is not needed anymore
>>> Documentation:
>>>    - Change information about the KernelVersion for the
>>>      calibration_forced_value_available
>>>
>>> Changes since v3:
>>> scd4x.c
>>>    - Change read and write_and_fetch function parameter. CRC byte is now
>>>      hidden inside the function.
>>>    - Fix minor style issues
>>>    - Add calibration_forced_value_available attribute to the driver
>>>    - Remove including BUFFER_TRIGGERED
>>>    - Change calibbias to raw ADC readings rather than converting it to
>>>      milli degrees C.
>>> Documentation:
>>>    - Change description of driver attributes
>>>    - Add calibration_forced_value_available documentation
>>>
>>> Changes since v2:
>>> scd4x.c:
>>>    - Change boolean operations
>>>    - Document scope of lock
>>>    - Remove device *dev from struct
>>>    - Add goto block for errror handling
>>>    - Add function to read value per channel in read_raw
>>>    - Fix bug with lock in error paths
>>>    - Remove conversion of humidity and temperature values
>>>    - Add scale and offset to temperature channel
>>>    - Add scale to humidity channel
>>>    - Move memset out of locked section
>>>    - Remove unused irq functions
>>>    - Move device register at end of probe function
>>> Documentation:
>>>    - Copy content of sysfs-bus-iio-scd30 to sysfs-bus-iio
>>>    - Remove Documentation/ABI/testing/sysfs-bus-iio-scd30
>>>
>>> Changes since v1:
>>> dt-bindings:
>>>    - Separated compatible string for each sensor type
>>> scd4x.c:
>>>    - Changed probe, resume and suspend functions to static
>>>    - Added SIMPLE_DEV_PM_OPS function call for power management
>>>      operations.
>>>
>>> Roan van Dijk (4):
>>>    dt-bindings: iio: chemical: sensirion,scd4x: Add yaml description
>>>    MAINTAINERS: Add myself as maintainer of the scd4x driver
>>>    drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor
>>>    iio: documentation: Document scd4x calibration use
>>>
>>>   Documentation/ABI/testing/sysfs-bus-iio       |  41 ++
>>>   Documentation/ABI/testing/sysfs-bus-iio-scd30 |  34 -
>>>   .../iio/chemical/sensirion,scd4x.yaml         |  46 ++
>>>   MAINTAINERS                                   |   6 +
>>>   drivers/iio/chemical/Kconfig                  |  13 +
>>>   drivers/iio/chemical/Makefile                 |   1 +
>>>   drivers/iio/chemical/scd4x.c                  | 689 ++++++++++++++++++
>>>   7 files changed, 796 insertions(+), 34 deletions(-)
>>>   delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-scd30
>>>   create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>>>   create mode 100644 drivers/iio/chemical/scd4x.c
>>>    
>>
> 
