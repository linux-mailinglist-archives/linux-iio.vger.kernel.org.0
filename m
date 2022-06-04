Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781CD53D7A3
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiFDQLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiFDQLA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:11:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0471F274;
        Sat,  4 Jun 2022 09:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9739B8069F;
        Sat,  4 Jun 2022 16:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4329C385B8;
        Sat,  4 Jun 2022 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654359057;
        bh=BR/gIt545qkwHAcr26HVThFM3VwGBkQEksbYZhnyxAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BFiYoPb+ci9cHbHuzO5GqpB8/1WBERjCf3AVC5dnrUtpokvnbWr/uxLVP1jDSl2Tq
         soiKgukQTHtr+IiD+zJd/XxawBdZty6xoQWkUt6mS2NV8H9MkI5PVQa3dSu2yZRPU9
         tmC8zlwN/BjgTMa5LpLelBlcaylddjhrTt0ihgkaK1Mqlatv5n/ajS6ddRIIfTlPGg
         qlEu8bONjJK1WhEbz7lPNZP/X1bsiHVTDqmU0QP3HF7zLTJuBRPSn+vqW106MYdvcq
         NZ/bGAyVw6PnrUZSXKx3QKQfhzXgBko2rlQ1lCaMib6HGiRw1fl4PiQrp1pCvYYBLK
         NYGbWOYmlCqRQ==
Date:   Sat, 4 Jun 2022 17:19:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     robh+dt@kernel.org, swboyd@chromium.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 02/10] iio: sx9324: Fix register field spelling
Message-ID: <20220604171958.28bcd451@jic23-huawei>
In-Reply-To: <20220429220144.1476049-3-gwendal@chromium.org>
References: <20220429220144.1476049-1-gwendal@chromium.org>
        <20220429220144.1476049-3-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Apr 2022 15:01:36 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> Field for PROX_CTRL4 should contain PROX_CTRL4.
> 
> Fixes: 4c18a890dff8d ("iio:proximity:sx9324: Add SX9324 support")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Applied

> ---
> No Changes in v5.
> Changes since v3:
> - Added Review tags.
> 
> Changes since v2:
> - no changes
> 
> Changes since v1:
> - Add Fixes keyword in commit message.
> 
>  drivers/iio/proximity/sx9324.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 378c2a17bae6e..a7d9a53692a6d 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -90,7 +90,7 @@
>  #define SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK	GENMASK(5, 3)
>  #define SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 0x08
>  #define SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK	GENMASK(2, 0)
> -#define SX9324_REG_PROX_CTRL3_AVGPOS_FILT_256 0x04
> +#define SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 0x04
>  #define SX9324_REG_PROX_CTRL5		0x35
>  #define SX9324_REG_PROX_CTRL5_HYST_MASK			GENMASK(5, 4)
>  #define SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK	GENMASK(3, 2)
> @@ -794,7 +794,7 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
>  	{ SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
>  		SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K },
>  	{ SX9324_REG_PROX_CTRL4, SX9324_REG_PROX_CTRL4_AVGNEG_FILT_2 |
> -		SX9324_REG_PROX_CTRL3_AVGPOS_FILT_256 },
> +		SX9324_REG_PROX_CTRL4_AVGPOS_FILT_256 },
>  	{ SX9324_REG_PROX_CTRL5, 0x00 },
>  	{ SX9324_REG_PROX_CTRL6, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },
>  	{ SX9324_REG_PROX_CTRL7, SX9324_REG_PROX_CTRL6_PROXTHRESH_32 },

