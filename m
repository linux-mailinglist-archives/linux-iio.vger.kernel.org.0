Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A335A121
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhDIOfF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:35:05 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45608 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIOfE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:35:04 -0400
Received: by mail-ot1-f51.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so766313otf.12;
        Fri, 09 Apr 2021 07:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q8QbNXkaNmX3huLM3Z90Cn0TrWqmFizJxfeesT8G4e0=;
        b=WVCtNfz+mPpuaFm0kBsYdylVG/wmi3IOd0xgAIiA+SKl744R3q7oMJSUm/awHL1o0j
         KxZ1F4CQNMQU0zCOtnA7mXZ5QFID2F0nEJ1DWSqzF66uSCRqoSAGQcUGEeXBGI54RH3a
         zU95JH5g5dccqRkBrMcn86Y5MTYbsrzxXg/EtZNuAqwFTwGs6OZr5xHFIL32zo6ZzamS
         DYJPs4AOz82ClJsV/DCE5b6uRnKrlLzrYqkNJ5EYmmuB0MFIgPdDMXmM/5/9o0RUXF1U
         XDoIsrcyMCKiitdGR9DDHuabYnOucVJ/7hd/jTVh+QdBg6IjpN5bKT/1k23/GBoccFc0
         mIJg==
X-Gm-Message-State: AOAM531AKY4WDJUVBVWLOBTdcFxT8IutcGF7rz9p3JVwFlgKdV6dU2yA
        TjqBV2FxB2aN40xhWUGzhg==
X-Google-Smtp-Source: ABdhPJwdpY4QE8agKY45CDc8/AHSKuKhEpjkbmzjwzKwv+xoaJjcdXRwsUHUZd/Q1/JpuALI55V4Jw==
X-Received: by 2002:a05:6830:1496:: with SMTP id s22mr12973609otq.293.1617978890924;
        Fri, 09 Apr 2021 07:34:50 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x3sm658911otj.8.2021.04.09.07.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:34:50 -0700 (PDT)
Received: (nullmailer pid 3610980 invoked by uid 1000);
        Fri, 09 Apr 2021 14:34:49 -0000
Date:   Fri, 9 Apr 2021 09:34:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/6] dt-bindings:iio:accel:fsl,mma7455 binding doc
Message-ID: <20210409143449.GA3610930@robh.at.kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
 <20210401174112.320497-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401174112.320497-4-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 18:41:09 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Binding documentation for this driver was missing.
> Note that the binding and some in tree dts files specifiy interrupts
> etc but the driver is fairly simple and does not yet make use of them.
> 
> Listed both Joachim and myself as maintainers for this binding on basis
> it's Joachim's driver but I don't want to volunteer Joachim too
> strongly to look after this doc.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> ---
>  .../bindings/iio/accel/fsl,mma7455.yaml       | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
