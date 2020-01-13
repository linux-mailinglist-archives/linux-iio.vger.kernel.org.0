Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74D139D32
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 00:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgAMXXB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 18:23:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41839 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgAMXXB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 18:23:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so10718974otc.8
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 15:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2iDZ52lWikDVmU5g/bwIONEfUCTF197jf9k+MTeRXI=;
        b=jJSFNWr4alxssxU8JyWdUKCvOZ7lXLbRObvIWGmXsu4vfEwhpdVatfVVuAr145lP0d
         5JKdf0SnRQJTy1j7/NVaj+0jfynUTXndZsZWRaE66+UfCYMLdr+M0/YuyIZVYT6llegt
         Z50PqjYHb/cFfyo6Std8IPPhdiy1EKlonVj2bY7WKEkwWr4zxhibEqq8mHF87UPBBHDW
         lKj8C1tkgElyPIoVGFGLErCGr6pgYq/kSyuh7j7pWprBRykNX0C+02A8zDZJLCrNWlB7
         kSRDaA3FnIVFRrxY4kfgX83V1JL+rRU09AaGPHeM6bLSKbPmP2BfWBuR934mw9h9cXIo
         ohkg==
X-Gm-Message-State: APjAAAWTDo9/eknVw1NtKGfGSrWWkO0MoibG0SsYW7XLpvO9oSP6ZJfI
        jC1yAVFCTMVOtMAhagw3ufQbEEc=
X-Google-Smtp-Source: APXvYqy34lb0/KIMRwggaiheaLGSb4WB5BHtuL7V3BR5uM/eNXC0j2LyXsvXDnIb4zgoSUE/1eOd3g==
X-Received: by 2002:a9d:5c8a:: with SMTP id a10mr13688846oti.95.1578957780491;
        Mon, 13 Jan 2020 15:23:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k26sm4022966oiw.34.2020.01.13.15.22.58
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:22:58 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:22:57 -0600
Date:   Mon, 13 Jan 2020 17:22:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: at_xdmac: remove wildcard
Message-ID: <20200113232257.GA30124@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Jan 2020 18:17:53 +0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatible.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
