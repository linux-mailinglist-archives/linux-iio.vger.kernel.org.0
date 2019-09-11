Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165EFAFCE4
	for <lists+linux-iio@lfdr.de>; Wed, 11 Sep 2019 14:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfIKMhn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Sep 2019 08:37:43 -0400
Received: from first.geanix.com ([116.203.34.67]:52526 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfIKMhn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 08:37:43 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 1FC75646EF;
        Wed, 11 Sep 2019 12:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568205423; bh=akf4bQO8N4W4dfD/MhJdqLksUCuvKz55l+2XDeeOCxI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Z2ZwXax1gRNqP6IGqvVQPK52RN4+qL1bI6R3MkNmm32Pa6R98htWKoDXbGplcMUCJ
         n8tGZvZ6B+ZB9qTlhMGwypMVkbSeCMrjj2wMKIfebeOu5NDTbIr3Lg9cV7ZG2gImyx
         VCFIc2X5EaGgAYh+4eBJsy0ksrpaY+BmwGkxHsUBJM3zeDtjprznkcNYXFBTFJzaly
         sXjzBltBKWI0/mZnjp9JEytBXNaKlc+8VaYvmTrzreMaOaZxOHcARE5BH3dnxSGAhq
         TpaZwIFRIGn7RU5m5akdGalfKZtcTQGFLJgc+pYW0SnY/DrkRLDBJSPgkHXiEGa5Ct
         XRHTX30kP3jGg==
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: enable clear on read for
 latched interrupts
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, armando.visconti@st.com, denis.ciocca@st.com
References: <cover.1568184231.git.lorenzo@kernel.org>
 <d2c9b90f277826a4b3403d44885fff1cd36d9245.1568184231.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d132a857-9bcb-6273-e2bd-95b0c2c87d0e@geanix.com>
Date:   Wed, 11 Sep 2019 14:37:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <d2c9b90f277826a4b3403d44885fff1cd36d9245.1568184231.git.lorenzo@kernel.org>
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
> Enable clear on read feature for latched interrupts. This bit allows
> immediately clearing the latched interrupts of an event detection upon
> the read of the corresponding status register.
> It must be set to 1 together with LIR.
> This feature is available just on LSM6DS0/LSM6DSR/ASM330LHH
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
>   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 ++++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 3ea0dc13d101..fefd9042590a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -216,6 +216,7 @@ struct st_lsm6dsx_ext_dev_settings {
>    * @decimator: List of decimator register info (addr + mask).
>    * @batch: List of FIFO batching register info (addr + mask).
>    * @lir: Latched interrupt register info (addr + mask).
> + * @clear_on_read: Clear on read register info (addr + mask).
>    * @fifo_ops: Sensor hw FIFO parameters.
>    * @ts_settings: Hw timer related settings.
>    * @shub_settings: i2c controller related settings.
> @@ -239,6 +240,7 @@ struct st_lsm6dsx_settings {
>   	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>   	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
>   	struct st_lsm6dsx_reg lir;
> +	struct st_lsm6dsx_reg clear_on_read;
>   	struct st_lsm6dsx_fifo_ops fifo_ops;
>   	struct st_lsm6dsx_hw_ts_settings ts_settings;
>   	struct st_lsm6dsx_shub_settings shub_settings;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index a208da865efe..b65a6ca775e0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -601,6 +601,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   			.addr = 0x56,
>   			.mask = BIT(0),
>   		},
> +		.clear_on_read = {
> +			.addr = 0x56,
> +			.mask = BIT(6),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> @@ -735,6 +739,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   			.addr = 0x56,
>   			.mask = BIT(0),
>   		},
> +		.clear_on_read = {
> +			.addr = 0x56,
> +			.mask = BIT(6),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> @@ -846,6 +854,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>   			.addr = 0x56,
>   			.mask = BIT(0),
>   		},
> +		.clear_on_read = {
> +			.addr = 0x56,
> +			.mask = BIT(6),
> +		},
>   		.fifo_ops = {
>   			.update_fifo = st_lsm6dsx_update_fifo,
>   			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> @@ -1449,6 +1461,18 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>   					 hw->settings->lir.mask, data);
>   		if (err < 0)
>   			return err;
> +
> +		/* enable clear on read for latched interrupts */
> +		if (hw->settings->clear_on_read.addr) {
> +			data = ST_LSM6DSX_SHIFT_VAL(1,
> +					hw->settings->clear_on_read.mask);
> +			err = regmap_update_bits(hw->regmap,
> +					hw->settings->clear_on_read.addr,
> +					hw->settings->clear_on_read.mask,
> +					data);
> +			if (err < 0)
> +				return err;
> +		}
>   	}
>   
>   	err = st_lsm6dsx_init_shub(hw);
> 
