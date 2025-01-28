Return-Path: <linux-iio+bounces-14678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E9A20CA9
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 16:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156D918841A7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498491BEF74;
	Tue, 28 Jan 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ6PKlun"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DB1A0BCD;
	Tue, 28 Jan 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076980; cv=none; b=NK1pHumypYjNbNgo2tuOcmFr01QU166epqIXCsa4Cb1w7ve75VO4i7bFdyvWntwqHYGNLVcd9HwqLalJz1hVobm0XXJQ+I+EZAy9ju21Q4QXT1o41h0mj6PVZFdg67YYHEdCDRuWJCL3qUOtrVH7wDlkXwNlijNnyXAQbqDPTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076980; c=relaxed/simple;
	bh=B0ih7HbYnolx4j3RHit7hoGsah1qbaGrxO5FPqi05hk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mk2TtI5HuaX4y4X/qt5yN/lws8qSBgRyml4VbU+2MWIMNqi7Ks9AXQcUCN71qyQXn7Z6CBVv1X4gnP9N0eq/GKoKfsgtHNiqhAc/W4TbQdQbEjw28arjhvF4ULUJoy0JtlAUAEAQCVJR+aBTmsOeirPqP7UgxtiNozN5zkF65HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJ6PKlun; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso39030785e9.3;
        Tue, 28 Jan 2025 07:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738076976; x=1738681776; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJg1xIa6+W+nc8hdIjhzpfAw0ph1sIlZz+gDyJW76U4=;
        b=mJ6PKlunnBjNjNHF2aE/pVbiVdepDzfsciFaH3dLx7nuEkI3Vb4GcTtIFnL4ZJmOdR
         CZbakgeZC5U+vkjWRsh3XRixe9vXX6iKWAW7Q6jyJHIHqxWvX/+3euGd66e3M7cCFSjH
         vaALMMiNIfk3LpIC92Z5pZ8aSZqV3V+SYjg56aXIFq1d1qRta+4UEPNt2HoukvvzOaEZ
         tgcjQD42P1kUjoL2zKTBt/uB0vaITvGVh3at0scavxn5s7y+8WJYz349bmvQATEG/071
         /XzFImaKvZf5b4SoBIYBwndivRye7rx0QxQyG/7QxMkUj90swwLiuEQHte5fReSQVDAJ
         w0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076976; x=1738681776;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJg1xIa6+W+nc8hdIjhzpfAw0ph1sIlZz+gDyJW76U4=;
        b=q2tPRCXzOKfJEj6gqgECui5bLsW5STcbxn4j9Zt5i+d22GaomRPPjrLFbB8g2Y4hDT
         3Jmp2C26IxSszkDgKgVrCINSfdIwPfqFS6d6o1pExnhjJjKfDX+/xCsZQ1RYHb0tq72m
         GxNiwVmerX7RSu4xTwjs0W7VTLyH20jqmktalrmC4br+v1Ii6F1yTahudXKHw79wasWU
         Ja//C62XE2U9HCYMb2ScjZBg/2TUpTlKNr6jwLCcOd+9C7N6pjplq8WqhZBobzI3HFfh
         BXFHGF0L8e8VjOdO6jth0A/jJ6+wkxjYhNs3BPgvEVC1rimzy4cqi1D2vgdTk/EKqDWU
         q2LA==
X-Forwarded-Encrypted: i=1; AJvYcCVc/MjY2gHkR8vu9thGYx5CoWejgt2dY0M0cr3FLG0P+f73WOQI3N7QC4oSt6GbERHjHncT3yZUjWAd@vger.kernel.org, AJvYcCWPeUj2L3ooPSOh5sJVdKfgUld7xf92ExZ1vfKbJHe310yDLq9XJiZE/vgpM7iiEvEOFcdVIiYGoYWx@vger.kernel.org, AJvYcCWcNBSKzaI2CSOXFu06EsC5VdMpP3ynDYMm5G9dnnj/j7ipJxIki/lMy3egSbkukeRv7oVYSZ2Jc9tpbz+3@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOm8JvFwuUuV9vBqwfuK0ovvtIx4G+akiA3R3JL8SE5lN9DF/
	t617WL+8mJuB/p8aHkQ73yWKa6S7qxm6Pk20fVb/vbhg2NJf94Eb
