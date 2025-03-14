Return-Path: <linux-iio+bounces-16818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC915A60B11
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08373A55D3
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490991A0706;
	Fri, 14 Mar 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yaLL2TvV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DB416F0FE
	for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940232; cv=none; b=oyjUk7yjgCD698sePdQhpuRj4cYHx8RmVeu6mDwDAaUz4ypcyYDpJIxh5z1Os/Oqstr1OWG2XyjpUwiMQHZtqr7GoaAeOyUNB+uHhOYTSfFDZChnFancs65iMMtBQ0mgP+z7QQ9vm7pDYvG7XrJY62iIm9BBCZII18G6Yth8neY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940232; c=relaxed/simple;
	bh=sAqNQxxYaR+0Tltp1KviJARJhOXM6KX0a50qQV1JteI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq1Rdan84NRs8+RXbItfZ6zCSKBGx4gpHuR5UatgYHtNpCUwxnrVXOJiR5H1HXl0YlZgGtumshPfgsNJvsU3dXFHOL4/cbPA2O1OSSjQ/6L652d2pxj/2dlD2UYCkWc+uHLjgaPS2bAWmRz8+jp6PTQTHjdf4FifvdBGuVEVeEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yaLL2TvV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso2831280a12.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741940227; x=1742545027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klYyfnhFfNhRZigjlZI4YyNSugdGK0OEd2fAAM/BTJ4=;
        b=yaLL2TvVwIvp4BLB8ODhIdC8+lmLcsLPwZoUWPzoqKyxKEy95vMothF+5fNjevb5u/
         Z470rAOeqcAt1PcPOZRYcEAz6E5utdsknOVM3ZGDYpHhWhaLZwSyqCB3W/GCMvsOq7DD
         uePKhTGGNQO8GX722LikDSkn0u8E1sJqXm5igChJgv3sempDajEvohYy3/TzfkhUQiRL
         CuNURxyQG8XmEVZ45HY08diUl27yX49ZVtOGO2uxu4Yo+Fr+TpAjuSWONY4XM8e1dmpU
         +Y7shsXgIr3VIv1nj8ECmqSLD075/R3xPljjhSgAdMV+GkZdRZU9mRmOrVU40vReA+Zf
         3mcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940227; x=1742545027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klYyfnhFfNhRZigjlZI4YyNSugdGK0OEd2fAAM/BTJ4=;
        b=bijLDYFaM36ootSnk0b9CVNp6hbgys/7RP5bMWMSgGsGELt00LRg0al1SP+onec3kq
         BYknAy5GgUBvs8gtqVvNt+WShxDAAmh9SBd/e8QMcEVMWu39ZdE3KyinIhIOkizD5AuP
         O/JZXcgAhkiscQiTxhqR9bHhtibnteTdz2C7+FAE6tR/6xUFJndWQWG1uBBglEVT/Gub
         0S5FGjTh1TD1L3MQDj1fxqH43OElL4P2fSnjCayKyN6A4zS0ddqnv84c9J4hvCAuby2K
         x6PU22fKikPHw6BC0F5KNrcjtoD7LqI7JnHM5I5HajKKBc4UcvfeBizDifABs/1SMOy4
         VhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgjGyx6h2HvyaP7qWQzRz8/jcKl8TCqL7h0dbFZzir77QeXe1BVQzElxmLOGID1eBilsbZL2JSZ0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo5kllFYm2TtXhp690syw68oU7InLvBpnRy3mCXSp3yv4E/OFL
	ru76MaZQQ0CDGj8jNY4SjwRfrnf77rdzO/+dd88oTBPD5ObkNgUHlh0/ZB3yPcM=
X-Gm-Gg: ASbGncunoaA2xSsB04KCFJID4l8po5UxOR0TEk2Q6ZF4spWfk0wYfHRU28bA+retWXt
	d+dPUsnd5WgsoP1APUY5Lc71fEudJglTck7CyfE9C6mVTw0NSStTFq2tGb3Xk+AzUVb4Rvj6CCF
	ef54DPzfX0dsXgoAhGx8xSOkapm5SG48+//S2kca9KKqTKfL6MXau7JQWYwjS+ntei/07x37C0m
	v3ODSSNNPX5AcuKV9zQnzLRRCjJ7KfEafAVzg4YcKb7S28OF6UjX3HQXHvnNfU1TL2Ia1JHGI8u
	YpRtQ0lO23l4C/N5MYq1rAufVPQLBsV8EPh2TG7cWvY/UTI+Gode+chW2uTy45QElRRKVsNWlrH
	Npgl0K2y5vv8=
