Return-Path: <linux-iio+bounces-19976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EAAC5C2F
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 23:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCD71BC123C
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 21:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A69213252;
	Tue, 27 May 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5WMtZJB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450021FDA;
	Tue, 27 May 2025 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748381281; cv=none; b=tbhwjAqbLBpw2zfOZSDYKR1rJIbBN99xEGpMFFTUrhHm+9cDT+1dmwW7DWfVYt99bz7Gw2tWZenJ4zN60ZAP9Zm8UXu0JQUeibWgd8sq8F8c1nUIWXAV43dNI9qba2eX8wpN9T2ojjy8RvHUX/IkfI8XuAaOrtveVfOHIzlIp+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748381281; c=relaxed/simple;
	bh=oN8PSp5/cFCTm8jcczwFU1FScvOvswG+E7fk/eNoR8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrTt5FAFuAdEEVsY12NwcGqj/J2E3QFyv1cps9dlCoHig4/31xuOQz2rEjHmFv6Vulx/ZzUcu2b3oN8pnAAWVgtXJrCQ1ydqyH3e9pUqM3VbU3Orb3To/lHpew6mkYfQpSTBbr4YIFpQSH8N35E5wWN6rR/bcTCu5eG6y+VLt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5WMtZJB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2341814895bso29527455ad.0;
        Tue, 27 May 2025 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748381279; x=1748986079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtnSy4gtUk5x74SNtlqyzT3FfVD9hF8kASVcFy4ZtBk=;
        b=G5WMtZJBJPszK7n5sii6feXgmSv+tOrQLo/VTYzmruErJfqbTqxqncAeO0B+lWl4DV
         jy0Y8AMUlClv3tAFt8yyyd41qLNCHKjTwn+2ZHc4bPkuRALVq+xM5yemTRL1ZPGS9Nng
         ulobhm8RE+Wq5wQ8cvnbUJKO8jAdvudbdvkFLYYoEIgd8XBZzPqcWSTUZtTIgvaZYmE/
         +FulySl6Hpei20ejHbAjsxKSRN+rvzoH5/hm+mFnwnqqf/lgNZ6nIi1Gp5bOnfpbP4J/
         DhtLG64u3YjY1PXx6+hM7dRqvFwpc47ug/+m9/H/athf5uo3qhflhFSFPWb9dGyNhNWM
         SaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748381279; x=1748986079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtnSy4gtUk5x74SNtlqyzT3FfVD9hF8kASVcFy4ZtBk=;
        b=cZRby8gHdN9K8qI+zzdspZwQ1O+jkWKclO46k0xlaK2FwCEe2ZfULb2QqSwX/G4Yvx
         CWYCukt/nqvuo3ponQhm7Bj2kWtr71LgH6oqkIgWWt0BxlOoHVNUeuavd+1FJnydPPYh
         m0uTmmz3IoQfxQ2RE7GBl9LgrsOx/YYkkIg1StZbnksxLakljmIk1Z5AMoVi5NCq7Q2p
         hm/gJqYz63dC36/1dFjUxlrhlLyh6fDzuilLHv+uhvdcNq/txdcOGwJueVNwLmLQn9Ha
         8lrLRiD/UTRwykwsKSwjsUPcKW20v9o1Ylt7Ly3+JNTBCfoPDZLrOkjnTP0tgA3szj/q
         URbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAK7ULQ1KlzqOd0XX1WsKT4d055lqt/YsKtIlEIHFJif+03VPqPOpfDVLXILqAWDzxe9iSsCln0VGNRUYg@vger.kernel.org, AJvYcCUna93QlTw+HAydYXTAlmmHWU0pjD/VRiRiyoS+I1WDMRy90WGO/QMY0HA5U3H/gIMIlyWbJwlgJzg=@vger.kernel.org, AJvYcCUqwGlkOIfL4UnpCz9k+MNpYmcBD0NN3u1mkTZaiRoqgTKOYaTE5SnliVpvb4fAP+gYjgIN8Hp1xX43Ckv1hryqApw=@vger.kernel.org, AJvYcCXkYnUg9NeeXxxV1Vnu6hYCiScDdNOb8s2ZKP86npKJRBYgHErGrPRVXUs68YosiMU8TRz9GVrsoxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXqDcu9ZHVg9B2RH5KIPoAJAkFc7aTZsR1gEW1/zL2hdRwndn2
	DjoII//fD5eokuLOy/4qxxRTfZDbqeo9AhB3YZmyqjeOawziDiXv4O84
