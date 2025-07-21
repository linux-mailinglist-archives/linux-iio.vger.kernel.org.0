Return-Path: <linux-iio+bounces-21807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC442B0C1A2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162763BBC9E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B39298269;
	Mon, 21 Jul 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKMwD7tk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F10298CAC
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094672; cv=none; b=tERF/RMQUb2MVUgwP34jtKFo4k7deAcQIAs3h58Nvwfq6nMx9FikqANYftOGyHkQif/Lkd/8rwHm2STGuKe1lsuaUwtg2QoPFOdOozI8RbXq9mocP2fxvHG+BpjV0m1cY+qti3EeRtXhBLJ0ckNHFr5qdTMV8jFBY8/Yb8Rpt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094672; c=relaxed/simple;
	bh=Jyg9VIduqhzzijMHnSKAC2B6G1xD8WFdq0kn3G+RX/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuAhFUj6oTCjgy8jPqz+y9KQg7mJ/lHXRW8jIKXEEvtsLQF4EaQ8IV2J0hfj8ZOjCC2NJMwQMeGs9HrOmMI1NVNUc25zggbHKe2WrF8Y9KF9jhEgUATKgPrFiWv1tjlM/t8F4Gj3d6Bgup7OVmSqIzcSWPlYL2VfZCmydkQyodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uKMwD7tk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a528243636so2499725f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753094668; x=1753699468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jv8CKZAnBLUK/0fb5CiuD7Hp6E+b8QPJo8tRAQ5ZhDg=;
        b=uKMwD7tkDvM6y1ai4Cu5EVRzwrIwC83suT5zEhID5qe2mwleN7zru6IM8MNu7+SUbd
         vgX4l23PX6jIuXULkaJ+TZ3rQ8DgvCSmsxzitnTo+2P+xR1z05kAhjPbNO6apTwr4DNw
         GmJgdxYa2PqJOo0U+EiI1aiKju5Ov4DsUZBp//Q+IZKwDwDBHfy4Cs5PN/+snhj940Cs
         s+wcZA+nsqI0Ywhwe7pY9zH8/gYB6FboDPs8KArN3fVKdyB6hxVxGyqOE8f/YxHjxS5k
         Qq3uIYladgqRGv6yBgyWOrT1rgbsPT1QMm9kqMQdY3DKEFtIM0h0D4TmxlDxvzaX1xRg
         musA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753094668; x=1753699468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv8CKZAnBLUK/0fb5CiuD7Hp6E+b8QPJo8tRAQ5ZhDg=;
        b=Ck39vNFZkykpmxor85fJ6Np6rsS7NIVNZAWbjC/xwBYgV+zCtxN2SIYgSiIud+o/fK
         3podA7Agg2zDJvk5Az/vOxtTJCQ/ukVWQ/4XpZ0HYsdPdow2bhGZsHbZqnK1DiZPQRTp
         XAfKST6wAPzK4rsg6mL0FCfB1PiMkwlowIKGGigsuE0L2pyOZ4kLwyL7Izpr73vSXK8/
         t409jUoYq8eS7DCHrTijioKhd+bk8IJzJMH2J+jHkF6DiCrT+ygpgcZZg7+KwSYqkxYn
         2oMhb8hcy9amw548bihEahYorvDGaDoockdBzp32WEeR7U+yNG6b+h+Av7IkSuRkSYoE
         Abvg==
X-Forwarded-Encrypted: i=1; AJvYcCWH2lE7PadDDslJBBwQrqVOJkYbv+oQpOMm5gDbamB/gs0w+NNVMcFB8maS8mVaz69d8XiWqUKDBpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzejsu4uGEoBKQn2wLtnoazY1SjwWQ3BFiQ8KR9bzxRh07joDrJ
	o8tEdZw5sopC6CjjM4Uxk5foO+bmHj0mwZ65n+QUyc8tlRgDM+QHXomr0Uc4+eW9ir0=
