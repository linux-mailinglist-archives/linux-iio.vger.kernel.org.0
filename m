Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABE22288A4
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 20:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgGUS4D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUSz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 14:55:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B97C0619DA;
        Tue, 21 Jul 2020 11:55:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 72so10654137ple.0;
        Tue, 21 Jul 2020 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jBFEbksikjQUkjnhOd+Swr75DALfr4QfxNrRV9ANfqs=;
        b=P9BGGPl6DI+JMtFXgdNO4o0hHvwFmJt70FkEXUh7gqzmsvjZHgdnoQkCaD6trv9+M+
         QyKVes8Q10JwpOHCiRvQtcFlnb5ag17sUPmZdLFB8N0paKZ/Mk5lUrr3afTkEMmjJISJ
         PA3YM76ZTu3ThrvSOSL7vpeVMfsEaFMP5VWr+i6OthtIJ8Dj7bflH0c3Tv9xSRtPSamO
         CipSgFh2XH1q2mx+ICMm5FBopQY6CV8xDdrz9PaxvUFCbM2djeaD7XAO2v4Ee8+18gkp
         jzlpK9MYrhavJON4LxkalZI4Rwe1ZkywyRxqE6FXXltjimJKsuaF/U8q7t6bdlpAP2xD
         cpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBFEbksikjQUkjnhOd+Swr75DALfr4QfxNrRV9ANfqs=;
        b=Qh/M6XGJaulU0xvu9JvJ8w9TsokXdcYJ2+boftIH6c39KgwdjMOtn7NHxYdusIHzqY
         q6oPPqhmtpyFmGACDkirOYwhsSwQapzbWwBpnbucLrjXTcJpLTMmu/xKiHVED8TsM6R5
         KO+v7QEctox/0jS8d3T4nWlKvpQ+PT0yICPhC3FJEYLaVua7RwljpDpcgqJwAy3Fht6i
         CT6OJnrdczfEa90MTUV5Dvo18duWyJJtlwMHZJc+iWFpm45KfZrnhdS4MLqn2hWr9znE
         62Led19mS7J4TzjExbtmjIlXLoQ+NXg1ke7UxuhOvQlosTDkgINQDhWJADiZW9JURJ1+
         aoZQ==
X-Gm-Message-State: AOAM530D9NynY8pn1+cCamrOa0KNYyh0zEZMTXzQAjQY4ddmGAHoB671
        Tb4YlWLI7Dcg0VJ+Ch3Ieq1x/8fxCWU=
X-Google-Smtp-Source: ABdhPJzFccfLZjMC1K7fqaLKVkUTyHs156QbhoYSpV6q5E8v/cL4in6aPnhIfqNkYk5is4oCVuKumg==
X-Received: by 2002:a17:90b:1650:: with SMTP id il16mr6011616pjb.79.1595357755750;
        Tue, 21 Jul 2020 11:55:55 -0700 (PDT)
