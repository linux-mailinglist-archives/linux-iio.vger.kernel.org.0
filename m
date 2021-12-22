Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27047D658
	for <lists+linux-iio@lfdr.de>; Wed, 22 Dec 2021 19:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbhLVSNg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Dec 2021 13:13:36 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:36660 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLVSNf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Dec 2021 13:13:35 -0500
Received: by mail-qk1-f170.google.com with SMTP id i130so2125285qke.3;
        Wed, 22 Dec 2021 10:13:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vM+X4HcbixZ8QJIGmktJgMcYQkhz0YWRNaFywDlSok=;
        b=Hw2XqzOCJcKNO6UmMliNDmXpuy7uc5zhQJfClKLj2njye4GRUdtIRqO7OpJAQxvd0B
         OyoIFzBmoGwKePv5sg0YjGuuzhNoeXTRR36+OAbvMM75Y2b5En71ezRzGYh8CcQKWNtf
         lwZZc52oyFEZFFPs8k85l55K5SEh0Hu7jEw4T9wCXNETA3i1iI3JhRTnLM7ntuCtSzgh
         t2g/MabRSqETqp8z2YWq3+TJwCrdwAMI7gwlWcswZEe9l0GqE7Mr6lpQuiMeNr8vEbaa
         Db44toY44TeIGOHkuID1yEJCdNxR+yPLW5UYRF09fTMCo0Ka3CYXPJIHMazY64c8b5rj
         ozyQ==
X-Gm-Message-State: AOAM531s5WINEO8F5kHv22h12TcQUX+kroDa528r5X4XtKJv6PlJ2zo7
        FC2eD+yrY5aQjG1fRD9/kQ==
X-Google-Smtp-Source: ABdhPJz2TY1HWqHFcqHe6AGH3EbiwO4F0rIHKL7w324aXSN34Cjlve95xI73IVAziukYLx5jhWTVAw==
X-Received: by 2002:a37:6587:: with SMTP id z129mr2942886qkb.384.1640196815059;
        Wed, 22 Dec 2021 10:13:35 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id j14sm2536014qkp.28.2021.12.22.10.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:13:34 -0800 (PST)
Received: (nullmailer pid 2439455 invoked by uid 1000);
        Wed, 22 Dec 2021 18:13:33 -0000
Date:   Wed, 22 Dec 2021 14:13:33 -0400
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     robh+dt@kernel.org, lars@metafoo.de, shawnguo@kernel.org,
        cai.huoqing@linux.dev, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-imx@nxp.com, jic23@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings:iio:adc: update the maintainer of
 vf610-adc
Message-ID: <YcNqzbjeXf5nY4A3@robh.at.kernel.org>
References: <1640073000-32629-1-git-send-email-haibo.chen@nxp.com>
 <1640073000-32629-2-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640073000-32629-2-git-send-email-haibo.chen@nxp.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Dec 2021 15:50:00 +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Drop Fugang Duan as the vf610-adc maintainer, and add my self as
> the maintainer.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
> 
> Fugang Duan already leave NXP, his mail address is dropped. And He can't
> keep maintain this driver.
> 
> ---
>  Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
