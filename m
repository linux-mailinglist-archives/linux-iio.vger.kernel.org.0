Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061FE2C7556
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgK1VtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgK1S0y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 13:26:54 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784EC094263
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 10:26:14 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l206so9526922oif.12
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 10:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8RiqeUI7pxEdcbpvxfJ+9GMvAAwvki840nbCV6Q60IU=;
        b=GvjnN70kbYequ6BfcsRpypGeWaz7M4mB5QZPIeglAYUDWgjYru8CEuIHzyZIMCjLTY
         giLlIEbmGAiGvREIxH/T7ywVpFWuVDo+x011+rt59YPS3k1TmGRgE8UH2UJXgEa17r8K
         1B9f4d1IaLl9dlOtiPpUOhXFo7949yfYwUJ/1l5A3rBruzpKq1ycZHCdfEw1rx5T5C2V
         b6BsFjLMQ9/O+mhvdvxkYSkCU5lZyKJSJk2J4+ZQRpIChm1Z2FT2s2bhjFYmTwexWKlf
         bDnUvNrdgFp+AvBRPn/xgSayNjlRcpKbZ9lpg3LwNhgqKHJhK2U00l1wCzYBAiBOD7y3
         Xu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RiqeUI7pxEdcbpvxfJ+9GMvAAwvki840nbCV6Q60IU=;
        b=QYwgbF/7UlWDY+tl+spHcB5DBnME8poISYONyAG6ljL9e63Khz3M15PsJK3qFAKLya
         rRTxJF+6xwtr6558FLd+f6ciwinFadF3scCPWFVWI5IMkOVffYCTPqmvy8jyMM6HjunQ
         8x0VCWEIqThhE91XeAr1IAT4FBivWRjez4eoU2QrJs6FVBNFVfY/g7gvTlDz7sHf6BCd
         /ZI84ABqMvsU74piJGmLkBGaEJgv84iBlNBqL5ihV15rWvasx73xuC7+FyU3rnJZPcRf
         CsTHBimKqKlOW0Fm5vMEMt76lyy122dJg1dhoPonkQJN5CEFTOxx1FPLXNyYRSzmGFGm
         LHWg==
X-Gm-Message-State: AOAM531FgV5iv03/Rper+EqvliCRbJ7UdQgiVst1wV0g9CL1xEP5jHMS
        0rRv3FYqEV8z/pn6H/SwQwyjrQ==
X-Google-Smtp-Source: ABdhPJxA5zsDHDJY99I5CzvTe4pikaKPHc9b9aQ8/DcRdy5mdSZJb5QNXLp5Vm7qvIKoHo+4x7kS7g==
X-Received: by 2002:aca:1916:: with SMTP id l22mr9717479oii.79.1606587973685;
        Sat, 28 Nov 2020 10:26:13 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m81sm7411469oib.37.2020.11.28.10.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 10:26:12 -0800 (PST)
Date:   Sat, 28 Nov 2020 12:26:10 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Jishnu Prakash <jprakash@codeaurora.org>
Subject: Re: [PATCH 1/9] dt-bindings:iio:qcom-spmi-vadc drop incorrect
 io-channel-ranges from example
Message-ID: <X8KWQrfyRXENTxM7@builder.lan>
References: <20201115192951.1073632-1-jic23@kernel.org>
 <20201115192951.1073632-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115192951.1073632-2-jic23@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun 15 Nov 13:29 CST 2020, Jonathan Cameron wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> io-channel-ranges is a property for io-channel consumers. Here
> it is in an example of a provider of channels so doesn't do anything
> useful.
> 
> Recent additions to dt-schema check this property is only provided
> alongside io-channels which is not true here and hence an error is
> reported.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reported-by: Rob Herring <robh@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Jishnu Prakash <jprakash@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> index 7f4f827c57a7..95cc705b961b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
> @@ -48,8 +48,6 @@ properties:
>      description:
>        End of conversion interrupt.
>  
> -  io-channel-ranges: true
> -
>  required:
>    - compatible
>    - reg
> @@ -249,7 +247,6 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>          #io-channel-cells = <1>;
> -        io-channel-ranges;
>  
>          /* Channel node */
>          adc-chan@39 {
> -- 
> 2.28.0
> 