X-Google-Smtp-Source: AGHT+IHjW239zYn26zGx0cVtSMZeNi2VzgrdmIbWOC/MFA4e1w8B4GT2HlMVGrfoMcCu1l8EUKEfXQ==
X-Received: by 2002:a05:6402:5106:b0:5e5:e78a:c502 with SMTP id 4fb4d7f45d1cf-5e8a13dd5d1mr1404321a12.31.1741940226860;
        Fri, 14 Mar 2025 01:17:06 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afdd49sm1703794a12.73.2025.03.14.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:17:06 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:17:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Alexandru Tachici <alexandru.tachici@analog.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad7124: Fix 3dB filter frequency reading
Message-ID: <6bxixvxb3um27njoetnpke7n33d7vse36z5isgxf27xo3algw5@2flduzj7ccsy>
References: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
 <6d31f9559939ec04066bec612a59bc7ace2ca548.1741801853.git.u.kleine-koenig@baylibre.com>
 <4d3e77deab4741112d7ef45ba331177bbc3879ca.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ayo2quhzmc3yhaek"
Content-Disposition: inline
In-Reply-To: <4d3e77deab4741112d7ef45ba331177bbc3879ca.camel@gmail.com>


--ayo2quhzmc3yhaek
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] iio: adc: ad7124: Fix 3dB filter frequency reading
MIME-Version: 1.0

On Fri, Mar 14, 2025 at 08:01:13AM +0000, Nuno S=E1 wrote:
> On Wed, 2025-03-12 at 19:38 +0100, Uwe Kleine-K=F6nig wrote:
> > The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
> > and for sinc3 the factor is 0.272 according to the data sheets for
> > ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).
> >=20
> > Fixes: cef2760954cf ("iio: adc: ad7124: add 3db filter")
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
> > =A0drivers/iio/adc/ad7124.c | 4 ++--
> > =A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> > index 67d49e6184f7..a3cb47ca3901 100644
> > --- a/drivers/iio/adc/ad7124.c
> > +++ b/drivers/iio/adc/ad7124.c
> > @@ -291,9 +291,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124=
_state *st,
> > =A0
> > =A0	switch (st->channels[channel].cfg.filter_type) {
> > =A0	case AD7124_FILTER_FILTER_SINC3:
> > -		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
> > -	case AD7124_FILTER_FILTER_SINC4:
> > =A0		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
>=20
> I wonder if we shouldn't fix the sinc3 factor as well? Or at the very lea=
st mention
> in the commit message why we're not doing it now. Otherwise it's confusin=
g and raises
> questions to state the proper factor in the commit and then look at this =
diff.

Huh, I intended to fix that, but it seems I sent out an older version of
my patch :-\. Will send a v2. Thanks for catching that.

Best regards
Uwe

--ayo2quhzmc3yhaek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfT5f4ACgkQj4D7WH0S
/k4DOwf/fIw3+8rI4Y67LzSyVLPhPOIanra/tHZWkce514njBd7OJ/XII/b3BSb8
EbanQ4vVedNkb+S5OVYmPCBw9PagMEt9qaixLioRXuCagyY9InogVXz9PESRoWBn
4yLWVIWCg4nUVqp0ansA8wrO/Bbyqv9y22RZnVIVC55IhCZXGiGadpGD+rbyIxlB
NanWWwcVVGJpkceEuRyHMh3uLzDhXf8pi3VHwTCKUPW+dDToJ3uJIqL24uXiw3dw
kRRX+20Nqp109Op0eppHvlvmRI1QnRcL5WuClZFni8pFQMQki1gN7roXh5CfqqSy
KX6hEo2RTAfEoOi9ojOAfM1lNOCH4A==
=pnDR
-----END PGP SIGNATURE-----

--ayo2quhzmc3yhaek--

