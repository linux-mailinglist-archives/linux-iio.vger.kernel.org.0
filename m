Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F249B6552E6
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLWQm0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 11:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiLWQmZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 11:42:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351113DDD
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 08:42:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 53E8ECE1CF3
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 16:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F34AC433EF;
        Fri, 23 Dec 2022 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671813740;
        bh=W8Djh0mxGJQUPew7Y6tP6xt7pFcY8U6K6ZZxydh3bfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lCdEFGvfMl4ACFy99ENijJepUYR3VJOLegUxF2QAjwwhbcd3FBW77Cd9O7UtBREI6
         uKADNfbCUI+MYTLTOsNVjqq2du4eJxa2jQrSFuHTVxeXB1Zi/2lO8B4SaP2A9EHvvD
         r8wIffMl+20ZPAzqkCklyGi/IPoOfxoOe84wDNHX3wucyTVaKJQIsHgTLjtXPi3wwl
         +MyyejCZfbX/qwgCpK4bNLPRs+Au5T7Dtm2yUtYWMLB1pUAcbisbKOhKVTYvZBgVEH
         YTlb82sTeF0Gf1mdmJslwuItFWCXxW7QizGfrToqdHd8fqMVDuqj2iT13vP88UPSS7
         /Ny74yFD9R0bA==
Date:   Fri, 23 Dec 2022 16:55:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/5] iio: imu: fxos8700: fix incorrect ODR mode
 readback
Message-ID: <20221223165529.08c491cb@jic23-huawei>
In-Reply-To: <20221214031503.3104251-2-carlos.song@nxp.com>
References: <20221214031503.3104251-1-carlos.song@nxp.com>
        <20221214031503.3104251-2-carlos.song@nxp.com>
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

On Wed, 14 Dec 2022 11:14:59 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> The absence of a correct offset leads an incorrect ODR mode
> readback after use a hexadecimal number to mark the value from
> FXOS8700_CTRL_REG1.
> 
> Get ODR mode by field mask and FIELD_GET clearly and conveniently.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> 
You need a 
---

above the change log to avoid git picking it up when I apply the patch.
I've fixed that up whilst applying.

Applied to the fixes-togreg branch of iio.git and marked for stable.

> Changes for V3:
> - Rework commit log
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 773f62203bf0..83ab7d0f79b3 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/regmap.h>
>  #include <linux/acpi.h>
>  #include <linux/bitops.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -147,6 +148,7 @@
>  #define FXOS8700_CTRL_ODR_MSK       0x38
>  #define FXOS8700_CTRL_ODR_MAX       0x00
>  #define FXOS8700_CTRL_ODR_MIN       GENMASK(4, 3)
> +#define FXOS8700_CTRL_ODR_GENMSK    GENMASK(5, 3)
>  
>  /* Bit definitions for FXOS8700_M_CTRL_REG1 */
>  #define FXOS8700_HMS_MASK           GENMASK(1, 0)
> @@ -524,7 +526,7 @@ static int fxos8700_get_odr(struct fxos8700_data *data, enum fxos8700_sensor t,
>  	if (ret)
>  		return ret;
>  
> -	val &= FXOS8700_CTRL_ODR_MSK;
> +	val = FIELD_GET(FXOS8700_CTRL_ODR_GENMSK, val);
>  
>  	for (i = 0; i < odr_num; i++)
>  		if (val == fxos8700_odr[i].bits)