X-Gm-Gg: ASbGnculSrr9JVpnw3Ut9BwD8xD+ajbSSpfdTbWpZFvoEODNmpQeRU2uflWNNkg/DqD
	aRx+MSa472weBGRW5tnU1IdJPNacS5Rw66a19mhQ1qZcrmqea4SvZbV7fQSoS9/UFVuQUzG0WqZ
	4ccAiTj+gHY93G8C5j+4O5MvT405E1Rs/Qgcs52Y4QdMoXo0GGSzaEA6W6tQvx8EvDtJz+pmPVE
	74IlMkHQdhS4X34Z+BpVpaCAEBGc3Wu2IPM72+AZv+bTFbZQkEQaxvRIGzoG054Hgi7aCdugvPs
	9V+WwDDYIH4x93/KWs4zo/cwYvK31jNcNBho8vvo4puJMrl4SH1cswNjTi+4Cq4=
X-Google-Smtp-Source: AGHT+IEfADpzKSPshHfHkQD6FbPypB+sd0w12a+BkA+IXB15KiZH8SF5kPW6ANO+idmw4HkSEN5Nlw==
X-Received: by 2002:a05:600c:1f10:b0:434:ff9d:a370 with SMTP id 5b1f17b1804b1-438912d1d49mr432976675e9.0.1738076975848;
        Tue, 28 Jan 2025 07:09:35 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4c75c0sm170983235e9.31.2025.01.28.07.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:09:35 -0800 (PST)
Message-ID: <80d444cbed3d30cf24b4d40e129caf6b1ebe358d.camel@gmail.com>
Subject: Re: [PATCH v2 07/16] iio: adc: ad7768-1: convert driver to use
 regmap
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: 648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Santos	
 <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Date: Tue, 28 Jan 2025 15:09:36 +0000
In-Reply-To: <Z5jtx6QaSMxBXoyk@JSANTO12-L01.ad.analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	 <0968f9cfc55c5ac80492a88bbe95fc8ff7208fa5.1737985435.git.Jonathan.Santos@analog.com>
	 <9b8204f2-107a-477e-a822-c1649af12d02@baylibre.com>
	 <648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com>
	 <Z5jtx6QaSMxBXoyk@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-28 at 11:46 -0300, Jonathan Santos wrote:
