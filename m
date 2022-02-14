Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0454B4E24
	for <lists+linux-iio@lfdr.de>; Mon, 14 Feb 2022 12:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiBNLVp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Feb 2022 06:21:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351186AbiBNLU7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Feb 2022 06:20:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A97C7C7A7
        for <linux-iio@vger.kernel.org>; Mon, 14 Feb 2022 02:55:00 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jy1GN4Vqnz6802N;
        Mon, 14 Feb 2022 18:50:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 11:54:58 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 10:54:57 +0000
Date:   Mon, 14 Feb 2022 10:54:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: mma8452: Fix 'mma8452_dt_ids' defined but not used
 compiler warning
Message-ID: <20220214105456.00002177@Huawei.com>
In-Reply-To: <20220214091850.44139-1-hdegoede@redhat.com>
References: <20220214091850.44139-1-hdegoede@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Feb 2022 10:18:50 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Commit 90adc57bd55a ("iio: mma8452: Fix probe failing when an
> i2c_device_id is used") introduces a new: "'mma8452_dt_ids' defined
> but not used" compiler warning.
> 
> This is caused by the switch from of_match_device() (which takes a
> pointer to this) to device_get_match_data(), combined with the use of
> of_match_ptr() when setting of_match_table.
> 
> We actually want mma8452_dt_ids to get optmized away when CONFIG_OF is
> not set, so mark it as __maybe_unused to silence the warning.
> 
> Fixes: 90adc57bd55a ("iio: mma8452: Fix probe failing when an i2c_device_id is used")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

For this I'd rather drop the of_match_ptr() protection.

We will need to do that anyway shortly as part of converting this
to fully device properties and allowing ACPI PRP0001 which uses
the of_match_table from ACPI.

We can now easily make that transition as (via Andy)
https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git/commit/?h=i2c/alert-for-acpi&id=ca0acb511c21738b32386ce0f85c284b351d919e

Anyhow, I can just fix it up on the original patch once I'm on the
right computer.  I might also post patches to get rid
of the of dependency completely if no one else gets there
before me.

Thanks,

Jonathan


> ---
> Note the 90adc57bd55a hash is from the jic23/iio.git testing branch, not
> sure of it is stable. It is probably best to just squash this into the
> original commit.
> ---
>  drivers/iio/accel/mma8452.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 590d9431e1bd..1324bd515377 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1529,7 +1529,7 @@ static int mma8452_reset(struct i2c_client *client)
>  	return -ETIMEDOUT;
>  }
>  
> -static const struct of_device_id mma8452_dt_ids[] = {
> +static const struct of_device_id __maybe_unused mma8452_dt_ids[] = {
>  	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
>  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
>  	{ .compatible = "fsl,mma8453", .data = &mma_chip_info_table[mma8453] },

