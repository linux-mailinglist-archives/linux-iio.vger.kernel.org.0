Return-Path: <linux-iio+bounces-17534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0F7A787E6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 08:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AF916E36E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 06:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4A4230D35;
	Wed,  2 Apr 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgBiqayY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC446230BE3;
	Wed,  2 Apr 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743574235; cv=none; b=IvLcVhi/a9U+Zo/xlzaSTtYqTLrJs1dV58tmo3IMl+LjcjlAQ7ihpm2jh7J/UUuuGOfBOX85BUHo7haoL/9uaCXcbjPNRYdFoLR2t0NfqxlMgtvx/OD/FNHXcdBzp4NuUnheU7/LlPwAjtsUhhsRcT9Vs/38gDzPfLBzyhTU59E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743574235; c=relaxed/simple;
	bh=qcJYs/4Hq/T5cxfjGUwALW1qfxveSrmKWWWjVClELts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuQe4zyozJtMB8THCzcwxaHufBw4lB1ZXXs4a5TdQI3GPWKWABE9v68sLfy1PAenzDixgaeykHAktTvrhzNAphBWT6xbKXrVTlqYungeeeHmh6upCVdKntq9cana0D9s5SvYwZnmbRbCVdOYaeMMErrOcgg94437QxUvnrXhj1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgBiqayY; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so61566551fa.1;
        Tue, 01 Apr 2025 23:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743574232; x=1744179032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fUyGCDgTIMq1vHv/uBEeZiyDV2WeO50QuM/4Ssw5Y0=;
        b=jgBiqayY2CJIfscZTkAYvQj1HwmHS2jeNFvI6t8bWxd0ZkxsXpoVbX7cCqbvxfmt3/
         LuIr2SDdjth8HS0viRb70gpgaL484VI5L3qo38TRwVs0VoQJbl5lE/EpnmrcHht57+WW
         h7YW4nxdZgKFR9jl83dcveVg24jSusVp+WREbr1GTfeslUmdpJNbxWFeBnxLa1CQ5OOT
         acKxH7qyjr3e74Vdnxh8EZoYwKS/wv932A7k7wpgnarognrhwIooItDXgINqunuQLS8m
         hOTid+JzTYuGjoA3YiSMRrGVkbd2gf7u9cTeRiuU9AuVrklGbIudv1+/S34uK6renHVI
         QCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743574232; x=1744179032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fUyGCDgTIMq1vHv/uBEeZiyDV2WeO50QuM/4Ssw5Y0=;
        b=e7aG3Xsiz3Xslt8pRKKoSxIWL3YlJRtfTBfAMfQ6zmeFEbqoZcbRyirxIFSIsipo/B
         Sou1hPnYi0qafZ598d7rq0FI/nlsijSCpFD12zeQ54qjKxo3lISFflm2ts5UC2nesEtn
         wh56OWbJLf4b8TKnEiXSX6d050tiJkx3Q54tX3XAzRYJLcXPNJX7CfZtR8sxOSvWqA4e
         GLDTbwNbGHVoYj7Tus8jMbh+76yswYnWwpmOFMaSBuhv/PWSxcVOwl+dh6D0fgWu+Zbf
         jmTBzVnEpQphuy6wnu0c9UhAiw6p2S2/Tn3AD6AN8ogiep67AqmqcdGVlw+m64lLxowA
         zRiA==
X-Forwarded-Encrypted: i=1; AJvYcCW1UkCQtQGY2eNWLjPqisl7+WMo8Db/8aSdXBpusgUq+6fxHNDm0Z+PKIzNNuWtnznYS1BOg5/baFZjoj7s@vger.kernel.org, AJvYcCWw5+EbxxGHQeN8/kGrIvwSxfcFxBlPFRfUGydK6bHauEEsmYoWzE4LG1O8+i8Q7wn9geAHNls4BWBZ@vger.kernel.org, AJvYcCXwM2amzlyHPyTvatTXPzEJqlcO5hNK8/KUMQhFXpHUyk3wHfY0EDSI4JVVMRmE39dd0x947KgbLq5/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8A+c1yP/nVNB6cIkKPhWHt98LNAw1MHb8Im3lYH/IyvWruz35
	7mTufhNZzKfdcNQuk9Ovccfu6c09tHIT/JS1DGykSbOuFAvL/yMT
X-Gm-Gg: ASbGncvp6GNUPaVSweiCadiN1i31+Q4SpA+qrGkY348PZAz1CJl5KrBQluyeUGKuiZi
	ZfOImAcIMAJcmt6R+EWH2UFdZ7bfL3apnw7U6heEYOWUEMeqTon9udIIlBtJ9UEXfGnFZuG0Uy5
	Lb5jbHBOLB7fI2v0RRxdFdjOqsLb2jePoOSq3eYXyNUgSYaVHlu9Y76unGZbJ9pexcGoZwbNQSc
	2Q7tAjxA7iFDX5GqufUiFfGhVqLpUOUCBekHruP8nr12xC0Bd6D14KgpStru5uWS5tEUsSzTb8f
	cWNqqIB0KxumYjqFHuHkj26cretExhp5jXPMdR0eXIkdNpGiEAs=
