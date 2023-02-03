Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E20689184
	for <lists+linux-iio@lfdr.de>; Fri,  3 Feb 2023 09:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBCIC5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Feb 2023 03:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjBCICX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Feb 2023 03:02:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303C2953DC;
        Fri,  3 Feb 2023 00:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C44461E12;
        Fri,  3 Feb 2023 08:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA7BC433D2;
        Fri,  3 Feb 2023 08:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675411265;
        bh=vVlrUZrr0/pVxnzPjRcXR17nLRCHZcsc+O5sCidCSEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zy4D+hVXGNR1n79Vy0USxgSGKN95OwliK7vCYgmNnVoKLQdDBiTmLFLBLBa8BKZx0
         ZnBuyeD2Kspu5CTulsoVwokPsnDSw+fKh9+G0d0GMofkvNIWvyX5E+nB9dXejRQaCG
         fq0/VcwtR6wWfZ4vC5GRnECi3HDAYUxylDpalgmTtnFLNBycRXErKy7hxFAmFBmfG/
         t2nxbz9GKvUbOU1IubhyX0JdGk03uMneVywFmYl8tV8RPcZOO8/S5HyeOC7fLN/KhN
         v+LcPWwFg8I0XL7jD4haF7ox6PHH0BgxGHgQun4IJvFZ/nlK9SUx+KbOB5jE18Lx6X
         w5CYunur7UE5g==
Date:   Fri, 3 Feb 2023 08:01:00 +0000
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
Subject: Re: [PATCH v12 4/6] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y9y/PDUKoyexFIpN@google.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202165732.305650-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 02 Feb 2023, Biju Das wrote:

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

When we come to merge this, an Ack will be required.

-- 
Lee Jones [李琼斯]
