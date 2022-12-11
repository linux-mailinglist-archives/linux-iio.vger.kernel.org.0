Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A6C649475
	for <lists+linux-iio@lfdr.de>; Sun, 11 Dec 2022 14:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLKNdE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Dec 2022 08:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKNdD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Dec 2022 08:33:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE5FFE
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 05:33:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91583B80884
        for <linux-iio@vger.kernel.org>; Sun, 11 Dec 2022 13:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05DEC433EF;
        Sun, 11 Dec 2022 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670765579;
        bh=M0HdFPp060+cDMdsmkRxRK4XFnUezItobODgaktC33o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kthCWsqd/48ykmRDofgBdLshLHXDxclnC82EceYV3sGILIysr2XdQt73IcyGvM/gk
         olBHBE4j2Wvwv7nyl5ZOrN8zNKj63ngSb0RljR6A1Zdae4uohrOYZWMofmHMqjibn4
         jYfBo4/3K2IuVXMiN7Bry6VURvDDMmWrp6QCHrgLSVGxLb1AR4veIjEoDa+LwFqvVW
         xb5B2b+8YhKUYnQWxZLOqhwNaK9BbWI1aRxnNNOqsWkCE8LzCgnxEvE4pWPXp2rexf
         r23+8h0JtypI113L1HT7LUrk0sOBpcX8grt5+0qQkiVtuMVvNkruT9izU//F3bmB4n
         P3mxtBbPJzmRA==
Date:   Sun, 11 Dec 2022 13:45:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     carlos.song@nxp.com
Cc:     lars@metafoo.de, rjones@gateworks.com, Jonathan.Cameron@huawei.com,
        haibo.chen@nxp.com, linux-imx@nxp.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: imu: fxos8700: fix incompete ACCEL and MAGN
 channels readback
Message-ID: <20221211134553.3616ffad@jic23-huawei>
In-Reply-To: <20221208071911.2405922-4-carlos.song@nxp.com>
References: <20221208071911.2405922-1-carlos.song@nxp.com>
        <20221208071911.2405922-4-carlos.song@nxp.com>
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

On Thu,  8 Dec 2022 15:19:07 +0800
carlos.song@nxp.com wrote:

> From: Carlos Song <carlos.song@nxp.com>
> 
> The length of ACCEL and MAGN 3-aix channels output data is 6 byte
> individually. However block only read 3 bytes data into buffer from
> ACCEL or MAGN output data registers every time. It causes an incompete
> ACCEL and MAGN channels readback.
> 
> Set correct value count for regmap_bulk_read to get 6 bytes ACCEL and
> MAGN channels readback.
> 
> Fixes: 84e5ddd5c46e ("iio: imu: Add support for the FXOS8700 IMU")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
Please spell check patch descriptions.  Anyhow, tidied that up whilst
applying.

Applied to the fixes-togreg branch of iio.git and marked for stable
inclusion.

Thanks,

Jonathan

> ---
> Changes for V2:
> - Reserve the global DMA safe buffer
> - Use sizeof(data->buf) instead of hardcoded FXOS8700_DATA_BUF_SIZE
> - Rework commit log
> 
> diff --git a/drivers/iio/imu/fxos8700_core.c b/drivers/iio/imu/fxos8700_core.c
> index 977eb7dc7dbd..b62bc92bbacc 100644
> --- a/drivers/iio/imu/fxos8700_core.c
> +++ b/drivers/iio/imu/fxos8700_core.c
> @@ -414,7 +414,7 @@ static int fxos8700_get_data(struct fxos8700_data *data, int chan_type,
>  
>  	/* Block read 6 bytes of device output registers to avoid data loss */
>  	ret = regmap_bulk_read(data->regmap, base, data->buf,
> -			       FXOS8700_DATA_BUF_SIZE);
> +			       sizeof(data->buf));
>  	if (ret)
>  		return ret;
>  

