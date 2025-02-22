Return-Path: <linux-iio+bounces-15984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A06BA40BA3
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 22:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3883BB3D2
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430E6200105;
	Sat, 22 Feb 2025 21:01:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D216C69F
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740258083; cv=none; b=TywK2Bfx2KrL9QXMduaiU/X0IrAqNoOrYUYeveKFN3ou0hmsadG9EnW0jrgTY8tXc1IRY9Cg+FQtEzcTK4p3XjzOXWoccdYf1PDw8exnX8Biz5bYvSxzdnx/b5tdWP3NYkvgbyTm4n+TAd8KYeI+5C0TobrJe8C2LgwHjdi00Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740258083; c=relaxed/simple;
	bh=NXfZGgoVtd+O+ozI4RNwnhgOlONxxwIKWWbNSDarPY0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqsSrwF7aOZf5eLrbx45c2aWmIubWIfNDS9ALrAQd8kZvKDqwynD/GbRZsg53yun4EZM+WIUYKn/Dy9/kGTK32uBWxCl0Yxm6ZkeFDbJ0NzHXtTnJlJPN8ci10jesjGVeNzVe0mehsO1FjGXfhNIqcRnFMCwC1sqZmBPHJ5UoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 00e54729-f160-11ef-a29d-005056bdfda7;
	Sat, 22 Feb 2025 23:00:10 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Feb 2025 23:00:10 +0200
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: adc: adi-axi-adc: replace of.h with
 mod_devicetable.h
Message-ID: <Z7o62qQDyWLk642C@surfacebook.localdomain>
References: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218-dev-axi-adc-fix-headers-v1-1-5ddc79221d8c@analog.com>

Tue, Feb 18, 2025 at 10:34:57AM +0000, Nuno Sá kirjoitti:
> Don't use of.h in order to include mod_devicetable.h. Use it directly as
> there no direct dependency on OF.h

...

>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>

Can we preserve the alpabetical ordering?

-- 
With Best Regards,
Andy Shevchenko



