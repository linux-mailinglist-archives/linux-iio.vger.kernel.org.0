Return-Path: <linux-iio+bounces-22432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37DB1E53C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 11:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C388816C4D9
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEED26E15D;
	Fri,  8 Aug 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmAVN+Wt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91D268C73;
	Fri,  8 Aug 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643110; cv=none; b=Z/F6/4DwBRbMX3rkzE7pO57UsnoMAbCron+JQ6TkpmdCrhVszE7Lfn2rFnIU7TeFelW2EtoqrSleLhm6rTo5E8gsViI022UBxuTPMVBHtrRAA/1CjOAtIqlMwi482wWdK4hJbGXR6oHv7lgIM/HCIA3C54FgguzIP5JFCKmYHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643110; c=relaxed/simple;
	bh=0m0hKxLzTdzkDYBIBlYlTeudZELSlrRSc04taSSYqEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfF0WyK55atrEqKXbiOhk2/awIyo6snIeKwAyNhAaAUntpwRTkoIwS+I+n8VZGQ08pmcSkMkXtCXyaZZKE0kOBAoyInvNM4xbHS6lJCLDhwxUWQbGMLR8Kd2TiZT9nmS4FxJnL9puTwLYTswapAwIS0nROuT3dpFznT97eB6kkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmAVN+Wt; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso1943258e87.2;
        Fri, 08 Aug 2025 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643105; x=1755247905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bc2SZUvYGAJAUUUWD4PqsS9pm2C4LFST32f4fyynuTA=;
        b=kmAVN+WttRixgCZZvWB0QVaj4XhmmrhU00HP3ifwNHafZmPEGr3Dbxf6VI+f9STSBC
         97npm4JIf64Z8nDq3kKszqfll4sFhloTGbFC3SrhwC0qXx75mYw4AftZTcBlU8pQp25H
         QnfTVEfEkzHl1+HQfEgf3g37Ofdt532X6Qfhz8/J7YCCqEyXsdhr5UsxOWK1QmWi+iTz
         JwGXv/QUAZCuobH1Lkx1MJ5oBHmJwCObMpO7WbgQeCI5TIApU7cDGA9KTRndotUZfKMG
         T8WqbrXlDsQ3zl26x5mB+sYyi+z83AMoZkkz8lh2kOUUqhDgXEdiD4hU5r5rTA0lshFa
         VvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643105; x=1755247905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc2SZUvYGAJAUUUWD4PqsS9pm2C4LFST32f4fyynuTA=;
        b=H8jWleaLcbaMzblVJbiCuzAS0oHjLZuylcjTiDfZsMpk45rIlf4sP5RLtmQAYsRKiU
         seVjEQBs3UySxdZ7EXD0TC2kfOhGxyJ1eSVVLa28sVwy3Q3KwMd1SkPVihtSfX5X4v7L
         k6PPQ/9VqncjP0giFZpzy2VMoOJDJaBpPzkQ2pjCnMpbenW0CBDRB3iXuCJsZ9Q1xFb6
         F7Bytgl84PX+TPONUd08XPOiVqUZegLTc+Ou2Jo0OCwyHGuPio6G85Irz20HX3ISDrqm
         GOtzkHHD973zdC+2m1nvMniwfJN0TyNyeW932YUEVxsIQbisQ+CJKcc4fgYBm3jBtCdB
         rtoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsznac/Rrah9mZlK4Mgk30WUowp++ykmvsdTdpl+upH2kdpP+xLnPk1WOzOhrfzGSenkrSIkz0xWu8+xJq@vger.kernel.org, AJvYcCX2rkGWTwDosPb1/jciTCmYRU/So2/mcA6U26tBxfvOtW1SJ2BfDe7KloOraVnzkMXAAvj8KjEAZ+kQ@vger.kernel.org, AJvYcCXuPuz7n6W5esYxZAV/xfviLSQebDygi07/uksqySCqdFLRdz2F7xZsgrqVcY4rhuO8egCKO2eKlL6A@vger.kernel.org
X-Gm-Message-State: AOJu0YyNLvZvw1+PI4ouO4wBGY5KW0nYtF6TPVS/CpljrSjuUEg48mfF
	Khok58VIj7koZMyFOZzUHXqgQ7SgODGhLPCGir0nY2YIQIoaHGEv1YGt
X-Gm-Gg: ASbGncupnFNAptfayJ+4D7H7jD+0FdeTNSA/UOq1V73yz7mvcyNjcNhnV+F7namO43p
	Tz6qvyjrCD83E5WDxgPscaznaJUym589deiGcrgcohr2a5SR3Zr/3JS763ieJjqNzCb3o1V8o6P
	cvTZDlO5LzJOLFHwkOTyuY3MDI3n3AM+pIfMpfO6PVhEpA6YtsQYPhk87EE6Wf9edAY4UhbQ5u0
	R4VMv05ltfZByOa2tyHADfO6UPBhp2FkQd9fwFLJT4y2itA39D1ZYlouA2sTk2pHz0cHVkPTnQE
	h2SHIGoqLnLzjirsyXZNqfV0CFOWCDEhBONQwv7clIzizSO5fFfHlRQjIPkfJG+wuFopq7Ill9D
	vEJ9zh4+Mc5252tXPaJULaqg+6ecE
