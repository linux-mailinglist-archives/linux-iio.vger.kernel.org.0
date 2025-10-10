Return-Path: <linux-iio+bounces-24918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF5BCE10A
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 19:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7BCA4F1C65
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25C821B905;
	Fri, 10 Oct 2025 17:16:31 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475A41400C;
	Fri, 10 Oct 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116591; cv=none; b=sE02dGZV3/M0FbDw5adY4tT4j0Yl1/MN3c/rqXRM8Fz03R/AdoZ+OPsyoNXz1ihLLnmeZ8e1qxvg73oRq+LJip4HFxcyap4n1SgpisN5qpQbzplbKwYhsW1FYUHQQp+FlSRwLT0hj7DgK4jFjOITF4rE40epaYs/f8pW4Wp3B98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116591; c=relaxed/simple;
	bh=K0tgO1JlA66YGrd+ox11+swcYB243l0ZdtHpb1qL3pQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RO04V2smJgYVdyjR4/XLggXp0D7S5+mBqZQ4Mrr7pKl7X3EKKH5xc5yySbQxvSjAURnc8xjdt+82vWr4i79AGc98UxV2Ko4T4WtOpUdpdE05T8/5T3pT9bTuGjXoR+MqNBvQe8Ju7RU1atsHSxi4q56srOvxwGqrzVD9GqZ2UEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cjtfs45BPz67G6Z;
	Sat, 11 Oct 2025 01:15:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E3326140279;
	Sat, 11 Oct 2025 01:16:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 18:16:19 +0100
Date: Fri, 10 Oct 2025 18:16:17 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
CC: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <~lkcamp/patches@lists.sr.ht>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: spear_adc: cleans up and sorts the existing
 includes
Message-ID: <20251010181617.0000492f@huawei.com>
In-Reply-To: <20251009182636.187026-1-rodrigo.gobbi.7@gmail.com>
References: <20251009182636.187026-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu,  9 Oct 2025 15:24:20 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> Remove unused includes and sort the remaining ones.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
Hi Rodrigo,

> At [1] it was suggested to sort and remove some unused includes,
> that is the reason for this patch. Removed the following includes
> due not being used or because some of them, like device.h/kernel.h
> are included indirectly from another .h file. What was removed:
>

The indirectly included thing was not what the email you reference
is intended to suggest.

It's actually about the general principle of IWYU (include what you use)
I only know that though from previous discussions!

The idea is to include what is directly used in the .c /.h file. So we
don't care about things embedded in structures that we are using
(they are guaranteed to be provided by the included headers that
defines the containing structure) but we do care about struct
types that are used directly or function declarations etc.

For example dropping device.h makes sense as whilst struct device *
pointers are found in this driver no accesses to specific elements
of that are made, it's just a magic token that is passed to other calls.

An example that was included in the email you reference is
dev_err_probe() and similar which are defined dev_printk.h.

Hence that should be included.

There are commonly made exceptions to this such as including
only mutex.h rather than that and mutex_types.h when
mutex_lock() and struct mutex are used.

It's a little tricky to get a universally agreed perfect set
of includes, but in this case you are referencing an email that called
out why dev_printk() should be there and this reasoning under the ---
doesn't correspond to common practice.

Jonathan



> #include <linux/device.h>
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/err.h>
> #include <linux/iio/sysfs.h>
> 
> Also ordered them alphabetically as other adc/iio drivers.
> Tks and regards.
> 
> [1] https://lore.kernel.org/linux-iio/e748d82b-43c7-48e6-b441-cef464f189e6@baylibre.com/#t
> ---
>  drivers/iio/adc/spear_adc.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index 50b0a607baeb..6d974e58637a 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -5,22 +5,17 @@
>   * Copyright 2012 Stefan Roese <sr@denx.de>
>   */
>  
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/io.h>
> -#include <linux/bitfield.h>
> -#include <linux/clk.h>
> -#include <linux/err.h>
> -#include <linux/completion.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  
>  /* SPEAR registers definitions */
>  #define SPEAR600_ADC_SCAN_RATE_LO(x)	((x) & 0xFFFF)


