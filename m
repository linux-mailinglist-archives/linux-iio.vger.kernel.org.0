Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09595417823
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbhIXQFF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Sep 2021 12:05:05 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37778
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347280AbhIXQFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Sep 2021 12:05:05 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 22C5F40784
        for <linux-iio@vger.kernel.org>; Fri, 24 Sep 2021 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632499411;
        bh=XSnJxfEBt5YWoJGVTt7uPSu776tBxvxqT4EkYhJhjIo=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=IYNSuk1j1yr+CtfY5Xham51abCzKx7pjG+badrdDeTJd/hpLGsnfGWGT9b3/7AUkO
         z7xi+r3Kn6oJM9K5msyvau+LjdNJ4LeaJo7k8GAJo93roWwDkEa69sEGN/y4/qTWg+
         3X34zwLk9xgbFudV77uUKNzrjeFL4wLW/Wvb8Yi+RY6UMHUw29+cOBILFD3acs/Aqg
         cA1LRCyx3z/PH4pK7kLBKfjc/Casrcjvgbeyb8R/EC8b4EmyNX/NEA/oZhDxedrac8
         vCLL+jR7maoCweBi8nqu8L+pLuWKETUTRJb42ROVH3KBiu077WyeQa8du1FpHVscho
         LqCh1mTuRlVQA==
Received: by mail-pg1-f199.google.com with SMTP id f22-20020a631016000000b00269ef9aae08so6463721pgl.20
        for <linux-iio@vger.kernel.org>; Fri, 24 Sep 2021 09:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XSnJxfEBt5YWoJGVTt7uPSu776tBxvxqT4EkYhJhjIo=;
        b=qyaQsbJKv5eUcPcVZ0kD+Z0EtEN9TLRNEAGI0yKIO7cZhgyC0ZR3hmYjV9TC69BwRM
         YvC8drg4yjhHbsNfUHWF7BBeH4DS+m7LbOSTvhab7UTEdm7bquDCIfac4CnvUEi8SOTJ
         mKTy1Wp9VdxDmni6fT9G8mGE0+4FYcp7cUn73nEO4hgsKfU0BMSoqfH9a4EqWMYDToTY
         vWme8U41LSszy1+lVncGj7e5KA90+ZFeGIfIbV6DI9fFbuzrFkNepBZHSl9iEquaM+T5
         NfLv6dZKvw8AgH7JIjvQH+MyWoy6x5tbIzcAnkXHc9I1ZGL6kZSLeDS69EjmFoH9/Ugo
         ZUqw==
X-Gm-Message-State: AOAM532X6ryi1W5ezYADuxCtjERHsSk1MA/Jr/NV+sVYgBg4iBZW8u0m
        2YDN/59ZZSQ9Q1FPhD2fGQ3ACuplQCdi1a38ZPJOb3j+jdMLpNxpdxKFYeS1SbigXr3lLbPg6q7
        btTGsOng0vVBjkJnFk/5IgcYmdsVgpTfzhcNTtw==
X-Received: by 2002:a17:903:234c:b0:13c:7a6e:4b43 with SMTP id c12-20020a170903234c00b0013c7a6e4b43mr9721663plh.29.1632499409597;
        Fri, 24 Sep 2021 09:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbq17OedBYOqqvHCiyPf1GcC81qSNLHfVaTfFKuYJaYW2V/CpDG52XQo9+c/uPpJZRP3liTQ==
X-Received: by 2002:a17:903:234c:b0:13c:7a6e:4b43 with SMTP id c12-20020a170903234c00b0013c7a6e4b43mr9721620plh.29.1632499409308;
        Fri, 24 Sep 2021 09:03:29 -0700 (PDT)
Received: from [192.168.1.124] ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id c199sm9747942pfb.152.2021.09.24.09.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 09:03:28 -0700 (PDT)
Subject: Re: [PATCH] drm/bridge: parade-ps8640: check return values in
 ps8640_aux_transfer()
To:     dri-devel@lists.freedesktop.org
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210924152607.28580-1-tim.gardner@canonical.com>
From:   Tim Gardner <tim.gardner@canonical.com>
Message-ID: <8cdae251-f75e-bde8-a53d-27c77ac624c3@canonical.com>
Date:   Fri, 24 Sep 2021 10:03:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210924152607.28580-1-tim.gardner@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 9/24/21 9:26 AM, Tim Gardner wrote:
> Coverity complains of an unused return code:
> 
> CID 120459 (#1 of 1): Unchecked return value (CHECKED_RETURN)
> 7. check_return: Calling regmap_bulk_write without checking return value (as is
> done elsewhere 199 out of 291 times).
> 204        regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> 205                          ARRAY_SIZE(addr_len));
> 
> While I was at it I noticed 2 other places where return codes were not being
> used, or used incorrectly (which is a real bug).
> 
> Fix these errors by correctly using the returned error codes.
> 
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Robert Foss <robert.foss@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> ---
>   drivers/gpu/drm/bridge/parade-ps8640.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 3aaa90913bf8..591da962970a 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -201,8 +201,12 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>   	addr_len[PAGE0_SWAUX_LENGTH - base] = (len == 0) ? SWAUX_NO_PAYLOAD :
>   					      ((len - 1) & SWAUX_LENGTH_MASK);
>   
> -	regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> +	ret = regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
>   			  ARRAY_SIZE(addr_len));
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "failed to bulk write ADDR_7_0: %d\n", ret);
> +		return ret;
> +	}
>   
>   	if (len && (request == DP_AUX_NATIVE_WRITE ||
>   		    request == DP_AUX_I2C_WRITE)) {
> @@ -218,13 +222,17 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
>   		}
>   	}
>   
> -	regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> +	ret = regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> +	if (ret) {
> +		DRM_DEV_ERROR(dev, "failed to write SEND: %d\n", ret);
> +		return ret;
> +	}
>   
>   	/* Zero delay loop because i2c transactions are slow already */
>   	regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
>   				 !(data & SWAUX_SEND), 0, 50 * 1000);
>   
> -	regmap_read(map, PAGE0_SWAUX_STATUS, &data);
> +	ret = regmap_read(map, PAGE0_SWAUX_STATUS, &data);
>   	if (ret) {
>   		DRM_DEV_ERROR(dev, "failed to read PAGE0_SWAUX_STATUS: %d\n",
>   			      ret);
> 

I forgot to mention this patch is for linux-next next-20210924.

-----------
Tim Gardner
Canonical, Inc
