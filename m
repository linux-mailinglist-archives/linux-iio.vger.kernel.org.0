Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5F69F83D
	for <lists+linux-iio@lfdr.de>; Wed, 22 Feb 2023 16:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjBVPl1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Feb 2023 10:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjBVPlR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2023 10:41:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F694ECB;
        Wed, 22 Feb 2023 07:41:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D01E0CE1DFF;
        Wed, 22 Feb 2023 15:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C59C433EF;
        Wed, 22 Feb 2023 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677080163;
        bh=6OiNrUoSk8IsC3LZqfhZGbwu+s0dh8vUE+MkRMC32tQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1Ac4W6yP3Trp0BLB/e+PLHiL0YM3rPCd1BvvqbtGBQLpOjQeksrT80fa82ASs2xj
         9YfuKL+EASoBMQXes/1aAYcXWEAnxBonhlXka42ux52xt8lcuBodf/U10cHn2fJGV6
         v6893vMaV95VapS9TT5ThTnXhWTVHzR83Eo4MxPNpc+TkAPWPqjr6BOmOUpNYZdhxW
         iBPNbKZukIQhjB3smw5c38EjusklrC+HNK5j52zz12pDm9mtlRf6eGvf2OL8b3bFye
         BHxzbkLjwlPHz2O3AyutFmIm2OaWfMSuvt8az13QCqYuxiR4GBX50D02oOwO+CbVm1
         M91nDV0JEsQAQ==
Date:   Wed, 22 Feb 2023 15:35:57 +0000
From:   Lee Jones <lee@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y/Y2XZ8Ns1DJkbSH@google.com>
References: <20230216203830.196632-1-biju.das.jz@bp.renesas.com>
 <20230216203830.196632-5-biju.das.jz@bp.renesas.com>
 <Y/YwzGWKyR4jhoFt@google.com>
 <Y/YzylOMwUGK/Z0c@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/YzylOMwUGK/Z0c@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Feb 2023, William Breathitt Gray wrote:

> On Wed, Feb 22, 2023 at 03:12:12PM +0000, Lee Jones wrote:
> > On Thu, 16 Feb 2023, Biju Das wrote:
> > 
> > > Add RZ/G2L MTU3a counter driver. This IP supports the following
> > > phase counting modes on MTU1 and MTU2 channels
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
> > > The external input phase clock pin for the counter value channels
> > > are as follows:
> > > 	count0: "MTCLKA-MTCLKB"
> > > 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> > > 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> > > 
> > > Use the sysfs variable "external_input_phase_clock_select" to select the
> > > external input phase clock pin and "cascade_counts_enable" to enable/
> > > disable cascading of channels.
> > > 
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Reviewed-by: William Breathitt Gray <william.gray@linaro.org>
> > 
> > Hey William,
> > 
> > Is this a review or an ack?
> > 
> > It looks like there are deps on other patches in this set.  It's likely
> > that the whole set with to in together via one tree (probably MFD),
> > which I can make happen with the appropriate maintainer acks.
> 
> I reviewed just this patch in-depth so that's wherefore the Reviewed-by
> tag. However, I do approve of these changes so please apply my Ack as
> well if so neccessary to pick this up.
> 
> Acked-by: William Breathitt Gray <william.gray@linaro.org>

An Acked-by implies that it's been reviewed.

> One minor suggestion is to include MAINTAINERS entries for the new
> MTU3a core driver and PWM driver, but I'll yield to the respective
> subsystem maintainers regarding that matter.

It's not required for driver authors to become file maintainers.
However, if they wish to, that's their prerogative.

Thanks William, I hope all is well with you.

-- 
Lee Jones [李琼斯]
