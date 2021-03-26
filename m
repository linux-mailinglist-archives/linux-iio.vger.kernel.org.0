Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F834B12F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Mar 2021 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCZVTf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 26 Mar 2021 17:19:35 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:46880 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZVTM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Mar 2021 17:19:12 -0400
Received: by mail-il1-f174.google.com with SMTP id j11so6128655ilu.13;
        Fri, 26 Mar 2021 14:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bRKC7X28obsRcnB5q96IoDTtBZOoyADsH3nuaftswgE=;
        b=aTfkLzadFx7rDYVIEo51mZFhufMzWwNf2afrhMCf7DKZO6yjhKYXQ5p2lsZQ90Nouz
         eySYjUn+ETAuAiF2p3vaUHxYqkw9aW5HQXkaaxoYfia6EjWkFI5jNe13ZCyQFx4S4MbE
         7ZHbwIPWMglxsig25MowCB1d7TDQM2sQSwRiGzf/8wAU8QkPPVGnwxpG6A5InCy2qUj9
         su5AIuvPqFNmu2TxcSdGzAQtAYlPXppenCdCXpgjZXDSYFy2ffOJMSzUIreb0MQ9GxWF
         pHzfoz//HYhCqKGfncWTkt0xdC/kRJFzmlQp2RVJHbTypcMOJ6ubYZg24/Zo3W8k29Mg
         7FIA==
X-Gm-Message-State: AOAM531xWoqaLTBGe710GQzdyx0W+DCE9zAZJU0vAf2qwHv3zAj3eNPx
        QVk641vU5FI4573Ob3p8ig==
X-Google-Smtp-Source: ABdhPJwF3tp/c/elQTaeQOJH/MpJJr3ohlgGKrhwDlBOjO4QijZTDQtBgq7OAN2ZOS2FqWh8li9FwQ==
X-Received: by 2002:a92:c549:: with SMTP id a9mr12221004ilj.300.1616793551531;
        Fri, 26 Mar 2021 14:19:11 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w1sm4860831iom.53.2021.03.26.14.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 14:19:10 -0700 (PDT)
Received: (nullmailer pid 3878058 invoked by uid 1000);
        Fri, 26 Mar 2021 21:19:08 -0000
Date:   Fri, 26 Mar 2021 15:19:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings:iio:adc: add generic settling-time-us
 and oversampling-ratio channel properties
Message-ID: <20210326211908.GA3876801@robh.at.kernel.org>
References: <20210322150608.14347-1-o.rempel@pengutronix.de>
 <20210322150608.14347-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322150608.14347-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 04:06:06PM +0100, Oleksij Rempel wrote:
> Settling time and over sampling is a typical challenge for different IIO ADC
> devices. So, introduce channel specific settling-time-us and oversampling-ratio
> properties to cover this use case.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 912a7635edc4..66fd4b45f097 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -39,4 +39,13 @@ properties:
>        The first value specifies the positive input pin, the second
>        specifies the negative input pin.
>  
> +  settling-time-us:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type for properties with a standard unit suffix.

> +    description:
> +      Time between enabling the channel and firs stable readings.
> +
> +  oversampling-ratio:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Number of data samples which are averaged for each read.
> +
>  additionalProperties: true
> -- 
> 2.29.2
> 
