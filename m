Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0E3F4C09
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhHWOBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 10:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHWOBs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 10:01:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F6C061575;
        Mon, 23 Aug 2021 07:01:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g135so1333440wme.5;
        Mon, 23 Aug 2021 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=R2tGo6xrsUEGsj3AANFN2+L5m1TjFUyMBKH4cijJ6zc=;
        b=mbARdz2rNesjZpGoJsow5fEuRAeKoON52ZsVrMoogpkHhIgCdaEIuQH7TWNqGDw58R
         +wW/TXKWYV7lE4yY9dZkFPMIJJEhTX3mRTzLb702ysa4rlVZebJB5od2YbpAjehUnGWA
         8WBwOllyrq+w/uxblpe6I65G1mnBgkc5BkCQ075lF64KLfQHzTE+59H7Dx7EkeyJG/cZ
         HLakKvnB/tmA/GBNw6KRK1DAKQ6mm3zhfTcFFe/BCOsKxl0csvimvnRhkP31ASwj05sQ
         xyDrPfJ5nVMuiGmuU1JAB17p8BotK0gBQTDuKxYrXIxvpdXqEIPgdl9a3bvzBb2D3T+N
         Abiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=R2tGo6xrsUEGsj3AANFN2+L5m1TjFUyMBKH4cijJ6zc=;
        b=rPN1BCkn/J02/m1suUnS4o2I6NPOUjsgRhYdvKqsyi8d4D5q+fUFSuvZ2zx9sOJlD3
         dQaUicfEnDBv3wOjMBExHJk5pFsRBdH+cmYvKDDudr4W+j6TmzVhkyDFcAh+J/GERy2F
         9vrh0pVxBv57FVODhiNkp1oCnrB9hpPRYVUM/Po8Zd/KhomdOEnvJLfpuXjxQ7mbLJDD
         ANJV4wt1PGIu4COTlsoLrpHGtBFgvc95J9j7NnZ9ZHykeLDTMUJAuXzKE342tXfvdpFV
         uvy5d1kVXrI+bKksmDbWXph/qJyTOtCHfPQW1k0vvgKDA++IYLoSEnPm/b3QKK3XHwbl
         cM9g==
X-Gm-Message-State: AOAM533ikR4WcnqIGvJPepf/P8coAsurHqmwiDWqSZg7/DWQLz1d6JVh
        RCn8mdVdf+CUflH+WipCgQA=
X-Google-Smtp-Source: ABdhPJxGJllyvVvrRQMppaCxBAgOoKAVhXsrTgk+nvYqQ6YsSjDbcor7UFfUOlY4DU4TW+VAvILEcA==
X-Received: by 2002:a05:600c:2e4a:: with SMTP id q10mr5348057wmf.189.1629727263716;
        Mon, 23 Aug 2021 07:01:03 -0700 (PDT)
Received: from nunojsa-N551JK ([2001:a61:2531:cb01:1061:e4b5:709f:d9ad])
        by smtp.googlemail.com with ESMTPSA id l7sm13273830wmj.9.2021.08.23.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 07:01:03 -0700 (PDT)
Message-ID: <ae52f65e92a490cb8580a1a92c33cd947dc204a6.camel@gmail.com>
Subject: Re: [PATCH v4 6/6] drivers:iio:dac: Add AD3552R driver support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Mihail Chindris <mihail.chindris@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        nuno.sa@analog.com,
        "dragos.bogdan@analog.com" <dragos.bogdan@analog.com>
Date:   Mon, 23 Aug 2021 16:01:02 +0200
In-Reply-To: <20210820165927.4524-7-mihail.chindris@analog.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
         <20210820165927.4524-7-mihail.chindris@analog.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-08-20 at 16:59 +0000, Mihail Chindris wrote:
