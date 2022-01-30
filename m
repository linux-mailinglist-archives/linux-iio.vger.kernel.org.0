Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD084A3648
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 13:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354797AbiA3MiX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 07:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiA3MiW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 07:38:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A995C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 04:38:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A830761193
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF46C340E4;
        Sun, 30 Jan 2022 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643546301;
        bh=z4EkGHSSzUXo5U3w1mUhpT3Hr3SpgVBh6HSkNvnGFtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zsmboc7zegZ+VhghlKn8op6HVHmLmV4Gri9HxS/0TCPjJhbdHQeq+QSvBxx07rtk0
         pFyO2ILEvGU5qBslLg2uKEtuNdzL4JO/A1Wo1VKiqV9AGYg6uGGAOWmryWuGlN8bav
         fMKrMnq/5zpZ3u9/NYZWSh61+miJiGDucOyr3WmsZdcH3t21vW1q50FeX7G+GgsURX
         ieaFB1FvwfqX3CWj9FeIPa7EWgrdJ1UTf1pC/7IoNcFoS6AZeiG6ZLoK3gJVqTrBud
         RSLhnTezskGarRxoGoaUPgw9/JVyryPP48j+lFa0amSGzYJdawjKQUXd3gwei7Sd1O
         PALto98ybtCIQ==
Date:   Sun, 30 Jan 2022 12:44:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, anand.ashok.dumbre@xilinx.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] iio: adc: xilinx-ams: Fix num_channels for PS channels
Message-ID: <20220130124445.22a34873@jic23-huawei>
In-Reply-To: <20220130123025.5ff021d9@jic23-huawei>
References: <20220119114513.2035609-1-m.tretter@pengutronix.de>
        <20220130123025.5ff021d9@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 30 Jan 2022 12:30:25 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 19 Jan 2022 12:45:13 +0100
> Michael Tretter <m.tretter@pengutronix.de> wrote:
> 
> > The IIO channels of the PS are not provided in the sysfs even if the
> > ams_ps is enabled in the device tree. The reason is that the channels of
> > the PS are not added to the overall number of IIO channels.
> > 
> > The line somehow got lost between v11 and v12 of the patch series.
> > 
> > Add the number of ams_ps_channels to the number of channels to correctly
> > register all channels.
> > 
> > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")  
> Applied to the fixes togreg branch of iio.git.
> 
Actually change of plan . I'll just pick up the v2 fixes set from
Robert as otherwise I'll loose track of where we are with these.

Thanks,

Jonathan

> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/xilinx-ams.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > index 8343c5f74121..ede968efb77f 100644
> > --- a/drivers/iio/adc/xilinx-ams.c
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -1224,6 +1224,7 @@ static int ams_init_module(struct iio_dev *indio_dev,
> >  
> >  		/* add PS channels to iio device channels */
> >  		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
> > +		num_channels += ARRAY_SIZE(ams_ps_channels);
> >  	} else if (fwnode_property_match_string(fwnode, "compatible",
> >  						"xlnx,zynqmp-ams-pl") == 0) {
> >  		ams->pl_base = fwnode_iomap(fwnode, 0);  
> 

