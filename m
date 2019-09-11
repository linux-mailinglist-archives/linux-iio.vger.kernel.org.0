Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA93AFCE5
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfIKMhu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 08:37:50 -0400
Received: from first.geanix.com ([116.203.34.67]:52560 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfIKMhu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 08:37:50 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 87857646EF;
        Wed, 11 Sep 2019 12:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568205429; bh=6Tf2EGkA4u56scuPZFARyHyAr76XS/+ReKIY1c5+aZ0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RPC43JEK51YoA/h00gnCe1n2pvU9tzfQxp7VhhkFVy063KiRxOVOq+0Nuah3mDID9
         p5AQj5tZzQSJpaqha/lplHJJhEF4Yaa0KezOrCcQ6fWvk788wjyDxGW/7owa/ozgeX
         bcRYZhKHcKdkFJ+MqY03NZt+M1KvfhpY7AXTRYaj5kEK5mLG+9kg2WrSd7cCHNEN4V
         XAMIIQtjw8dYw0j/F+2IpsF5eEE+OZseIeDSPjxd6z+U7Lb3XMC5Aj9bUiODSosj9y
         G6v/RdSB/8H2lAfWcxgYV5n+hJjNUFeAj5YxmfI7/uzJX5w2AVZnA5N1LAmthpoIeT
         t1IH0iOsvL7VQ==
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: enable LIR for sensor events
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, armando.visconti@st.com, denis.ciocca@st.com
References: <cover.1568184231.git.lorenzo@kernel.org>
 <376b8e64aa95f686e46aa760934cd25d9f47833f.1568184231.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <9e55d2f6-5136-f783-bec6-bae79dbc59d2@geanix.com>
Date:   Wed, 11 Sep 2019 14:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <376b8e64aa95f686e46aa760934cd25d9f47833f.1568184231.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/09/2019 08.50, Lorenzo Bianconi wrote:
> Enable Latched interrupt by default for sensor events
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 35 ++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 5e3cd96b0059..3ea0dc13d101 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -215,6 +215,7 @@ struct st_lsm6dsx_ext_dev_settings {
>    * @fs_table: Hw sensors gain table (gain + val).
>    * @decimator: List of decimator register info (addr + mask).
>    * @batch: List of FIFO batching register info (addr + mask).
> + * @lir: Latched interrupt register info (addr + mask).
>    * @fifo_ops: Sensor hw FIFO parameters.
>    * @ts_settings: Hw timer related settings.
>    * @shub_settings: i2c controller related settings.
> @@ -237,6 +238,7 @@ struct st_lsm6dsx_settings {
>   	struct st_lsm6dsx_fs_table_entry fs_table[2];
>   	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>   	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
> +	struct st_lsm6dsx_reg lir;
>   	struct st_lsm6dsx_fifo_ops fifo_ops;
>   	struct st_lsm6dsx_hw_ts_settings ts_settings;
>   	struct st_lsm6dsx_shub_settings shub_settings;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 2d3495560136..a208da865efe 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -237,6 +237,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   				.mask = GENMASK(5, 3),
>   			},
>   		},
> +		.lir = {
> +			.addr = 0x58,
> +			.mask = BIT(0),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_fifo,
> @@ -349,6 +353,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   				.mask = GENMASK(5, 3),
>   			},
>   		},
> +		.lir = {
> +			.addr = 0x58,
> +			.mask = BIT(0),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_fifo,
> @@ -470,6 +478,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   				.mask = GENMASK(5, 3),
>   			},
>   		},
> +		.lir = {
> +			.addr = 0x58,
> +			.mask = BIT(0),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_fifo,
> @@ -585,6 +597,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   				.mask = GENMASK(7, 4),
>   			},
>   		},
> +		.lir = {
> +			.addr = 0x56,
> +			.mask = BIT(0),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> @@ -715,6 +731,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   				.mask = GENMASK(7, 4),
>   			},
>   		},
> +		.lir = {
> +			.addr = 0x56,
> +			.mask = BIT(0),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> @@ -822,6 +842,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   				.mask = GENMASK(7, 4),
>   			},
>   		},
> +		.lir = {
> +			.addr = 0x56,
> +			.mask = BIT(0),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> @@ -1416,6 +1440,17 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>   	if (err < 0)
>   		return err;
>   
> +	/* enable Latched interrupts for device events */
> +	if (hw->settings->lir.addr) {
> +		unsigned int data;
> +
> +		data = ST_LSM6DSX_SHIFT_VAL(1, hw->settings->lir.mask);
> +		err = regmap_update_bits(hw->regmap, hw->settings->lir.addr,
> +					 hw->settings->lir.mask, data);
> +		if (err < 0)
> +			return err;
> +	}
> +
>   	err = st_lsm6dsx_init_shub(hw);
>   	if (err < 0)
>   		return err;
> 
