Return-Path: <linux-iio+bounces-21858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 999AAB0D509
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4802B1C24677
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951B22D9793;
	Tue, 22 Jul 2025 08:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uLjxZL7U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B812D9497
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 08:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174536; cv=none; b=ps60hS8wUizH7gGLAjUKB4QBr+VdTg/Wke+HA8T4q0PQFb+UGIMH65845H1Fi/LdNMEqZe07uszWLkYiIVUyzgVAcO0b2FuaXfVeHftyg/UXOe04ELeWd0AcmVufEoppf3IjZuSfyPW9mAgBIICBstRR1Jzp/WSvb9jyoeI7CRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174536; c=relaxed/simple;
	bh=5b8MKHVqYLr5Rggl/IWCv6wjMRmc73shJsW9k0EWJ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmPKmBNdcXh3Kvr2QKkOGMvD2VMw5O49fs1ZMO4lZjebnM+HvnuqFUd6mlhSdl89m0GkKdjLN+V6D9yPbQbI0uvK0JHPwUePbbVAzBrBB1BqnRLllqoSQe2xydiek4Rd1xcuesln6KRiEwtaZuiup2YjYMbiI6zDbuyWC7krjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uLjxZL7U; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso4910392f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753174532; x=1753779332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sWVg45QqINHNP6wsm4mft52LdlAaPExkFNIIrXJ9gA=;
        b=uLjxZL7UJbIUZKGJeAZQEPSa9WcYKhbTZFhfvs6pIeJzjh5Pgw2Ucj/+pgB0+dJxE9
         SZaQ6lZn0AbO4AnCc2Fq/uEq2SuCpwEMy91UWSfsy5JBkSN6tGI3XKFQgKUdSFITixRB
         sBSZ4yqROIUPfon/GMcp+R34e2Ap5sSN0qhdwUAiXAEmrtLwxvqw+lcYLPMz5pFp/du5
         fpsXThtK2u7IjShX9e3Fv3/Fj8ATrzwOMJuGIEI/mD5/qChlA8VQCFYhnUXAdR2Z2sOx
         +rMrS5HEz1SV0jLEarOUX61sSB2X41VvUEC/2ZlBrf2w7D4927FbtD65CAtYAwcymvhP
         Q09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753174532; x=1753779332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sWVg45QqINHNP6wsm4mft52LdlAaPExkFNIIrXJ9gA=;
        b=Ifn0iY0pLeeZV2aOMtDujw9eQQGpyj/Wdaqg+489qWH91VINXzSKZ0pkbrXh/LQe7X
         /4e+NqRagMmIUnM20fbK6Nr/u92WUT5DDOP5DX6586Vas1uJHwLN+kjcVpu/qJMGCnPv
         PFJyYd6DzhbFjllYH+Ugrcti50bI8M/I/9FOcVkI98CGTVF2UMfMcH5pQKqQjWCD0lDv
         SK3ywKo50HIi34+f8fTXKLZC5+9Kta885KXfJ1BhCYkehJCn8Y29YbVadz8+QocVM9MV
         CyWjvT7Mos6wOs7M2vocM9fY2lG0GjrYlWHBGIL3pUV+aYcDRuLIUWrjU/LREKEbZSbN
         Sgdg==
X-Forwarded-Encrypted: i=1; AJvYcCXvfVmKage+DMlRdJhmrN1dJmbSiG2w+o3glMYF1GKS0KrBQrKwjvCG5kSvbYRdVoDIjbsbH4Iv5PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Fi6Q2da3CvpjCRxqp0vu9TJZSdwAIFr1Bp4oGRCj4ZAjNN8K
	GtuYx6k4eDkw8h72cyfmFhldXKdDB5QoGS9/e9SkPd+rmpTd4TpoKNJ07XXaHwOrksU=
X-Gm-Gg: ASbGnctNq62exgF9xTKIQoy6NFbTgLnfIq29wsuMXk3e5rRrSN6ts4Rehx24ySAGJPH
	Da+gKR6p5ezkF/rMclfSaGJO+cxVAyCus0IHFjObYJI7qP2nVkKazlGIsCzyKtY01dGaZHaGsSN
	JHTucAwmrUyXy8kXEDtGNhdrfSppFZ+WVfAVekpsGLUrsPTCaGDBdM9n6HzsAzC4eim38Avi4v5
	zo1nhNwU2R+wIwOMOI//4HXU+IpPzfLvjgq5nQUPNRBvgdzgltMrDxdKeVD6IAkTksQMMzpn2ak
	dSD50Fwxw3WWUj7TjnN33chyTJ40dJfmhnEvlp2NUX/SWJ3XETI+ayTGKhud+b2/ZZMpXZ2a3uR
	kUGQV3X865GhCOLBEDOvtP68niWXhJ5LFn9/2K0n6yDDAAEksCSQG3GzNrmY6Mr5l
