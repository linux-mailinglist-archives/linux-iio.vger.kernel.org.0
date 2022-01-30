Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3EE4A3632
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 13:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354769AbiA3MZi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 07:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354760AbiA3MZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 07:25:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEB1C061714;
        Sun, 30 Jan 2022 04:25:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8851BB82920;
        Sun, 30 Jan 2022 12:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C620C340E4;
        Sun, 30 Jan 2022 12:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643545535;
        bh=qQp9Ydhf25VS6D6MpriuZZ0bGWeVhYXJp4Y6EavVOsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QtfUmzPkUvpp4y4hfqnbeAackZ4U+DnUuzmbHoIZ+4dig3kYJy18rBSZ2of+jOVE0
         VeuQB/eZ/2cw0DQ2g+VD7CfflBUnJe1IHelkj1X8cmvVc5v5hTf+/3VfsoRGtynkmW
         Kx3N2OzmER+O8hnmfL6+84gk4Tv7l5l6u8fVMxu4ewFtztW9HNR/09O6dK2cHCz4UX
         XftS4kMyd8O6wP02qhlEdRydL3eIkzhPvEeWfD2r8Cz1QuI/YfAkjlByEkDyaBwrfC
         1Wn9AClpAOsPjVJzD/x9PqK88d+WIlbNrbLygT7Yqz8d6srAlXjs15sAg8KD+TMgdq
         LmEa+U9RARNjw==
Date:   Sun, 30 Jan 2022 12:31:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Robert Hancock <robert.hancock@calian.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>
Subject: Re: [PATCH 3/4] iio: adc: xilinx-ams: Fixed wrong sequencer
 register settings
Message-ID: <20220130123157.0d98f968@jic23-huawei>
In-Reply-To: <20220126091250.GC2550@pengutronix.de>
References: <20220120010246.3794962-1-robert.hancock@calian.com>
        <20220120010246.3794962-4-robert.hancock@calian.com>
        <20220125082108.GE25856@pengutronix.de>
        <4c5fb3899a8aafa34106a668bcb2807b6f073036.camel@calian.com>
        <20220126091250.GC2550@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Jan 2022 10:12:50 +0100
Michael Tretter <m.tretter@pengutronix.de> wrote:

> On Tue, 25 Jan 2022 16:15:05 +0000, Robert Hancock wrote:
> > On Tue, 2022-01-25 at 09:21 +0100, Michael Tretter wrote:  
> > > On Wed, 19 Jan 2022 19:02:45 -0600, Robert Hancock wrote:  
> > > > Register settings used for the sequencer configuration register
> > > > were incorrect, causing some inputs to not be read properly.
> > > > 
> > > > Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> > > > Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> > > > ---
> > > >  drivers/iio/adc/xilinx-ams.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > > > index b93864362dac..199027c93cdc 100644
> > > > --- a/drivers/iio/adc/xilinx-ams.c
> > > > +++ b/drivers/iio/adc/xilinx-ams.c
> > > > @@ -91,8 +91,8 @@
> > > >  
> > > >  #define AMS_CONF1_SEQ_MASK		GENMASK(15, 12)
> > > >  #define AMS_CONF1_SEQ_DEFAULT		FIELD_PREP(AMS_CONF1_SEQ_MASK,
> > > > 0)
> > > > -#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 1)
> > > > -#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK,
> > > > 2)
> > > > +#define AMS_CONF1_SEQ_CONTINUOUS	FIELD_PREP(AMS_CONF1_SEQ_MASK, 2)
> > > > +#define AMS_CONF1_SEQ_SINGLE_CHANNEL	FIELD_PREP(AMS_CONF1_SEQ_MASK,
> > > > 3)  
> > > 
> > > The TRM states that Continuous Loop Mode is 2, but Single Pass Sequence Mode
> > > is 1, not 3. Is there a reason, why you need to set both bits?  
> > 
> > Single pass sequence mode (1) just runs the same sequence only once. To read
> > these values it needs to switch to single channel mode (3).
> > 
> > The register bits are defined in Table 3-8 of 
> > https://www.xilinx.com/support/documentation/user_guides/ug580-ultrascale-sysmon.pdf
> >  .  
> 
> Thanks for the clarification.
> 
> Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
