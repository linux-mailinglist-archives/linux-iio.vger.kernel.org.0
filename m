Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1A5F232B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJBMax (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 08:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJBMaf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 08:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D1B27DD6
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 05:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5F660EC6
        for <linux-iio@vger.kernel.org>; Sun,  2 Oct 2022 12:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297A5C433C1;
        Sun,  2 Oct 2022 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664713829;
        bh=abjCo0FZkwDB9ygn/LTtRI0AdjceUghi4L4AcYCaEpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CQrmJn/5fZuPvXsBNFXcqwRqW4xu2HiB9Qwuu2DS9zUv4pus5TxUttm1nMhCiyAfv
         KzGj3Cd70nDhBxtQlg+QppBGwprljcCsgV0ZTZPaIp/w2XXQgnWBj/3hq9q+09xYHI
         Vh0rw7WKmH+OixvdPKJet7iWvWiatPZsbxTyUoudsMSh/QMK5D63yt1gKY0CbFxCyr
         0ouYqsGsgPwf/YhISXzfNcU0iy7wmrQpG5cZz7wLwB+Roa55dfnWjMLQgGc0QSExw1
         r4UJwNrk1oO7g+QOIxx0itFZedJmvomwwjjeKF10gF4Rd63ccaysfMpTfPjBhqQ+9w
         SH/fszm0TTG9A==
Date:   Sun, 2 Oct 2022 13:30:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-iio@vger.kernel.org>, <dan@dlrobertson.com>,
        <lars@metafoo.de>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH -next] iio: accel: bma400: Switch to use dev_err_probe()
 helper
Message-ID: <20221002133046.31d536f0@jic23-huawei>
In-Reply-To: <20220927064435.152211-1-yangyingliang@huawei.com>
References: <20220927064435.152211-1-yangyingliang@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Tue, 27 Sep 2022 14:44:35 +0800
Yang Yingliang <yangyingliang@huawei.com> wrote:

> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Similar patch already queued for 6.2 from Yuan Can

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bma400_core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index ad8fce3e08cd..e4de649b6701 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -886,14 +886,10 @@ static int bma400_init(struct bma400_data *data)
>  	ret = devm_regulator_bulk_get(data->dev,
>  				      ARRAY_SIZE(data->regulators),
>  				      data->regulators);
> -	if (ret) {
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(data->dev,
> -				"Failed to get regulators: %d\n",
> -				ret);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Failed to get regulators\n");
>  
> -		return ret;
> -	}
>  	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
>  				    data->regulators);
>  	if (ret) {

