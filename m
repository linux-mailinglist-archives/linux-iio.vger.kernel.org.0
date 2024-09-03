Return-Path: <linux-iio+bounces-9106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C3B96ACB4
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 01:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8CC1B23F65
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8B71D7999;
	Tue,  3 Sep 2024 23:19:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC65C126C07
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725405590; cv=none; b=rrVw+lG3MdX/u1khzgl8EHIz3mCoCOTzltv+MRJaTSrkdeZWjAQu4arWZ9DPnenTzfNAPvHvXMkzdnwx0QpTC9qluME8smvA2m1Czvoaho7OIZ7n1jH7TDvyDjPcpLgQjXf7o5AaXAGcreEET7+gghAgvkz821W0Z+aN5eYcgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725405590; c=relaxed/simple;
	bh=1cNuZ5vvM1BwYOrKWY3og5ZYu1ar/VPzjfYW7RN6UWA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIjIdPpukwF+zR6EOWZuPCqj8jGB5TnLfdQSYWHvR8dcrZ4aMKEa7j6NKdu5s7bTQFWClsDutWvj03EqIawNMS/U1WLpUnSLN4KDIujW0sn+qPSn+OUhhlk1EueTeJN5nia/GE6Qxir7PZ+l0tvcyUEyyXYTM4bp9jjiYmpj+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id fca0b417-6a4a-11ef-abaf-005056bdd08f;
	Wed, 04 Sep 2024 02:19:37 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 02:19:36 +0300
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: wbg@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/counter: close fd when exit
Message-ID: <ZteZiKKsAYmGdu0s@surfacebook.localdomain>
References: <20240903080121.5294-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903080121.5294-1-zhangjiao2@cmss.chinamobile.com>

Tue, Sep 03, 2024 at 04:01:21PM +0800, zhangjiao2 kirjoitti:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> close fd when exit the program

Please, mind English grammar and punctuation.
Also this doesn't state what the problem is.

...

>  		if (ret == -1) {
>  			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
>  				strerror(errno));
> +			close(fd);

Since fd is not used in the messaging it's better to close it before printing
anything. Ditto for other cases.

...

>  		if (ret != sizeof(event_data)) {
>  			fprintf(stderr, "Failed to read event data\n");
> +			close(fd);

>  			return -EIO;

Side note: This will return garbage to the userspace. Should be

			return EIO;

>  		}

-- 
With Best Regards,
Andy Shevchenko



