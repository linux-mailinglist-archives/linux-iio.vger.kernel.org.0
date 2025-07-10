Return-Path: <linux-iio+bounces-21499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B00AFFA0F
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC905A06BD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 06:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B212264B6;
	Thu, 10 Jul 2025 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnvAWsei"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC86522338;
	Thu, 10 Jul 2025 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129978; cv=none; b=uXr8PHdh3lTMCwKESNSHDkOqcbn5OfHjEMuV9QhbG7qrF7IdoTC01xRbzEKZuBby8auNnTXzEptpSnTrvfug4zVLzCVAP6W90zJn40RElJn8FVPCrklLxd9coUnnkJIk3F2rnsSuU0Ogr+XQJli3quHp2pRZvApWDlcNt7vdZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129978; c=relaxed/simple;
	bh=SaWBkZcHZ4aKxg3FkTHQpx1YP6uSo8+yenkvJCAFQCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hMsqdp0OecExo1XM50hsWKQlI9MIT3EuGtlLpugIuUVqdGxSitkB6xNAT5fyG6JZnX1KBdrWO9sd95+pKi7O86gOSIjKhXzpj1U9mjaTU4IXwvLgwK4OZRt4a6sdeOMWtA/EOUSvrCcSAO9IJQGhyPZzgDRehlHaxOA+GwzkBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnvAWsei; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-555024588a8so517635e87.0;
        Wed, 09 Jul 2025 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752129975; x=1752734775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBFok7NYlB5OyToL0/XSTt/GomMYeSZX2t1V5vo0a+Q=;
        b=bnvAWseiT7ldDile1aB7kwlnlhc/dlckfjTyNua3QFE31AgbgnCfzy4/iKjOTMcsRZ
         wUa+3NLGsG7/7Uq0hEBPpaXrN1eXGOh7v0Z5MJ5lcEDstCNynH+hPUl3OC1nUMoToBq0
         H/DZoIL0TwuG5xGtb6G20Nj8OHoL0z6QZNVkF0vqVneqKLvxmvCJkLwY3n45ek8cLzy4
         aBWpwv7iekLx7ARej70SDDL8fmsBiYuuu7rGkhebnYHpS9AB1ZSldwo+xdlKb2fknhSV
         umI8KTvn39gGtHNWG4+gqg/UjK3caZBrJjyGn18jI/rkgIUWQumuoEkgzGktznYbT5ko
         g1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752129975; x=1752734775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LBFok7NYlB5OyToL0/XSTt/GomMYeSZX2t1V5vo0a+Q=;
        b=c929To0ZTrXEi+sbxfp20IWgoq35mq1jNUESGQ8eN+Ww0RXzRaUzFTLC5Gezl4ImZo
         6VFZGugHyzQuVBfVrtI1slP5gtEq0yJDY438QU9FuShlQxkfvPjWS8+ju1I4QzdVAMBf
         Z0lEnhEkTOpngXdQZKXOGsbP652Gnqhlv4c/sFvrtiUbov2VS6CbP5iCAlvVPrnIe1/Q
         Se1ZdMC0eQLdN4TVQzOSNIOHtSPVMmF/+4IC1oYdC4WdilpLZs1G7BpTFhZbP4YG2IH5
         bVk0JCVqbjhFwEURxDP3ijxdR5/kjcfmces72EIQeeJIz5gpwpAWsvl+pOxchfTtPsJI
         7Cbw==
X-Forwarded-Encrypted: i=1; AJvYcCWsxncTP1xz+/acWxJ26FrI1YEyXmMdshWw7BQZNApdHGSJxMxWlPiRUfc1He+UV3geoRlWRM1YbhF5PMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy33bdIV3YuM+Bvk/IyWjg/iBW8h8VZ79T9DmA7sVtYsIQeHNru
	xlIG/iZkc831ObG8ENgSgs408UM1elkV87MeiCd9u4u3X75UpAgysvMh
X-Gm-Gg: ASbGncv0ilNoeY+S684Attlerty7pr6ZuveXH3zPXf3+ylbZNYZQ+RE1Xj5dTBKAjZW
	kezqms1GIVzWofMZ1g5p04FAacH03L0mldHz+wYLYH1UVgvjg3avYjWk51QFDZpHLac328L+BlW
	BUVp3Vnwgf1kJL+tIze+GUcJiRGgKOaULfa+XXC7wyjh68rgFOqYpYRAAjM0HZZV6kh0/nNX0Mc
	BTscaR3ux9U2Qot2nutbc7pRmzKsSovs5rO0zfNQteOxQfGX2qEyPI7qPXXVn2PZwORoYBtCyNb
	oJQ7Fwvs9Zs9XlyKW2b7SpBqF0nV8srrOtaQ9s5wJfZMIW8dPUvHH3DLa0klxzEkGP91Frh9FJc
	7kBXSpCfdAluK/s0pR0QLabjpzlB808taviSY768eXuM=
