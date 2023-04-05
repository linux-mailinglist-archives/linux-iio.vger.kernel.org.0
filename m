Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE26D7EF8
	for <lists+linux-iio@lfdr.de>; Wed,  5 Apr 2023 16:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbjDEOQD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Apr 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbjDEOQC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Apr 2023 10:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30D26588;
        Wed,  5 Apr 2023 07:15:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18EC361FC3;
        Wed,  5 Apr 2023 14:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730CBC433EF;
        Wed,  5 Apr 2023 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680704110;
        bh=Dfv16e+bR5p7T51xphMD3a1e+PiXwpZYEjZMIu90IUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLxDCOdBlHGOnbP971/mOn+p7NsA6ETcJ/iyQTkxoncD9u7dN4Ue3QadhgxmpBeb7
         PsUlMa2R5R0ulUJGcyaZfNpFXWVgLG6tDuKexeUttvfAJRje5Ej8+0H/grZ5r7GDgh
         W8P9I7zNGd0tGessn7yGwhAzXf2OV1+89gbrbdjddZjgD0Sqg95/f8lsvor2GG1ROd
         q+IV226fI14FD2WhkstSL9oQ10FM9h7Qnm2l6jgZwTFA3DDjkoOpBNjUrPRb1/wxbC
         QBskBv+3V0jq6IWP6bV4S8A8GZ3zpPmz4FAvZy2lPPUdLJfGJLfQb8ZajziKSYlT5e
         Xy0vwuo/BfvDg==
Date:   Wed, 5 Apr 2023 15:15:05 +0100
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
Subject: Re: [PATCH v15 5/6] MAINTAINERS: Add entries for Renesas RZ/G2L
 MTU3a counter driver
Message-ID: <20230405141505.GK8371@google.com>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330111632.169434-6-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Mar 2023, Biju Das wrote:

> Add the MAINTAINERS entries for the Renesas RZ/G2L MTU3a counter
> driver.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v14->v15:
>  * No change.
> v13->v14:
>  * No change.
> v12->v13:
>  * No change.
> v11->v12:
>  * No change.
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied, thanks

--
Lee Jones [李琼斯]
