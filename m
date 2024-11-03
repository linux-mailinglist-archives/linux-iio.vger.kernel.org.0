Return-Path: <linux-iio+bounces-11870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB79BA617
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 017171F21771
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D117C234;
	Sun,  3 Nov 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVU8b3ug"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741711714C9;
	Sun,  3 Nov 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730645851; cv=none; b=rdn664tKqrdM7OdNBeof9khFs2t+5uGmG8i2LEPxXzHFEdjVOnm27l6g2BybTZm2IgyeQwCz3sxMsQJ1TcMZDzQM14DEBWhr8YWofWmdC2MP8guoNsRhvQVnAVDbJ3bWfKqKqixDsuNmNYzLKmfHPRaKUnlDwRAex02Iy+y4XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730645851; c=relaxed/simple;
	bh=EOsvNzuZPbWSw+k1ZdiEsy7Q4yXtJ7tmRLNBP6XVcFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvr5//+M5mF/077f1ik5ioIIp8atyNqgLj0Qf4YXweuExJ6pDuulV13zy2pUnmQXGtHQ+SXVJ7AdKHLSkdNhy2hBGsDb/LlwvD58GmizYRqGb/Zuyl/gtBylgE9sP0skZ7Qn3MhBn+6Z55p/6j76jlNJ4R1E1qkSg686asEnxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVU8b3ug; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso600486366b.2;
        Sun, 03 Nov 2024 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730645848; x=1731250648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l70JIgOc7IzpCaPrM3FJwtrkPdLAYJDlpQSQ7yaSRQg=;
        b=ZVU8b3ugRBO11jsOHaH7bBTnQc0e4Jt9vJIIcPqXtvkHfEceSl703KtwxwZadMCPzw
         3VF946q+/gskAQvVJF4NXH/7FLb72yxaEfYLSAoAtDqgffUNd5Esnz2gV9OyDI0yiuwl
         zhI6yBm3pzr8GDKZBCvATOoaKj4L7AyTB1JDH/z4zef0P2fTN4S9hE5o89PAfKeXbfas
         AQTP24h2W7lIJqFcrOXHN2MWbaD2YRd2UjwR/IGOBdngfYuOnb86Ej/6T9XuGj/rRUgX
         LJDkc4TIKbLGBvhLE0Mw9Vw+EfO2VMUO7p2TcgmhAJgwnDV1/z6O8p35UILTD9msi2SS
         x6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730645848; x=1731250648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l70JIgOc7IzpCaPrM3FJwtrkPdLAYJDlpQSQ7yaSRQg=;
        b=rjzZ+DSYwo79RF1ol+HzI2rKOyoAr+ULYAAA/SY+ch0J4c0/buV9x+NOIgCbA58hIS
         6XWULJMgb+mXzmXszr98vHfJtgctOYFsF9+hxcnekcq9UMlrMVNZGiU7ekMNgrR60yqh
         sYDco0FvIcymZwG/y0Izn2WCXsonezfIjDZYR4a6yfniNR1IoRw3jcBXrkeSWMF+e4l5
         S9V5omm1r4/UkiwemTgbFtN8uEl+t7z51k3ztptYo281bHt/8vVmGBZq/YK3/hXuafch
         y1TY6ECIsYUhcw+fISpmRWfuz0BqZF9uGUTJf2ISxiW2aSHAx7d7DN4jjOFnoviDUoq/
         uETQ==
X-Forwarded-Encrypted: i=1; AJvYcCUey5XZWTOMgKzXDXflygNVcm6BTsGRL6HZ+aQyGLTiripFgzqPXM+e3GlwnqMY9mozIlkJD8qWQrji@vger.kernel.org, AJvYcCVBsW2QdwfRJG/fcS/qdtsExJA2rGOK1W0iSVcTN7lvAe0v/aU+03VdqRbGe3Im+mL9/cg8xKEjG4N1TS5T@vger.kernel.org, AJvYcCXQm31tug+R83wnQAEOTslFQ0kL9QLsYGtSVgOf+cuOofx6TZ70JHfrNpSHFqxest2jJha8CBWAD6MZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUD2jqswVWKtdsPoawy46dYlFXA+vtMsg46i2G3qHXmbfB6u/
	nTUzDmBcpyJROcZnq8OvAYr4LUBxvseLYdoIYoGHYJLJCZGJkA7FI0WbrQ==
X-Google-Smtp-Source: AGHT+IFS9BezNhD2QcpuQw2ndnCLizdvkhTKmF4tibAAksPwAWzbjtK9FXV8UoZK4ALtenLknKx0qw==
X-Received: by 2002:a17:907:1c22:b0:a99:ee4e:266d with SMTP id a640c23a62f3a-a9de5c91a9cmr2884313766b.1.1730645847510;
        Sun, 03 Nov 2024 06:57:27 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:c24c:5620:73cc:ab84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494295sm438447366b.14.2024.11.03.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 06:57:26 -0800 (PST)
Date: Sun, 3 Nov 2024 15:57:25 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] iio: chemical: bme680: add power management
Message-ID: <ZyePVVk6jzQPsjSF@vamoirid-laptop>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
 <20241102131311.36210-8-vassilisamir@gmail.com>
 <20241102153512.5b93efa7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102153512.5b93efa7@jic23-huawei>

On Sat, Nov 02, 2024 at 03:35:12PM +0000, Jonathan Cameron wrote:
> On Sat,  2 Nov 2024 14:13:11 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add runtime power management to the device.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> This and previous patch look fine to me.  Just need to clean up that
> dt-binding patch and hopefully get a clear direction on whether to require the
> supplies or not.
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

Thank you very much for the review once again!

I will wait as well to see how that evolves and I will send a new
version, thank you!

Cheers,
Vasilis

