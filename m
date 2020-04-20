Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F781B02BD
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 09:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTHTO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726020AbgDTHTO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 03:19:14 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E43C061A41
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 00:19:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so10033916wma.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Apr 2020 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+a5D/Go3l6kNSMlbJDlUz7E/smrjsN8BEZkxCZCPYyw=;
        b=j2WkOi/BwuKO0264ycM/t1QGPReas21DiXLzX+1O2wHO69r4NkdP/a+D9TWB7XTU/S
         h7Ht8uQGNR5z3nBRGDVpcE9JyM6yAL2hh47Xme4rAAuZJ1X4AMknYJNzvgemYgKTK/SQ
         HDfySjW67EuCUellMv/FB8SxZrNhWqkFZIDlMwsbnN3H45p7+d/xDI22zqaS4wtdS1fH
         cJsfpC6DEGo8I4nydqC6GKJyR/bzH3JoygU3N2GBwQU4VJetVikJaRlp2+lxOtNZTzw8
         8oYM7q0Wttet5w6aDSEO8FcsPFM/A6FTcQjynbFfD31acw8WbBgOCR4yGGLiNjo56rbR
         PCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+a5D/Go3l6kNSMlbJDlUz7E/smrjsN8BEZkxCZCPYyw=;
        b=DB4bdPCFQPZJAOWa528EwDRmXp44+H1H/5VSjfBoBCAbm4vVUfqU2KZG6i+n5Ervwk
         RDyROxNPGVhwbhiHzIcCZNAo2d2Dbnd5DeaWU0xsa+BzMGUGANIcC+v97gHeL8FFEcg5
         mU9wp3uvGd2Zbln8cPlupjTgKCEDsmDnih6IIHILVGjiR8mtLjt6HznGKMwXJP/1EEL6
         w0JilIO4uI95AiX/qpSW0ixmAjcdlpOJeVDZk4vjlF1Jh3NggQbu5hOk8suxA4KxFCq4
         XrZFAabPKbgNANwam3mIuUkMo76wRInQjoUpNNsmREYNmXwF3OZbFNBFiezG9CTxonWl
         IxDw==
X-Gm-Message-State: AGi0PuYPgcC1FRsKFXe0UAj3W/VMkkARKLCVtFwgrupORhPvHpWJbqi2
        lw9cA8UviIDW/oZm/ZcFnyrugw==
X-Google-Smtp-Source: APiQypLv4LVvAOzvDjOb58HRVezAofHOjRpLzd4Mor7CopqOj5iXyJlmolJo63jJoVcdcrCO+1fbkQ==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr17368816wmh.59.1587367152449;
        Mon, 20 Apr 2020 00:19:12 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id k133sm196661wma.0.2020.04.20.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:19:11 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:19:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     saravanan sekar <sravanhome@gmail.com>, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 1/6] dt-bindings: mfd: add document bindings for
 mp2629
Message-ID: <20200420071910.GH3737@dell>
References: <20200417085003.6124-1-sravanhome@gmail.com>
 <20200417085003.6124-2-sravanhome@gmail.com>
 <20200418155308.681df38f@archlinux>
 <50ffb42e-4080-415e-dd3d-e38f7b0a6071@gmail.com>
 <20200418170619.155222fa@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200418170619.155222fa@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Apr 2020, Jonathan Cameron wrote:

> On Sat, 18 Apr 2020 17:01:17 +0200
> saravanan sekar <sravanhome@gmail.com> wrote:
> 
> > Hi Jonathan,
> > 
> > On 18/04/20 4:53 pm, Jonathan Cameron wrote:
> > > On Fri, 17 Apr 2020 10:49:58 +0200
> > > Saravanan Sekar <sravanhome@gmail.com> wrote:
> > >  
> > >> Add device tree binding information for mp2629 mfd driver.
> > >>
> > >> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > >> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >> ---
> > >>   .../devicetree/bindings/mfd/mps,mp2629.yaml   | 61 +++++++++++++++++++
> > >>   1 file changed, 61 insertions(+)
> > >>   create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > >> new file mode 100644
> > >> index 000000000000..b25b29259d67
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> > >> @@ -0,0 +1,61 @@
> > >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > >> +%YAML 1.2
> > >> +---
> > >> +$id: http://devicetree.org/schemas/mfd/mps,mp2629.yaml#
> > >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >> +
> > >> +title: MP2629 Battery Charger PMIC from Monolithic Power System.
> > >> +
> > >> +maintainers:
> > >> +  - Saravanan Sekar <sravanhome@gmail.com>
> > >> +
> > >> +description: |
> > >> +  MP2629 is a PMIC providing battery charging and power supply for smartphones,
> > >> +  wireless camera and portable devices. Chip is controlled over I2C.
> > >> +
> > >> +  The battery charge management device handles battery charger controller and
> > >> +  ADC IIO device for battery, system voltage
> > >> +
> > >> +properties:
> > >> +  compatible:
> > >> +    const: mps,mp2629
> > >> +
> > >> +  reg:
> > >> +    maxItems: 1
> > >> +
> > >> +  interrupts:
> > >> +    maxItems: 1
> > >> +
> > >> +  interrupt-controller: true
> > >> +
> > >> +  "#interrupt-cells":
> > >> +    const: 2
> > >> +    description:
> > >> +      The first cell is the IRQ number, the second cell is the trigger type.
> > >> +
> > >> +required:
> > >> +  - compatible
> > >> +  - reg
> > >> +  - interrupts
> > >> +  - interrupt-controller
> > >> +  - "#interrupt-cells"
> > >> +
> > >> +examples:
> > >> +  - |
> > >> +    #include <dt-bindings/interrupt-controller/irq.h>
> > >> +    #include <dt-bindings/input/linux-event-codes.h>
> > >> +    i2c@7e205000 {  
> > > I thought the general trend for i2c devices was to leave the i2c
> > > part 'vague'.
> > >
> > >      i2c {
> > >            #address-cells = <1>;
> > >            #size-cells = <0>;
> > >           
> > >            pmic@4b.. etc  
> > I agree with you and initial patch was as like above, but Lee was 
> > somehow unhappy and not satisfied with
> > 
> > my explanations. Please find more info on v4.
> 
> Ah. Curious.  Oh well - over to Rob for a definitive answer!

I haven't seen this spoken about before.  The comments were based
solely on my own views of, the example should provide a solid, valid,
potentially working block for people to use as a reference.

Would an I2C node missing an address be a valid DTS/DTSI entry?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
