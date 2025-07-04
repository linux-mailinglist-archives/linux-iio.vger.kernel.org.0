Return-Path: <linux-iio+bounces-21350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC80AF9300
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6824541C8E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B332D8DDB;
	Fri,  4 Jul 2025 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuLLpMrl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707742A83;
	Fri,  4 Jul 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751633032; cv=none; b=gNiq6ABtq2KTi4gfiUWWJlZvcjv0gEnX4vmPXiMEQxd67P/pww/V/I4yhXlyogEadhFZS0oWzrzvVBCZr2bfM714raFeTWLEg9PBZsRai4xk50W0wv4V4NGU5gPJmGuOgEvuSlfjZ4tjk5+Tjn4RNnBQHmEF1XPoPS/sUDLCUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751633032; c=relaxed/simple;
	bh=KmQQxpBb0mS9m0kDclJWLtXM6Fgs0/JDUTulvAo7Xlc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ngkq5qcmW+d4Ijarq7eyIaBJXX9BWCrcmGw3lyzRO26UVkI/pf07AgbPmEmrMrgg6BcN5brPt7v3l6VURDePlcyY7CaLrztxDegnP9x4MHy/it91KagBoL/V4nvdu/OOMLHuz1ZyFlEp4yA3li66EbVzZYljGKhgwHo9RvrMChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuLLpMrl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4539cd7990cso5524975e9.0;
        Fri, 04 Jul 2025 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751633029; x=1752237829; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8S+dBLGBuQUYunnEiKGhmjVQLSWnhxEtryc+4FvVY6g=;
        b=NuLLpMrl1uWHJBgwlOajblP7BfHUYnuFd5IylM13e40S+q+8Tj6gtlgyclMC7zJ+i4
         /Fu1FAL9j10gfJ4ogbGdRySWgtB2BMAWcxa10jbDci3J6XVDHOmNgg9jHqJQxkJ6kRxC
         YMMJPPhEeaf38+Q+LV5rHfIo6OPQvObCqYnUnnrvr1hyX1kDBRmcma/rATzcbBvrbKIp
         bb87nH7eYOhOYpPPSykUMhP/ynN0sCWg2W72ozQ19iFMvdyNt4IR2GQb3tdKwr/Ci/CK
         6e5yC/nnTgpsw3zXOjNSr6VdgJJ65Lhn9ONctwmT6Tbk/2gIihGuIuLf/F1p4SqTT+uD
         nURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751633029; x=1752237829;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8S+dBLGBuQUYunnEiKGhmjVQLSWnhxEtryc+4FvVY6g=;
        b=G6udykCoKsrJ4gPIt2o6rqc62qzes2EJUOOovZldMFRuyp0O0KAidkSm7hVjiRT4nv
         cb8ULjK/LbfapUbzG/KcAzSaBhS9eCwN4WrJUfTduNYGxPCAbRDbnG3h6KB7jFeiOH5v
         PKTXi1O+NfjKC9tMQIfyvstOfN5c0ZEqGjg4tV8WuKDlC2ifo6b8dq8/955CMghvEjQj
         WpY0vrFU7wm568o85gUJM+jIRC2zWlB3RiKFZBBWl6rH6q2tNLL3D+t/ea1ANYR6ey8B
         OSeDZYCBV2H52ThQV6b2DWdKhfH5zg7iED7rNeJe5kpHG9Lb1latpYVdRYRTRZrklGB+
         q+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVWcJ6MrzMukpG2LwQ2TzNTEVAlv9wIV+tjY+W+Ry/F2hR21ylr27EA8jn8CDB24C0+bvyCm/dgEXtmq2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdh/Pxhy0qjZiFVNRc/yO3QaWhXkOuWJanXC4BN7sMm1tUnfF
	qgYQekgL+Pnycik18K50CR/NwveK9HOKQtmy40mijOSShjjycK6tWRv7
X-Gm-Gg: ASbGnctuXJt0z4+AOysE8jsAjF2b7wv1wZ2/jPWJ++M/B/g8AksPY1vQPli9WDEzgcj
	9V0EJC+LtQe+8z7/lr3lkpZvGV4SWCND044d6URXEhMBmNxs1pLYjLbKe+JnwxkonICiBt+hWGT
	7IFsvQKA1d1AGq/yFW1F0sUrAli1vkuo5Ns8LAiQ7uc56j2x1jUWy4VLwQJdzFa423fw3Yc1AEr
	taTe9rvl8PvBlKf7KLIgXznJQ/9VEy6yc+KObqyVhQR+PORs6fReDqJZqZxQYrHC20Ea6h1U/Ii
	C6bnAbbzYAcFz5F8kaDN9d+bov51PYPig0ryKUlemyg5bb2nu4/rQcKiHbUfqCPKuWBM0A==
X-Google-Smtp-Source: AGHT+IGiSvTkIqysm1uUAQVVvplLxRCxua4bVn3UJYZp/G5UzsdcwRs/NjjUri56Aqmro8fgJUGpYg==
X-Received: by 2002:a05:600c:c492:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-454b38fa8a6mr23435815e9.0.1751633028646;
        Fri, 04 Jul 2025 05:43:48 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97732sm2455270f8f.59.2025.07.04.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 05:43:48 -0700 (PDT)
Message-ID: <1a0d8f22dc540567142e4583db6eaea0e7d06f99.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: change to buffer predisable
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Jul 2025 13:43:59 +0100
In-Reply-To: <20250703-iio-adc-ad_sigma_delta-buffer-predisable-v1-1-f2ab85138f1f@baylibre.com>
References: 
	<20250703-iio-adc-ad_sigma_delta-buffer-predisable-v1-1-f2ab85138f1f@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-07-03 at 16:07 -0500, David Lechner wrote:
> Change the buffer disable callback from postdisable to predisable.
> This balances the existing posteanble callback. Using postdisable
> with posteanble can be problematic, for example, if update_scan_mode
> fails, it would call postdisable without ever having called posteanble,
> so the drivers using this would be in an unexpected state when
> postdisable was called.
>=20
> Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta device=
s")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad_sigma_delta.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad_sigma_delta.c
> b/drivers/iio/adc/ad_sigma_delta.c
> index
> 4c5f8d29a559fea7226b84141bcb148fb801f62c..1a2ee7c7f65afc60677af9f3138e59f=
6476f
> 74c7 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -520,7 +520,7 @@ static int ad_sd_buffer_postenable(struct iio_dev
> *indio_dev)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
> +static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct ad_sigma_delta *sigma_delta =3D
> iio_device_get_drvdata(indio_dev);
> =C2=A0
> @@ -644,7 +644,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev
> *indio_dev, const unsigned l
> =C2=A0
> =C2=A0static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops =3D=
 {
> =C2=A0	.postenable =3D &ad_sd_buffer_postenable,
> -	.postdisable =3D &ad_sd_buffer_postdisable,
> +	.predisable =3D &ad_sd_buffer_predisable,
> =C2=A0	.validate_scan_mask =3D &ad_sd_validate_scan_mask,
> =C2=A0};
> =C2=A0
>=20
> ---
> base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
> change-id: 20250703-iio-adc-ad_sigma_delta-buffer-predisable-d10fc1914092
>=20
> Best regards,

