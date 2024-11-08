Return-Path: <linux-iio+bounces-12044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C479C2496
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 19:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47F91C281CE
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 18:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929151917F4;
	Fri,  8 Nov 2024 18:02:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE213233D61;
	Fri,  8 Nov 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088970; cv=none; b=EaxtYnmq5g/rK87QAD+3lylHZ+PttqMRkoITp8fPchXQsLbjLWn1ZOyBSDFRIMahxFv95tJR4OvSspZEgetzP1oNKERVaf048eRwvkejaV//No0ttpv1F6RMXTm1dy9AkdSQ7mVrIbNnfacFw9Dr1BnQsGo5EyVF9zJQOKxrshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088970; c=relaxed/simple;
	bh=9/hFmSn3anL6QFSvv6Vt7Qx8CSCybfea/bPR0zRVthc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W09TKke/JWF3+EOYu4gOEKfO/rIH17acxG3C1MWXXY0Tsw82Dou1jgL2V7qJcFGTNJh9fYBx4pUovY6b9S2VvdIzbv9ohmkQSYmoioDboR+gC14egpgnpN2R4GKXfHaksQwB0n3geadjR8rJ/ZgUjzHNLd6xh0o7bCW+VFtQ4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlRY32V00z6K7HF;
	Sat,  9 Nov 2024 01:59:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AA1A91400CA;
	Sat,  9 Nov 2024 02:02:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 19:02:45 +0100
Date: Fri, 8 Nov 2024 18:02:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <megi@xff.cz>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>, <linux-iio@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, <hpa@zytor.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <linux-kernel@vger.kernel.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: magnetometer: fix if () scoped_guard() formatting
Message-ID: <20241108180243.00000c27@huawei.com>
In-Reply-To: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
References: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri,  8 Nov 2024 16:41:27 +0100
Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Add mising braces after an if condition that contains scoped_guard().
> 
> This style is both preferred and necessary here, to fix warning after
> scoped_guard() change in commit fcc22ac5baf0 ("cleanup: Adjust
> scoped_guard() macros to avoid potential warning") to have if-else inside
> of the macro. Current (no braces) use in af8133j_set_scale() yields
> the following warnings:
> af8133j.c:315:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
> af8133j.c:316:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
> 
> Fixes: fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409270848.tTpyEAR7-lkp@intel.com/
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> I have forgot to add this patch prior to the cited Fixes: commit,
> so Stephen Rothwell had to reinvent it, in order to fix linux-next.
> original posting by Stephen Rothwell:
> https://lore.kernel.org/lkml/20241028165336.7b46ce25@canb.auug.org.au/
> ---
>  drivers/iio/magnetometer/af8133j.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
> index d81d89af6283..acd291f3e792 100644
> --- a/drivers/iio/magnetometer/af8133j.c
> +++ b/drivers/iio/magnetometer/af8133j.c
> @@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
>  	 * When suspended, just store the new range to data->range to be
>  	 * applied later during power up.
>  	 */
> -	if (!pm_runtime_status_suspended(dev))
> +	if (!pm_runtime_status_suspended(dev)) {

I thought I replied to say don't do it this way. Ah well probably went astray
as I was having some email issues yesterday.

		guard(mutex)(&data->mutex);
		ret = regmap_write...

>  		scoped_guard(mutex, &data->mutex)
>  			ret = regmap_write(data->regmap,
>  					   AF8133J_REG_RANGE, range);
> +	}
>  
>  	pm_runtime_enable(dev);
>  


