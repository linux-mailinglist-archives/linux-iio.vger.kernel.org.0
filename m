Return-Path: <linux-iio+bounces-3566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BD87DB4F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 20:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E859328173A
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730DC1BC43;
	Sat, 16 Mar 2024 19:33:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05721843
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710617586; cv=none; b=XDirUp8zS0mshTioc/oIneWrgnXZpa1Xdgh1snIZbiAaH0AI0RXoqWBqCbgZ+E3C8/SiOQZMZI/QgapcVoM0I97bMv/2OpqAe9ppxDRS0UtBIBYEPKkIdmmL6hbf4s7J03j6spF1MxLiav0RzcxatWhMJZTnUYWAfEw4lKadBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710617586; c=relaxed/simple;
	bh=Hj80M/ZA0DOQ/gGIu+1litVipnGif3Wb2BdcCE9t2gA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNWYgfpwnbTgtgAPvtKfTDt7gkUFpPCUdGOtJtOInD/qfon2jt7z+R1MDk2x3cVjxrA/akmGmbrQB8yS5Ag2k9WOYt+n4Rtr2RJj2gPMOA7cME+v6sBy0/bm9fvF/HIfKXJf0TBaEUMA0mfMjeVPZyUni+QQumE7eVgzNwSe640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id fd8c9685-e3cb-11ee-b972-005056bdfda7;
	Sat, 16 Mar 2024 21:32:57 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 16 Mar 2024 21:32:56 +0200
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/4] iio: trigger: move to the cleanup.h magic
Message-ID: <ZfXz6E086KPWUn8Q@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
 <20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>

Thu, Feb 29, 2024 at 04:10:26PM +0100, Nuno Sa kirjoitti:
> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.

...

>  	/* Add to list of available triggers held by the IIO core */
> -	mutex_lock(&iio_trigger_list_lock);
> -	if (__iio_trigger_find_by_name(trig_info->name)) {
> -		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> -		ret = -EEXIST;
> -		goto error_device_del;
> +	scoped_guard(mutex, &iio_trigger_list_lock) {
> +		if (__iio_trigger_find_by_name(trig_info->name)) {
> +			pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> +			ret = -EEXIST;
> +			goto error_device_del;

With scoped_guard() it can't be achived, but in the original code the unlocking
can be potentially done before printing the message.
Here are pros and cons of printing messages under the lock:
+ the timestamp and appearance in the log probably more accurate
- the lock maybe taken for much longer time (if there is a slow
  console is involved)

That said, always consider where to put message printing when it's a critical
section.

> +		}
> +		list_add_tail(&trig_info->list, &iio_trigger_list);
>  	}

...

>  	list_for_each_entry(iter, &iio_trigger_list, list)
> -		if (sysfs_streq(iter->name, name)) {
> -			trig = iter;
> -			iio_trigger_get(trig);
> -			break;
> -		}
> -	mutex_unlock(&iio_trigger_list_lock);
> +		if (sysfs_streq(iter->name, name))
> +			return iio_trigger_get(iter);

In this case the outer {} better to have.

...

> -	ret = bitmap_find_free_region(trig->pool,
> -				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> -				      ilog2(1));

> +		ret = bitmap_find_free_region(trig->pool,
> +					      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> +					      ilog2(1));

Despite being in the original code, this is funny magic constant...

-- 
With Best Regards,
Andy Shevchenko



