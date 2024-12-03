Return-Path: <linux-iio+bounces-13034-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18D9E2BE0
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F37B3E5B4
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 18:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D041FDE26;
	Tue,  3 Dec 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ySmHKye4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC31FECB7
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251682; cv=none; b=B8wQafx2bEfehHYRxYHzO9vX/JiweTpba72Zy4MBZJhFVxqShYvTT1TKvZDHuqQdsm7jYBW3qQmi17dRA9t5S1zEy/+YMa8ib59g7WNgQa0IFvw1yuryxAJakDD2mjVxP3YSMwvzMYmQe7TREVPIpPB8O4QKDRY6sDb5nid9qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251682; c=relaxed/simple;
	bh=5bBerDSvMx+1pyXViGYT+NSdKblxz79ItUqYQdKjo2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7EakYRDjQZgNXxXwVT8h2KCML3lDK+Bi5U6TX2Z7MjK9J6HNF7k+YfbWj9vyI6fgbWOhZtPLV55IZAkRSObA8VQet3cWNCU1D31E/MklTxJdqwIoZVX944tQtvWoNHkw716Z7lxQ06NlhVA5rJ9ClR3SzaMUaVqSobJjcO1lEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ySmHKye4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a766b475so54560995e9.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733251678; x=1733856478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kfxenyyAnBDfqRL1EqxAaj2O3HQhabP61v6SyaE7JO0=;
        b=ySmHKye4ZkFCH2engaVANRiM34MXK2zKPMVkd474a2N3R3EifHVoqie7mAplkQa6PP
         mBV1Pcr/i2nkg1HJi4INCEntIKiAHjHAwWXE3Mcvbjc5KFmhakS9pSy+MzveBgxiEYNj
         x1Buy1hgqU1JuPWhmrBh2oBCIxCqhJCHQ/kTk8QzwKU1VfXozIerIyqvUjoqs2RxB5Mv
         uN9QV1iyeEdr3yTBbV69k3afcisbn3lJtTv/Q5WZTr0RlQwdHSU0Bju03aV3d/vNt26N
         JQuQvy70LtHUUZ8UVQPsLAkd0AnbeSsGathRmjQvejATvhh/pRcwspL+RKsd9Y/nTHaR
         mJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733251678; x=1733856478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfxenyyAnBDfqRL1EqxAaj2O3HQhabP61v6SyaE7JO0=;
        b=HF5nCrmGGkFAS9X59Q5GlYsdBw0Op5Sxcanz9s9D0ZscVC4vc0MU+0f6GH/icb+J2w
         WA08GystrpApwPh1LXgpNeNlTdLgsW8jQv+JxIYs6gPVLpzAs/3XvJGNVcsMwu7iR4Kt
         CMdivDfVa0Tpg6hynwwFh4QRnTbH5Zd3+F6mjcN3D5yFdkx+QzeQ0jgEOZuspRFds82q
         TqIFDVCwbLbqTt3vXI4CjK86NlYADmnZNA6II9VHmVTRb/bwXprHGxLPBbhRn7m9Ulw+
         Hi/3qXoLzqId1JUDOz4yYmVfzwCEd7e/0dHJBgAaqDXeiasobKioIyc83a5kWyNYyMaF
         RpFg==
X-Forwarded-Encrypted: i=1; AJvYcCWXgd0tNnliZ4r7FZEr3ZDtkvYIqz8WZGY5Y5u+NWRwa6qX8UWAvKnMhn5cao3fxvnV/K8u4rpXxoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzahQbbixtJYq1usOfY4F9AqFiZSrHi0cCJCznX9wGb6JCYZuRr
	0/c8l5bmZpt5Z7lzpoalJcLlgMNJMjj7/ZtJ63VEJmT842oDDI/jvxsCHDhetww=
X-Gm-Gg: ASbGncshJjDeN4Ss3eLTewPPI7CeOuIr3pmhqW4BfNeu53aoxONw9t5BHwhb8a/B7Uo
	pck9Z9ZzuNEG7lCcHI2Qvkk7oKUV1MMZsut7MNRjSZhvYV6KR0L3oWsE4ZNSHc9k53+885n/4eY
	ceKHlSXoInSvIyDdnf/aOzIwsM2KCVJ7DbjH2+cL7rGyJ76lXWVVrKRvHHEFE3C34qUSj7avT0j
	IWFiPKllXx46QwC5t5WBFPmbob0QmyAZMIbuJT5bIRlQIw4EHlAkX8lbG3dSxzUm6lOxamsxihD
	maET
