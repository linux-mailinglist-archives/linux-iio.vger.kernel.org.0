Return-Path: <linux-iio+bounces-13275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BFA9E8ED6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 10:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6C8163A47
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13B8215711;
	Mon,  9 Dec 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oFk6MKby"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813521507B
	for <linux-iio@vger.kernel.org>; Mon,  9 Dec 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733737039; cv=none; b=D/QHSDdT8R6UuZRfEilFnkxZMFD9fWmu2z8soKjWSZixFdqn4TrRyIYvUqsCPei6SvALVcB0U/niuqPcrn5vrerbCy0URNsrk1HdFFmx/aKo08UQag7eU8Dw8uUPrN3Ompxv1xipUiFFSpa/wZs7Z3/rKdD5joznUgv8wYktbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733737039; c=relaxed/simple;
	bh=BH8ENDFmJutZmwDlkkZZn9pICQu2i5ganG3gBpNL8P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwob+6zAZvDWNSTrD6Z7aa5Ul9T8GypaAbVRNBOWU4g9wPCJrM8dArYz2Ho7QKUbPXxdUNSzmBc3LmPhbINr96SkNkRrwxV5HphhO8BGn2IEokMWdb8XZPhkzPammu191jUMMTCdspd3dzdXh+dZhnCUFsGGHIHCuNw2yUt5giA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oFk6MKby; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434e9716feaso9243205e9.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Dec 2024 01:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733737035; x=1734341835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvRG8NcjqWA+75/lEiUfzhW/FQ36BewK4IXOxJWVejg=;
        b=oFk6MKby+gM1v+NYKgoKZKgH/25Yoi8N9a4ui2BlPQeOInVmKbzX9x19+L1uKywmTb
         dKNz5maMQTOMK9iY0iasVMeB0t+7DTuYFYxLNgZVbhrvuPBqj65wvVHWkVWIUPOqC865
         87aoCOqk3o+03+oIXWVN2koCJhr6iWBGM3/oGRcIiZp+zUaXKMCcAVuYe2A8HQ8jeqKP
         Nv+esAN5ScLIMcGWmUkKlEalsmmTMqMx8WUG3rVc+TUo6zSNgvmgMG1BLwz4WxZ2uVmH
         mib5YgXkHJQJoEATUJLThPsTgtvGrzyPc2I8Bu/mRQjIBvN9ovHJzVknvE1Q10tLZ5P7
         fOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733737035; x=1734341835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvRG8NcjqWA+75/lEiUfzhW/FQ36BewK4IXOxJWVejg=;
        b=Nkyf7ELRRo4H2uuRqEFhj91wYPLynZpcdvktcwxC0bBTJarplRfQYf0011+Nur8j37
         tfNQvUrMdrT++aDqCsi8xSqQ7ORojkQkMWahrSsj32Pk/VlrYNl4k3I4w02K0Nfkj1Ck
         fBhUrxMF9VHcD2U0Umm0Q3FnbeFlT97AQMHMWcFyKBTGCh2PfLbPza1khbdY7DGpM2wn
         FylQ66uZfQIFqlofi8mTUuVemzuv4o6NkB8y/uBFczCQeWAlk0owCJzfNTDq3EZ0eiqv
         E9OfrzuTJ7oUQEi5jrKSu6QNTjym9tK2+3pSJi2Dvd5T4PqYlIgWJ4HXBgwodk08zj6k
         CC3g==
X-Forwarded-Encrypted: i=1; AJvYcCXVpkBUrTGF8EoqDG0tZauuuTNTSCldptPAMhutdKY3pssIiPGMrx32nACzQeXQjqupBM0u70SFD0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOgft5fwKin1F4t90oHZpx7c1xbY8ftnUZJsfu54jGjvXDqXB
	X2cPhaz/H883iat6hTth6n6xSFivVG/YwKtqtOdM2LdRx/Fo4WpCbrnkW8yLba4=
X-Gm-Gg: ASbGncv6UnLS2GflDsVGyXhB8M40bJObRYhIS5lCt5n8Xsp+5VwdR+8WKJC3FpfSWkj
	AIUerlieigEtiAqKoIUlOTTA4qYMIHBPYC5Q+hXKFbkfNzqEkPkvEJp+56DB4Lcu9YQD76pQpgB
	ME6OWvI7w5xTIX+a1PSptvw5QOae+kWIjDPhwsimrx5WuexC0rwHq/hEAkCDUKMnt4ETDcZ/f9R
	yARPH41O9gppQHEDl7K4Dtr7HF1Hzm8wJYYaCm1JA7+6XQvTGYPf5+OEX3Up6X2UKjlK6qwixSj
	Fkf/
X-Google-Smtp-Source: AGHT+IGTAH466Do47LXhtm0C0AFjStJBAhhCiTYBDduKsOsywXQD+YFHm3I81Ff+QowaJAjf8dPMCA==
X-Received: by 2002:a5d:47aa:0:b0:385:e3c5:61ae with SMTP id ffacd0b85a97d-3862b3815a9mr7633067f8f.31.1733737035392;
        Mon, 09 Dec 2024 01:37:15 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3863dd5d09fsm3072801f8f.83.2024.12.09.01.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 01:37:14 -0800 (PST)