X-Gm-Gg: ASbGnctSraNggLV7l6rAUdu7+qDAoi1NFzz4kaC/Hy1k2X+5NV0Als/6dINpdnVmlYD
	BHGWrG/KVrBt7aFwaifDjLE05vgxxQfaaWI3Uda/yNzso/TYgh4kpnO72SUrkRJ1e/HGhCdxskh
	4ZC+ki3Ri2bHYzFiUmaXoPGr3WNgcufq/vWjB4OkOhP6XQDeJAPjj140rL5P61pKBe+Lx1FzN3y
	Yk5TbDKRbdZSiHkB4ftIRbZ64h1+SISKt31c98dViu2lFMGDFKK6/XAnk9LASaCdwpHYXRVRD9g
	KEp8ucTHCnD1aS8FF0F2DtrZMrvld0OnZh04GiTAHxFXl8mL78AI
X-Google-Smtp-Source: AGHT+IE9K1qVTsFedKeUhDJK4ylY4AgpSEX6di2VB1nSvwGIqKNUOGFRIn9ZG31PAGJe3Q10c2UGWg==
X-Received: by 2002:a17:902:e74b:b0:234:18a:d8cb with SMTP id d9443c01a7336-23414fbb76emr205953485ad.42.1748381279337;
        Tue, 27 May 2025 14:27:59 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:234b:b801:3ed0:528a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234cc11fea6sm468875ad.56.2025.05.27.14.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:27:58 -0700 (PDT)
Date: Tue, 27 May 2025 14:27:56 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, ulf.hansson@linaro.org, jic23@kernel.org, 
	daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, bhelgaas@google.com, 
	geert@linux-m68k.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
Message-ID: <hojdkntm3q5a5ywya7n5i4zy24auko4u6zdqm25infhd44nyfx@x2evb6sc2d45>
References: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
 <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com>

Hi Claudiu,

On Mon, May 26, 2025 at 03:20:53PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The dev_pm_domain_attach() function is typically used in bus code alongside
> dev_pm_domain_detach(), often following patterns like:
> 
> static int bus_probe(struct device *_dev)
> {
>     struct bus_driver *drv = to_bus_driver(dev->driver);
>     struct bus_device *dev = to_bus_device(_dev);
>     int ret;
> 
>     // ...
> 
>     ret = dev_pm_domain_attach(_dev, true);
>     if (ret)
>         return ret;
> 
>     if (drv->probe)
>         ret = drv->probe(dev);
> 
>     // ...
> }
> 
> static void bus_remove(struct device *_dev)
> {
>     struct bus_driver *drv = to_bus_driver(dev->driver);
>     struct bus_device *dev = to_bus_device(_dev);
> 
>     if (drv->remove)
>         drv->remove(dev);
>     dev_pm_domain_detach(_dev);
> }
> 
> When the driver's probe function uses devres-managed resources that depend
> on the power domain state, those resources are released later during
> device_unbind_cleanup().
> 
> Releasing devres-managed resources that depend on the power domain state
> after detaching the device from its PM domain can cause failures.
> 
> For example, if the driver uses devm_pm_runtime_enable() in its probe
> function, and the device's clocks are managed by the PM domain, then
> during removal the runtime PM is disabled in device_unbind_cleanup() after
> the clocks have been removed from the PM domain. It may happen that the
> devm_pm_runtime_enable() action causes the device to be runtime-resumed.
> If the driver specific runtime PM APIs access registers directly, this
> will lead to accessing device registers without clocks being enabled.
> Similar issues may occur with other devres actions that access device
> registers.

I think you are concentrating too much on runtime PM aspect of this. As
you mentioned in the last sentence the same issue may happen in the
absence of runtime PM if the power domain code will shut down the device
while it is not fully cleaned up.

