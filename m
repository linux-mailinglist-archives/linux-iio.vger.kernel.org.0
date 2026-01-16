Return-Path: <linux-iio+bounces-27893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FAFD3891A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB72830BC4B0
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5A2F546D;
	Fri, 16 Jan 2026 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hp0ZOVff"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B8F27815D
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768601292; cv=none; b=DR9ljvv/y+ctliib7Gs9lubqs+KF8SyXfk+aBYb5fba3cxVObrGp4qaBSt8RwiGEmAhKrZzn8nC63KedHAykCqcss0LM1kJmX3oRl+385hgIXWOVWAvmD33YTfoAa8jnw8a+4wENucyc7Xb+33ffJkrCJOiGzfj/Dnim72GlVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768601292; c=relaxed/simple;
	bh=oEe9OHwJMl1JJM8nh2NuUNyf1hkrjraAipLQfPvexEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG4w18ff7c0dE9+x9lnHj4biVbWbW02gziDfbYROcE97MlqArLmfN4Cy5qFN05RXcfAFEExDWRrvoTQWesSHg0x7ta552dskpU0fw9xAInDKonRpZkkUI5krlRSeEMi/wjj51RKYIgYo/dAcrDfGko/ZWtX0LTnDex4v1XT9sME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hp0ZOVff; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cfdd3146deso823515a34.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768601289; x=1769206089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnxLBlPiG6XltTI+ghGxYDwfnQMTS3jgBfwR6N4+E+I=;
        b=hp0ZOVffc/UpagjbyLm1fFA0F6JXj2H1KDJQGCz8n5vBO7zqgnUm4gmDRUYlhBWpBG
         lagI7g7DwC4A7xGyhK0iFITmtCSst+JZiOev8y2p6BhROmCWtsVGH4Z0/mzrY9J1pGjy
         4BpJmbNltPAMhPoPkuZg4tOKQ7QkH4d9XWugMlVvvHIyzD5t4H8iGYHw5ibsejt8ARv1
         B/9dS7ROxCGZCAt6R/sPdFZN/j2sYja4cn0q2AQKffnsmzIaB/5pGGzg7glSZMU7zMRt
         NWMHW8vrwU5SeSGCjUsVIrgRICbHj8IJthTOB9F6yEnZmqmWiVh3IO63tc5K2JPhM7ZG
         /WGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768601289; x=1769206089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnxLBlPiG6XltTI+ghGxYDwfnQMTS3jgBfwR6N4+E+I=;
        b=FXuh/CGF2a1jGPFJSfvoTUb06PzsvBMTKJaj44lhQRiWnDh697IQzevhxP2yJriFJI
         8l4LKM3Ho3txpTcrZeZp9R66utUISQ9WTMx1lh/CYwMBKHMmF+ImG2Z9kdedbiEirlUK
         DLc9YpdBUJhpbSc2FHdDfmeokpKlgglvFkOgcUoZ6eAxBmi/dYf7gKrCIgVIajizwrsr
         iMc4AsDK32C5dv09/730K7oUaZjpWqXiGrmFvticMYXKKHIe9C7G183GdRzJmpXfhjfW
         bGaUfVlatwH4swpYh806WCqYjk0ok9Bwrpy/jzJx/anCnoVSF9mughx1Alek5b79pHrq
         vHew==
X-Forwarded-Encrypted: i=1; AJvYcCVMU4o4lJXNbDDOiWWKJYerrAPIZBYhZGKcFL5w3KT8hV2v1NHX8ufv5yMjWeNgCrSx/pc+tfSBKB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CYq0GmC/eWEsArer8SxZjktXbpEUYkjvMaRHaSP9cIR3ULdn
	vTe3mB60B+UDhuq3hAi75gZ53ir/ODag/k2rsD3NgeeSSO3JMyCFW2oirveOWp02uiY=
X-Gm-Gg: AY/fxX5OjH6+6JZXTuPqQczgufQ+LA+VnZCIL+M3Otr/ImmDhIllrIX4YzAYrKBhSP9
	36hVygorYLgrKNrGG2L4g7we5I9GTXCO/k3VjPApX6c0L5reTdBytCqdSBe1owkMGa8zYQhTDbp
	WTEujrNKK3De2ofHHOPYbrt4P6/7pJzCQ3F6F8WN9n8OV8Dnau9WZGS+BfO2Ysqy7bfmh3AGEg4
	xlNoQy6fQkz+nI9hl/eUaxUqf1dJwD0uVt3nd6ksCn0bVCEFV7CZy7k4rD+LanJKyyQJUeuGBRh
	2joDR8nYZmmY8XjE8Sbe3qf+H6RwcVmZ605v0nda71qm02iPybT3VKIM/ya2PoJM8pA7R+2d5co
	pLm2UQdJbbqix6RMpuc+KmsJ4npJWWbC3t2YVnbZemw9tMImaxduknY9d+LTTy3S001NgcFK77n
	Yhy9t7a2LVEY9nslpfBBpkHAxAAZGY4E0DAyCf8A8+CeRh1TSu8rTfgOGiGxNz
X-Received: by 2002:a05:6830:f85:b0:7cf:d191:2a50 with SMTP id 46e09a7af769-7cfded8025cmr1842614a34.13.1768601288855;
        Fri, 16 Jan 2026 14:08:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:bd39:740e:f70f:5f7d? ([2600:8803:e7e4:500:bd39:740e:f70f:5f7d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2a5f0dsm2452490a34.24.2026.01.16.14.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 14:08:08 -0800 (PST)
Message-ID: <4e77ebef-07b3-49ae-9d53-d24616569a74@baylibre.com>
Date: Fri, 16 Jan 2026 16:08:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] iio: core: Introduce cleanup.h support for mode
 locks
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260106-lock-impr-v3-0-1db909b192c0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 2:06 AM, Kurt Borja wrote:
> Hi,
> 
> In a recent driver review discussion [1], Andy Shevchenko suggested we
> add cleanup.h support for the lock API:
> 
> 	iio_device_claim_{direct,buffer_mode}().
> 
> Which would allow some nice code simplification in many places. Some
> examples are given as patches, but the last two are the biggest
> differences.
> 
> In this version I dropped the RFC tag, as the general feeling is to go
> through with this after some modifications. Main one is the addition of
> IIO_DEV_ACQUIRE_{BUFFER,CLAIM}_MODE() wrappers to avoid drivers using
> the guard classes directly. I also added comments on the forbidden ways
> to use this API but I definitely still take suggestions on this.
> 
> For now I dropped iio_device_claim_buffer_mode() rename, as this point
> is still being discussed. My suggestion based on the RFC discussion is
> to do it, but in a separate patch (using coccinelle) and while we're at
> it rename the whole API like this:
> 
> 	iio_dev_mode_lock()
> 	iio_dev_mode_direct_trylock()
> 	iio_dev_mode_buffer_trylock()
> 	iio_dev_mode_unlock()
> 
> Let me know what you think and thanks for taking a look!
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
Like Jonathan, I just had a few minor suggestions, but overall:

Reviewed-by: David Lechner <dlechner@baylibre.com>



