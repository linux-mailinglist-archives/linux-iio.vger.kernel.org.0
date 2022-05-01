Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7116C516550
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349471AbiEAQk6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 12:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349589AbiEAQkz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 12:40:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F54E33A16
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 09:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD9D60F30
        for <linux-iio@vger.kernel.org>; Sun,  1 May 2022 16:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11014C385A9;
        Sun,  1 May 2022 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651423045;
        bh=ExaK1RoYsxzIEyuY5ugijDf1DOg8EdbdSCMrM9CkQcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RZzV0xKL3pt3rJlj+t0ofN2teYLj0993cYCrGWEvUQ75oqax428B6J0pUJG9Pq/z4
         ebtAnlt6W9867CugdWpZI3Im6CTSGtFkLqDVXBTu5zrm06o/HkFfZy+HFcr6GwZwmY
         hlyxY0/alfgvxKPv4nI7BoSPvlbI2aYpNTtitjdSb3ob77ElgyS4JEXOIWC6Gzcqov
         ARoKnWfacmvfN8KFSm4NvzIFiAanCtsmV9pbpcT9c4GhFMY6TmofRkT60Nfm9YQDeB
         XsZQsDJCPvzhwhDWO3yMifWUQNZLQ/s9pOYSPNwbhwB+ggCmQLQJS9A/NeCsXEKlAj
         nR7/66PqFUW3w==
Date:   Sun, 1 May 2022 17:45:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lars@metafoo.de, hdegoede@redhat.com, linux-iio@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH] iio: mma8452: fix probe fail when device tree
 compatible is used.
Message-ID: <20220501174540.17d7a27a@jic23-huawei>
In-Reply-To: <1650876060-17577-1-git-send-email-haibo.chen@nxp.com>
References: <1650876060-17577-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Mon, 25 Apr 2022 16:41:00 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Correct the logic for the probe. First check of_match_table, if
> not meet, then check i2c_driver.id_table. If both not meet, then
> return fail.
> 
> Fixes: a47ac019e7e8 ("iio: mma8452: Fix probe failing when an i2c_device_id is used")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Yikes.

Just goes to show review doesn't always pick up on the obvious :(

Applied to the fixes-togreg branch of iio.git

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 9c02c681c84c..4156d216c640 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1556,11 +1556,13 @@ static int mma8452_probe(struct i2c_client *client,
>  	mutex_init(&data->lock);
>  
>  	data->chip_info = device_get_match_data(&client->dev);
> -	if (!data->chip_info && id) {
> -		data->chip_info = &mma_chip_info_table[id->driver_data];
> -	} else {
> -		dev_err(&client->dev, "unknown device model\n");
> -		return -ENODEV;
> +	if (!data->chip_info) {
> +		if (id) {
> +			data->chip_info = &mma_chip_info_table[id->driver_data];
> +		} else {
> +			dev_err(&client->dev, "unknown device model\n");
> +			return -ENODEV;
> +		}
>  	}
>  
>  	ret = iio_read_mount_matrix(&client->dev, &data->orientation);