> 
> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
> dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
> device is detached from its PM domain in device_unbind_cleanup(), only
> after all driver's devres-managed resources have been release.
> 
> For flexibility, the implemented devm_pm_domain_attach() has 2 state
> arguments, one for the domain state on attach, one for the domain state on
> detach.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v2:
> - none; this patch is new
> 
>  drivers/base/power/common.c | 59 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  8 +++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 781968a128ff..6ef0924efe2e 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -115,6 +115,65 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>  
> +/**
> + * devm_pm_domain_detach_off - devres action for devm_pm_domain_attach() to
> + * detach a device and power it off.
> + * @dev: device to detach.
> + *
> + * This function reverse the actions from devm_pm_domain_attach().
> + * It will be invoked during the remove phase from drivers implicitly.
> + */
> +static void devm_pm_domain_detach_off(void *dev)
> +{
> +	dev_pm_domain_detach(dev, true);
> +}
> +
> +/**
> + * devm_pm_domain_detach_on - devres action for devm_pm_domain_attach() to
> + * detach a device and power it on.
> + * @dev: device to detach.
> + *
> + * This function reverse the actions from devm_pm_domain_attach().
> + * It will be invoked during the remove phase from drivers implicitly.
> + */
> +static void devm_pm_domain_detach_on(void *dev)
> +{
> +	dev_pm_domain_detach(dev, false);
> +}
> +
> +/**
> + * devm_pm_domain_attach - devres-enabled version of dev_pm_domain_attach()
> + * @dev: Device to attach.
> + * @attach_power_on: Use to indicate whether we should power on the device
> + *                   when attaching (true indicates the device is powered on
> + *                   when attaching).
> + * @detach_power_off: Used to indicate whether we should power off the device
> + *                    when detaching (true indicates the device is powered off
> + *                    when detaching).
> + *
> + * NOTE: this will also handle calling dev_pm_domain_detach() for
> + * you during remove phase.
> + *
> + * Returns 0 on successfully attached PM domain, or a negative error code in
> + * case of a failure.
> + */
> +int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
> +			  bool detach_power_off)

Do we have examples where we power on a device and leave it powered on
(or do not power on device on attach but power off it on detach)? I
believe devm release should strictly mirror the acquisition, so separate
flag is not needed.


> +{
> +	int ret;
> +
> +	ret = dev_pm_domain_attach(dev, attach_power_on);
> +	if (ret)
> +		return ret;
> +
> +	if (detach_power_off)
> +		return devm_add_action_or_reset(dev, devm_pm_domain_detach_off,
> +						dev);
> +
> +	return devm_add_action_or_reset(dev, devm_pm_domain_detach_on, dev);

Instead of 2 separate cleanup methods maybe define dedicated devres:

struct dev_pm_domain_devres {
	struct device *dev;
	bool power_off;
}

?

> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach);
> +
>  /**
>   * dev_pm_domain_attach_by_id - Associate a device with one of its PM domains.
>   * @dev: The device used to lookup the PM domain.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 0b18160901a2..ee798b090d17 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -509,6 +509,8 @@ struct device *dev_pm_domain_attach_by_name(struct device *dev,
>  int dev_pm_domain_attach_list(struct device *dev,
>  			      const struct dev_pm_domain_attach_data *data,
>  			      struct dev_pm_domain_list **list);
> +int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
> +			  bool detach_power_off);
>  int devm_pm_domain_attach_list(struct device *dev,
>  			       const struct dev_pm_domain_attach_data *data,
>  			       struct dev_pm_domain_list **list);
> @@ -539,6 +541,12 @@ static inline int dev_pm_domain_attach_list(struct device *dev,
>  	return 0;
>  }
>  
> +static int devm_pm_domain_attach(struct device *dev, bool attach_power_on,

Needs to be marked "inline".

> +				 bool detach_power_off)
> +{
> +	return 0;
> +}
> +
>  static inline int devm_pm_domain_attach_list(struct device *dev,
>  					     const struct dev_pm_domain_attach_data *data,
>  					     struct dev_pm_domain_list **list)

Thanks.

-- 
Dmitry

