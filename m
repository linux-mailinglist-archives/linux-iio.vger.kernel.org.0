Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B04C5727
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 18:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiBZRvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 12:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiBZRvm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 12:51:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A427EC17;
        Sat, 26 Feb 2022 09:51:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6382B80947;
        Sat, 26 Feb 2022 17:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D766C340E8;
        Sat, 26 Feb 2022 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645897864;
        bh=V62jRcLH/8MNpKHjxDLun0Cs4D+nxjy4aEAg3Ka1ZY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y4DxmxMNqySPLmaJ9+p7N/bL58oFGeTyUjCB37hXekQibCJGsn3rsRbIuqdkSJD4R
         gbw4or82uI0d1i8MMNF2FJ5kmwuTSgybsg2hQE56mf6FDZzgA6WvhU+/SlBLhtBsTW
         /a4S3lf1L+/X+uU0DF+x2dmP7NNqHN2GCA20I3brBaaA8vuI3pLX39aOQNVuD67UAW
         krMFULc4SHmJgsgOHay5QmDP47p6lYtPgbrLAIk7IxwwypRKVGSyqJlCvRc6Ed3pwU
         LDuoid8KapGOnC/WcoQGLMG66I4sHQ6pes/JUKwYNLCgE0U6jNZ3vclRu+e5Vb/Jgr
         SAAPLPDwbUHBw==
Date:   Sat, 26 Feb 2022 17:58:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl367: unlock on error in
 adxl367_buffer_predisable()
Message-ID: <20220226175805.1f35babb@jic23-huawei>
In-Reply-To: <20220224150228.GB6856@kili>
References: <20220224150228.GB6856@kili>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Thu, 24 Feb 2022 18:02:28 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> This error path needs to call the mutex_unlock(&st->lock) before
> returning.
> 
> Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, applied to the togreg branch of iio.git.

Jonathan

> ---
>  drivers/iio/accel/adxl367.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index b452d74b1d4d..bdc95409abed 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -1359,7 +1359,7 @@ static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	ret = adxl367_set_measure_en(st, true);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	ret = adxl367_set_temp_adc_mask_en(st, indio_dev->active_scan_mask,
>  					   false);

