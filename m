Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7035A11E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbhDIOdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:33:53 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45028 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIOdw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:33:52 -0400
Received: by mail-oi1-f170.google.com with SMTP id a8so5947028oic.11;
        Fri, 09 Apr 2021 07:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VuECpWrUjP1002NTkMicGvKPOsIq+30WLEhBf1xvueQ=;
        b=F1nIgiRyQWTBat4nhQ8XYaK6cOm3HhfrboGSm/fkB77oszmWGJIMSxIxDN/KKabLd4
         IjfOviOX5YYhB4zcVdO5iX02RG5sgfHYGwErlYFiHBafY94DEUAdGhjIsf9QwVAhR8xo
         CszDnFlNnU2TndtcKLMuqxgfvyVPfJyupbpCL3iraO8sGEAbuSalJEgNGGhsxJOFdheq
         IrPaaUK3ylhc5knHcD8keJwfYZEIG7RqEtgrPRWIr73QVh2Mdq3nVG6crCip4bZ3XLdV
         QjGpVyvSrsDGmpeqTy8WH3pgwgS8lJ5OvH2hIE90kT1CUt+IIXehQK2IWcA7PBL7hPnC
         t/2g==
X-Gm-Message-State: AOAM533a2o1YGOyA36LlyC6PZB1g479cqb+zHVTcMI48iLUnlLC4QeT2
        s1SddZFTDVF6IPGCYfVypvKcS9hn/w==
X-Google-Smtp-Source: ABdhPJx+/KafgBkhhh32hzighlCMnMFD6t/XaNDbwF+f8tVXc0jdkjV7RftPyvCjWIbmWbeUN1JE9g==
X-Received: by 2002:aca:33c6:: with SMTP id z189mr9820665oiz.27.1617978817751;
        Fri, 09 Apr 2021 07:33:37 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o23sm637008otp.45.2021.04.09.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:33:36 -0700 (PDT)
Received: (nullmailer pid 3609280 invoked by uid 1000);
        Fri, 09 Apr 2021 14:33:35 -0000
Date:   Fri, 9 Apr 2021 09:33:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings:iio:accel:bosch,bma220 device tree
 binding documentation
Message-ID: <20210409143335.GA3609233@robh.at.kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
 <20210401174112.320497-3-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401174112.320497-3-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 18:41:08 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Linux driver currently relies on the driver.name to match to the
> compatible, but that doesn't mean it isn't a good idea to document it.
> 
> Only real complexity is the 3 separate power supplies.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/accel/bosch,bma220.yaml      | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
