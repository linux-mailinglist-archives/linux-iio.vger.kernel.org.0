Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682704002EF
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349828AbhICQIG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 12:08:06 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34504 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbhICQIF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 12:08:05 -0400
Received: by mail-oi1-f175.google.com with SMTP id p2so7490795oif.1;
        Fri, 03 Sep 2021 09:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XobZX3a2+/izWbvDj1BcrfhYa4TqY+ivLKD/hRVfrBE=;
        b=GmUV1pc0gmiFCllxMwEnVpSYRawMYRlJRXd6hoMtg27zIJz2RK3GbhQlkKpoWd8Qgc
         8PxtV/Gxnwoi1IV7erx4qd42Ow5/i6sqNb8+Vx4+mWCpGcCPJ3Bhzy5JJ1cWcVAQXgTJ
         VEl8fd9xjQ32bhC/fkaSKCJZAmfFw9d+8rBcG//eGKA3Ton+iDhZSZIgvRig+6UstqSM
         Np/4oIloHIA8+dChUvsKQBKvP+IyuVUkBSoD5TvqgzP6bqhKMqX9cLnlCbRPrxdTNZS6
         jwiqOpFmQOKsjCqRZgYyxB+StJFl2TeVjVlTNFROc234bH64ptStMcs1T9DdpI1n2EwS
         g9/w==
X-Gm-Message-State: AOAM5327CB5i8781oNoK7DteTqMxMva6/bpKhSJ6FNeVeR3F1bmGfpKd
        cI8Rpr2UsjvxxyRpjihIGg==
X-Google-Smtp-Source: ABdhPJzel5rWJLH0rRFFB62nUGUFXnwA+rENRgqU65XyMhIAH04qgVoLhXrtpuJDVMiVRnmtXL3bXQ==
X-Received: by 2002:aca:5889:: with SMTP id m131mr3184277oib.39.1630685224179;
        Fri, 03 Sep 2021 09:07:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w1sm1031627ott.21.2021.09.03.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:07:02 -0700 (PDT)
Received: (nullmailer pid 3025187 invoked by uid 1000);
        Fri, 03 Sep 2021 16:07:01 -0000
Date:   Fri, 3 Sep 2021 11:07:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        bcousson@baylibre.com, Jason Reeder <jreeder@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 04/46] dt-bindings: iio: adc: ti,am3359-adc: New yaml
 description
Message-ID: <YTJIJSeqKyozRhxd@robh.at.kernel.org>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
 <20210902215144.507243-5-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902215144.507243-5-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 02 Sep 2021 23:51:02 +0200, Miquel Raynal wrote:
> This ADC was already described in a text file also containing an MFD
> description an a touchscreen description:
> Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> Let's add a proper description for this hardware.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  .../bindings/iio/adc/ti,am3359-adc.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
