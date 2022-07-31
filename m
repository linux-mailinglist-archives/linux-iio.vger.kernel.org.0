Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FB1585EB5
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jul 2022 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGaLrp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jul 2022 07:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiGaLro (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Jul 2022 07:47:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200910579;
        Sun, 31 Jul 2022 04:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0345B80B20;
        Sun, 31 Jul 2022 11:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AADC433C1;
        Sun, 31 Jul 2022 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659268060;
        bh=YOuvINDrMEu+uQVE4RQ1m3SGEuyLvk7r7BH2c8nML30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=caRjgR9wNJpCoR/y+rTm3GVX+Dm2tiVmjayQpS5KqVk4nbvSiJBBNyXRhcPl9CoBo
         e7oi6Kg+daXnARshdp64/zk0Bz+Diw+LaURYkHCHoF6gLuQUUFQzOMVIlG/uoMCnUw
         uFx25r9LNLwLKvNTKW4WcGuYl0hFIbsN/5KolfydSyZkOL19j2i7iekqGg6TU+FCw7
         Z5kL5TYC0EMda5LIrCBluqmb4ls+QmlGv9V13vyViExUqWbDMNELv1KHWlEsVzBlbG
         HW4mj092pz0wV+0B/RvhSYtb+X4MO0vfaffDS1MU2v3Rm7ZwczrRDXcf39WsuQoiGi
         ZRuZOSYSxxgEg==
Date:   Sun, 31 Jul 2022 12:57:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        Rishi Gupta <gupt21@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] HID: mcp2221: add ADC/DAC support via iio subsystem
Message-ID: <20220731125752.3e6b1919@jic23-huawei>
In-Reply-To: <20220729154723.99947-1-matt.ranostay@konsulko.com>
References: <20220729154723.99947-1-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 29 Jul 2022 23:47:23 +0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add support for 3x 10-bit ADC and 1x DAC channels registered via
> the iio subsystem.
> 
> To prevent breakage and unexpected dependencies this support only is
> only built if CONFIG_IIO is enabled, and is only weakly referenced by
> 'imply IIO' within the respective Kconfig.

Seems ok, but I've not seen this done before, so will rely on others
to feedback on that element.

Otherwise, various comments inline.

> 
> Additionally the iio device only gets registered if at least one channel
> is enabled in the power-on configuration read from SRAM.
> 
> Cc: Rishi Gupta <gupt21@gmail.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/hid/Kconfig       |   3 +-
>  drivers/hid/hid-mcp2221.c | 207 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 209 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 6ce92830b5d1..eb4f4bb05226 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1298,7 +1298,8 @@ config HID_ALPS
>  config HID_MCP2221
>  	tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
>  	depends on USB_HID && I2C
> -	depends on GPIOLIB
> +	select GPIOLIB
> +	imply IIO
>  	help
>  	Provides I2C and SMBUS host adapter functionality over USB-HID
>  	through MCP2221 device.
> diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
> index de52e9f7bb8c..ab8ca2a65592 100644
> --- a/drivers/hid/hid-mcp2221.c
> +++ b/drivers/hid/hid-mcp2221.c
> @@ -16,6 +16,8 @@
>  #include <linux/hidraw.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

I can't immediately see why you need iio/sysfs.h
That's normally only relevant if non standard ABI is in use.

