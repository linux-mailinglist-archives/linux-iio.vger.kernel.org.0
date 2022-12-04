Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29686641D90
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLDPCk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiLDPCh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 10:02:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47C210CF
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 07:02:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D74360AFC
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 15:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955C4C433D6;
        Sun,  4 Dec 2022 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670166155;
        bh=yoUjRWf69w+QzljYXydQFrVG3Zh62+9Cr3eCCv0RxUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kudX/fowa1iRwmuiKGkoHF+bvM9NOBNW93FW9maNWRY2I4ZQTpjkkFzjbJCH8jhew
         taGZ/DZSJdYXI8cboP/qLsm8qknAmEARwxIGXaJlV0Z8aA07X0QUEtmGo7VQoPc492
         +UY537LBLNTTiLwpBAjKZ5yvRoEbsBs7aH9U3HnYihptmNEmgnnikD4KWpOc1TJSHh
         jQm2ppkwT+FTmbjkrRaiawWH214ZZXm5ECwGoPC8dCT/rlt9wGqPNBDS9DyGHzxgg7
         rGUI8aAVB7UBXBULZ5S1z8ZVUgNbCeIR424nJZACKidYUwoQgOHDDhlgthbo4cLPbr
         hdm/TNPp/4TsQ==
Date:   Sun, 4 Dec 2022 15:15:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Carlos Song <carlos.song@nxp.com>
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: imu: fxos8700: fix ODR offset error
Message-ID: <20221204151521.208e6a7d@jic23-huawei>
In-Reply-To: <20221202103538.2218925-4-carlos.song@nxp.com>
References: <20221202103538.2218925-1-carlos.song@nxp.com>
        <20221202103538.2218925-4-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri,  2 Dec 2022 18:35:37 +0800
Carlos Song <carlos.song@nxp.com> wrote:

> Correct offset of ODR configure is needed when configure the register
> and read ODR data from the register.
> 
> Give the correct offset to value when configuring ODR bit and
> reading ODR data from CTRL_REG1 register.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Fixes: 058f2a09e645 ("iio: imu: fxos8700: fix CTRL_REG1 register configuration error")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Minor suggestion inline.

Btw, I'm not particularly keen on internal review tags.
I know the policy varies by company, but it it isn't too much of a problem, I'd
prefer to have seen Haibo Chen's review on list as that then gives me some
way to build trust in Haibo's reviews over the long run!

If not possible, then that's fine.

Jonathan

> ---
>  drivers/iio/imu/fxos8700_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 60c08519d8af..27e3bd61d054 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -147,6 +147,7 @@
>  #define FXOS8700_CTRL_ODR_MSK       0x38
>  #define FXOS8700_CTRL_ODR_MAX       0x00
>  #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
> +#define FXOS8700_CTRL_ODR_OFFSET    3
>  
>  /* Bit definitions for FXOS8700_M_CTRL_REG1 */
>  #define FXOS8700_HMS_MASK           GENMASK(1, 0)
> @@ -498,8 +499,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (ret)
>  		return ret;
>  
> -	val &= FXOS8700_CTRL_ODR_MSK;
> -
> +	val = (val & FXOS8700_CTRL_ODR_MSK) >> FXOS8700_CTRL_ODR_OFFSET;

FIELD_GET() / FIELD_PREP() preferred as it avoids need to separately define
an offset.

>  	for (i = 0; i < odr_num; i++)
>  		if (val == fxos8700_odr[i].bits)
>  			break;
> @@ -636,7 +636,8 @@ static int fxos8700_chip_init(struct fxos8700_data *data, bool use_spi)
>  
>  	/* Max ODR (800Hz individual or 400Hz hybrid), active mode */
>  	return regmap_write(data->regmap, FXOS8700_CTRL_REG1,
> -			   FXOS8700_CTRL_ODR_MAX | FXOS8700_ACTIVE);
> +			   FXOS8700_CTRL_ODR_MAX << FXOS8700_CTRL_ODR_OFFSET |
> +			   FXOS8700_ACTIVE);
>  }
>  
>  static void fxos8700_chip_uninit(void *data)