> The AD3552R-16 is a low drift ultrafast, 16-bit accuracy,
> current output digital-to-analog converter (DAC) designed
> to generate multiple output voltage span ranges.
> The AD3552R-16 operates with a fixed 2.5V reference.
> 
> analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  drivers/iio/dac/Kconfig   |   10 +
>  drivers/iio/dac/Makefile  |    1 +
>  drivers/iio/dac/ad3552r.c | 1419
> +++++++++++++++++++++++++++++++++++++
>  3 files changed, 1430 insertions(+)
>  create mode 100644 drivers/iio/dac/ad3552r.c
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 75e1f2b48638..ced6428f2c92 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -6,6 +6,16 @@
>  
>  menu "Digital to analog converters"
>  
> +config AD3552R
> +	tristate "Analog Devices AD3552R DAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD3552R
> +	  Digital to Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad3552r.
> +
>  config AD5064
>  	tristate "Analog Devices AD5064 and similar multi-channel DAC
> driver"
>  	depends on (SPI_MASTER && I2C!=m) || I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 33e16f14902a..dffe36efd8ff 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_AD3552R) += ad3552r.o
>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o
>  obj-$(CONFIG_AD5421) += ad5421.o
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> new file mode 100644
> index 000000000000..89993dd87522
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -0,0 +1,1419 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Analog Devices AD3552R
> + * Digital to Analog converter driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +#include <linux/iopoll.h>
> +#include <linux/device.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/time64.h>
> +#include <linux/unaligned/be_byteshift.h>
> +
> +/* Register addresses */
> +/* Primary address space */
> +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_A		0x00
> +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_B		0x01
> +#define AD3552R_REG_ADDR_DEVICE_CONFIG			0x02
> +#define AD3552R_REG_ADDR_CHIP_TYPE			0x03
> +#define AD3552R_REG_ADDR_PRODUCT_ID_L			0x04
> +#define AD3552R_REG_ADDR_PRODUCT_ID_H			0x05
> +#define AD3552R_REG_ADDR_CHIP_GRADE			0x06
> +#define AD3552R_REG_ADDR_SCRATCH_PAD			0x0A
> +#define AD3552R_REG_ADDR_SPI_REVISION			0x0B
> +#define AD3552R_REG_ADDR_VENDOR_L			0x0C
> +#define AD3552R_REG_ADDR_VENDOR_H			0x0D
> +#define AD3552R_REG_ADDR_STREAM_MODE			0x0E
> +#define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
> +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
> +#define AD3552R_REG_ADDR_INTERFACE_STATUS_A		0x11
> +#define AD3552R_REG_ADDR_INTERFACE_CONFIG_D		0x14
> +#define AD3552R_REG_ADDR_SH_REFERENCE_CONFIG		0x15
> +#define AD3552R_REG_ADDR_ERR_ALARM_MASK			0x16
> +#define AD3552R_REG_ADDR_ERR_STATUS			0x17
> +#define AD3552R_REG_ADDR_POWERDOWN_CONFIG		0x18
> +#define AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE		0x19
> +#define AD3552R_REG_ADDR_CH_OFFSET(ch)			(0x1B +
> (ch) * 2)
> +#define AD3552R_REG_ADDR_CH_GAIN(ch)			(0x1C + (ch) *
> 2)
> +/*
> + * Secondary region
> + * For multibyte registers specify the highest address because the
> access is
> + * done in descending order
> + */
> +#define AD3552R_SECONDARY_REGION_START			0x28
> +#define AD3552R_REG_ADDR_HW_LDAC_16B			0x28
> +#define AD3552R_REG_ADDR_CH_DAC_16B(ch)			(0x2C -
> (1 - ch) * 2)
> +#define AD3552R_REG_ADDR_DAC_PAGE_MASK_16B		0x2E
> +#define AD3552R_REG_ADDR_CH_SELECT_16B			0x2F
> +#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_16B		0x31
> +#define AD3552R_REG_ADDR_SW_LDAC_16B			0x32
> +#define AD3552R_REG_ADDR_CH_INPUT_16B(ch)		(0x36 - (1 -
> ch) * 2)
> +/* 3 bytes registers */
> +#define AD3552R_REG_START_24B				0x37
> +#define AD3552R_REG_ADDR_HW_LDAC_24B			0x37
> +#define AD3552R_REG_ADDR_CH_DAC_24B(ch)			(0x3D -
> (1 - ch) * 3)
> +#define AD3552R_REG_ADDR_DAC_PAGE_MASK_24B		0x40
> +#define AD3552R_REG_ADDR_CH_SELECT_24B			0x41
> +#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B		0x44
> +#define AD3552R_REG_ADDR_SW_LDAC_24B			0x45
> +#define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 -
> ch) * 3)
> +
> +#define AD3552R_REG_ADDR_MAX				0x4B
> +
> +/* AD3552R_REG_ADDR_INTERFACE_CONFIG_A */
> +#define AD3552R_MASK_SOFTWARE_RESET			(BIT(7) |
> BIT(0))
> +#define AD3552R_MASK_ADDR_ASCENSION			BIT(5)
> +#define AD3552R_MASK_SDO_ACTIVE				BIT(4)
> +/* AD3552R_REG_ADDR_INTERFACE_CONFIG_B */
> +#define AD3552R_MASK_SINGLE_INST			BIT(7)
> +#define AD3552R_MASK_SHORT_INSTRUCTION			BIT(3)
> +/* AD3552R_REG_ADDR_DEVICE_CONFIG */
> +#define AD3552R_MASK_DEVICE_STATUS(n)			BIT(4 +
> (n))
> +#define AD3552R_MASK_CUSTOM_MODES			(BIT(3) |
> BIT(2))
> +#define AD3552R_MASK_OPERATING_MODES			(BIT(1) |
> BIT(0))
> +/* AD3552R_REG_ADDR_CHIP_TYPE */
> +#define AD3552R_MASK_CLASS				0x0F
> +/* AD3552R_REG_ADDR_CHIP_GRADE */
> +#define AD3552R_MASK_GRADE				0xF0
> +#define AD3552R_MASK_DEVICE_REVISION			0x0F
> +/* AD3552R_REG_ADDR_STREAM_MODE */
> +#define AD3552R_MASK_LENGTH				0x0F
> +/* AD3552R_REG_ADDR_TRANSFER_REGISTER */
> +#define AD3552R_MASK_MULTI_IO_MODE			(BIT(7) |
> BIT(6))
> +#define AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
> +/* AD3552R_REG_ADDR_INTERFACE_CONFIG_C */
> +#define AD3552R_MASK_CRC_ENABLE				(BIT(7)
> | BIT(6) |\
> +							 BIT(1) |
> BIT(0))
> +#define AD3552R_MASK_STRICT_REGISTER_ACCESS		BIT(5)
> +/* AD3552R_REG_ADDR_INTERFACE_STATUS_A */
> +#define AD3552R_MASK_INTERFACE_NOT_READY		BIT(7)
> +#define AD3552R_MASK_CLOCK_COUNTING_ERROR		BIT(5)
> +#define AD3552R_MASK_INVALID_OR_NO_CRC			BIT(3)
> +#define AD3552R_MASK_WRITE_TO_READ_ONLY_REGISTER	BIT(2)
> +#define AD3552R_MASK_PARTIAL_REGISTER_ACCESS		BIT(1)
> +#define AD3552R_MASK_REGISTER_ADDRESS_INVALID		BIT(0)
> +/* AD3552R_REG_ADDR_INTERFACE_CONFIG_D */
> +#define AD3552R_MASK_ALERT_ENABLE_PULLUP		BIT(6)
> +#define AD3552R_MASK_MEM_CRC_EN				BIT(4)
> +#define AD3552R_MASK_SDO_DRIVE_STRENGTH			(BIT(3)
> | BIT(2))
> +#define AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN		BIT(1)
> +#define AD3552R_MASK_SPI_CONFIG_DDR			BIT(0)
> +/* AD3552R_REG_ADDR_SH_REFERENCE_CONFIG */
> +#define AD3552R_MASK_IDUMP_FAST_MODE			BIT(6)
> +#define AD3552R_MASK_SAMPLE_HOLD_DIFFERENTIAL_USER_EN	BIT(5)
> +#define AD3552R_MASK_SAMPLE_HOLD_USER_TRIM		(BIT(4) |
> BIT(3))
> +#define AD3552R_MASK_SAMPLE_HOLD_USER_ENABLE		BIT(2)
> +#define AD3552R_MASK_REFERENCE_VOLTAGE_SEL		(BIT(1) |
> BIT(0))
> +/* AD3552R_REG_ADDR_ERR_ALARM_MASK */
> +#define AD3552R_MASK_REF_RANGE_ALARM			BIT(6)
> +#define AD3552R_MASK_CLOCK_COUNT_ERR_ALARM		BIT(5)
> +#define AD3552R_MASK_MEM_CRC_ERR_ALARM			BIT(4)
> +#define AD3552R_MASK_SPI_CRC_ERR_ALARM			BIT(3)
> +#define AD3552R_MASK_WRITE_TO_READ_ONLY_ALARM		BIT(2)
> +#define AD3552R_MASK_PARTIAL_REGISTER_ACCESS_ALARM	BIT(1)
> +#define AD3552R_MASK_REGISTER_ADDRESS_INVALID_ALARM	BIT(0)
> +/* AD3552R_REG_ADDR_ERR_STATUS */
> +#define AD3552R_MASK_REF_RANGE_ERR_STATUS			BIT(6)
> +#define AD3552R_MASK_DUAL_SPI_STREAM_EXCEEDS_DAC_ERR_STATUS	BIT(5)
> +#define AD3552R_MASK_MEM_CRC_ERR_STATUS				
> BIT(4)
> +#define AD3552R_MASK_RESET_STATUS				BIT(0)
> +/* AD3552R_REG_ADDR_POWERDOWN_CONFIG */
> +#define AD3552R_MASK_CH_DAC_POWERDOWN(ch)		BIT(4 + (ch))
> +#define AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch)		BIT(ch)
> +/* AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE */
> +#define AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch)		((ch) ? 0xF0 :
> 0x0F)
> +/* AD3552R_REG_ADDR_CH_GAIN */
> +#define AD3552R_MASK_CH_RANGE_OVERRIDE			BIT(7)
> +#define AD3552R_MASK_CH_GAIN_SCALING_N			(BIT(6)
> | BIT(5))
> +#define AD3552R_MASK_CH_GAIN_SCALING_P			(BIT(4)
> | BIT(3))
> +#define AD3552R_MASK_CH_OFFSET_POLARITY			BIT(2)
> +#define AD3552R_MASK_CH_OFFSET_BIT_8			BIT(0)
> +/* AD3552R_REG_ADDR_CH_OFFSET */
> +#define AD3552R_MASK_CH_OFFSET_BITS_0_7			0xFF
> +
> +/* Useful defines */
> +#define AD3552R_NUM_CH					2
> +#define AD3552R_MASK_CH(ch)				BIT(ch)
> +#define AD3552R_PAGE_CH					2
> +#define AD3552R_MAX_REG_SIZE				3
> +#define AD3552R_READ_BIT				(1 << 7)
> +#define AD3552R_ADDR_MASK				(~AD3552R_READ_
> BIT)
> +#define AD3552R_CRC_ENABLE_VALUE			(BIT(6) |
> BIT(1))
> +#define AD3552R_CRC_DISABLE_VALUE			(BIT(1) |
> BIT(0))
> +#define AD3552R_CRC_POLY				0x07
> +#define AD3552R_CRC_SEED				0xA5
> +#define AD3552R_MASK_DAC_12B				0xFFF0
> +#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
> +#define SCRATCH_PAD_TEST_VAL1				0x34
> +#define SCRATCH_PAD_TEST_VAL2				0xB2
> +#define TO_MICROS					1000000
> +#define GAIN_SCALE					1000
> +#define AD3552R_READ					true
> +#define AD3552R_WRITE					false
> +#define LDAC_PULSE_US					10
> +
> +enum ad3552r_ch_output_range {
> +	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
> +	AD3552R_CH_OUTPUT_RANGE_0__2_5V,
> +	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
> +	AD3552R_CH_OUTPUT_RANGE_0__5V,
> +	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
> +	AD3552R_CH_OUTPUT_RANGE_0__10V,
> +	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
> +	AD3552R_CH_OUTPUT_RANGE_NEG_5__5V,
> +	/* Range from -6.5 V to 3.5 V. Requires Rfb4x connection  */
> +	AD3552R_CH_OUTPUT_RANGE_NEG_10__10V,
> +};
> +
> +static const s32 ch_ranges[][2] = {
> +	[AD3552R_CH_OUTPUT_RANGE_0__2_5V]	= {0, 2500},
> +	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
> +	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000},
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= {-10000, 10000}
> +};
> +
> +enum ad3552r_ch_gain_scaling {
> +	/* Gain scaling of 1 */
> +	AD3552R_CH_GAIN_SCALING_1,
> +	/* Gain scaling of 0.5 */
> +	AD3552R_CH_GAIN_SCALING_0_5,
> +	/* Gain scaling of 0.25 */
> +	AD3552R_CH_GAIN_SCALING_0_25,
> +	/* Gain scaling of 0.125 */
> +	AD3552R_CH_GAIN_SCALING_0_125,
> +};
> +
> +/* Gain * GAIN_SCALE */
> +static const s32 gains_scaling_table[] = {
> +	[AD3552R_CH_GAIN_SCALING_1]		= 1000,
> +	[AD3552R_CH_GAIN_SCALING_0_5]		= 500,
> +	[AD3552R_CH_GAIN_SCALING_0_25]		= 250,
> +	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
> +};
> +
> +enum ad3552r_dev_attributes {
> +	/* - Direct register values */
> +	/* From 0-3 */
> +	AD3552R_SDO_DRIVE_STRENGTH,
> +	/*
> +	 * 0 -> Internal Vref, vref_io pin floating (default)
> +	 * 1 -> Internal Vref, vref_io driven by internal vref
> +	 * 2 or 3 -> External Vref
> +	 */
> +	AD3552R_VREF_SELECT,
> +	/* Enable / Disable CRC */
> +	AD3552R_CRC_ENABLE,
> +	/* Spi mode: Strandard, Dual or Quad */
> +	AD3552R_SPI_MULTI_IO_MODE,
> +	/* Spi data rate: Single or dual */
> +	AD3552R_SPI_DATA_RATE,
> +	/* Dual spi synchronous mode */
> +	AD3552R_SPI_SYNCHRONOUS_ENABLE,
> +
> +	/* - Direct register values (Private) */
> +	/* Read registers in ascending order if set. Else descending */
> +	AD3552R_ADDR_ASCENSION,
> +	/* Single instruction mode if set. Else, stream mode */
> +	AD3552R_SINGLE_INST,
> +	/* Number of addresses to loop on when stream writing. */
> +	AD3552R_STREAM_MODE,
> +	/* Keep stream value if set. */
> +	AD3552R_STREAM_LENGTH_KEEP_VALUE,
> +};
> +
> +enum ad3552r_ch_attributes {
> +	/* DAC powerdown */
> +	AD3552R_CH_DAC_POWERDOWN,
> +	/* DAC amplifier powerdown */
> +	AD3552R_CH_AMPLIFIER_POWERDOWN,
> +	/* Select the output range. Select from enum
> ad3552r_ch_output_range */
> +	AD3552R_CH_OUTPUT_RANGE_SEL,
> +	/*
> +	 * Over-rider the range selector in order to manually set the
> output
> +	 * voltage range
> +	 */
> +	AD3552R_CH_RANGE_OVERRIDE,
> +	/* Manually set the offset voltage */
> +	AD3552R_CH_GAIN_OFFSET,
> +	/* Sets the polarity of the offset. */
> +	AD3552R_CH_GAIN_OFFSET_POLARITY,
> +	/* PDAC gain scaling */
> +	AD3552R_CH_GAIN_SCALING_P,
> +	/* NDAC gain scaling */
> +	AD3552R_CH_GAIN_SCALING_N,
> +	/* Trigger a software LDAC */
> +	AD3552R_CH_TRIGGER_SOFTWARE_LDAC,
> +	/* Hardware LDAC Mask */
> +	AD3552R_CH_HW_LDAC_MASK,
> +	/* Rfb value */
> +	AD3552R_CH_RFB,
> +	/* Channel select. When set allow Input -> DAC and Mask -> DAC
> */
> +	AD3552R_CH_SELECT,
> +	/* Raw value to be set to dac */
> +	AD3552R_CH_CODE
> +};
> +
> +struct ad3552r_ch_data {
> +	u16	gain_offset : 9;
> +	u16	range_override : 1;
> +	u16	n : 2;
> +	u16	p : 2;
> +	u16	offset_polarity : 1;
> +	u16	rfb;
> +	u8	range;
> +	s32	scale_int;
> +	s32	scale_dec;
> +	s32	offset_int;
> +	s32	offset_dec;
> +	bool	prec_en;
> +};
> +
> +struct ad3552r_desc {
> +	struct iio_dev		*indio_dev;
> +	struct mutex		lock;
> +	struct gpio_desc	*gpio_reset;
> +	struct gpio_desc	*gpio_ldac;
> +	struct spi_device	*spi;
> +	struct ad3552r_ch_data	ch_data[AD3552R_NUM_CH];
> +	struct iio_chan_spec	channels[AD3552R_NUM_CH + 1];
> +	unsigned long		enabled_ch;
> +	unsigned int		num_ch;
> +	bool			use_input_regs;
> +	u8 buf_data[2 * (AD3552R_MAX_REG_SIZE + 2)]
> ____cacheline_aligned;
> +};
> +
> +static const u16 addr_mask_map[][2] = {
> +	[AD3552R_ADDR_ASCENSION] = {
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
> +			AD3552R_MASK_ADDR_ASCENSION
> +	},
> +	[AD3552R_SINGLE_INST] = {
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
> +			AD3552R_MASK_SINGLE_INST
> +	},
> +	[AD3552R_STREAM_MODE] = {
> +			AD3552R_REG_ADDR_STREAM_MODE,
> +			AD3552R_MASK_LENGTH
> +	},
> +	[AD3552R_STREAM_LENGTH_KEEP_VALUE] = {
> +			AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +			AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE
> +	},
> +	[AD3552R_SDO_DRIVE_STRENGTH] = {
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +			AD3552R_MASK_SDO_DRIVE_STRENGTH
> +	},
> +	[AD3552R_VREF_SELECT] = {
> +			AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
> +			AD3552R_MASK_REFERENCE_VOLTAGE_SEL
> +	},
> +	[AD3552R_CRC_ENABLE] = {
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_C,
> +			AD3552R_MASK_CRC_ENABLE
> +	},
> +	[AD3552R_SPI_MULTI_IO_MODE] = {
> +			AD3552R_REG_ADDR_TRANSFER_REGISTER,
> +			AD3552R_MASK_MULTI_IO_MODE
> +	},
> +	[AD3552R_SPI_DATA_RATE] = {
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +			AD3552R_MASK_SPI_CONFIG_DDR
> +	},
> +	[AD3552R_SPI_SYNCHRONOUS_ENABLE] = {
> +			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
> +			AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN
> +	},
> +};
> +
> +/* 0 -> reg addr, 1->ch0 mask, 2->ch1 mask */
> +static const u16 addr_mask_map_ch[][3] = {
> +	[AD3552R_CH_DAC_POWERDOWN] = {
> +			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> +			AD3552R_MASK_CH_DAC_POWERDOWN(0),
> +			AD3552R_MASK_CH_DAC_POWERDOWN(1)
> +	},
> +	[AD3552R_CH_AMPLIFIER_POWERDOWN] = {
> +			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
> +			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0),
> +			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1)
> +	},
> +	[AD3552R_CH_OUTPUT_RANGE_SEL] = {
> +			AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
> +			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0),
> +			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1)
> +	},
> +	/*
> +	 * This attributes are update by the chip on 16B and 24B no
> matter to
> +	 * what register the write is done
> +	 */
> +	[AD3552R_CH_TRIGGER_SOFTWARE_LDAC] = {
> +			AD3552R_REG_ADDR_SW_LDAC_16B,
> +			AD3552R_MASK_CH(0),
> +			AD3552R_MASK_CH(1)
> +	},
> +	[AD3552R_CH_HW_LDAC_MASK] = {
> +			AD3552R_REG_ADDR_HW_LDAC_16B,
> +			AD3552R_MASK_CH(0),
> +			AD3552R_MASK_CH(1)
> +	},
> +	[AD3552R_CH_SELECT] = {
> +			AD3552R_REG_ADDR_CH_SELECT_16B,
> +			AD3552R_MASK_CH(0),
> +			AD3552R_MASK_CH(1)
> +	}
> +};
> +
> +static u8 _ad3552r_reg_len(u8 addr)
> +{
> +	if (addr > AD3552R_REG_ADDR_MAX)
> +		return 0;
> +
> +	switch (addr) {
> +	case AD3552R_REG_ADDR_HW_LDAC_16B:
> +	case AD3552R_REG_ADDR_CH_SELECT_16B:
> +	case AD3552R_REG_ADDR_SW_LDAC_16B:
> +	case AD3552R_REG_ADDR_HW_LDAC_24B:
> +	case AD3552R_REG_ADDR_CH_SELECT_24B:
> +	case AD3552R_REG_ADDR_SW_LDAC_24B:
> +		return 1;
> +	default:
> +		break;
> +	}
> +
> +	if (addr > AD3552R_REG_ADDR_HW_LDAC_24B)
> +		return 3;
> +	if (addr > AD3552R_REG_ADDR_HW_LDAC_16B)
> +		return 2;
> +
> +	return 1;
> +}
> +
> +/* SPI transfer to device */
> +static int ad3552r_transfer(struct ad3552r_desc *dac, u8 addr, u32
> len,
> +			    u8 *data, bool is_read)
> +{
> +	int err;
> +	u8 instr;
> +
> +	instr = addr & AD3552R_ADDR_MASK;
> +	instr |= is_read ? AD3552R_READ_BIT : 0;
> +	dac->buf_data[0] = instr;
> +	if (is_read) {
> +		err = spi_write_then_read(dac->spi, dac->buf_data, 1,
> +					  dac->buf_data + 1, len);
> +		if (err)
> +			return err;
> +
> +		memcpy(data, dac->buf_data + 1, len);
> +
> +		return 0;
> +	}
> +
> +	memcpy(dac->buf_data + 1, data, len);
> +	return spi_write(dac->spi, dac->buf_data, len + 1);
> +}
> +
> +static int ad3552r_write_reg(struct ad3552r_desc *dac, u8 addr, u16
> val)
> +{
> +	u8 reg_len, buf[AD3552R_MAX_REG_SIZE] = { 0 };
> +
> +	reg_len = _ad3552r_reg_len(addr);
> +	if (!reg_len)
> +		return -EINVAL;
> +
> +	if (reg_len == 2)
> +		/* Only DAC register are 2 bytes wide */
> +		val &= AD3552R_MASK_DAC_12B;
> +	if (reg_len == 1)
> +		buf[0] = val & 0xFF;
> +	else
> +		/* reg_len can be 2 or 3, but 3rd bytes needs to be set
> to 0 */
> +		*((u16 *)buf) = cpu_to_be16(val);
> 

As you already know, this is not really ok :).