X-Gm-Gg: ASbGncuBCZsPXe4Oon9TMTSCtddwjqQLJshS9ygbxt3L4qHHg0QRX4KRGwWp482VSwT
	xOLfpJ3YusWYdsdWSqZyQET8ZRS6g/QIOCd+6B/2ckcLRMTjQ5WBkKeXrjdEXMYPOAlVKjYUPEJ
	DrEV+ChVLz0eJra7HQ42X3j9tG79P6Yb3SC8hWRj59m7sqei9BZ54cc7WsASY/iMBQsMckWueJ4
	w/dE3SlLUDPedwy0KZ5LRNzqw/PH/qx2qx37viLFtvKHFuulOufE36qxrNnfWytUI0zSNizhKQz
	RAMkakhOVFHHXb+FJqigQtjjm+L38AFxhr9WhhhcCuk97P3AjXiwhfStOHuN7kT8lYqmxUbFa/V
	yLnUUxX3dvojHgiyonN/UuHfK44IrmbHLvFLxTzGZAK2y07boeKqpyT6gSjb6FEDsuZWINxtv2w
	==
X-Google-Smtp-Source: AGHT+IHsr6BfHmmGvAFEpmk7FK7MXUXtHfZVvvvivtdI5mefMv0lLuRMGQqdMBTcEDjNOnr/mFRYmQ==
X-Received: by 2002:a05:6000:4108:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3b61b22ec16mr7504872f8f.56.1753094668208;
        Mon, 21 Jul 2025 03:44:28 -0700 (PDT)
Received: from [192.168.1.36] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm10159988f8f.58.2025.07.21.03.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 03:44:27 -0700 (PDT)
Message-ID: <e724e6a2-21a8-436a-8809-ce73c0afa433@linaro.org>
Date: Mon, 21 Jul 2025 12:44:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 sboyd@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
 krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-3-angelogioacchino.delregno@collabora.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250721075525.29636-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 21/07/2025 09:55, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate a SDAM device, internally located in
> a specific address range reachable through SPMI communication.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for SDAM
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

This is honestly a really nice improvement :D>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/nvmem/qcom-spmi-sdam.c | 41 +++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
> index 4f1cca6eab71..1b80e8563a33 100644
> --- a/drivers/nvmem/qcom-spmi-sdam.c
> +++ b/drivers/nvmem/qcom-spmi-sdam.c
> @@ -9,6 +9,7 @@
>  #include <linux/nvmem-provider.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/spmi.h>
>  
>  #define SDAM_MEM_START			0x40
>  #define REGISTER_MAP_ID			0x40
> @@ -20,7 +21,6 @@
>  struct sdam_chip {
>  	struct regmap			*regmap;
>  	struct nvmem_config		sdam_config;
> -	unsigned int			base;
>  	unsigned int			size;
>  };
>  
> @@ -73,7 +73,7 @@ static int sdam_read(void *priv, unsigned int offset, void *val,
>  		return -EINVAL;
>  	}
>  
> -	rc = regmap_bulk_read(sdam->regmap, sdam->base + offset, val, bytes);
> +	rc = regmap_bulk_read(sdam->regmap, offset, val, bytes);
>  	if (rc < 0)
>  		dev_err(dev, "Failed to read SDAM offset %#x len=%zd, rc=%d\n",
>  						offset, bytes, rc);
> @@ -100,7 +100,7 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
>  		return -EINVAL;
>  	}
>  
> -	rc = regmap_bulk_write(sdam->regmap, sdam->base + offset, val, bytes);
> +	rc = regmap_bulk_write(sdam->regmap, offset, val, bytes);
>  	if (rc < 0)
>  		dev_err(dev, "Failed to write SDAM offset %#x len=%zd, rc=%d\n",
>  						offset, bytes, rc);
> @@ -110,28 +110,47 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
>  
>  static int sdam_probe(struct platform_device *pdev)
>  {
> +	struct regmap_config sdam_regmap_config = {
> +		.reg_bits = 16,
> +		.val_bits = 16,

I believe registers are 8 bits wide, at least on Qualcomm platforms.

Kind regards,
-- 
// Casey (she/her)


