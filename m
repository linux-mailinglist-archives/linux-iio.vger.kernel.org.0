Return-Path: <linux-iio+bounces-10467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A3099AB19
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 20:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42A7B22DFF
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A562A1C9B87;
	Fri, 11 Oct 2024 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPpmdaS/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF2183CA5;
	Fri, 11 Oct 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671983; cv=none; b=m3CF+Ep2vmGkXNUg8QWvQii8f9/OeT821o5AScebpQYmsDksVfrKItVXhZwXk7+vlY7EBycQdx8p92gAznFO2BaLqUkvjrJ57CwQbtuj6Jc2kBqnFwZHwfdZwNl6U5lt6BNRVhrflLMJslGlO1yI+s2mjsYAE+75F2kYNLjUVsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671983; c=relaxed/simple;
	bh=BjmHehEYiieqNpDq/GlpQx/BBNqqkQRnGEJAPGl7DC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLfnEF1yDOgq+jeoSw+HOdtNO7gMPNDuSpjXK7AF4eCIwiCprbkvD4csAgOopNjcQt4iSa2z1ziiBLxNCEWcXeum/vjlUgqjNJPOm/X8Ba0AMM9GoYzSIpbTbBUJ7xCozS5TVYJycbVpOW80sXU+fSP7Houru3lcnCg8eS215/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPpmdaS/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so25572265e9.0;
        Fri, 11 Oct 2024 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671980; x=1729276780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZd3vjq/tmMctPSkLmA2iur97vFbUfqjeAAFAjjUbes=;
        b=bPpmdaS/7fZVR6TZuwJO8qLnabXNmede9LFJjWN67HBMcXmrgyHfltsy8tJk9aK1VM
         W8r2cl6UPRBve52gKMxmE+5a1c8v+eDZFZ2yiFosEa4szkQb1utkvE2jysk9XgJ3ksaI
         GtZpTM1OI/P5KmsL9uYN49L3vIabh1Ik8B2Tzt01KJCOyL67MXsyTrYMOHzmdLp4xjPD
         +h1TgT6GTXbKNz0oPjCISd9mdzWzIr0Iw9L9k1Jls7P8hmmfwZayfwxkVzjuG7ZS1br3
         4yfduRiIQTcUKqWlBSKNQltF61DwcKKGmuaVL0gumV1laStlJ57pEy1SztK//V+ZBpD8
         GG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671980; x=1729276780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZd3vjq/tmMctPSkLmA2iur97vFbUfqjeAAFAjjUbes=;
        b=ZiZId5gJ9szI1fRdUNe5B/pZapow8iTqqIgutyzqr8mHRFLpd6Dw8PsDO3CBi27oyW
         enpj3W6yNYvFayzo7pMvqqtFXjsJSbkF6SyIQnrEQkAoJX8C7vr3ByBjG6azm2Xz9BPm
         //x+s4TYQHgE3ng+qf9hFkBBJ9JB1FVP5jRE6MySJrhOE5amHy/0aqh7BCr2rQVzENBn
         jbNqo7UwdmNzsKllNEZjyGpZos7cuN/5a/DEhYji8Zqp9TWIOIzxC7l+EtemPKvf/mMe
         TH3trCPmN0Qeq0lqnR3gEhry3fYrij497pyE57Lfz3+W+ZpqzWMffyv0cZURiynVyxwC
         3E6w==
X-Forwarded-Encrypted: i=1; AJvYcCVZzCKmtxRYIsO9VbLiqJypYfGX3H7Sz7k9s5nufsuUATpiKWQD97wIsZ2Fqrz0lWkXeyNKtNuxMjeq@vger.kernel.org, AJvYcCVx2VjAO+IDLUjv7pWG2gSzbRwLxvp+QgOJA4OxhWXRzUMa9Rf9tx2H/WEYR6QINWixH0DgK1pABU0t@vger.kernel.org, AJvYcCWa/RvKVSe4c63xcXF0eQrvPNdBJ392ugBWg0g8p1V1uG0FZpueZ1bs8yiSboh9vD8r4nGyTWUP8u/27HNT@vger.kernel.org
X-Gm-Message-State: AOJu0YxR3XQLg7ZVoiJuGoGi9G6J3+VIEFqjqY6iwJ5Gc7q1nnkx/xGZ
	8+2Fuf/2Jc4AH9lgQ7N/CxKtjETz5IP8oalIqTsAkFIS4sU9YVrE
X-Google-Smtp-Source: AGHT+IGX2zS2nstXpg6SsT/vPf49c6EfYdf1f/gcUWCtylET2lJBwsm299NphqGeiEKFawFQofaaMQ==
X-Received: by 2002:a05:600c:5251:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-43125607846mr4437365e9.23.1728671979747;
        Fri, 11 Oct 2024 11:39:39 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f896sm4513805f8f.87.2024.10.11.11.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:39:38 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:39:36 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13]: chemical: bme680: 2nd set of clean and add
Message-ID: <Zwlw6FvJrGRARYVc@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <ZwkA_NW3xLi3dxMb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkA_NW3xLi3dxMb@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:42:04PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:17PM +0200, vamoirid wrote:
> > This patch series is continuing the work that started on [1] by
> > improving some small issues of the driver in the commits 1,2,3.
> > 
> > Commits 4,5 are refactorizing existing code.
> > 
> > Commits 6,7,8 are adding DT, regulator and PM support.
> > 
> > Commit 9 is refactorizing one macro to attribute.
> > 
> > Commit 10,11,12 are refactorizing the read/compensate functions
> > to become generic and add triggered buffer support.
> > 
> > Finally, commit 13 adds support for an *output* channel of type
> > IIO_CURRENT in order to preheat the plate that is used to measure the
> > quality of the air.
> > 
> > This and the previous series [1] started with the idea to add support
> > for the new bme688 device but due to the structure of the driver I
> > decided that it is better to restructure and improve some things before
> > adding extra funcitonalities.
> 
> Besides the small comments here and there I think you need to rearrange the
> patches layout in the series.
> 
> In general it should go in these blocks:
> 1) bug fixes (if any);
> 2) cleanups (note, whitespace-cleanup-like are the last);
> 3) new feature.
> 
> Note that PM runtime belongs to the last group quite close to the patches
> where you more or less start using it more.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

Hello Andy,

Thank you very much for taking the time to review this, I appreciate it
a lot. I was not sure about the order of the patches but what you
explained here makes total sense. I will rework the order and address
the rest of the comments.

Cheers,
Vasilis

