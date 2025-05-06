Return-Path: <linux-iio+bounces-19199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2E5AAC7DD
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBEA81C42094
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64052283128;
	Tue,  6 May 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xH5emjGq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B122820DC
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541507; cv=none; b=oba5wDbJoNCj50XnoaIq/9R6eOwUWy3utvj2JPNv/jdqkIxSVf7/XK/Qu2lBjtk4HLxdievJPVOdK1CfUekIbVWYB2yn7nVQhWozagowZJNRcsALU2r32pmKiWuevbClE6zGmZgahHId/uiZx7sI1vCmgRi53uyO/Vet5tAW7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541507; c=relaxed/simple;
	bh=W1tmEJU49GjikwCABBiUBOtB7NgBi4jBnAt9L6MX5mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCAzj30MHkE9vIuSdLzEedga+Tb9o0khK1Xtz0nnS9T4rJEn05YpiZL2HE9iELep0IStWHS6c1bqgODe/S+li2KrxbQjI6k8jG7iiVJfhVCPRK3RAQcWnbX3+hQSB4aNpCZzMUt+upIV8ryqMky7ABnXsoryhEDGV5rO0nwoNgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xH5emjGq; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-401be80368fso939869b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746541502; x=1747146302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWNXtyGfkXjsQGeXrJ9qOGqg5ox2lxjpKQV58Pgzr2o=;
        b=xH5emjGqOlIy+idA1kU+4YlmNDmdyRt6mmUJtsQsLR9ND7v/r6hSFDvIRu3oc4Hmtw
         fLs8I+jd4han7QWha6ic66yU2TMWZ+rGuD69El9VXDCC/WyPhxn36XHTeUVNGs2UvpmB
         ocLdvP5f1Ooc8aTK+N7m2bu7qogcmnhniV/iobgga/CyWOxEkZ0mxyHHO2Sy1V5rs06I
         jU9WEIQsDlZnfMlaZqNDHYPpGKmfhBevbH5kdmw7rSM4NeyrGj8Xmbq+jwQA/0fmw+Nc
         Ob7h1LjYXW+w5On1cFDpUEdDJNy8lZRiHFl8pfHOZ8F7f8o6z/ZIX8GQsMM4GZVSKiKM
         BbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541502; x=1747146302;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWNXtyGfkXjsQGeXrJ9qOGqg5ox2lxjpKQV58Pgzr2o=;
        b=BbOdWeC6s6+FEOB59rXjI8Pp8IczKD4bIfV6k6277BDNcxvdDIAPJTVLTgkkDX5OvP
         QHfX6CZ5xSStRXoZBPlMuxvKrJrnNwqyaC26nHc45fRZm0HCPIgQNj9apqV8jZT4E8Mw
         iA0ODwEgoP2EjP8TdoAb6ZEc4DW4TtDPT/CwJnvpYqFwqjO+kItbvoCLkoVF/qKp24ZG
         nj+72HA1PyXy3cRhER0IBGsTtKiR6lXEozrn1eotymFKSs2C7YbMPiitI6e7W0zl175F
         1mvRkUOmWG7cyje9c1QJ75vp6MuJkrQxB2V1YGek67hAEpU/esaVKnzLUPDfg6ctHKeg
         r2Uw==
X-Gm-Message-State: AOJu0YwQmeakP0+f/aLGW4eABUYwZY2GB6Ov3+Bxo/8oqp0Bep2svCev
	Vzh4nxk0DXCCN0wvHGXZaOaoTgOZi5NnhcqOc4mHx7lHZ7ZsMYYXSSXYhMlT4oE=
X-Gm-Gg: ASbGncsAAdSUIAD8iLTnltHLi8RNmNL31GYoPRuXkWM/16bMcNZBj4J5pFwhku/hw3R
	dBSheRgfAYYGfuRUV4EwK7X+yVhu/FFMdkJQqQ3IS70+yOKTSXuB5zElffvWJPKtVeYJUA/Hu0G
	/LxerPdBc6c7FGmSDD36xOCj4KUvf31MXQiG4OU0z9FEKsjqFgUg6ll3a9RSWgKRLrCkx3idCPO
	YjQ1ecO1QsVVSXB62ALL8nHZbX9iRhUpVfpabyQJWMTYFQj8UAmhN79O06Q2jMcWSYyVbVmEWzx
	iZ6XElW4Me1moikLx9acn8IG7dvWRcx3swvxXbxjG7KRUbumuKZojcbNXofnU2DePXKsjWxxTLM
	uFm6S9u1H20pTL7HUYA==
X-Google-Smtp-Source: AGHT+IHE0iP3CmJC9cWq/VXgz1IdjBd+9uWhAl8iU3TcaMlgcq22IDmjobolfqYBrgl3A8/RlZZNzw==
X-Received: by 2002:a05:6808:1913:b0:3f4:1c2:874a with SMTP id 5614622812f47-4036987acd0mr1571783b6e.24.1746541502176;
        Tue, 06 May 2025 07:25:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:5172:9f6c:997a:41ea? ([2600:8803:e7e4:1d00:5172:9f6c:997a:41ea])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dc66d0esm2588043b6e.33.2025.05.06.07.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 07:25:01 -0700 (PDT)
Message-ID: <487c81af-6604-4881-ae78-2d41ce23396f@baylibre.com>
Date: Tue, 6 May 2025 09:25:00 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] iio: pressure: bmp280: drop sensor_data array
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-iio@vger.kernel.org
References: <aBoBR5D1UMjsSUfZ@stanley.mountain>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aBoBR5D1UMjsSUfZ@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 7:32 AM, Dan Carpenter wrote:
> Hello David Lechner,
> 
> Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
> from Apr 22, 2025 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/iio/pressure/bmp280-core.c:1280 bme280_trigger_handler()
> 	warn: check that 'buffer' doesn't leak information (struct has a hole after 'comp_humidity')
> 
> drivers/iio/pressure/bmp280-core.c
>     1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
>     1226 {
>     1227         struct iio_poll_func *pf = p;
>     1228         struct iio_dev *indio_dev = pf->indio_dev;
>     1229         struct bmp280_data *data = iio_priv(indio_dev);
>     1230         u32 adc_temp, adc_press, adc_humidity;
>     1231         s32 t_fine;
>     1232         struct {
>     1233                 u32 comp_press;
>     1234                 s32 comp_temp;
>     1235                 u32 comp_humidity;
>     1236                 aligned_s64 timestamp;
> 
> There is a 4 byte hole between comp_humidity and timestamp.

Yes, this was the intention of this patch.

> 
>     1237         } buffer;
>     1238         int ret;
>     1239 

...

>     1279 
> --> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
>                                                         ^^^^^^^^^^^^^^^^^^^^^^^
> So I believe it leads to an information leaks here.

Aha, so we should e.g. do memset() to fill the hole first.

> 
>     1281                                     iio_get_time_ns(indio_dev));
>     1282 
>     1283 out:
>     1284         iio_trigger_notify_done(indio_dev->trig);
>     1285 
>     1286         return IRQ_HANDLED;
>     1287 }
> 
> regards,
> dan carpenter


