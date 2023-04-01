Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77AC6D3260
	for <lists+linux-iio@lfdr.de>; Sat,  1 Apr 2023 17:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDAP1V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Apr 2023 11:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDAP1T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Apr 2023 11:27:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBB64EF2
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 08:27:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B70FB80BA5
        for <linux-iio@vger.kernel.org>; Sat,  1 Apr 2023 15:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF499C433EF;
        Sat,  1 Apr 2023 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680362836;
        bh=Tarl7yn67QNMylbW+AF+741gYMkQH5LT+8vzsrN6c9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CI17/aF277iBpjLv9KMMc+FxDhlieJTHzAECDMmRR/7RG2W5iMy4rVzcKQ7NW9oRC
         ynZBa7OSa7bvsgikKNIpSm6IzexZCSUMd2/7giETaaMlL9V0JuDGtkbYODcZ01XQZC
         GyOgoDOEznkUSlCSy84ywkHbtqT4j+Gg4r78rgNykyopAAavl8g/2S653iz6rVMx7W
         69WNLyQN5aDzJCrHnqeArLGSDOsodVuvYd5SUtOZqIjb0E/Y2+vthw727V5s8fuKdb
         q8CBUjacZqJJcZGpH/M/14wPhEpKX0IlosuqvD17zmSf1JCzgaFEu4isnwRjD3+Pe+
         RxU6RaExME4ug==
Date:   Sat, 1 Apr 2023 16:42:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liang He <windhl@126.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] iio: dac: ad5755: Add missing fwnode_handle_put()
Message-ID: <20230401164224.773a04ad@jic23-huawei>
In-Reply-To: <20230322035627.1856421-1-windhl@126.com>
References: <20230322035627.1856421-1-windhl@126.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Mar 2023 11:56:27 +0800
Liang He <windhl@126.com> wrote:

> In ad5755_parse_fw(), we should add fwnode_handle_put()
> when break out of the iteration device_for_each_child_node()
> as it will automatically increase and decrease the refcounter.
> 
> Fixes: 3ac27afefd5d ("iio:dac:ad5755: Switch to generic firmware properties and drop pdata")
> Signed-off-by: Liang He <windhl@126.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5755.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index beadfa938d2d..404865e35460 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -802,6 +802,7 @@ static struct ad5755_platform_data *ad5755_parse_fw(struct device *dev)
>  	return pdata;
>  
>   error_out:
> +	fwnode_handle_put(pp);
>  	devm_kfree(dev, pdata);
>  	return NULL;
>  }

