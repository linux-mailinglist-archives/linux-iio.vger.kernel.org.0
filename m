Return-Path: <linux-iio+bounces-13942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B45A03334
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 00:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B29116316B
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2025 23:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D16C1E0E07;
	Mon,  6 Jan 2025 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OoZKwq7R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0D1C69D
	for <linux-iio@vger.kernel.org>; Mon,  6 Jan 2025 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736205259; cv=none; b=qvz+nZKZeg4q4FQ15gJKFGUINEoTFzE6puX3ugQAkiDP1y3eUGxIp5fd7ryxctq2+skP2Tsdb+JrKV5GJrz/FJxBUEVpG2LH04qPDVuOP4NNJ4+gCxLQ1yMlJpNfYVpbvUNji9vMV45OKM0Pilu6HxbrmyQ1oQvP7YhvF7Nkwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736205259; c=relaxed/simple;
	bh=DWGiG0ZaCYi6bm9bvnUj4eB/X9u2rjmWWI6ax6ysPzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFr21eg0sEqg38jgqeY06/3vBegCi49aFShi0evbktRLwiPOVuQM3KxReAmbqYePUxm8igA8k/HY2xi26XxdKqW2rdF68PNjwEIQDZebVLf1JfYrP7llzqgxLmXMGb5xpx+7yQMLXFsYFFPu4YL6kZm6Vj20nv/aeiZ4btnn6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OoZKwq7R; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71deb3745easo3052293a34.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jan 2025 15:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736205255; x=1736810055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWQCafUeUdMmATvO0pbSZ6GN231PVhR0R2GjjPUfTrg=;
        b=OoZKwq7RbFbed9mk+6wlSOMj5WbdXK4uzODd+kJztekiIz5XNdsNkO242YyOyiCUI9
         VkBQe8A6GCuhAgir01iEote4A3sNZlZVKM17bE82jbTsw5frbWe6sw4o/pBzSaMTGL3w
         BMgk8mBTE4zwnb4ByoTc1SzA+GFAmWQJRdBBxMeA0hQ8DS/O0hv1haVSM1doo0IO0eGR
         YyyPaf33YRV8D3HjUXM9PRhz0qfT/eIuugNDffclF7WoE1SwPtfP7OoUNiaBzy+kw+qy
         B8GH48ijnFRbn1VXTbaHVdVd5i3JtkcZ9NBuJHZF+zNJKgrQbA46NwCBomexNb8jcBBu
         GNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736205255; x=1736810055;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWQCafUeUdMmATvO0pbSZ6GN231PVhR0R2GjjPUfTrg=;
        b=gNVJx5ItKduN8ZgJHwrRUcZNwUk5O1idZsK8QdHb4haI41cMyJ8chTYNjbDZlWPD+S
         DO99J2VcH+6lQ/4Z9JOnQbsrdufYKDAxe5EtR3K1svAuzPOJnBB6KjhApmQVuru82lJJ
         bfBee7lGmvubm7vz5MQ4V6pCwMCP/xX7CG9Mi39ETAuPlINn1NZS+ktrBZOKywP6QIKP
         /1LjYxxRXxyMrT4bCAAO6K4mU2GXgqjLcY9e5T1heu/0MYcKrR5mrQVZMmyptLUN8edC
         11FWEb6zZ/fWWj6JgXmmgKIgFv0U2efccsd5e+sk9dxF5tEqGv2ERlcRly/e0rrardf0
         enWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc6ifPOujQ0fLS4Ru5I7BqGKHHspVz6JoqmkcMQDCeFHbTA+9NWrL36x4MuHgkSKD75pbkAnt8SnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMESs10qbmSgVoav1vzY+KCXCMATKRXFxOFt3Rovrbc89CZTjR
	OUddfDN2MDhbEjHBxmn8U04dXWTjDPPUafTKON44ILVdxylDVwfnayOY27ygjFtefsl48kfXksS
	s
