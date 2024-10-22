Return-Path: <linux-iio+bounces-10936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B599AB0B2
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 16:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAE51C2151F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52A1A072C;
	Tue, 22 Oct 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6H/oWR1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D25184540;
	Tue, 22 Oct 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606903; cv=none; b=J3asKT8TvrCzkNqYjCCFarQaetKTQPX9zqau7J5fmK4g8UmdUSnGLE9d/peEjMsmi0/xsBz6TXB7uQ0U57QuIAtPhYlcu7zZinvwXF4ps4ItYpaM9Qsoyudh4et1Jxwr54z03AheM2A2z9wdrhor+U+qbWF6lnwKmiPoA2BfUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606903; c=relaxed/simple;
	bh=zb2pZFilP0FY1yJLNmlNcBBInrhhxeM+cH9SmHa58jY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Poek682vsG52TDGe2b1qCnFtCfDqpWmlg2F/4Q2t+X9erk+fC7maQOqEc8c/jCgdGDBIoGKVQCWOn/7LHe1J9DLRbpq6dZ9o/6tKojQPtbUTJ7jPAixYJAGPgRj1mH3jIN3vLm4mYcfMbQtYUUlrYP4jmTAbQYvNTdUJk/eTpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6H/oWR1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43169902057so33190325e9.0;
        Tue, 22 Oct 2024 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729606899; x=1730211699; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MolLQzD331lVbYoy6Af/QEZhpzzcOB1L48eCfOQYL8A=;
        b=l6H/oWR1QakLlRpU5u933iEWcl4Dz+IIjFfcjT7JGkU3/EBUP7XKwtUXSt0U5Y/VC7
         pwSZPmwb/mHyrlvvjIBOhCTf+8FNdbfLtfN/7+9Tx2/tAi0ehqkGRYDyJWb0snbXKDpQ
         8bYinq/RRWbL4PcTD622WJULY30Z37M1eOZjes3HNTmFy4mAtHZdvNiMX7jgYcmNbaVZ
         kgUGtXTRvXyG+UAGao/japTUY+tTKd90grCPmjrassJPijdEq6lHe3J8hyb47fZCeuVR
         b1Dml3c1dBLji/RM05MUTdjTpKEKOVb4l34QQzzA1YS/vSGWfdDim3m2DHVJoQSlu7ft
         gDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729606899; x=1730211699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MolLQzD331lVbYoy6Af/QEZhpzzcOB1L48eCfOQYL8A=;
        b=vDsz4GNXTzwAaxyLO+6UrcCasib4REgAJhl00ouyAewZ/ra0vZ5EyF6PMtnm9SiJla
         vCSeO0tPAIwazTQt1ia61/ae4xUq7MnbmF05yYYlgoapEflbqRoZQ6n6ocv0ki2HqURh
         535KHWtCReAAUsvIhArUWRvFn7Yj4NAVaU48fhW6xJ01Y+3RqxAMtCdYyptwO2XvH520
         lnBKrHjt8pg5CErtGO77QkjhcrDdUmYF6wC2bJ4ya4SrRY1JPN3qphL4UfgKpaWWUuaW
         mwFcPn6KyzODbQfROengoCEuHnal57v6LFdxbqDtGFUhOx6dlFRyn+KtyvCElc0ouI7d
         Dr9w==
X-Forwarded-Encrypted: i=1; AJvYcCUcdSk6ws5gj0GwMFc5MwEfc4LxHYj8ZnGgXSzjhciJhQCVUo+h2xEAztKe+jE5wXfFrHyJmz/cX8/4eWnn@vger.kernel.org, AJvYcCXYfkCle1yNtIZ0ghdFvrfo3xQl6CnPRxGCZa1pmIGF2TA5OnURHIf0MApajOPsTuzeRrprlsxSlnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjb7jJLuAD2FJA9pQZl0x6FMlPx8kClgf4Y3DHAVYtV9s4V9M9
	jn7uGdu/OS2zUuvCj+0zyHw4KeXanpLxCoJgs0vgDK+kU5r5FTSU
X-Google-Smtp-Source: AGHT+IEOr9f0Msf1K6xaBWxYFYQKEceNzf7UioGw0VW+ts2gOu+AVYaDIU5aZv1ZsU0lEFe/ws1dAw==
X-Received: by 2002:a05:600c:1da7:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-4317b915dddmr30059155e9.33.1729606898892;
        Tue, 22 Oct 2024 07:21:38 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37958sm6750173f8f.15.2024.10.22.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:21:38 -0700 (PDT)
Message-ID: <3b20cb3c06b7cc196ace5ee0a113b77c99be2504.camel@gmail.com>
Subject: Re: [PATCH] drivers/staging/iio/frequency/ad9832.c: fix division by
 zero in ad9832_calc_freqreg()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Zicheng Qu <quzicheng@huawei.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, jic23@kernel.org, gregkh@linuxfoundation.org,
 	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Date: Tue, 22 Oct 2024 16:25:56 +0200
In-Reply-To: <20241022134354.574614-1-quzicheng@huawei.com>
References: <20241022134354.574614-1-quzicheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 13:43 +0000, Zicheng Qu wrote:
> In the ad9832_write_frequency() function, clk_get_rate() might return 0.
> This can lead to a division by zero when calling ad9832_calc_freqreg().
> The check if (fout > (clk_get_rate(st->mclk) / 2)) does not protect
> against the case when fout is 0. The ad9832_write_frequency() function
> is called from ad9832_write(), and fout is derived from a text buffer,
> which can contain any value.
>=20
> Link: https://lore.kernel.org/all/2024100904-CVE-2024-47663-9bdc@gregkh/
> Fixes: ea707584bac1 ("Staging: IIO: DDS: AD9832 / AD9835 driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/staging/iio/frequency/ad9832.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/staging/iio/frequency/ad9832.c
> b/drivers/staging/iio/frequency/ad9832.c
> index 6c390c4eb26d..492612e8f8ba 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -129,12 +129,15 @@ static unsigned long ad9832_calc_freqreg(unsigned l=
ong
> mclk, unsigned long fout)
> =C2=A0static int ad9832_write_frequency(struct ad9832_state *st,
> =C2=A0				=C2=A0 unsigned int addr, unsigned long fout)
> =C2=A0{
> +	unsigned long clk_freq;
> =C2=A0	unsigned long regval;
> =C2=A0
> -	if (fout > (clk_get_rate(st->mclk) / 2))
> +	clk_freq =3D clk_get_rate(st->mclk);
> +
> +	if (!clk_freq || fout > (clk_freq / 2))
> =C2=A0		return -EINVAL;
> =C2=A0
> -	regval =3D ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
> +	regval =3D ad9832_calc_freqreg(clk_freq, fout);
> =C2=A0
> =C2=A0	st->freq_data[0] =3D cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIF=
T) |
> =C2=A0					(addr << ADD_SHIFT) |


