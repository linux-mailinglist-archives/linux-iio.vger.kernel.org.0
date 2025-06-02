Return-Path: <linux-iio+bounces-20167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3088ACB9DF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD742189B7E6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 16:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ADA2253A9;
	Mon,  2 Jun 2025 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4guQdPu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE8221280;
	Mon,  2 Jun 2025 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883171; cv=none; b=b0WPd5ig0eLIYaHaPodTggJssrE3+04w7M/d5wIRCkiojpvzzo0Y4tU8HLfGACOhA9Pr1yzhdpbbrD72oPECugllQgkRdPjcplIjgV638Tq/RW4jhirL7qiLOQ1HpMmFCSA2Ywuws/pGXQ9U1zFjNvVaAS4bhMYsDDpnJUPa8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883171; c=relaxed/simple;
	bh=ePf765SQYuwJZAPdzzPBFspRg6Q3ylotrkU8EfBBeHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRsOjreXV2z5cf9Q12a/Vfm0HtzfTuiPqBafXFiaqtCv+1Y8xmMVzlL74cXpxqHFwHVyhgXh/c7aFgVqYNQNfNiGyg+jjX/nxag56TL4mYtaT/OxYjQm0Jxm8gwzr+GQPyYNLbbqJ0/j2MteZ5prtQ/eVodfj0SZqlRqWxp/sXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4guQdPu; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-527a2b89a11so1790577e0c.2;
        Mon, 02 Jun 2025 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748883169; x=1749487969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UaHylnij5ODN/rPLDB2SjQz/P4QohjD/xWcVVYel2fo=;
        b=Y4guQdPuiwoDdzc2ilerX/Apcj7Onufr1LlkYV5CiVxppK4XXTLnsTAvvPrD9IwfQ6
         rkrZA1iDrs0scMvtyxnUt+4AeCpoqfPRnBBt6JZHSqxpzzR8JepDA82E6C4flmETujge
         fQ4BQ6SR2Mgjv7Faz4njz1qZDJtjorK8+fJ4dSgtOL/+VSgzGi3nK3EB+he5Id5yREk6
         K6YP3Ox1ArfrJ+5qDegW2oxEII86Y8U//A0dH5s7/cGxbqibABVjHylhBzKCG2hoe2rb
         kILHUu6EfYA/Ygvz66O4M2K04D0HH4EAYd8BXRe7JsAI1APGerME7iLHjkxy5hQNn/Mp
         m9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748883169; x=1749487969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaHylnij5ODN/rPLDB2SjQz/P4QohjD/xWcVVYel2fo=;
        b=SAiQvLqOyElu1FA6v6m7kXz5IGt39dBh7xxMhqSN98J1/LYQWrpXS/3vLaIObvT4hw
         Ook8r4x1T+DWzno3GUYomXyFwIuG/hn71EvE2kDTZIGqYGGjTyE1jll1/sOjATwhg47o
         ddgg9wx5y0lb7PZBcp3P3tL9+U52AvbBT9ZjtsEzyRj2w8fdf2VHCfl+5cmhnlU1/Ri9
         o72zZRQ8QrUSLqqnMFEcS8zJJuK3x2y/lwJv/WZlBXlPbU57zZ5hf93ntTibX+G7XNtO
         bQE82uGXTPv1EXVp7b8KZUsSjSqIUx4+gZHi3hY8DGRcb3REw2JWqJ6dG3r0Os3zyGPn
         PXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY1HirOpy3uUKdEG6Wfr8xuNsjgYD7hOU3a/nE/XGlIulED88MYVbx63cYwjVEp2Sm6I4nvP0lk6fjzeDF@vger.kernel.org, AJvYcCUzGwtfAOKYdB1zoLR4TKd56eVe3IWJ48Xf2MDXwDrBWFKWF3sCY1dZ4FakaYpXeP27Ipyblf99coAg@vger.kernel.org, AJvYcCVW6gxc692nH2SrKwLq2Qa+pTBiaHKb6qJf1j7by6YLzHo4J4NztyIVjv6hggZzinOgaco7sYwTSxAlyw==@vger.kernel.org, AJvYcCWGHCGKfDIkQMi9dmCpOqtjfBir2Wf3qMKeSjv5y38Qi/et5iFUEi1IqiYMjh9AkxU1yZXeTvAC0M1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyM92LcnePVGGT1rJYjhnmTd+sek2oNGQCblFCTY3m66zmRQnAp
	7nhV+6zMvL0iLn22CH14/fm4zil5EQ1q5Jn17hukIul+O8lwttBS4FfE
