Return-Path: <linux-iio+bounces-15044-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FECA2920F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 15:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06873ABB95
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716CA18C01E;
	Wed,  5 Feb 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5sPwDkC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9971FC7C2
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766835; cv=none; b=LPjRR9fZDeIU5Qx8s3D7mFAo3ZjV474Dxbbb5QzISS9E8oqLn/b9QWxeAKQHPrd56XxnYz/5AjXxVIZbVZ2F4hdmsB363fu8tUUIsPJI9tjBJBch7Ojb5IVs2NjtrrkUfO9VU0AnoIcNKucTKnPstZVZ1KXs3Y86ExGs3u/dRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766835; c=relaxed/simple;
	bh=oRdogc/geZIJX57rsZrmG1KYxuk6eFV4e76AwSeXXw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goAncuRwt/qV32kcU55lat/J1JF8EaXlldd4KvtlobOC7KvSGLhjkIGeWZXaxkxHOEIoSbb3UihLH3NqiyjrNeDj7/kC62BY+gI6B6t/QuTpjooQeeU6I9zQVVnmVrWmuoSel0iDCjlarZrfjGjE9YygxB7fQ/SkcGAq7gW17K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L5sPwDkC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361c705434so51058225e9.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 06:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738766831; x=1739371631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nGYOIUhB5NlCoFWrNkjS8/LO2NSNaMVzUTIEOw9/la0=;
        b=L5sPwDkCT+QyULYpxoMldsQhPIrKwy7MyNZbtRVQh1SyGrg0zVK0y01sjrrVDmIcHT
         vepTEIQXeffrYk3u+IqsBcSq6RpbNjrarwCh3OGAP0Fa1mirLLM3QNnpMnHlu5jCgg0P
         AKHf0PBnl5YwVBpgpaakUUUGQaes+pUN++QpELPVShxIHNGe64xkmtHdMZeZ/pVmPv0c
         BaxuRV4voIw+sS8tEjtNHtLJXpoN9PAUtF2nJMfetNIJXStpeDq9wwVj959BjY6hFONG
         CpgR2e3MMG3mu1K69+Toiv4xSDA7TBMyeOscwBPIkDWXKBcAvdj07/sYPI1seb6GHEK2
         lTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738766831; x=1739371631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGYOIUhB5NlCoFWrNkjS8/LO2NSNaMVzUTIEOw9/la0=;
        b=rvL59PmOTwb2NSoh7zT6A29slGt+frlkZwT0hyjSjpZt7fms3vz2Wcx8MUshP/enE6
         sd1O2fv8/NdRI35vnK1jrCN68Y7TTtHrPMhIn0/rLSBgndnGNvaRzCvF4jHrTEHw9Sx9
         KaiICvF/5kuVuVXAKQXAmInKYqg20pv/CGYknJXhMIWkxI1t0y6oH3LT4WLTvoJf4Lkm
         0i2mpK9laf077er8iH1GjaRih9Vi1/HY0GY0zCiaW0TX90TXAmS8vpYwaOivbHt2QksE
         JK/G4GnFgSzfiCqv9IQBwEQAPjv3hitE74KFUyXPwFOkKQvzCSv5jamrTXzUsXhx6+mb
         Cn5A==
X-Forwarded-Encrypted: i=1; AJvYcCW273K0eVYZJf6IDcy4gU/36wYBE5qBLZ/7b71jjBlxHxGtX1ob0uTgQV+337frZqeQvpnvHbafW9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYMJWMSeRzW10cqcGBmSD8jJh1zc3P3LCNHp0/LKYejAqWGy/
	Vtfkk8PxkUiUUvmZJOs0nhJxmPXvYcGT7AVUM1yanta5TzPjNWTXgim0RESWcVYPG9eH9iGnVxu
	T
