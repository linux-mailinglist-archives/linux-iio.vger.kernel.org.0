Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E930069F76B
	for <lists+linux-iio@lfdr.de>; Wed, 22 Feb 2023 16:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjBVPMW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Feb 2023 10:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjBVPMV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2023 10:12:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C138007;
        Wed, 22 Feb 2023 07:12:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11E6CB80B46;
        Wed, 22 Feb 2023 15:12:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1C4C433D2;
        Wed, 22 Feb 2023 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677078737;
        bh=KwCS55LXaW+g1mI7XLynXyNJDVrmhINQPL14pmlru6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdnlIKvaBe8dqKz2+a5EHdzCGR9auoEGx3yCrVTL/G+4quSDf6eXJYxxDE30pDBVr
         pVB6LRSn/FCTbWFki9+AXn9pQKxvbLWZX1xu0FXRrjkzfB09Es2C5erAYh6gSn+MaT
         JsZTkZh6/NKFqyH7zSsrIe7kBMjKfTF+iGL2XIXgMYHinoEw4F+JPvHawuPjkryn2j
         EALC/x38aRbhFUBlE+aHtJPVrx/9uh8e42sYylqQtx58GMed5rvLxe6y4KkZzlFYYo
         sBukDTkAcI1z4whblB+w9uqWdvkDPtpESlttX007DcUaXCThz7ScQp51sGkvYFin9X
         Yg5QIMv+NCn2w==
Date:   Wed, 22 Feb 2023 15:12:12 +0000
From:   Lee Jones <lee@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y/YwzGWKyR4jhoFt@google.com>
References: <20230216203830.196632-1-biju.das.jz@bp.renesas.com>
 <20230216203830.196632-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216203830.196632-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Feb 2023, Biju Das wrote:

> Add RZ/G2L MTU3a counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
> 
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
> 
> This patch adds 3 counter value channels.
> 	count0: 16-bit phase counter value channel on MTU1
> 	count1: 16-bit phase counter value channel on MTU2
> 	count2: 32-bit phase counter value channel by cascading
>                 MTU1 and MTU2 channels.
> 
> The external input phase clock pin for the counter value channels
> are as follows:
> 	count0: "MTCLKA-MTCLKB"
> 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> 
> Use the sysfs variable "external_input_phase_clock_select" to select the
> external input phase clock pin and "cascade_counts_enable" to enable/
> disable cascading of channels.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: William Breathitt Gray <william.gray@linaro.org>

Hey William,

Is this a review or an ack?

It looks like there are deps on other patches in this set.  It's likely
that the whole set with to in together via one tree (probably MFD),
which I can make happen with the appropriate maintainer acks.

>  drivers/counter/Kconfig       |  11 +
>  drivers/counter/Makefile      |   1 +
>  drivers/counter/rz-mtu3-cnt.c | 902 ++++++++++++++++++++++++++++++++++
>  3 files changed, 914 insertions(+)
>  create mode 100644 drivers/counter/rz-mtu3-cnt.c

-- 
Lee Jones [李琼斯]
