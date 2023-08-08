Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2E773C5F
	for <lists+linux-iio@lfdr.de>; Tue,  8 Aug 2023 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjHHQFA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Aug 2023 12:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjHHQD2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Aug 2023 12:03:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2399196
        for <linux-iio@vger.kernel.org>; Tue,  8 Aug 2023 08:45:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKxKf4R3nz6J75P;
        Tue,  8 Aug 2023 23:04:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 16:07:44 +0100
Date:   Tue, 8 Aug 2023 16:07:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        "Stefan Windfeldt-Prytz" <stefan.windfeldt-prytz@axis.com>
Subject: Re: [PATCH] iio: light: opt4001: Fix a wrong array iteration limit
Message-ID: <20230808160743.00002d91@Huawei.com>
In-Reply-To: <20230807195043.200767-1-jic23@kernel.org>
References: <20230807195043.200767-1-jic23@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  7 Aug 2023 20:50:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> In practice it's unlikely anyone would try to set the integration time
> to 0 which isn't in the available list and if they did then they would
> get index 12 which whilst reserved on the device fits in the field.
> However a compiler might get half way through this reasoning and that
> might be the cause of
> 
> > >> drivers/iio/light/opt4001.c:215:9: error: call to '__compiletime_assert_355' declared with 'error' attribute: FIELD_PREP: value too large for the field  
> >      215 |         reg |= FIELD_PREP(OPT4001_CTRL_CONV_TIME_MASK, chip->int_time);  
> 
> Even if this isn't the cause, it looks like a bug to me.
> 
> Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308061902.0gVz6bSe-lkp@intel.com/
> Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Oops. Clearly half asleep last night. This is garbage so I'm back to the drawing board
on what is causing clang to believe int_time can be bigger than 4 bits.

Any suggestions welcome!

> ---
>  drivers/iio/light/opt4001.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
> index 502946bf9f94..83f978706758 100644
> --- a/drivers/iio/light/opt4001.c
> +++ b/drivers/iio/light/opt4001.c
> @@ -137,7 +137,7 @@ static int opt4001_als_time_to_index(const u32 als_integration_time)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(opt4001_int_time_available); i++) {
> +	for (i = 0; i < ARRAY_SIZE(opt4001_int_time_available) / 2; i++) {
>  		if (als_integration_time == opt4001_int_time_available[i][1])
>  			return i;
>  	}

