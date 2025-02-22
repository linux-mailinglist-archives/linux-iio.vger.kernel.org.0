Return-Path: <linux-iio+bounces-15957-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24DA40991
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BD8189E636
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AE1C84C2;
	Sat, 22 Feb 2025 15:52:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74669D2B
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239538; cv=none; b=TW6jQ/FsllOv8oNYDTGUsomES1chE7wNn35kCq5F/eK4DZS2opYHj1aJtccauVPO3Bo9gDSqDycVMk8kfVa4/NF8BBpLvifOoc8GoMs3Aq3bUevQFFc4c9I/vWfwNGmWE+0WsOEbtVO2dczlaoFiR7K7UdhmTNGnPUv/aDMftV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239538; c=relaxed/simple;
	bh=SjkWiZ2sx8IBC+5Xt3C7jZVmmOPWlDNTgWbLYSvzoMs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5lFVj4FxQ+N1FLrqLDAqWr6+06qizSrT//i2GyOeZiXK5YJc9Oj4gfQDcxlGiwLVgUX8f9goSXPyr6TGEalImhvAdhmcAkWwRpgxJi9yM3bZ6gvxINWJESmv1oVW0jam/j34big4w2Ul1vzpN7HcIE1zeRfVVWZ2z0RcrJZ178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id d1fbfd7e-f134-11ef-9d78-005056bd6ce9;
	Sat, 22 Feb 2025 17:51:04 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Feb 2025 17:51:02 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Mudit Sharma <muditsharma.info@gmail.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Mariel Tinaco <Mariel.Tinaco@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Guillaume Stols <gstols@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
Message-ID: <Z7nyQgjZ36zkO8oD@surfacebook.localdomain>
References: <20250209180624.701140-1-jic23@kernel.org>
 <20250209180624.701140-2-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209180624.701140-2-jic23@kernel.org>

Sun, Feb 09, 2025 at 06:05:58PM +0000, Jonathan Cameron kirjoitti:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Initial thought was to do something similar to __cond_lock()
> 
> 	do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev); 0; })
> + Appropriate static inline iio_device_release_direct_mode()
> 
> However with that, sparse generates false positives. E.g.
> 
> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: context imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock
> 
> So instead, this patch rethinks the return type and makes it more
> 'conditional lock like' (which is part of what is going on under the hood
> anyway) and return a boolean - true for successfully acquired, false for
> did not acquire.
> 
> To allow a migration path given the rework is now non trivial, take a leaf
> out of the naming of the conditional guard we currently have for IIO
> device direct mode and drop the _mode postfix from the new functions giving
> iio_device_claim_direct() and iio_device_release_direct()
> 
> Whilst the kernel supports __cond_acquires() upstream sparse does not
> yet do so.  Hence rely on sparse expanding a static inline wrapper
> to explicitly see whether __acquire() is called.
> 
> Note that even with the solution here, sparse sometimes gives false
> positives. However in the few cases seen they were complex code
> structures that benefited from simplification anyway.

...


> +/*
> + * Helper functions that allow claim and release of direct mode
> + * in a fashion that doesn't generate many false positives from sparse.
> + * Note this must remain static inline in the header so that sparse
> + * can see the __acquire() marking. Revisit when sparse supports
> + * __cond_acquires()
> + */
> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
> +{
> +	int ret = iio_device_claim_direct_mode(indio_dev);
> +
> +	if (ret)
> +		return false;
> +
> +	__acquire(iio_dev);
> +
> +	return true;

While I understand the intention, I dislike the function return boolean and
hide the actual error code, it calls user to misuse and replace boolean false
by arbitrary error codes.

Can we rather return an error code, please?
(as a side effect it reduces the churn in the followup changes)

> +}

-- 
With Best Regards,
Andy Shevchenko



