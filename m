Return-Path: <linux-iio+bounces-17865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0320A820F8
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4682D4A175B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604525D548;
	Wed,  9 Apr 2025 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t1+zmKGV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE92528F0
	for <linux-iio@vger.kernel.org>; Wed,  9 Apr 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744190764; cv=none; b=PFZvTQi3XWixKbGueJN48KZXCrtb7qLB5+/CaaFbKaWx4iKda0DauE8PQqLc3vg4qPNvJF8c/UzREbQL8PSPIJcea+0KXhSwxiaB+77TlCo0U6Ai70F4xxusynxfN6UzI22t62a9TfPIf19PojMFNswYHvK5ZfOwPp0y8lLxn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744190764; c=relaxed/simple;
	bh=jcwBfldelS5c0jSTsE4Kp6YvMT4Tu091LMvQ8hLdekE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjqdN2AczMbTCatXw5KluhJ0i3F3pNUJzFsnrCuQQWZ44l3/kXVUVlKfFS0QOSiM1EIQxCy3C6gJFyER86pi474483bD5EsCEqgqhsif71P0Wy3n0mp9J/Y5UGbGegM2ticYzpJHZfAPel9UOJIqwztAmPHvQ1OZHaabM6VsOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t1+zmKGV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so6118415f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2025 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744190759; x=1744795559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wt3P/PZ2A+bsUg/oTQhsQUkmjpYKm6Jh4MgXrIAoQbk=;
        b=t1+zmKGV1bgktYlXXAhes+oDH56rkv0/iEL73HoXu7gLvofVjObyxOw2gYcy6oEf8E
         JX3XTNduyc/dTDxfBGE2sON8Y8pSXJ4pxggz9zfraYUrhiKgs6orSZAJCagBPSFsWjRs
         k6MCPD9aPe0EdVklwYSEjg1EDi/2SaQm1V+LWIfM6VQsN31zFGccNTQgyOxAuNaz2tZv
         BIewm+qKQ1dy1RXwc52uci0mV4e93T/yhpI38wavxphoBU/Jajy1NLn+j2D32aJqGwdG
         8UjqfdulVDEVzoAzMqWThZ+nTXq8N+0iJE9kQKXMZUYnJEeXC6I/3+mmOn3ouPYhbD/F
         2kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744190759; x=1744795559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wt3P/PZ2A+bsUg/oTQhsQUkmjpYKm6Jh4MgXrIAoQbk=;
        b=noDV2qd3T35vPlbjRuzT1E52YzlH6Ihgcky92YzdsBMgbbib3zau61ev0+ZUyJnILk
         cE02Z2th1LB5SjJ4BuyNPFAbujH4E4PAgFmV2SvyF+THg1QCvAA4N9oakxxnEAs14qFV
         wan3FsPtiKmbCljOfUoQMk99Q9+dF/uPSNCYwDUApJtO9ESUn66c+bX+n/FuEqVob+/c
         rHIuFX+gjOtF/1heBlG3VE9l9USH0+seQCNcSiNuoqHVZrP/QFeQfiRr9EEHQmuDc+ab
         6whfsdOgytWDBKkCqrDSemDt6T/3PwGxvHr0wjIbttyds083jzQqQem1wFuHNjXk7Yz+
         5I5A==
X-Forwarded-Encrypted: i=1; AJvYcCXmBzmYLgw6y4Ve1aQX00rIFVETSR7sPsoUnR7tqsU3LNxV6D44c9pja+VHe7/YYuuZA0X8NxoGQMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kzDRFcqBjPILBw8GPRy6hQVSLKiHc74hi7qny3U4Ebcb44O7
	I+QAUDwWc0kAGEF3h5joivMxA2Qp3qIMVJCTdijoonRYPQk4CWLRWBT9jOX6Qyc=
X-Gm-Gg: ASbGncvMEyABcLZ2ogHcPml8U7Ykml3Cu60JT71ZD2X7pVbzY3duVE3t72Vz/s+cZNz
	8xfbYPfPFCkpaP+i2ve0IZZTGM/uGBKlOcozZw+Ex/sF0SHBl1ZCyd1zIF+dK7adK+Es5GJprPF
	zuKrVz8EtQ+7mkjonJmhs9wmRQGh/9K5iOnmMReRDHHGq1TA4hvWNzdFe2fi8lHlf7H+Rk37i39
	YrciKe0yKyO0KG83bZ9sGWf5TmwZ1BQUk88t/sheDxhXz0OROu8d/Esd5UD9AHCmtLcDbyO5o+H
	7Qy+EeYkHrET7tUB2xunQM4DCN8iF1qEH8R/dCTmNN1lQjQT/RC2D12GVn7J4mVO1r8b9RWuLtF
	M77YjNBh+fQ2J
X-Google-Smtp-Source: AGHT+IF2W60HyjSsanXCbQ9L1wsO5+PxuL8njMCAxCqnMoNOXFuOtG6P0fbWAqj4LGVy335MUd1DNA==
X-Received: by 2002:a05:6000:4285:b0:391:487f:2828 with SMTP id ffacd0b85a97d-39d87aa1ff1mr1996324f8f.10.1744190758752;
        Wed, 09 Apr 2025 02:25:58 -0700 (PDT)
