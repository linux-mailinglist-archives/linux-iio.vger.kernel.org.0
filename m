Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078C94E4893
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 22:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbiCVVoe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiCVVo2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 17:44:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520D5F8C2
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 14:42:53 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNQ153Q70z67Zn3;
        Wed, 23 Mar 2022 05:41:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 22 Mar 2022 22:42:50 +0100
Received: from localhost (10.47.75.191) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Mar
 2022 21:42:50 +0000
Date:   Tue, 22 Mar 2022 21:42:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marek Vasut <marex@denx.de>
CC:     <linux-iio@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
        "Daniel Baluta" <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] iio: core: Print error in case sample bits do not
 fit storage bits
Message-ID: <20220322214248.00007194@Huawei.com>
In-Reply-To: <20220322111619.54808-1-marex@denx.de>
References: <20220322111619.54808-1-marex@denx.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.75.191]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Mar 2022 12:16:19 +0100
Marek Vasut <marex@denx.de> wrote:

> Add runtime check to verify whether storagebits are at least as big
> as shifted realbits. This should help spot broken drivers which may
> set realbits + shift above storagebits.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hmm. I was thinking we'd fail the probe if this happens,
though I guess there might be cases where we get away 
(in kernel anyway) with a driver setting this wrong as
many drivers don't use realbits internally in an explicit
fashion, so maybe a message and skipping the channel is
the right choice...

Userspace running against such a description is likely
to generate garbage though unless it's very lucky and
the spill past storage bits is into padding space and
the driver doesn't put anything in there (padding might
contain old data or similar).

Either way it's a definite improvement so I'm probably fine
with the message and not failing the probe, (though will
think a bit more about it before picking this up.)


Jonathan`


> ---
> V2: Use dev_err() instead as WARN_ON() may panic() the kernel on existing machines
> ---
>  drivers/iio/industrialio-buffer.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b078eb2f3c9de..b5670398b06d7 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1629,6 +1629,18 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  			if (channels[i].scan_index < 0)
>  				continue;
>  
> +			/* Verify that sample bits fit into storage */
> +			if (channels[i].scan_type.storagebits <
> +			    channels[i].scan_type.realbits +
> +			    channels[i].scan_type.shift) {
> +				dev_err(&indio_dev->dev,
> +					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
> +					i, channels[i].scan_type.storagebits,
> +					channels[i].scan_type.realbits,
> +					channels[i].scan_type.shift);
> +				continue;
> +			}
> +
>  			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
>  							 &channels[i]);
>  			if (ret < 0)

