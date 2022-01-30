Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880EA4A3629
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 13:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350383AbiA3MXO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 07:23:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56336 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiA3MXO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 07:23:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24DA3B80ADA;
        Sun, 30 Jan 2022 12:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C78C340E4;
        Sun, 30 Jan 2022 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643545391;
        bh=fm2H03I7JohTOGhiivk+lcwEwYwVivsT2lguCfjn4vQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WSFIn9BFnwuKWcFuf8//TihWk0p6oF31TRHWjI+qoRayjyNdNYccL5rGP4XcU/fSe
         RjvPEtuSBlHJ0qXHXrgAoL2YgaroFWZLN/ShGzRQYs+2KG8FPU3rNsnBEphNG/9JCS
         3bFQgxM7gmxa9tCYYwF2QQsZzfWVHX8FjChO9hugMX5SmrqpY0VHzjmQ0GwaqHxqNw
         aGXONfVC26BsPdfqmZ/Nbg+2SqoRM3Zk2e0+x0M9hFSCfEWrqbvbEcdXofwW/MC1Rd
         Z1NnD6JRn6A5VZ4JdODDr8BKLeW9R5DGOwhxC7aO47sxeH9mj2HRFhHej1K9BnS5pj
         UAqz89xtva8zw==
Date:   Sun, 30 Jan 2022 12:29:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Robert Hancock <robert.hancock@calian.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] iio: adc: xilinx-ams: Fixed missing PS channels
Message-ID: <20220130122934.705dcd87@jic23-huawei>
In-Reply-To: <20220125080634.GD25856@pengutronix.de>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
        <20220120010246.3794962-3-robert.hancock@calian.com>
        <c615acdc4f0a818e070705e1f3f5d82660fb4c8a.camel@calian.com>
        <20220125080634.GD25856@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jan 2022 09:06:34 +0100
Michael Tretter <m.tretter@pengutronix.de> wrote:

> On Thu, 20 Jan 2022 01:09:39 +0000, Robert Hancock wrote:
> > On Wed, 2022-01-19 at 19:02 -0600, Robert Hancock wrote:  
> > > The code forgot to increment num_channels for the PS channel inputs,
> > > resulting in them not being enabled as they should.
> > > 
> > > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > > Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> > > ---
> > >  drivers/iio/adc/xilinx-ams.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > > index 8343c5f74121..b93864362dac 100644
> > > --- a/drivers/iio/adc/xilinx-ams.c
> > > +++ b/drivers/iio/adc/xilinx-ams.c
> > > @@ -1224,6 +1224,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
> > >  
> > >  		/* add PS channels to iio device channels */
> > >  		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
> > > +		num_channels = ARRAY_SIZE(ams_ps_channels);
> > >  	} else if (fwnode_property_match_string(fwnode, "compatible",
> > >  						"xlnx,zynqmp-ams-pl") == 0) {
> > >  		ams->pl_base = fwnode_iomap(fwnode, 0);  
> > 
> > Looks like this is the same change just submitted by Michael Tretter ("iio:
> > adc: xilinx-ams: Fix num_channels for PS channels").  
> 
> Thanks for pointing me here.
> 
> Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

I picked up Michael's patch and will drop this one...
(based on random email reading order. I'd argue his was first in time, but
then someone would point out next time I pick a patch up that is later than
another one :)

Thanks,

> 
> Michael

