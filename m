Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0BF6552ED
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiLWQqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 11:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLWQqq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 11:46:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03ACB7C
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 08:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12AD2618DF
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 16:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319A2C433D2;
        Fri, 23 Dec 2022 16:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671814004;
        bh=dA7nSOF03thKSFPXRdpgN7RnskeK/PD4s588GCJIfM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W0QzJrhal2PCjk3zEAXwcE2b9ppCTva2Kbwp96fzh44uAwbiRjEn6JDq+jAu/V3hA
         P90KmTa6CX0T4hAN287g8WXG6EWHRrc7SiB1jDqJBCGNnAtlBvPccmok4B5hlNZ2vL
         JnicfJ0Ko6y/NPqr8LDn8D84ObPbwvQeuvkq3NeqPrBB4tmmCfJyliwsZDuRv3PSSX
         GScpmL05IplfeBbZwwCvGPYxLKHswtOV0DLVVVhhgklYqHuwRFZQnoAfpYyXc0IMJY
         fZc2gT5aZ6wt2DN4BabD5sNNPLyBrO9R5ZoDwyq3EOn35IpSDCm5+mxl/m3dHaGJd/
         x74pVk+ZkNs6g==
Date:   Fri, 23 Dec 2022 16:59:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] iio: imu: fxos8700: improve readability by field
 mask and regmap_write
Message-ID: <20221223165953.19fc0081@jic23-huawei>
In-Reply-To: <20221214031503.3104251-3-carlos.song@nxp.com>
References: <20221214031503.3104251-1-carlos.song@nxp.com>
        <20221214031503.3104251-3-carlos.song@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed, 14 Dec 2022 11:15:00 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> FXOS8700_CTRL_ODR_MSK is a hex digit mask and FXOS8700_CTRL_ODR_GENMSK
> is a field mask. They have a similar function. And mixing regmap_write
> and regmap_update_bits isn't good for readability.
> 
> Remove FXOS8700_CTRL_ODR_GENMSK and set FXOS8700_CTRL_ODR_MSK a field
> mask definition with a synchronous change. Use regmap_write() instead
> of regmap_update_bits() to update bits. They are good for readability.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
Needs a comment on why this deserves a fixes tag.

> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> 
---

needed here.

> Changes for V3:
> - Remove FXOS8700_CTRL_ODR_GENMSK and set FXOS8700_CTRL_ODR_MSK a
>   field mask.
> - Legal use of filed mask and FIELD_PREP() to select ODR mode
> - Rework commit log
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 83ab7d0f79b3..a1af5d0fde5d 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -145,10 +145,9 @@
>  #define FXOS8700_NVM_DATA_BNK0      0xa7
>  
>  /* Bit definitions for FXOS8700_CTRL_REG1 */
> -#define FXOS8700_CTRL_ODR_MSK       0x38
>  #define FXOS8700_CTRL_ODR_MAX       0x00
>  #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
> -#define FXOS8700_CTRL_ODR_GENMSK    GENMASK(5, 3)
> +#define FXOS8700_CTRL_ODR_MSK       GENMASK(5, 3)

Why jump through this loop in patch 1 and then this?  Just use
ODR_MSK in that fix in the first place. Doesn't matter for
purposes of a fix that it is in a less than ideal form.

>  
>  /* Bit definitions for FXOS8700_M_CTRL_REG1 */
>  #define FXOS8700_HMS_MASK           GENMASK(1, 0)
> @@ -510,10 +509,8 @@ static int fxos8700_set_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (i >= odr_num)
>  		return -EINVAL;
>  
> -	return regmap_update_bits(data->regmap,
> -				  FXOS8700_CTRL_REG1,
> -				  FXOS8700_CTRL_ODR_MSK + FXOS8700_ACTIVE,
> -				  fxos8700_odr[i].bits << 3 | active_mode);
> +	val = val | FIELD_PREP(FXOS8700_CTRL_ODR_MSK, fxos8700_odr[i].bits) | active_mode;
> +	return regmap_write(data->regmap, FXOS8700_CTRL_REG1, val);
>  }
>  
>  static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
> @@ -526,7 +523,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (ret)
>  		return ret;
>  
> -	val = FIELD_GET(FXOS8700_CTRL_ODR_GENMSK, val);
> +	val = FIELD_GET(FXOS8700_CTRL_ODR_MSK, val);
>  
>  	for (i = 0; i < odr_num; i++)
>  		if (val == fxos8700_odr[i].bits)

