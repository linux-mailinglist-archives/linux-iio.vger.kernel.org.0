Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46405E8E51
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiIXQDk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 12:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiIXQDi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 12:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB2399F3
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 09:03:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79BD8B80D94
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 16:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEF6C433D6;
        Sat, 24 Sep 2022 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664035413;
        bh=KGQKM70hSvylHc6eDJ0I/T2VNL8Jk5i5oVhQCTj0/qs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XtkJq4Bebt70qvnCgFWM8NlfHqw0/qy1J8pHvfIvrbqXyz2mFcJcre54XaE5suw3g
         1DFtCS9znS9AJ60jKmxztkOyjdmO/h4DPnL3Wjjh+79lyqV2+sr+2fsT/dkpnMsQRJ
         rhrBOJbMnhzUnEQVs4BwTSKC77zx/PNQ2cnByPCJ9qYbICQVQeZF5skTOiEOqZ0Qd9
         10FvhfckVgvxnr1ahPFNlvU/+YBCGiLS4lqN2bVWnmHGBIF+N1YeQHimUFGUXkNXRt
         PKzYMJUn16UKOL9nd7C8EXAXutKBLFNmEaaNYppbfZJ2w9n8LOSSLlRq70rXOeIMXs
         WiW8gR+Rt6M/w==
Date:   Sat, 24 Sep 2022 17:03:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yuan Can <yuancan@huawei.com>
Cc:     <dan@dlrobertson.com>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: bma400: Switch to use dev_err_probe()
 helper
Message-ID: <20220924170340.1bdf5e84@jic23-huawei>
In-Reply-To: <20220921023915.47300-1-yuancan@huawei.com>
References: <20220921023915.47300-1-yuancan@huawei.com>
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

On Wed, 21 Sep 2022 02:39:15 +0000
Yuan Can <yuancan@huawei.com> wrote:

> In the probe path, dev_err() can be replace with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name.
> 
> Signed-off-by: Yuan Can <yuancan@huawei.com>

@Dan.  whilst reviewing this one I noticed we are turning the power to vddio (which
I assume is the supply for the IO interface) after reading the chip ID. That
doesn't seem right!

Unrelated to this patch beyond I was looking to see if there were other cases
for dev_err_probe() in here.

Applied but it may well not make the next merge window as I'm not sure I'll get
another IIO pull request out before that opens.  Currently Linus has hinted
at a possible rc8 but we will know more on that after he tags rc7 tomorrow.

Jonathan

> ---
>  drivers/iio/accel/bma400_core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index eceb1f8d338d..cebd7e370b09 100644
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
> +		return dev_err_probe(data->dev, ret, "Failed to get regulators: %d\n",
> +				     ret);
>  
> -		return ret;
> -	}
>  	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
>  				    data->regulators);
>  	if (ret) {