X-Google-Smtp-Source: AGHT+IE+mINE/wii0xEgdb9J5tybiK7jCpBxHMWvI9VPEHL4zjMQcjhCWxPOVh3uPNn/j1WMmMb/vg==
X-Received: by 2002:a05:6512:4019:b0:553:35ad:2f33 with SMTP id 2adb3069b0e04-5592e3e0fbamr545945e87.37.1752129974453;
        Wed, 09 Jul 2025 23:46:14 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7ebf3sm233094e87.243.2025.07.09.23.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 23:46:13 -0700 (PDT)
Message-ID: <090c1c98-0f68-47d5-9e57-bd764b2856de@gmail.com>
Date: Thu, 10 Jul 2025 09:46:12 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/80] iio: accel: Remove redundant
 pm_runtime_mark_last_busy() calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Waqar Hameed <waqar.hameed@axis.com>,
 Julien Stephan <jstephan@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, Bo Liu <liubo03@inspur.com>,
 Greg KH <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Sean Nyekjaer <sean@geanix.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Rayyan Ansari <rayyan@ansari.sh>,
 Francisco Henriques <franciscolealhenriques@usp.br>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
 <20250704075418.3218938-1-sakari.ailus@linux.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250704075418.3218938-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/07/2025 10:54, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---

Looks good to me. Just one comment (to 4 drivers) - but I'm not 
insisting it to be addressed :)

> The cover letter of the set can be found here
> <URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.
> 
> In brief, this patch depends on PM runtime patches adding marking the last
> busy timestamp in autosuspend related functions. The patches are here, on
> rc2:
> 
>          git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>                  pm-runtime-6.17-rc1
> 
>   drivers/iio/accel/bmc150-accel-core.c | 1 -
>   drivers/iio/accel/bmi088-accel-core.c | 3 ---
>   drivers/iio/accel/fxls8962af-core.c   | 1 -
>   drivers/iio/accel/kxcjk-1013.c        | 1 -
>   drivers/iio/accel/kxsd9.c             | 3 ---
>   drivers/iio/accel/mma8452.c           | 1 -
>   drivers/iio/accel/mma9551_core.c      | 1 -
>   drivers/iio/accel/msa311.c            | 6 ------
>   8 files changed, 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index be5fbb0c5d29..f45beae83f8b 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -335,7 +335,6 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
>   	if (on) {
>   		ret = pm_runtime_resume_and_get(dev);
>   	} else {
> -		pm_runtime_mark_last_busy(dev);
>   		ret = pm_runtime_put_autosuspend(dev);
>   	}
>   

// snip

> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 6aefe8221296..44d770729186 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -637,7 +637,6 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
>   	if (on)
>   		ret = pm_runtime_resume_and_get(&data->client->dev);
>   	else {
> -		pm_runtime_mark_last_busy(&data->client->dev);
>   		ret = pm_runtime_put_autosuspend(&data->client->dev);
>   	}
>   	if (ret < 0) {

//snip

> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index aba444a980d9..5863478bab62 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -227,7 +227,6 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
>   	if (on) {
>   		ret = pm_runtime_resume_and_get(&client->dev);
>   	} else {
> -		pm_runtime_mark_last_busy(&client->dev);
>   		ret = pm_runtime_put_autosuspend(&client->dev);
>   	}

//snip

>   
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 3e7d9b79ed0e..22768f43fd24 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -672,7 +672,6 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
>   	if (on)
>   		ret = pm_runtime_resume_and_get(&client->dev);
>   	else {
> -		pm_runtime_mark_last_busy(&client->dev);
>   		ret = pm_runtime_put_autosuspend(&client->dev);
>   	}
>   

Do these really warrant a function? (Especially for the mma9551 where 
the function is exported). I think it'd be fine to have the 
pm_runtime_resume_and_get() and the pm_runtime_put_autosuspend() called 
directly without these wrappers.

Anyways, this looks good to me - thanks!

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours
	-- Matti



