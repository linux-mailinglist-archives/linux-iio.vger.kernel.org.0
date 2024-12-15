Return-Path: <linux-iio+bounces-13489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABAB9F23B3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 13:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B91886470
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2929F17E00F;
	Sun, 15 Dec 2024 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML3RFGf/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE69517A58F;
	Sun, 15 Dec 2024 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265562; cv=none; b=qSHhwXhYHE3o4spyCvJ3nf3sOU+93nwuXpNRriE40zgYpKxG+7cFPvufxm4bDgMTwhfyNdJzKA5ETdcmzLF+BO4Ni5ulogJ9+sn6xnZdfCXlMSo3xTdXWqmPQ+kHQ7JUMHnsSrbgbm60v6fk5ebAWNdrX+nsmcn2Y78+w+QU0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265562; c=relaxed/simple;
	bh=hBCBYksFIyNhxJwJxRKXqjB5K6Spf0NiF3kaZ0z6gZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAGkJAl5BtguuT5Lv1Qho0xJIjclfbqK7gxxJKRJkXaDNk7WbC6LTQvARVkFHZslmbt1JDK2ljdnMbNuDYeGmCLxeXCTR63uUcJ9V1nGbSx1lyPZdgG4Av73A6lZRupU7GYqT8RUSM/PTD310KOC85tQujYhbSiU9g4r1QZuYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML3RFGf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D7BC4CECE;
	Sun, 15 Dec 2024 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734265562;
	bh=hBCBYksFIyNhxJwJxRKXqjB5K6Spf0NiF3kaZ0z6gZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ML3RFGf/JgEAFv3dDlzelPXTh2oN4dXEQfUH402JguQABiaZObjU5aFfyZiUtLoqV
	 DPRRG1uz3G5kYdB1x8gswhVywmO0jTSuFfLnumoBhxDlYOthZGNlgkp46e1bvy4N/Y
	 v8Pn8jvfAbgi3iW94Yy6WEw53VnS6dM5xnUWrg8NVXsIDWSysRdQogzrFq6Knd4nqa
	 fo6oZdIT5aY1qYOGqPOXgM3mloRtR73fHMYFBrAvoHnYTdkDvaTyPJypZIyXlWv910
	 jtj8iab7oSEeekrKyZy9HLkgNXGOrJgbewXP0DY6cVwHPfu9lxvLnjUrXRYnvMGlx1
	 QuBq1H9F8Tp7w==
Date: Sun, 15 Dec 2024 12:25:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, yasin.lee.x@outlook.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: hx9023s: Added firmware file parsing
 functionality
Message-ID: <20241215122553.60c2caba@jic23-huawei>
In-Reply-To: <20241210-hx9023s-firmware-20241209-v1-1-8a736691b106@gmail.com>
References: <20241210-hx9023s-firmware-20241209-v1-1-8a736691b106@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 12:24:03 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> Configuration information is now prioritized from the firmware file.
> If the firmware file is missing or fails to parse, the driver falls
> back to using the default configuration list for writing the settings.
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

Ok.  I guess just reading a load of register values isn't hugely different
to more complex firmware loads.

Comments inline - in particular please take the time to tidy up
formatting of your code before posting.

Also why is this +CC linux-hardening, Kees and Gustavo?

They have enough stuff to do without getting patches that seem to have nothing
to do with hardening!

Jonathan

> ---
>  drivers/iio/proximity/hx9023s.c | 96 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 89 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index 4021feb7a7ac..6cb1b688bfa9 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -14,6 +14,7 @@
>  #include <linux/cleanup.h>
>  #include <linux/device.h>
>  #include <linux/errno.h>
> +#include <linux/firmware.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
> @@ -100,6 +101,17 @@
>  #define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
>  #define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
>  
> +#define FW_VER_OFFSET 2
> +#define FW_REG_CNT_OFFSET 3
> +#define FW_DATA_OFFSET 16
> +
> +struct hx9023s_bin {
> +	u16 reg_count;
> +	u16 fw_size;
> +	u8 fw_ver;
> +	u8 data[] __counted_by(fw_size);
> +};
> +
>  struct hx9023s_ch_data {
>  	s16 raw; /* Raw Data*/
>  	s16 lp; /* Low Pass Filter Data*/
> @@ -998,6 +1010,80 @@ static int hx9023s_id_check(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static int hx9023s_bin_load(struct hx9023s_data *data,
> +								struct hx9023s_bin *bin)
> +{
> +	u8 *cfg_start = bin->data + FW_DATA_OFFSET;
> +	u8 addr, val;
> +	u16 i;
> +	int ret;
> +
> +	for (i = 0; i < bin->reg_count; i++) {
> +		addr = cfg_start[i * 2];
> +		val = cfg_start[i * 2 + 1];
> +		ret = regmap_write(data->regmap, addr, val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return ret;
return 0;
Can't get here with anything else.

> +}
> +
> +static int hx9023s_send_cfg(const struct firmware *fw,
> +								struct hx9023s_data *data)


Fix all your indenting to match kernel style.

> +{
> +	if (!fw)

You can't get to this call below with out fw so drop this check.

> +		return -EINVAL;
> +
> +	struct hx9023s_bin *bin __free(kfree) =
> +		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
> +	if (!bin)
> +		return -ENOMEM;
> +
> +	memcpy(bin->data, fw->data, fw->size);
> +	release_firmware(fw);
> +
> +	bin->fw_size = fw->size;
> +	bin->fw_ver = bin->data[FW_VER_OFFSET];
> +	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
> +
> +	return hx9023s_bin_load(data, bin);
> +}
> +
> +static void hx9023s_cfg_update(const struct firmware *fw, void *context)
> +{
> +	struct hx9023s_data *data = context;
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	if (!fw || !fw->data) {
> +		dev_warn(dev, "No firmware\n");
> +		goto no_fw;
> +	}
> +
> +	ret = hx9023s_send_cfg(fw, data);
> +	if (ret)
If this fails, we want to notify the user.  The firmware loaded
but we were unable to use it for some reasons.

> +		goto no_fw;
> +
> +	ret = regcache_sync(data->regmap);
> +	if (ret)
> +		dev_err(dev, "regcache sync failed\n");
> +
> +	return;
> +
> +no_fw:
> +	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
> +								ARRAY_SIZE(hx9023s_reg_init_list));
> +	if (ret) {
> +		dev_err(dev, "Error loading default configuration\n");
> +		return;
> +	}
> +
> +	ret = regcache_sync(data->regmap);
> +	if (ret)
> +		dev_err(dev, "regcache sync failed\n");
> +}
> +
>  static int hx9023s_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -1036,18 +1122,14 @@ static int hx9023s_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	i2c_set_clientdata(client, indio_dev);
>  
> -	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
> -				     ARRAY_SIZE(hx9023s_reg_init_list));
> -	if (ret)
> -		return dev_err_probe(dev, ret, "device init failed\n");
> -
>  	ret = hx9023s_ch_cfg(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "channel config failed\n");
>  
> -	ret = regcache_sync(data->regmap);

> +	ret = request_firmware_nowait(THIS_MODULE, true, "hx9023s.bin",
> +						dev, GFP_KERNEL, data, hx9023s_cfg_update);

Indent dev under T of the THIS_MODULE


>  	if (ret)
> -		return dev_err_probe(dev, ret, "regcache sync failed\n");
> +		return dev_err_probe(dev, ret, "reg config failed\n");
>  
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(dev, client->irq,
> 
> ---
> base-commit: 8d4d26450d71289a35ff9e847675fd9c718798b8
> change-id: 20241209-hx9023s-firmware-20241209-47411e8cda0b
> 
> Best regards,


