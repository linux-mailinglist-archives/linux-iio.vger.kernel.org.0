Return-Path: <linux-iio+bounces-26712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143FCA1BA6
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 22:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6971F303A8DD
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DE5255F3F;
	Wed,  3 Dec 2025 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ayxoBrpR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD926560B
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798620; cv=none; b=dw4LXd9inDeZLB5wRXouBC+le+L38CFbaDsZ0WGVbZYjy9E7X9Kvb30h5wcS/QIsYM56bRKy3iKqI2E+5Avf1VM491W5K1KEts71qGoMhGyer3rdL9HCYyTI+HF0uqMvbKDwp5L+950qmr9TvMoHwrq0sWyyQqIxnEkeN/NEiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798620; c=relaxed/simple;
	bh=YgHZypyagJe1BCLcrMUNn/7Ro8RBkzNoa+EVq0F9gHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgkCkeKjCYheWtIVdndoOpXgG6tArx+PF2wibH7mp7y6w1xfuZViWR4y1JoboLPSdCLgVI+JZ9cfrgqbMU6FWB8nC2GfqKmY30/FV3Uy3r2qdQ+nziVednr1+Wq8tlGkxX/G8tjeYTwKXuDjBLKxqdeTELJVgVZK6bJN11l0Kq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ayxoBrpR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e80c483a13so173274fac.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 13:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764798616; x=1765403416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aHgJcHMP1b26Of1JkY/qA3Wj2osFan8vLqjXrah45I=;
        b=ayxoBrpRlSdpuAj4hb2nfwHDgZBTI6pcQt6IS87VUXaFsV8+94uyWsSAX62AGgdU/k
         wgYDMzSwh0EVxB8FxZSeJqHY9WJRslZe7Jk8sYtG0HA8thebDaE+vPweIExM8uoiQN17
         HhSmw76DBGnHcVu8Pmtw2vcEUIajZPIeJv5q6wDJNBBj85LAQdU93NOu2wlrkcBE8zf6
         77FJ93PXTSj/LFncVo2uv678p9QA7Pf10aDJGOILbFAHzOl+n5tSDQgMH62D6edBPSrN
         GbTRXUQTosM3J8KBRsHY+RtFb8FwrSrA/M9FayQyhqbxZ+2enXKQjNhcrGWb/Tn6KepJ
         TFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798616; x=1765403416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aHgJcHMP1b26Of1JkY/qA3Wj2osFan8vLqjXrah45I=;
        b=Sn47K1D0IrKCKUYuozgBYUd7AERlCYIXwQIduvN8IF0Ihl8aibE7zmktiJPyyOhanX
         2lTqqkNlx+82fZjt1BNsjd4e0m4ldkoZKSBPxvel2MvPktFVfefln6lQmsTjcbNVMYxW
         qQbeArwjsGR34SmF5ON9ovuu3JG4QmepJUnhpuAuwdfWYb4Dh0kyJRfTuGya8SzJAHvs
         dCbPEZn3PMt3G1ugjte7lPv4+H+SE8kuU9CLpJYlXAgr2Qkx+zrII3DDQZExWeZDoWt1
         GBCewwLqsbhN8fE2EpqNYUP1DEbInI/vZUszURfO6km6+eOIDlIwUfMXUQLKGhmZF0fZ
         37Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVPMVUhrJUfl2dh2ForezCyH3ATSShRxeWBeHMuODxCrbyMdY6ARVNrVHlkO9hoQcwircifxeoW+3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZMYPNDHbsL7cu0p3NboyiGf1mezT5trnOUlI46nv0zuhwgyx
	LHl1zdfbFTdHfg9jaRXMOp309/llJj0/CFEES5i9KGGcADgupMoWnPeftKUge01J5iY=
X-Gm-Gg: ASbGncvWuQDKVacUUd1PrnPosIuvbkcR30KGc6bMqU18bGKautm8eFXg9ngKH6Zwwqf
	mcN0gy/AJefoKtE0wvxiKjq5aAFZ1335N2x5W0c6Nl+f3AGS6BOgU4aNKeqAzxRqtvplMI5I4EA
	UQHJXO8R69eVeVxdKtv2RtFENoYGA1DupfJKNtuVrUshVWiv7XFnHBE1iJZ75G1xywIw4bv6d7U
	DGUfv/q+TFO7RYY2aLcHaHm4fFAUPnOrZH/0+hAOYd8TwO7JJlaazfL2aj11ZlsXQsWla7ZEKKV
	axc4XM+Bk5IHvqSLePKJXE/qLghW8eLl8DTzoGYXw5UmKP7/LdUKq5PWz+pjc4HyZT1bF4nYKgc
	xj0QAVkmE10KBfHcvbYlepdgoHAGtfDtwgAf6ePLC5d61uksKqMNGAH5t7Zq8i9WGxrhIF0qM18
	WWcqC+kjD/kkGMeOU=
X-Google-Smtp-Source: AGHT+IFutLafJ3wb941bakA0AIIVuPFpUqb3HuvqoTC3uqOBylvA9l2fj9oSwy8CkX9eqOUervTgRg==
X-Received: by 2002:a05:6808:124e:b0:451:4c7e:4657 with SMTP id 5614622812f47-4536e41cf4amr2208801b6e.26.1764798616600;
        Wed, 03 Dec 2025 13:50:16 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6b05:aad2:5053:6d1? ([2600:8803:e7e4:500:6b05:aad2:5053:6d1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dcfdba71sm10902274fac.12.2025.12.03.13.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:50:16 -0800 (PST)
Message-ID: <40cd9574-ac26-45c9-91a4-b08ad799ca99@baylibre.com>
Date: Wed, 3 Dec 2025 15:50:14 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/6] iio: core: Match iio_device_claim_*() naming
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
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-2-b4a1fd639423@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-lock-impr-v1-2-b4a1fd639423@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 1:18 PM, Kurt Borja wrote:
> Rename iio_device_claim_buffer_mode() -> iio_device_claim_buffer() to
> match iio_device_claim_direct().
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
If we decide to do this, I would squash this with the previous patch
to make a clean break of it. Although it is helpful to have "mode"
in the name if we can keep that without breaking things.



