Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454356EBE8B
	for <lists+linux-iio@lfdr.de>; Sun, 23 Apr 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDWKVq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Apr 2023 06:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjDWKVo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Apr 2023 06:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4D10D8
        for <linux-iio@vger.kernel.org>; Sun, 23 Apr 2023 03:21:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C95B60C41
        for <linux-iio@vger.kernel.org>; Sun, 23 Apr 2023 10:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AABC433D2;
        Sun, 23 Apr 2023 10:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682245302;
        bh=zOLZHnGpKILoH1HPaewA+HlW0oetF8a5lwpJYBQAZQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HpywQk0SYOXmBNHviyUnMgzLLNXVJ6ZoKIkE4EFtiB8P4iNcAHBvYcwzYl4IROUNW
         kUcZVQ1wri2bO2nZiEFLEiFa8hUh2RQtz9LEXttpJhoHae614oJsX1a1pMbcHmrLaR
         Fkkulz6RKWKAUnl3IShXYaOFqyreJNnVb3RdCpw+39F0vMYoaEiOEFgq0OSeKSlnFe
         0NYvxxnuhu9adPyu19E8ZzKGmju+My/rhLzzDXW3qKrHRv0ovAhZe3BCigkuLjvoE1
         DnRIuizg03S6hvsnwWC4M9AtmgpfDrXEFOT2tgMjg3UjuJFHvZYaY8W5gG3VboUKLa
         CVHeEsOazu/MA==
Date:   Sun, 23 Apr 2023 11:37:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad4130: Make sure clock provider gets removed
Message-ID: <20230423113718.34880560@jic23-huawei>
In-Reply-To: <20230414150702.518441-1-lars@metafoo.de>
References: <20230414150702.518441-1-lars@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Apr 2023 08:07:02 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> The ad4130 driver registers a clock provider, but never removes it. This
> leaves a stale clock provider behind that references freed clocks when the
> device is unbound.
> 
> Register a managed action to remove the clock provider when the device is
> removed.
> 
> Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad4130.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> index 38394341fd6e..5a5dd5e87ffc 100644
> --- a/drivers/iio/adc/ad4130.c
> +++ b/drivers/iio/adc/ad4130.c
> @@ -1817,6 +1817,11 @@ static const struct clk_ops ad4130_int_clk_ops = {
>  	.unprepare = ad4130_int_clk_unprepare,
>  };
>  
> +static void ad4130_clk_del_provider(void *of_node)
> +{
> +	of_clk_del_provider(of_node);
> +}
> +
>  static int ad4130_setup_int_clk(struct ad4130_state *st)
>  {
>  	struct device *dev = &st->spi->dev;
> @@ -1824,6 +1829,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
>  	struct clk_init_data init;
>  	const char *clk_name;
>  	struct clk *clk;
> +	int ret;
>  
>  	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
>  	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
> @@ -1843,7 +1849,11 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> -	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
> +	ret = of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, ad4130_clk_del_provider, of_node);
>  }
>  
>  static int ad4130_setup(struct iio_dev *indio_dev)

