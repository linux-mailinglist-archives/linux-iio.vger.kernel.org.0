Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26742139DCD
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 01:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgANAKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 19:10:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40880 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgANAKH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 19:10:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id w21so10818304otj.7
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 16:10:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T2alnzvz8KAPkt6TNZdOKsvg51Cv8nSh38BXX535N54=;
        b=r3314dvFOoJcO+ExkxlskYr6KGSkkBWPDUdiMdol4o32oxQErJNPASFx5QpIweCZGj
         hMtYl0th+nLXqgN9/5VDhjvVGdaQyJpDoxHJUFXe+UZrn6s1Ibba26kiWfaAQ1tyWu/o
         dEfhU3cq+0dmtOPUYB9oOOl/7sGnadkSO5swgWPh9A+V2y8LaRzzoaltuGeky3ncPSLt
         DXC4bcBwNuMBh0FQTFQqgohDHSxnJtPa5jRphgm1yxIFCPmZO9FRnrJrxOYiP9hBJj9m
         P+RPu91aLU0Nv8bDBBQ+Q89eH/HxQ5y4j4qCLdYei5Ijtdba6S3UEJMEZOiv3+xDVX1a
         Vsgg==
X-Gm-Message-State: APjAAAUyoytI5asPxamyRJmu2xnLhlgLGvNEkoC8A1ZhJaNWQkxAaMHz
        FCiPAZuxZedZjv2Pfl1wNGVVH0fFDg==
X-Google-Smtp-Source: APXvYqy3AEyJprqyEoVXvwHVqqKLpDs/rZMI9VMhonqkBmP9WjeAIAZf1n8ReLk1uJCP6e/M+lhC9w==
X-Received: by 2002:a05:6830:108a:: with SMTP id y10mr15021266oto.81.1578960606046;
        Mon, 13 Jan 2020 16:10:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j8sm720421oii.32.2020.01.13.16.10.05
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:10:05 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221ac9
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:25:02 -0600
Date:   Mon, 13 Jan 2020 17:25:02 -0600
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
Subject: Re: [PATCH v2 04/17] dt-bindings: atmel-tcb: add
 microchip,sam9x60-tcb
Message-ID: <20200113232502.GA31265@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 10, 2020 at 06:17:56PM +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-tcb to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-tcb.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> index c4a83e364cb6..cf0edf5381c9 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
> @@ -1,6 +1,6 @@
>  * Device tree bindings for Atmel Timer Counter Blocks
> -- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
> -  <chip> can be "at91rm9200" or "at91sam9x5"
> +- compatible: Should be "atmel,at91rm9200-tcb", "atmel,at91sam9x5-tcb",
> +  "microchip,sam9x60-tcb", "simple-mfd", "syscon".

How many valid combinations are there? 1 with 5 strings? List one valid 
combination per line.

>  - reg: Should contain registers location and length
>  - #address-cells: has to be 1
>  - #size-cells: has to be 0
> -- 
> 2.7.4
> 