Date: Mon, 9 Dec 2024 10:37:13 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Renato Lui Geh <renatogeh@gmail.com>, Rob Herring <robh@kernel.org>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v6 06/10] iio: adc: ad_sigma_delta: Fix a race condition
Message-ID: <dkxaqzlfgmup4hcmbpxfk5vb5mhy2lngvd4gcibtj7ojpynlxi@h3cmrzuurxmz>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
 <9e6def47e2e773e0e15b7a2c29d22629b53d91b1.1733504533.git.u.kleine-koenig@baylibre.com>
 <20241208124205.5b297fa4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqul5onkateqffxb"
Content-Disposition: inline
In-Reply-To: <20241208124205.5b297fa4@jic23-huawei>


--tqul5onkateqffxb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 06/10] iio: adc: ad_sigma_delta: Fix a race condition
MIME-Version: 1.0

Hello Jonathan,

On Sun, Dec 08, 2024 at 12:42:05PM +0000, Jonathan Cameron wrote:
> On Fri,  6 Dec 2024 18:28:38 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > The ad_sigma_delta driver helper uses irq_disable_nosync(). With that
> > one it is possible that the irq handler still runs after the
> > irq_disable_nosync() function call returns. Also to properly synchronize
> > irq disabling in the different threads proper locking is needed and
> > because it's unclear if the irq handler's irq_disable_nosync() call
> > comes first or the one in the enabler's error path, all code locations
> > that disable the irq must check for .irq_dis first to ensure there is
> > exactly one disable call per enable call.
> >=20
> > So add a spinlock to the struct ad_sigma_delta and use it to synchronize
> > irq enabling and disabling. Also only act in the irq handler if the irq
> > is still enabled.
> >=20
> > Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devi=
ces")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> From sparse.
>=20
> drivers/iio/adc/ad_sigma_delta.c:205:13: warning: context imbalance in 'a=
d_sd_disable_irq' - wrong count at exit
> drivers/iio/adc/ad_sigma_delta.c:218:13: warning: context imbalance in 'a=
d_sd_enable_irq' - wrong count at exit
>=20
> I saw your discussion with Linus on this...
>=20
> https://lore.kernel.org/all/CAHk-=3DwiVDZejo_1BhOaR33qb=3Dpny7sWnYtP4JUbR=
TXkXCkW6jA@mail.gmail.com/
>=20
> So I guess we just treat that as a false positive and move on.

Yes, my discussion was about a different driver, but it's the same here.
sparse is happy when applying the following patch:

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_de=
lta.c
index d32102b25530..dea4816793fa 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -206,23 +206,33 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
=20
 static bool ad_sd_disable_irq(struct ad_sigma_delta *sigma_delta)
 {
-	guard(spinlock_irqsave)(&sigma_delta->irq_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sigma_delta->irq_lock, flags);
=20
 	/* It's already off, return false to indicate nothing was changed */
-	if (sigma_delta->irq_dis)
+	if (sigma_delta->irq_dis) {
+		spin_unlock_irqrestore(&sigma_delta->irq_lock, flags);
 		return false;
+	}
=20
 	sigma_delta->irq_dis =3D true;
 	disable_irq_nosync(sigma_delta->irq_line);
+	spin_unlock_irqrestore(&sigma_delta->irq_lock, flags);
+
 	return true;
 }
=20
 static void ad_sd_enable_irq(struct ad_sigma_delta *sigma_delta)
 {
-	guard(spinlock_irqsave)(&sigma_delta->irq_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sigma_delta->irq_lock, flags);
=20
 	sigma_delta->irq_dis =3D false;
 	enable_irq(sigma_delta->irq_line);
+
+	spin_unlock_irqrestore(&sigma_delta->irq_lock, flags);
 }
=20
 #define AD_SD_CLEAR_DATA_BUFLEN 9

which results in equivalent code. Also TTBOMK this can only be fixed by
teaching sparse about the cleanup stuff and an annotation doesn't help.

So yes, please move on (or fix sparse :-)

Best regards
Uwe

--tqul5onkateqffxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdWukcACgkQj4D7WH0S
/k69Kgf/XRzLz7S08CiZQ587pexWKAv1vd8j/rmwIa0DGPoHfte/rMmYXR7WbSLE
hChUaWkMEZIfqkqSH0qswoWDJ6nuGYf5TfPpBAoaQYovF7OfZ/SYhEZrmh7c/lNJ
obo17OpjtYroynvC7AENREYe+q9MMTcX4q8Dh9raKqfE+KyccVjBUVrsoITz1n2+
Uejs2QPnmNILHayON4lvdn0zS1KjZxdrjMMYtlHP5Aw8wX0YzgiH4lbEvuhfPdX2
py1zgpTdqTMmRGpeIghvalUDKrL4mDY/8GVnuVLt0PrOb6dsOTrUGIrM2dhnzT+o
k9sXwTiR3ghfLF/p70SfpiYXvMqYTw==
=oJcp
-----END PGP SIGNATURE-----

--tqul5onkateqffxb--

