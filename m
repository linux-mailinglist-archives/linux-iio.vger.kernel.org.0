Return-Path: <linux-iio+bounces-11414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130FD9B20E6
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 22:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979601F21453
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9B186E54;
	Sun, 27 Oct 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N93utngC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D82F29
	for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730065646; cv=none; b=bxiufHVKZ3CbLOc1g1NUoWPWH9GeckuXMQOUUAhQQhQOTDt0DGQrGQ3Xf3O3rx9pg5eJe7R0cTyKhoKlQOde/17+GfirzU6GIWanZmTiU/PszHntr2m3+1Xgza2oBJx9XXjGmWkni818VmtMMyvDTXAZOQmU3M0UYQS00ECZO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730065646; c=relaxed/simple;
	bh=g9ExJhbQO0btiexdBLqoRN3afcSaIl11asZqPV6S2VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLS8MPG3cL8yxza4KUTI3OoXk3wc8z+cIaz3GlFVTmgngYstwqFi0pffKP0Yi1+87/8vI29S4OPyC0fKY4/L0oOGofXLOehBYSovKs4bKSDYzbQeyBFgTvVVmIjApiD93mTpaAkuuyFrc3Gmc0Yw078y11P5/j/QaQhQXTVeNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N93utngC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a156513a1so577109166b.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2024 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730065642; x=1730670442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe4ci66LRd5kwFw5K/E+LHePoZpEogZnmdvcyj6nqgE=;
        b=N93utngCN1UVS4ojQ1Ch+Dta91PTtq0dOdDoFr3AWrKgUmH/nghRAPBWQ+EtVkiwkr
         M/INQvX/NFSLXcYXHeOJseq16DU/NjbfjqZtYFz7NMJrX38H2jlOtSBCyvbgEPL+iLzG
         CWCszAwK4ain20ve26Hv4P9LrWjeS/i8P5HoYGBpWwDDS3TO7UZKCoLicP/Zqu76GgwS
         yU1MgcSYzLLbAjqmUsaR7BI6/4aBNC2gXKLSoHCdTMSiyiE7cHzft/z7AwJGJDEmNOK5
         9IvNKX0IlB+PIJa6B7yKffzJsdPCrX/LDvVysfT4jmQHRJReaYrHHB5S30GcAwJ+mhcP
         jPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730065642; x=1730670442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe4ci66LRd5kwFw5K/E+LHePoZpEogZnmdvcyj6nqgE=;
        b=DbTTzzuK0xNbOlU6cbpQek8dzGx4eIFyLTqgzxsikMkEDhFvBo+SQH31FIQW6ZN0IK
         yDVmrXQfa2rn3uYsp2DPPMG00nlZ81zFwwHHRR0/aNkpjDh+0584pSZvEvH2/twxfh53
         pPQ5dZNrCUenWcCq/tsxTOsw0540Efy50r+7tpDb2hxHCM/pbau0P3iX27h0Kd0IfXV8
         BgXBFu1pZoBCDddvSEwDDxCIlg/4gpu9k0IFWN+g2/ItjYoH61bskn/xn5Jaz9dWNnhv
         bhuxDk1A1zJh+HYT60T5qWjdSWQnTMMFx7w9sCevh6c1Qn16rDJR0Hz3YEn+TDq3qjxr
         VWug==
X-Forwarded-Encrypted: i=1; AJvYcCUfkdXYBOP/IxG+sk62f3QlSXgRhrsJ6pwjQ8rSSH2pLalqufx54gb3IbuJUw81SxTjIqdiTNdnnLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZnUDZIUogRypBsw6v6s1bE8743RTE4KxXaO2Lp+EMNPBP3d6
	638WCo/4y58O2f+dlbNn2hHEOU9KvwG1yAhR+GVWD4pnC+2neoD5w0+z0AGgtSw=
X-Google-Smtp-Source: AGHT+IG5CRs6f+sypgPUJBs8fk1CA6OCLhhRraAk54KIDDATP9CuUk0L3+AwwI6EAtbPJeZbpBO7yQ==
X-Received: by 2002:a17:907:96a0:b0:a99:5d01:dbd4 with SMTP id a640c23a62f3a-a9de633218cmr488951966b.59.1730065641792;
        Sun, 27 Oct 2024 14:47:21 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:7909:9635:32a2:1dee])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2994e9sm312921966b.115.2024.10.27.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 14:47:20 -0700 (PDT)
Date: Sun, 27 Oct 2024 22:47:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Dumitru Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7124: Disable all channels at probe time
Message-ID: <3rko6t45aqdfl7xk2nadduqmpvlgwleolmel2zj7ebz3mmvuiv@ef3raxsu2t45>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
 <20241024171703.201436-8-u.kleine-koenig@baylibre.com>
 <20241027114228.5e418341@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="trkgarjzxwucnumm"
Content-Disposition: inline
In-Reply-To: <20241027114228.5e418341@jic23-huawei>


--trkgarjzxwucnumm
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] iio: adc: ad7124: Disable all channels at probe time
MIME-Version: 1.0

On Sun, Oct 27, 2024 at 11:42:28AM +0000, Jonathan Cameron wrote:
> On Thu, 24 Oct 2024 19:17:05 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> wrote:
>=20
> > When during a measurement two channels are enabled, two measurements are
> > done that are reported sequencially in the DATA register. As the code
> > triggered by reading one of the sysfs properties expects that only one
> > channel is enabled it only reads the first data set which might or might
> > not belong to the intended channel.
> >=20
> > To prevent this situation disable all channels during probe. This fixes
> > a problem in practise because the reset default for channel 0 is
> > enabled. So all measurements before the first measurement on channel 0
> > (which disables channel 0 at the end) might report wrong values.
> >=20
> > Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> Makes sense in general, but one comment inline.
>=20
> > ---
> >  drivers/iio/adc/ad7124.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index a5d91933f505..912ba6592560 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -917,6 +917,9 @@ static int ad7124_setup(struct ad7124_state *st)
> >  		 * set all channels to this default value.
> >  		 */
> >  		ad7124_set_channel_odr(st, i, 10);
> > +
> > +		/* Disable all channels to prevent unintended conversions. */
> > +		ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0x0001);
> Why 1?  Build that default up from the register definitions rather than a=
 magic
> constant.

I picked 0x0001 because that's the documented reset default values for
the channels > 0. But agreed. Will fix in a v2.

Best regards
Uwe

--trkgarjzxwucnumm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcetOIACgkQj4D7WH0S
/k52Cwf+PY8XUYHFW2QZl1jc4Tqq8UZ0wtUg2K+c6HmpMeXrEk3WFGDhGEe8K4K3
Gu0PHvIcIJ7dmy9p4Qb35Yyk2f+xBKczc71Pbh00V5igLN9ITQX+6s0JtgaBFobZ
hxMxJa9Sdk5nBxFWAwng1M8u1hfu9mzXwy/boNkcuZw1jUrL26QlUlBQm6pSY2Ir
mvtIGV9OylNC+4b5EEOyGomBkplG8WkZypNMlsCpZMKAj8isyjHVN45CAJL4RrcP
x14Y7M0t53Rr/GpnjN+vpzstMAsjRuqH1t3nBcnrOivZoFj1HYMkfmrSg/4qawko
O3uidHvjTyolMmYFNgnXrLMsYDebxg==
=CfjI
-----END PGP SIGNATURE-----

--trkgarjzxwucnumm--