X-Gm-Gg: ASbGnctcLcQCJYkOObUIMqdF2H+mPXFtZouTWFxeqWIyfT8aF3m6I3xcSEBg82qkyqA
	bE9AmTDS/wtFL3koZf+WvOZz5o9tgiJNQH/xIvxz9n+hrcG3I92Y76Ih+CF0BVsBfavaa/pNNX/
	LKg7EK09FbSeYozxYf4Ip4rAM7bDbXlpgz+KdfDqbATp4UMqtCSO1HfXrbB8i5lav9NnswzXDly
	cCF5CMAK9xmnOpLyBAZlU7lBgHsIrJ+77DF6xsUPWWgmQuQIDXmlFtj0szVgM5JdE8NbYiPtVHO
	k6o6Ts4j43+xuzueKzaS
X-Google-Smtp-Source: AGHT+IGg9aS421ExdsmlVfrZyolwGp6cb02wFEnpJuIdjKHi2yIK7E7fI2dYgeXkm0hm9LsM6bqqSA==
X-Received: by 2002:a05:600c:310b:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-4390d434872mr26859105e9.12.1738766831414;
        Wed, 05 Feb 2025 06:47:11 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38db4a84dc3sm2346003f8f.50.2025.02.05.06.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 06:47:11 -0800 (PST)
Date: Wed, 5 Feb 2025 17:47:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-iio@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [bug report] iio: magnetometer: add Allegro MicroSystems
 ALS31300 3-D Linear Hall Effect driver
Message-ID: <117cccfb-fa19-4849-8c37-989ea1911429@stanley.mountain>
References: <db435a8b-7546-4d16-9a15-ee44dac849c9@stanley.mountain>
 <20250204193304.6cdcc9d7@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204193304.6cdcc9d7@jic23-huawei>

On Tue, Feb 04, 2025 at 07:33:04PM +0000, Jonathan Cameron wrote:
> On Tue, 4 Feb 2025 14:18:36 +0300
> Dan Carpenter <dan.carpenter@linaro.org> wrote:
> 
> > Hello Neil Armstrong,
> > 
> > Commit 3c9b6fd74188 ("iio: magnetometer: add Allegro MicroSystems
> > ALS31300 3-D Linear Hall Effect driver") from Oct 30, 2024
> > (linux-next), leads to the following Smatch static checker warning:
> > 
> > 	drivers/iio/magnetometer/als31300.c:248 als31300_trigger_handler()
> > 	warn: check that 'scan.timestamp' doesn't leak information
> > 
> > drivers/iio/magnetometer/als31300.c
> >     226 static irqreturn_t als31300_trigger_handler(int irq, void *p)
> >     227 {
> >     228         struct iio_poll_func *pf = p;
> >     229         struct iio_dev *indio_dev = pf->indio_dev;
> >     230         struct als31300_data *data = iio_priv(indio_dev);
> >     231         struct {
> >     232                 u16 temperature;
> >     233                 s16 channels[3];
> >     234                 aligned_s64 timestamp;
> >     235         } scan;
> >     236         s16 x, y, z;
> >     237         int ret;
> >     238         u16 t;
> >     239 
> >     240         ret = als31300_get_measure(data, &t, &x, &y, &z);
> >     241         if (ret)
> >     242                 goto trigger_out;
> >     243 
> >     244         scan.temperature = t;
> >     245         scan.channels[0] = x;
> >     246         scan.channels[1] = y;
> >     247         scan.channels[2] = z;
> > --> 248         iio_push_to_buffers_with_timestamp(indio_dev, &scan,  
> >     249                                            pf->timestamp);
> > 
> > So I guess we had some CVEs recently with regards to
> > iio_push_to_buffers_with_timestamp() so this was added as a "must be
> > initialized" thing.  The "aligned_s64 timestamp" struct member is
> > sometimes initialized in iio_push_to_buffers_with_timestamp() but not
> > always.  So this seems like a valid static checker warning?
> Hi Dan,
> 
> It's a false positive. When it's not initialized it is also never
> used.  No code beyond that iio_push_to_buffers_with_timestamp() can
> assume there is even data there. In the common case of it being a
> kfifo the elements aren't big enough to store the timestamp if
> it's not enabled. So it never gets to userspace.
> 
> The other bugs were around holes in the structure.  Those can
> get to userspace.  On my todo list is a patch to add
> a size parameter to that function so we can verify the passed
> buffer is big enough, but that won't change how the data is used.
> 

Got it.  Thanks, Jonathan!

regards,
dan carpenter