Received: from ?IPv6:2409:4072:593:314e:d028:8959:a8a3:a7bc? ([2409:4072:593:314e:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id q24sm18042878pgg.3.2020.07.21.11.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 11:55:55 -0700 (PDT)
Subject: Re: [PATCH 1/2] iio: gyro: Add driver support for ADXRS290
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20200715092757.14563-1-nish.malpani25@gmail.com>
 <e369f36c-ec9e-0f90-674f-06c7d51d8b5e@gmail.com>
 <20200720121315.38500910@archlinux>
From:   Nishant Malpani <nish.malpani25@gmail.com>
Message-ID: <91b82340-832c-6e02-c595-613322926337@gmail.com>
Date:   Wed, 22 Jul 2020 00:25:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200720121315.38500910@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Thanks a lot for the detailed review. Comments inline...

On 20/07/20 4:43 pm, Jonathan Cameron wrote:
> On Wed, 15 Jul 2020 15:20:35 +0530
> Nishant Malpani <nish.malpani25@gmail.com> wrote:
> 
>> Hello,
>>
>> On 15/07/20 2:57 pm, Nishant Malpani wrote:
>>> ADXRS290 is a high performance MEMS pitch and roll (dual-axis in-plane)
>>> angular rate sensor (gyroscope) designed for use in stabilization
>>> applications. It also features an internal temperature sensor and
>>> programmable high-pass and low-pass filters.
>>>
>>> Add support for ADXRS290 in direct-access mode for now.
>>>
>>> Datasheet:
>>> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf
>>>
>>> Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
> Hi Nishant,
> 
> Mostly looks good. A few comments / questions inline.
> 
> I replied to your reply so I could answer the question you raised alongside
> the rest of the review.  Short answer, do precise matches as everything
> necessary is exposed to userspace or userspace to be clever if wants to be.
> 
> Thanks,
> 
> Jonathan
> 
>>> ---
>>>    MAINTAINERS                 |   6 +
>>>    drivers/iio/gyro/Kconfig    |  10 +
>>>    drivers/iio/gyro/Makefile   |   1 +
>>>    drivers/iio/gyro/adxrs290.c | 490 ++++++++++++++++++++++++++++++++++++
>>>    4 files changed, 507 insertions(+)
>>>    create mode 100644 drivers/iio/gyro/adxrs290.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e016ee39c74a..dd02cfc410e8 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1098,6 +1098,12 @@ L:	linux-media@vger.kernel.org
>>>    S:	Maintained
>>>    F:	drivers/media/i2c/adv7842*
>>>    
>>> +ANALOG DEVICES INC ADXRS290 DRIVER
>>> +M:	Nishant Malpani <nish.malpani25@gmail.com>
>>> +L:	linux-iio@vger.kernel.org
>>> +S:	Supported
>>> +F:	drivers/iio/gyro/adxrs290.c
>>> +
>>>    ANALOG DEVICES INC ASOC CODEC DRIVERS
>>>    M:	Lars-Peter Clausen <lars@metafoo.de>
>>>    M:	Nuno Sá <nuno.sa@analog.com>
>>> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
>>> index 6daeddf37f60..024a34139875 100644
>>> --- a/drivers/iio/gyro/Kconfig
>>> +++ b/drivers/iio/gyro/Kconfig
>>> @@ -41,6 +41,16 @@ config ADIS16260
>>>    	  This driver can also be built as a module.  If so, the module
>>>    	  will be called adis16260.
>>>    
>>> +config ADXRS290
>>> +	tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
>>> +	depends on SPI
>>> +	help
>>> +	  Say yes here to build support for Analog Devices ADXRS290 programmable
>>> +	  digital output gyroscope.
>>> +
>>> +	  This driver can also be built as a module. If so, the module will be
>>> +	  called adxrs290.
>>> +
>>>    config ADXRS450
>>>    	tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI driver"
>>>    	depends on SPI
>>> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
>>> index 45cbd5dc644e..0319b397dc3f 100644
>>> --- a/drivers/iio/gyro/Makefile
>>> +++ b/drivers/iio/gyro/Makefile
>>> @@ -8,6 +8,7 @@ obj-$(CONFIG_ADIS16080) += adis16080.o
>>>    obj-$(CONFIG_ADIS16130) += adis16130.o
>>>    obj-$(CONFIG_ADIS16136) += adis16136.o
>>>    obj-$(CONFIG_ADIS16260) += adis16260.o
>>> +obj-$(CONFIG_ADXRS290) += adxrs290.o
>>>    obj-$(CONFIG_ADXRS450) += adxrs450.o
>>>    obj-$(CONFIG_BMG160) += bmg160_core.o
>>>    obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
>>> diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
>>> new file mode 100644
>>> index 000000000000..1139f79a3bd5
>>> --- /dev/null
>>> +++ b/drivers/iio/gyro/adxrs290.c
>>> @@ -0,0 +1,490 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * ADXRS290 SPI Gyroscope Driver
>>> + *
>>> + * Copyright (C) 2020 Analog Devices, Inc.
> 
> Nishant, you are doing a gsoc I believe?
> 
Yes!

> If so I'd assume the copyright should be yours or joint with ADI rather
> than just ADI?
> 
I was skeptical about that initially but I guess it makes sense to add a 
joint COPYRIGHT tag; did so in v2.

>>> + */
>>> +
>>> +#include <asm/unaligned.h>
> 
> Convention is put 'generic headers' (e.g. the linux/ ones first)
> then arch specific (asm) stuff after.
> Not sure that's actually documented anywhere though!
> 
Right, haven't seen it documented anywhere. From what I learnt from the 
ML is that the usual convention is to order those lexicographically 
which is what I tried to do.

Although this header is not required anymore; see [1].
>>> +#include <linux/bitfield.h>
>>> +#include <linux/device.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/spi/spi.h>
>>> +
>>> +#include <linux/iio/iio.h>
>>> +#include <linux/iio/sysfs.h>
>>> +
>>> +#define ADXRS290_ADI_ID		0xAD
>>> +#define ADXRS290_MEMS_ID	0x1D
>>> +#define ADXRS290_DEV_ID		0x92
>>> +
>>> +#define ADXRS290_REG_ADI_ID	0x00 /* Analog Devices Identifier Register */
>>> +#define ADXRS290_REG_MEMS_ID	0x01 /* MEMS Identifier Register */
>>> +#define ADXRS290_REG_DEV_ID	0x02 /* Device Identifier Register */
>>> +#define ADXRS290_REG_REV_ID	0x03 /* Silicon Revision Number Register */
> 
> These first 4 are fairly obvious from the naming so I don't think the comments
> add much.
> 
Agreed. Removed in v2.

>>> +#define ADXRS290_REG_SN0	0x04 /* Serial Number Registers, 4 bytes */
>>> +#define ADXRS290_REG_DATAX0	0x08 /* Roll Rate o/p Data Regs, 2 bytes */
>>> +#define ADXRS290_REG_DATAY0	0x0A /* Pitch Rate o/p Data Regs, 2 bytes */
> 
> Are we actually right to map roll and pitch to x and y?
> If so we should probably add that to the docs somewhere.  We need to document
> which one maps to x and which to y as that mapping is far from obvious!
> 
"The ADXRS290 is an x-axis and y-axis rate sensing device that
is also called a roll and pitch rate sensing device" (datasheet pg. 4). 
I think I'm right in marking the DATA X-axis register as the roll rate 
and similarly the DATA Y-axis register as the pitch rate.

Also, I thought it is a known convention to use x for roll, y for pitch, 
etc. [2]. But you're right, its not very obvious. Where do I document it?

[2] https://en.wikipedia.org/wiki/Aircraft_principal_axes#Principal_axes

>>> +#define ADXRS290_REG_TEMP0	0x0C /* Temperature Data Registers, 2 bytes */
>>> +#define ADXRS290_REG_POWER_CTL	0x10 /* Power Control Register */
>>> +#define ADXRS290_REG_FILTER	0x11 /* Band-pass Filter Register */
>>> +#define ADXRS290_REG_DATA_RDY	0x12 /* Data Ready Register */
> 
> Most of these comments also don't tell us anything the naming doesn't.
> Always keep in mind that comments may become incorrect due to future changes,
> hence just use them when the comment adds significant value in of itself.
> 
Yes, makes sense. Removed in v2.

>>> +
>>> +#define ADXRS290_READ		BIT(7)
>>> +#define ADXRS290_TSM		BIT(0)
>>> +#define ADXRS290_MEASUREMENT	BIT(1)
>>> +#define ADXRS290_SYNC		GENMASK(1, 0)
>>> +#define ADXRS290_LPF_MASK	GENMASK(2, 0)
>>> +#define ADXRS290_LPF(x)		FIELD_PREP(ADXRS290_LPF_MASK, x)
>>> +#define ADXRS290_HPF_MASK	GENMASK(7, 4)
>>> +#define ADXRS290_HPF(x)		FIELD_PREP(ADXRS290_HPF_MASK, x)
>>> +
>>> +#define ADXRS290_READ_REG(reg)	(ADXRS290_READ | (reg))
>>> +
>>> +#define ADXRS290_MAX_TRANSITION_TIME_MS 100
>>> +
>>> +enum adxrs290_mode {
>>> +	STANDBY,
>>> +	MEASUREMENT,
>>> +};
>>> +
>>> +struct adxrs290_state {
>>> +	struct spi_device	*spi;
>>> +	/* To atomize successive reads for single measurement */
> 
> Comment doesn't seem to be accurate.  Key point is you are
> protecting the  buffers by serializing the read and processing of
> the read.
> 
You're right. I'm not sure what I was thinking when I wrote this; sorry 
about that. Rephrased it in v2.

>>> +	struct mutex		lock;
>>> +	enum adxrs290_mode	mode;
>>> +	unsigned int		lpf_3db_freq_idx;
>>> +	unsigned int		hpf_3db_freq_idx;
>>> +	union {
>>> +		u8 tx;
>>> +		u8 rx[2];
> 
> I would not bother with a union here. It will save little
> space and make readers have to think about whether it is safe.
> Mark the tx as aligned and the following rx will be in the same
> cacheline which should be safe.
> 
Okay. Although these local tx, rx buffers are not required anymore in 
v2; see [1].

>>> +	}			data ____cacheline_aligned;
>>> +};
>>> +
>>> +/*
>>> + * Available cut-off frequencies of the low pass filter in Hz.
>>> + * The integer part and fractional part are represented separately.
>>> + */
>>> +static const unsigned int adxrs290_lpf_3db_freq_tbl[][2] = {
>>> +	[0] = {480, 0},
>>> +	[1] = {320, 0},
>>> +	[2] = {160, 0},
>>> +	[3] = {80, 0},
>>> +	[4] = {56, 600},
>>> +	[5] = {40, 0},
>>> +	[6] = {28, 300},
>>> +	[7] = {20, 0},
>>> +};
>>> +
>>> +/*
>>> + * Available cut-off frequencies of the high pass filter in Hz.
>>> + * The integer part and fractional part are represented separately.
>>> + */
>>> +static const unsigned int adxrs290_hpf_3db_freq_tbl[][2] = {
>>> +	[0] = {0, 0},
>>> +	[1] = {0, 11},
>>> +	[2] = {0, 22},
>>> +	[3] = {0, 44},
>>> +	[4] = {0, 87},
>>> +	[5] = {0, 175},
>>> +	[6] = {0, 350},
>>> +	[7] = {0, 700},
>>> +	[8] = {1, 400},
>>> +	[9] = {2, 800},
>>> +	[10] = {11, 300},
>>> +};
>>> +
>>> +static int adxrs290_spi_read16b(struct iio_dev *indio_dev, const u8 cmd,
>>> +				u16 *val)
>>> +{
>>> +	struct adxrs290_state *st = iio_priv(indio_dev);
>>> +	int ret = 0;
> 
> No reason to init this.
> 
Yes, thanks for pointing. Fixed in v2.

>>> +
>>> +	struct spi_transfer t[] = {
>>> +		{
>>> +			.tx_buf = &st->data.tx,
>>> +			.bits_per_word = 8,
>>> +			.len = sizeof(st->data.tx),
>>> +			.cs_change = 0,
> 
> 
> How is this different from spi_w8r16?
> 
> If it is, then a comment to explain that would be great as it's not immediately
> obvious!
> 
Ah, the evolution of this function made it semantically the same as 
spi_w8r16. Previously, the idea was to support 16b reads in both STANDBY 
and MEASUREMENT mode. Although, "in STANDBY mode, only single register 
transactions are supported" (datasheet pg. 14). So, the CS had to be 
toggled in between two (since *16b* read from 2 8b registers) 
transactions *only* in STANDBY mode & in the MEASUREMENT mode we could 
do what spi_w8r16() essentially does; we had a conditional to handle the 
state. But we later realized the rate data access is not supported by 
adxrs290 in the STANDBY mode, ergo the need for handling 16b reads in 
STANDBY mode was proved to be unwanted. So, the function simply dumbed 
down to what spi_w8r16() does.

[1] Anyways, you're right; it is similar to spi_w8r16(), so utilized it 
in v2. This also marks the use of <asm/unaligned.h> & tx, rx buffers as 
unnecessary.

>>> +		}, {
>>> +			.rx_buf = &st->data.rx,
>>> +			.bits_per_word = 8,
>>> +			.len = sizeof(st->data.rx),
>>> +		},
>>> +	};
>>> +
>>> +	mutex_lock(&st->lock);
>>> +
>>> +	st->data.tx = cmd;
>>> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
>>> +
>>> +	if (ret < 0) {
>>> +		dev_err(&st->spi->dev, "error reading 16b from reg 0x%02x\n",
>>> +			cmd);
>>> +		goto err_unlock;
>>> +	}
>>> +
>>> +	*val = get_unaligned_le16(st->data.rx);
>>> +
>>> +err_unlock:
>>> +	mutex_unlock(&st->lock);
>>> +	return ret;
>>> +}
>>> +
>>> +static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd,
>>> +				  unsigned int *val)
>>> +{
>>> +	int ret;
>>> +	u16 temp;
>>> +
>>> +	ret = adxrs290_spi_read16b(indio_dev, cmd, &temp);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	*val = temp;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int adxrs290_get_temp_data(struct iio_dev *indio_dev, unsigned int *val)
>>> +{
>>> +	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
>>> +	int ret;
>>> +	u16 temp;
>>> +
>>> +	ret = adxrs290_spi_read16b(indio_dev, cmd, &temp);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	/* extract lower 12 bits temperature reading */
>>> +	*val = temp & 0x0FFF;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u8 *val2)
>>> +{
>>> +	struct adxrs290_state *st = iio_priv(indio_dev);
>>> +	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_FILTER);
>>> +	int temp;
>>> +
>>> +	temp = spi_w8r8(st->spi, cmd);
>>> +	if (temp < 0)
>>> +		return temp;
>>> +
>>> +	*val = FIELD_GET(ADXRS290_LPF_MASK, temp);
>>> +	*val2 = FIELD_GET(ADXRS290_HPF_MASK, temp);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
>>> +				  const u8 val)
>>> +{
>>> +	u8 buf[2];
>>> +
>>> +	buf[0] = reg;
>>> +	buf[1] = val;
>>> +
>>> +	return spi_write(spi, buf, ARRAY_SIZE(buf));
> 
> spi_write requires a dma safe buffer.  Such a buffer needs to be in its
> own cacheline.  Given trivial nature of what you have here, easiest
> may be to use spi_write_then_read with the read length set to 0.
> That function uses local bounce buffers to ensure the dma requirements
> are met.
> 
Thanks for the explanation. Fixed in v2.

>>> +}
>>> +
>>> +static unsigned int adxrs290_find_best_match(const unsigned int (*freq_tbl)[2],
>>> +					     unsigned int n, unsigned int freq)
>>> +{
>>> +	unsigned int i, best_freq_idx;
>>> +	unsigned int diff, best_diff;
>>> +
>>> +	best_freq_idx = 0;
>>> +	best_diff = UINT_MAX;
>>> +	for (i = 0; i < n; i++) {
>>> +		diff = abs(freq_tbl[i][0] - freq);
>>
>> To find the "closest" 3db frequency from the acceptable ones, for now, I
>> simply consider the integer part of the frequency (freq_tbl[i][0]).
>> Taking into account the sensitivity of acceptable 3db frequencies for
>> the high-pass filter [1], I'm guessing this isn't an acceptable
>> solution. Should I progressively compare the fractional part after the
>> integer part or perhaps directly exercise a FP arithmetic? Any other
>> suggestions? Thanks in advance.
>>
>> [1] Supported 3db frequencies of the high-pass filter:
>> 0.000 0.011 0.022 0.044 0.087 0.175 0.350 0.700 1.400 2.800 11.300
> 
> Given the driver is exporting the 'precise' values in the available
> attribute, I would suggest just doing a precise match against both parts.
> Leave any rounding complexity to userspace.
> 
I agree. Manifested the above in v2.

>>
>> With regards,
>> Nishant Malpani
>>
>>> +		if (diff < best_diff) {
>>> +			best_diff = diff;
>>> +			best_freq_idx = i;
>>> +		}
>>> +	}
>>> +
>>> +	return best_freq_idx;
>>> +}
>>> +
>>> +static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
>>> +				    unsigned int lpf_idx, unsigned int hpf_idx)
>>> +{
>>> +	struct adxrs290_state *st = iio_priv(indio_dev);
>>> +	u8 val;
>>> +
>>> +	val = ADXRS290_HPF(hpf_idx) | ADXRS290_LPF(lpf_idx);
>>> +
>>> +	return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
>>> +}
>>> +
>>> +static ssize_t adxrs290_show_avail(const unsigned int (*freq_tbl)[2], size_t n,
>>> +				   char *buf)
>>> +{
>>> +	ssize_t len = 0;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < n; i++) {
>>> +		len += scnprintf(buf + len, PAGE_SIZE - len,
>>> +				 "%u.%03u ", freq_tbl[i][0], freq_tbl[i][1]);
>>> +	}
>>> +	buf[len - 1] = '\n';
>>> +
>>> +	return len;
>>> +}
>>> +
>>> +static ssize_t adxrs290_show_lpf_freq_avail(struct device *dev,
>>> +					    struct device_attribute *attr,
>>> +					    char *buf)
>>> +{
>>> +	return adxrs290_show_avail(adxrs290_lpf_3db_freq_tbl,
>>> +				   ARRAY_SIZE(adxrs290_lpf_3db_freq_tbl), buf);
>>> +}
>>> +
>>> +static ssize_t adxrs290_show_hpf_freq_avail(struct device *dev,
>>> +					    struct device_attribute *attr,
>>> +					    char *buf)
>>> +{
>>> +	return adxrs290_show_avail(adxrs290_hpf_3db_freq_tbl,
>>> +				   ARRAY_SIZE(adxrs290_hpf_3db_freq_tbl), buf);
>>> +}
>>> +
>>> +/* attribute to display available 3db frequencies for the low-pass filter */
>>> +static IIO_DEVICE_ATTR(in_anglvel_filter_low_pass_3db_frequency_available,
>>> +		       0444, adxrs290_show_lpf_freq_avail, NULL, 0);
>>> +
>>> +/* attribute to display available 3db frequencies for the high-pass filter */
>>> +static IIO_DEVICE_ATTR(in_anglvel_filter_high_pass_3db_frequency_available,
>>> +		       0444, adxrs290_show_hpf_freq_avail, NULL, 0);
>>> +
>>> +static struct attribute *adxrs290_attributes[] = {
>>> +	&iio_dev_attr_in_anglvel_filter_low_pass_3db_frequency_available.dev_attr.attr,
>>> +	&iio_dev_attr_in_anglvel_filter_high_pass_3db_frequency_available.dev_attr.attr,
>>> +	NULL,
>>> +};
> 
> Perhaps change these over to the read_avail core callbacks. The tables
> are almost in the right form already so it may end up less complex.
> 
I wasn't aware of the core's support to read available values as a 
read_avail() callback. Thanks for the tip; utilized it in v2.

