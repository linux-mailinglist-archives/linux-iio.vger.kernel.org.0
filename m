Return-Path: <linux-iio+bounces-22552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE6B20257
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 10:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAAC18C030E
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722D72DCF4D;
	Mon, 11 Aug 2025 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3XYuLpL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10B2DCC01;
	Mon, 11 Aug 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902351; cv=none; b=QIHRjUbplEjaNKgdP1JgjnTLds2FCLexM+jI2UFp9MH9AzuEX5fYc266KrxgB7qMmlYnG7kQXt4bMt1c1YaTO9cxXOWiR2yxdkjqVNQPBTtj5vu3CGdcQpEMcDOONR7vTvAJ8+1JgIpN4vuql14iVi0Je2oxDyAv/Lc1+p6uk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902351; c=relaxed/simple;
	bh=Hlk8EN9xbDmm1NtQet78oN3FUB+0fZJLpIJYQ3dp5Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvQBfTULeKWsQx5qYMZqIMKNJW+YwM6tEe61hWaIod0KFXtln7FmpYZWgL25WkTP+eAqhNjuMkYrId3LD/qY1G2jXs+VhIkBKPHnBHerH1TyDkgfnZYKyzB5ORLNQ6qqwD0qe5f27X1qnBEoMC/5P8HuS9n2QNZW5LmWXASOlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3XYuLpL; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3323d8e0ac4so30487491fa.0;
        Mon, 11 Aug 2025 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902347; x=1755507147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DB3BeAtydk6NyVA5ErhHYanuAqOo1ZV9Uz6jX0sM5PM=;
        b=H3XYuLpLC2hhh56tVTtfgvDSk29kh3lswBI7QtBdo3VhXPoP5hEXEfs+o8KL4/cPXD
         9o1s1LZy838wTnAJ/zJatRleDUr1Vccq05+R2tkXDJPh+9qzO93QwpiVF8dIdxbRCiL+
         t120MMtkct5nw+w2u57XSQ3v26+yHM7u+LrjoJQrOn2QjA8ifaBu0OGsPewwlQtdyuK0
         A0++E62IEHTcDcKaO6Y+KousmE+0uL0xPQSxO3PfVQsj7ycBrZc4o4IBCF1jOf/6iAqe
         1SsMBw9OV0EbeqVrDCO6FG7oTSSE3UlBaepky+iKyLjvc2oTJLSIzuiGAjnfaOVnVDXp
         qCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902347; x=1755507147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB3BeAtydk6NyVA5ErhHYanuAqOo1ZV9Uz6jX0sM5PM=;
        b=ssUBHTPgp3L2rX1e1AyKvLgOALVX0hl0ACHHa+/DS7TEAMD8k4o93WD6MIY0xxjQqJ
         YdWCzl8dazWLpkOvidTslXUUPwS4Rat3AJyU82rdEG8WR4ZNXo172a6oWriZuQbE69HA
         t7ZgxRHwFqo5JbMJ8EjaAZv2bPw++PD2w5Ql2YZ35Wooyq1c5UGpkuYgP2ggVofrF563
         eGls313frLFSe+isIwZOpezTO8k/68f2nXVmwVljhlpryCzVVypbE0LDq3DvE8PiTrxe
         pyQ+kOZzEsUuYd0m4QXqzf3beBoU43gJ4uuQrqTIxL+HmzZ/WbXWpLGcTqvepUBeBz9x
         Ku9w==
X-Forwarded-Encrypted: i=1; AJvYcCVJRLv8iTZq/b/c7u/3sxTwOQd/b6riO3AEb46LCJgCt75q70dWPUKAlFLpmT6Wt4GTFDYjuqAEaOUAAmtI@vger.kernel.org, AJvYcCVo5qPPGcGNGi/r0q0OdxzYcwonpFJrtSipdAShIAHb6J6DYFkKV3Rmbhd9lVtMbI6f9x6QrpJwPlo2@vger.kernel.org, AJvYcCW+e1Z/RFbUr/VyUKZHKSolCkd+FrwpsbxQPjdNn0sRA1PZJlYo2OMj+Lg7seGGp2L7eGKTho5VMk2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxNyUUd8CCgOcb/LnBilWWWQsdx6swYZ6jjhsdyYCVcHDeSnOEQ
	5zNIA4HCEvC70VuFl4b/TJNvAle7gtFjRIZc2g58MeK1IhC/NFYWSNMr
