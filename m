Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080DC1974A9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 08:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgC3Gpj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 02:45:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgC3Gpj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 02:45:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so20197326wrn.2
        for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2020 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V56YQ8YQXjkIauhgboyrxCMrbncDw2TqLEBJO6LLNNM=;
        b=sQ2f+skFCCbEiOoww8kH9zZYLPWziNWtDYM/MzX1shre1CF6ETuE51sUbV60Mcbp3c
         7ofQGCgIpUXTV10fB8GyD0slTikuSNdlePQ7vG9wO47RRcTnybZAdKTqKbhPzCIZpk8v
         Hy6ije5XX9W48RP7H3ASmx4vFqgFf/gk/I4VS8cK396oDd/bs6+1e+/m+XdzXseQvP6g
         hkxkwAApQvHdND1yQ4DgfVVkdUao2XNw+v5HTUR2TLdHbCGM+4Cnc3wfMniX+0A13ev+
         CmNpK5tc1KR7tqVtcmTg0w7xWqBt2ETiw2Fgn8j2zb5UJh8aLCCVM5utDA2vJth35Hv5
         5YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V56YQ8YQXjkIauhgboyrxCMrbncDw2TqLEBJO6LLNNM=;
        b=bGh05k0m/NCwzsVmggahpNBXuukRPrXFEkvrCX8yj7lpHADlYIVWNZ0cyryk4mZ7WK
         4jVHjSdQLZdG9zC+1CMx9uWilT8P6YQ+a8XT8n0nmQyBoF0Llm2qeGI3xL/5k34jb5lg
         rTZNaDzRdtclHTH9FxqVgLPNfCAdotvle9SzMU2/sWe6BgFVu1NQsqOOJYzHEiHE2Oa9
         r0oZxWxmr5vEp9/UL53tM4YMiBfypgsewL8HtiLnOEhl6aDfUxSEK3JvzVBc3BCjEehl
         uwEFXQC0cKru6V96DpKcWRM17dH99poF6YpHEOCopqLvE1ctdiy9cvx5nKptG0ou1CHk
         RE4w==
X-Gm-Message-State: ANhLgQ2/XIQSIuJQk5KRZ4OKK+dJpt5rSKXak+/RnGuxDUGtH0oQnkt4
        eQRB8iOhNeGfPUEOW7GSeZ+Hnw==
X-Google-Smtp-Source: ADFU+vsGOjMWUR3XuueAXOf+kGUjz672AeJsnP+zNGCOJq+3zYTVOE2f/ajoKzhEq5O/LNUAMeRj0A==
X-Received: by 2002:a5d:4f92:: with SMTP id d18mr12996829wru.400.1585550737261;
        Sun, 29 Mar 2020 23:45:37 -0700 (PDT)
Received: from dell ([95.149.164.95])
        by smtp.gmail.com with ESMTPSA id c23sm21059704wrb.79.2020.03.29.23.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 23:45:36 -0700 (PDT)
Date:   Mon, 30 Mar 2020 07:46:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: mfd: add document bindings for mp2629
Message-ID: <20200330064630.GA30614@dell>
References: <20200322224626.13160-1-sravanhome@gmail.com>
 <20200322224626.13160-2-sravanhome@gmail.com>
 <20200327080013.GG603801@dell>
 <d449b567-bd5c-168d-83af-5ba38771f75a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d449b567-bd5c-168d-83af-5ba38771f75a@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020, saravanan sekar wrote:
> On 27/03/20 9:00 am, Lee Jones wrote:
> > On Sun, 22 Mar 2020, Saravanan Sekar wrote:
> > 
> > > Add device tree binding information for mp2629 mfd driver.
> > > 
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >   .../devicetree/bindings/mfd/mps,mp2629.yaml   | 60 +++++++++++++++++++
> > >   1 file changed, 60 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > new file mode 100644
> > > index 000000000000..314309ea91ac
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > > @@ -0,0 +1,60 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > Are these links supposed to work?
> Not really, but as far my understanding needed for dt-bindings check

Rob, why are these here if they just result in 404s?

> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +    #include <dt-bindings/input/linux-event-codes.h>
> > > +    i2c {
> > i2c@0x????????
> 
> Its a I2C controller node, I don't think address is needed. Mention like
> this my previous other driver patches,

This doesn't sound right.

How do you control/operate the controller?

Surely you read/write from/to registers?

> dt_binding_check is also passed
> 
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        pmic@4b {
> > > +            compatible = "mps,mp2629";
> > > +            reg = <0x4b>;
> > > +
> > > +            interrupt-controller;
> > > +            interrupt-parent = <&gpio2>;
> > > +            #interrupt-cells = <2>;
> > > +            interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> > > +        };
> > > +    };

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
