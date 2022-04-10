Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FA24FAF2C
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 19:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiDJRKt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiDJRKs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 13:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED861276F
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 10:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45EE861154
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 17:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C59C385A1;
        Sun, 10 Apr 2022 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649610516;
        bh=2obxRpiLJS9IXr6USKYItJu9ikFI1kyXw4UgiYwUL3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M2EnAjpT/Q9aUhhyWHh8HotkDoRnuey0M8nzQyJ84b1LP8rhg7gm8vFK1mUI2HSoS
         R7mLfctMRmECrKoN/S2w3LCDTdE+35cmB/5hIaKU22nffYZvjBZywpwB0HPoCrzEcj
         P6+wpEUU9zGZb1ZKBTW0JMnCB9sq2NLJJTCDtuZuPR9S7fMgUF8XrnJFV0awaPdy6D
         5ACfs8bhbAU/Xk4XTfHeJiyexUrfiY1avIDM6399IZoI+E9rRzIyparRHQEmd92Zdg
         xx5UWxoGUJJkhIksvPSUsQ19WgBGAefle3U14B2Ehh1xV/WJMsNUlNuoR+sxqRyrr3
         H2c0U7HknrJPw==
Date:   Sun, 10 Apr 2022 18:16:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH] iio: freq: admv1014: Fix warning about dubious x & !y
 and improve readability
Message-ID: <20220410181628.084fcf3b@jic23-huawei>
In-Reply-To: <20220319181401.136810-1-jic23@kernel.org>
References: <20220319181401.136810-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Sat, 19 Mar 2022 18:14:01 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The warning comes from __BF_FIELD_CHECK()
> specifically
> 
> BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> 		 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
> 		 _pfx "value too large for the field"); \
> 
> The code was using !(enum value) which is not particularly easy to follow
> so replace that with explicit matching and use of ? 0 : 1; or ? 1 : 0;
> to improve readability.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>

Antoniu, or anyone else who has time, can you sanity check this one?
I'd like to clean up the warning asap but don't really trust myself
enough to not have done something stupid ;)

Jonathan

> ---
>  drivers/iio/frequency/admv1014.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> index a7994f8e6b9b..802835efbec7 100644
> --- a/drivers/iio/frequency/admv1014.c
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -700,8 +700,10 @@ static int admv1014_init(struct admv1014_state *st)
>  			 ADMV1014_DET_EN_MSK;
>  
>  	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp ? 3 : 0) |
> -		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
> -		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
> +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
> +				(st->input_mode == ADMV1014_IQ_MODE) ? 0 : 1) |
> +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
> +				(st->input_mode == ADMV1014_IQ_MODE) ? 1 : 0) |
>  		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
>  
>  	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);