X-Gm-Gg: ASbGncvMJeY/BpHdtUW8lIPppcstdMFykCAvhkj6pL7ULdrwRCQE9Ftos1XCGa2p4dO
	0fEUF7iyHeSaRESDY226nHmxQelCHnuAfP6T6+w/AkWyK3tyOVJuJUwXS/WQ1Kv1r9RaadG3zfs
	Sj/1qxf4JnbukrpkYG8pA5OmX82sPW+6q+fSI5FOT8ARWklTwLtau77AGYoW2cZmXMJHrd4BO2P
	aW81Jyn3/Wf/hU1PCVYmquqrlqe9JsOiuat81l0723JmNtM4UmcOy57/zV20QGeRzhbsQxYiWqA
	XvzKtKPU+Uas+KwBcriCdk6e8/hJZec9uHFTPggp93Uq7SckeUqmL3krjL6k+bqfT2vF4cGB/Mn
	CcBQMiGAFu7IW/TK62OeOwVEfJ2Dp
X-Google-Smtp-Source: AGHT+IEZFg7RnyOTDfA2GqlcQAo7ojCz6fPWEKe+9TJ8SdS9A9eoZiRhmfixQUFoP6gvu2ntmDrogA==
X-Received: by 2002:a05:651c:4103:b0:332:631e:42ff with SMTP id 38308e7fff4ca-333a213bc16mr15254391fa.13.1754902347254;
        Mon, 11 Aug 2025 01:52:27 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332624953b1sm33197611fa.80.2025.08.11.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:52:26 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:52:22 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <6ee06d551256db9213ccbe72f44cfe9452717716.1754901948.git.mazziesaccount@gmail.com>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uNvoIjZaMUqxG5XO"
Content-Disposition: inline
In-Reply-To: <cover.1754901948.git.mazziesaccount@gmail.com>


--uNvoIjZaMUqxG5XO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.

The BD79105 has a CONVSTART pin, which must be set high to start the ADC
conversion. Unlike with the ad7091 and ad7091r which also have a
CONVSTART pin, the BD79105 requires that the pin must remain high also
for the duration of the SPI access.

(*) Couple of words about the SPI. The BD79105 has pins named as
CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
ISO.

DIN is a signal which can be used as a chip-select. When DIN is pulled
low, the ADC will output the completed measurement via DOUT as SCLK is
clocked. According to the data-sheet, the DIN can also be used for
daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
'data-ready' -IRQ. These modes aren't supported by this driver.

Support reading ADC scale and data from the BD79105 using SPI, when DIN
is used as a chip-select.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>

---
Revision history:
 v3 =3D> :
 - No changes

 v2 =3D> v3:
 - Check for missing convstart GPIO at probe.
 - Use indirect call to convstart (via function pointer) also from the
   ad7476_scan_direct().

 v1 =3D> v2:
 - Fix the conversion delay for the BD79105
 - Drop unnecessary GPIO check from the convstart disable
 - Drop unintended whitespace change
 - Fix spelling
---
 drivers/iio/adc/ad7476.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 6cb2cbeafbd3..1bec6657394c 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -32,8 +32,10 @@ struct ad7476_chip_info {
 	struct iio_chan_spec		channel[2];
 	void (*reset)(struct ad7476_state *);
 	void (*conversion_pre_op)(struct ad7476_state *st);
+	void (*conversion_post_op)(struct ad7476_state *st);
 	bool				has_vref;
 	bool				has_vdrive;
+	bool				convstart_required;
 };
=20
 struct ad7476_state {
@@ -64,6 +66,18 @@ static void ad7091_convst(struct ad7476_state *st)
 	udelay(1); /* Conversion time: 650 ns max */
 }