X-Google-Smtp-Source: AGHT+IGzoNeVUa7ZD7wYbJlqIfKtXx68y9UDnsruVwf0NCHOhAM8a50yQTJRheMoReud0nTa6PlIlw==
X-Received: by 2002:a05:600c:1c07:b0:434:a10f:9b with SMTP id 5b1f17b1804b1-434d09c0b93mr34092995e9.14.1733251677976;
        Tue, 03 Dec 2024 10:47:57 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dc6831sm196821245e9.20.2024.12.03.10.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 10:47:57 -0800 (PST)
Date: Tue, 3 Dec 2024 19:47:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Renato Lui Geh <renatogeh@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, devicetree@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v5 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
Message-ID: <ysobvgq5vxvoe6cr3aryxwfaaqg7ckdyxr72mo7k3r4z2n7bnj@hgfh4ec2sopp>
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
 <20241203110019.1520071-20-u.kleine-koenig@baylibre.com>
 <CAHp75VfuTRDAjOD73re8tCWWJsAFUq_P6hPiPd4j_mOFM8oKGw@mail.gmail.com>
 <wfcqlw3xqs2farpvkn3jjlot2bhmsgfa7lfpyzrjwuwuininsn@ni5rcnm3zdxs>
 <CAHp75VdYagk3Rk=ZwhrONHmJBQ=oxQuJc0-RHZwj7E_wGim-OA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tpwewig44xsnrk2t"
Content-Disposition: inline
In-Reply-To: <CAHp75VdYagk3Rk=ZwhrONHmJBQ=oxQuJc0-RHZwj7E_wGim-OA@mail.gmail.com>


--tpwewig44xsnrk2t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
MIME-Version: 1.0

On Tue, Dec 03, 2024 at 07:47:53PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 3, 2024 at 6:16=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Tue, Dec 03, 2024 at 03:10:30PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 3, 2024 at 1:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > >
> > > > It can happen if a previous conversion was aborted the ADC pulls do=
wn
> > > > the =CC=85R=CC=85D=CC=85Y line but the event wasn't handled before.=
 In that case enabling
> > >
> > > Interesting use of Unicode, but I suggest to avoid it when it can be
> > > avoided, i.e.
> > > using the notation of #RDY_N might be appropriate as that is how
> > > usually the HW people refer to the active low signals.
> >
> > Usage of =CC=85R=CC=85D=CC=85Y has the advantage to match the reference=
 manual and data
> > sheet. So I tend to keep it.
>=20
> Not sure it's strictly the same. The above has two dashes on top
> (actually misaligned a bit) of two letters out of three, this is quite
> confusing (as to me to an electrical engineer) and I hardly believe
> it's the same in the datasheet (however nowadays everything is
> possible with (ab)use of Unicode).

I think this is "only" a misrepresentation on your end. Sometimes it
happens for me, too. A forced redraw helps then. I think that's a bug in
the unicode render engine. In gitk it looks completely wrong.
Syntactically it's correct however, the sequence is:
\xcc\x85R\xcc\x85D\xcc\x85Y, where "\xcc\x85" is the UTF-8
representation of the "combining overline" code point (0x305).

That makes me remember the times when having a non-ASCII char in your
name was a problem:

$ git log v6.13-rc1 | grep -P -o 'Kleine-K.*?nig' | sort | uniq -c
      8 Kleine-K=C3=83=C2=B6nig
      1 Kleine-K=3DC3=3DB6nig
      1 Kleine-K=3DF6nig
      1 Kleine-K?nig
     10 Kleine-Knig
    156 Kleine-Koenig
      8 Kleine-Konig
  12862 Kleine-K=C3=B6nig
      1 Kleine-K <u.kleine-koenig

If we don't start using these, it will never be repaired ...

Best regards
Uwe

--tpwewig44xsnrk2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdPUlkACgkQj4D7WH0S
/k7+MQf/XxwyxQcVhchWqL0L8wNdKvbfwTFx0rYliYbHfhAfeePuEj/Tp8fZwbPn
Tb8sxD0QFPUfkvullZBnlyKAph2PPxeWxDaqQ7rR7ZqtYinOXB9/C+7J+LhidHY6
dlqcAfGZ9MczpoWxSW84ueNq26oRAw/H9bKgBr6DjRFuRoDHunKU3z7OtITvh/Dc
b2hhw5p079/XXYmz8AeMDxc63mKNQrvR59IqNDPhQH6ywPRn18Dk6WvZGCarAere
I0ENVcVnqN9qj5GsZNtmpa90TdikN5HN0zVjtuA7BZm01pD4XDW6lRGPo0nAUEi0
e+nZhYTXmf512TDi7PjEeOCO8ZVMmg==
=pM72
-----END PGP SIGNATURE-----

--tpwewig44xsnrk2t--

