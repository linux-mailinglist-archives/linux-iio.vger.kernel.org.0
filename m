Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C672B6F14
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 20:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbgKQTpJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 14:45:09 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46765 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgKQTpJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 14:45:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id t11so23695597edj.13;
        Tue, 17 Nov 2020 11:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=muiIIdpzRpISIhpEP3s4OT743jHKC4403fMvxisSzME=;
        b=qhfLx+d/5uGEBHacvSDCnP73RTAHVuFxx1vVEzwDyguJnQeYwXhT+iq5+Pn0Ymipm0
         OIPpuALoHehhB1VOqgSDcRkbstqjwDxfFPKp6MnvOaAPrLnOK3gT1PfI7HGND+a+/hFh
         7dm/I4jI67WLYXFOhmq3IskyECqrqoU9OzifCfPZEVjAzcADexXwaYD6Pn4CxgviQNs5
         ihqAM+3zczNEUFuGi0UupvXb+1IKJkih8KukjJnk/IAWo0VYCXw7770kfy1v+GM0YV7w
         mt+dWVag6DcCyCo4uvFWsoIwL4SrGOh2M1rXysSDU3RJGBJohhJEig4x0MnmpALyKELH
         vbsA==
X-Gm-Message-State: AOAM530Tf7hiqzDk1zupYOubx0zdoVgjPa+wl8ZKgUa5OV7cpmGLdt0W
        3zcIepeAF2W80AwlYxtVwDI=
X-Google-Smtp-Source: ABdhPJwJbZ7sC8YgF4QqYdP6pFK8WPOxYbuDV8bApZi5uHEWgST49QnMBcag3a6MHQvJmHycJyreHQ==
X-Received: by 2002:a05:6402:1d87:: with SMTP id dk7mr23076000edb.199.1605642307470;
        Tue, 17 Nov 2020 11:45:07 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e17sm939164edc.45.2020.11.17.11.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:45:06 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:45:04 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/9] ARM: dts: exynos: Drop incorrect use of
 io-channel-ranges
Message-ID: <20201117194504.GA108045@kozik-lap>
References: <20201115192951.1073632-1-jic23@kernel.org>
 <20201115192951.1073632-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201115192951.1073632-5-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 15, 2020 at 07:29:46PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This property is only relevant to consumers of io-channels, not providers.
> All these dtsi files have it alongside #io-channel-cells which indicates
> they are providers of io-channels, not consumers.
> 
> Note that dt_schema will now flag this up due to a dependency between
> this property and io-channels.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 1 -
>  arch/arm/boot/dts/exynos4412.dtsi | 1 -
>  arch/arm/boot/dts/exynos5250.dtsi | 1 -
>  arch/arm/boot/dts/exynos54xx.dtsi | 1 -
>  4 files changed, 4 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

