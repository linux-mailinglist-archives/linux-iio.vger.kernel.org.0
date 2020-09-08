Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589AD260B39
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 08:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgIHGs3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 02:48:29 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44654 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgIHGsR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 02:48:17 -0400
Received: by mail-ej1-f65.google.com with SMTP id r7so7546601ejs.11;
        Mon, 07 Sep 2020 23:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VyiVf+Mq59UC5ZzKMYrAjFhEEKe4orUQbv2Dw6ICisQ=;
        b=Qt2OvcNIVdt78UW4jLDz6nktC9mUQL/abkGCyd41iCFp1dO1iDhVQgQ9KQRsFJIqP/
         +cAXGjR8GXm/R8n8bNtHgtid78nlHpKhGzuVnXWukF1nyeyh+YVqzUegEZsPibxnna8y
         xW4SDv7DnqzXfBVK1RDpg19qGRllqHBskRWEmUsYZNbsFmSLjRqDtNw2IyDhbFw/6vGT
         roUdrWvMHfSgUc4Jv9/LEie8dJt8SPHrDQJ8bo6ZszAysLFS0cL/2qPDDv7BQRHCKSRc
         p8U0APQR6BqN0cqC1jphrNDbPejCgFwzVXKk29H97WHEJSEQ0jm9xFwT9ANcaKCMnBtT
         OCpg==
X-Gm-Message-State: AOAM531vjY+lOC8/Xan29LgR+bvW9Qr6t7j52kfPWy/zg9i5PKIygj1X
        Qg8hInokSXw5h9zxQWLtLDA=
X-Google-Smtp-Source: ABdhPJy61y/aCX2qNyKljrz5UJOWH8ADbK1AwDDzicWB2lQYIWTkbWIYURrKncOKjTAbVcUMp5Tlaw==
X-Received: by 2002:a17:906:455:: with SMTP id e21mr25591439eja.170.1599547694870;
        Mon, 07 Sep 2020 23:48:14 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id j8sm16697525edp.58.2020.09.07.23.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 23:48:13 -0700 (PDT)
Date:   Tue, 8 Sep 2020 08:48:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/25] dt-bindings: iio: adc: exynos-adc: do not require
 syscon on S5Pv210
Message-ID: <20200908064811.GA24227@pi3>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-4-krzk@kernel.org>
 <BN6PR04MB06601B8D0B7F1E51953024E6CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06601B8D0B7F1E51953024E6CB280@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 02:49:49PM -0700, Jonathan Bakker wrote:
> Looking at this again, it appears that there is actually control for
> it at offset 0x6818 of pmu_syscon (0xe0108000) [1].  However, it defaults to
> enabled so it's not required for proper use of the block.  Whether it should
> be present in the schema/DTS is up to you.

Indeed the driver could turn off the ADC phy via syscon however bindings
(before YAML conversion) explicitly were saying that it is not needed. I
am not going to add it as I am not able to test the change and also
adding such requirement would be a break of ABI (described by first TXT
bindings).

Best regards,
Krzysztof


> 
> Thanks,
> Jonathan
> 
> [1] https://android.googlesource.com/kernel/samsung/+/refs/heads/android-samsung-3.0-jb-mr0/arch/arm/mach-s5pv210/include/mach/regs-clock.h#325
> 
> On 2020-09-07 9:11 a.m., Krzysztof Kozlowski wrote:
> > The ADC in S5Pv210 does not have ADC phy registers in separate block for
> > which syscon would be needed.  Remove this requirement to fix dtbs_check
> > warnings like:
> > 
> >   arch/arm/boot/dts/s5pv210-fascinate4g.dt.yaml: adc@e1700000: 'samsung,syscon-phandle' is a required property
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../devicetree/bindings/iio/adc/samsung,exynos-adc.yaml          | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> > index 89b4f9c252a6..75174af72288 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
> > @@ -81,7 +81,6 @@ allOf:
> >                - samsung,exynos-adc-v2
> >                - samsung,exynos3250-adc
> >                - samsung,exynos4212-adc
> > -              - samsung,s5pv210-adc
> >      then:
> >        required:
> >          - samsung,syscon-phandle
> > 
