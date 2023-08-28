Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5949678AE84
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjH1LMX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjH1LMH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55BB0
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 04:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FDA61022
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 11:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63853C433C7;
        Mon, 28 Aug 2023 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693221124;
        bh=3xzMaPjPYEqZCNZV1zhlfpTm5S4RWqgbO23BEWAdQgU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Oxfh+ZjH/zfMgeQvI+h2B3MHBfoOJBA1zSctRZ58PrZXZqpwYfyLpZbLydXAY+GRq
         rvA2l85mogIOWbrnzDYCphiRkeflaw/NT03B7H/dEp3h0Nh3ov1v/vlGh0EAw3hGBJ
         mJm7tx2kyrVGySYg/0jUMt7GgVVEChbFuCtqj/sSgPdrjsd6dxOdAGlrca10q3c1SO
         vxGQcsgbvSPcoGfJXOAxnjNPjGVqmjDqB1wukA/QFP4w1VbspjRBpvFvgAyHST21Fr
         D0mWnlao8cRUrNJ9VV6TBKoKl1QSH4uHiDOyC3uMQ64ydkIQNdg2+upx9UwgJw9vVL
         izf/NdY3xUWkw==
Date:   Mon, 28 Aug 2023 12:12:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
        <yangyingliang@huawei.com>, <robh@kernel.org>, <heiko@sntech.de>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH -next v3 0/3] iio: adc: at91_adc: Cleanup with the
 helpers
Message-ID: <20230828121222.114c728a@jic23-huawei>
In-Reply-To: <20230828064546.2383857-1-ruanjinjie@huawei.com>
References: <20230828064546.2383857-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Aug 2023 14:45:43 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks") provides a new helper function to prepare and
> enable a clock which keeps prepared (or enabled) during the whole
> lifetime of the driver.
> 
> Use devm_request_irq() to request the interrupt, so we can
> avoid having to manually clean this up.
> 
> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless
> error is printed.
> 
> changes in v3:
> - Take the last remove free_irq() and add it to be the first devm managed.
> - Not going any longer than 80 chars than is necessary.
> 
> Changes in v2:
> - Also use devm_request_irq() and dev_err_probe() to clean up the at91_adc.
> - Split the at91_adc patch out to be a new patch set.
> 
> Jinjie Ruan (3):
>   iio: adc: at91_adc: Use devm_request_irq() helper function
>   iio: adc: at91_adc: Use devm_clk_get_enabled() helper function
>   iio: adc: at91_adc: Simplify with dev_err_probe()
> 
>  drivers/iio/adc/at91_adc.c | 108 +++++++++++++------------------------
>  1 file changed, 37 insertions(+), 71 deletions(-)
> 

Series applied.

Thanks for jumping through the various hoops that came up in review!

Note that whilst I have applied this, that is mostly about my tracking
rather than meaning others cannot continue to comment on it.

I won't be pushing this out as a non rebasing tree (which linux-next will
pick up) for a few weeks.

Jonathan
