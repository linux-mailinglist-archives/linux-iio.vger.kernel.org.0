Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F022B6F3E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 20:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgKQTri (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 14:47:38 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35105 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731313AbgKQTrh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 14:47:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id ay21so23805058edb.2;
        Tue, 17 Nov 2020 11:47:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1z90j1aFviHm/leFksOBL+CdeH0Bxlmtq5H3/2MNN4=;
        b=M0wN1czDIG7pWGCM8K/LzlYDYHWiMHO9UmtnQkamsQ3GQfQ806/nBQA3XON9ffywd/
         gxi23A7/b1m7WRn9oGLv8RbF0w81sXVHcPznYWYXwh7fwX1a6JNdzKlstj6MNPFvCqJ7
         N7n5i47DgFnGrPcgOS1W7Ix3oBFvcahlQhmV4RCo7yQ76S11QlPw4umWWT19catXyTFs
         uQvM/hPJQWSXtLm9HbYv/xXRp+a7O47fDbF+yVBKffchIH93lKHmsGAKeyRGP41HqrlU
         I92fb//NidsUIMsGPdacoDIFaAAeEPLwaVQAFY2nDEOtfRyTTOut7vvLQy8og1tJ+UQO
         1qUA==
X-Gm-Message-State: AOAM531Q79xtHAZ2s9jQxhcuY6KoE/xZnjnwrgXyY+w618T2HuuSnlkY
        Au0Pobmmjw77LyV/dGUTFaf8mEAIrms=
X-Google-Smtp-Source: ABdhPJzEhnoc9QFVljsrgEPx2QrMjDr9X9f1H3s8Y4Dv0Y0cGPtdOY789btw2hqwx+ZCFM7QnCA0OA==
X-Received: by 2002:aa7:c503:: with SMTP id o3mr5596558edq.4.1605642455660;
        Tue, 17 Nov 2020 11:47:35 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x1sm12684922edl.82.2020.11.17.11.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:47:34 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:47:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/9] ARM: dts: s5pv210-aries: Drop unneeded
 io-channel-ranges property.
Message-ID: <20201117194732.GC108045@kozik-lap>
References: <20201115192951.1073632-1-jic23@kernel.org>
 <20201115192951.1073632-8-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201115192951.1073632-8-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Nov 15, 2020 at 07:29:49PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This property is only useful if a node has children as it allows them
> to then use io-channel properties in the parent.  Here there are no
> children.
> 
> This is harmless, but we are planning to shortly drop this property
> as it is rarely used correctly and there is little reason it would
> ever be needed as we can just provide the io-channels property to
> any child nodes that need it.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

