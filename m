Return-Path: <linux-iio+bounces-22324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D2B1C0EC
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6895916CA9D
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E621171D;
	Wed,  6 Aug 2025 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlBwQuL4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6E219E98C;
	Wed,  6 Aug 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463831; cv=none; b=a9pdgikNg0e8eOqJ7yP9vlvuKK0UonYw2agHfV4JPAl3z8RTR/9rOr1B6K0U1GK/EnC8cZ/iYBpQIlGGm97IQtPehOxX4Qgn9TgRtyti1J0pqGrByXe8wQhZGBmBJ02lygyVau0+wd88qnOqqPHKsyw4bTT0YEAr7pX4OATtmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463831; c=relaxed/simple;
	bh=FA+yFniqCAIOhQue0e4ZRphBIhJMTFvFKmSbhJvYHZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsbNCvoF9RmW1XzCae7/7aKXjQ27IZhwzF5azjEM/fDyp1OoMmRqPLfKMIXayvVxiuI7tKWosnUZMkG2Ego/eev/km7tOD6LCea6zY5jwj6uhU/wORQTf/XIPCqgdTrdNw2ARNu8l9nngZ2cQ7/dmSEZu1Vw0cP6dN15N6Z+65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlBwQuL4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55b975b459aso5078807e87.3;
        Wed, 06 Aug 2025 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463828; x=1755068628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7X2Digh9r/3L3Y0yTewn7eyWNCH6B6OUcexQ92JH4Dw=;
        b=AlBwQuL4EaShGVzigbO5LLl0X4+LHVrloDaYIYgfCF8Tc0wU0i82e72PkkYwlrQcvT
         gGBjk6zVybqFXadzKbewjeos5Gr+7BIkECu2ha3nCYImKDKqSniQ+TdOsOcAsdgJ5Qzr
         R7IFVlQE/ORaXiy33j/ug4DCJ+gxEpo+Y7y8vp2bedkTG7Om7kydBoPkqOXNL2MJ/W1q
         59aQhDDrI7qlnMjbNJiJ71PEcC37NqR2YylMxT8lOeDoY5Oz3PKwKyEDO76LdRwMTyvq
         hDEu1hrxZdJRt6j7nx3zXBn3JvfJXvbLWhpIQsW/FNtvMzV72NfuIq5QFsbvxFFAnsGU
         FkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463828; x=1755068628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X2Digh9r/3L3Y0yTewn7eyWNCH6B6OUcexQ92JH4Dw=;
        b=NGYcu2+tO9RkqBsWRkHvgS0CrwLq/KeVNX804Lm9waSuqwG/wDQ3sYVrLzNXFjF9ku
         QnN2+OQFUI9BAAAVfTiqMrEOZ8KsIWd6nKnyAKVDvo6Zqm2vYLWoI1alnagd2hY6vT8m
         m711VmCrtBwHSYsdGTqjbpzjeoZyiED5IpEUp1825JvRqrO61tpdZ3I5In2QJdEpgTFU
         ICo5x3M3lDue7TgMWGYgBMcBYd/IqjKl1QK1XPbjJmHG7FQ9uVMXAm2mDt+lVDJWXZmp
         J3+9sfLgzlFvajQT7nmE8Dhb60dk0yA6u8ICo+vLIMrGYeCZdJlRKnBmduDY6tDDyp7L
         0MHA==
X-Forwarded-Encrypted: i=1; AJvYcCUf70zpUe4Ubh6sdaQmPPYAEzObpMgHYyaiwrw+adgejKyN+3cso0pBIQBKVqfNNj1t9BuLnSyos5lY7oAg@vger.kernel.org, AJvYcCUnyAqX9BxG5ofLwWPcgVSXVsDJE4pZFCKMNJ8Zjfl6+uF8l0D/uLuvUDgZbq3E2tbI0g96gSFahQ7j@vger.kernel.org, AJvYcCXwJIR5ayV9wQOfrnKuENpc1rYvtb08fJtNS2xmy4FlL2pRc4rx+kOGS9LHHl9CE0kuc+T77BpsHQyg@vger.kernel.org
X-Gm-Message-State: AOJu0YwHgOQlM87BW8ZlDJ27ClgvaBATJBgzHGWpVhhydmQWDa5Iq53M
	kH9z05mr+OLwOPVRLsKbn+83Rr3ikkc5rK98+JeVz9MZah+7XUPj9Bzg
