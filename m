Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584AA372051
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhECTWn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 15:22:43 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43875 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECTWn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 15:22:43 -0400
Received: by mail-ot1-f52.google.com with SMTP id g7-20020a9d5f870000b02902a5831ad705so6085446oti.10;
        Mon, 03 May 2021 12:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TlXLprW/UaAcDykke6O1kT0eI+7fbmpiZAI11hk4NlU=;
        b=Hg1IvVHMpAQYQYiQ0RlE41Ds1soy7GpTUwEYpIkG6VZlV1LTMkeJ+d/sE8vGLQ7tgU
         LdfQdmmRhaUTSWh0W+GaXOletKqWx3Lp1lseKyUek0/n77t0HItVqtpqM3LZMsuPU7Gn
         6rkOTeyhfsoJkQ7JyTBR6PRf/pToZSFaC7FPV6aZZHroq2gZBgWN2ZtAktwyUHg4lF09
         oSa/KqqaLyEOPYwlHs82q2ULfk8Snwy+T1D+UcJ0YNDhsBSC09dUWD0UuzN3t8mbi0oz
         HRADK0SmRjV4RhXpuANxMxHXHK6IPQsoFF6vptTxljyTXuRPEG+43IM3gTE8UJlJloJ0
         kncg==
X-Gm-Message-State: AOAM532U5zsjHzzjNcUYtOIIxbBmiSdl2lfaHfpJNDt94KRqE4778X9+
        /BE5TAVuyKJqxuSQ/dVQww==
X-Google-Smtp-Source: ABdhPJyoRxlJG9apV1LN2webxLjtJSe+i8SveqVtXmvusy140bwM9WuR6WuUc+tqaCG9PBEFqMhFfQ==
X-Received: by 2002:a9d:6b15:: with SMTP id g21mr15991518otp.327.1620069709777;
        Mon, 03 May 2021 12:21:49 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v125sm168200oie.22.2021.05.03.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:21:49 -0700 (PDT)
Received: (nullmailer pid 2231141 invoked by uid 1000);
        Mon, 03 May 2021 19:21:48 -0000
Date:   Mon, 3 May 2021 14:21:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] dt-bindings: iio: accel: fxls8962af: add
 interrupt options
Message-ID: <20210503192148.GA2229526@robh.at.kernel.org>
References: <20210428082203.3587022-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428082203.3587022-1-sean@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 28, 2021 at 10:22:00AM +0200, Sean Nyekjaer wrote:
> This in done for supporting hw buffered sampling
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> This series depends on "iio: accel: add support for
> FXLS8962AF/FXLS8964AF accelerometers"
> 
>  .../bindings/iio/accel/nxp,fxls8962af.yaml           | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> index c7be7a1679ab..e0e5542377df 100644
> --- a/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/nxp,fxls8962af.yaml
> @@ -32,6 +32,16 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  interrupt-names:
> +    maxItems: 1
> +    items:
> +      enum:
> +        - INT1
> +        - INT2

You can simplify this to:

interrupt-names:
  enum:
    - INT1
    - INT2


> +
> +  drive-open-drain:
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> @@ -51,6 +61,7 @@ examples:
>              reg = <0x62>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
>          };
>      };
>    - |
> @@ -66,5 +77,6 @@ examples:
>              spi-max-frequency = <4000000>;
>              interrupt-parent = <&gpio0>;
>              interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "INT1";
>          };
>      };
> -- 
> 2.31.0
> 
