Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26C402EB6
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbhIGTG3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Sep 2021 15:06:29 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:45696 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTG3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Sep 2021 15:06:29 -0400
Received: by mail-oo1-f45.google.com with SMTP id m14-20020a4ad50e000000b002912a944a47so83313oos.12;
        Tue, 07 Sep 2021 12:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xG8XtyNOMTr7L9vWlv1RtoU+mRp0MG0nj8OT2PfaaKc=;
        b=C34wVMJ5tMM0b2DGnZBo+YVSKG/fDsJcj7n8OvhDYwdg85BEWFwEcU//vpk0SlMDjY
         V0ASZ46lHbYDQwPpc3inqqCRBodrG9/lxuyaDunYD37ca2RMvsJ//46Bam7cyOKTL/xz
         Mm2QUhkn85ZACFGCHW9OnJMJ7LhC0rt+gd0vKI6NvvIXvBDjgI/4QNw46g4praRfqLvd
         4fn6xju8agGv9mLZKKYkJEaLJe9iqyvhzcKaz418yM8tWHtSOY56DWmlm0iqk3U88Mj6
         qS/9ZhqbTXC7qCy9POqnYVdqpaR0x3Bd2bMcjOI+NBcZ6LS/0p56Y5Rz/bvNAAakjQIl
         YTWw==
X-Gm-Message-State: AOAM531jg/H4KgIUtxeh+xBupBpIbt1yn0AdYve2/95pDCrn+6iIWxlC
        4aYl5Ggpj8yv4p7u2O4QNw==
X-Google-Smtp-Source: ABdhPJwvKHJB56QW0OLh0B8b9pk8wolbsjN+Be2o3jJnyFZbM/oWiz/ufQhm/BNt1/K79q4MgwqJXQ==
X-Received: by 2002:a4a:5742:: with SMTP id u63mr1145298ooa.87.1631041522404;
        Tue, 07 Sep 2021 12:05:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x22sm2391802oox.26.2021.09.07.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:05:21 -0700 (PDT)
Received: (nullmailer pid 168046 invoked by uid 1000);
        Tue, 07 Sep 2021 19:05:20 -0000
Date:   Tue, 7 Sep 2021 14:05:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        linux-input@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, Jason Reeder <jreeder@ti.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-omap@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 07/46] dt-bindings: iio: adc: ti,am3359-adc: Describe
 am4372 ADC compatible
Message-ID: <YTe38HWmbICuwGjf@robh.at.kernel.org>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
 <20210902215144.507243-8-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902215144.507243-8-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 02 Sep 2021 23:51:05 +0200, Miquel Raynal wrote:
> A more recent version of the am3359 ADC is available on certain SoCs of
> the am437x family. This IP has evolved a little bit and deserves its own
> compatible.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
