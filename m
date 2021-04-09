Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780B835A124
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 16:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhDIOfe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 10:35:34 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37573 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhDIOfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 10:35:33 -0400
Received: by mail-ot1-f50.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so5883393otr.4;
        Fri, 09 Apr 2021 07:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E+K+kaLstyWO9zCvAfA3d2DlRfmbrZBRPxzUFgI+TTQ=;
        b=HjedTG7uCAbDbwCTqMlvCkkjCJNlXqGJG4dEEmI5MmhoSRivlPqcqG//zU3pINWdIY
         7gSeFE+KBpvvVG0pbRezVYgkcvJJut+f5jy4vGxpsr2D9FLtqB+mIGon5Aeqhu1Xm1Dt
         tL6PavGbrb1ioN+vzoKDtsjP59NWibc4BgIthkg4oiFsgPLp6An7NLaMGSAGv6mdDBwz
         4s1D1/sKwWf3P705KcclVXcG2Js1c0XaABuA6gLDrqsO8DR/4QL/UK4BVuAGSnivWKbI
         76in36TBsup3eq//EyHU7ONgvPQnU3yUArHXqDm0984ccnTMg29mCchWWE8cc7hKIAVT
         iDsg==
X-Gm-Message-State: AOAM533CfG+1KcKoi1mUP1IuTRZZLvnyMlSsRzwVppPeHMX08NrG82OL
        ST0bbGPixSgkUk5WM6XTbA==
X-Google-Smtp-Source: ABdhPJwcgBiqgVQ/lmHZb5U/MrLUatfIqL5XIisxyxTCdm39HpW30LXToKrGpEIAplZXwOUUqA7m2w==
X-Received: by 2002:a05:6830:1ae6:: with SMTP id c6mr12626622otd.124.1617978920217;
        Fri, 09 Apr 2021 07:35:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s3sm548591ool.36.2021.04.09.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 07:35:19 -0700 (PDT)
Received: (nullmailer pid 3611757 invoked by uid 1000);
        Fri, 09 Apr 2021 14:35:18 -0000
Date:   Fri, 9 Apr 2021 09:35:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/6] dt-bindings:trivial-devices: Add
 memsic,mxc4005/mxc6255/mxc6655 entries
Message-ID: <20210409143518.GA3611709@robh.at.kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
 <20210401174112.320497-5-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401174112.320497-5-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 18:41:10 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Simple devices with I2C interface and single interrupt line so
> entries in trivial devices are sufficient.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
