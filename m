Return-Path: <linux-iio+bounces-18458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA42A95275
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8813A9716
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C7778F39;
	Mon, 21 Apr 2025 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJIuE7Ut"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DC1372;
	Mon, 21 Apr 2025 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244415; cv=none; b=ZodTm5cqv7fI2sUlFF7tZlddP29w/XYq2Wm6c5Tk5uGv+/2ZUKnkUsx9NRUxeDjjpamw1Y06ZRBGtnM76DkUwGDb3+OTHhoQ1YM/TqZorLCQp4Uu29ten0ohikI2KGMDDaFLpokJGH3wd28iK7lk6d7FVBJcbg5/R2zbs22xdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244415; c=relaxed/simple;
	bh=eJSvP6WoW1OnCWuj048isT9pN6rXqEQM0rSV660pM4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDYRo/WUVboykM4Q2EuTnECH25WrA8gPbWFz0A+DYZvQFlQu84BZliEMAzsIa0O0VKvYB4Rr9VCXZVkdfW0CPRlmvu7PGI5JQCXFh2lCEmLEW2FZ3qBdi+Xq1sV5nlbgJPeULWp+x+pl6nTGq6VTjoZSVX4ewe+Lk3FTO/F1DOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJIuE7Ut; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-306b78ae2d1so3048992a91.3;
        Mon, 21 Apr 2025 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745244413; x=1745849213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJSvP6WoW1OnCWuj048isT9pN6rXqEQM0rSV660pM4c=;
        b=KJIuE7UtsEFsgUYluW4iWmABKcKlasWEMH0GBWqw3NpRayWkdfrK5ScxjIRltkzNsI
         Nlnhgt/ACd0JmJzp5TyVHzCgcS5OkA3ylkoVvlcFHRlZ9ZExBmQ1sNuN3nnJ8Xh+9lbd
         BnLTG83uwK2ykpl5Qb0q4LsgUJjeWIsg7BoJ59U7V9QRdFlXrd9NhW2ebPjcMjt29p9G
         HjjK6w0pAKJGkZ3fKOOEdBFJFg9lcbwKt8MdNYdMdlkRbHfj3gk5aNYpTNl6wuiSb4i5
         UFgaE48MqULx7kQXTT4ct2njgO/CdWvEroTbLBxyHF8VZcVk+sjTzbBrHa+9swMeRSpt
         XQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244413; x=1745849213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJSvP6WoW1OnCWuj048isT9pN6rXqEQM0rSV660pM4c=;
        b=ny34JTij4A1xIEzRxHLL8GwY09RMOgaVqtUkt4lw3+Lx3jQvdK4PgS99GR1nuUrhUP
         3ZbA12f/0t6iQPeiGzAZTtGFYkLYPKv4l4sxD4sU1sxRZl+Sy1PjP//Z0/HjOmbEC2s/
         07YZXM0CItodiwP4lyDORR65lcx0lTWe9x5lZKrpvoSppFPGeDuBUXyuaO8F111+5/Sc
         gWQ2aCZPDiaPHWfLTvKjbe9g2ui42gIqm6FCfM3O/OW61GRYfS7DFSUtVkBCFHDwNIU1
         mKJ/uy5J3k+DcOK0mcqgGXdkCpLA+vdqna5jMa5pvXuZsIkvtoyCvU9aqZWI5It+iZpA
         kJKg==
X-Forwarded-Encrypted: i=1; AJvYcCW6VB9w4Z7go9AvZDbHsparF352h2upi4GUEwQnt9vX+NQzlkbngkl5Z+miMOxb3TSQfbX3Mb3B@vger.kernel.org, AJvYcCX1MyaqpTm9+cFOypV/vC8sv0OhJb3HHatbOwHO8OS1dtX5D4sUxRC5CRaqZD8aEXbDMNJtZDMiwCc=@vger.kernel.org, AJvYcCXVgBhCkkqoar3nHZxq5PlE3wyBYd5aXTMS3E8ZINQfksXsAmkco4kQn9Y91AdlZkd6eUPTUIVf/2eGJCkp@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvEvJaWyGlrFRuxqgxtEc5SuDb+uTZT80p8wHr5gf5O10QrE8
	UYr+cNXYiGpdeKfHHUG6XZaQVVXCjICg3xLqH6w5idG/zyhkmWy1u8hMgCWyW3o=
X-Gm-Gg: ASbGncu/bUmbZeFqCsf8o7mKzBkvhD4F9+ak/ERWbUF2WjWqcvU/JIkgQjN8F52gqvq
	Y/Fq31Q1eh2FxI1Mb/5mAa727cJaOlZbCmdOLMNcfCtWGrXyL0uY6vunqShotTP+zaMDIl4FfMH
	v3FloMMJPvj0nF9906JZf/QnjfYe9S13F5+qfiWGHji1as1wA+84kxylML2HhX2xg6oB5VvxTny
	tQh5IeCRw5tSq+U9Jl7dpn4NNDpq3kAQ9TTSG8UtMCyXClFkyNmWBF/HenKiArxinqIAHTR7mdQ
	LfBYhC4J/qg/akYXvgHRj74V3ALtLjcENQF1fgwPPuxMcjZGBzWnR3phEA==
X-Google-Smtp-Source: AGHT+IEMWH811QnX8SwzsqnyFjLTQnfz+ENu2Dko3yepmQHf59RoumB8vWB9UmZwjeYORmMPBWW/mg==
X-Received: by 2002:a17:90a:c887:b0:2fa:15ab:4df5 with SMTP id 98e67ed59e1d1-3087bccb042mr14746550a91.34.1745244412669;
        Mon, 21 Apr 2025 07:06:52 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50fdf1e6sm65418065ad.224.2025.04.21.07.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:06:52 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:08:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: adis16201: Correct inclinometer channel resolution
Message-ID: <aAZRRfO1AmiHs4Bf@debian-BULLSEYE-live-builder-AMD64>
References: <20250421124915.32a18d36@jic23-huawei>
 <20250421131539.912966-1-gshahrouzi@gmail.com>
 <aAZNCEUejrTgy_yZ@debian-BULLSEYE-live-builder-AMD64>
 <CAKUZ0zLEacGg5cD4wGmFz80e4FQ9A=JsVyrzGAHkKEeOT=CU2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKUZ0zLEacGg5cD4wGmFz80e4FQ9A=JsVyrzGAHkKEeOT=CU2A@mail.gmail.com>

On 04/21, Gabriel Shahrouzi wrote:
> On Mon, Apr 21, 2025 at 9:48 AM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > On 04/21, Gabriel Shahrouzi wrote:
> > > The inclinometer channels were previously defined with 14 realbits.
> > > However, the ADIS16201 datasheet states the resolution for these output
> > > channels is 12 bits (Page 14, text description; Page 15, table 7).
> > >
> > > Correct the realbits value to 12 to accurately reflect the hardware.
> > >
> > > Fixes: f7fe1d1dd5a5 ("staging: iio: new adis16201 driver")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> >
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Should I have included the reviewed-by tag on the latest patch sent in
> this thread since there were no changes to the code?

Not sure I had given a review tag for this.
Hard to find the previous versrion because it doesn't seem to contain adis16201
in the subject name :/
Anyway, good thing the fix should be added to IIO now.

Regards,
Marcelo

