Return-Path: <linux-iio+bounces-22394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A455FB1D4F2
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BD7563D05
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 09:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0D226A1AB;
	Thu,  7 Aug 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i829ksI0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A4257ACF;
	Thu,  7 Aug 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754559345; cv=none; b=dhEdh+wvnZqv/HsWMZ4kf9BO359DUcCyW9jU9U7NcyphVdbRq56Khp7xr85FWQKvGdV/+JMUNDVIlozGRpBasEhzV+KaUHDw1vod7amG3IdqntM300VVYGoehuNdSqSjkzaSIm24vc+yHQKGSjqtmXKAGjt2nt3muV1cdjlQZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754559345; c=relaxed/simple;
	bh=3ZmZxda5fwI6t9T+++UojtC/Ikta8I6rVnxdF3YhgRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM+5VhTXxMOf+mE7atF07EbjFxVWTJS3Br8lf+ke26qkGJ1gVDtLjQZRFLuWjL+zNdQ7HRFV0zkO7ogtNG9J2DPSYSqHMCwXEAd7uA9jWZjaSvSLBSUpiWYnVgr1Z779l/ulyCJAaIa6zY7sC9ufnewO8G95FuLtF/0qgA0Hvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i829ksI0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b827aba01so771065e87.0;
        Thu, 07 Aug 2025 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754559342; x=1755164142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQS5hdBw6jdDe9JhXS58Gfk518osTqMd8NXHuh/iDro=;
        b=i829ksI0JFAGoQyv6uuNSvGSilUqyJAqZl3F1L6FN+q61EvqktakPwESwJinOL5EOt
         XOuiBQ02TOrmPueklsijmNg02+eTV9yhiflVZHZ7D+e13VDEhW9yC1ep0ibUkwuZjQty
         IEGe8CxH6E0nUqmqh68utNUFpX3GUNSoKQoEhKtvzSuYaEQkGbYie0y0q5+NRfQ0UIfr
         0U/+cnbvA17scmoJmyK6uM8cxk24HsEDKaIF5PZElybyDAQUILVxlChrgyewNUGs7+FB
         CO2uUF46hsVViJCGbDeIGU8ZWETDIISGTpKKnxV1ZSykXAQDz5mWmohL1OjcaCvz6DTE
         xwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754559342; x=1755164142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQS5hdBw6jdDe9JhXS58Gfk518osTqMd8NXHuh/iDro=;
        b=FOUEoODVkcLvM1pO+fZQDMDqtSVvVRb4zmy6f0UEQAriykxDJcENvR06E1v/ghbYGL
         dYq1l/DozFYl6IQRkCZ6duzxphHCPveUAQOm2GDLQUdH2PC0XDv4BYgYyZe6llkOtyeX
         rU5ycJBn83MaH7pHLGqX+osviA/LzKcTYQCSZZEHoHo9WxgW7sBwKbweUACipbmA+mty
         dtWViza7lVnIDGm0jB+S/bxNbnZ1TyuUjm0CwSzNUKRfmXRAYqK+olWTmY8T0tt4ro9y
         gqaYnqe+AbYa23M32TalU+r/gvzAu5kLFjJHOlqI7A8O50mgtksMzXmEaVEofPG7OQU6
         7+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV6co2FM6OsdWBpIqhJRRkpktdnKPz4ql/htBc0uj7TqoDfCZ7wjGJJObEcHCHpICRWgSPmD0nFWEdXpZzn@vger.kernel.org, AJvYcCVGGGBmpjUVUsnWXebx8Ad7dhubwVyAhu41oiMWRvgERmwYcTdNr/et72Fx1UQxd8mPmzv5UH6oqkkI@vger.kernel.org, AJvYcCXEXJMJ/A0tOkJirNdzgkMxwUyrMQ+ejn5QqvyCAdRBYxAbTe8ezw4plTFleC2zwskNRUO1/b3z6qtI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy841DYQTDNQm4jblKEXKSD8IAKLxMBzRwg9zfVrIef/AmI2OjQ
	xizk0ipcoq4auPNPa1PznaAb6t1BECf/TwE90bdBYGeIji3In3yg2kQa
