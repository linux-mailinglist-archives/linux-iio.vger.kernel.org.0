Return-Path: <linux-iio+bounces-14738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7FA23208
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 17:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEF27A4343
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659301F0E2C;
	Thu, 30 Jan 2025 16:32:42 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171A1F03F3;
	Thu, 30 Jan 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254762; cv=none; b=pmXifKCW0GK2FfEAEhNDZPm6HOX1gYPwS2EQZ5oVbWtgKDTmyz/6gqoKY9GIS14QR2vbSGUaVPCThTda3xWMRHFKaP5FPYSNA7qadMBml5Pmz6+y83QUbuOyIAnDjvIDXqmOonkVmKD/AoF78xTxJ9saw65Kzvtln1EuuNBf+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254762; c=relaxed/simple;
	bh=N3uRZNOg+mOiqM6Y63kR3dKZjLlgCxorZswyB7Jn/CE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAIyKFyA5NkTn2QMR2eNzu74Dltn+WmY0hf3Uv0+zGrXh/yWCMw8Ipx7u3Sa6aqXoW3dV65aeHlbZ/ldrlyZ7S31FLW7LsW+PtvTxb/kowscWn0EfMbfHIbsDTd96pbjnOAAAzKQXdtEwIuOx6PpNeOvVOvD5dmRvWrtSFyZk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkPgK6kq6z6K61b;
	Fri, 31 Jan 2025 00:31:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2465B140D1A;
	Fri, 31 Jan 2025 00:32:37 +0800 (CST)
Received: from localhost (10.195.245.124) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 17:32:36 +0100
Date: Thu, 30 Jan 2025 16:32:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: <648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com>, David Lechner
	<dlechner@baylibre.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
	<jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 07/16] iio: adc: ad7768-1: convert driver to use
 regmap