X-Gm-Gg: ASbGncv6TPQFdh3kc6QGhbyQbZDEmrmPltX6tyGwRXLNcv6P+GhrGKl1l+gs1iSwyWK
	19OiZJ23W4CFGRLJshExLAuEjaohtIuk1+MZb5FncXtHvBKGcKG41IBV/2g3M6tbAtmszaw2sPu
	ceuFDXOwBDQLxiOU3t3o4t4z7Uyez0UaLvY8PqhlV+72TTcV1++c0imYz2FNV5H6bHExeBcgWnT
	MDj3w5e6g7V2QtU+BqFGeQrfg+QT4unTKVJjyZz780a73XZDmcUZltxwlbFsJHMwFp8QrZ+UUQU
	iZ58KTD90uFSiQQiFwtolU4+wFVSU3yidG5WD9YL7av8dAFscjagY2nzBBuGpsuegpIZbwy7YC1
	cAcNS
X-Google-Smtp-Source: AGHT+IEdZ3vdLWHi5wrwjpkN9fh88F/jznYlhx4DCKgBK46LxS+SxZlTBGaOLUAZuZ12R7bzJaBKMw==
X-Received: by 2002:a05:6122:8c0d:b0:520:4996:7d2a with SMTP id 71dfb90a1353d-530811020efmr9909613e0c.10.1748883168825;
        Mon, 02 Jun 2025 09:52:48 -0700 (PDT)
Received: from localhost ([2804:30c:406b:9100:2a26:16f5:c81:e61f])
        by smtp.gmail.com with UTF8SMTPSA id 71dfb90a1353d-53074b09342sm7796437e0c.28.2025.06.02.09.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:52:47 -0700 (PDT)
Date: Mon, 2 Jun 2025 13:54:25 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v4 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aD3XQfUfxIiz62ZU@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <e79f9a126672b33b8a7c01f650fee43a68c74029.1748829860.git.marcelo.schmitt@analog.com>
 <aD27cobHWeBX8o30@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aD27cobHWeBX8o30@smile.fi.intel.com>

...
> > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > +{
> > +	/*
> > +	 * The use of static_assert() here is to make sure that the comparison
> > +	 * is adapted whenever struct ad4170_setup is changed.
> > +	 */
> > +	static_assert(sizeof(*a) ==
> > +		      sizeof(struct {
> > +				     u16 misc;
> > +				     u16 afe;
> > +				     u16 filter;
> > +				     u16 filter_fs;
> > +				     u32 offset;
> > +				     u32 gain;
> > +			     }));
> 
> I think it doesn't make much sense unless one uses memcpy().

memcpy() is used to update the setups after reg write succeeds.
Also, previously, memcmp() was used to compare setups.
Since struct ad4170_setup has only unsigned integers (no floating point fields
like ad7124 had [1]), ad4170 works properly when comparing setups with memcmp().
Though, it was asked to do explicit field matching on previous reviews [2] so
that's how it had been since then. Well, both ways work for ad4170. We can
compare setup with memcmp(), or do the comparison field by field. I don't mind
changing it again if requested. I guess we only need to reach an agreement about
what to go with.

[1]: https://lore.kernel.org/all/20250303114659.1672695-13-u.kleine-koenig@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/20250504192117.5e19f44b@jic23-huawei/

> 
> > +	if (a->misc != b->misc ||
> > +	    a->afe != b->afe ||
> > +	    a->filter != b->filter ||
> > +	    a->filter_fs != b->filter_fs ||
> > +	    a->offset != b->offset ||
> > +	    a->gain != b->gain)
> > +		return false;
> > +
> > +	return true;
> > +}
> 
> ...
> 

Thanks,
Marcelo

