Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC06159616
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2020 18:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgBKRWa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Feb 2020 12:22:30 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:33994 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgBKRW3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 11 Feb 2020 12:22:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=41NYLLK5qRcP8cF8kvTRJuqUxQ6KXFUUpwHwGzlXmUc=; b=VvfnH2oKQYzoIxUMTrhAURVdj
        jUg5G3WJ16HIV5m5ey9kDFs6lOCdxYGdFFlUSkCC2ENMBKFG+AvabUw8aCb/RpZ7SIRipjXo7Nd+f
        d//S8TokeN0vtVge2q2Vb/N4x5olRsY+mMRvoCRCxiwn3GNBlYqHJizp0+bxXGQKk+6HA=;
Received: from p200300ccff0bd500e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0b:d500:e2ce:c3ff:fe93:fc31] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j1ZEr-0001uL-4x; Tue, 11 Feb 2020 18:22:21 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j1YMH-0001bD-HP; Tue, 11 Feb 2020 17:25:57 +0100
Date:   Tue, 11 Feb 2020 17:24:50 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com
Subject: Re: [PATCH v2 1/3] iio: adc: rn5t618: Add ADC driver for
 RN5T618/RC5T619
Message-ID: <20200211172033.6094878c@kemnade.info>
In-Reply-To: <20200202173355.1b949a37@archlinux>
References: <20200120212056.28806-1-andreas@kemnade.info>
        <20200120212056.28806-2-andreas@kemnade.info>
        <20200202173355.1b949a37@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vBUbY9u/kbP2xVXByu8Ctzs"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/vBUbY9u/kbP2xVXByu8Ctzs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Feb 2020 17:33:55 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 20 Jan 2020 22:20:54 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>=20
> > Both chips have an A/D converter capable of measuring
> > things like VBAT, VUSB and analog inputs.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info> =20
> Sorry I missed one bigger thing in here around PROCESSED vs RAW.
> See inline.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > Changes in v2:
> > - enum for channels
> > - bulk read instead of single byte read for conversion
> >   result
> > - fix get_virq error handling
> > - use devm for registering device and requesting IRQ
> >=20
> >  drivers/iio/adc/Kconfig       |  10 ++
> >  drivers/iio/adc/Makefile      |   1 +
> >  drivers/iio/adc/rn5t618-adc.c | 253 ++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 264 insertions(+)
> >  create mode 100644 drivers/iio/adc/rn5t618-adc.c
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index f0af3a42f53c..9ea9489e3f0a 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -735,6 +735,16 @@ config RCAR_GYRO_ADC
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called rcar-gyroadc.
> > =20
> > +config RN5T618_ADC
> > +	tristate "ADC for the RN5T618/RC5T619 family of chips"
> > +	depends on MFD_RN5T618
> > +	help
> > +	  Say yes here to build support for the integrated ADC inside the
> > +	  RN5T618/619 series PMICs: =20
> Why :?
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called rn5t618-adc.
> > +
> >  config ROCKCHIP_SARADC
> >  	tristate "Rockchip SARADC driver"
> >  	depends on ARCH_ROCKCHIP || (ARM && COMPILE_TEST)
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index ef9cc485fb67..2aea70556ed0 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -69,6 +69,7 @@ obj-$(CONFIG_QCOM_VADC_COMMON) +=3D qcom-vadc-common.o
> >  obj-$(CONFIG_QCOM_SPMI_VADC) +=3D qcom-spmi-vadc.o
> >  obj-$(CONFIG_QCOM_PM8XXX_XOADC) +=3D qcom-pm8xxx-xoadc.o
> >  obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
> > +obj-$(CONFIG_RN5T618_ADC) +=3D rn5t618-adc.o
> >  obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
> >  obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
> >  obj-$(CONFIG_SPEAR_ADC) +=3D spear_adc.o
> > diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-ad=
c.c
> > new file mode 100644
> > index 000000000000..667bd814569d
> > --- /dev/null
> > +++ b/drivers/iio/adc/rn5t618-adc.c
> > @@ -0,0 +1,253 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * ADC driver for the RICOH RN5T618 power management chip family
> > + *
> > + * Copyright (C) 2019 Andreas Kemnade
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/rn5t618.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/completion.h>
> > +#include <linux/regmap.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/slab.h>
> > +#include <linux/irqdomain.h> =20
> I may be missing something, but I'm not immediately seeing any irq_domain*
> calls?  I suspect the only call is via stuff buried in regmap so we proba=
bly
> don't need the header here.
>=20
> > +
> > +#define RN5T618_ADC_CONVERSION_TIMEOUT   (msecs_to_jiffies(500))
> > +#define REFERENCE_VOLT 2500 =20
>=20
> Please prefix these defines
> RN5T618_*=20
>=20
Does that also apply for the defines below?