X-Gm-Gg: ASbGncvYiE4pmQ2cJ5tIM/PdCZv9mR371i1n0airixCbLifcNbugbB6UOoDJNVdcS3k
	sqe2eltxPwS04d4sqNcZlBdODJTM0T2Hh6QiBv/oKUzVQQvm8AGwZHrByCeAmDpzeotJ8T51ydx
	AJPhvPdG1xcHmALMV2v4sAmxMLf5pfekFgnyEng4aERGaW57flIJoF6lm0oq4FmhFLthqNZN4ud
	UNV0h8c02yXRAyptFts91oT3DvQDYbGghwLb8PrI3sM9Z+GQ8+d5bqD5KwydZnfsfb9rqo9GCuK
	MoZn2R/YF13TXupPX1v9YsqI2bqThQTXmH3fAbMSP+vL9R7hUXmwsu5gqO19S0M6+jqaVH82CQx
	fYUFKoTinxes/1ZbXHFM9Cx6k++3m
X-Google-Smtp-Source: AGHT+IHwpS9xPNMbyeflY/IkeZw7hFymrnWVT43OPpHQfrsf9G7ixdFFvLxl0FqGrRVLeme0HxatMQ==
X-Received: by 2002:a05:6512:2395:b0:553:2ee0:7728 with SMTP id 2adb3069b0e04-55caf45444bmr2076994e87.0.1754559341705;
        Thu, 07 Aug 2025 02:35:41 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ba8954f0bsm1022001e87.162.2025.08.07.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:35:40 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:35:37 +0300
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
Subject: [PATCH v2 10/10] MAINTAINERS: A driver for simple 1-channel SPI ADCs
Message-ID: <008ef72e484906cf4760f99eab6bfcd7a4b3c4be.1754559149.git.mazziesaccount@gmail.com>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kEIOraG57ZNktAFU"
Content-Disposition: inline
In-Reply-To: <cover.1754559149.git.mazziesaccount@gmail.com>


--kEIOraG57ZNktAFU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add undersigned as a maintainer for the ad7476.c which supports a few
simple 1-channel ADC connected to SPI.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v1 =3D> :
 - No changes.

I'll try to keep this on eye.

I only have access to the ROHM BD79105 and BU79100g. I would welcome
anyone with access to other supported ADCs (and time, energy and the
knowledge) to join me. :)
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8c8f682edf6..36fa6333f7b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -455,6 +455,11 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad738=
0.yaml
 F:	Documentation/iio/ad7380.rst
 F:	drivers/iio/adc/ad7380.c
=20
+AD7476 ADC DRIVER FOR VARIOUS SIMPLE 1-CHANNEL SPI ADCs
+M:	Matti Vaittinen <mazziesaccount@gmail.com>
+S:	Maintained
+F:	drivers/iio/adc/ad7476.c
+
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 S:	Supported
--=20
2.50.1


--kEIOraG57ZNktAFU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmiUc2kACgkQeFA3/03a
ocUqCwgAs1dmwvRjQSh7iYhvrvM+e590DW8p7gXDISZt8rRXRu8ebrZztFD9UwLP
xmnakfPq9Tj0UX3GwzarBS020+UCL4rAPz43QQYQOxj5B68DQCQXmHLNju3QX2by
ThYNmhIwjnJWnLaP7XtnqMd79wVN5ausm3xHk5v1MR8u7ACsSoVBnSC+etRHKkYL
FzpOD281q1eROzUF9DiooqfHIJZ4Wr4PvQ6HTKJhMv6hAGiihRf7qgV2Fpo7Xha8
CKs8nO54Io7o/C4eIfAomslBRhWlSQwulwn82EGRk1pJHVEoSs0xPiNHrNAdIYk7
5OaYm6MqXZW7A5EWBDYV+sPtiYmupQ==
=b8D0
-----END PGP SIGNATURE-----

--kEIOraG57ZNktAFU--

