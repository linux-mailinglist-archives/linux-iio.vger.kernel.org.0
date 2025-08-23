Return-Path: <linux-iio+bounces-23165-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D8AB32A73
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FD93B4C0E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Aug 2025 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6C2EB854;
	Sat, 23 Aug 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FZEHH0DZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477842EB5B4
	for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 16:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964998; cv=none; b=PUVgGLWOrOAUblTZaJ59V5Mii5YDflpFD/0OG06PYok4BawpTZK67Go1iHx7qohELe4B3hAm3R2pNt5E1T3bQvjiggQMG4sPPtWHeq2j56AiZ3I/e2tHcY8bTsuPFpwpHZnOwlrJrvjgctnoZ9S+YC6KOyzYHXZ34Om+rhVwwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964998; c=relaxed/simple;
	bh=bua1tPQwfQWa+hvfw1onqoeCC8jdTz/SIM8NGi2GfA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyhpTQpdTfRQA7edl4ogRUJ8DUGekedGKoWSjmUNXzbTqkEyK+eC6pH3rpVQgmKVIK59KZ+8TI9jggx5qMpYX7meW7CJThBD42GWKzEEUjJ1yB00Ak1T9/pW1nEnmll0nC2RGmT4jofa3z2CrLS4IIFB2yWqkw99JqxJ1tU+tTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FZEHH0DZ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-435de81b368so1481745b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 23 Aug 2025 09:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755964994; x=1756569794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f15oMbDITgq7oB6xJ/vYq6N1D3lMcONr/Su4wF27UoA=;
        b=FZEHH0DZh51EF7Rkn4sF5+t9zG/nrnwUt9qEbMI3mp7Vu0Q/AdoRr5GJblL5Z4KjLn
         hMhG4Pp3LKTfoiH4Ynrjyk3URoRWKEXTQH9gweWupUN+UixwUlIXO7uerkk8/PyNCPA9
         M7snZxuhquuf29LkdX64ZBLdAFbfVx0od+RTSB154Vr1OWGV6MaKLxq0BlRZufdILBtV
         JXuMRf+RBJSj+0FwkHeEGIcVeUb4nY2tfm7hsW0tk3bDIraxl4VcKDYS/sZKWcjtePH8
         pAIyBJHOlcSI8SgTr7sNbMOv/PVRy7QyWwUAxj48ouXTw2MVAeJ4pzed0bMnz+Iszn1+
         PZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964994; x=1756569794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f15oMbDITgq7oB6xJ/vYq6N1D3lMcONr/Su4wF27UoA=;
        b=F86NiEs9+X2fHNTHJZhEd+REp7whnyb3kjRk4ENRexOXf87gp92pn1bhObvU72UKNU
         7KRJGs47XRU5OLsH/ecy5OYjb0bro/E2bAbYaMkc2sN/rZ3WW6kLJdpReovg7DZ2p0Uv
         2La+J6dPdbyTVu4z++IPlkzOLOVKRyQ1Co242aA7xi+Kxt867ryXGaR13F6LKe+3jilE
         jHCtSDx5g0WgZ+5P/LW2rweLG9ioO+mWHls2/NzdysVIhxraGZF2GuJZwTqm58r94Uy/
         pA9vdNa5GzqiXgMEfhRaZF3nw/7UAQOK5JismKqO9jU8DaNTVomRXDLQE0k+JpwJD1uR
         /N9g==
X-Forwarded-Encrypted: i=1; AJvYcCUbHxpN87DrttycR1Y+jET6Q49GsJjyrrue6gbYZuIMqP8mBmfaRx35YeTlx0N07HFA3Flu52BDhac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8+OrV/zQITB3+FTFxfSE3pEtNgybWoli8q/LO06uDSBD+07w
	ZELEAeKqy5uM7M+3Ed0PSzD2ubiUs/XCCvrp2qcaBC0jt6WjTcb81yCsADEXrAfNb+E=