> It avoids potential clashes in future with things defined in headers.
>=20
> > +
> > +/* mask for selecting channels for single conversion */
> > +#define ADCCNT3_CHANNEL_MASK 0x7
> > +/* average 4-time conversion mode */
> > +#define ADCCNT3_AVG BIT(3)
> > +/* set for starting a single conversion, gets cleared by hw when done =
*/
> > +#define ADCCNT3_GODONE BIT(4)
> > +/* automatic conversion, period is in ADCCNT2, selected channels are
> > + * in ADCCNT1
> > + */
> > +#define ADCCNT3_AUTO BIT(5)
> > +#define ADCEND_IRQ BIT(0)
> > +
> > +struct rn5t618_adc_data {
> > +	struct device *dev;
> > +	struct rn5t618 *rn5t618;
> > +	struct completion conv_completion;
> > +	int irq;
> > +};
> > +
> > +struct rn5t618_channel_ratios {
> > +	u16 numerator;
> > +	u16 denominator;
> > +};
> > +
> > +enum rn5t618_channels {
> > +	LIMMON =3D 0,
> > +	VBAT,
> > +	VADP,
> > +	VUSB,
> > +	VSYS,
> > +	VTHM,
> > +	AIN1,
> > +	AIN0
> > +};
> > +
> > +static const struct rn5t618_channel_ratios rn5t618_ratios[8] =3D {
> > +	[LIMMON] =3D {50, 32}, /* measured across 20mOhm, amplified by 32 */
> > +	[VBAT] =3D {2, 1},
> > +	[VADP] =3D {3, 1},
> > +	[VUSB] =3D {3, 1},
> > +	[VSYS] =3D {3, 1},
> > +	[VTHM] =3D {1, 1},
> > +	[AIN1] =3D {1, 1},
> > +	[AIN0] =3D {1, 1},
> > +};
> > +
> > +static int rn5t618_read_adc_reg(struct rn5t618 *rn5t618, int reg, u16 =
*val)
> > +{
> > +	u8 data[2];
> > +	int ret;
> > +
> > +	ret =3D regmap_bulk_read(rn5t618->regmap, reg, data, sizeof(data));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val =3D (data[0] << 4) | (data[1] & 0xF);
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t rn5t618_adc_irq(int irq, void *data)
> > +{
> > +	struct rn5t618_adc_data *adc =3D data;
> > +	unsigned int r =3D 0;
> > +	int ret;
> > +
> > +	/* clear low & high threshold irqs */
> > +	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC1, 0);
> > +	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC2, 0);
> > +
> > +	ret =3D regmap_read(adc->rn5t618->regmap, RN5T618_IR_ADC3, &r);
> > +	if (ret < 0)
> > +		dev_err(adc->dev, "failed to read IRQ status: %d\n", ret);
> > +
> > +	regmap_write(adc->rn5t618->regmap, RN5T618_IR_ADC3, 0);
> > +
> > +	if (r & ADCEND_IRQ)
> > +		complete(&adc->conv_completion);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int rn5t618_adc_read(struct iio_dev *iio_dev,
> > +			    const struct iio_chan_spec *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct rn5t618_adc_data *adc =3D iio_priv(iio_dev);
> > +	u16 raw;
> > +	int ret;
> > +
> > +	/* select channel */
> > +	ret =3D regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
> > +				 ADCCNT3_CHANNEL_MASK,
> > +				 chan->channel);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D regmap_write(adc->rn5t618->regmap, RN5T618_EN_ADCIR3, ADCEND_=
IRQ);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
> > +				 ADCCNT3_AVG,
> > +				 mask =3D=3D IIO_CHAN_INFO_AVERAGE_RAW ?
> > +				 ADCCNT3_AVG : 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	init_completion(&adc->conv_completion);
> > +	/* single conversion */
> > +	ret =3D regmap_update_bits(adc->rn5t618->regmap, RN5T618_ADCCNT3,
> > +				 ADCCNT3_GODONE, ADCCNT3_GODONE);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D wait_for_completion_timeout(&adc->conv_completion,
> > +					  RN5T618_ADC_CONVERSION_TIMEOUT);
> > +	if (ret =3D=3D 0) {
> > +		dev_warn(adc->dev, "timeout waiting for adc result\n");
> > +		return -ETIMEDOUT;
> > +	}
> > +
> > +	ret =3D rn5t618_read_adc_reg(adc->rn5t618,
> > +				   RN5T618_ILIMDATAH + 2 * chan->channel,
> > +				   &raw);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*val =3D raw;
> > +	if (mask =3D=3D IIO_CHAN_INFO_PROCESSED)
> > +		*val =3D *val * REFERENCE_VOLT *
> > +		       rn5t618_ratios[chan->channel].numerator /
> > +		       rn5t618_ratios[chan->channel].denominator / 4095; =20
>=20
> This info should be provided as scale so that userspace can do the maths =
if
> it wants to rather than handling it in kernel.
>=20
can do as has to do? So I guess any simple shell script then cannot simply
read out values from sysfs.
Hmm, how is scale defined here?
processed in mV =3D raw * scale (which can be IIO_VAL_FRACTIONAL)?

> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static const struct iio_info rn5t618_adc_iio_info =3D {
> > +	.read_raw =3D &rn5t618_adc_read,
> > +};
> > +
> > +#define RN5T618_ADC_CHANNEL(_channel, _type, _name) { \
> > +	.type =3D _type, \
> > +	.channel =3D _channel, \
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> > +			      BIT(IIO_CHAN_INFO_AVERAGE_RAW) | \
> > +			      BIT(IIO_CHAN_INFO_PROCESSED), \ =20
>=20
> Sorry, I missed this before.=20
>=20
> As a general rule it makes no sense to expose both RAW and PROCESSED valu=
es.
> It should be possible to work one out from the other if the relationship =
is
> linear and scale is provided.
>=20
hmm, the other adc drivers, I get in touch with, expose both RAW and PROCES=
SED.
like twl4030_madc. So you want to not have that for new drivers and from the
previous comment you prefer to have PROCESSED dropped here?

Regards,
Andreas

--Sig_/vBUbY9u/kbP2xVXByu8Ctzs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5C1VIACgkQl4jFM1s/
ye+4rxAAukhEdCr5+cNk4+viLBRbT44QJoZepp66pkWugvCzqeZ0JSDKPG53yLXO
w5HsHn1UINVwrjCWKYoHBudkhYCn+etzWk29HOH34QuMqSx9ii5lWGLbKvCQnvC5
r6HAwcNLuc8VZ52uZI03WRNLzqYtqzTbLykX6T4zdrtlOU+RxZVfj/vYM+316Qpy
IRYMXvZJMarjJlmPmgJisbpecNgRbDnd+fGXO7yXXds8SSQ1Uf7hwAYAu5A+U6si
CZuRHW8bBkRLAQrBWEMigpvGTVOjSW2fQG/shbdBxl+dwMgI9+vOw18UdQLtXmCY
ai43DOXkzEo92VPKWOg8Hjd1IC/nOukuy39/yMBSnO9HmTtaKH+gbuc4ZL3VSRk7
xwij3WMCQqzM5wG6cTixhDS+Z6hjgiAhzgCN4uQ7Mh11V04qTKK9eJUToUUiL37n
+nbf1N4Mu4ZMvRccO1mqXL5FE1gpBGkCBQBo8yQrOB71VXEFN/pmGw3/pR7jTPxH
4ApdvvxJ3jhFCzoOXZam9yBSvSjfTWHBynOaSvuz3q046UV3hqCKw7ylT/fz2yII
V/1XLu7egNJyI7+LBjYK4A2HbgEe/Cv7nSoeLU6OycorLNGZzdaNfrrj5x1sSzL8
gwa63HDT815XsCSVbIkQnds2qyLxLgPA0a2704qGI1mPzWH7ADs=
=ttxJ
-----END PGP SIGNATURE-----

--Sig_/vBUbY9u/kbP2xVXByu8Ctzs--
