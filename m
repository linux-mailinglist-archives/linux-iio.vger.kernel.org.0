Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E7613A426
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2020 10:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgANJrM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 04:47:12 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:43333 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgANJrM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 04:47:12 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 326A12000F;
        Tue, 14 Jan 2020 09:47:05 +0000 (UTC)
Date:   Tue, 14 Jan 2020 10:47:05 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
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
Subject: Re: [PATCH v2 01/17] dt-bindings: at_xdmac: remove wildcard
Message-ID: <20200114094705.GB3137@piout.net>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/01/2020 18:17:53+0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatible.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
