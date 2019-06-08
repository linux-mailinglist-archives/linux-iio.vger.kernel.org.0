Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A654639FFD
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFHNpG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfFHNpG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 09:45:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25164214C6;
        Sat,  8 Jun 2019 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560001504;
        bh=1YxBt97MN4FOqn7GkHiFso8ZvFRd2DXHqf/rnTHZR/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MFKghhBGvHU0YZC4dLTf5yhzIQNuLjOJzaAimKxhM0habFSLYrr5ri9PXIGcTjhW3
         5wBGK+rmg3FbQVK8DGxIJFppkkkufZfjB5m7cO7uCsNwGQ0cH+upYqY47BVS6l1F3x
         qU4PG2aLTD31E4FS4QUF8OTZr56YKnKVqYOjQ0OI=
Date:   Sat, 8 Jun 2019 14:44:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] iio: frequency: adf4371: Add support for ADF4371
 PLL
Message-ID: <20190608144458.4d9603aa@archlinux>
In-Reply-To: <1559660282-12183-1-git-send-email-stefan.popa@analog.com>
References: <1559660282-12183-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 4 Jun 2019 17:58:02 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The ADF4371 is a frequency synthesizer with an integrated voltage
> controlled oscillator (VCO) for phase-locked loops (PLLs). The ADF4371
> has an integrated VCO with a fundamental output frequency ranging from
> 4000 MHz to 8000 MHz. In addition, the VCO frequency is connected to
> divide by 1, 2, 4, 8, 16, 32, or 64 circuits that allows the user to
> generate radio frequency (RF) output frequencies as low as 62.5 MHz at
> RF8x. A frequency multiplier at RF16x generates from 8 GHz to 16 GHz. A
> frequency quadrupler generates frequencies from 16 GHz to 32 GHz at RF32x.
> RFAUX8x duplicates the frequency range of RF8x or permits direct access to
> the VCO output.
>=20
> The driver takes the reference input frequency from the device tree and
> uses it to calculate and maximize the PFD frequency (frequency of the pha=
se
> frequency detector). The PFD frequency is further used to calculate the
> timeouts: synthesizer lock, VCO band selection, automatic level
> calibration (ALC) and PLL settling time.
>=20
> This initial driver exposes the attributes for setting the frequency and
> enabling/disabling the different adf4371 channels.
>=20
> Datasheet:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets=
/adf4371.pdf
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
A few comments inline, but nothing to stop me taking it.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- Added a new sysfs-bus-iio-frequency-adf4371 file which documents the A=
BI
> 	  changes.
> 	- Modified the ADF4371_REG() macro to take the reg values in hex as para=
ms
> 	- ADF4371_MAX_MODULUS2 macro is now defined as BIT(14)
> 	- regmap_bulk_write() can do DMA directly, so the buffer was forced into
> 	  it's own cacheline.
> 	- Fixed the multi line comment style.
> Changes in v3:
> 	- out_altvoltageY_frequency and out_altvoltageY_powerdown attributes are
> 	  treated as normal indexed channels.
> 	- out_altvoltageY_name attribute was added, from which the datasheet nam=
es
> 	  of the channels can be read.
> 	- Added more information in the documentation.
> 	- Documented the use of mutex lock.
> 	- As part of adf4371_write(), used a bool variable for power down and a
> 	  64 bit variable for the frequency.
> Changes in v4:
> 	- Misc style fixes.
> Changes in v5:
> 	- Added st->spi =3D spi; line of code in probe and fixing possible NULL
> 	  pointer dereference.
> Changes in v6:
> 	- Channel RF8AUX was accidentally duplicated.
>=20
>  .../ABI/testing/sysfs-bus-iio-frequency-adf4371    |  44 ++
>  drivers/iio/frequency/Kconfig                      |  10 +
>  drivers/iio/frequency/Makefile                     |   1 +
>  drivers/iio/frequency/adf4371.c                    | 594 +++++++++++++++=
++++++
>  4 files changed, 649 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf=
4371
>  create mode 100644 drivers/iio/frequency/adf4371.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 b/=
Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> new file mode 100644
> index 0000000..302de64
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> @@ -0,0 +1,44 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores the PLL frequency in Hz for channel Y.
> +		Reading returns the actual frequency in Hz.
> +		The ADF4371 has an integrated VCO with fundamendal output
> +		frequency ranging from 4000000000 Hz 8000000000 Hz.
> +
> +		out_altvoltage0_frequency:
> +			A divide by 1, 2, 4, 8, 16, 32 or circuit generates
> +			frequencies from 62500000 Hz to 8000000000 Hz.
> +		out_altvoltage1_frequency:
> +			This channel duplicates the channel 0 frequency
> +		out_altvoltage2_frequency:
> +			A frequency doubler generates frequencies from
> +			8000000000 Hz to 16000000000 Hz.
> +		out_altvoltage3_frequency:
> +			A frequency quadrupler generates frequencies from
> +			16000000000 Hz to 32000000000 Hz.
> +
> +		Note: writes to one of the channels will affect the frequency of
> +		all the other channels, since it involves changing the VCO
> +		fundamental output frequency.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_name
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns the datasheet name for channel Y:
Hmm. The open question in my mind is whether _name is obviously enough
associated with the internal datasheet_name parameter... =20

