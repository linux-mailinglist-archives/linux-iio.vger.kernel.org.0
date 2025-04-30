Return-Path: <linux-iio+bounces-18917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0887AA5497
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 21:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA006465526
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12413264F81;
	Wed, 30 Apr 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lhWWqPXS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9725E817
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746040665; cv=none; b=qQEJg4jZC4HUwaO3O3s8e6vufXMtznijVfycWNjMn7+j8kqmEI0xh3Oh/iDJd/GICNtKMlOiGZ90Hlw/9waZriyE2Y7TvpkIw8hkS7XxPvioM9e8+ZQwd8N9Xw1VWg1IbURASFz40WPjFKTENmmq3kPMY8QcCRRrL8rj+dGFv18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746040665; c=relaxed/simple;
	bh=DyHVpZe7sPP3pdh2AqiHnweC4kVwYKyUKswOh2cdzBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIoF6AYE4Yok4uBeO+cgYcX/BZXbGZLaaiiwkzPfi7CxfqVVTBmipiYdXGl8eDzarIksRSyIkEpNI4SCEHF4+ED4Zlybwa7Sl4HqGK+1Y/u989QlFntKgxf/Xl8XFVo1iKF0mGVG1aXt9/bosgmbGFDOe/NaW/zMH7q197SMyUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lhWWqPXS; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-401e77e5443so160619b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746040662; x=1746645462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXhOqh4ZLVwyszMvf+9Z/x0nU/kY8/7DOicY6xuWBc4=;
        b=lhWWqPXSjbb8svBw2Nexbhm8/Qlr4vLGQqi6fANlIs29mZi/YM1ngIyGJBiSDgEkVq
         hbzJW3eiP0e84s794SKaCJ0oaeDVOc/SfDliyOBiR00FaWopS193z8qb1eQTkbJyEcKq
         uA4lD1MMmDOtsCaaeP+pc6PfaR0t7nQT7dafSBtizksRNoBWWY9AU4/rYWqffNMeixS5
         Wq7Wme0xQQPZJQsJDZwi7aBlgR3zDGFZqEZs+KPjBOOYP6Hu/w8Ldaj7EOV9TZ6dYlcB
         qnTi/23gZv/sCq8xofcALvfzrrk0Yi2KvXNp+vVBHPiApRJKFkSVBdAMEK5U4aJeOLj6
         FOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746040662; x=1746645462;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXhOqh4ZLVwyszMvf+9Z/x0nU/kY8/7DOicY6xuWBc4=;
        b=jkC84lo9I7zHWvuLTil4hHv1Ns6dWn/BW+/33mXhODbNU+Zw1M2g07Crkyf58FNOf1
         EcFBC7VjjpLxJlsW36LMl0HAaJKVCGfaI5oUkXw6tOP/x2a0ffkV39f2sYPjwozwFqtY
         HPaA5ySN1L1PIBDKwLvIdclc4LODMptJqGyFIJQHxzGKtnOT9ztxztpvg/32SfZGh5lG
         tMjtXLM5HR1XUzEUq6y07j0t+nOK5tVldn6X+MZpr6bV4OwWYw/wRxZJJG5+7/ScehM7
         RljskoDECL+STNX8YFB9Fd3ASUWrMfZIjA0bXQ4wS501c4uFF7SLBhkWcuaVML0hXms4
         jGxA==
X-Forwarded-Encrypted: i=1; AJvYcCX768T/tEB4L3OfQomRtdReupzvTq8iiaMqiXhAK9LclInzT2QWxu4RC00nUurRNXojdVAQzRu7guI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynK9dAZQB5/qKCqFc0XR/VCaSz9C2iD3G67ZP/KnqPTptWjQgV
	IJjXberI4Jqax9IqJ7rV8qT1S+qh6Qe/bufKHYIGJbC61h8OI+UU/edrDBZ1g2Y=
X-Gm-Gg: ASbGncuDyYKHbuOkPkwC59GfDxc955MYHu/BjAY4AR+HWA8tzeuFkz2U6yON0+sN/De
	9+DeDS2Zo4y/BCVuNy9EDpcfhtlKdvjscE/y/XBjnCQS+cY+I0rzV4ZkEw23sWOGc3U8dV6eM4N
	ezvD1sf0SKkM5kHQMatRXVFRIGllE0M4oR1FwcoAzB7cdxPRqAYX/S+YFKkiv825t9hl0TlTzCP
	LsHWSUbVAKBnjGzyBO3N+caW7B2HkyrGL7ZmrgdL2/hunBD81hrj9ZdGBQH/AO7AUw92QuA0Upq
	gzywQRKPuPxbCO0w0hzCwNsRHq+tUS6972il31Ie3v/sz3wHAVnXo10pL3MoJGyPtAeVY0VrRUd
	V5pzbK6rSPf4Ypuk=
X-Google-Smtp-Source: AGHT+IGy4UEKIqEqUHbe0JTx+91yGHN8GtDOL5hK/oCVz9Muk88lGWpmRT+rWl7rMdtnMbKuWLummQ==
X-Received: by 2002:a05:6808:2e4f:b0:3fe:aeaf:26a5 with SMTP id 5614622812f47-402439689d7mr2636968b6e.31.1746040662560;
        Wed, 30 Apr 2025 12:17:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4021291e53esm923240b6e.9.2025.04.30.12.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 12:17:42 -0700 (PDT)
Message-ID: <1f8de7bd-7049-4933-82e3-8ce71685998e@baylibre.com>
Date: Wed, 30 Apr 2025 14:17:40 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: sensor-hub: Fix typo and improve documentation for
 sensor_hub_remove_callback()
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>, jikos@kernel.org,
 jic23@kernel.org, srinivas.pandruvada@linux.intel.com, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 1:23 PM, Chelsy Ratnawat wrote:
> Fixed a typo in "registered" and improved grammar for better readability
> and consistency with kernel-doc standards. No functional changes.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> ---
>  include/linux/hid-sensor-hub.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index c27329e2a5ad..5d2ac79429d4 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -130,10 +130,11 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
>  /**
>  * sensor_hub_remove_callback() - Remove client callbacks

This says "callbacks", so is it possible to have more than one registered at a
time?

>  * @hsdev:	Hub device instance.
> -* @usage_id:	Usage id of the client (E.g. 0x200076 for Gyro).
> +* @usage_id:	Usage id of the client (e.g. 0x200076 for Gyro).

should we also make gyro lower-case?

>  *
> -* If there is a callback registred, this call will remove that
> -* callbacks, so that it will stop data and event notifications.
> +* Removes a previously registered callback for the given usage ID.
> +* Once removed, the client will no longer receive data or event
> +* notifications.

I like the revised wording, but possibly looses some clarity that could be
fixed with:

Removes a previously registered callback(s), if any, for the given usage ID.

As above, not sure if singular or plural callbacks is correct.

>  */
>  int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
>  			u32 usage_id);


