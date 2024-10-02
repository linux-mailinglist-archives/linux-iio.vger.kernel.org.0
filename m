Return-Path: <linux-iio+bounces-10006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB098D884
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 16:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB0F1F21B20
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52901D1509;
	Wed,  2 Oct 2024 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbNL0Frb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE251D0951;
	Wed,  2 Oct 2024 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877537; cv=none; b=asE5Jjo0eXew0hJjzjqsaISxHGfa3o34/bHuClSSqVL7Saty8YCATeBuiwGpTY9kYGD3YIJZm15wUbsUzbT4bPi1gujmjia6+jy2BQR23M9xniY6XKGy6nN2MyfQOjVH4IU6s4qa7p23X+Sp6RO5Bdv15R64CymkVOCze807Z5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877537; c=relaxed/simple;
	bh=kzEysxO2ap3NSntJagiOFBlB2EHYbnQ40iQCb2oIRLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5U3fuofiqtK0xf28pnclT5+iJ17IF+D8URnKKaaL73rcNzGd/PpXUsJLrcVKjmxG21zNwAviC0VgWoAcUcXIbftbRKM9yV1bNdHWb+8zbzX8FKWDPmlATzQoQKjsZ1zRKi+cY105ZDmMTcOcFwavEM52IlzslI5LqbsjVILVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbNL0Frb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C46C4CECE;
	Wed,  2 Oct 2024 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727877537;
	bh=kzEysxO2ap3NSntJagiOFBlB2EHYbnQ40iQCb2oIRLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbNL0Frbukj+51wQmYmNT6WV9aa9aA7MwmnkV/9lK15Rew25r0gaXhEnWPjft7UUj
	 c2fmQLNBp9Sb7TTKMl1QwGaMmDkKl2kndMXJu8Bi69C00FJe2BTcGaGhX2LgdmH1to
	 8JCPci0I5M+QiemOaMrcsv1OW+14RM6tEYmTz3pghoDGC6puORnZY/owGG2us1ADvI
	 c+5E9McgeP2F1lLr2fsheVIn9H/RgE48Ms4aiRl/DkQxYk0brod3WpW0LZTg5AZZSV
	 WPmiUSkEca5NEorG4Gw8yZc+sfbpPRFzVANINoqd6zwhH2Uyz0TxCdHA1dX4MFmGYB
	 r8+IHxoUnSQ3g==
Date: Wed, 2 Oct 2024 14:58:50 +0100
From: Lee Jones <lee@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: jikos@kernel.org, jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
	srinivas.pandruvada@linux.intel.com, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, pavel@ucw.cz, ukleinek@debian.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v8 1/9] HID: hid-sensor-hub: don't use stale
 platform-data on remove
Message-ID: <20241002135850.GE7504@google.com>
References: <20240908210803.3339919-1-heiko@sntech.de>
 <20240908210803.3339919-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240908210803.3339919-2-heiko@sntech.de>

Intentional top-post!

Just this patch to be reviewed now.

Any of the HID people around?

> The hid-sensor-hub creates the individual device structs and transfers them
> to the created mfd platform-devices via the platform_data in the mfd_cell.
> 
> Before commit e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
> the sensor-hub was managing access centrally, with one "completion" in the
> hub's data structure, which needed to be finished on removal at the latest.
> 
> The mentioned commit then moved this central management to each hid sensor
> device, resulting on a completion in each struct hid_sensor_hub_device.
> The remove procedure was adapted to go through all sensor devices and
> finish any pending "completion".
> 
> What this didn't take into account was, platform_device_add_data() that is
> used by mfd_add{_hotplug}_devices() does a kmemdup on the submitted
> platform-data. So the data the platform-device gets is a copy of the
> original data, meaning that the device worked on a different completion
> than what sensor_hub_remove() currently wants to access.
> 
> To fix that, use device_for_each_child() to go through each child-device
> similar to how mfd_remove_devices() unregisters the devices later and
> with that get the live platform_data to finalize the correct completion.
> 
> Fixes: e651a1da442a ("HID: hid-sensor-hub: Allow parallel synchronous reads")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/hid/hid-sensor-hub.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 26e93a331a51..3cd00afa453a 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -730,23 +730,30 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	return ret;
>  }
>  
> +static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
> +{
> +	struct hid_sensor_hub_device *hsdev = dev->platform_data;
> +
> +	if (hsdev->pending.status)
> +		complete(&hsdev->pending.ready);
> +
> +	return 0;
> +}
> +
>  static void sensor_hub_remove(struct hid_device *hdev)
>  {
>  	struct sensor_hub_data *data = hid_get_drvdata(hdev);
>  	unsigned long flags;
> -	int i;
>  
>  	hid_dbg(hdev, " hardware removed\n");
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);
> +
>  	spin_lock_irqsave(&data->lock, flags);
> -	for (i = 0; i < data->hid_sensor_client_cnt; ++i) {
> -		struct hid_sensor_hub_device *hsdev =
> -			data->hid_sensor_hub_client_devs[i].platform_data;
> -		if (hsdev->pending.status)
> -			complete(&hsdev->pending.ready);
> -	}
> +	device_for_each_child(&hdev->dev, NULL,
> +			      sensor_hub_finalize_pending_fn);
>  	spin_unlock_irqrestore(&data->lock, flags);
> +
>  	mfd_remove_devices(&hdev->dev);
>  	mutex_destroy(&data->mutex);
>  }
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