>  #include "hid-ids.h"
>  
>  /* Commands codes in a raw output report */
> @@ -30,6 +32,8 @@ enum {
>  	MCP2221_I2C_CANCEL = 0x10,
>  	MCP2221_GPIO_SET = 0x50,
>  	MCP2221_GPIO_GET = 0x51,
> +	MCP2221_SET_SRAM_SETTINGS = 0x60,
> +	MCP2221_GET_SRAM_SETTINGS = 0x61,
>  };
>  
>  /* Response codes in a raw input report */
> @@ -89,6 +93,7 @@ struct mcp2221 {
>  	struct i2c_adapter adapter;
>  	struct mutex lock;
>  	struct completion wait_in_report;
> +	struct delayed_work init_work;
>  	u8 *rxbuf;
>  	u8 txbuf[64];
>  	int rxbuf_idx;
> @@ -97,6 +102,17 @@ struct mcp2221 {
>  	struct gpio_chip *gc;
>  	u8 gp_idx;
>  	u8 gpio_dir;
> +	u8 mode[4];
> +#if IS_REACHABLE(CONFIG_IIO)
> +	struct iio_chan_spec iio_channels[3];
> +	struct iio_dev *indio_dev;
> +	u16 adc_values[3];
> +	u8 dac_value;
> +#endif
> +};
> +
> +struct mcp2221_iio {
> +	struct mcp2221 *mcp;
>  };
>  
>  /*
> @@ -745,6 +761,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  				break;
>  			}
>  			mcp->status = mcp_get_i2c_eng_state(mcp, data, 8);
> +#if IS_REACHABLE(CONFIG_IIO)
> +			if (mcp->indio_dev)
> +				memcpy(&mcp->adc_values, &data[50], 6);
> +#endif
>  			break;
>  		default:
>  			mcp->status = -EIO;
> @@ -816,6 +836,32 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  		complete(&mcp->wait_in_report);
>  		break;
>  
> +	case MCP2221_SET_SRAM_SETTINGS:
> +		switch (data[1]) {
> +		case MCP2221_SUCCESS:
> +			mcp->status = 0;
> +			break;
> +		default:
> +			mcp->status = -EAGAIN;
> +		}
> +		complete(&mcp->wait_in_report);
> +		break;
> +
> +	case MCP2221_GET_SRAM_SETTINGS:
> +		switch (data[1]) {
> +		case MCP2221_SUCCESS:
> +			memcpy(&mcp->mode, &data[22], 4);
> +#if IS_REACHABLE(CONFIG_IIO)
> +			mcp->dac_value = data[6] & GENMASK(4, 0);
Might be worth converting to more readable mask define and
FIELD_GET()

> +#endif
> +			mcp->status = 0;
> +			break;
> +		default:
> +			mcp->status = -EAGAIN;
> +		}
> +		complete(&mcp->wait_in_report);
> +		break;
> +
>  	default:
>  		mcp->status = -EIO;
>  		complete(&mcp->wait_in_report);
> @@ -824,6 +870,158 @@ static int mcp2221_raw_event(struct hid_device *hdev,
>  	return 1;
>  }
>  
> +#if IS_REACHABLE(CONFIG_IIO)
> +static int mcp2221_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +
No blank line here
> +	struct mcp2221_iio *priv = iio_priv(indio_dev);
> +	struct mcp2221 *mcp = priv->mcp;
> +	int ret;
> +
> +	mutex_lock(&mcp->lock);
For readability I'd prefer this duplicated in each of the
branches so clearly matched against the unlocks.

> +
> +	if (channel->output) {
> +		*val = mcp->dac_value;
> +
> +		mutex_unlock(&mcp->lock);
> +	} else {
> +		// Read ADC values
As below.

> +		ret = mcp_chk_last_cmd_status(mcp);
> +		if (ret < 0) {
> +			mutex_unlock(&mcp->lock);
> +			return ret;
> +		}
> +
> +		*val = le16_to_cpu(mcp->adc_values[channel->address]);
> +
> +		mutex_unlock(&mcp->lock);
> +
> +		// Confirm value is within 10-bit range
> +		if (*val > GENMASK(9, 0))
> +			return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int mcp2221_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp2221_iio *priv = iio_priv(indio_dev);
> +	struct mcp2221 *mcp = priv->mcp;
> +	int ret;
> +
> +	if (val < 0 || val > GENMASK(4, 0))
This is a bit wierd.  I'd either expect comparison with a number
rather than a mask, or FIELD_FIT()


> +		return -EINVAL;
> +
Single blank line is enough.
> +
> +	hid_hw_power(mcp->hdev, PM_HINT_FULLON);
> +
> +	mutex_lock(&mcp->lock);
> +
> +	memset(mcp->txbuf, 0, 12);
> +	mcp->txbuf[0] = MCP2221_SET_SRAM_SETTINGS;
> +	mcp->txbuf[4] = BIT(7) | val;

Given GENMASK usage above, FIELD_PREP() would make this
more 'self documenting' both for the val and BIT(7)

> +
> +	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 12);
> +
> +	hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
> +
> +	if (ret) {
> +		mutex_unlock(&mcp->lock);
> +		return -EINVAL;
> +	}
> +
> +	mcp->dac_value = val;
> +
> +	mutex_unlock(&mcp->lock);
> +
> +	return 0;
> +}
> +
> +static const struct iio_info mcp2221_info = {
> +	.read_raw = &mcp2221_read_raw,
> +	.write_raw = &mcp2221_write_raw,
> +};
> +
> +static int mcp_iio_channels(struct mcp2221 *mcp)
> +{
> +	int idx, cnt = 0;
> +	bool dac_created = false;
> +
> +	// GP0 doesn't have ADC/DAC alternative function

Not consistent with comment style in this driver. /* ... */

> +	for (idx = 1; idx < MCP_NGPIO; idx++) {
> +		struct iio_chan_spec *chan = &mcp->iio_channels[cnt];
> +
> +		switch (mcp->mode[idx]) {
> +		case 2:
> +			chan->address = idx - 1;
> +			chan->channel = cnt++;
> +			break;
> +		case 3:
> +			// GP1 doesn't have DAC alternative function

As above.

> +			if (idx == 1 || dac_created)
> +				continue;
> +			// DAC1 and DAC2 outputs are connected to the same DAC
> +			dac_created = true;
> +			chan->output = 1;
> +			cnt++;
> +			break;
> +		default:
> +			continue;
> +		};
> +
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		chan->scan_index = -1;
> +	}
> +
> +	return cnt;
> +}
> +
> +static void mcp_init_work(struct work_struct *work)
> +{
> +	struct mcp2221 *mcp = container_of(work, struct mcp2221, init_work.work);
> +	struct mcp2221_iio *iio;
> +	int ret, num_channels;
> +
> +	hid_hw_power(mcp->hdev, PM_HINT_FULLON);
> +
> +	mutex_lock(&mcp->lock);
> +
> +	mcp->txbuf[0] = MCP2221_GET_SRAM_SETTINGS;
> +
> +	ret = mcp_send_data_req_status(mcp, mcp->txbuf, 1);
> +
> +	hid_hw_power(mcp->hdev, PM_HINT_NORMAL);
> +	mutex_unlock(&mcp->lock);
> +
> +	if (ret)
> +		return;
> +
> +	num_channels = mcp_iio_channels(mcp);
> +	if (!num_channels)
> +		return;
> +
> +	mcp->indio_dev = devm_iio_device_alloc(&mcp->hdev->dev, sizeof(*iio));
This can fail.
> +
> +	iio = iio_priv(mcp->indio_dev);
> +	iio->mcp = mcp;
> +
> +	mcp->indio_dev->name = "mcp2221";
> +	mcp->indio_dev->modes = INDIO_DIRECT_MODE;
> +	mcp->indio_dev->info = &mcp2221_info;
> +	mcp->indio_dev->channels = mcp->iio_channels;
> +	mcp->indio_dev->num_channels = num_channels;
> +
> +	iio_device_register(mcp->indio_dev);
As can this.  You need to check both.

> +}
> +#endif
> +
>  static int mcp2221_probe(struct hid_device *hdev,
>  					const struct hid_device_id *id)
>  {
> @@ -902,6 +1100,11 @@ static int mcp2221_probe(struct hid_device *hdev,
>  	if (ret)
>  		goto err_gc;
>  
> +#if IS_REACHABLE(CONFIG_IIO)
> +	INIT_DELAYED_WORK(&mcp->init_work, mcp_init_work);
> +	schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(500));
> +#endif
> +
>  	return 0;
>  
>  err_gc:
> @@ -920,6 +1123,10 @@ static void mcp2221_remove(struct hid_device *hdev)
>  	i2c_del_adapter(&mcp->adapter);
>  	hid_hw_close(mcp->hdev);
>  	hid_hw_stop(mcp->hdev);
> +#if IS_REACHABLE(CONFIG_IIO)
> +	if (mcp->indio_dev)
> +		iio_device_unregister(mcp->indio_dev);
> +#endif
I'd expect remove to be reverse order of probe. Mind you this driver has a fun
mix of devm and non devm which makes it very hard to reason about correctness
and potential race conditions.  I would personally advocate preceding this
patch with a cleanup of that side of things (probably mass usage of devm_add_action_or_reset()
and appropriate callbacks).

Jonathan

>  }
>  
>  static const struct hid_device_id mcp2221_devices[] = {

