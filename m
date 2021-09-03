Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536774002EA
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbhICQHe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 12:07:34 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33693 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349763AbhICQHd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 12:07:33 -0400
Received: by mail-oi1-f177.google.com with SMTP id n27so7515464oij.0;
        Fri, 03 Sep 2021 09:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIYTmjSKJ4m99IrwsrpuSXGl+Bc1vG4YgKTp8eB89Ls=;
        b=cE7mc9nuPjRxJCyAXlN5LUOfjDCbD7nvIyYwDHFAeWue0KrRKi2jP8qlFB2VqArH8c
         ekB8uiW+INjgsvT4n6d974fcNZUwdRn5w3PoWFLprj0oJGKCRXEdCMhibdZuEeUukV+J
         s3BwAmuhxVo1AET8aqyGw2GWt/VI52c/Qn2M/pdqJ04EAZbEfJvU9lIU1fc0v3QLzvlm
         mdJJe4KYeT9Qc19nNvJ4tU22JweovhEt55u/ULRnEXZSA4ViNOM1aNRhlWA4V5F2Zlrc
         DLwzkSJrEXNzr+IGSvmKgGpS8LuH+TAB3LXsNiTUXraX1qoJ6k/J/gOCdwzBP3rygPD2
         vdZw==
X-Gm-Message-State: AOAM531CoVEuiQxdOfv49PvdC4tDsvRzuPQ3+TnqCkVJmRlC6/s/PFnJ
        sTlRLuEjQnLHIvaJfHDYMA==
X-Google-Smtp-Source: ABdhPJxfeCgYu6tEaa2XT7Un6YhwVA3ACRbsP1GiVPvmovmHU0bhwYGdsyIJoFaiI0QGlA7qLz+aOQ==
X-Received: by 2002:aca:3b85:: with SMTP id i127mr6787901oia.28.1630685193190;
        Fri, 03 Sep 2021 09:06:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u40sm1078049oiw.51.2021.09.03.09.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:06:31 -0700 (PDT)
Received: (nullmailer pid 3024364 invoked by uid 1000);
        Fri, 03 Sep 2021 16:06:29 -0000
Date:   Fri, 3 Sep 2021 11:06:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-input@vger.kernel.org, Jason Reeder <jreeder@ti.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-iio@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>, bcousson@baylibre.com
Subject: Re: [PATCH v2 03/46] dt-bindings: touchscreen: ti,am3359-tsc: New
 yaml description
Message-ID: <YTJIBY93OQWM0VEW@robh.at.kernel.org>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
 <20210902215144.507243-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902215144.507243-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 02 Sep 2021 23:51:01 +0200, Miquel Raynal wrote:
> This touchscreen controller is already described in a text file:
> Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
> 
> After introducing a proper description of the MFD, this is the second
> step. The file cannot be removed yet as it also contains an ADC
> description.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../input/touchscreen/ti,am3359-tsc.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