> +	return ad3552r_transfer(dac, addr, reg_len, buf,
> +				AD3552R_WRITE);
> +}
> +
> +static int ad3552r_read_reg(struct ad3552r_desc *dac, u8 addr, u16
> *val)
> +{
> +	int err;
> +	u8  reg_len, buf[AD3552R_MAX_REG_SIZE] = { 0 };
> +
> +	reg_len = _ad3552r_reg_len(addr);
> +	if (!reg_len)
> +		return -EINVAL;
> +
> +	err = ad3552r_transfer(dac, addr, reg_len, buf, AD3552R_READ);
> +	if (err)
> +		return err;
> +
> +	if (reg_len == 1)
> +		*val = buf[0];
> +	else
> +		/* reg_len can be 2 or 3, but only first 2 bytes are
> relevant */
> +		*val = be16_to_cpu(*((u16 *)buf));
> +

ditto

> +	return 0;
> +}
> +
> +/* Update field of a register, shift val if needed */
> +static int ad3552r_update_reg_field(struct ad3552r_desc *dac, u8
> addr, u16 mask,
> +				    u16 val)
> +{
> +	int ret;
> +	u16 reg;
> +
> +	ret = ad3552r_read_reg(dac, addr, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg = (reg & ~mask) | (val << __ffs(mask));
> +
> +	return ad3552r_write_reg(dac, addr, reg);
> +}
> +
> +static int ad3552r_set_dev_value(struct ad3552r_desc *dac,
> +				 enum ad3552r_dev_attributes attr,
> +				 u16 val)
> +{
> +	switch (attr) {
> +	case AD3552R_SPI_MULTI_IO_MODE:
> +	case AD3552R_SPI_DATA_RATE:
> +	case AD3552R_SPI_SYNCHRONOUS_ENABLE:
> +	case AD3552R_CRC_ENABLE:
> +		/* Not implemented */
> +		return -EINVAL;
> +	default:
> +		return ad3552r_update_reg_field(dac,
> addr_mask_map[attr][0],
> +						addr_mask_map[attr][1],
> val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad3552r_set_offset_value(struct ad3552r_desc *dac, u8 ch,
> int val)
> +{
> +	int err;
> +
> +	err = ad3552r_write_reg(dac, AD3552R_REG_ADDR_CH_OFFSET(ch),
> +				val & AD3552R_MASK_CH_OFFSET_BITS_0_7);
> +	if (err)
> +		return err;
> +
> +	err = ad3552r_update_reg_field(dac,
> +				       AD3552R_REG_ADDR_CH_GAIN(ch),
> +				       AD3552R_MASK_CH_OFFSET_BIT_8,
> +				       (val >> 8) &
> AD3552R_MASK_CH_OFFSET_BIT_8);
> +	if (err)
> +		return err;
> +
> +	dac->ch_data[ch].gain_offset = val;
> +
> +	return 0;
> +}
> +
> +static int ad3552r_set_gain_value(struct ad3552r_desc *dac,
> +				  enum ad3552r_ch_attributes attr,
> +				  u8 ch,
> +				  int val)
> +{
> +	int reg_mask, err;
> +
> +	if (attr == AD3552R_CH_GAIN_OFFSET)
> +		return ad3552r_set_offset_value(dac, ch, val);
> +
> +	switch (attr) {
> +	case AD3552R_CH_RANGE_OVERRIDE:
> +		val = !!val;
> +		reg_mask = AD3552R_MASK_CH_RANGE_OVERRIDE;
> +		break;
> +	case AD3552R_CH_GAIN_OFFSET_POLARITY:
> +		val = !!val;
> +		reg_mask = AD3552R_MASK_CH_OFFSET_POLARITY;
> +		break;
> +	case AD3552R_CH_GAIN_SCALING_P:
> +		reg_mask = AD3552R_MASK_CH_GAIN_SCALING_P;
> +		break;
> +	case AD3552R_CH_GAIN_SCALING_N:
> +		reg_mask = AD3552R_MASK_CH_GAIN_SCALING_N;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	err = ad3552r_update_reg_field(dac,
> AD3552R_REG_ADDR_CH_GAIN(ch),
> +				       reg_mask, val);
> +	if (err)
> +		return err;
> +
> +	switch (attr) {
> +	case AD3552R_CH_RANGE_OVERRIDE:
> +		dac->ch_data[ch].range_override = val;
> +		break;
> +	case AD3552R_CH_GAIN_OFFSET_POLARITY:
> +		dac->ch_data[ch].offset_polarity = val;
> +		break;
> +	case AD3552R_CH_GAIN_SCALING_P:
> +		dac->ch_data[ch].p = val;
> +		break;
> +	case AD3552R_CH_GAIN_SCALING_N:
> +		dac->ch_data[ch].n = val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Iterate over mask and write required bytes */
> +static int ad3552r_write_codes(struct ad3552r_desc *dac, u32 mask,
> u8 *vals)
> +{
> +	int err, i, reg_len, k = 0;
> +	unsigned long lmask = mask;
> +	u8 addr, buff[AD3552R_NUM_CH * AD3552R_MAX_REG_SIZE];
> +	u16 val;
> +
> +	/* If writing to consecutive registers do just one transfer */
> +
> +	if (mask == (AD3552R_MASK_CH(0) | AD3552R_MASK_CH(1)) &&
> +	    dac->ch_data[0].prec_en == dac->ch_data[1].prec_en) {
> +		if (dac->use_input_regs) {
> +			if (dac->ch_data[0].prec_en)
> +				addr =
> AD3552R_REG_ADDR_CH_INPUT_24B(1);
> +			else
> +				addr =
> AD3552R_REG_ADDR_CH_INPUT_16B(1);
> +		} else {
> +			if (dac->ch_data[0].prec_en)
> +				addr = AD3552R_REG_ADDR_CH_DAC_24B(1);
> +			else
> +				addr = AD3552R_REG_ADDR_CH_DAC_16B(1);
> +		}
> +
> +		reg_len = _ad3552r_reg_len(addr);
> +		buff[0] = vals[0];
> +		buff[reg_len] = vals[2];
> +		if (dac->ch_data[0].prec_en) {
> +			/* Reg_len is 3 here */
> +			buff[1] = vals[1];
> +			buff[2] = 0;
> +			buff[4] = vals[3];
> +			buff[5] = 0;
> +		} else {
> +			buff[1] = vals[1] & 0xf0;
> +			buff[3] = vals[3] & 0xf0;
> +		}
> +
> +		err = ad3552r_transfer(dac, addr, reg_len * 2, buff,
> +				       AD3552R_WRITE);
> +		if (err)
> +			return err;
> +	} else {
> +
> +		k = 0;
> +		for_each_set_bit(i, &lmask, AD3552R_NUM_CH + 1) {
> +			/* Writing to mask CH */
> +			if (i == AD3552R_PAGE_CH)
> +				addr = dac->ch_data[0].prec_en ?
> +					AD3552R_REG_ADDR_INPUT_PAGE_MAS
> K_24B :
> +					AD3552R_REG_ADDR_INPUT_PAGE_MAS
> K_16B;
> +			else
> +				addr = dac->ch_data[i].prec_en ?
> +					AD3552R_REG_ADDR_CH_INPUT_24B(i
> ) :
> +					AD3552R_REG_ADDR_CH_INPUT_16B(i
> );
> +
> +			reg_len = _ad3552r_reg_len(addr);
> +			val = be16_to_cpu(*((u16 *)(vals + k)));
> +
> +			k += 2;
> +			err = ad3552r_write_reg(dac, addr, val);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	if (dac->gpio_ldac) {
> +		gpiod_set_value_cansleep(dac->gpio_ldac, 0);
> +		usleep_range(LDAC_PULSE_US, LDAC_PULSE_US + 10);
> +		gpiod_set_value_cansleep(dac->gpio_ldac, 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad3552r_get_ch_value(struct ad3552r_desc *dac,
> +				enum ad3552r_ch_attributes attr,
> +				u8 ch,
> +				u16 *val)
> +{
> +	int ret;
> +	u16 reg;
> +	u8  addr;
> +	u16 mask;
> +
> +	/* Attributes not defined in addr_mask_map_ch */
> +	switch (attr) {
> +	case AD3552R_CH_CODE:
> +		return ad3552r_read_reg(dac,
> AD3552R_REG_ADDR_CH_DAC_24B(ch),
> +					val);
> +	case AD3552R_CH_RFB:
> +		*val = dac->ch_data[ch].rfb;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	if (attr >= AD3552R_CH_RANGE_OVERRIDE &&
> +	    attr <= AD3552R_CH_GAIN_SCALING_N)
> +		return -EINVAL;
> +
> +	addr = addr_mask_map_ch[attr][0];
> +	if (addr == AD3552R_REG_ADDR_SW_LDAC_24B ||
> +	    addr == AD3552R_REG_ADDR_SW_LDAC_16B) {
> +		dev_err(&dac->indio_dev->dev, "Write only
> registers\n");
> +		/* LDAC are write only registers */
> +		return -EINVAL;
> +	}
> +
> +	ret = ad3552r_read_reg(dac, addr, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	mask = addr_mask_map_ch[attr][ch + 1];
> +	*val = (reg & mask) >> __ffs(mask);
> +
> +	return 0;
> +}
> +
> +static int ad3552r_set_ch_value(struct ad3552r_desc *dac,
> +				enum ad3552r_ch_attributes attr,
> +				u8 ch,
> +				u16 val)
> +{
> +	int ret;
> +
> +	/* Attributes not defined in addr_mask_map_ch */
> +	switch (attr) {
> +	case AD3552R_CH_CODE:
> +		return ad3552r_write_reg(dac,
> AD3552R_REG_ADDR_CH_DAC_24B(ch),
> +					 val);
> +	case AD3552R_CH_RFB:
> +		dac->ch_data[ch].rfb = val;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	if (attr >= AD3552R_CH_RANGE_OVERRIDE &&
> +	    attr <= AD3552R_CH_GAIN_SCALING_N)
> +		return ad3552r_set_gain_value(dac, attr, ch, val);
> +
> +	/* Update register related to attributes in chip */
> +	ret = ad3552r_update_reg_field(dac, addr_mask_map_ch[attr][0],
> +				       addr_mask_map_ch[attr][ch + 1],
> val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Update software structures */
> +	if (attr == AD3552R_CH_OUTPUT_RANGE_SEL) {
> +		val %= AD3552R_CH_OUTPUT_RANGE_NEG_10__10V + 1;
> +		dac->ch_data[ch].range = val;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t ad3552r_write_ext(struct iio_dev *indio_dev,
> +				 uintptr_t private,
> +				 const struct iio_chan_spec *chan,
> +				 const char *buf, size_t len)
> +{
> +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> +	int val, frac, err;
> +
> +	err = iio_str_to_fixpoint(buf, 0, &val, &frac);
> +	if (err < 0)
> +		return err;
> +
> +	dac->ch_data[chan->channel].prec_en = !!val;
> +
> +	return len;
> +}
> +
> +static ssize_t ad3552r_read_ext(struct iio_dev *indio_dev,
> +				uintptr_t private,
> +				const struct iio_chan_spec *chan,
> +				char *buf)
> +{
> +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> +	int val;
> +
> +	if (private != 0)
> +		return -EINVAL;
> +
> +	val = dac->ch_data[chan->channel].prec_en;
> +
> +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +#define AD3552R_CH_ATTR(_name, _what) { \
> +	.name = _name, \
> +	.read = ad3552r_read_ext, \
> +	.write = ad3552r_write_ext, \
> +	.private = _what, \
> +	.shared = IIO_SEPARATE, \
> +}
> +
> +static const struct iio_chan_spec_ext_info ad3552r_ext_info[] = {
> +	AD3552R_CH_ATTR("precision_mode_en", 0),
> +	{},
> +};
> +
> +#define AD3552R_CH_DAC(_idx) ((struct iio_chan_spec) {		
> \
> +	.type = IIO_VOLTAGE,					\
> +	.output = true,						\
> +	.indexed = true,					\
> +	.channel = _idx,					\
> +	.scan_index = _idx,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_BE,				\
> +	},							\
> +	.ext_info = ad3552r_ext_info,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				BIT(IIO_CHAN_INFO_SCALE) |	\
> +				BIT(IIO_CHAN_INFO_ENABLE) |	\
> +				BIT(IIO_CHAN_INFO_OFFSET),	\
> +})
> +
> +#define AD3552R_CH_DAC_PAGE(_idx) ((struct iio_chan_spec) {	\
> +	.type = IIO_VOLTAGE,					\
> +	.output = true,						\
> +	.indexed = true,					\
> +	.channel = _idx,					\
> +	.scan_index = _idx,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_BE,				\
> +	},							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.modified = 1,						\
> +	.channel2 = IIO_MOD_X_AND_Z,				\
> +})
> +
> +static int ad3552r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val,
> +			    int *val2,
> +			    long mask)
> +{
> +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> +	u16 tmp_val;
> +	int err;
> +	u8 ch = chan->channel;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&dac->lock);
> +		if (chan->channel == AD3552R_PAGE_CH)
> +			err = ad3552r_read_reg(dac,
> +					       AD3552R_REG_ADDR_DAC_PAG
> E_MASK_24B,
> +					       &tmp_val);
> +		else
> +			err = ad3552r_get_ch_value(dac,
> AD3552R_CH_CODE, ch,
> +						   &tmp_val);
> +		if (err < 0) {
> +			mutex_unlock(&dac->lock);
> +			return err;
> +		}
> +
> +		*val = tmp_val;
> +		mutex_unlock(&dac->lock);
> +		break;
> +	case IIO_CHAN_INFO_ENABLE:
> +		mutex_lock(&dac->lock);
> +		err = ad3552r_get_ch_value(dac,
> AD3552R_CH_DAC_POWERDOWN,
> +					   ch, &tmp_val);
> +		if (err < 0) {
> +			mutex_unlock(&dac->lock);
> +			return err;
> +		}
> +		*val = !tmp_val;
> +		mutex_unlock(&dac->lock);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = dac->ch_data[ch].scale_int;
> +		*val2 = dac->ch_data[ch].scale_dec;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = dac->ch_data[ch].offset_int;
> +		*val2 = dac->ch_data[ch].offset_dec;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad3552r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> +	enum ad3552r_ch_attributes attr;
> +	int err = 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->channel == AD3552R_PAGE_CH) {
> +			mutex_lock(&dac->lock);
> +			err = ad3552r_write_reg(dac,
> +						AD3552R_REG_ADDR_DAC_PA
> GE_MASK_24B,
> +						val);
> +			mutex_unlock(&dac->lock);
> +
> +			return err;
> +		}
> +
> +		attr = AD3552R_CH_CODE;
> +		break;
> +	case IIO_CHAN_INFO_ENABLE:
> +		attr = AD3552R_CH_DAC_POWERDOWN;
> +		val = !val;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&dac->lock);
> +	err = ad3552r_set_ch_value(dac, attr, chan->channel, val);
> +	mutex_unlock(&dac->lock);
> +
> +	return err;
> +}
> +
> +static int ad3552r_update_scan_mode(struct iio_dev *indio_dev,
> +				    const unsigned long *scan_mask)
> +{
> +	u32 mask;
> +
> +	mask = *scan_mask;
> +	/* If writing to mask, can't write to other channels */
> +	if ((mask & AD3552R_MASK_CH(AD3552R_PAGE_CH)) &&
> +	    (mask & (~AD3552R_MASK_CH(AD3552R_PAGE_CH))))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * Device type specific information.
> + */
> +static const struct iio_info ad3552r_iio_info = {
> +	.read_raw = ad3552r_read_raw,
> +	.write_raw = ad3552r_write_raw,
> +	.update_scan_mode = ad3552r_update_scan_mode
> +};
> +
> +static irqreturn_t ad3552r_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func	*pf = p;
> +	struct iio_dev		*indio_dev = pf->indio_dev;
> +	struct iio_buffer	*buf = indio_dev->buffer;
> +	struct ad3552r_desc	*dac = iio_priv(indio_dev);
> +	char			buff[AD3552R_NUM_CH *
> AD3552R_MAX_REG_SIZE];
> +	int			err;
> +
> +	memset(buff, 0, sizeof(buff));
> +	mutex_lock(&dac->lock);
> +	err = iio_buffer_remove_sample(buf, buff);
> +	if (err)
> +		goto end;
> +
> +	err = ad3552r_write_codes(dac, *indio_dev->active_scan_mask,
> buff);
> +	if (err)
> +		goto end;
> +
> +end:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	mutex_unlock(&dac->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad3552r_setup_trigger_buffer(struct device *dev,
> +					struct iio_dev *indio_dev, int
> irq)
> +{
> +	struct ad3552r_desc	*dac = iio_priv(indio_dev);
> +	struct iio_trigger	*hwtrig;
> +	int			err;
> +
> +	/* Configure trigger buffer */
> +	err = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
> +						  &ad3552r_trigger_hand
> ler,
> +						  IIO_BUFFER_DIRECTION_
> OUT,
> +						  NULL,
> +						  NULL);
> +	if (err)
> +		return err;
> +
> +	if (!irq)
> +		return 0;
> +
> +	hwtrig = devm_iio_trigger_alloc(dev, "%s-ldac-dev%d",
> +					indio_dev->name,
> +					iio_device_id(indio_dev));
> +	if (!hwtrig)
> +		return -ENOMEM;
> +

Well, As I already expressed this internally, I do not really agree
with this. The device does not really have a trigger (at least one in
the way we are used too) and the only IRQ it has is an ALERT pin which
is not used for alerting us that the device can consume more data.
Hence, I do not think we should be allocating a trigger here. IMO, we
should just use 'devm_iio_triggered_buffer_setup_ext()' and then use a
hrtimer trigger (for example) to poll for new data. I think for these
kind of devices, introducing a new pwm-trigger would also be a nice
thing to consider.

The ldac pin is a trigger for the device, not for us (controller).

- Nuno Sá


