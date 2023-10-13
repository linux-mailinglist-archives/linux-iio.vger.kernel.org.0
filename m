Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0377C8CCE
	for <lists+linux-iio@lfdr.de>; Fri, 13 Oct 2023 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMSJo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Oct 2023 14:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSJo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Oct 2023 14:09:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE1991
        for <linux-iio@vger.kernel.org>; Fri, 13 Oct 2023 11:09:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E02C433C7;
        Fri, 13 Oct 2023 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697220582;
        bh=CHLL/TyQTja+JRvBseAF7Alk0rHDgoNMClzQSpKtjqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OOfEP2G61Kx4R2W09dOqBgP8/I3Ey4F0icJOfyqAP8PTjAm3de/QwLL3zs+4TyvVq
         3JO6wISpPZgbFDdRqA+MdTo+fFoGKLlIRLJGiS7WjPHN6JTRuQikLlhkXosPjEt6RE
         OOI0N5HXv9hye6oHNKEkRMXmayFOaGDFBfixSMXxj9p2o37CwFz+xLV5YNkoQ7JkOE
         1MRha0PhbaKqfJP7oNvTHbnRRiaaMEkfG2Jw68VG46dhMQuXTaVnJItmdd1l7oFrC9
         NpkkqdqvO096tsEsJCWEtvSRJwNb9YZ87i5nl0mUBUKgo16LY9RnkdgGKiopBeRIiQ
         agScAznjdOBgQ==
Date:   Fri, 13 Oct 2023 19:09:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc:     "Simek, Michal" <michal.simek@amd.com>,
        Robert Hancock <robert.hancock@calian.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/2] Xilinx XADC fixes
Message-ID: <20231013190956.6c814db4@jic23-huawei>
In-Reply-To: <DM6PR12MB4217D5104DF438AA05039CC58BD3A@DM6PR12MB4217.namprd12.prod.outlook.com>
References: <20230915001019.2862964-1-robert.hancock@calian.com>
        <bae646e9-7977-4de3-927b-ffcb7a94ac48@amd.com>
        <20230924173210.13f2bf85@jic23-huawei>
        <20231010171928.75451192@jic23-huawei>
        <DM6PR12MB4217D5104DF438AA05039CC58BD3A@DM6PR12MB4217.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 12 Oct 2023 09:53:44 +0000
"O'Griofa, Conall" <conall.ogriofa@amd.com> wrote:

> [AMD Official Use Only - General]
> 
> Acked-by: O'Griofa, Conall <conall.ogriofa@amd.com>
> Tested-by: O'Griofa, Conall <conall.ogriofa@amd.com>
> 
> Hi Jonathan,
> 
> Thanks for the patches, changes look good, I have tested on board and not seen any issues from my testing.
Great. Applied to the fixes-togreg branch of iio.git.

thanks,

Jonathan

> 
> Cheers,
> Conall.
> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Tuesday, October 10, 2023 5:19 PM
> > To: Simek, Michal <michal.simek@amd.com>
> > Cc: Robert Hancock <robert.hancock@calian.com>; O'Griofa, Conall
> > <conall.ogriofa@amd.com>; Lars-Peter Clausen <lars@metafoo.de>; linux-
> > iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v2 0/2] Xilinx XADC fixes
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Sun, 24 Sep 2023 17:32:10 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> > > On Fri, 15 Sep 2023 08:52:49 +0200
> > > Michal Simek <michal.simek@amd.com> wrote:
> > >  
> > > > +Conall
> > > >
> > > > On 9/15/23 02:10, Robert Hancock wrote:  
> > > > > Fixes for a couple of issues in the Xilinx XADC driver: one where
> > > > > preconfigured temperature/voltage thresholds were being clobbered
> > > > > and potentially breaking overtemperature shutdown, and another for
> > > > > inaccurate temperature readings on UltraScale family devices.
> > > > >
> > > > > Changed since v2: Updated to also remove disabling XADC alarm bits.
> > > > >
> > > > > Robert Hancock (2):
> > > > >    iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
> > > > >      thresholds
> > > > >    iio: adc: xilinx-xadc: Correct temperature offset/scale for
> > > > > UltraScale
> > > > >
> > > > >   drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++-------------------
> > > > >   drivers/iio/adc/xilinx-xadc.h      |  2 ++
> > > > >   2 files changed, 16 insertions(+), 25 deletions(-)
> > > > >  
> > > >
> > > > Conall: Please test and review.  
> > >
> > > I'm sitting on this one until I hear back.   No huge rush, but if you
> > > can estimate when you'll get to this I know to leave you alone until
> > > after that!  
> >
> > I'll ask one more time, then probably just assume these are fine and apply.
> >
> > So Conall, have you had a chance to look at these?
> >
> > Thanks,
> >
> > Jonathan
> >  
> > >
> > > Jonathan
> > >  
> > > >
> > > > Thanks,
> > > > Michal  
> > >  
> 

