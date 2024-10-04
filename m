Return-Path: <linux-iio+bounces-10131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D88399060B
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 16:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397831C213F6
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB0217326;
	Fri,  4 Oct 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdR6kSye"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD999217301;
	Fri,  4 Oct 2024 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052083; cv=none; b=lWJLZ7ZwmLG4oHSFS3GycoqBWVeGQSXgHujDZCbNmUKAe3WmkKejlaisSMTbabKcH84vohDVIRTD4hsJvOXSIIAFGex8UbuGEaxL+qWJ/UawcII8RXMWYxj4EJXAKDB487L1uw/GHDHg7SFpg0odYc1M1owwKAf0y4JeQaxpkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052083; c=relaxed/simple;
	bh=k1SXox8r+eoo4pQYJSMYwMxHVoV6VQ5uUt6yDmrd5zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfu3GBjBlv2HyaMjG8TDI6AEQGlj6ZKCJjphB9b5eHnRVfO3f+B8wd9m97U3nAYUnKUJFjoFOxqXAFlx7tMrKj/uIHchfB/wI+US2iixhvoi/9xigW/HO+F1b4pZOQc4Wl8ZMY24znNV7n1OHjjP+HTBA/9TQa1FpHsSMVp38Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdR6kSye; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a344f92143so9464395ab.2;
        Fri, 04 Oct 2024 07:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728052081; x=1728656881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJyHcWlFcB0yneGCRYF2/KavmOdw1GuiFft4k/6Xt8c=;
        b=fdR6kSye88THc8iNYeXDr3QE7nBkG+vibNwikAn6vawYUqowFD9dDlzVPYwMlSln+L
         yVrIKso/Ch8E+V6LGzENoeyrTjfTqDqtcjWcqLi2wo3btj5Nzv/68j1kC4VCQeIMNn3A
         CyC//ajz/FHjrr9BfBiA158Y3KIjTdweZtJohmwa7lwBagjGckKSXGeLPqoPtX7ijgEG
         pS11apsFvUlmYVANAtXObq4M1UiR+CG2enU1HV0xdlNR5/nd3PDAj3qtnRzxe32HcOrV
         uHR/DGO2PJ8CCc8EMQLzH8PCLqRUje50xHVWjvEvz08rjJRF6+VuP1CBYcjKKKQTwJJB
         mpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728052081; x=1728656881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJyHcWlFcB0yneGCRYF2/KavmOdw1GuiFft4k/6Xt8c=;
        b=SBg8jdY7WK24P40hAJ2MbRTrA3IPI5lbRvwt33DDTDEBDm1Kb8R4ptlIQwdWfheQYP
         keCbaWQlZvxKKxq+4qzpDkdPmSmjVane6/i8Tw4WClJJz89KYGZEamtNMTQm+hOvQd/c
         4IYD+HGkIjm+pS3Y6WAcntS8OVmpjS4pFWMzFQCOSzpWx/1Na86nBd+GUlOcwZnL3fgd
         HbX6+DBDdPoS5G5XpFvmqAx5fjrmAMQ1bruIoaWScSDaybPXZfg9GUIh+MKslqalI3hQ
         zL65t+39YqIt404BrO6huczYykFaeMOzkLJ8QbWyPORpZYg2p1jPFixuuig06wxigtUU
         pTEA==
X-Forwarded-Encrypted: i=1; AJvYcCV9W7K+2T8DRv29kL+5SrurltjwJnENNwjtbj1NCfE7mrvfXmHBR5iwaSH6UlmpUJ23PxWezWhOlrU=@vger.kernel.org, AJvYcCXesKLX+b6efA38AgTGLra1tKFKxYbgMS3J3IuSLgP9TbxBT25bpmY5fxwfGi01RXysRnlmNcmfIIzrrEbQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwaliaRj0w1fHbjYfCGMobLpb/CuRuTWqwzhx3bUe3knB028/gx
	1YeY2mggz56KmzbGDAfAQCY8vg6975hHWgLzyaa4X6/WxsWoCES4
X-Google-Smtp-Source: AGHT+IF0UfwSa2sNu/ffyHD0rHjxqiKaM8BWemAcJnDtqS6Lk9zjQ76SeayuXv9I/441oh7+FNnc7Q==
X-Received: by 2002:a05:6e02:1c09:b0:39f:5d96:1fde with SMTP id e9e14a558f8ab-3a375978c12mr27061835ab.3.1728052080860;
        Fri, 04 Oct 2024 07:28:00 -0700 (PDT)
Received: from archlinux ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dcb5d85csm2531087a12.84.2024.10.04.07.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:28:00 -0700 (PDT)
Date: Fri, 4 Oct 2024 11:27:49 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno Sa <nuno.sa@analog.com>, Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, 
	Leonard =?utf-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mihail Chindris <mihail.chindris@analog.com>, 
	Alexandru Ardelean <ardeleanalex@gmail.com>, Shoji Keita <awaittrot@shjk.jp>, 
	Andrey Skvortsov <andrej.skvortzov@gmail.com>, Dalton Durst <dalton@ubports.com>, 
	Icenowy Zheng <icenowy@aosc.io>, Andreas Klinger <ak@it-klinger.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 09/13] iio: chemical: ens160: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <xb4kbwrxm3j3mt7mciuzx3r6ilkb4j7sa3djkzcvwrutx3m6em@gp7bc4kq7jmd>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
 <20241003-iio-select-v1-9-67c0385197cd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-iio-select-v1-9-67c0385197cd@gmail.com>

On Thu, Oct 03, 2024 at 11:04:55PM +0200, Javier Carrasco wrote:
> This driver makes use of triggered buffers, but does not select the
> required modules.
> 
> Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> 
> Fixes: 0fc26596b4b3 ("iio: chemical: ens160: add triggered buffer support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Acked-by: Gustavo Silva
<gustavograzs@gmail.com>

