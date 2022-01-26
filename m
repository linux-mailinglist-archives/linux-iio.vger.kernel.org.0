Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281BE49C5ED
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jan 2022 10:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiAZJNG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jan 2022 04:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiAZJNF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jan 2022 04:13:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2DC06161C
        for <linux-iio@vger.kernel.org>; Wed, 26 Jan 2022 01:13:05 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCeMH-0002MY-Kx; Wed, 26 Jan 2022 10:12:53 +0100
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1nCeME-00026i-OU; Wed, 26 Jan 2022 10:12:50 +0100
Date:   Wed, 26 Jan 2022 10:12:50 +0100
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Robert Hancock <robert.hancock@calian.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>
Subject: Re: [PATCH 3/4] iio: adc: xilinx-ams: Fixed wrong sequencer register
 settings
Message-ID: <20220126091250.GC2550@pengutronix.de>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
 <20220120010246.3794962-4-robert.hancock@calian.com>
 <20220125082108.GE25856@pengutronix.de>
 <4c5fb3899a8aafa34106a668bcb2807b6f073036.camel@calian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c5fb3899a8aafa34106a668bcb2807b6f073036.camel@calian.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:10:37 up 46 days, 17:56, 80 users,  load average: 0.43, 0.21,
 0.19
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jan 2022 16:15:05 +0000, Robert Hancock wrote:
> On Tue, 2022-01-25 at 09:21 +0100, Michael Tretter wrote:
> > On Wed, 19 Jan 2022 19:02:45 -0600, Robert Hancock wrote:
> > > Register settings used for the sequencer configuration register
> > > were incorrect, causing some inputs to not be read properly.
> > > 
> > > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > > Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> > > ---
> > >  drivers/iio/adc/xilinx-ams.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > > index b93864362dac..199027c93cdc 100644
> > > --- a/drivers/iio/adc/xilinx-ams.c
> > > +++ b/drivers/iio/adc/xilinx-ams.c
> > > @@ -91,8 +91,8 @@
> > >  
> > >  #define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
> > >  #define AMS_CONF1_SEQ_DEFAULT		FIELD_PREP(AMS_CONF1_SEQ_MASK,
> > > 0)
> > > -#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 1)
> > > -#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK,
> > > 2)
> > > +#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
> > > +#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK,
> > > 3)
> > 
> > The TRM states that Continuous Loop Mode is 2, but Single Pass Sequence Mode
> > is 1, not 3. Is there a reason, why you need to set both bits?
> 
> Single pass sequence mode (1) just runs the same sequence only once. To read
> these values it needs to switch to single channel mode (3).
> 
> The register bits are defined in Table 3-8 of 
> https://www.xilinx.com/support/documentation/user_guides/ug580-ultrascale-sysmon.pdf
>  .

Thanks for the clarification.

Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

> 
> > 
> > Michael
> > 
> > >  
> > >  #define AMS_REG_SEQ0_MASK		GENMASK(15, 0)
> > >  #define AMS_REG_SEQ2_MASK		GENMASK(21, 16)
> > > -- 
> > > 2.31.1
> > > 
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-arm-kernel__;!!IOGos0k!yGFEjSC1BL20lwurby914len0HCLXyzarwxKJP9Jx30qv_qrERSkRJUiVo_2MdusMVA$ 
> > > 
> -- 
> Robert Hancock
> Senior Hardware Designer, Calian Advanced Technologies
> www.calian.com
