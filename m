Return-Path: <linux-iio+bounces-11898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F359BBA53
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 17:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6C01F217A2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1F01C1ABC;
	Mon,  4 Nov 2024 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGGdLSe7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130D4A08;
	Mon,  4 Nov 2024 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737600; cv=none; b=W9CTUcinGyy/+Tc4VZ7h3GBOoOA9b+2d9fZQ8N/3e3VVZMs6dGOPoXw1fWufqvft2tM59CUEIOFIjLKKRk9moNwO8rueuigTKY4LSY15qLwiHMN0GH5Z8o8ax01y9QfgCGM0ptumjY3PzQ1z4JEJwMhyVTBmAwvsOklorULFn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737600; c=relaxed/simple;
	bh=7R3Dk2gJ543VSNlT8vmuLD0jP6XJIEys+cP5iYmfBfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiDULc9p/JHz91XIrSaheyv7FtXFX5BRTDxA5rfOUyK8LCVN0vcaNXfVEC/xiMuRO7FFXNif17Si++hvHH7nQ6EF1P/xzW1p1eOKOySIOrMYvw1LnDGor/7eSkbqOeScTAS/5KCnJwb5f5XL1W4ugiqZ+y8abZi/CkAiOEuHtbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGGdLSe7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb7139d9dso39608785ad.1;
        Mon, 04 Nov 2024 08:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730737598; x=1731342398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0z6VRhmL+riFADmXem2uFU7dggIvvunuyK9Zh9Vgkqw=;
        b=HGGdLSe7rlpHfAofstRzW380umdd/rkMQTyj4+j566I1VegCgV8cYeWUE2cZXILnq8
         ZUN19C97wc7HyDRmpOM/qfqHB3cU+gAJbxDAvCx4gMmfEA+8Mv6TyXesGxd1L7FkgYmc
         ufYT82YoLX9OhQWVuW6pj1mcvw+K4b3ZPF3yz2Sz3YWNJD56cHXJUr112dWN03BzX6Tr
         3CONSTPZOV13DkDUAs1T5Ux8atjZ+kBN4hJVXpsnG56t+RZD1nbLmTcCRAaxWdgNcg/5
         HsTP3e6lgSSHL5jEiDS6AAvysB2P86ElxZEGFnEgSkW4TgzfILHCev5uWGOGfEtQNN2s
         cr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737598; x=1731342398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0z6VRhmL+riFADmXem2uFU7dggIvvunuyK9Zh9Vgkqw=;
        b=L6MnxlFUyl7vVsu6ZWE8IjEpRcPxWG2yyErjIE3QtzRZMHYCM5bhVycNY0IeXGIWma
         VRUntdZuxn8CiBZqjprhPbirXhmbAkaC7fJrTHQVgzJtUdNOUrKe5Azttr1oMHhc16T5
         OqiR4aUtN6y6qIgsUWijg+d4wB6YKF4HpXCLuy+9dSyzw8hdFPrYVvbfd8JgjRfZ5Q+S
         hFaAPB0RebXhEsprwwBkqvc3uPgJ4UXO5oxmVK0PGiKgf+SWe7xMHA6dCvzFUsSp5nMr
         xMrPcqqLELxbEacJ/s48kyOFDag+XHiWhPhXU5uIHJ4Zvd/ApV/WrN2+VakiRb2xauwk
         E0mw==
X-Forwarded-Encrypted: i=1; AJvYcCUy033TEZXe4VCyaWvk+RpKlGCfXX3cbLQxzkHYbO/jeWWST+xSN2Q+swmshRpU/6j37BL0sfPpA460MJQF@vger.kernel.org, AJvYcCWr34lVUuWwuG2ZFOxlAtzms9CbasdzlAIQ9kL8/ZO3VHAMn2T4bREsXqxmcweLpwRfxAfILP/RBm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAh66oD5Nqs1dSNLSSQKRuvasY1UPqIrpbjPgrHSx3psBXtGo
	VpNqLyO2+EzogTTLlOc8ZcYNvNX0HVM8jFq9ZrVRbYkt/f2NXT3yDz6R8mYlbEY=
X-Google-Smtp-Source: AGHT+IHl1idgZsKyhWYsf7s0AoATg2Jw6nH4qo4UBXojQLFOxileExNRi8STmwbVY73p2VdWdA6GJA==
X-Received: by 2002:a17:902:d4c2:b0:20e:590f:58af with SMTP id d9443c01a7336-210c6877322mr435198045ad.1.1730737597584;
        Mon, 04 Nov 2024 08:26:37 -0800 (PST)
Received: from Emma ([2401:4900:1c97:5a7:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21131de4918sm39213525ad.5.2024.11.04.08.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 08:26:37 -0800 (PST)
Date: Mon, 4 Nov 2024 16:26:31 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup <anupnewsmail@gmail.com>
Subject: Re: [PATCH] iio: invensense: fix integer overflow while
 multiplication
Message-ID: <clo3nj5fokr47vheikv7nozr2exzha3rwkyfqq7n3s6vqyglzr@g6eu2ycy6gzo>
References: <20241103-coverity1586045integeroverflow-v1-1-43ea37a3f3cd@gmail.com>
 <20241103111827.0894a40a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103111827.0894a40a@jic23-huawei>

On Sun, Nov 03, 2024 at 11:18:27AM +0000, Jonathan Cameron wrote:
> On Sun, 03 Nov 2024 08:43:14 +0000
> Karan Sanghavi <karansanghvi98@gmail.com> wrote:
> 
> Hi Karan,
> 
> > Typecast a variable to int64_t for 64-bit arithmetic multiplication
> 
> The path to actually triggering this is non obvious as these
> inputs are the result of rather complex code paths and per chip
> constraints.  Have you identified a particular combination that overflows
> or is this just based on the type?  I have no problem with applying this
> as hardening against future uses but unless we have a path to trigger
> it today it isn't a fix.
> 
> If you do have a path, this description should state what it is.
>

The above issue is discovered by Coverity with CID 1586045 and 1586044.
Link: https://scan7.scan.coverity.com/#/project-view/51946/11354?selectedIssue=1586045

Should I mention this path in the commit short message?

> > 
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> If it's a real bug, needs a Fixes tag so we know how far to backport it.
> 

What kind of Fixes tag should I provide here. 

> > ---
> >  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > index f44458c380d9..d1d11d0b2458 100644
> > --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> > @@ -105,8 +105,8 @@ static bool inv_update_chip_period(struct inv_sensors_timestamp *ts,
> >  
> >  static void inv_align_timestamp_it(struct inv_sensors_timestamp *ts)
> >  {
> > -	const int64_t period_min = ts->min_period * ts->mult;
> > -	const int64_t period_max = ts->max_period * ts->mult;
> > +	const int64_t period_min = (int64_t)ts->min_period * ts->mult;
> > +	const int64_t period_max = (int64_t)ts->max_period * ts->mult;
> >  	int64_t add_max, sub_max;
> >  	int64_t delta, jitter;
> >  	int64_t adjust;
> > 
> > ---
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > change-id: 20241102-coverity1586045integeroverflow-cbbf357475d9
> > 
> > Best regards,
>

Thank you,
Karan.

