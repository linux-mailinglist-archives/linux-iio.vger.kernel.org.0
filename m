Return-Path: <linux-iio+bounces-3586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B887E95B
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 13:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEAB1C21217
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41E1E532;
	Mon, 18 Mar 2024 12:33:26 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AA381A4
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765206; cv=none; b=WGvjYWZsQOCYx5gaMIVckaP/Cs0Bf12rGTRXQOd1+++D0GI1rISm/knpCtbxJXi4c63RjRgG5c95QvMQpyrZSmBfzEWPH7rpaUnIj5YQhcU47g14VA2xt6kCDPamKl/rOsKlrhYpjTdryfyhCpmJMZ+KKWTr+4oOlN1p4CvmLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765206; c=relaxed/simple;
	bh=Y8EDeL5lV4JSuAN453wHBY5xceX+Dq9yTv4sWRXIBuI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFoVJ7jOEtIXgWxiR3vdJRD/pRJIzsqUAcnxDPYqggh9nwzriBQ05SoD8dnYKQ8v4bnmMVX25R/6VkPPZeo//x+t3dA4LZ8ZsHxb9md/k1aubceVg8tHZ2iglifQa1TD2NdA4jtAMxrP0s8NgNStOiFjpCNe9GY9TqW3ku4pjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TyvQ668Czz6JBcJ;
	Mon, 18 Mar 2024 20:32:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2FC5E140DE5;
	Mon, 18 Mar 2024 20:33:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Mar
 2024 12:33:20 +0000
Date: Mon, 18 Mar 2024 12:33:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Nuno Sa <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 2/4] iio: trigger: move to the cleanup.h magic
Message-ID: <20240318123320.000030d3@Huawei.com>
In-Reply-To: <ZfXz6E086KPWUn8Q@surfacebook.localdomain>
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
	<20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>
	<ZfXz6E086KPWUn8Q@surfacebook.localdomain>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sat, 16 Mar 2024 21:32:56 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Thu, Feb 29, 2024 at 04:10:26PM +0100, Nuno Sa kirjoitti:
> > Use the new cleanup magic for handling mutexes in IIO. This allows us to
> > greatly simplify some code paths.  
> 
> ...
> 
> >  	/* Add to list of available triggers held by the IIO core */
> > -	mutex_lock(&iio_trigger_list_lock);
> > -	if (__iio_trigger_find_by_name(trig_info->name)) {
> > -		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> > -		ret = -EEXIST;
> > -		goto error_device_del;
> > +	scoped_guard(mutex, &iio_trigger_list_lock) {
> > +		if (__iio_trigger_find_by_name(trig_info->name)) {
> > +			pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> > +			ret = -EEXIST;
> > +			goto error_device_del;  
> 
> With scoped_guard() it can't be achived, but in the original code the unlocking
> can be potentially done before printing the message.
> Here are pros and cons of printing messages under the lock:
> + the timestamp and appearance in the log probably more accurate
> - the lock maybe taken for much longer time (if there is a slow
>   console is involved)
> 
> That said, always consider where to put message printing when it's a critical
> section

It's an unlikely to occur error message. We almost certainly don't care.

> 
> > +		}
> > +		list_add_tail(&trig_info->list, &iio_trigger_list);
> >  	}  
> 
> ...
> 
> >  	list_for_each_entry(iter, &iio_trigger_list, list)
> > -		if (sysfs_streq(iter->name, name)) {
> > -			trig = iter;
> > -			iio_trigger_get(trig);
> > -			break;
> > -		}
> > -	mutex_unlock(&iio_trigger_list_lock);
> > +		if (sysfs_streq(iter->name, name))
> > +			return iio_trigger_get(iter);  
> 
> In this case the outer {} better to have.
> 
> ...
> 
> > -	ret = bitmap_find_free_region(trig->pool,
> > -				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> > -				      ilog2(1));  
> 
> > +		ret = bitmap_find_free_region(trig->pool,
> > +					      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> > +					      ilog2(1));  
> 
> Despite being in the original code, this is funny magic constant...

Not that magic, build time config variable to avoid adding complexity
of dynamic expansion of various structures. We could have picked a big
number but someone will always want a bigger one and from what I recall
actually make it expandable was nasty to do.  Been a long time, though
so I'm open to patches that get rid of this in favor of a dynamic solution.

Jonathan

> 


