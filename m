Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C201B1294E4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 12:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWLQm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 06:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfLWLQm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 06:16:42 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6736206D3;
        Mon, 23 Dec 2019 11:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577099801;
        bh=xGLGE31Xwh18pncBblQVgK8mlKFPGu9zTopz+g6QchE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wGGbAnN85TdnRe8X5bBQUW1NcJrt9ju9qrIRIrrSR99dAyaSppay1+iMrH3ciW2Bz
         vA/ihWAMcV7tMU8XZujCgsRDibtJNxvgf4zCK/Cr3toa1eFkRiADZZt+bbSZQH8sWj
         uDVfZylf5vJ9p+13u06it86FdW+BzlycytGe3R4Y=
Date:   Mon, 23 Dec 2019 11:16:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Eugen.Hristev@microchip.com, robh+dt@kernel.org,
        Nicolas.Ferre@microchip.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        a.zummo@towertech.it, Ludovic.Desroches@microchip.com
Subject: Re: [PATCH 04/10] rtc: at91rm9200: use of_platform_populate as
 return value
Message-ID: <20191223111636.4698123b@archlinux>
In-Reply-To: <20191219102321.GR695889@piout.net>
References: <1576686157-11939-1-git-send-email-eugen.hristev@microchip.com>
        <1576686157-11939-5-git-send-email-eugen.hristev@microchip.com>
        <20191218164348.GN695889@piout.net>
        <04264cb0-61a9-aba3-82ad-e7d12fd8441e@microchip.com>
        <20191218165831.GO695889@piout.net>
        <91cc67e1-7e14-f7b9-da77-b16d9e158f20@microchip.com>
        <20191219102321.GR695889@piout.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Dec 2019 11:23:21 +0100
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 19/12/2019 09:15:02+0000, Eugen.Hristev@microchip.com wrote:
> > 
> > 
> > On 18.12.2019 18:58, Alexandre Belloni wrote:  
> > > On 18/12/2019 16:52:21+0000, Eugen.Hristev@microchip.com wrote:  
> > >>
> > >>
> > >> On 18.12.2019 18:43, Alexandre Belloni wrote:
> > >>  
> > >>> Hi,
> > >>>
> > >>> On 18/12/2019 16:24:00+0000, Eugen.Hristev@microchip.com wrote:  
> > >>>> From: Eugen Hristev <eugen.hristev@microchip.com>
> > >>>>
> > >>>> This allows the RTC node to have child nodes in DT.
> > >>>> This allows subnodes to be probed.
> > >>>>
> > >>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > >>>> ---
> > >>>>    drivers/rtc/rtc-at91rm9200.c | 2 +-
> > >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> > >>>> index 3b833e0..f1b5b3d 100644
> > >>>> --- a/drivers/rtc/rtc-at91rm9200.c
> > >>>> +++ b/drivers/rtc/rtc-at91rm9200.c
> > >>>> @@ -421,7 +421,7 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
> > >>>>         at91_rtc_write_ier(AT91_RTC_SECEV);
> > >>>>
> > >>>>         dev_info(&pdev->dev, "AT91 Real Time Clock driver.\n");
> > >>>> -     return 0;
> > >>>> +     return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> > >>>>  
> > >>>
> > >>> You can avoid the DT binding change and DT parsing by using
> > >>> platform_add_device here. I don't think there is any point describing
> > >>> the trigger as a child node (a watchdog functionality wouldn't be
> > >>> described for example).
> > >>>  
> > >>
> > >> Hi,
> > >>
> > >> It's needed because the ADC needs a link to the trigger device. This is
> > >> a hardware link inside the SoC, so I thought the best way is to describe
> > >> this hardware is in the Device Tree.
> > >> Otherwise the ADC node is unaware of the RTC triggering possibility.
> > >> If we just assign the RTC trigger device to the ADC through the sysfs,
> > >> the ADC cannot distinguish between the RTC trigger and other various
> > >> triggers which can be attached.
> > >>  
> > > 
> > > I'm not sure this links is required but I will let Jonathan review. Even
> > > if it is needed, you can still use the rtc node to describe that link.  
> > 
> > Actually, the RTC node could potentially have two different ADC 
> > triggers. There is another OUT1 field that can do a second trigger for 
> > the ADC only for the last channel. Future development might add this 
> > trigger, so, with that in mind, I think it's best to link the exact 
> > trigger and not the RTC node.  
> 
> Nothing prevents you from using an index with the phandle (and I would
> add a type in that case then). Having subnodes in the DT is not really a
> good idea. The IP is the RTC, it just happens to have some outputs.
> See what has been done for the PMC.
> 
> 

If it can be done either way, let's avoid adding to the rtc dt binding.

Jonathan

