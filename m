Return-Path: <linux-iio+bounces-5434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CF58D3585
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13B028859C
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8CA1802DD;
	Wed, 29 May 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWCiGihk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DD1802CB;
	Wed, 29 May 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981904; cv=none; b=O6wvBEVbH0AUyvdaH7qvnFcFSeW5oKbduLgraHOljM+VGK6SGXqk2qonLZONUCqvp475hlm7SK35/cHthRONTRgNVCXjisws7cY3Inw+7LXhFTDW+S7On5DmOhVwck9l0U8+4zsHbVgZqRSOSGrLi2uYXtFgEAAGY6xJFB1yWUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981904; c=relaxed/simple;
	bh=TzZQrzj+WOG1xkO/GYUZ4HiFLMiivXVoPSh1a4x0Q04=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cl3+hyZPg2YTyW3G9IAoyrvNv49oIW3a/Nrg2liSL51PstGemF5lr97tdXm88+Luvg4E7Z6RRrHsPvzIHzYw9Xkh9lUztEjV/LKdKxQfsSQw5dEzAXO18RgLGeyacVTiJqEHxF5itHDkVbRMwH79grEEt3QGzJ0BL2QzdZhNLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWCiGihk; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so1019651fa.0;
        Wed, 29 May 2024 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716981901; x=1717586701; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n5uEzMRdxtO7RULJZB7deduoIw+Y3iKQ4EZq8+uKKOA=;
        b=nWCiGihkAaNbGw7J6WSCHUCT+oArcKhNmrx1SfU0glADSHBFulm7SjHtf+pexR2ZqW
         0KQ3eAlHpamNcs+ms5QrVagO3U6L607Lle94gg9x0HmhgX/Bx0YKA7wvMojfI+8z3UFJ
         W61+wvANKzUFplphP+h9De31dwwYfIWuEg4UFhCeSPbP5dYZeKwNsSHvl3+SJWzmcfb3
         7n+CFaDgYadE3qeyTpCixUyC8ZLIv3cDmmX7QYiJREnsdPkmn3ULtKWO3yRGpnPgNpDg
         MXjQ2Shux4JNklJVW4iuFGFRYW7hi92c2MjglSf8FAE9YzSwcHCgj7oSBHKrwrFaelWp
         IHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716981901; x=1717586701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5uEzMRdxtO7RULJZB7deduoIw+Y3iKQ4EZq8+uKKOA=;
        b=BsHgWCAUm7luZu8POLkxGCkAK8nwjwonSaNV3Ii8WKkjhzI/Jhx9Yb0xLCS/R5lmHu
         PGI3eyoJzgp/zDwcKQWFrzKiBCLGGJDWisyQGJhtogLf+8wNCUY2U7JTEXLfdUPtIpch
         eQJJf051MS6oi/iwLdRDxJ6UP7ZKbRU5W3snJUKgtkRKopaVw/Fx7eRLZLOzNIyC8fgs
         a/xhbARwvsaK72tRNmB3h0DH7ysnosIxCmFlIedGGX699pUmjr+lzxyG8MgBNkivYyPP
         yW9L8RCPzoDifXh4qqM78rUHMC1TC1/VzjGvGWPn59OjtTgLc69i1ghBTZi5IDxaJtIq
         kWeg==
X-Forwarded-Encrypted: i=1; AJvYcCWu0DEApheNN8kCnvWrX7eRzYBk48kWeG/NSv7dkTE6lgw944DPZaSr89+oaEV5XtmlphrP7urH7+eDreqkXoEaovj7k+RxL8cNUnQs
X-Gm-Message-State: AOJu0Ywez/PiS+a2cjvsovcHOvIzvB3qEQI7UYapx0y3ldQo4lS5IeA0
	t0ifapZ7pvTgp6ISe0wKBcpid5H3oJJ0eGvemP/Z9dnscRE48SMG
X-Google-Smtp-Source: AGHT+IFrPvh7qeKnY8XKng8faeG4RHzsfNVpq2beLpTDGHDt1ahg4B1fMWblmIksy9gHtLUqFTZeQQ==
X-Received: by 2002:a2e:9810:0:b0:2ea:7d9f:8f62 with SMTP id 38308e7fff4ca-2ea7d9f917bmr10742401fa.10.1716981900672;
        Wed, 29 May 2024 04:25:00 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8c287sm710848966b.162.2024.05.29.04.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 04:25:00 -0700 (PDT)
Message-ID: <23d5359dca83dd803655b0990479f6fb0eadc61c.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: linux@treblig.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Wed, 29 May 2024 13:24:59 +0200
In-Reply-To: <20240528233008.191403-1-linux@treblig.org>
References: <20240528233008.191403-1-linux@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-29 at 00:30 +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> 'adt7316_limit_regs' has never been used since the original
> commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
> driver").
>=20
> The comment above it is a copy-and-paste from a different struct.
>=20
> Remove both the struct and the comment.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/staging/iio/addac/adt7316.c | 8 --------
> =C2=A01 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316.c
> b/drivers/staging/iio/addac/adt7316.c
> index 79467f056a05..23d036d2802c 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -209,14 +209,6 @@ struct adt7316_chip_info {
> =C2=A0#define ADT7316_TEMP_AIN_INT_MASK	\
> =C2=A0	(ADT7316_TEMP_INT_MASK)
> =C2=A0
> -/*
> - * struct adt7316_chip_info - chip specific information
> - */
> -
> -struct adt7316_limit_regs {
> -	u16	data_high;
> -	u16	data_low;
> -};
> =C2=A0
> =C2=A0static ssize_t adt7316_show_enabled(struct device *dev,
> =C2=A0				=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,


