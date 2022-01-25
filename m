Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B8F49AF89
	for <lists+linux-iio@lfdr.de>; Tue, 25 Jan 2022 10:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456465AbiAYJLZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Jan 2022 04:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454024AbiAYI5V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Jan 2022 03:57:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2648C06C581
        for <linux-iio@vger.kernel.org>; Tue, 25 Jan 2022 00:06:43 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCGqc-0006yQ-47; Tue, 25 Jan 2022 09:06:38 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCGqY-0000ZQ-Cl; Tue, 25 Jan 2022 09:06:34 +0100
Date:   Tue, 25 Jan 2022 09:06:34 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] iio: adc: xilinx-ams: Fixed missing PS channels
Message-ID: <20220125080634.GD25856@pengutronix.de>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
 <20220120010246.3794962-3-robert.hancock@calian.com>
 <c615acdc4f0a818e070705e1f3f5d82660fb4c8a.camel@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c615acdc4f0a818e070705e1f3f5d82660fb4c8a.camel@calian.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:03:39 up 45 days, 16:49, 77 users,  load average: 0.24, 0.42,
 0.41
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Jan 2022 01:09:39 +0000, Robert Hancock wrote:
> On Wed, 2022-01-19 at 19:02 -0600, Robert Hancock wrote:
> > The code forgot to increment num_channels for the PS channel inputs,
> > resulting in them not being enabled as they should.
> > 
> > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> > ---
> >  drivers/iio/adc/xilinx-ams.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > index 8343c5f74121..b93864362dac 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -1224,6 +1224,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
> >  
> >  		/* add PS channels to iio device channels */
> >  		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
> > +		num_channels = ARRAY_SIZE(ams_ps_channels);
> >  	} else if (fwnode_property_match_string(fwnode, "compatible",
> >  						"xlnx,zynqmp-ams-pl") == 0) {
> >  		ams->pl_base = fwnode_iomap(fwnode, 0);
> 
> Looks like this is the same change just submitted by Michael Tretter ("iio:
> adc: xilinx-ams: Fix num_channels for PS channels").

Thanks for pointing me here.

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

Michael
