Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4F4167CF
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 00:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhIWWFw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Sep 2021 18:05:52 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36610 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbhIWWFv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Sep 2021 18:05:51 -0400
Received: by mail-ot1-f53.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so10606094otx.3;
        Thu, 23 Sep 2021 15:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Yn/zKfY1e+OALBtmnxl+pt+aoAA40VXrdqikSMZ29s=;
        b=GEsXRuCWzoHymPTn1WP4eyHxUm4e6fM/O4px8YNYwoPsFwPlhVkmWxgyh2gaRIduhr
         Ipq0shlBrJ4qZssK4kzgmzRDCHTdRiUXQEuYQxM/R5cacGLn4dsjvIGotry58klXS37K
         7p6WHC0SnKHuFqFYYKbQxk0BuJs0gwPyW3MhZofDXmm+C0NQnH4epK3Ip5fWvTVOm2G0
         FTeTOhXVEUpmzyOa7xL+F96a0Rj6J1J6iujunVWpiLPBke+tZvdkvspTF0DWmJTGfR0G
         Fu2MWZDBV4k/u9+CQ3DUjYxfpA4Z6oU5ggO4D5CXmBuZRN8kPlLgw2GZ2S1BiQFtZfUz
         77HA==
X-Gm-Message-State: AOAM53316dFLjq9+6cqKw3hn7e0cDwbeWwIwosYLuQO3Lm8Z6Z8Ox8ZI
        40hBonflpHXp141lFAnvrE5gvIRkFA==
X-Google-Smtp-Source: ABdhPJzqiFPHmVyFkh2YZAtU90uejrnAT37LFonxYP0a0NeDFHNro0hOUYwnziZsZ7vbJQN+MlC7uw==
X-Received: by 2002:a05:6830:40cb:: with SMTP id h11mr937856otu.176.1632434659372;
        Thu, 23 Sep 2021 15:04:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c10sm1653247ooi.11.2021.09.23.15.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 15:04:18 -0700 (PDT)
Received: (nullmailer pid 3607140 invoked by uid 1000);
        Thu, 23 Sep 2021 22:04:17 -0000
Date:   Thu, 23 Sep 2021 17:04:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/3] iio: imx8qxp-adc: dt-bindings: iio: adc: Add
 binding documentation for  NXP IMX8QXP ADC
Message-ID: <YUz54Uv+Mh/9j+rY@robh.at.kernel.org>
References: <20210921052821.91-1-caihuoqing@baidu.com>
 <20210921052821.91-3-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921052821.91-3-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Sep 2021 13:28:14 +0800, Cai Huoqing wrote:
> The NXP i.MX 8QuadXPlus SOC a new ADC IP, so add
> binding documentation for NXP IMX8QXP ADC.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
> v1->v2:
>         *Fix some indentation issues.
>         *Mark status as okay.
>         *Change clock2 source.
> v3->v4:
>         *Remove 'status' from examples.
>         *Remove unused 'state'.
>         *Remove interrupts-parent.
>         *Change num of address/size-cells from 1 to 2.
> v4->v5:
>         *Remove unused properties
> v1 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-5-caihuoqing@baidu.com/
> v3 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210907015724.1377-3-caihuoqing@baidu.com/
> v4 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210912071334.1745-3-caihuoqing@baidu.com/
> 
>  .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
