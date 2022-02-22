Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEA94BFF18
	for <lists+linux-iio@lfdr.de>; Tue, 22 Feb 2022 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiBVQoB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 22 Feb 2022 11:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiBVQoB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2022 11:44:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B9C7E49
        for <linux-iio@vger.kernel.org>; Tue, 22 Feb 2022 08:43:35 -0800 (PST)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K34j51V9Kz67hFv;
        Wed, 23 Feb 2022 00:42:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 17:43:33 +0100
Received: from localhost (10.47.30.92) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 16:43:32 +0000
Date:   Tue, 22 Feb 2022 16:43:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <haibo.chen@nxp.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <pmeerw@pmeerw.net>, <linux-imx@nxp.com>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] iio: accel: mma8452: remove the reset operation during
 driver probe
Message-ID: <20220222164331.00002d18@Huawei.com>
In-Reply-To: <1645505151-5789-1-git-send-email-haibo.chen@nxp.com>
References: <1645505151-5789-1-git-send-email-haibo.chen@nxp.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.30.92]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
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

On Tue, 22 Feb 2022 12:45:51 +0800
<haibo.chen@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Though Sensor Datasheet define this reset bit in it's CTRL_REG2
> register, but seems the actual hardware behavior do not align with
> the doc expect. Once the reset bit is set, sensor can’t give back
> an I2C ack, which will cause the probe fail. So just remove this
> reset operation.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Hi Haibo,

I'm not really that keen to remove reset on probe as it's normally
a good way to ensure we get a device into a sane state as we have no
idea what has run before we load the driver.

Wolfram is there a standard way to work around missing ACK in cases
like this?  Would just ignoring the return value be fine or are their
i2c masters that will get stuck if they don't get the expected ack?

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 0016bb947c10..ec9e26fdfb2a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1481,30 +1481,6 @@ static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)
>  		iio_trigger_unregister(indio_dev->trig);
>  }
>  
> -static int mma8452_reset(struct i2c_client *client)
> -{
> -	int i;
> -	int ret;
> -
> -	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
> -					MMA8452_CTRL_REG2_RST);
> -	if (ret < 0)
> -		return ret;
> -
> -	for (i = 0; i < 10; i++) {
> -		usleep_range(100, 200);
> -		ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG2);
> -		if (ret == -EIO)
> -			continue; /* I2C comm reset */
> -		if (ret < 0)
> -			return ret;
> -		if (!(ret & MMA8452_CTRL_REG2_RST))
> -			return 0;
> -	}
> -
> -	return -ETIMEDOUT;
> -}
> -
>  static const struct of_device_id mma8452_dt_ids[] = {
>  	{ .compatible = "fsl,mma8451", .data = &mma_chip_info_table[mma8451] },
>  	{ .compatible = "fsl,mma8452", .data = &mma_chip_info_table[mma8452] },
> @@ -1591,10 +1567,6 @@ static int mma8452_probe(struct i2c_client *client,
>  	indio_dev->num_channels = data->chip_info->num_channels;
>  	indio_dev->available_scan_masks = mma8452_scan_masks;
>  
> -	ret = mma8452_reset(client);
> -	if (ret < 0)
> -		goto disable_regulators;
> -
>  	data->data_cfg = MMA8452_DATA_CFG_FS_2G;
>  	ret = i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
>  					data->data_cfg);