Message-ID: <20250130163234.000021e9@huawei.com>
In-Reply-To: <80d444cbed3d30cf24b4d40e129caf6b1ebe358d.camel@gmail.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<0968f9cfc55c5ac80492a88bbe95fc8ff7208fa5.1737985435.git.Jonathan.Santos@analog.com>
	<9b8204f2-107a-477e-a822-c1649af12d02@baylibre.com>
	<648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com>
	<Z5jtx6QaSMxBXoyk@JSANTO12-L01.ad.analog.com>
	<80d444cbed3d30cf24b4d40e129caf6b1ebe358d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 28 Jan 2025 15:09:36 +0000
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Tue, 2025-01-28 at 11:46 -0300, Jonathan Santos wrote:
> > On 01/28, Nuno S=E1 wrote: =20
> > > On Mon, 2025-01-27 at 19:29 -0600, David Lechner wrote: =20
> > > > On 1/27/25 9:12 AM, Jonathan Santos wrote: =20
> > > > > Convert the AD7768-1 driver to use the regmap API for register
> > > > > access. This change simplifies and standardizes register interact=
ions,
> > > > > reducing code duplication and improving maintainability.
> > > > >=20
> > > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > > ---
> > > > > v2 Changes:
> > > > > * New patch in v2.
> > > > > ---
> > > > > =A0drivers/iio/adc/ad7768-1.c | 82 +++++++++++++++++++++++++++---=
--------
> > > > > =A01 file changed, 58 insertions(+), 24 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-=
1.c
> > > > > index 95ba89435652..fb8d6fae5f8a 100644
> > > > > --- a/drivers/iio/adc/ad7768-1.c
> > > > > +++ b/drivers/iio/adc/ad7768-1.c
> > > > > @@ -12,6 +12,7 @@
> > > > > =A0#include <linux/gpio/consumer.h>
> > > > > =A0#include <linux/kernel.h>
> > > > > =A0#include <linux/module.h>
> > > > > +#include <linux/regmap.h>
> > > > > =A0#include <linux/regulator/consumer.h>
> > > > > =A0#include <linux/sysfs.h>
> > > > > =A0#include <linux/spi/spi.h>
> > > > > @@ -153,6 +154,7 @@ static const struct iio_chan_spec ad7768_chan=
nels[]
> > > > > =3D {
> > > > > =A0
> > > > > =A0struct ad7768_state {
> > > > > =A0	struct spi_device *spi;
> > > > > +	struct regmap *regmap;
> > > > > =A0	struct regulator *vref;
> > > > > =A0	struct mutex lock;
> > > > > =A0	struct clk *mclk;
> > > > > @@ -176,12 +178,17 @@ struct ad7768_state {
> > > > > =A0	} data __aligned(IIO_DMA_MINALIGN);
> > > > > =A0};
> > > > > =A0
> > > > > -static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned=
 int
> > > > > addr,
> > > > > -			=A0=A0=A0=A0=A0=A0 unsigned int len)
> > > > > +static int ad7768_spi_reg_read(void *context, unsigned int addr,
> > > > > +			=A0=A0=A0=A0=A0=A0 unsigned int *val)
> > > > > =A0{
> > > > > -	unsigned int shift;
> > > > > +	struct iio_dev *dev =3D context;
> > > > > +	struct ad7768_state *st;
> > > > > +	unsigned int shift, len;
> > > > > =A0	int ret;
> > > > > =A0
> > > > > +	st =3D iio_priv(dev); =20
> > > >=20
> > > > This can be combined with the variable declaration.
> > > >  =20
> > > > > +	/* Regular value size is 1 Byte, but 3 Bytes for ADC data */ =20
> > > >=20
> > > > Probably not currently needed but COEFF_DATA register is also 3 byt=
es.
> > > >  =20
> > > > > +	len =3D (addr =3D=3D AD7768_REG_ADC_DATA) ? 3 : 1;
> > > > > =A0	shift =3D 32 - (8 * len);
> > > > > =A0	st->data.d8[0] =3D AD7768_RD_FLAG_MSK(addr);
> > > > > =A0
> > > > > @@ -190,13 +197,19 @@ static int ad7768_spi_reg_read(struct ad776=
8_state
> > > > > *st, unsigned int addr,
> > > > > =A0	if (ret < 0)
> > > > > =A0		return ret;
> > > > > =A0
> > > > > -	return (be32_to_cpu(st->data.d32) >> shift);
> > > > > +	*val =3D be32_to_cpu(st->data.d32) >> shift;
> > > > > +
> > > > > +	return 0;
> > > > > =A0}
> > > > > =A0
> > > > > -static int ad7768_spi_reg_write(struct ad7768_state *st,
> > > > > +static int ad7768_spi_reg_write(void *context,
> > > > > =A0				unsigned int addr,
> > > > > =A0				unsigned int val)
> > > > > =A0{
> > > > > +	struct iio_dev *dev =3D context;
> > > > > +	struct ad7768_state *st;
> > > > > +
> > > > > +	st =3D iio_priv(dev);
> > > > > =A0	st->data.d8[0] =3D AD7768_WR_FLAG_MSK(addr);
> > > > > =A0	st->data.d8[1] =3D val & 0xFF;
> > > > > =A0
> > > > > @@ -206,16 +219,16 @@ static int ad7768_spi_reg_write(struct
> > > > > ad7768_state
> > > > > *st,
> > > > > =A0static int ad7768_set_mode(struct ad7768_state *st,
> > > > > =A0			=A0=A0 enum ad7768_conv_mode mode)
> > > > > =A0{
> > > > > -	int regval;
> > > > > +	int regval, ret;
> > > > > =A0
> > > > > -	regval =3D ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
> > > > > -	if (regval < 0)
> > > > > -		return regval;
> > > > > +	ret =3D regmap_read(st->regmap, AD7768_REG_CONVERSION, &regval);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > =A0
> > > > > =A0	regval &=3D ~AD7768_CONV_MODE_MSK;
> > > > > =A0	regval |=3D AD7768_CONV_MODE(mode);
> > > > > =A0
> > > > > -	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
> > > > > +	return regmap_write(st->regmap, AD7768_REG_CONVERSION, regval);
> > > > > =A0}
> > > > > =A0
> > > > > =A0static int ad7768_scan_direct(struct iio_dev *indio_dev)
> > > > > @@ -234,9 +247,10 @@ static int ad7768_scan_direct(struct iio_dev
> > > > > *indio_dev)
> > > > > =A0	if (!ret)
> > > > > =A0		return -ETIMEDOUT;
> > > > > =A0
> > > > > -	readval =3D ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > > > > -	if (readval < 0)
> > > > > -		return readval;
> > > > > +	ret =3D regmap_read(st->regmap, AD7768_REG_ADC_DATA, &readval);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > =A0	/*
> > > > > =A0	 * Any SPI configuration of the AD7768-1 can only be
> > > > > =A0	 * performed in continuous conversion mode.
> > > > > @@ -258,13 +272,11 @@ static int ad7768_reg_access(struct iio_dev
> > > > > *indio_dev,
> > > > > =A0
> > > > > =A0	mutex_lock(&st->lock);
> > > > > =A0	if (readval) {
> > > > > -		ret =3D ad7768_spi_reg_read(st, reg, 1);
> > > > > -		if (ret < 0)
> > > > > +		ret =3D regmap_read(st->regmap, reg, readval);
> > > > > +		if (ret)
> > > > > =A0			goto err_unlock; =20
> > > >=20
> > > > Can drop the if and goto.
> > > >  =20
> > > > > -		*readval =3D ret;
> > > > > -		ret =3D 0;
> > > > > =A0	} else {
> > > > > -		ret =3D ad7768_spi_reg_write(st, reg, writeval);
> > > > > +		ret =3D regmap_write(st->regmap, reg, writeval);
> > > > > =A0	}
> > > > > =A0err_unlock:
> > > > > =A0	mutex_unlock(&st->lock);
> > > > > @@ -283,7 +295,7 @@ static int ad7768_set_dig_fil(struct ad7768_s=
tate
> > > > > *st,
> > > > > =A0	else
> > > > > =A0		mode =3D AD7768_DIG_FIL_DEC_RATE(dec_rate);
> > > > > =A0
> > > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER,
> > > > > mode);
> > > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER,
> > > > > mode);
> > > > > =A0	if (ret < 0)
> > > > > =A0		return ret;
> > > > > =A0
> > > > > @@ -320,7 +332,7 @@ static int ad7768_set_freq(struct ad7768_stat=
e *st,
> > > > > =A0	 */
> > > > > =A0	pwr_mode =3D AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_=
div)
> > > > > |
> > > > > =A0		=A0=A0 AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
> > > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK,
> > > > > pwr_mode);
> > > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_POWER_CLOCK,
> > > > > pwr_mode);
> > > > > =A0	if (ret < 0)
> > > > > =A0		return ret;
> > > > > =A0
> > > > > @@ -447,11 +459,11 @@ static int ad7768_setup(struct ad7768_state=
 *st)
> > > > > =A0	 * to 10. When the sequence is detected, the reset occurs.
> > > > > =A0	 * See the datasheet, page 70.
> > > > > =A0	 */
> > > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
> > > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> > > > > =A0	if (ret)
> > > > > =A0		return ret;
> > > > > =A0
> > > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
> > > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> > > > > =A0	if (ret)
> > > > > =A0		return ret;
> > > > > =A0
> > > > > @@ -509,18 +521,19 @@ static int ad7768_buffer_postenable(struct =
iio_dev
> > > > > *indio_dev)
> > > > > =A0	 * continuous read mode. Subsequent data reads do not require
> > > > > an
> > > > > =A0	 * initial 8-bit write to query the ADC_DATA register.
> > > > > =A0	 */
> > > > > -	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT,
> > > > > 0x01);
> > > > > +	return regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT,
> > > > > 0x01);
> > > > > =A0}
> > > > > =A0
> > > > > =A0static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
> > > > > =A0{
> > > > > =A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> > > > > +	unsigned int regval; =20
> > > >=20
> > > > Intention could be more clear by calling this "unused". Otherwise, =
it can
> > > > look
> > > > like a bug if you don't fully understand what the comment below mea=
ns.
> > > >  =20
> > > > > =A0
> > > > > =A0	/*
> > > > > =A0	 * To exit continuous read mode, perform a single read of the
> > > > > ADC_DATA
> > > > > =A0	 * reg (0x2C), which allows further configuration of the
> > > > > device.
> > > > > =A0	 */
> > > > > -	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > > > > +	return regmap_read(st->regmap, AD7768_REG_ADC_DATA, &regval);
> > > > > =A0}
> > > > > =A0
> > > > > =A0static const struct iio_buffer_setup_ops ad7768_buffer_ops =3D=
 {
> > > > > @@ -563,6 +576,20 @@ static int ad7768_set_channel_label(struct i=
io_dev
> > > > > *indio_dev,
> > > > > =A0	return 0;
> > > > > =A0}
> > > > > =A0
> > > > > +static const struct regmap_bus ad7768_regmap_bus =3D {
> > > > > +	.reg_write =3D ad7768_spi_reg_write,
> > > > > +	.reg_read =3D ad7768_spi_reg_read,
> > > > > +	.reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
> > > > > +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG, =20
> > > >=20
> > > > The bus read function is calling be32_to_cpu(), so we probably want=
 to
> > > > remove
> > > > that or change the default here.
> > > >  =20
> > > > > +};
> > > > > +
> > > > > +static const struct regmap_config ad7768_regmap_config =3D {
> > > > > +	.name =3D "ad7768-1",
> > > > > +	.reg_bits =3D 8,
> > > > > +	.val_bits =3D 8, =20
> > > >=20
> > > > Should this be 24 since the largest registers are 24-bit?
> > > >=20
> > > > Another option could be to just use a regular spi_*() API for that
> > > > register
> > > > instead of regmap_*() and avoid trying to do something that regmap =
doesn't
> > > > really handle.
> > > >=20
> > > > Or we could possibly use regmap_bulk_read(), but that feels a bit h=
acky
> > > > too
> > > > since it isn't actually how that function was intended to be used.
> > > >  =20
> > >=20
> > > Hmm I might be missing something but looking at the register map, It =
seems
> > > we do
> > > have 8bit registers? We do have values that span multiple registers (=
3 for
> > > the
> > > 24bit values) and regmap_bulk_read() should actually fit right? I mea=
n,
> > > looking
> > > at the docs:
> > >=20
> > > "regmap_bulk_read() - Read multiple sequential registers from the dev=
ice"
> > >  =20
> >=20
> > Isn't regmap_bulk_*() for reading a value spread in sequential register=
s,
> > like the offset calibration (registers 0x22, 0x23 and 0x24, 8 bits value
> > for each reg)? For the ADC data (0x2C) we have a 24 bits value in only =
one
> > register, so I beleive this does not apply.
> >  =20
>=20
> Ah got it. I failed to see that. Yeah, in that case you're right... it wo=
n't
> work out of the box.
>=20
> > > But I do agree that what we have right now does not make much sense. =
If we
> > > need
> > > to do
> > >=20
> > > len =3D (addr =3D=3D AD7768_REG_ADC_DATA) ? 3 : 1;
> > >=20
> > > for supporting regmap, then I have to question using it. Also note th=
at we
> > > have
> > > things like gain and offset that are also 3 bytes which means that our
> > > custom
> > > read would need to become more questionable if we add support for it.
> > >  =20
> >=20
> > For those cases the regmap_bulk_*() works.
> >  =20
> > > Jonathan, did you tried to use plain regmap (without the custom bus)?
> > > Assuming
> > > bulk reads work, I'm not seeing an apparent reason for the custom bus=
... I
> > > would
> > > also suspect that if bulk reads don't work out of the box, providing a
> > > regmap
> > > cache would make it work but relying on implementation details is not=
 a very
> > > good practice.
> > >  =20
> >=20
> > Yes, i tried and only works for the register with 8-bits value. David
> > suggested using regular spi_*() functions for the unsual registers with
> > 24-bits value, such as the ADC data (0x2C). That is the only way of
> > having the default spi bus interface using regmap. Otherwise we should
> > drop the regmap.  =20
>=20
> Yeah, might be better to do plain spi for the unusual registers rather th=
an the
> custom bus. But no strong feelings on my side...
I'm not keen on a mix or on a regmap that handles the size under the hood.
I think this quirk should be obvious.

Can we do two regmap, one for each of the register size?  We have other
drivers taking that approach and I'm not sure if it was ruled out for
this one.

Jonathan

>=20
> - Nuno S=E1
> >  =20
>=20
>=20
>=20