=20
+static void bd79105_convst_disable(struct ad7476_state *st)
+{
+	gpiod_set_value_cansleep(st->convst_gpio, 0);
+}
+
+static void bd79105_convst_enable(struct ad7476_state *st)
+{
+	gpiod_set_value_cansleep(st->convst_gpio, 1);
+	/* Worst case, 2790 ns required for conversion */
+	ndelay(2790);
+}
+
 static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
 {
 	struct iio_poll_func *pf =3D p;
@@ -81,6 +95,8 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  =
*p)
 	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
 				    iio_get_time_ns(indio_dev));
 done:
+	if (st->chip_info->conversion_post_op)
+		st->chip_info->conversion_post_op(st);
 	iio_trigger_notify_done(indio_dev->trig);
=20
 	return IRQ_HANDLED;
@@ -103,6 +119,9 @@ static int ad7476_scan_direct(struct ad7476_state *st)
 	if (ret)
 		return ret;
=20
+	if (st->chip_info->conversion_post_op)
+		st->chip_info->conversion_post_op(st);
+
 	return be16_to_cpup((__be16 *)st->data);
 }
=20
@@ -273,6 +292,22 @@ static const struct ad7476_chip_info ltc2314_14_chip_i=
nfo =3D {
 	.has_vref =3D true,
 };
=20
+static const struct ad7476_chip_info bd79105_chip_info =3D {
+	.channel[0] =3D AD7091R_CHAN(16),
+	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
+	/*
+	 * The BD79105 starts ADC data conversion when the CONVSTART line is
+	 * set HIGH. The CONVSTART must be kept HIGH until the data has been
+	 * read from the ADC.
+	 */
+	.conversion_pre_op =3D bd79105_convst_enable,
+	.conversion_post_op =3D bd79105_convst_disable,
+	/* BD79105 won't do conversion without convstart */
+	.convstart_required =3D true,
+	.has_vref =3D true,
+	.has_vdrive =3D true,
+};
+
 static const struct iio_info ad7476_info =3D {
 	.read_raw =3D &ad7476_read_raw,
 };
@@ -332,6 +367,9 @@ static int ad7476_probe(struct spi_device *spi)
 	if (IS_ERR(st->convst_gpio))
 		return PTR_ERR(st->convst_gpio);
=20
+	if (st->chip_info->convstart_required && !st->convst_gpio)
+		return dev_err_probe(&spi->dev, -EINVAL, "No convstart GPIO\n");
+
 	/*
 	 * This will never happen. Unless someone changes the channel specs
 	 * in this driver. And if someone does, without changing the loop
@@ -401,6 +439,7 @@ static const struct spi_device_id ad7476_id[] =3D {
 	{ "ads7866", (kernel_ulong_t)&ads7866_chip_info },
 	{ "ads7867", (kernel_ulong_t)&ads7867_chip_info },
 	{ "ads7868", (kernel_ulong_t)&ads7868_chip_info },
+	{ "bd79105", (kernel_ulong_t)&bd79105_chip_info },
 	/*
 	 * The ROHM BU79100G is identical to the TI's ADS7866 from the software
 	 * point of view. The binding document mandates the ADS7866 to be
--=20
2.50.1


--uNvoIjZaMUqxG5XO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiZr0YACgkQeFA3/03a
ocW7zQgAwvN3MfIpVIv7x+hKqz0SV55BiyvCyosnqX7O2AoKcaa/oPJiCVbbiw4+
w0i8Y2MtNzP1dCTESL75QDcmmiWEpHG162Rpmn/IG+LuLpgnCpUoj7IP/CPbUYJd
a4CNhtbKJHS1vooZzYi1s1gSD2kHBkVqTEDB8nrsE+Grzm2u0bnPLB385VtqB+fE
uLrPbuTLWTNw4x4LBdTo39jOS+aidKIUNjHArGlbvgDBr3yBNt2IpQNHXFXzA3Bx
FeZHgrLDwwupWXDDlldRn6ch5HIWkkGhzb+9D2lES8IQqiDjUr/+XAuGV92f4vLf
tjvBiaxSY4aMCUmjoqj+HLTng43ugg==
=oGMs
-----END PGP SIGNATURE-----

--uNvoIjZaMUqxG5XO--

