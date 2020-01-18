Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9105141A03
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2020 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgARWOn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jan 2020 17:14:43 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:48890 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgARWOn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jan 2020 17:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8tIlcevMZuK8tzOUEFQH0HMzvOsuxmVV5Iu8EIIenws=; b=TEI+CqdBepm7r5N0g4afC4zpK
        ay2C9SrHNINiF+r5YwEZ+iy4W1GvL9JtCmwhuIUhcxwW8vdO13BZbWTI9tVNQxkyx3TsMdPDGYv53
        jrJaN8KsnTK00kTkqXB5QqgkCXanyXHjgukdOUF4apph/qKapGvuHNUm+r77WSTg8S59c=;
Received: from p200300ccff4ca4007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff4c:a400:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iswMP-0000zS-LT; Sat, 18 Jan 2020 23:14:30 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iswMO-0004ru-FF; Sat, 18 Jan 2020 23:14:28 +0100
Date:   Sat, 18 Jan 2020 23:14:21 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 3/5] iio: adc: rn5t618: Add ADC driver for
 RN5T618/RC5T619
Message-ID: <20200118231421.68546a93@kemnade.info>
In-Reply-To: <20200118145318.399e8318@archlinux>
References: <20200117215926.15194-1-andreas@kemnade.info>
        <20200117215926.15194-4-andreas@kemnade.info>
        <20200118145318.399e8318@archlinux>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=AMvpm5u/8xCpl6FYhdCFaC"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/=AMvpm5u/8xCpl6FYhdCFaC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Jan 2020 14:53:18 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 17 Jan 2020 22:59:24 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>=20