> On 01/28, Nuno S=C3=A1 wrote:
> > On Mon, 2025-01-27 at 19:29 -0600, David Lechner wrote:
> > > On 1/27/25 9:12 AM, Jonathan Santos wrote:
> > > > Convert the AD7768-1 driver to use the regmap API for register
> > > > access. This change simplifies and standardizes register interactio=
ns,
> > > > reducing code duplication and improving maintainability.
> > > >=20
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---
> > > > v2 Changes:
> > > > * New patch in v2.
> > > > ---
> > > > =C2=A0drivers/iio/adc/ad7768-1.c | 82 +++++++++++++++++++++++++++--=
---------
> > > > =C2=A01 file changed, 58 insertions(+), 24 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.=
c
> > > > index 95ba89435652..fb8d6fae5f8a 100644
> > > > --- a/drivers/iio/adc/ad7768-1.c
> > > > +++ b/drivers/iio/adc/ad7768-1.c
> > > > @@ -12,6 +12,7 @@
> > > > =C2=A0#include <linux/gpio/consumer.h>
> > > > =C2=A0#include <linux/kernel.h>
> > > > =C2=A0#include <linux/module.h>
> > > > +#include <linux/regmap.h>
> > > > =C2=A0#include <linux/regulator/consumer.h>
> > > > =C2=A0#include <linux/sysfs.h>
> > > > =C2=A0#include <linux/spi/spi.h>
> > > > @@ -153,6 +154,7 @@ static const struct iio_chan_spec ad7768_channe=
ls[]
> > > > =3D {
> > > > =C2=A0
> > > > =C2=A0struct ad7768_state {
> > > > =C2=A0	struct spi_device *spi;
> > > > +	struct regmap *regmap;
> > > > =C2=A0	struct regulator *vref;
> > > > =C2=A0	struct mutex lock;
> > > > =C2=A0	struct clk *mclk;
> > > > @@ -176,12 +178,17 @@ struct ad7768_state {
> > > > =C2=A0	} data __aligned(IIO_DMA_MINALIGN);
> > > > =C2=A0};
> > > > =C2=A0
> > > > -static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned i=
nt
> > > > addr,
> > > > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int len)
> > > > +static int ad7768_spi_reg_read(void *context, unsigned int addr,
> > > > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *val)
> > > > =C2=A0{
> > > > -	unsigned int shift;
> > > > +	struct iio_dev *dev =3D context;
> > > > +	struct ad7768_state *st;
> > > > +	unsigned int shift, len;
> > > > =C2=A0	int ret;
> > > > =C2=A0
> > > > +	st =3D iio_priv(dev);
> > >=20
> > > This can be combined with the variable declaration.
> > >=20
> > > > +	/* Regular value size is 1 Byte, but 3 Bytes for ADC data */
> > >=20
> > > Probably not currently needed but COEFF_DATA register is also 3 bytes=
.
> > >=20
> > > > +	len =3D (addr =3D=3D AD7768_REG_ADC_DATA) ? 3 : 1;
> > > > =C2=A0	shift =3D 32 - (8 * len);
> > > > =C2=A0	st->data.d8[0] =3D AD7768_RD_FLAG_MSK(addr);
> > > > =C2=A0
> > > > @@ -190,13 +197,19 @@ static int ad7768_spi_reg_read(struct ad7768_=
state
> > > > *st, unsigned int addr,
> > > > =C2=A0	if (ret < 0)
> > > > =C2=A0		return ret;
> > > > =C2=A0
> > > > -	return (be32_to_cpu(st->data.d32) >> shift);
> > > > +	*val =3D be32_to_cpu(st->data.d32) >> shift;
> > > > +
> > > > +	return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > -static int ad7768_spi_reg_write(struct ad7768_state *st,
> > > > +static int ad7768_spi_reg_write(void *context,
> > > > =C2=A0				unsigned int addr,
> > > > =C2=A0				unsigned int val)
> > > > =C2=A0{
> > > > +	struct iio_dev *dev =3D context;
> > > > +	struct ad7768_state *st;
> > > > +
> > > > +	st =3D iio_priv(dev);
> > > > =C2=A0	st->data.d8[0] =3D AD7768_WR_FLAG_MSK(addr);
> > > > =C2=A0	st->data.d8[1] =3D val & 0xFF;
> > > > =C2=A0
> > > > @@ -206,16 +219,16 @@ static int ad7768_spi_reg_write(struct
> > > > ad7768_state
> > > > *st,
> > > > =C2=A0static int ad7768_set_mode(struct ad7768_state *st,
> > > > =C2=A0			=C2=A0=C2=A0 enum ad7768_conv_mode mode)
> > > > =C2=A0{
> > > > -	int regval;
> > > > +	int regval, ret;
> > > > =C2=A0
> > > > -	regval =3D ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
> > > > -	if (regval < 0)
> > > > -		return regval;
> > > > +	ret =3D regmap_read(st->regmap, AD7768_REG_CONVERSION, &regval);
> > > > +	if (ret)
> > > > +		return ret;
> > > > =C2=A0
> > > > =C2=A0	regval &=3D ~AD7768_CONV_MODE_MSK;
> > > > =C2=A0	regval |=3D AD7768_CONV_MODE(mode);
> > > > =C2=A0
> > > > -	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
> > > > +	return regmap_write(st->regmap, AD7768_REG_CONVERSION, regval);
> > > > =C2=A0}
> > > > =C2=A0
> > > > =C2=A0static int ad7768_scan_direct(struct iio_dev *indio_dev)
> > > > @@ -234,9 +247,10 @@ static int ad7768_scan_direct(struct iio_dev
> > > > *indio_dev)
> > > > =C2=A0	if (!ret)
> > > > =C2=A0		return -ETIMEDOUT;
> > > > =C2=A0
> > > > -	readval =3D ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > > > -	if (readval < 0)
> > > > -		return readval;
> > > > +	ret =3D regmap_read(st->regmap, AD7768_REG_ADC_DATA, &readval);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > =C2=A0	/*
> > > > =C2=A0	 * Any SPI configuration of the AD7768-1 can only be
> > > > =C2=A0	 * performed in continuous conversion mode.
> > > > @@ -258,13 +272,11 @@ static int ad7768_reg_access(struct iio_dev
> > > > *indio_dev,
> > > > =C2=A0
> > > > =C2=A0	mutex_lock(&st->lock);
> > > > =C2=A0	if (readval) {
> > > > -		ret =3D ad7768_spi_reg_read(st, reg, 1);
> > > > -		if (ret < 0)
> > > > +		ret =3D regmap_read(st->regmap, reg, readval);
> > > > +		if (ret)
> > > > =C2=A0			goto err_unlock;
> > >=20
> > > Can drop the if and goto.
> > >=20
> > > > -		*readval =3D ret;
> > > > -		ret =3D 0;
> > > > =C2=A0	} else {
> > > > -		ret =3D ad7768_spi_reg_write(st, reg, writeval);
> > > > +		ret =3D regmap_write(st->regmap, reg, writeval);
> > > > =C2=A0	}
> > > > =C2=A0err_unlock:
> > > > =C2=A0	mutex_unlock(&st->lock);
> > > > @@ -283,7 +295,7 @@ static int ad7768_set_dig_fil(struct ad7768_sta=
te
> > > > *st,
> > > > =C2=A0	else
> > > > =C2=A0		mode =3D AD7768_DIG_FIL_DEC_RATE(dec_rate);
> > > > =C2=A0
> > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER,
> > > > mode);
> > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER,
> > > > mode);
> > > > =C2=A0	if (ret < 0)
> > > > =C2=A0		return ret;
> > > > =C2=A0
> > > > @@ -320,7 +332,7 @@ static int ad7768_set_freq(struct ad7768_state =
*st,
> > > > =C2=A0	 */
> > > > =C2=A0	pwr_mode =3D AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk=
_div)
> > > > |
> > > > =C2=A0		=C2=A0=C2=A0 AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrm=
ode);
> > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK,
> > > > pwr_mode);
> > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_POWER_CLOCK,
> > > > pwr_mode);
> > > > =C2=A0	if (ret < 0)
> > > > =C2=A0		return ret;
> > > > =C2=A0
> > > > @@ -447,11 +459,11 @@ static int ad7768_setup(struct ad7768_state *=
st)
> > > > =C2=A0	 * to 10. When the sequence is detected, the reset occurs.
> > > > =C2=A0	 * See the datasheet, page 70.
> > > > =C2=A0	 */
> > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
> > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> > > > =C2=A0	if (ret)
> > > > =C2=A0		return ret;
> > > > =C2=A0
> > > > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
> > > > +	ret =3D regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> > > > =C2=A0	if (ret)
> > > > =C2=A0		return ret;
> > > > =C2=A0
> > > > @@ -509,18 +521,19 @@ static int ad7768_buffer_postenable(struct ii=
o_dev
> > > > *indio_dev)
> > > > =C2=A0	 * continuous read mode. Subsequent data reads do not requir=
e
> > > > an
> > > > =C2=A0	 * initial 8-bit write to query the ADC_DATA register.
> > > > =C2=A0	 */
> > > > -	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT,
> > > > 0x01);
> > > > +	return regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT,
> > > > 0x01);
> > > > =C2=A0}
> > > > =C2=A0
> > > > =C2=A0static int ad7768_buffer_predisable(struct iio_dev *indio_dev=
)
> > > > =C2=A0{
> > > > =C2=A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> > > > +	unsigned int regval;
> > >=20
> > > Intention could be more clear by calling this "unused". Otherwise, it=
 can
> > > look
> > > like a bug if you don't fully understand what the comment below means=
.
> > >=20
> > > > =C2=A0
> > > > =C2=A0	/*
> > > > =C2=A0	 * To exit continuous read mode, perform a single read of th=
e
> > > > ADC_DATA
> > > > =C2=A0	 * reg (0x2C), which allows further configuration of the
> > > > device.
> > > > =C2=A0	 */
> > > > -	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > > > +	return regmap_read(st->regmap, AD7768_REG_ADC_DATA, &regval);
> > > > =C2=A0}
> > > > =C2=A0
> > > > =C2=A0static const struct iio_buffer_setup_ops ad7768_buffer_ops =
=3D {
> > > > @@ -563,6 +576,20 @@ static int ad7768_set_channel_label(struct iio=
_dev
> > > > *indio_dev,
> > > > =C2=A0	return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static const struct regmap_bus ad7768_regmap_bus =3D {
> > > > +	.reg_write =3D ad7768_spi_reg_write,
> > > > +	.reg_read =3D ad7768_spi_reg_read,
> > > > +	.reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
> > > > +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
> > >=20
> > > The bus read function is calling be32_to_cpu(), so we probably want t=
o
> > > remove
> > > that or change the default here.
> > >=20
> > > > +};
> > > > +
> > > > +static const struct regmap_config ad7768_regmap_config =3D {
> > > > +	.name =3D "ad7768-1",
> > > > +	.reg_bits =3D 8,
> > > > +	.val_bits =3D 8,
> > >=20
> > > Should this be 24 since the largest registers are 24-bit?
> > >=20
> > > Another option could be to just use a regular spi_*() API for that
> > > register
> > > instead of regmap_*() and avoid trying to do something that regmap do=
esn't
> > > really handle.
> > >=20
> > > Or we could possibly use regmap_bulk_read(), but that feels a bit hac=
ky
> > > too
> > > since it isn't actually how that function was intended to be used.
> > >=20
> >=20
> > Hmm I might be missing something but looking at the register map, It se=
ems
> > we do
> > have 8bit registers? We do have values that span multiple registers (3 =
for
> > the
> > 24bit values) and regmap_bulk_read() should actually fit right? I mean,
> > looking
> > at the docs:
> >=20
> > "regmap_bulk_read() - Read multiple sequential registers from the devic=
e"
> >=20
>=20
> Isn't regmap_bulk_*() for reading a value spread in sequential registers,
> like the offset calibration (registers 0x22, 0x23 and 0x24, 8 bits value
> for each reg)? For the ADC data (0x2C) we have a 24 bits value in only on=
e
> register, so I beleive this does not apply.
>=20

Ah got it. I failed to see that. Yeah, in that case you're right... it won'=
t
work out of the box.

> > But I do agree that what we have right now does not make much sense. If=
 we
> > need
> > to do
> >=20
> > len =3D (addr =3D=3D AD7768_REG_ADC_DATA) ? 3 : 1;
> >=20
> > for supporting regmap, then I have to question using it. Also note that=
 we
> > have
> > things like gain and offset that are also 3 bytes which means that our
> > custom
> > read would need to become more questionable if we add support for it.
> >=20
>=20
> For those cases the regmap_bulk_*() works.
>=20
> > Jonathan, did you tried to use plain regmap (without the custom bus)?
> > Assuming
> > bulk reads work, I'm not seeing an apparent reason for the custom bus..=
. I
> > would
> > also suspect that if bulk reads don't work out of the box, providing a
> > regmap
> > cache would make it work but relying on implementation details is not a=
 very
> > good practice.
> >=20
>=20
> Yes, i tried and only works for the register with 8-bits value. David
> suggested using regular spi_*() functions for the unsual registers with
> 24-bits value, such as the ADC data (0x2C). That is the only way of
> having the default spi bus interface using regmap. Otherwise we should
> drop the regmap.=20

Yeah, might be better to do plain spi for the unusual registers rather than=
 the
custom bus. But no strong feelings on my side...

- Nuno S=C3=A1
>=20