X-Google-Smtp-Source: AGHT+IFX0i6FSzyQZNr7Cp4HiiSW0eBgqIzbUjiWR0MHJ+Mx0aHmKcX043y8sFIbR55tLnHzLH7o7Q==
X-Received: by 2002:a05:651c:212a:b0:30b:f42b:72f6 with SMTP id 38308e7fff4ca-30de034a374mr55127891fa.32.1743574231622;
        Tue, 01 Apr 2025 23:10:31 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30dd2ad3cdfsm19169761fa.54.2025.04.01.23.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 23:10:30 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:10:26 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 7/7] iio: ti-adc128s052: Drop variable vref
Message-ID: <dda9e0710a9293a9f52e64c092f79afd4b719536.1743573284.git.mazziesaccount@gmail.com>
References: <cover.1743573284.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDhnfkxg75gPcpNP"
Content-Disposition: inline
In-Reply-To: <cover.1743573284.git.mazziesaccount@gmail.com>


--qDhnfkxg75gPcpNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

According to Jonathan, variable reference voltages are very rare. It is
unlikely it is needed, and supporting it makes the code a bit more
complex.

Simplify the driver and drop the variable vref support.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
Revision History:
 v2:
  - New patch
---
 drivers/iio/adc/ti-adc128s052.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s05=
2.c
index 0f93c6266527..0bfe4e558c69 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -29,13 +29,12 @@ struct adc128_configuration {
 struct adc128 {
 	struct spi_device *spi;
=20
-	struct regulator *reg;
 	/*
 	 * Serialize the SPI 'write-channel + read data' accesses and protect
 	 * the shared buffer.
 	 */
 	struct mutex lock;
-
+	int vref;
 	union {
 		__be16 rx_buffer;
 		u8 tx_buffer[2];
@@ -82,11 +81,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
=20
 	case IIO_CHAN_INFO_SCALE:
=20
-		ret =3D regulator_get_voltage(adc->reg);
-		if (ret < 0)
-			return ret;
-
-		*val =3D ret / 1000;
+		*val =3D adc->vref / 1000;
 		*val2 =3D 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
=20
@@ -156,11 +151,6 @@ static const struct iio_info adc128_info =3D {
 	.read_raw =3D adc128_read_raw,
 };
=20
-static void adc128_disable_regulator(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int adc128_probe(struct spi_device *spi)
 {
 	const struct adc128_configuration *config;
@@ -184,17 +174,10 @@ static int adc128_probe(struct spi_device *spi)
 	indio_dev->channels =3D config->channels;
 	indio_dev->num_channels =3D config->num_channels;
=20
-	adc->reg =3D devm_regulator_get(&spi->dev, config->refname);
-	if (IS_ERR(adc->reg))
-		return PTR_ERR(adc->reg);
-
-	ret =3D regulator_enable(adc->reg);
-	if (ret < 0)
-		return ret;
-	ret =3D devm_add_action_or_reset(&spi->dev, adc128_disable_regulator,
-				       adc->reg);
-	if (ret)
-		return ret;
+	adc->vref =3D devm_regulator_get_enable_read_voltage(&spi->dev,
+							   config->refname);
+	if (adc->vref < 0)
+		return adc->vref;
=20
 	if (config->num_other_regulators) {
 		ret =3D devm_regulator_bulk_get_enable(&spi->dev,
--=20
2.49.0


--qDhnfkxg75gPcpNP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfs1NIACgkQeFA3/03a
ocVttQgAmVe5HHdtdr/F1K/yw6zZKUV8NnbNR0VtujtoJPW5aDMAZJdYJM+KMloK
6CHx4h17zJNvWzGQmh4To9/awzWJX6icRrX9KQKvWIaK5Y58L8kau8yziYYMBGAA
V5MUlaRECOB0dYq7vpX38272YIw/iuVZXx0P4MTsUBojvh0q1pxhPo94IFwPUn+v
iZ/axjL/205aAQN+QvVwGPM7dM2p2i/4tnMcaRepSeKJxyepgxg2R6sj3F6dU3yf
6VqKRtpcs9MZEKBRkOIyrMRdm8ulVkCxnnP8OGGZnW6p3R+DPZonz4Jr6WPLT8bV
k2yMvuU5Up6jqH31udihwTs10sJqXw==
=AkFf
-----END PGP SIGNATURE-----

--qDhnfkxg75gPcpNP--

