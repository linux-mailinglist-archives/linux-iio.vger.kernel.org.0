Return-Path: <linux-iio+bounces-15627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45782A380AF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE8D167630
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925051DE3B5;
	Mon, 17 Feb 2025 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsS5U/KJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93FF15C0
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789380; cv=none; b=KJ/I7EI2ITujw+r73fjK37mDt+RtHVIMgUBZYoWUANBdNGvtOlrFNLn8e9bnuN6Sorb4Bk9nJX72dKjSrHei8GXzZ39Ay0OaUAazIEXGqq4KaoxpZGrxt+bi6Xq/x63+3/fQZ4hCRJRvr8VRtLxWdujCsxFsVMpGQ3uUeOt/5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789380; c=relaxed/simple;
	bh=n7pjHZpz7vHM1YII30TUgRmH9OcUvQmbh2H8y7mCbK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EWJIRuuHWALX4KS5o+DXxnfzCQ/mjoLJyctuqNyW8vMVVcRlSQVa43z0vWK4LahTYUv097ScLOhYMkhzykgoiD8GurmBgwvM1NRRHpkRFoqDQR6FBESUroRCh7nM08950GAl76xqlXwjCdSqDYRnJNKUUAYlYpLtAJBEr/jN61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsS5U/KJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so28490835e9.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789377; x=1740394177; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVdkn0DcbwGHOAuRrhk7twPxj0MgnPURdi9enqY3l1w=;
        b=TsS5U/KJurNiYL2dkXXsP4r/1d6mtwfVGnScdmCgns2u85fOOD4LqPBHbKtdDOiIMy
         QUvr+nxsiZahuoh2/zOqPpeSumsZiwMAHyhldGvDjULby2P9xakuw5I3xNQfKgGV6PDS
         ATVY9pQYrS34w/4surYIoCbO1r2D390uBzsoc+4+yQ0AUI5Iya9ezuJEoxBAKQn2YD6t
         OBh3lAirziMbiPesyU/6cSCrejPuHDAlMFWQolSJsq22j5myTYteK5CNsxKs5v18+Pmg
         2gwc9oJeshsgOgs8TbAiLbz2EWKUm/tVTaOqeoI50IyTusQu0WbwDe7AqIUmzcdFIamF
         2dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789377; x=1740394177;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVdkn0DcbwGHOAuRrhk7twPxj0MgnPURdi9enqY3l1w=;
        b=qFKYbZrJynOGAYd5GC3nGEx/t5RLbI4mqfoGlbp1uwXeBZCc/BoQKTFmY0JfuszJV1
         Dcj4j1C7inOKEf2+2R9VhYnC7ThhIHuVHOgHiGUI0/QKe0LhuQQxhEMgPqASQgHArNSm
         r7Ns9y+gaFb8Hw8pSXHH0VYiifIZWz3NFbze+nVBURng80BfJVtO6UaY1W0YA0fh8zDk
         4OBFz3Vp7KpyhZqpm/Goe3DX02Ow+2t7jIkc72/GqvTdHrXfT6eotX37HPxcgQ9bL+YJ
         /9hLSdTSJiMnGwvt/sfcxaih7BWKfBCmtKStmYmN5TwgIYBzbSbG2yRr2AejL5olidET
         brAg==
X-Forwarded-Encrypted: i=1; AJvYcCWn58TUQT6/UORzAzYJKorX5M51M4JLSJQlVUIGUxBQ2SmYoneW9UGreQrmPcc/scaqdp7iK8BM2Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RSgh3lx1dZEU6qU8z8wr0ZiyJO3R/CJXnEj8SoKFmyGR+j7W
	b8sPGQBpExn4bSSi6fLiOFyvdb//xTcPLOz9ZaT6DjuhpWqhLi3D
X-Gm-Gg: ASbGncsSbyM8KGsAPtJFKpE5z6E8CbU9Z3jlXhVDbn5etA3c7/89tQM+Iihp06a85GI
	jpicEEctI6Yz9QtFwXWvo5TAfcj+kJuvIjKiFrlDNrk/P/ul1PHTmJHxbqwe8iZwrG+TZ5AenCK
	qh8RPW6dJyTGKdRpP9j7rsC6zpXXMXc+LHcUJp6WHXB0PETGhlZny8hJFgE/lmR/4492ym83qQt
	SjGA97o5EvFF+cdVh6ZDGm2z2SCd6PkK0E9YHWj3NHvoTqhFjmTV/G3qml5aYDINQQH/rh/wUpf
	ioWvYqhHEkEtregrEJ3ufkpbe1fPesBevlwHT3jvA/g1MOpAzz7FY2NcboSbojY=
X-Google-Smtp-Source: AGHT+IGjEO/Nyn+6EEqVnKdyTJTYo7DQLTPxsIvS0Gbm9TGtF3l4pWLs8LPLOYR1xbh2LykVRdCnww==
X-Received: by 2002:a05:600c:1910:b0:439:8dbc:1d0e with SMTP id 5b1f17b1804b1-4398dbc2311mr5098985e9.10.1739789376732;
        Mon, 17 Feb 2025 02:49:36 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5efdsm11750205f8f.43.2025.02.17.02.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:49:36 -0800 (PST)
Message-ID: <0518e0504a9390fb1c4af6294d0527a57f013966.camel@gmail.com>
Subject: Re: [PATCH v2 13/27] iio: adc: ad7625: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:49:39 +0000
In-Reply-To: <20250209180624.701140-14-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-14-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
>=20
> Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7625.c | 9 ++++++---
> =C2=A01 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> index adb4e25dd7ea..0466c0c7eae4 100644
> --- a/drivers/iio/adc/ad7625.c
> +++ b/drivers/iio/adc/ad7625.c
> @@ -248,12 +248,15 @@ static int ad7625_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int val, int val2, long info)
> =C2=A0{
> =C2=A0	struct ad7625_state *st =3D iio_priv(indio_dev);
> +	int ret;
> =C2=A0
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -			return ad7625_set_sampling_freq(st, val);
> -		unreachable();
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D ad7625_set_sampling_freq(st, val);
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}


