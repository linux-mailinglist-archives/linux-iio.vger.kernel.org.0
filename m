Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43503402EB4
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbhIGTFz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Sep 2021 15:05:55 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:45621 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTFy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Sep 2021 15:05:54 -0400
Received: by mail-ot1-f51.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso322758otv.12;
        Tue, 07 Sep 2021 12:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HtB9CH8GC2u54lPJu+xSnel5zM09YC2wZis3Xc76gl8=;
        b=rvJeorgmbUJQ14neao7LJchXSQJRtWbc4CrgBsjiw4EDOyjI9dhRg/ZPoKQNEkORYZ
         i74vBLsFv3sQtssDRjMyRRkROulA8EEfmVzeIAkPKRYHXaqaV4zhZwqs9Zxoy6f7KyYx
         0RxfmzuoiO07VEgGlzo6RP7FbxyE5HBHhTP230Qa2gCzvyKymeHO5A+jIsHgs7mpjv+S
         1Zx9hmyNIkfBrIQCqs/M4jAZBc7AYQF5NTtoJPwv27Bf9dWBN/JF+aLLYW24ZyzX1ey7
         zQDiGYz/xQvTZIslJChVxVEzlmq3Ju7F4ZrgyLM/tT/82fFOOykWgq05hD3NFeInHsI1
         0AAA==
X-Gm-Message-State: AOAM530BZtcF24d4IBztKKZ8bo4yOA5UWB6NQNsDHvPbMUYIV+J2QDH8
        pgcNXZRS6GZudowrDCSvkQ==
X-Google-Smtp-Source: ABdhPJznkGHdyk/oYxe4e563Tjt9kYzNjzxuHpLrM4Fpl4oR+AlUNt+2JlBzh2x7EBvpPNo2qcIwKg==
X-Received: by 2002:a05:6830:4c1:: with SMTP id s1mr15781569otd.221.1631041487921;
        Tue, 07 Sep 2021 12:04:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o8sm2243301oiw.55.2021.09.07.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:04:47 -0700 (PDT)
Received: (nullmailer pid 166895 invoked by uid 1000);
        Tue, 07 Sep 2021 19:04:45 -0000
Date:   Tue, 7 Sep 2021 14:04:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        bcousson@baylibre.com, Vignesh Raghavendra <vigneshr@ti.com>,
        linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, linux-iio@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tero Kristo <kristo@kernel.org>, Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 06/46] dt-bindings: mfd: ti,am3359-tscadc: Describe
 am4372 MFD compatible
Message-ID: <YTe3zRufXhqs+iA2@robh.at.kernel.org>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
 <20210902215144.507243-7-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902215144.507243-7-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 02 Sep 2021 23:51:04 +0200, Miquel Raynal wrote:
> A more recent version of the am3359 ADC/Touchscreen controller is
> available on certain SoCs of the am437x family. This IP has evolved a
> little bit and deserves its own compatible.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