...=20

I can't come up with anything short that does as well so let's go
with this.  I would think we'll actually move this into the core
shortly anyway as standard ABI, but let's do that when we have
a second reason to do so.

> +
> +		out_altvoltage0_name: RF8x
> +		out_altvoltage1_name: RFAUX8x
> +		out_altvoltage2_name: RF16x
> +		out_altvoltage3_name: RF32x
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows the user to power down the PLL and it's
> +		RFOut buffers.
> +		Writing 1 causes the specified channel to power down.
> +		Clearing returns to normal operation.
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index dc5e0b7..e4a921f 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -38,5 +38,15 @@ config ADF4350
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4350.
> =20
> +config ADF4371
> +	tristate "Analog Devices ADF4371 Wideband Synthesizer"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Analog Devices  ADF4371
> +	  Wideband Synthesizer. The driver provides direct access via sysfs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adf4371.
>  endmenu
>  endmenu
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makef=
ile
> index 2bca03f..2ddda77 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -5,3 +5,4 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD9523) +=3D ad9523.o
>  obj-$(CONFIG_ADF4350) +=3D adf4350.o
> +obj-$(CONFIG_ADF4371) +=3D adf4371.o
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4=
371.c
> new file mode 100644
> index 0000000..d8c414b
> --- /dev/null
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -0,0 +1,594 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices ADF4371 SPI Wideband Synthesizer driver
> + *
> + * Copyright 2019 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gcd.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/sysfs.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +
> +/* Registers address macro */
> +#define ADF4371_REG(x)			(x)
I'm not all that keen on this which is basically just a macro to act
as documentation.

Given you could just use c99 structure assignment to make the same point,
that might have been nicer.

