Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C214C56DA
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 17:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiBZQje (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 11:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiBZQj3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 11:39:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771292763DE;
        Sat, 26 Feb 2022 08:38:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 305B0B80814;
        Sat, 26 Feb 2022 16:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A18C340E8;
        Sat, 26 Feb 2022 16:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645893532;
        bh=d5AVYgPxJWn9UwC6aAdRHNnNvHYGW63YkaCdBsPCMW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=brNXrWjEttinCo9d52z+QPt+qcJM7w6ExHd9GTBjpi3ayjtMzeQYsHVedmdw9cchi
         1tG47rMaJ6sW+f0pQ1F/BbaaFUFVww9yV5x9xcqmMYsiRY2wFJ4lsbK84fCofNdBEl
         OQohHXygKhHZfTOeNoUkuwYjiYJFBp5viuNjaP8mUifG7kPrvw9ENMc7LEBgpQwNqi
         MAJsPjUECXtl5aGviLWl3BwACkMO5uXvn4r/qk02HpZiBg4JGpoHa+msfla6xd8+t0
         OW63mnzyfgH0kAxodbZxxoc9RRCuOWhS1g9EflY95PKoMa2xt41W/dsBxPSy8QOycY
         aR1dW9Q3xLIOQ==
Date:   Sat, 26 Feb 2022 16:45:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Robert Hancock <robert.hancock@calian.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Cc:     "anand.ashok.dumbre@xilinx.com" <anand.ashok.dumbre@xilinx.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "manish.narani@xilinx.com" <manish.narani@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Xilinx AMS fixes
Message-ID: <20220226164552.7fed4f1d@jic23-huawei>
In-Reply-To: <9aeda9dd153f470ae630cff79c374e66ffbeade8.camel@calian.com>
References: <20220127173450.3684318-1-robert.hancock@calian.com>
        <20220130124605.6268bfc5@jic23-huawei>
        <9aeda9dd153f470ae630cff79c374e66ffbeade8.camel@calian.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Feb 2022 19:49:27 +0000
Robert Hancock <robert.hancock@calian.com> wrote:

> On Sun, 2022-01-30 at 12:46 +0000, Jonathan Cameron wrote:
> > On Thu, 27 Jan 2022 11:34:46 -0600
> > Robert Hancock <robert.hancock@calian.com> wrote:
> >   
> > > Various fixes for the Xilinx AMS driver.
> > > 
> > > Changes since v1:
> > > -drop addition to ZynqMP device tree, will be submitted elsewhere
> > > -add patch to fix DT binding to add missing clock entry  
> > 
> > I'm fine with these but would like to leave them all on list a tiny
> > bit longer so we can hopefully get some review, particularly on patches
> > 1 and 4.
> > 
> > Jonathan  
> 
> Hi all,
> 
> I don't think I've gotten any feedback. Is anyone able to review/test?
> 
Michal,

If you have a chance to take a quick look at this series that would
be great.

Thanks,

Jonathan


> >   
> > > Robert Hancock (4):
> > >   dt-bindings: iio: adc: zynqmp_ams: Add clock entry
> > >   iio: adc: xilinx-ams: Fixed missing PS channels
> > >   iio: adc: xilinx-ams: Fixed wrong sequencer register settings
> > >   iio: adc: xilinx-ams: Fix single channel switching sequence
> > > 
> > >  .../bindings/iio/adc/xlnx,zynqmp-ams.yaml         |  8 ++++++++
> > >  drivers/iio/adc/xilinx-ams.c                      | 15 +++++++++++----
> > >  2 files changed, 19 insertions(+), 4 deletions(-)
> > >   

