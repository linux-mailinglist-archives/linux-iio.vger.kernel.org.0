Return-Path: <linux-iio+bounces-27476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D922CF09E5
	for <lists+linux-iio@lfdr.de>; Sun, 04 Jan 2026 06:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18186300FF9F
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jan 2026 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987782D7DF6;
	Sun,  4 Jan 2026 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaZ6L3Ar"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8D14B084
	for <linux-iio@vger.kernel.org>; Sun,  4 Jan 2026 05:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767505134; cv=none; b=hH/rETvToZnLOdyYAisqZ9SzrTqUzAxhMim8YevHKdCXBDVy92KOftOhjVIzun3pP17nIParfI6a6dchJ/DZlcwlbZ9OQuNYsqHivwywT2b73qSZ6bAU9hnQLlJDi4AFhyCRbWu9AW077ya2FeGA8mf0//6ekp9TgCEQb+ePvGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767505134; c=relaxed/simple;
	bh=1cy/7omDUaB5WW8ifDmvv3jc+tFSD3izpn1YCB7cvj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0lwdztDRJ0LsLuKGl40b596Yq8pexKC4afwvJJGUc7EEb9VPuSjd638fD1qJWcf26v2j3/lyxjV4legIrNoIkMSfT2xKisVq7CNnpvI+si8mXsA3jgB9wElnlc1f3RotwqiD9f87VvuqSH6RqQGcE3xA/STLuXa8kVzy94Zpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaZ6L3Ar; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c3259da34so13786557a91.2
        for <linux-iio@vger.kernel.org>; Sat, 03 Jan 2026 21:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767505132; x=1768109932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BFnxtKrucpWCo/zUoxUrPbX5HS36ZTXbhXduqwcqQ/M=;
        b=TaZ6L3Ar72W5kIrKJWN7Fcr4H0PAkqiw38aiFyVf+f9/9GV0y4OOBfiCbU0OdBNx4J
         MC0MyMJakF9yP5Yd7dFGXjaBR96zXpJuqRKp19XU4L+2oPf1uUWOQkS6Z4mfUSjLLrPB
         qf/ZJ3zwulRMSdsqkiIJBLQ57RQ9tBnXEtxvQixycgB9qKnnIN5hcPKjL2FJ3AkN4Re6
         YNErn5wEphOPviFJA6kdFaSoYO/td+5JUE02R5yerha5Tff9QyW354nH1KDo0r2ZHJfs
         pdbqADO4SVjkmIPGJvJ48FSi7MhBWWWo8x0JT4mXuHEPhgxUjRM99InopLBEkYrdhqEd
         KzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767505132; x=1768109932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFnxtKrucpWCo/zUoxUrPbX5HS36ZTXbhXduqwcqQ/M=;
        b=AVI0a+705uQe2icVXYVMjFFPFUWWhQUOFeQYzDYFmW7toKoLPvbuUrEuTtLshwnyw3
         1sKOvbMv40q8U5LijqEeBZjV8QFqJnsVbdIsMiq3/mjCyrdrwvGMvd7XrjboYcsUQSCV
         uCPQcWaWWVZg3TYrPty+mFhBK901u4KErKH1x76X8Q+hk0+7PDE120/wVWhCLpH95Fmn
         3G7tLhT38vVCEcIXH5wyU9YziYFwYQ4/13BzKORD1rBsipTbQ4hyMvF+vbskzG4WxpE/
         3DMfDQ7PMv/JBvS7Snva0pS9vsoAjX93t77pQWeLtx6k6fbLoyl4l4UzUtay8LJdkxB4
         rB3A==
X-Forwarded-Encrypted: i=1; AJvYcCW5ErzCQyFOgEeLA8/suXxQgL95Y+BZ7jh++UlvntbtjAYeBrWM4qZgz3r1fj9Slm+Vf+GUCsPw77E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5jaRn4GLZZt+3Cd7IhlFWGLOjWIfLBhVMrxEjct7827UVihx
	PbBJhQJ4O0kEbK83v547lkbB+mSnnq7jn8jqEuASAk2wO7q8yw583Hsq
X-Gm-Gg: AY/fxX6KvrxobBbqX1f/tYLUpt+fVP4hsiZTNYW/8WLUgLLdSiry/QFyHkPwc/5IAGh
	TDFMMqRvxk1maY8qfC2jNiVGEyY6PNab8aBst/73796bDdTxGhhUZIw5+Hm4z8Jo+nqOpPlCYGO
	74+6Ina5eD3ZdA3i+VcwkB/0rzoMUGN9VJxzPRFvg5rRMh9+wBeJX0APUxMGJM9Rnj3GdvnI3Am
	LL4D6nWdGgs4wN+cTsQcZguJJn2pvnN3voMT4dI/nJ/21BCLFTgIDR0e0zuTQ0+jIt4MlmSg7u1
	QmmtIdvqU1nINj4v7mzjh0+V/hd9ama6pEdn5zZIPDdpKlle+UGfLZAjEhMLj7Y3lZp+8+CzPQ9
	fbdaQCt5CM0ah/tUq3VBAmy9dhRC/2HG9+jjupT/QR0NzUizRGBQYbGpXO68lZYZNYLB0QX0h8o
	BPhFtXn2phTguGzSp8ppXeiqQb9PNO8lmsMeFaBaVSNpJjahTWgc87hP3iMPkNrAwlg5W0RlNKf
	rNdwR/z6dNRu4XLmaScX5Hzgk+CFmzeKiEmGTx/TsP5aBuhPi1bKAxGWBk=
X-Google-Smtp-Source: AGHT+IFuU8vk9mK3i7jVlpZJLCONCafucoWR4wnV/MEWErIkN9otjQLB08bVxfsOiCswR8zeLPY+Kg==
X-Received: by 2002:a05:7022:4287:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-121723018d9mr53382128c88.41.1767505132287;
        Sat, 03 Jan 2026 21:38:52 -0800 (PST)
Received: from localhost ([181.191.143.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724ddc30sm170899611c88.6.2026.01.03.21.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 21:38:51 -0800 (PST)
Date: Sun, 4 Jan 2026 02:38:50 -0300
From: Tomas Borquez <tomasborquez13@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/6] staging: iio: ad9832: remove dds.h dependency
Message-ID: <7s5n34ucflr5jvn7xpotj7qnp5msf45t37ziydh2g4eej4j6ai@irs5mrlpwcyr>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
 <20251230203459.28935-5-tomasborquez13@gmail.com>
 <20251231180939.422e9e62@jic23-huawei>
 <20251231181153.556f14fe@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231181153.556f14fe@jic23-huawei>

On Wed, Dec 31, 2025 at 06:11:53PM +0000, Jonathan Cameron wrote:
> On Wed, 31 Dec 2025 18:09:39 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 30 Dec 2025 17:34:57 -0300
> > Tomas Borquez <tomasborquez13@gmail.com> wrote:
> > 
> > > Remove dependency on dds.h by converting custom macros to standard IIO
> > > attribute declarations.
> > > 
> > > Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>  
> > Hi Tomas,
> > 
> > Happy new year (almost)
Hey Jonathan,

Happy new year!

...

> > I'm not that keen on having the documentation only several patches later. Drag that
> > before this patch or combine adding the new ABI and documentation in the same patch
> Ah. I'd missed that this is deliberately a no change patch with old abi.
> 
> So ignore the stuff that doesn't make sense with that in mind!

Just to make sure I understood:
- I should just remove out_altvoltage0_frequency_scale
- And add documentation in the same patch with all the ABI changes
  "staging: iio: ad9832: convert to iio channels and ext_info attrs"
  or as a separate patch like it is now?

