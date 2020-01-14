Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D64139E0E
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANAYU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 19:24:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45827 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgANAYU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 19:24:20 -0500
Received: by mail-oi1-f196.google.com with SMTP id n16so10142388oie.12
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 16:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fTr7T7GJceLoLFzB5OjtrxDOobOt56IiyvMJHYGzl0w=;
        b=mDJ6XkIDm2X5gg6Fiej28pqto84KSRVlameog+Sl3u8ijZ+CZAshjVuQoO4XtuGfPV
         BItwl28Yj29k2KJuYONyXBO8MQff77aP34PmOIfRBmlvESjlTrP7HI2AOedoDEmYXWCt
         FKNgv8o9+aQ0qUiPqfuob05jvpyiL9jMaCzG5a67sI4xEWzp2spO1yq85Q8l32nM1qHf
         LFH5RBwLBEaAQpbJNYy0ZCAmqqG76sjHfQ2oY8j2dD4LaCIfbcUra3ZO2S6oR4wP2DuD
         Vsqo1JDNxX98vnjJfc4PlYx/dUwCB5WyX5THawB6tA76EStb0XtS9I3M6T1McXioeVfb
         x2cw==
X-Gm-Message-State: APjAAAUvZJiMP68X86X2QUQ6TGOv+hytHGN8ZQq4Ff/Rjn4QvXP+aj/v
        xg7Quz4N3Q4vEtnNZSG2K7qTlpKu7g==
X-Google-Smtp-Source: APXvYqwLvFFlvk5J98MbNz6JPGoRoGQ24pKUDvExxR6+XzzwgqJs61yI/gnFjspkkhjhUjaaoVZ7DQ==
X-Received: by 2002:aca:4a08:: with SMTP id x8mr15074590oia.39.1578961459037;
        Mon, 13 Jan 2020 16:24:19 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s26sm4749666otk.43.2020.01.13.16.24.16
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:24:17 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 223ddc
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:24:15 -0600
Date:   Mon, 13 Jan 2020 18:24:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, lee.jones@linaro.org,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, wg@grandegger.com,
        mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 13/17] dt-bindings: atmel-usart: remove wildcard
Message-ID: <20200114002415.GA18336@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-14-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-14-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 10, 2020 at 06:18:05PM +0200, Claudiu Beznea wrote:
> Remove chip whildcard and introduce the list of compatibles instead.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-usart.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> index 699fd3c9ace8..09013c49f6cc 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
> @@ -1,10 +1,11 @@
>  * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
>  
>  Required properties for USART:
> -- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
> -  The compatible <chip> indicated will be the first SoC to support an
> -  additional mode or an USART new feature.
> -  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
> +- compatible: Should be one of the following:
> +	- "atmel,at91rm9200-usart"
> +	- "atmel,at91sam9260-usart"
> +	- "atmel,at91rm9200-dbgu"
> +	- "atmel,at91sam9260-dbgu"

Should be:

"atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
"atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"

>  - reg: Should contain registers location and length
>  - interrupts: Should contain interrupt
>  - clock-names: tuple listing input clock names.
> -- 
> 2.7.4
> 