>>> +
>>> +static const struct attribute_group adxrs290_attrs_group = {
>>> +	.attrs = adxrs290_attributes,
>>> +};
>>> +
>>> +static int adxrs290_initial_setup(struct iio_dev *indio_dev)
>>> +{
>>> +	struct adxrs290_state *st = iio_priv(indio_dev);
>>> +
>>> +	st->mode = MEASUREMENT;
>>> +
>>> +	return adxrs290_spi_write_reg(st->spi,
>>> +				      ADXRS290_REG_POWER_CTL,
>>> +				      ADXRS290_MEASUREMENT | ADXRS290_TSM);
>>> +}
>>> +
>>> +static int adxrs290_read_raw(struct iio_dev *indio_dev,
>>> +			     struct iio_chan_spec const *chan,
>>> +			     int *val,
>>> +			     int *val2,
>>> +			     long mask)
>>> +{
>>> +	struct adxrs290_state *st = iio_priv(indio_dev);
>>> +	int ret;
>>> +	unsigned int t;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_RAW:
>>> +		switch (chan->type) {
>>> +		case IIO_ANGL_VEL:
>>> +			ret = adxrs290_get_rate_data(indio_dev,
>>> +						     ADXRS290_READ_REG(chan->address),
>>> +						     &t);
>>> +			if (ret < 0)
>>> +				return ret;
>>> +			*val = t;
>>> +			return IIO_VAL_INT;
>>> +		case IIO_TEMP:
>>> +			ret = adxrs290_get_temp_data(indio_dev, &t);
>>> +			if (ret < 0)
>>> +				return ret;
>>> +			*val = t;
>>> +			return IIO_VAL_INT;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		switch (chan->type) {
>>> +		case IIO_ANGL_VEL:
>>> +			*val = 0;
>>> +			*val2 = 87266;
>>> +			return IIO_VAL_INT_PLUS_NANO;
>>> +		case IIO_TEMP:
>>> +			*val = 100;
>>> +			return IIO_VAL_INT;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>> +		switch (chan->type) {
>>> +		case IIO_ANGL_VEL:
>>> +			t = st->lpf_3db_freq_idx;
>>> +			*val = adxrs290_lpf_3db_freq_tbl[t][0];
>>> +			*val2 = adxrs290_lpf_3db_freq_tbl[t][1] * 1000;
> 
> Given we are writing integers and it doesn't otherwise mater, I'd make
> the table int and also just add the zeros to avoid the need to do *1000
> here.  That will also let you use the core support for avail.
> 
Makes sense. Acked in v2.

> 
>>> +			return IIO_VAL_INT_PLUS_MICRO;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>>> +		switch (chan->type) {
>>> +		case IIO_ANGL_VEL:
>>> +			t = st->hpf_3db_freq_idx;
>>> +			*val = adxrs290_hpf_3db_freq_tbl[t][0];
>>> +			*val2 = adxrs290_hpf_3db_freq_tbl[t][1] * 1000;
>>> +			return IIO_VAL_INT_PLUS_MICRO;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +static int adxrs290_write_raw(struct iio_dev *indio_dev,
>>> +			      struct iio_chan_spec const *chan,
>>> +			      int val,
>>> +			      int val2,
>>> +			      long mask)
>>> +{
>>> +	struct adxrs290_state *st = iio_priv(indio_dev);
>>> +	unsigned int lpf_idx, hpf_idx;
>>> +
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>>> +		lpf_idx = adxrs290_find_best_match(adxrs290_lpf_3db_freq_tbl,
>>> +						   ARRAY_SIZE(adxrs290_lpf_3db_freq_tbl),
>>> +						   val);
>>> +		/* caching the updated state of the low-pass filter */
>>> +		st->lpf_3db_freq_idx = lpf_idx;
>>> +		/* retrieving the current state of the high-pass filter */
>>> +		hpf_idx = st->hpf_3db_freq_idx;
>>> +		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
>>> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>>> +		hpf_idx = adxrs290_find_best_match(adxrs290_hpf_3db_freq_tbl,
>>> +						   ARRAY_SIZE(adxrs290_hpf_3db_freq_tbl),
>>> +						   val);
>>> +		/* caching the updated state of the high-pass filter */
>>> +		st->hpf_3db_freq_idx = hpf_idx;
>>> +		/* retrieving the current state of the low-pass filter */
>>> +		lpf_idx = st->lpf_3db_freq_idx;
>>> +		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
>>> +	}
>>> +
>>> +	return -EINVAL;
>>> +}
>>> +
>>> +#define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {				\
>>> +	.type = IIO_ANGL_VEL,						\
>>> +	.address = reg,							\
>>> +	.modified = 1,							\
>>> +	.channel2 = IIO_MOD_##axis,					\
>>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
>>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
>>> +	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |		\
>>> +	BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),		\
>>> +}
>>> +
>>> +static const struct iio_chan_spec adxrs290_channels[] = {
>>> +	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAX0, X),
>>> +	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAY0, Y),
>>> +	{
>>> +		.type = IIO_TEMP,
>>> +		.address = ADXRS290_REG_TEMP0,
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>>> +		BIT(IIO_CHAN_INFO_SCALE),
>>> +	},
>>> +};
>>> +
>>> +static const struct iio_info adxrs290_info = {
>>> +	.attrs = &adxrs290_attrs_group,
>>> +	.read_raw = &adxrs290_read_raw,
>>> +	.write_raw = &adxrs290_write_raw,
>>> +};
>>> +
>>> +static int adxrs290_probe(struct spi_device *spi)
>>> +{
>>> +	struct iio_dev *indio_dev;
>>> +	struct adxrs290_state *st;
>>> +	int ret;
>>> +	u8 val, val2;
>>> +
>>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>>> +	if (!indio_dev)
>>> +		return -ENOMEM;
>>> +
>>> +	st = iio_priv(indio_dev);
>>> +	st->spi = spi;
>>> +	spi_set_drvdata(spi, indio_dev);
>>> +
>>> +	indio_dev->dev.parent = &spi->dev;
>>> +	indio_dev->name = "adxrs290";
>>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>>> +	indio_dev->channels = adxrs290_channels;
>>> +	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
>>> +	indio_dev->info = &adxrs290_info;
>>> +
>>> +	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
>>> +	if (val != ADXRS290_ADI_ID) {
>>> +		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
>>> +	if (val != ADXRS290_MEMS_ID) {
>>> +		dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", val);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
>>> +	if (val != ADXRS290_DEV_ID) {
>>> +		dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", val);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	/* default mode the gyroscope starts in */
>>> +	st->mode = STANDBY;
>>> +
>>> +	/* switch to measurement mode and switch on the temperature sensor */
>>> +	ret = adxrs290_initial_setup(indio_dev);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	/* max transition time to measurement mode */
>>> +	msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
>>> +
>>> +	ret = adxrs290_get_3db_freq(indio_dev, &val, &val2);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	st->lpf_3db_freq_idx = val;
>>> +	st->hpf_3db_freq_idx = val2;
>>> +
>>> +	return devm_iio_device_register(&spi->dev, indio_dev);
>>> +}
>>> +
>>> +static const struct of_device_id adxrs290_of_match[] = {
>>> +	{ .compatible = "adi,adxrs290" },
>>> +	{ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, adxrs290_of_match);
>>> +
>>> +static struct spi_driver adxrs290_driver = {
>>> +	.driver = {
>>> +		.name = "adxrs290",
>>> +		.of_match_table = adxrs290_of_match,
>>> +	},
>>> +	.probe = adxrs290_probe,
>>> +};
>>> +module_spi_driver(adxrs290_driver);
>>> +
>>> +MODULE_AUTHOR("Nishant Malpani <nish.malpani25@gmail.com>");
>>> +MODULE_DESCRIPTION("Analog Devices ADXRS290 Gyroscope SPI driver");
>>> +MODULE_LICENSE("GPL");
>>>    
> 
