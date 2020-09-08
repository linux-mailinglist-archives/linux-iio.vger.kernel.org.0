Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF25262107
	for <lists+linux-iio@lfdr.de>; Tue,  8 Sep 2020 22:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIHUYa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Sep 2020 16:24:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34923 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgIHUY2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2020 16:24:28 -0400
Received: by mail-io1-f65.google.com with SMTP id r9so785881ioa.2;
        Tue, 08 Sep 2020 13:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=imI2XMeiATPhwUEpyY9e3b3s2gjee5q70bwpnwzYJnI=;
        b=EMeoBohZHqc/GEf3csaoa1/FjSblc3ZTYX5b9vZT8sPBnfYcFZMnEzZFLc1Iz0SGjM
         xMU0oCBwRD3ayzE0ltT3QSPYGPOoe5UrZTksoe9Rq14ytVUzFDGMtCYfBPPF5Bp4K8Fr
         nhL4QLxmk+Xpd3g5VxS0txyMcpYnaoFkiIoa0H6ecQT6wFVhtmNHW748nmLktD8Bq3sD
         MfcvpHRbrehWmVOax8vYsK8UmbrBhZxEuW2RmcGll0zfjO+2I+mDSMCAsK1IIpFCbuMI
         D8rLVP5fNh4fprYhzKpT2MbuTZjMzr8jgPt/e+JE3evcrnliUkni+lTvXcWf5A3xcXgK
         wIYw==
X-Gm-Message-State: AOAM5336r0/c0VQkMre/7LcKmSGGn5L50NR9fAKSLjupBhQ9w835RlU8
        NOXtpya2UVG8KibkE3V5AA==
X-Google-Smtp-Source: ABdhPJz7p84dShi+SgdcBrBu6OR0/T4zQCh0uY1sDBRkowINwB9yeb+eOXb9wqT+XYZP6EvbQeZu/Q==
X-Received: by 2002:a05:6602:2a43:: with SMTP id k3mr543095iov.83.1599596667513;
        Tue, 08 Sep 2020 13:24:27 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c12sm146535ilm.17.2020.09.08.13.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:24:27 -0700 (PDT)
Received: (nullmailer pid 848429 invoked by uid 1000);
        Tue, 08 Sep 2020 20:24:25 -0000
Date:   Tue, 8 Sep 2020 14:24:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-samsung-soc@vger.kernel.org, linux-iio@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>
Subject: Re: [PATCH 02/25] dt-bindings: iio: adc: exynos-adc: require second
 interrupt with touch screen
Message-ID: <20200908202425.GA846754@bogus>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-3-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 07 Sep 2020 18:11:18 +0200, Krzysztof Kozlowski wrote:
> The ADC in S3C/S5P/Exynos SoCs can be used also for handling touch
> screen.  In such case the second interrupt is required.  This second
> interrupt can be anyway provided, even without touch screens.  This
> fixes dtbs_check warnings like:
> 
>   arch/arm/boot/dts/s5pv210-aquila.dt.yaml: adc@e1700000: interrupts: [[23], [24]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/iio/adc/samsung,exynos-adc.yaml      | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: adc@12d10000: interrupts: [[0, 106, 0]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.example.dt.yaml: adc@126c0000: interrupts: [[0, 137, 0]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml


See https://patchwork.ozlabs.org/patch/1359054

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

