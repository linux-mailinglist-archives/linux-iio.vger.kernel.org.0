Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9B96894F0
	for <lists+linux-iio@lfdr.de>; Fri,  3 Feb 2023 11:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBCKP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 05:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjBCKP2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 05:15:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCE48D62E;
        Fri,  3 Feb 2023 02:15:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C75C260691;
        Fri,  3 Feb 2023 10:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A2C4339E;
        Fri,  3 Feb 2023 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675419326;
        bh=2nhbC6FJlLG55yKyyU0atw1B7ll2cNKoFXxA5qOS+r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bhKQujDzvoH55yuw241n5FLYf6qa4v/Btw8CasaVqqnYIIRfiwHU4G2m7GqUPr4bt
         8Mdner8LuDyVBRYfg4iSp7yK3GwLkskQrXAcUxNUxqR4oyuGelYArH+XnqYBY+isXd
         weV3nxU5ifukHpsu9r6FSuoNXppjZn29ocRdxZPd3/20d7p0LjHpCleRczg7+OQyP0
         JjkkpDa9Mgv12XcnQ5UP6kbc6deVQVDS5QtzV9DfOFxv0bUYHXcdDdEAMrAxyyEgtE
         gAEeeQ4AiBxALi+GEoUFVS849wWsEkOqc94n7/RABYaOoW2PLe4RzMIJR/09bbdbFD
         cymabkdP0HzsQ==
Date:   Fri, 3 Feb 2023 10:15:20 +0000
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v12 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y9zeuJDHzTGlYfrE@google.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-5-biju.das.jz@bp.renesas.com>
 <Y9y/PDUKoyexFIpN@google.com>
 <OS0PR01MB5922BF3489BC0A263DB60DAA86D79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS0PR01MB5922BF3489BC0A263DB60DAA86D79@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 03 Feb 2023, Biju Das wrote:

> 
> Hi Lee Jones,
> 
> Thanks for the feedback.
> 
> > -----Original Message-----
> > From: Lee Jones <lee@kernel.org>
> > Sent: Friday, February 3, 2023 8:01 AM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: William Breathitt Gray <william.gray@linaro.org>; linux-
> > iio@vger.kernel.org; Daniel Lezcano <daniel.lezcano@linaro.org>; Thierry
> > Reding <thierry.reding@gmail.com>; Uwe Kleine-König <u.kleine-
> > koenig@pengutronix.de>; Geert Uytterhoeven <geert+renesas@glider.be>; Chris
> > Paterson <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; linux-renesas-soc@vger.kernel.org
> > Subject: Re: [PATCH v12 4/6] counter: Add Renesas RZ/G2L MTU3a counter
> > driver
> > 
> > On Thu, 02 Feb 2023, Biju Das wrote:
> > 
> > > Add RZ/G2L MTU3a counter driver. This IP supports the following phase
> > > counting modes on MTU1 and MTU2 channels
> > >
> > > 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> > > 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
> > >
> > > This patch adds 3 counter value channels.
> > > 	count0: 16-bit phase counter value channel on MTU1
> > > 	count1: 16-bit phase counter value channel on MTU2
> > > 	count2: 32-bit phase counter value channel by cascading
> > >                 MTU1 and MTU2 channels.
> > >
> > > The external input phase clock pin for the counter value channels are
> > > as follows:
> > > 	count0: "MTCLKA-MTCLKB"
> > > 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> > > 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> > >
> > > Use the sysfs variable "external_input_phase_clock_select" to select
> > > the external input phase clock pin and "cascade_counts_enable" to
> > > enable/ disable cascading of channels.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
> > 
> > When we come to merge this, an Ack will be required.
> 
> You mean an Ack from William Breathitt Gray and you can take it through
> MFD (ie, core + counter patches together)??
> 
> or 
> 
> You will apply core driver and create an immutable branch, counter subsystem
> can use that branch to avoid build issues while applying??
> 
> Please share your view on this.

My assumption is that William provided his tag with a view to not
merging this via his own repo.

However, if there aren't any *build time* dependencies between the
patches (i.e. shared header files, etc), then the preference would be
for each commit to be merged through their own associated subsystem
trees.  However if there are build time deps, then it's common for the
entire set to be merged in via the MFD tree.  In the latter case a
subsequent pull-request would then be provided for each of the other
maintainers to pull from (if they so desire / need to).

-- 
Lee Jones [李琼斯]
