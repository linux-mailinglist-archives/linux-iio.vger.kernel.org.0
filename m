Return-Path: <linux-iio+bounces-10469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C899AB57
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E61C225D6
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 18:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0C1C9DC9;
	Fri, 11 Oct 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7mE7FC1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47A1C2DB7;
	Fri, 11 Oct 2024 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672332; cv=none; b=IzDAfsoZpp+/HZtCF+7S8ODfBz8/f0VFSdq3r84QGH7G+XUZjfOQTNXD3c+KOTIjWpuG0L0aoUfekEGnG41aXUy5g2TEhW2+/O9DJS0DYU1lx1fhmylckvyxhkydYtM0nnBSjDYBXxCsNJdZ61a0FzmmhFqb9VslkhMopaq4K28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672332; c=relaxed/simple;
	bh=wraktrblQiTB9JxWAuex6XbMie83pZLaU0C9AZLoeVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaOWXVR2MnPanHzDiEkgqVTiBzf3+1efKdQhwsif9uAFPLL7iKqi4ZGv9basTWd1vuXkXHVj3Q2AM3H4VXH16vXaXAqRb/FhPGDndoGGlbdd8mWDKGKwOlhZsgXttaGt0pHwC4lFjRcI2zYg/rpFACb/AbWDBBTZfNeTFgeTTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7mE7FC1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4311c575172so11744095e9.2;
        Fri, 11 Oct 2024 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672329; x=1729277129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZqKQ2LfzInsks2n4Vpgt/XJ/3z4FcVBp1MqifOjlS0=;
        b=I7mE7FC1Jx1xvtu7Hx+cI5ug79x+OXHa4YKjyFcn6hZv9yV0l/DCAYBde15udlokwH
         pLYEB3Tmu6mVe/gqdhXQPInnl2dk1VgLBuaHWkryJhiYYzJ5XsovE7YCM60zejiTV62o
         k9/IX/hhlnhwIaugxIM04SMMK90gZUlKtlf9X/NBseXB8DuX+KFNHMniooVWZKmhwKBC
         YU1KjRDnlzvyj2oT06KD3S3H1pGu5GJ1l9RO+hIb3IFvU6NkVx4oYS/+O/c3J5qqa2JK
         QZXNmoCKJH42wMEk3pX2kvX3amIacUq9yGpQ6/AAzATlTs60r4G1FNqZ1JdWJDfTOpmg
         40ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672329; x=1729277129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZqKQ2LfzInsks2n4Vpgt/XJ/3z4FcVBp1MqifOjlS0=;
        b=DpITA9/SzBS4zQS7w4glJ6wXRBOpWaePYennfC8+GnwLkaMReGLrQzwswiiWQGRi7s
         q9++t6Hgy6Nmt0eoym8dEjpoZrH3VyrJAFbA+NJyxqED0fnAAmcE8mlle/zy1LIAMAIy
         6R9gt+/iGzwYI9DLoIiHN+M184AjG4abnM0olQ0B/IYFmsMY9GPy2MlAQAa6RuXY1ov3
         U0oQ1B69iHUIvH/FasySjwy0XFWMDbHSwaDCO12GhdxliWT+pOIEMtCP9O2fNmdaXZTP
         uA8AD0LT+7LVkBj4vYKDqrgzCAQ9wdEFmy2xOH2zASYDeEqp3ytQn78d9+VwRy587dsC
         10Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVA+BM5WxRHtHKLEZV9YlNuLrC2VgYI6hvwWqcc0baGAd+PFPs2CQ/+s+OoD5CzR7eoPa0A2lvFsQoE@vger.kernel.org, AJvYcCVFoyYuWF981HroM+u9W9Rtm0kBHEZR1EE2ceiogFcxUtK+JbOfI1PNK3a4GR4OnaNPId9c/KMje/l7sB9D@vger.kernel.org, AJvYcCXSSiK8CANecU2KaCTikoI/lOizRAVNxvVDyNwVGixRCGl65L3msiIAPM1uy5lrT1rEGzRKaSdGEAjk@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+kfWP9Dd/rXkfimmW64kwvV8Woj/1KhHEV2AKOIkHfmUwnHj
	zsXLFrg+H2tDUIvZ3iH3esM+H+bbOckF5MLSV05qmUWg29XUnD1e
X-Google-Smtp-Source: AGHT+IFl6lUU2m75dGga7nHPuig5zujRXmtgRHZU0b/P/jNvxeaz4J4ZUE4h8jWxwBFkYEWvoRz7CA==
X-Received: by 2002:a05:600c:3588:b0:42c:b905:2c04 with SMTP id 5b1f17b1804b1-4311ded19c1mr29212085e9.12.1728672329268;
        Fri, 11 Oct 2024 11:45:29 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835c35asm49157405e9.40.2024.10.11.11.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:45:28 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:45:26 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/13] iio: chemical: bme680: Fix indentation and
 unnecessary spaces
Message-ID: <ZwlyRjnEkO4ROCdr@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-2-vassilisamir@gmail.com>
 <Zwj19ONfbDr0f4Fh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwj19ONfbDr0f4Fh@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 12:55:00PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:18PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Fix indentation issues, line breaking and unnecessary spaces
> > reported by checkpatch.pl.
> 
> Can we move this to be the last (or close to the end) in the series?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>

Hi Andy,

Yes, will do it.