X-Gm-Gg: ASbGncvD97GPBqkdTiWDaNew3kPSRPl4wwTpWKWFvr8cG/DwY57BZ4whnR5b/jkOlp2
	2K5ZH+e1JEyjj/bLloDaAIbNcQmB20bMB08I+9edLl0EODgcJcdXTxKzEgQ9AKeHClUJF/FVxtE
	zlvuR2GNRDtw9k4h4lxjEpts73CQqQK1+GGCaljvUAAEaZDPPlnPwOhe1WqxR1/DkVOKukZftGm
	6wPpd4Gx/+IxqqaDKFSELdeUJ4RfMBGLf4xLpsLGPJQJcR3BAwySMYaXHglnAl76LLIFBUFUnt9
	p1huA6Inz5AVv42dFpgpltRNXg3687Pe6cR0Xdea9qp5z9EvjE5fSZxsvBL/PZEUh/S2Y6QaGTz
	x3dDPrmS8a7IBS/+0bk3bI1imUICwzLArYzz3P/xM1rc9+qWEM04JwLcSPHRlWOW22ijhLC7hgB
	BzyTr36xs=
X-Google-Smtp-Source: AGHT+IF5S5n10x8t6fzxv7W+hQlkYBgQ5KnbdgnfR/wPKi0MkIYRDyZabVifnoN80ZoF4puOCUaYzg==
X-Received: by 2002:a05:6808:1a01:b0:434:aadd:727b with SMTP id 5614622812f47-437851dc733mr3895334b6e.20.1755964994112;
        Sat, 23 Aug 2025 09:03:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4d25:af10:67ec:53d? ([2600:8803:e7e4:1d00:4d25:af10:67ec:53d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967bf1bbsm405969b6e.7.2025.08.23.09.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 09:03:13 -0700 (PDT)
Message-ID: <1c0fe63a-e13b-4e01-9032-686298d3b632@baylibre.com>
Date: Sat, 23 Aug 2025 11:03:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: ltr390: Add runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>, anshulusr@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250822180335.362979-1-akshayaj.lkd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/22/25 1:03 PM, Akshay Jindal wrote:
> Implement runtime power management for the LTR390 sensor.
> The device would now autosuspend after 1s of idle time.
> This would save the overall power consumption by the sensor.

How much power does it actually save?

> 
> Ensure that interrupts continue to be delivered during
> runtime suspend by disabling the sensor only when no
> interrupts are enabled. This prevents loss of events
> while still allowing power savings when IRQs are unused.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
> 
> Testing summary:
> ================
> -> Tested on Raspberrypi 4B. Following tests were performed.
> 1. Verified that /sys/bus/i2c/devices/i2c-1/1-0053/power/control contains ‘auto’ value.
> 2. Verified the /sys/bus/i2c/devices/i2c-1/1-0053/power/autosuspend_delay_ms contains 1000 which is assigned by the driver.
> 3. Changed the autosuspend_delay_ms value from 1000 to 2000ms and verified it.
> 	3.1 Verified through the timestamp that whatever autosuspend_delay_ms is set, it is being honoured.
> 4. Verified that runtime_suspend and runtime_resume callbacks are called whenever any IO is done on a channel attribute.
> 	4.1 Verified that power/runtime_status first becomes active and then becomes suspended.
> 	4.2 Verified that power/runtime_active_time keeps on increasing with a delta of autosuspend_delay_ms.
> 
> Interrupt Handling Verification:
> --------------------------------
> 1. Verified that when interrupts are enabled on the device, then the device does not get put in standby mode and keeps sampling.
> 	a. As a result interrupts are delivered to the driver and are handled.
> 2. Verified that when interrupts are disabled, the device is put in standby mode and stops sampling.
> 	a.Since there is no sampling, so no IRQs will be generated. They are only generated when the device is resumed due to I/O on some sysfs attribute from userspace.
> 
>  drivers/iio/light/ltr390.c | 246 +++++++++++++++++++++++++++++--------
>  1 file changed, 193 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 2e1cf62e8201..9e2f33a401f2 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -30,6 +30,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <linux/unaligned.h>
>  
> @@ -105,6 +106,7 @@ struct ltr390_data {
>  	enum ltr390_mode mode;
>  	int gain;
>  	int int_time_us;
> +	bool irq_enabled;
>  };
>  
>  static const struct regmap_range ltr390_readable_reg_ranges[] = {
> @@ -154,6 +156,25 @@ static const int ltr390_samp_freq_table[][2] = {
>  		[7] = { 500, 2000 },
>  };
>  
> +static int ltr390_set_power_state(struct ltr390_data *data, bool on)

This function does completely different things depending on if the
last argument is true or false. It should just be two separate
functions and avoid the parameter and the if statement.

> +{
> +	struct device *dev = &data->client->dev;
> +	int ret = 0;
> +
> +	if (on) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret) {
> +			dev_err(dev, "failed to resume runtime PM: %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	return ret;
> +}
> +

