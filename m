Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2083290A61
	for <lists+linux-iio@lfdr.de>; Fri, 16 Oct 2020 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgJPRQP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Oct 2020 13:16:15 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34894 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgJPRQP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2020 13:16:15 -0400
Received: by mail-ot1-f65.google.com with SMTP id f22so481082ots.2;
        Fri, 16 Oct 2020 10:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZmPWxKpDTknAmEe7UdqFdRj8Owf4EcjFeMtD8aGa6yA=;
        b=aFQ1pb6TWRwo41XultgA2RQo9jXf8HphiX2utd1RfFHKeXeehO6pJzZOeaiPKt+ifR
         yy8Z3mi3SXfOX33Hb2pGlZ3gvWLSPC1iypJFK8omK0LlWCzza2b9dJjgdE5qX55DBuXs
         1QINw5GIy5Sogz2AMBY3OiAHF1I71R560c59aW+W34GBBMJzY4VUjQ63Qv/KXH0IO9mq
         u5nrB6HKvrncJnuydtHsyKrwn2grlyFytfqW9Ce5BK3Peis2VOoZqKkHD5VLkXZDVaUo
         fsypCHnsRii3xdLX0oJ2XxnVJhw97eaFJckCteIsXnEyK6B2IqGsq48ybFnqvt9EW4hE
         XQLQ==
X-Gm-Message-State: AOAM530jHjnxlQXV1FfYxEdeU+BDrUN5jLkkuyKAaa1YFrsLwNB0iuVM
        VMyRnS8huymvLLrpYh9HOPT4Zt1Ygg==
X-Google-Smtp-Source: ABdhPJwNFTc03Dpq8hQaQDs+x9At0y/IfS8Tw88Q4LOwNP/y70SOX0/J9aHLsKBqBo0dt8/jeyr6pw==
X-Received: by 2002:a05:6830:13c5:: with SMTP id e5mr3209070otq.319.1602868574593;
        Fri, 16 Oct 2020 10:16:14 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p11sm1158258otp.8.2020.10.16.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:16:13 -0700 (PDT)
Received: (nullmailer pid 1595441 invoked by uid 1000);
        Fri, 16 Oct 2020 17:16:12 -0000
Date:   Fri, 16 Oct 2020 12:16:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, joel@jms.id.au, andrew@aj.id.au,
        p.zabel@pengutronix.de, alexandru.ardelean@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH 3/3] iio: adc: aspeed: Setting ref_voltage in probe
Message-ID: <20201016171612.GA1593560@bogus>
References: <20201013103245.16723-1-billy_tsai@aspeedtech.com>
 <20201013103245.16723-4-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013103245.16723-4-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 13, 2020 at 06:32:45PM +0800, Billy Tsai wrote:
> At ast2600 ref_voltage becomes configurable and this property is board
> dependency.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/iio/adc/aspeed_adc.txt   | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> index 034fc2ba100e..0ba1980c4e06 100644
> --- a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> @@ -3,8 +3,11 @@ Aspeed ADC
>  This device is a 10-bit converter for 16 voltage channels.  All inputs are
>  single ended.
>  
> +At ast2600, this device split into two individual IPs and each contains 8 voltage channels.
> +
> +Chip level dtsi:
>  Required properties:
> -- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
> +- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc" or "aspeed,ast2600-adc"
>  - reg: memory window mapping address and length
>  - clocks: Input clock used to derive the sample clock. Expected to be the
>            SoC's APB clock.
> @@ -20,3 +23,14 @@ Example:
>  		resets = <&syscon ASPEED_RESET_ADC>;
>  		#io-channel-cells = <1>;
>  	};
> +
> +Board level dts:

This split is convention, but not relevant to the binding.

> +Required properties:
> +- ref_voltage: (ast2600 only)

s/_/-/

And needs a vendor prefix.

> +	- Reference voltage in millivolts for the conversions.
> +	- The range of value is 900 to 2700 mv.
> +
> +Example:
> +&adc0 {
> +	ref_voltage = <2500>;
> +};
> \ No newline at end of file

Fix this.

> -- 
> 2.17.1
> 
