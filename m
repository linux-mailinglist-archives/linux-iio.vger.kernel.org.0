Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601863B37F7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jun 2021 22:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhFXUki (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Jun 2021 16:40:38 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:40933 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Jun 2021 16:40:38 -0400
Received: by mail-il1-f178.google.com with SMTP id u2so7665434ilk.7;
        Thu, 24 Jun 2021 13:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=edgRMvPD/ik/7S0XQsYyzsNfQDkWNprLd6tyWBRBAu8=;
        b=A4UDYZRV77SRJBUGL465cL033NYEr8rsamTZm+u5vn4OqpNlFzx8sOKLBVYm04lrmw
         lqF7sM0+dSFXPu0wFPa/TPbyiYZUQmLMIc58WlRMQ0mScux/E4I8qUat0ipG1ZfqL0xc
         d3bE/sLf/zTgYMusmTVQg5lZmrOL7Edhje2F14CBcphSxd4ApTyiBb6Tc7F+8VjJwpsj
         ls+ptNIzkc5AjhkJIHlhV7L1SQpnEia9EM6sxZsGajbUjN47kMHdDus9H7n5kIl+U3op
         dUazHZT7Na78tIohgHlVUJRkGgyQYtAp0yh5UvINoA3LLhOW/CYkqBvqIUNwMKWqCaYF
         LK4g==
X-Gm-Message-State: AOAM531OHmtQloHlvFTsVXBF4iybnggCA3rJ1WxzXVuwnCMBkWoZ5ofW
        BkdS26CKzi0JbOPTMuquqw==
X-Google-Smtp-Source: ABdhPJwAJl83i3OFn42a2JYx02Nk3MXeadtw5dMrjF0OFHXBzNGg7/UIUFllWRvhy/F4jyZeTKz6Dg==
X-Received: by 2002:a92:c052:: with SMTP id o18mr4815089ilf.286.1624567098623;
        Thu, 24 Jun 2021 13:38:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t16sm2389860ilh.4.2021.06.24.13.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:38:17 -0700 (PDT)
Received: (nullmailer pid 1948585 invoked by uid 1000);
        Thu, 24 Jun 2021 20:38:14 -0000
Date:   Thu, 24 Jun 2021 14:38:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: accel: bma255: Fix interrupt type
Message-ID: <20210624203814.GA1948531@robh.at.kernel.org>
References: <20210614163150.7774-1-stephan@gerhold.net>
 <20210614163150.7774-2-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614163150.7774-2-stephan@gerhold.net>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Jun 2021 18:31:48 +0200, Stephan Gerhold wrote:
> Bosch accelerometers similar to BMA255 are initially configured to
> emit an active-high interrupt signal. This is currently not re-configured
> in the bmc150-accel driver so the interrupt should most certainly be
> IRQ_TYPE_EDGE_RISING (or potentially IRQ_TYPE_LEVEL_HIGH).
> (Unless there is some kind of inverter installed on the board...)
> 
> At the moment the bmc150-accel driver forcefully requests the IRQ
> using IRQF_TRIGGER_RISING, which means that the IRQ type is currently
> ignored in all existing device trees.
> 
> Fixes: 6259551 ("iio: accel: bmc150-accel: Add DT bindings")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
> It's probably better to let the bmc150-accel driver rely on the IRQ
> type provided by the device tree in case of inverters or something.
> 
> However:
>   1. We need to fix up several broken device trees first (I found
>      IRQ_TYPE_LEVEL_LOW in some device trees).
>   2. Similarly, I'm not sure if this might break some ACPI devices
>      in case they have the wrong IRQ type listed?
> 
> As a first step this patch just fixes the documentation.
> ---
>  Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
