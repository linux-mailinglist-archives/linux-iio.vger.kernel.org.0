Return-Path: <linux-iio+bounces-5324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A228CFC33
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7F3283A65
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB13712B17C;
	Mon, 27 May 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezABXKOK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FA812DDA2
	for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799866; cv=none; b=kGwTVU/2xrPYmxpuBqV1XXCaTD0Th161LgVU87C/LJBXt4ZEkUGvBqiDE9BOPH3ccHwpAWu1wwGR68dbze6XZvyUDa/dDTiMlc5F/vrJnDaW7JSgkMk2z+Qlw4nLeJzYzuawWC+C60kcvNj7ODx4dAUl/uz/1QSPlqGRbPnBrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799866; c=relaxed/simple;
	bh=VWIWAz/C36z3ejzKqZpM6Ta9/KsBCD/qHV4r6Ufeiwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qn5jZe6DNcZMnzhrpJWsV0OfB9zDfE4xUj8DDAsRQ3CX8vzXyc9H4H2d5RB8uL6jPxgdjsXzye7FpyEoyY5RkoV9egToULvgCSoSsltRZUk2kQ2wKxHWVtjGOM8aQ+o/i/p6WYT5coB9Mqisg8XLMsmByWi0O0AYNEvDuYDk+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ezABXKOK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so1041757066b.2
        for <linux-iio@vger.kernel.org>; Mon, 27 May 2024 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716799863; x=1717404663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IngHvuVJ+qy5kq3ZL0tayX0b+UVqjmY0nRoaAshOXto=;
        b=ezABXKOKLGX0jjJ10068nEoXL5ajIOQDXfrcClolrN/HJYAGaCgB2H3UWiOlFt/NEx
         iqpllyGEyaoaYcEtLPLU5RROxdfScdZ9rcyItDZnZSwId5P2n7H7JaqkEXnNlSznmdUU
         hZOgOQGwwTwm4UKd9C3PxQtfFUxQDcTPhGaizkQEvm2IJehlM0RL8q6NtpOVYxTW8iAB
         AA50ucWMQCVTkpZ5XNqZ7ZSsvIQeDFigJxldKTGNF/YlMtvZd6T5gSb9VnZJrFYedEQM
         hHhZ8Ftnvl7qwSLci7WAUYb7QZsMx40TN7RrjXzACK3yZJo8i+OAUfqBlKKhb82iCCnE
         5OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799863; x=1717404663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IngHvuVJ+qy5kq3ZL0tayX0b+UVqjmY0nRoaAshOXto=;
        b=N3+LMb4RhWAkrwufjmBR0boK8i+cEN1bYUP43TiyJPSrhgq8GQ5NI4V1GZRzBKR8y/
         Zcm8PKkLDja/46isovDRscrkGpW2qkAEDYKhKBTWozpEYa0qm8YfmEfrHAbfFUOpuKqc
         3hsEHxmc2Qh8btKDY3c/6RK79Hd3XQHuURduxyqF+yfwsQ+AIfV3m8c4/WI8AbTvmDNj
         Q6L3tZjGINY8PbaFwfIhUWM/zDwlgtaw5kknJM8edTZuKBiqYEaK0/T+4L1NmU4NuBh7
         HBFrWTkNp1YFPWgu4qyMdhhm1jjppE1EPUn7C24OqEk2PL0vic4otktUssGQVbHiUziV
         AtVA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Hw0v50QFbPYauR8+tMhl7KTj4/5UqAH4mrGv7EfEsahR3v3Otln8cAd3lzvFPBKjT3YZwPLZM81fJomrmQOv6xA4LP61SSwE
X-Gm-Message-State: AOJu0YxAq5n8sc9TChuVBXI4B/5YTGW8Nw+IdJXfSKXx5dvrb6gQq7Uc
	plvisripMsVW1rHl+nB1JnuKvzmdUaspEUJP7v8dtlJjlatAqx4UKqk5tzK6yCM=
X-Google-Smtp-Source: AGHT+IGCA1HNlfKaJ/l7+h/ehh9h7+FLYF0FcNG522umKz/7ymLJE0wk2XH+LOhyNYPx0n/gIfzzKg==
X-Received: by 2002:a17:906:f353:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a626511604fmr475369266b.70.1716799863000;
        Mon, 27 May 2024 01:51:03 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc519f5sm471282566b.98.2024.05.27.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:51:02 -0700 (PDT)
Date: Mon, 27 May 2024 11:50:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: oe-kbuild@lists.linux.dev, Yasin Lee <yasin.lee.x@outlook.com>,
	jic23@kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	lars@metafoo.de, swboyd@chromium.org, nuno.a@analog.com,
	u.kleine-koenig@pengutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <16a63a13-4c98-4eea-82b7-68213bff61bc@moroto.mountain>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
 <59869d5f-3d97-48a2-8a96-127f7b46c0e8@moroto.mountain>
 <CAHp75VcTxXsnKVR5EQYTNhokHeXrOxQPe9gAkWFRr0yZT1KTPA@mail.gmail.com>
 <6f479ca6-cd6d-4a28-8afe-8b74c4d171d4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f479ca6-cd6d-4a28-8afe-8b74c4d171d4@moroto.mountain>

Mauro, Hans,

The debugfs code in drivers/media/common/siano/smsdvb-debugfs.c is
completely broken.  No one has tested it since Dec 2022.  Can we just
remove it?

On Mon, May 27, 2024 at 11:14:16AM +0300, Dan Carpenter wrote:
> On Sat, May 25, 2024 at 05:00:59PM +0300, Andy Shevchenko wrote:
> > On Thu, May 23, 2024 at 3:42 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > 
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1110  static ssize_t hx9031as_raw_data_show(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1111  {
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1112       char buf[BUF_SIZE] = {0};
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1113       char *p = buf;
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1114       int ii = 0;
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1115
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1116       hx9031as_sample();
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10  1117       for (ii = 0; ii < HX9031AS_CH_NUM; ii++) {
> > > 5e5a419c9407f6 Yasin Lee 2024-05-10 @1118               p += snprintf(p, PAGE_SIZE, "ch[%d]: DIFF=%-8d, RAW=%-8d, OFFSET=%-8d, BL=%-8d, LP=%-8d\n",
> > >                                                                          ^^^^^^^^^
> > 
> > 
> > > Also use scnprintf() instead of snprintf() unless you need to check the
> > > results.
> > 
> > This is incorrect advice. You should recommend sysfs_emit() /
> > sysfs_emit_at() in this kind of case.
> 
> No, this is not sysfs code.  It's debugfs.  The API is completely
> different.

I was going to say that if you find yourself calling sysfs_emit_at()
then you're already in trouble because sysfs is supposed to be one thing
per file.

But then I searched and we call it almost 1000 times.

The first caller I looked at was drivers/media/common/siano/smsdvb-debugfs.c
from commit 2f7d0c94396e ("media: siano: Convert to use sysfs_emit_at()
API") which changes debugfs code to use sysfs_emit().  And it so clearly
has never been tested because debug_data->stats_data does not point to
the start of a page.  sysfs_emit() will refuse to print anything unless
it's given a pointer to the start of a page.  Ugh...

regards,
dan carpenter