Received: from archlinux (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdf84sm1046430f8f.86.2025.04.09.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:25:58 -0700 (PDT)
Date: Wed, 9 Apr 2025 11:24:42 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Corbet <corbet@lwn.net>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: dac: ad3552r-hs: add support for internal
 ramp
Message-ID: <ldn4jhz7oeo7sxygifra36daydbo3mdsf6dznxbugoixwmn7ci@gok34zr2mund>
References: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
 <20250408-wip-bl-ad3552r-fixes-v4-5-b33c0264bd78@baylibre.com>
 <0900650872a1533a344df375e99ce116046b3ee0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0900650872a1533a344df375e99ce116046b3ee0.camel@gmail.com>

On 09.04.2025 07:32, Nuno Sá wrote:
> On Tue, 2025-04-08 at 12:18 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > The ad3552r can be feeded from the HDL controller by an internally
> > generated 16bit ramp, useful for debug pourposes. Add debugfs a file
> > to enable or disable it.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---

Hi Nuno,
> 
> Hi Angelo,
> 
> One issue that needs a respin and then a minor comment... With it,
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> 
> >  drivers/iio/dac/ad3552r-hs.c | 166 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 160 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index
> > 37397e188f225a8099745ec03f7c604da76960b1..9a8eed7a06e4f2e7b23d59764b8f2fc21e2c4537
> > 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -7,6 +7,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/iio/backend.h>
> > @@ -54,6 +55,18 @@ struct ad3552r_hs_state {
> >  	struct ad3552r_hs_platform_data *data;
> >  	/* INTERFACE_CONFIG_D register cache, in DDR we cannot read values. */
> >  	u32 config_d;
> > +	/* Protects backend I/O operations from concurrent accesses. */
> > +	struct mutex lock;
> > +};
> > +
> > +enum ad3552r_sources {
> > +	AD3552R_SRC_IIO_BUFFER,
> > +	AD3552R_SRC_BACKEND_RAMP_GEN,
> > +};
> > +
> > +static const char * const dbgfs_attr_source[] = {
> > +	[AD3552R_SRC_IIO_BUFFER] = "iio-buffer",
> > +	[AD3552R_SRC_BACKEND_RAMP_GEN] = "backend-ramp-generator",
> >  };
> 
> nit: I would use more generic strings. I assume "iio-buffer" is just the "normal"
> data so use something like that. For the ramp, is it 16 bits? I would just use ex:
> RAMP_16. I do not thing that the "backend" prefix (as well as "-generator") to add
> much.
> >  

are 
"normal", "ramp-16bit"
ok ?
Or please let me know the names you prefer.

> 
> ...
> 
> > +
> > +static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
> > +						 char __user *userbuf,
> > +						 size_t count, loff_t *ppos)
> > +{
> > +	ssize_t len = 0;
> > +	char *buf;
> > +	int i;
> > +
> > +	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> 
> When are we freeing this memory? I also do not see the point for a PAGE_SIZE
> allocation for such a small string table. I would say to simplify things and use a
> local buffer with 64/128 bytes (should be more than enough). If you see this growing
> in the future, you can also go with seq_file.
>
agh, frogot the free. Sorry.
Ok, i'll use 128.
 
> - Nuno Sá
> 
> > +	for (i = 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
> > +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
> > +				 dbgfs_attr_source[i]);
> > +	}
> > +	buf[len - 1] = '\n';
> > +
> > +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> > +}
> > +
> > +static const struct file_operations ad3552r_hs_data_source_fops = {
> > +	.owner = THIS_MODULE,
> > +	.write = ad3552r_hs_write_data_source,
> > +	.read = ad3552r_hs_show_data_source,
> > +};
> > +
> > +static const struct file_operations ad3552r_hs_data_source_avail_fops = {
> > +	.owner = THIS_MODULE,
> > +	.read = ad3552r_hs_show_data_source_avail,
> > +};
> > +
> >  static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> >  {
> >  	u16 id;
> > @@ -550,11 +678,7 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
> > +	ret = ad3552r_hs_set_data_source(st, IIO_BACKEND_EXTERNAL);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -661,6 +785,26 @@ static const struct iio_info ad3552r_hs_info = {
> >  	.debugfs_reg_access = &ad3552r_hs_reg_access,
> >  };
> >  
> > +static void ad3552r_hs_debugfs_init(struct iio_dev *indio_dev)
> > +{
> > +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> > +	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
> > +
> > +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> > +		return;
> > +
> > +	d = iio_get_debugfs_dentry(indio_dev);
> > +	if (!d) {
> > +		dev_warn(st->dev, "can't set debugfs in driver dir\n");
> > +		return;
> > +	}
> > +
> > +	debugfs_create_file("data_source", 0600, d, st,
> > +			    &ad3552r_hs_data_source_fops);
> > +	debugfs_create_file("data_source_available", 0600, d, st,
> > +			    &ad3552r_hs_data_source_avail_fops);
> > +}
> > +
> >  static int ad3552r_hs_probe(struct platform_device *pdev)
> >  {
> >  	struct ad3552r_hs_state *st;
> > @@ -705,7 +849,17 @@ static int ad3552r_hs_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	return devm_iio_device_register(&pdev->dev, indio_dev);
> > +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_mutex_init(&pdev->dev, &st->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ad3552r_hs_debugfs_init(indio_dev);
> > +
> > +	return ret;
> >  }
> >  
> >  static const struct of_device_id ad3552r_hs_of_id[] = {
> > 
> 