X-Gm-Gg: ASbGncsfqLYXWl3IHTTkSCDyRQCzZXAY5GIUaqyOIu0s2CVqtpfipSFoQ794TG6Lrax
	xhnF4BViXUL2dsiTrLGmPbvkIZmXtcE4Ir45qlxWL7KF+9gUaEFaRNRZHXOY2T591mFTFx3PHVd
	j380TB7iexJR6Oey8XNNmc7TAjuHjQBXOadmH0I9uEy0bOTSAP12tQGS8I6/WKqWHXfbIe8rX1q
	ZG6d1KfB9rvxAe70I4uhxvI+ih9No+iXLunJ9k5eAGo4aaqvobvKeSx995GiUdqRURHP+dvveie
	DVBssuOFz43zF0JupFglS33q1Rl57YqQl8vep+sPEwMzN7rZpKmXHsLY8AjWuHoASXE4mcEaTLK
	LwqBIHThMDHkphKcxdqd9aGNA3KlpQtrSnIBr904=
X-Google-Smtp-Source: AGHT+IFjnQUSdkiui4QE39Chc6xRm/EAnLOhZtBcni/J6FcHm8bWO18oKfxlZhreGXrv2E4tomi0bA==
X-Received: by 2002:a05:6512:118d:b0:55b:822a:3ca2 with SMTP id 2adb3069b0e04-55caf304acfmr417994e87.13.1754463827817;
        Wed, 06 Aug 2025 00:03:47 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bc7fsm2185475e87.33.2025.08.06.00.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:03:46 -0700 (PDT)
Date: Wed, 6 Aug 2025 10:03:43 +0300
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
Subject: [PATCH 4/8] iio: adc: ad7476: Use correct channel for bit info
Message-ID: <7c353ad496e0056e9fb3869bf07e7fd66d816018.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NI9ctx46G+gVAh0K"
Content-Disposition: inline
In-Reply-To: <cover.1754463393.git.mazziesaccount@gmail.com>


--NI9ctx46G+gVAh0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ad7476 supports ADCs which use separate GPIO for starting the
conversion. For such devices, the driver uses different channel
information if the GPIO is found. The bit information is still always
used from the original (non 'convstart') channels.

This has not been causing problems because the bit information for the
'convstart' -channel and the 'normal' -channel is identical. It,
however, will cause issues if an IC has different characteristics for an
'convstart' -channel and regular channel. Furthermore, this will cause
problems if a device always requires the convstart GPIO and thus only
defines the convstart channel.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
It appears that the _only_ difference between the 'convstart' -channel
and the 'normal' channel is a lack of the 'raw-read' support. I might
prefer seeing the _same_ channel information being used for 'convstart'
and 'normal' channels, just setting the IIO_CHAN_INFO_RAW -bit when the
CONVSTART GPIO is found. This would allow getting rid of the 'convstart'
-channel spec altogeher. Having only one channel info spec would also
help the code-reader to understand that the driver really provides only
one data channel to the users. Currently a quick reader may assume the
driver for some reason provides both the 'convstart' and the 'normal'
channels.

Adding the IIO_CHAN_INFO_RAW when CONVSTART GPIO is obtained would
however require the channel information structs to be mutable - which may
be seen as a "no, no" by some. Hence this minimally intrusive patch.
---
 drivers/iio/adc/ad7476.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
index 7b6d36999afc..fc701267358e 100644
--- a/drivers/iio/adc/ad7476.c
+++ b/drivers/iio/adc/ad7476.c
@@ -121,8 +121,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
=20
 		if (ret < 0)
 			return ret;
-		*val =3D (ret >> st->chip_info->channel[0].scan_type.shift) &
-			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
+		*val =3D (ret >> chan->scan_type.shift) &
+			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val =3D st->scale_mv;
@@ -345,7 +345,7 @@ static int ad7476_probe(struct spi_device *spi)
 	/* Setup default message */
=20
 	st->xfer.rx_buf =3D &st->data;
-	st->xfer.len =3D st->chip_info->channel[0].scan_type.storagebits / 8;
+	st->xfer.len =3D indio_dev->channels[0].scan_type.storagebits / 8;
=20
 	spi_message_init(&st->msg);
 	spi_message_add_tail(&st->xfer, &st->msg);
--=20
2.50.1


--NI9ctx46G+gVAh0K
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiS/k8ACgkQeFA3/03a
ocULJQgAkbrmxw74dsPL2XAUROTf1b16YE4t21z1XS3L3OwQh8Ss/kMwV7MC8ctg
8xwkRh+RbSAEBKoNOV3Yp39sQn5lDFcDOZLMSCn9LEEryJYIuYVIN05V2rposRaO
sSggaRMpDWkLsywTfOdnf1iuPNSnNNzjLTM/ElyyzkG8Be7NxvwfuLmGItaMXJAA
PUJCiYV6f5HmfYvbCyuo0h9ZjAY1EfFGKrUa29YxGoeKrJ481QKYCSb9JT6h2voa
CaG3nOrFRmxHU5GWw/zX3XQI+rjOrQeP/H1NiAdVz7OztOb5052DBCgg1qI/WNq+
ZHob1CvWEmTxti3ZC/mm8Qce1VvLIA==
=zSFj
-----END PGP SIGNATURE-----

--NI9ctx46G+gVAh0K--