> > Both chips have an A/D converter capable of measuring
> > things like VBAT, VUSB and analog inputs.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info> =20
> A few comments inline, but looks pretty good on the whole.
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/adc/Kconfig       |  10 ++
> >  drivers/iio/adc/Makefile      |   1 +
> >  drivers/iio/adc/rn5t618-adc.c | 266 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 277 insertions(+)
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
> > +	  RN5T618/619 series PMICs:
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
> > index 000000000000..81f872a7ad7f
> > --- /dev/null
> > +++ b/drivers/iio/adc/rn5t618-adc.c
> > @@ -0,0 +1,266 @@
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
> > +#include <linux/irqdomain.h>
> > +
> > +#define RN5T618_ADC_CONVERSION_TIMEOUT   (msecs_to_jiffies(500))
> > +#define REFERENCE_VOLT 2500
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
> > +static const struct rn5t618_channel_ratios rn5t618_ratios[8] =3D {
> > +	{50, 32}, /* LIMMON measured across 20mOhm, amplified by 32 */ =20
> Define an enum for the channel.  Then you can use explicit element
> setting to make this code self docuemnting.
>=20
> [LIMMON] =3D {50, 32},
> [VBAT] =3D {2, 1}, etc.
>=20
> Use the enum to fill in the channel numbers below as well and
> it all becomes 'obviously' correct rather than having to check the
> two things are in the same order.
>=20
oh, yes that makes sense.

> > +	{2, 1}, /* VBAT */
> > +	{3, 1}, /* VADP */
> > +	{3, 1}, /* VUSB */
> > +	{3, 1}, /* VSYS */
> > +	{1, 1}, /* VTHM */
> > +	{1, 1}, /* AIN1 */
> > +	{1, 1}, /* AIN0 */
> > +};
> > +
> > +static int rn5t618_read_adc_reg(struct rn5t618 *rn5t618, int reg, u16 =
*val)
> > +{
> > +	unsigned int h;
> > +	unsigned int l;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(rn5t618->regmap, reg, &h);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D regmap_read(rn5t618->regmap, reg + 1, &l);
> > +	if (ret < 0)
> > +		return ret; =20
>=20
> regmap_bulk_read perhaps?=20
>=20
ok, can do that.
> > +
> > +	h <<=3D 4;
> > +	h |=3D (l & 0xF);
> > +	h &=3D 0xFFF; =20
>=20
> I'd mask h before the shift.  More readable I think than
> masking the l part twice.
>=20
or simply don't mask it at all. It is an 8 bit register, so masking it with
0xff does not make sense at all.

> > +	*val =3D h;
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
> > +		       rn5t618_ratios[chan->channel].denominator / 4095;
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
> > +			      BIT(IIO_CHAN_INFO_PROCESSED), \
> > +	.datasheet_name =3D _name, \
> > +	.indexed =3D 1. \
> > +}
> > +
> > +static const struct iio_chan_spec rn5t618_adc_iio_channels[] =3D {
> > +	RN5T618_ADC_CHANNEL(0, IIO_CURRENT, "LIMMON"),
> > +	RN5T618_ADC_CHANNEL(1, IIO_VOLTAGE, "VBAT"),
> > +	RN5T618_ADC_CHANNEL(2, IIO_VOLTAGE, "VADP"),
> > +	RN5T618_ADC_CHANNEL(3, IIO_VOLTAGE, "VUSB"),
> > +	RN5T618_ADC_CHANNEL(4, IIO_VOLTAGE, "VSYS"),
> > +	RN5T618_ADC_CHANNEL(5, IIO_VOLTAGE, "VTHM"),
> > +	RN5T618_ADC_CHANNEL(6, IIO_VOLTAGE, "AIN1"),
> > +	RN5T618_ADC_CHANNEL(7, IIO_VOLTAGE, "AIN0")
> > +};
> > +
> > +static int rn5t618_adc_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct iio_dev *iio_dev;
> > +	struct rn5t618_adc_data *adc;
> > +	struct rn5t618 *rn5t618 =3D dev_get_drvdata(pdev->dev.parent);
> > +
> > +	iio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*adc));
> > +	if (!iio_dev) {
> > +		dev_err(&pdev->dev, "failed allocating iio device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	adc =3D iio_priv(iio_dev);
> > +	adc->dev =3D &pdev->dev;
> > +	adc->rn5t618 =3D rn5t618;
> > +	adc->irq =3D -ENOENT;
> > +
> > +	if (rn5t618->irq_data)
> > +		adc->irq =3D regmap_irq_get_virq(rn5t618->irq_data,
> > +					       RN5T618_IRQ_ADC);
> > +
> > +	if (adc->irq  < 0) { =20
>=20
> Extra space before the <
> For an irq 0 usually counts as 'no irq'.  Can that particular
> path ever give that?
>=20
hmm, regmap_irq_get_virq seems to return < 0 or 0 on error depending
on situation. Unless there is a bug in the mfd parent, it should not fail.
But maybe better catch that. If the mfd parent itself does not have an IRQ
irq_data will also be NULL.
BTW: palmas_gpadc.c does the same strange check, so maybe it should be fixed
there too.

> > +		dev_err(&pdev->dev, "get virq failed\n");
> > +		return adc->irq;
> > +	}
> > +
> > +	init_completion(&adc->conv_completion);
> > +
> > +	iio_dev->name =3D dev_name(&pdev->dev);
> > +	iio_dev->dev.parent =3D &pdev->dev;
> > +	iio_dev->info =3D &rn5t618_adc_iio_info;
> > +	iio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	iio_dev->channels =3D rn5t618_adc_iio_channels;
> > +	iio_dev->num_channels =3D ARRAY_SIZE(rn5t618_adc_iio_channels);
> > +
> > +	/* stop any auto-conversion */
> > +	ret =3D regmap_write(rn5t618->regmap, RN5T618_ADCCNT3, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	platform_set_drvdata(pdev, iio_dev);
> > +
> > +	ret =3D request_threaded_irq(adc->irq, NULL,
> > +				   rn5t618_adc_irq,
> > +				   IRQF_ONESHOT, dev_name(adc->dev),
> > +				   adc);
> > +	if (ret < 0) {
> > +		dev_err(adc->dev, "request irq %d failed: %d\n", adc->irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D iio_device_register(iio_dev);
> > +	if (ret < 0)
> > +		free_irq(adc->irq, adc);
> > +
> > +	return ret;
> > +}
> > +
> > +static int rn5t618_adc_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *iio_dev =3D platform_get_drvdata(pdev);
> > +	struct rn5t618_adc_data *adc =3D iio_priv(iio_dev);
> > +
> > +	iio_device_unregister(iio_dev);
> > +	free_irq(adc->irq, adc); =20
>=20
> If this is all we are going to have in remove, why not just use
> the device managed form to do it for us and get rid of remove.
>=20
yes, should be a very good idea.

Regards,
Andreas

--Sig_/=AMvpm5u/8xCpl6FYhdCFaC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl4jgz0ACgkQl4jFM1s/
ye+W7w/9EyN0Gq4YI6+s521wX295UnLdEr6Vr1fYS5guUrg/xTw3bqRsQ0eqBtTg
JlfPYy0Wuey3JM0osTJlr6pgphL3W72/EY8ewYGUEFhs9Gp+lR3tjDabh0ZDURm7
i8hc3tWdUu6S7kcBFmm7eErJdL+ifcXWWo/SQAu831kkt0viaCXIH8oLIDc9Xoih
qUX762Ph9NOPJB910FhmmQeqa+v3JJZ421x2eF8Lliiga8dRBBT6QgJasmDWA6bJ
10xcygJqZXw2Dlm0D/n9yRddF/WEWw3k4vfrolkavKf99JqBhdM9O40NyFcmQcVY
lFtTAQuE3jKavOPhSVQTY+PBQch/jrN5Fr0k4IFwhLdN+bC+ns0hu7ojUZ+OeqFO
84FX4B3Z6VlX4SBZkfEcQOotX1YBOOguEzKPEsQT5VX36pbTNUXM2/Exz7Pw/YWs
JaP79YaTIGicFVR+a6PbrmwtAYGWQ0qBfSGJ9jfKFxeJC4ptt/O8F+YwMy4yQnM2
+OpEjAOku48luRDn+Kb9O/QKa4hDVQHr1slHO0TawnhdyOkbEDolMr4crPL3oTLq
diQ5qhm5gMuLAZAHjaNcfExmPkSigimC3aoLVeZtkd9z/R9x4Kdmi+QLjrqEau7w
n7w+gLjccP3emFMEHXiGQkFUVkCWX+uB9JDOq0pzijxK5QfC+II=
=d551
-----END PGP SIGNATURE-----

--Sig_/=AMvpm5u/8xCpl6FYhdCFaC--
