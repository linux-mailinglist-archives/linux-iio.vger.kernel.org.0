Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26A6E327A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Apr 2023 18:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDOQjk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Apr 2023 12:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOQjj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 12:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4678421B
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 09:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8030E60ADF
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 16:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20659C433D2;
        Sat, 15 Apr 2023 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681576777;
        bh=m12Wojvj0aAZam7vE4eThYvhDPLzJEnY7nKdrJZREDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kbmb944mXF/staDCdoolg0nNt/9ePRmvAo0kgi2YO0ygM52yBtBe/bThF6OooqZuj
         VMLpKrhVIZmM0kNBMAVlBpVxiD35ocwecWqLEwKqA9nOPpUhsI4k94o966AEzuFVu9
         Yd4cXXLGcwkH/1Gz3+Qx+ySagRLuuFDrBFSpGNlZXDqGjlO4UOwG8q0i03IWh0l8IX
         ZvP34LV8sXpawSeFXnPltJ6alTbdYnyhIIUxefNMo0Ki157yhZtlOuEeTrkvyxnkYT
         SX5pTeBAR5KVF0g4CsqV4jDcSt/tqJi6IOTcpmus9wMwvP6eu1iGpV50zjwSRuXnbW
         uxXWM+CwNo78w==
Date:   Sat, 15 Apr 2023 17:39:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: ad7192: Fix internal/external clock
 selection
Message-ID: <20230415173939.3c2dc829@jic23-huawei>
In-Reply-To: <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
References: <CAPJMGm4PU0YgU0DhMvNZK58JzEhg_eszFaXfmyuY1ymjR617Xw@mail.gmail.com>
        <CAPJMGm4bv3PHiGa7B8uH+izmVOWVJnibmuZ-9GwnAGeGHmpN5w@mail.gmail.com>
        <CAPJMGm4YhDNOLku_vWUJA8cYbUinoVoP+NmP4Te+fpa-bjfHfQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Thu, 13 Apr 2023 10:33:32 +0200
Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:

> Fixed wrong selection of internal clock when mclk is defined.
> 
> Resolved a logical inversion introduced in c9ec2cb328e3.
> 
> Fixes: c9ec2cb328e3 iio: adc: ad7192: use devm_clk_get_optional() for mclk
> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>

Version should apply to whole series.

git format-patch -v2 
is a good way to get this right automatically.

Patch is fine subject to the fixes tag fix that Nuno pointed out.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 94a9cf34a255..5a9c8898f8af 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -367,7 +367,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
>      clock_sel = AD7192_CLK_INT;
> 
>      /* use internal clock */
> -    if (st->mclk) {
> +    if (!st->mclk) {
>          if (of_property_read_bool(np, "adi,int-clock-output-enable"))
>              clock_sel = AD7192_CLK_INT_CO;
>      } else {

