Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423CC6DC634
	for <lists+linux-iio@lfdr.de>; Mon, 10 Apr 2023 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDJLOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Apr 2023 07:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjDJLOQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2023 07:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3873FA
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 04:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48EF4611EC
        for <linux-iio@vger.kernel.org>; Mon, 10 Apr 2023 11:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C727C433D2;
        Mon, 10 Apr 2023 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681125254;
        bh=Cpi9rEKLrUOdMnOsPx3naBE2mSPNhdA4Y605405Lh40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t6PBeanHSaq4Bvwitsl2sm7uix2tWdnf3PlMu34bxAS4Z5hMuPEhYQ4xofjj0pbLc
         RCcXg3ej085MOrMf7cY8VtFsP2Za6+cxi3mFVrw8BeUjYexvbVHy4xf4N462JXro3d
         cYuzOrJCeMHE9Tw76pEpTQ0efGDYrg5NIPYzjhGZeMrS6lKjz2H7Bo1KIrpbWZ4gg7
         tEn9hLs5XNMpun7uw1TrbKVT4y2FzWMctWYpVRa0Omuec6B+s5/4c1pvojbCIDM5KH
         IIlnhxtOHgpe7PnG1c2M5iIBo/mJiVBGsvHUNR3xoTDiJb6TAD9tffqb2PEWnMyWfS
         1KhL0YcUa7E1A==
Date:   Mon, 10 Apr 2023 12:29:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad4310: Replace devm_clk_register() with
 devm_clk_hw_register()
Message-ID: <20230410122932.580b42fb@jic23-huawei>
In-Reply-To: <6cae1606-838f-1859-01ad-23d80b7f4033@metafoo.de>
References: <20230326142046.422314-1-lars@metafoo.de>
        <20230326162539.3e291184@jic23-huawei>
        <6cae1606-838f-1859-01ad-23d80b7f4033@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 9 Apr 2023 11:25:28 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/26/23 08:25, Jonathan Cameron wrote:
> > On Sun, 26 Mar 2023 07:20:46 -0700
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >  
> >> The devm_clk_register() is deprecated and devm_clk_hw_register() should be
> >> used as a replacement.
> >>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> > Applied
> >  
> I've noticed a bug in this driver. It never removes the clock provider. 
> A backportable fix for that conflicts with this patch. Can we drop this 
> patch for now and re-apply it after the fix?

Hopefully this won't cause anyone too much trouble as that was pushed out
as a supposedly non rebasing branch.

Patch dropped.

> >  
> >> ---
> >>   drivers/iio/adc/ad4130.c | 11 ++++++-----
> >>   1 file changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> >> index 38394341fd6e..f23b7808e996 100644
> >> --- a/drivers/iio/adc/ad4130.c
> >> +++ b/drivers/iio/adc/ad4130.c
> >> @@ -1823,7 +1823,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
> >>   	struct device_node *of_node = dev_of_node(dev);
> >>   	struct clk_init_data init;
> >>   	const char *clk_name;
> >> -	struct clk *clk;
> >> +	int ret;
> >>   
> >>   	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
> >>   	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
> >> @@ -1839,11 +1839,12 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
> >>   	init.ops = &ad4130_int_clk_ops;
> >>   
> >>   	st->int_clk_hw.init = &init;
> >> -	clk = devm_clk_register(dev, &st->int_clk_hw);
> >> -	if (IS_ERR(clk))
> >> -		return PTR_ERR(clk);
> >> +	ret = devm_clk_hw_register(dev, &st->int_clk_hw);
> >> +	if (ret)
> >> +		return ret;
> >>   
> >> -	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
> >> +	return of_clk_add_hw_provider(of_node, of_clk_hw_simple_get,
> >> +				      &st->int_clk_hw);
> >>   }
> >>   
> >>   static int ad4130_setup(struct iio_dev *indio_dev)  
> 
> 