X-Google-Smtp-Source: AGHT+IGYVh2/WJzbDt+DN0HSbymXZFF7QPHF9pyqcII57UFno+gGw+qiIcAm0aMQ4YYQqlCvtGcexw==
X-Received: by 2002:a05:6000:22c2:b0:3b7:5a2c:f09f with SMTP id ffacd0b85a97d-3b75a2cf0dfmr6663473f8f.25.1753174531909;
        Tue, 22 Jul 2025 01:55:31 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca2b803sm12484186f8f.19.2025.07.22.01.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:55:31 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:55:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Hans de Goede <hansg@kernel.org>
Cc: Marek Vasut <marek.vasut+bmc150@mailbox.org>, 
	linux-iio@vger.kernel.org, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Julien Stephan <jstephan@baylibre.com>, 
	Peter Zijlstra <peterz@infradead.org>, Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
Message-ID: <6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lf4ecyroqrknrlzu"
Content-Disposition: inline
In-Reply-To: <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>


--lf4ecyroqrknrlzu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
MIME-Version: 1.0

Hello,

On Mon, Jun 16, 2025 at 02:42:54PM +0200, Hans de Goede wrote:
> > diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/=
bmc150-accel-core.c
> > index 744a034bb8b5..1c3583ade2b4 100644
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -550,6 +550,9 @@ static int bmc150_accel_set_interrupt(struct bmc150=
_accel_data *data, int i,
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > +	if (!info)
> > +		return 0;
> > +
> >  	/* map the interrupt to the appropriate pins */
> >  	ret =3D regmap_update_bits(data->regmap, info->map_reg, info->map_bit=
mask,
> >  				 (state ? info->map_bitmask : 0));
>=20
> AFAIK the proper fix would be to not register any IIO-triggers. This fix =
will
> avoid the problem, but userspace might still try to use non-working trigg=
ers
> which will now silently fail.

I don't have a system that triggers the problem, but there is
https://bugs.debian.org/1106411 which I guess is the same problem.

I think the suggestion to not register the triggers in the absence of an
irq would be implemented by

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc1=
50-accel-core.c
index be5fbb0c5d29..8d90802e65fd 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1687,18 +1687,18 @@ int bmc150_accel_core_probe(struct device *dev, str=
uct regmap *regmap, int irq,
 		fifo_attrs =3D NULL;
 	}
=20
-	ret =3D iio_triggered_buffer_setup_ext(indio_dev,
-					     &iio_pollfunc_store_time,
-					     bmc150_accel_trigger_handler,
-					     IIO_BUFFER_DIRECTION_IN,
-					     &bmc150_accel_buffer_ops,
-					     fifo_attrs);
-	if (ret < 0) {
-		dev_err(dev, "Failed: iio triggered buffer setup\n");
-		goto err_disable_regulators;
-	}
-
 	if (irq > 0) {
+		ret =3D iio_triggered_buffer_setup_ext(indio_dev,
+						     &iio_pollfunc_store_time,
+						     bmc150_accel_trigger_handler,
+						     IIO_BUFFER_DIRECTION_IN,
+						     &bmc150_accel_buffer_ops,
+						     fifo_attrs);
+		if (ret < 0) {
+			dev_err(dev, "Failed: iio triggered buffer setup\n");
+			goto err_disable_regulators;
+		}
+
 		ret =3D devm_request_threaded_irq(dev, irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,


But given that bmc150_accel_write_event_config() also calls
bmc150_accel_set_interrupt() this might not be a complete fix.

Best regards
Uwe

--lf4ecyroqrknrlzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmh/Uf4ACgkQj4D7WH0S
/k6j6Qf/diOY/rHVfJ8kTlouaukYXMYReN/iKL9zB7ATC6+Ye6wyWiwahTCFCE7/
oK6asU/QMWYxQDeHx8zELj97vxge3Ipwfz7564usJTxNKCE9L8+/opksOviGHI2b
jAMlwJ6bdFBN2e86UA/FhGJ5+qLfEs8x2OuTpk26jszHaEIpKnO6c4l/yF9ltI2M
N+4MMA6jC97YfvtesbBR8Etikkg2kcZMh0MQSSmdNJ+Tq5hbtdAPMksq8+CAXWXT
dzQfU3eTYgFs3wdBNuDFN1SP0U+MuiEW16kBs/uFnnGC+yQ612lFVSBkPS4BjMzr
FcWz1KF4lTYYL9UX2ytfr+8KLeYuyg==
=I4Pp
-----END PGP SIGNATURE-----

--lf4ecyroqrknrlzu--

