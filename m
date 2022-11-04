Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82B619C32
	for <lists+linux-iio@lfdr.de>; Fri,  4 Nov 2022 16:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKDPy4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Nov 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDPyz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2022 11:54:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A792C2F037
        for <linux-iio@vger.kernel.org>; Fri,  4 Nov 2022 08:54:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A4Fs1mw021956;
        Fri, 4 Nov 2022 10:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667577241;
        bh=0e5rbAy5K6kiagwWXZQl/am0wFzyeNhfF9nH14uyePc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jmGnDQs1lp7YIziIIqmr4SLV0J4XOxpC2c9CxrIErVvFjh0wZidUzo2iSMgPAIM4O
         dfMnwC19eBhNj5i4JJfm8/iv6hSS1Txeld5Fo+CvSj5VJZGpUGb0OglOQ6aOL77CMl
         ckMaGMQEPdKOWFZe0PjnV8THwnqGiNOgbEPXHZYo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A4Fs1VQ094632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Nov 2022 10:54:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 4 Nov
 2022 10:54:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 4 Nov 2022 10:54:00 -0500
Received: from [10.250.38.44] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A4Fs0jD003996;
        Fri, 4 Nov 2022 10:54:00 -0500
Message-ID: <b2bf65e1-439b-3a4f-7e01-b2f211680270@ti.com>
Date:   Fri, 4 Nov 2022 10:53:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iio: health: afe4403: Fix oob read in afe4403_read_raw
Content-Language: en-US
To:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-iio@vger.kernel.org>
References: <20221104112808.346719-1-weiyongjun@huaweicloud.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20221104112808.346719-1-weiyongjun@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/4/22 6:28 AM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> KASAN report out-of-bounds read as follows:
> 
> BUG: KASAN: global-out-of-bounds in afe4403_read_raw+0x42e/0x4c0 [afe4403]
> Read of size 4 at addr ffffffffc02ac638 by task cat/279
> 
> CPU: 2 PID: 279 Comm: cat Tainted: G                 N
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <TASK>
>   afe4403_read_raw+0x42e/0x4c0 [afe4403 141d77410f5466ef049ee2376f5136b77a168de0]
>   iio_read_channel_info+0x249/0x2e0 [industrialio d0627df60a92bbb9630e68c3e2f98d20dac889ef]
>   dev_attr_show+0x4b/0xa0 drivers/base/core.c:2195
>   sysfs_kf_seq_show+0x1ec/0x390 fs/sysfs/file.c:59
>   seq_read_iter+0x48d/0x10b0 fs/seq_file.c:230
>   kernfs_fop_read_iter+0x4e6/0x710 fs/kernfs/file.c:275
>   call_read_iter include/linux/fs.h:2153 [inline]
>   new_sync_read fs/read_write.c:389 [inline]
>   vfs_read+0x5f2/0x890 fs/read_write.c:470
>   ksys_read+0x106/0x220 fs/read_write.c:613
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x38/0xa0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fd8611cf992
>   </TASK>
> 
> The buggy address belongs to the variable:
>   afe4403_channel_leds+0x18/0xffffffffffffe9e0 [afe4403]
> 
> This issue can be reproduced by singe command:
> 
>   $ cat /sys/bus/spi/devices/spi0.0/iio\:device0/in_intensity6_raw
> 
> The array size of afe4403_channel_leds is less than channels, so access
> with chan->address cause OOB read in afe4403_read_raw. Fix it by moving
> access before use it.
> 
> Fixes: b36e8257641a ("iio: health/afe440x: Use regmap fields")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>   drivers/iio/health/afe4403.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 3bb4028c5d74..14213a48e349 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -246,7 +246,7 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
>   {
>   	struct afe4403_data *afe = iio_priv(indio_dev);
>   	unsigned int reg = afe4403_channel_values[chan->address];

Good find and the fix does look valid, but can we also move this
access for 'reg' to right before we use it also? Just for consistency.

Same for the 'afe4403_channel_leds' access below in afe4403_write_raw(),
and same for value_reg in your patch for afe4404. Then both patches can have:

Acked-by: Andrew Davis <afd@ti.com>

> -	unsigned int field = afe4403_channel_leds[chan->address];
> +	unsigned int field;
>   	int ret;
>   
>   	switch (chan->type) {
> @@ -262,6 +262,7 @@ static int afe4403_read_raw(struct iio_dev *indio_dev,
>   	case IIO_CURRENT:
>   		switch (mask) {
>   		case IIO_CHAN_INFO_RAW:
> +			field = afe4403_channel_leds[chan->address];
>   			ret = regmap_field_read(afe->fields[field], val);
>   			if (ret)
>   				return ret;