X-Google-Smtp-Source: AGHT+IFqzcRq4VVkEu+exCO4BNgSeLHEU9yVzn85s2o4vFUGFMe6G0VEL7yMxmECfN6o1ywNkq/WSw==
X-Received: by 2002:a05:6512:b82:b0:553:37da:2bad with SMTP id 2adb3069b0e04-55cc0127ed4mr500626e87.38.1754643104761;
        Fri, 08 Aug 2025 01:51:44 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332388fc7b8sm28453541fa.62.2025.08.08.01.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:51:43 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:51:40 +0300
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
Subject: [PATCH v3 03/10] iio: adc: ad7476: Use mV for internal reference
Message-ID: <c09da07693059ebb5392fd4c19c83d0a162d5ee5.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cVstOuumvj/F2loe"
Content-Disposition: inline
In-Reply-To: <cover.1754641960.git.mazziesaccount@gmail.com>


--cVstOuumvj/F2loe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports some ICs with an internal reference voltage. For
those ICs the reference voltage has been hard-coded as micro volts, but
the value which is later used in code needs to be milli volts. This
results the need to divide hard coded voltage by 1000 before using it.

Simplify code by changing the hard-coded voltage to millivolts and by
dropping the division.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
---
Revision history:
 v1 =3D> :
 - No changes
---
 drivers/iio/adc/ad7476.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index f117aafd8fad..7b6d36999afc 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -27,7 +27,7 @@
 struct ad7476_state;
=20
 struct ad7476_chip_info {
-	unsigned int			int_vref_uv;
+	unsigned int			int_vref_mv;
 	struct iio_chan_spec		channel[2];
 	/* channels used when convst gpio is defined */
 	struct iio_chan_spec		convst_channel[2];
@@ -172,7 +172,7 @@ static const struct ad7476_chip_info ad7091r_chip_info =
=3D {
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
 	.convst_channel[0] =3D AD7091R_CONVST_CHAN(12),
 	.convst_channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vref =3D true,
 	.reset =3D ad7091_reset,
 };
@@ -229,7 +229,7 @@ static const struct ad7476_chip_info ad7475_chip_info =
=3D {
 static const struct ad7476_chip_info ad7495_chip_info =3D {
 	.channel[0] =3D AD7476_CHAN(12),
 	.channel[1] =3D IIO_CHAN_SOFT_TIMESTAMP(1),
-	.int_vref_uv =3D 2500000,
+	.int_vref_mv =3D 2500,
 	.has_vdrive =3D true,
 };
=20
@@ -295,7 +295,7 @@ static int ad7476_probe(struct spi_device *spi)
 		return -ENODEV;
=20
 	/* Use VCC for reference voltage if vref / internal vref aren't used */
-	if (!st->chip_info->int_vref_uv && !st->chip_info->has_vref) {
+	if (!st->chip_info->int_vref_mv && !st->chip_info->has_vref) {
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
 		if (ret < 0)
 			return ret;
@@ -310,7 +310,7 @@ static int ad7476_probe(struct spi_device *spi)
 		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
 		if (ret < 0) {
 			/* Vref is optional if a device has an internal reference */
-			if (!st->chip_info->int_vref_uv || ret !=3D -ENODEV)
+			if (!st->chip_info->int_vref_mv || ret !=3D -ENODEV)
 				return ret;
 		} else {
 			st->scale_mv =3D ret / 1000;
@@ -318,7 +318,7 @@ static int ad7476_probe(struct spi_device *spi)
 	}
=20
 	if (!st->scale_mv)
-		st->scale_mv =3D st->chip_info->int_vref_uv / 1000;
+		st->scale_mv =3D st->chip_info->int_vref_mv;
=20
 	if (st->chip_info->has_vdrive) {
 		ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
--=20
2.50.1


--cVstOuumvj/F2loe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiVupwACgkQeFA3/03a
ocU7uggAoRiPHC2wByQr+p6RN1N60W24aCAwO3WQzetKKL++xTTZ5uW865wuAjz3
W0KPwY9slw0ZzP7zSNPNi1w7Nugyfmv5jx2nLKb+BHAFcIrf9iv47eaJ6uMhN/Ih
bAgML2dKheCSiKOhcIbXXOLPST08Ziq14gNz/dl6W/GitYbrcHHMY+kWPqUYY4wg
/dte8p+/Eu+yNiOZFci7Yy2YDIolpiqokWNIPWM/sfX9D8I3HnQKwn05MM1z58ww
RlT7pNJhT9XxEysQ8kd0SCe/LX3XYlLOWu+akvlmqE44APr8cLD02rldb0WIQvNX
dDROymkg7+FDtN8HM3WxiFo5YYXieA==
=dMSd
-----END PGP SIGNATURE-----

--cVstOuumvj/F2loe--

