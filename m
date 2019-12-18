Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9A124E81
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2019 17:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLRQ6e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Dec 2019 11:58:34 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33851 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfLRQ6e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2019 11:58:34 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A3939C000E;
        Wed, 18 Dec 2019 16:58:31 +0000 (UTC)
Date:   Wed, 18 Dec 2019 17:58:31 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     jic23@kernel.org, robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as
 return value
Message-ID: <20191218165831.GO695889@piout.net>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
 <1576686157-11939-5-git-send-email-eugen.hristev@microchip.com>
 <20191218164348.GN695889@piout.net>
 <04264cb0-61a9-aba3-82ad-e7d12fd8441e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04264cb0-61a9-aba3-82ad-e7d12fd8441e@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 18/12/2019 16:52:21+0000, Eugen.Hristev@microchip.com wrote:
> 
> 
> On 18.12.2019 18:43, Alexandre Belloni wrote:
> 
> > Hi,
> > 
> > On 18/12/2019 16:24:00+0000, Eugen.Hristev@microchip.com wrote:
> >> From: Eugen Hristev <eugen.hristev@microchip.com>
> >>
> >> This allows the RTC node to have child nodes in DT.
> >> This allows subnodes to be probed.
> >>
> >> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >> ---
> >>   drivers/rtc/rtc-at91rm9200.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> >> index 3b833e0..f1b5b3d 100644
> >> --- a/drivers/rtc/rtc-at91rm9200.c
> >> +++ b/drivers/rtc/rtc-at91rm9200.c
> >> @@ -421,7 +421,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
> >>        at91_rtc_write_ier(AT91_RTC_SECEV);
> >>
> >>        dev_info(&pdev->dev, "AT91 Real Time Clock driver.\n");
> >> -     return 0;
> >> +     return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> >>
> > 
> > You can avoid the DT binding change and DT parsing by using
> > platform_add_device here. I don't think there is any point describing
> > the trigger as a child node (a watchdog functionality wouldn't be
> > described for example).
> > 
> 
> Hi,
> 
> It's needed because the ADC needs a link to the trigger device. This is 
> a hardware link inside the SoC, so I thought the best way is to describe 
> this hardware is in the Device Tree.
> Otherwise the ADC node is unaware of the RTC triggering possibility.
> If we just assign the RTC trigger device to the ADC through the sysfs, 
> the ADC cannot distinguish between the RTC trigger and other various 
> triggers which can be attached.
> 

I'm not sure this links is required but I will let Jonathan review. Even
if it is needed, you can still use the rtc node to describe that link.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