X-Gm-Gg: ASbGncvAunp/eDLEfqwdhtbchg9EUE9kfZ4wdClKt1+sEgRvggkzZUdrfoSdENGeaoo
	TuA6kwTN4LYvtFEmwlZglwDosoIwCNeSMBVvJ/XWI/1WSDym4VdajdEnCqq+GjBU9osG8ewxuXy
	enHAbx5EOC/CYsE9K9iGkyUMkZ4sUTmkhfLv+MirbOmYdUgkKIPXOuc1iY+CmM0cobmwJ0k3/s+
	LjAITXqPy4DYYd7Avx6qkej6ICiD7yP/nex48gxgYRv11kFLZdWW6yegJpgpWLSEpVCm2AVJSHk
	ldwuJEdZrWwI5aAXXw==
X-Google-Smtp-Source: AGHT+IFjl3QUG/LujRH9edOHr8M50nsBAH7LUspAPIDZya3BDySSLzOC6zszyB0i2V53na14PHcY8A==
X-Received: by 2002:a05:6808:16a3:b0:3e3:c411:adf0 with SMTP id 5614622812f47-3ed88f50a4bmr36406963b6e.21.1736205255630;
        Mon, 06 Jan 2025 15:14:15 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f4db588946sm9430605eaf.12.2025.01.06.15.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 15:14:14 -0800 (PST)
Message-ID: <88bd5013-19bb-45e1-a435-ab48e59db9cd@baylibre.com>
Date: Mon, 6 Jan 2025 17:14:12 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 =?UTF-8?B?4oCcTHVjIFZhbiBPb3N0ZW5yeWNr4oCd?= <luc.vanoostenryck@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
 <20250105172613.1204781-2-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250105172613.1204781-2-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/25 11:25 AM, Jonathan Cameron wrote:
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

Even if false positives aren't technically wrong, if sparse is having a hard
time reasoning about the code, then it is probably harder for humans to reason
about the code as well. So rewriting these false positives anyway could be
justified beyond just making the static analyzer happy.

> 
> So instead, this patch rethinks the return type and makes it more
> 'conditional lock like' (which is part of what is going on under the hood
> anyway) and return a boolean - true for successfully acquired, false for
> did not acquire.

I think changing this function to return bool instead of int is nice change
anyway since it makes writing the code less prone authors to trying to do
something "clever" with the ret variable. And it also saves one one line of
code.

> 
> To allow a migration path given the rework is now no trivial, take a leaf
> out of the naming of the conditional guard we currently have for IIO
> device direct mode and drop the _mode postfix from the new functions giving
> iio_device_claim_direct() and iio_device_release_direct()
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/iio/iio.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 56161e02f002..4ef2f9893421 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -662,6 +662,28 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
>  void iio_device_release_direct_mode(struct iio_dev *indio_dev);
>  
> +/*
> + * Helper functions that allow claim and release of direct mode
> + * in a fashion that doesn't generate false positives from sparse.
> + */
> +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(indio_dev)

Doesn't __cond_acquires depend on this patch [1] that doesn't look like it was
ever picked up in sparse?

[1]: https://lore.kernel.org/all/CAHk-=wjZfO9hGqJ2_hGQG3U_XzSh9_XaXze=HgPdvJbgrvASfA@mail.gmail.com/

> +{
> +	int ret = iio_device_claim_direct_mode(indio_dev);
> +
> +	if (ret)
> +		return false;
> +
> +	__acquire(iio_dev);
> +
> +	return true;
> +}
> +
> +static inline void iio_device_release_direct(struct iio_dev *indio_dev) __releases(indio_dev)
> +{
> +	iio_device_release_direct_mode(indio_dev);
> +	__release(indio_dev);
> +}
> +
>  /*
>   * This autocleanup logic is normally used via
>   * iio_device_claim_direct_scoped().

In summary, assuming we get the required changed merged into sparse, I think this
seems like the best solution.