.reg =3D XXXX, .bit =3D XXXX
etc
> +
> +/* ADF4371_REG0 */
> +#define ADF4371_ADDR_ASC_MSK		BIT(2)
> +#define ADF4371_ADDR_ASC(x)		FIELD_PREP(ADF4371_ADDR_ASC_MSK, x)
> +#define ADF4371_ADDR_ASC_R_MSK		BIT(5)
> +#define ADF4371_ADDR_ASC_R(x)		FIELD_PREP(ADF4371_ADDR_ASC_R_MSK, x)
> +#define ADF4371_RESET_CMD		0x81
> +
> +/* ADF4371_REG17 */
> +#define ADF4371_FRAC2WORD_L_MSK		GENMASK(7, 1)
> +#define ADF4371_FRAC2WORD_L(x)		FIELD_PREP(ADF4371_FRAC2WORD_L_MSK, x)
> +#define ADF4371_FRAC1WORD_MSK		BIT(0)
> +#define ADF4371_FRAC1WORD(x)		FIELD_PREP(ADF4371_FRAC1WORD_MSK, x)
> +
> +/* ADF4371_REG18 */
> +#define ADF4371_FRAC2WORD_H_MSK		GENMASK(6, 0)
> +#define ADF4371_FRAC2WORD_H(x)		FIELD_PREP(ADF4371_FRAC2WORD_H_MSK, x)
> +
> +/* ADF4371_REG1A */
> +#define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
> +#define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
> +
> +/* ADF4371_REG24 */
> +#define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
> +#define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
> +
> +/* ADF4371_REG32 */
> +#define ADF4371_TIMEOUT_MSK		GENMASK(1, 0)
> +#define ADF4371_TIMEOUT(x)		FIELD_PREP(ADF4371_TIMEOUT_MSK, x)
> +
> +/* ADF4371_REG34 */
> +#define ADF4371_VCO_ALC_TOUT_MSK	GENMASK(4, 0)
> +#define ADF4371_VCO_ALC_TOUT(x)		FIELD_PREP(ADF4371_VCO_ALC_TOUT_MSK, x)
> +
> +/* Specifications */
> +#define ADF4371_MIN_VCO_FREQ		4000000000ULL /* 4000 MHz */
> +#define ADF4371_MAX_VCO_FREQ		8000000000ULL /* 8000 MHz */
> +#define ADF4371_MAX_OUT_RF8_FREQ	ADF4371_MAX_VCO_FREQ /* Hz */
> +#define ADF4371_MIN_OUT_RF8_FREQ	(ADF4371_MIN_VCO_FREQ / 64) /* Hz */
> +#define ADF4371_MAX_OUT_RF16_FREQ	(ADF4371_MAX_VCO_FREQ * 2) /* Hz */
> +#define ADF4371_MIN_OUT_RF16_FREQ	(ADF4371_MIN_VCO_FREQ * 2) /* Hz */
> +#define ADF4371_MAX_OUT_RF32_FREQ	(ADF4371_MAX_VCO_FREQ * 4) /* Hz */
> +#define ADF4371_MIN_OUT_RF32_FREQ	(ADF4371_MIN_VCO_FREQ * 4) /* Hz */
> +
> +#define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
> +#define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
> +
> +/* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
> +#define ADF4371_MODULUS1		33554432ULL
> +/* MOD2 is the programmable, 14-bit auxiliary fractional modulus */
> +#define ADF4371_MAX_MODULUS2		BIT(14)
> +
> +#define ADF4371_CHECK_RANGE(freq, range) \
> +	((freq > ADF4371_MAX_ ## range) || (freq < ADF4371_MIN_ ## range))
> +
> +enum {
> +	ADF4371_FREQ,
> +	ADF4371_POWER_DOWN,
> +	ADF4371_CHANNEL_NAME
> +};
> +
> +enum {
> +	ADF4371_CH_RF8,
> +	ADF4371_CH_RFAUX8,
> +	ADF4371_CH_RF16,
> +	ADF4371_CH_RF32
> +};
> +
> +struct adf4371_pwrdown {
> +	unsigned int reg;
> +	unsigned int bit;
> +};
> +
> +static const char * const adf4371_ch_names[] =3D {
> +	"RF8x", "RFAUX8x", "RF16x", "RF32x"
> +};
> +
> +static const struct adf4371_pwrdown adf4371_pwrdown_ch[4] =3D {
> +	[ADF4371_CH_RF8] =3D { ADF4371_REG(0x25), 2 },
> +	[ADF4371_CH_RFAUX8] =3D { ADF4371_REG(0x72), 3 },
> +	[ADF4371_CH_RF16] =3D { ADF4371_REG(0x25), 3 },
> +	[ADF4371_CH_RF32] =3D { ADF4371_REG(0x25), 4 },
> +};
> +
> +static const struct reg_sequence adf4371_reg_defaults[] =3D {
> +	{ ADF4371_REG(0x0),  0x18 },
> +	{ ADF4371_REG(0x12), 0x40 },
> +	{ ADF4371_REG(0x1E), 0x48 },
> +	{ ADF4371_REG(0x20), 0x14 },
> +	{ ADF4371_REG(0x22), 0x00 },
> +	{ ADF4371_REG(0x23), 0x00 },
> +	{ ADF4371_REG(0x24), 0x80 },
> +	{ ADF4371_REG(0x25), 0x07 },
> +	{ ADF4371_REG(0x27), 0xC5 },
> +	{ ADF4371_REG(0x28), 0x83 },
> +	{ ADF4371_REG(0x2C), 0x44 },
> +	{ ADF4371_REG(0x2D), 0x11 },
> +	{ ADF4371_REG(0x2E), 0x12 },
> +	{ ADF4371_REG(0x2F), 0x94 },
> +	{ ADF4371_REG(0x32), 0x04 },
> +	{ ADF4371_REG(0x35), 0xFA },
> +	{ ADF4371_REG(0x36), 0x30 },
> +	{ ADF4371_REG(0x39), 0x07 },
> +	{ ADF4371_REG(0x3A), 0x55 },
> +	{ ADF4371_REG(0x3E), 0x0C },
> +	{ ADF4371_REG(0x3F), 0x80 },
> +	{ ADF4371_REG(0x40), 0x50 },
> +	{ ADF4371_REG(0x41), 0x28 },
> +	{ ADF4371_REG(0x47), 0xC0 },
> +	{ ADF4371_REG(0x52), 0xF4 },
> +	{ ADF4371_REG(0x70), 0x03 },
> +	{ ADF4371_REG(0x71), 0x60 },
> +	{ ADF4371_REG(0x72), 0x32 },
> +};
> +
> +static const struct regmap_config adf4371_regmap_config =3D {
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.read_flag_mask =3D BIT(7),
> +};
> +
> +struct adf4371_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct clk *clkin;
> +	/*
> +	 * Lock for accessing device registers. Some operations require
> +	 * multiple consecutive R/W operations, during which the device
> +	 * shouldn't be interrupted. The buffers are also shared across
> +	 * all operations so need to be protected on stand alone reads and
> +	 * writes.
> +	 */
> +	struct mutex lock;
> +	unsigned long clkin_freq;
> +	unsigned long fpfd;
> +	unsigned int integer;
> +	unsigned int fract1;
> +	unsigned int fract2;
> +	unsigned int mod2;
> +	unsigned int rf_div_sel;
> +	unsigned int ref_div_factor;
> +	u8 buf[10] ____cacheline_aligned;
> +};
> +
> +static unsigned long long adf4371_pll_fract_n_get_rate(struct adf4371_st=
ate *st,
> +						       u32 channel)
> +{
> +	unsigned long long val, tmp;
> +	unsigned int ref_div_sel;
> +
> +	val =3D (((u64)st->integer * ADF4371_MODULUS1) + st->fract1) * st->fpfd;
> +	tmp =3D (u64)st->fract2 * st->fpfd;
> +	do_div(tmp, st->mod2);
> +	val +=3D tmp + ADF4371_MODULUS1 / 2;
> +
> +	if (channel =3D=3D ADF4371_CH_RF8 || channel =3D=3D ADF4371_CH_RFAUX8)
> +		ref_div_sel =3D st->rf_div_sel;
> +	else
> +		ref_div_sel =3D 0;
> +
> +	do_div(val, ADF4371_MODULUS1 * (1 << ref_div_sel));
> +
> +	if (channel =3D=3D ADF4371_CH_RF16)
> +		val <<=3D 1;
> +	else if (channel =3D=3D ADF4371_CH_RF32)
> +		val <<=3D 2;
> +
> +	return val;
> +}
> +
> +static void adf4371_pll_fract_n_compute(unsigned long long vco,
> +				       unsigned long long pfd,
> +				       unsigned int *integer,
> +				       unsigned int *fract1,
> +				       unsigned int *fract2,
> +				       unsigned int *mod2)
> +{
> +	unsigned long long tmp;
> +	u32 gcd_div;
> +
> +	tmp =3D do_div(vco, pfd);
> +	tmp =3D tmp * ADF4371_MODULUS1;
> +	*fract2 =3D do_div(tmp, pfd);
> +
> +	*integer =3D vco;
> +	*fract1 =3D tmp;
> +
> +	*mod2 =3D pfd;
> +
> +	while (*mod2 > ADF4371_MAX_MODULUS2) {
> +		*mod2 >>=3D 1;
> +		*fract2 >>=3D 1;
> +	}
> +
> +	gcd_div =3D gcd(*fract2, *mod2);
> +	*mod2 /=3D gcd_div;
> +	*fract2 /=3D gcd_div;
> +}
> +
> +static int adf4371_set_freq(struct adf4371_state *st, unsigned long long=
 freq,
> +			    unsigned int channel)
> +{
> +	u32 cp_bleed;
> +	u8 int_mode =3D 0;
> +	int ret;
> +
> +	switch (channel) {
> +	case ADF4371_CH_RF8:
> +	case ADF4371_CH_RFAUX8:
> +		if (ADF4371_CHECK_RANGE(freq, OUT_RF8_FREQ))
> +			return -EINVAL;
> +
> +		st->rf_div_sel =3D 0;
> +
> +		while (freq < ADF4371_MIN_VCO_FREQ) {
> +			freq <<=3D 1;
> +			st->rf_div_sel++;
> +		}
> +		break;
> +	case ADF4371_CH_RF16:
> +		/* ADF4371 RF16 8000...16000 MHz */
> +		if (ADF4371_CHECK_RANGE(freq, OUT_RF16_FREQ))
> +			return -EINVAL;
> +
> +		freq >>=3D 1;
> +		break;
> +	case ADF4371_CH_RF32:
> +		/* ADF4371 RF32 16000...32000 MHz */
> +		if (ADF4371_CHECK_RANGE(freq, OUT_RF32_FREQ))
> +			return -EINVAL;
> +
> +		freq >>=3D 2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	adf4371_pll_fract_n_compute(freq, st->fpfd, &st->integer, &st->fract1,
> +				    &st->fract2, &st->mod2);
> +	st->buf[0] =3D st->integer >> 8;
> +	st->buf[1] =3D 0x40; /* REG12 default */
> +	st->buf[2] =3D 0x00;
> +	st->buf[3] =3D st->fract2 & 0xFF;
> +	st->buf[4] =3D st->fract2 >> 7;
> +	st->buf[5] =3D st->fract2 >> 15;
> +	st->buf[6] =3D ADF4371_FRAC2WORD_L(st->fract2 & 0x7F) |
> +		     ADF4371_FRAC1WORD(st->fract1 >> 23);
> +	st->buf[7] =3D ADF4371_FRAC2WORD_H(st->fract2 >> 7);
> +	st->buf[8] =3D st->mod2 & 0xFF;
> +	st->buf[9] =3D ADF4371_MOD2WORD(st->mod2 >> 8);
> +
> +	ret =3D regmap_bulk_write(st->regmap, ADF4371_REG(0x11), st->buf, 10);
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * The R counter allows the input reference frequency to be
> +	 * divided down to produce the reference clock to the PFD
> +	 */
> +	ret =3D regmap_write(st->regmap, ADF4371_REG(0x1F), st->ref_div_factor);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, ADF4371_REG(0x24),
> +				 ADF4371_RF_DIV_SEL_MSK,
> +				 ADF4371_RF_DIV_SEL(st->rf_div_sel));
> +	if (ret < 0)
> +		return ret;
> +
> +	cp_bleed =3D DIV_ROUND_UP(400 * 1750, st->integer * 375);
> +	cp_bleed =3D clamp(cp_bleed, 1U, 255U);
> +	ret =3D regmap_write(st->regmap, ADF4371_REG(0x26), cp_bleed);
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * Set to 1 when in INT mode (when FRAC1 =3D FRAC2 =3D 0),
> +	 * and set to 0 when in FRAC mode.
> +	 */
> +	if (st->fract1 =3D=3D 0 && st->fract2 =3D=3D 0)
> +		int_mode =3D 0x01;
> +
> +	ret =3D regmap_write(st->regmap, ADF4371_REG(0x2B), int_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADF4371_REG(0x10), st->integer & 0xFF);
> +}
> +
> +static ssize_t adf4371_read(struct iio_dev *indio_dev,
> +			    uintptr_t private,
> +			    const struct iio_chan_spec *chan,
> +			    char *buf)
> +{
> +	struct adf4371_state *st =3D iio_priv(indio_dev);
> +	unsigned long long val =3D 0;
> +	unsigned int readval, reg, bit;
> +	int ret;
> +
> +	switch ((u32)private) {
> +	case ADF4371_FREQ:
> +		val =3D adf4371_pll_fract_n_get_rate(st, chan->channel);
> +		ret =3D regmap_read(st->regmap, ADF4371_REG(0x7C), &readval);
> +		if (ret < 0)
> +			break;
> +
> +		if (readval =3D=3D 0x00) {
> +			dev_dbg(&st->spi->dev, "PLL un-locked\n");
> +			ret =3D -EBUSY;
> +		}
> +		break;
> +	case ADF4371_POWER_DOWN:
> +		reg =3D adf4371_pwrdown_ch[chan->channel].reg;
> +		bit =3D adf4371_pwrdown_ch[chan->channel].bit;
> +
> +		ret =3D regmap_read(st->regmap, reg, &readval);
> +		if (ret < 0)
> +			break;
> +
> +		val =3D !(readval & BIT(bit));
> +		break;
> +	case ADF4371_CHANNEL_NAME:
> +		return sprintf(buf, "%s\n", adf4371_ch_names[chan->channel]);
> +	default:
> +		ret =3D -EINVAL;
> +		val =3D 0;
> +		break;
> +	}
> +
> +	return ret < 0 ? ret : sprintf(buf, "%llu\n", val);
> +}
> +
> +static ssize_t adf4371_write(struct iio_dev *indio_dev,
> +			     uintptr_t private,
> +			     const struct iio_chan_spec *chan,
> +			     const char *buf, size_t len)
> +{
> +	struct adf4371_state *st =3D iio_priv(indio_dev);
> +	unsigned long long freq;
> +	bool power_down;
> +	unsigned int bit, readval, reg;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	switch ((u32)private) {
> +	case ADF4371_FREQ:
> +		ret =3D kstrtoull(buf, 10, &freq);
> +		if (ret)
> +			break;
> +
> +		ret =3D adf4371_set_freq(st, freq, chan->channel);
> +		break;
> +	case ADF4371_POWER_DOWN:
> +		ret =3D kstrtobool(buf, &power_down);
> +		if (ret)
> +			break;
> +
> +		reg =3D adf4371_pwrdown_ch[chan->channel].reg;
> +		bit =3D adf4371_pwrdown_ch[chan->channel].bit;
> +		ret =3D regmap_read(st->regmap, reg, &readval);
> +		if (ret < 0)
> +			break;
> +
> +		readval &=3D ~BIT(bit);
> +		readval |=3D (!power_down << bit);
> +
> +		ret =3D regmap_write(st->regmap, reg, readval);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&st->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +#define _ADF4371_EXT_INFO(_name, _ident) { \
> +		.name =3D _name, \
> +		.read =3D adf4371_read, \
> +		.write =3D adf4371_write, \
> +		.private =3D _ident, \
> +		.shared =3D IIO_SEPARATE, \
> +}
> +
> +static const struct iio_chan_spec_ext_info adf4371_ext_info[] =3D {
> +	/*
> +	 * Ideally we use IIO_CHAN_INFO_FREQUENCY, but there are
> +	 * values > 2^32 in order to support the entire frequency range
> +	 * in Hz. Using scale is a bit ugly.
> +	 */
> +	_ADF4371_EXT_INFO("frequency", ADF4371_FREQ),
> +	_ADF4371_EXT_INFO("powerdown", ADF4371_POWER_DOWN),
> +	_ADF4371_EXT_INFO("name", ADF4371_CHANNEL_NAME),
> +	{ },
> +};
> +
> +#define ADF4371_CHANNEL(index) { \
> +		.type =3D IIO_ALTVOLTAGE, \
> +		.output =3D 1, \
> +		.channel =3D index, \
> +		.ext_info =3D adf4371_ext_info, \
> +		.indexed =3D 1, \
> +	}
> +
> +static const struct iio_chan_spec adf4371_chan[] =3D {
> +	ADF4371_CHANNEL(ADF4371_CH_RF8),
> +	ADF4371_CHANNEL(ADF4371_CH_RFAUX8),
> +	ADF4371_CHANNEL(ADF4371_CH_RF16),
> +	ADF4371_CHANNEL(ADF4371_CH_RF32),
> +};
> +
> +static int adf4371_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int writeval,
> +			      unsigned int *readval)
> +{
> +	struct adf4371_state *st =3D iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +	else
> +		return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static const struct iio_info adf4371_info =3D {
> +	.debugfs_reg_access =3D &adf4371_reg_access,
> +};
> +
> +static int adf4371_setup(struct adf4371_state *st)
> +{
> +	unsigned int synth_timeout =3D 2, timeout =3D 1, vco_alc_timeout =3D 1;
> +	unsigned int vco_band_div, tmp;
> +	int ret;
> +
> +	/* Perform a software reset */
> +	ret =3D regmap_write(st->regmap, ADF4371_REG(0x0), ADF4371_RESET_CMD);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_multi_reg_write(st->regmap, adf4371_reg_defaults,
> +				     ARRAY_SIZE(adf4371_reg_defaults));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set address in ascending order, so the bulk_write() will work */
> +	ret =3D regmap_update_bits(st->regmap, ADF4371_REG(0x0),
> +				 ADF4371_ADDR_ASC_MSK | ADF4371_ADDR_ASC_R_MSK,
> +				 ADF4371_ADDR_ASC(1) | ADF4371_ADDR_ASC_R(1));
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * Calculate and maximize PFD frequency
> +	 * fPFD =3D REFIN =C3=97 ((1 + D)/(R =C3=97 (1 + T)))
> +	 * Where D is the REFIN doubler bit, T is the reference divide by 2,
> +	 * R is the reference division factor
> +	 * TODO: it is assumed D and T equal 0.
> +	 */
> +	do {
> +		st->ref_div_factor++;
> +		st->fpfd =3D st->clkin_freq / st->ref_div_factor;
> +	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
> +
> +	/* Calculate Timeouts */
> +	vco_band_div =3D DIV_ROUND_UP(st->fpfd, 2400000U);
> +
> +	tmp =3D DIV_ROUND_CLOSEST(st->fpfd, 1000000U);
> +	do {
> +		timeout++;
> +		if (timeout > 1023) {
> +			timeout =3D 2;
> +			synth_timeout++;
> +		}
> +	} while (synth_timeout * 1024 + timeout <=3D 20 * tmp);
> +
> +	do {
> +		vco_alc_timeout++;
> +	} while (vco_alc_timeout * 1024 - timeout <=3D 50 * tmp);
> +
> +	st->buf[0] =3D vco_band_div;
> +	st->buf[1] =3D timeout & 0xFF;
> +	st->buf[2] =3D ADF4371_TIMEOUT(timeout >> 8) | 0x04;
> +	st->buf[3] =3D synth_timeout;
> +	st->buf[4] =3D ADF4371_VCO_ALC_TOUT(vco_alc_timeout);
> +
> +	return regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
> +}
> +
> +static void adf4371_clk_disable(void *data)
> +{
> +	struct adf4371_state *st =3D data;
> +
> +	clk_disable_unprepare(st->clkin);
> +}
> +
> +static int adf4371_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +	struct iio_dev *indio_dev;
> +	struct adf4371_state *st;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap =3D devm_regmap_init_spi(spi, &adf4371_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	st =3D iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +	st->spi =3D spi;
> +	st->regmap =3D regmap;
> +	mutex_init(&st->lock);
> +
> +	indio_dev->dev.parent =3D &spi->dev;
> +	indio_dev->name =3D id->name;
> +	indio_dev->info =3D &adf4371_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D adf4371_chan;
> +	indio_dev->num_channels =3D ARRAY_SIZE(adf4371_chan);
> +
> +	st->clkin =3D devm_clk_get(&spi->dev, "clkin");
> +	if (IS_ERR(st->clkin))
> +		return PTR_ERR(st->clkin);
> +
> +	ret =3D clk_prepare_enable(st->clkin);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&spi->dev, adf4371_clk_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	st->clkin_freq =3D clk_get_rate(st->clkin);
> +
> +	ret =3D adf4371_setup(st);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "ADF4371 setup failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id adf4371_id_table[] =3D {
> +	{ "adf4371", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adf4371_id_table);
> +
> +static const struct of_device_id adf4371_of_match[] =3D {
> +	{ .compatible =3D "adi,adf4371" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, adf4371_of_match);
> +
> +static struct spi_driver adf4371_driver =3D {
> +	.driver =3D {
> +		.name =3D "adf4371",
> +		.of_match_table =3D adf4371_of_match,
> +	},
> +	.probe =3D adf4371_probe,
> +	.id_table =3D adf4371_id_table,
> +};
> +module_spi_driver(adf4371_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADF4371 SPI PLL");
> +MODULE_LICENSE("GPL");

