Return-Path: <linux-iio+bounces-19737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776AAABDC33
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 16:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B390417D380
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 14:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D34248F46;
	Tue, 20 May 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAoHyriT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9A2472B5;
	Tue, 20 May 2025 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750135; cv=none; b=apwyXcbyLiRPFJ9p5apJ6uxANy7XJCfDecA9ytgRbLzD5PLBgcOC3os7kjmDQtWodE2pfDaaRhXKkfuiIzPO0yA3FhyfgfmZXlEKhA+9S2vGLmF/7esuvINoIr8Vxb3lISQ7F4gY0UFdAk6HtLDc7+a6GIRqwU/4LXnlNkgN/R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750135; c=relaxed/simple;
	bh=EKrW1ao0uX+vpJzi1onxtfutXqkKhmw9wP0fjEy4uKk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjfzP6XdgRzK1KNcMY6ZhJHtEA3irae3cNq0JqsTTOofXY4+35J883PKdNdu+gfYA7fZ4ONMX/ZO3S99+zigsnjtvRsKCFTT71czpnGGgFvoGgLrF46lVfkArgLn5SpzxwdAZLz3htJk4pJi75u4RbPyXHZqKJh5mmSsxkBozFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAoHyriT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a36e090102so1396529f8f.2;
        Tue, 20 May 2025 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747750131; x=1748354931; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hn/LYhmECEspf/Dn0ZU1r59gAeh7cLe2Zio25uygSQ=;
        b=DAoHyriTfGMhLsXthoTNSunJIjKajFZ76sULjQkPJjIPHVS87TyCuOs0ztqXTQfpsP
         WXumKox5NKo4NxTCCXOhS2pJKftfeJikvpkRhVcDoLje2cE2AaIvZ3P333tvCrx7IYkt
         gisYu4JGWLfl3/EGP8gMcS7lBOhd+pka/NVlqE391eV+LIEz0VyyDqssLdPHwopzD30f
         jWL93hOeiBwPl3nqj+r2777p/uGEfWb9prxUNB2YEVe6KiZKY++fL1JLcSNcBRrxImec
         tg10hZfaJap1F6JbdkobwyRLrVQEAqP5Ay8joIz+vih+p1AOmgr8+Rqm7vAUL/Ngt6Fp
         9yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747750131; x=1748354931;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Hn/LYhmECEspf/Dn0ZU1r59gAeh7cLe2Zio25uygSQ=;
        b=PIUxPCGHjeQ3KbdrVyqXlxIg8gIGxhLRk9c/xBIQaHwUnd2NLQ1oUUkKyCwLkLSd0U
         ArMaXudb4g1hE+21O747eaPzrsWEHMOfanzRLUtgkGUwWjSYMR2TDN/UXh2Fg937mXbA
         3kuEVWjptlSKZb0yT5ipDhqFCkWqE9qL+f+Hj/Sw5dSN/5G+cpPJv2Ej1RjkPE9pJiY/
         QOvYcSY41gX6m8zDaUfBbc7/f5QMiLWyhyjc/Rfn/3T/n73s6ClgLUGAaGtJO5YUnm9H
         oa5DLXvZKqOgOzs1kN47utsGnyaEU8SmP4dQpkajRiG2S7XDELSm9veJExnzy0gQxr/c
         Rnug==
X-Forwarded-Encrypted: i=1; AJvYcCWhgHD0pDHISG7ErNaspJKCoZd1uhJeF7SYhKQHSaWcpe+H+jO9v/+44bLjL0v14dUyWrvXbdhFLhU=@vger.kernel.org, AJvYcCXgweqRtJmg4KEoJ9A/mbSDJ3CdrLLZ39fj15G3+pkp+cTI5GfDM5oeYetR/Mq6SrHqSZWA4WNrinsJgiBJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyckK8A8fKrw3wwE+ere4cjjekp/H9/G9l8NiSH4moY7eGCpMSZ
	qFqWfSTUIzKZ/bSz6jq8uok1nWJv7Auo4dSNgw83j4A9ofXzn09hZxva8er+9lfz
X-Gm-Gg: ASbGncuAaRPuD4PBPEXDRotkBL4Uhmt1nHBf7cwzKO8HkhM097BaDcKHjJ1/ylJZM4K
	3r67kUqGEXMoWvugVYVmHbiix/SJweoCH/M9LKBRqcxbJ09RCxsh9rQj/K08WpJKq029zXHhAse
	fZ4JpDLRHfdzjNpOlU2M4vrK8ykBq0CJF55o2iWL2XdTDr1jn0yuvhBtS8EKxMD3o7b2eKVDROF
	CtWp74t7nHYH5ob1ACNyqyy9mN2ofy2UT2icpYTC7SR7VkcLagK1VejRI2r//VfsuQhmq9SwZ9k
	GLESVLAyZ5+2jt2+fcpOJas+dvI3W9zfcvk6fuHnLkZczaR4NA==
X-Google-Smtp-Source: AGHT+IHQFapr57pcb2+37HK2NBjkiXNKucItcxDhbMdGqj1jAdnCsUg61o4ITQSx8sezRRbb+bPRMg==
X-Received: by 2002:a05:6000:2385:b0:3a2:6b2:e558 with SMTP id ffacd0b85a97d-3a35c825ae4mr12392803f8f.28.1747750130356;
        Tue, 20 May 2025 07:08:50 -0700 (PDT)
Received: from [10.5.0.2] ([185.128.9.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d305sm16875311f8f.16.2025.05.20.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:08:50 -0700 (PDT)
Message-ID: <5e0eb8b91062a5622b09c5e32f9e662a224d8d80.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad4080: use lowercase device name
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 May 2025 15:08:52 +0100
In-Reply-To: <20250520110101.29478-1-antoniu.miclaus@analog.com>
References: <20250520110101.29478-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-20 at 14:01 +0300, Antoniu Miclaus wrote:
> Update the .name field in the ad4080_chip_info struct
> from "AD4080" to "ad4080" to follow the common convention
> in IIO drivers of using lowercase names for device identifiers.
>=20
> No functional changes are introduced.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4080.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index e8b2e5e7a68a..c36eb41d738a 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -433,7 +433,7 @@ static const struct iio_chan_spec ad4080_channel =3D =
{
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> -	.name =3D "AD4080",
> +	.name =3D "ad4080",
> =C2=A0	.product_id =3D AD4080_CHIP_ID,
> =C2=A0	.scale_table =3D ad4080_scale_table,
> =C2=A0	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),

