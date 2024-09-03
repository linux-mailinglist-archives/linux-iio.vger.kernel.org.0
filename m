Return-Path: <linux-iio+bounces-9065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CFD9696D7
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 10:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D621283500
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01CE20FAB1;
	Tue,  3 Sep 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Xfo2D7uw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877F200133
	for <linux-iio@vger.kernel.org>; Tue,  3 Sep 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351530; cv=none; b=U1oDRl5W27aIxBcOEH7R0IW1t5sOWpk/G60el6ktnU4FDwEJYcBprFQDN33QbV2VWecDT0T2qviKoFJe8tRmr9bVrkPIqxZfkRHnB9JajJ+oyIheuLIbVFo9i/4sNKcC3QNuQN+gFdqg7rOui6u2pHMEwJmrFSV9ohbXM8lFbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351530; c=relaxed/simple;
	bh=OkWCxwzIGJRHZ17496M6MZKBIn/PO3d9NEbjjLrGJI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGM/xTqOBpoxiJazRzXitzoiaBxDWmWi3pihVvOaKdA3ja0jc9vfPBh0gVfbb4NfVFJ3E8Y9NY+X57Ip+pkOd2dhG3ubnI+aT+MdL98lf/X+Z/rCGInyilfF7c2iaAqZErI7ux13OgfUwXrLyfqbNhCtf98u2u5PTAvdlUx33RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Xfo2D7uw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371ba7e46easo3378779f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Sep 2024 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725351525; x=1725956325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJFmOqpgT/yiN0OE5Ri1vW3ZQd/CDj4sEGVnSDpyRy0=;
        b=Xfo2D7uwU2MZCr0flPN3sgpyopRCGKnPJjlbA7Rc4MYZ6zRQH9pOD21EHT6ygrHq8u
         3EwRlpAk5+FcB8CZHPw5khU+07MhUT5CECOvUBeNS5f2QB3ix+1ugB1lq9mcEBvqhFsY
         tFE1FvqJ3sP6tWRxv/RHdyXo8Vnoh9sttbOkJ81BV9jQozTWf967g6VDOa7mL778UIU2
         58PRH/BHAeu0xgEWMbLygYMw7shcc2QOZ0BR/NBXtJLlv8WRmA8EbtkLL6sCAqSNCxdS
         I6Ruubge7WjnTgaJjFFBbKPNuBJjN7+j+XZWCr1m+TcChnNszAcXYxQQBhsQG/P0RS8m
         H2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351525; x=1725956325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJFmOqpgT/yiN0OE5Ri1vW3ZQd/CDj4sEGVnSDpyRy0=;
        b=gtln71r3PAWU0B+bDSvo0PDlrN6ZsXH/jwoNV3Cmt0e8gvogtIY4vCWXq9410Z5lO+
         5laqWRCa8Nxc8L9QHOFN0uLfz763OnWJklSopamc6ZLxgnsZ2BcwaINQtJW6dlZrHqlb
         fsvSpdizZNtb2VOUa5u3W4a0dUl/BUkN3i3NWb+M2dRbpnJ3KLbrmVjuAaYQOzFE+hSP
         fpDq6lQacNHNdIve9K4E/4nGQ9t5KbUric58x2U6sYOPKvPu82m7thTsnh+Q+tPsKYfA
         wNOAgSQCZkPbj9rhqAGWIcHIQXIK8fQESxVgu3TnDbF/Nua1xoo64pVVl7tQ3YgRlvUE
         c+kg==
X-Forwarded-Encrypted: i=1; AJvYcCXN8CZjb2azlVVYNrclYkMVXh+1BVWX6w7Pb/UJ+bBM6KzO1iDcXZsllBxn/pT/rOJZaczrwGCBoaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmYVSSWF7sFrZuM0RnI0unUCmIrXWCdDG0fatnm4LNd8DMmAN
	ZncXo/Vh0PfL8hJZk9ufwQH/ciAe5xuwo8Co/wL8Y3IpTXFX3swsHf77GVzg+bAWhDyiIAzsWyQ
	i
X-Google-Smtp-Source: AGHT+IEFdJRtBDTYMr1I8gMiNbVs9yjZDfuwUwHmxUiLM/+WnnQYSWWklbBHYn8eYxSyoTGWCbOh9w==
X-Received: by 2002:a05:6000:118e:b0:371:87d1:4248 with SMTP id ffacd0b85a97d-374bceb5565mr7140308f8f.29.1725351524692;
        Tue, 03 Sep 2024 01:18:44 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c71140bbsm6319796f8f.110.2024.09.03.01.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 01:18:43 -0700 (PDT)
Message-ID: <421d7967-e9e4-4207-a9de-db309ea482b0@baylibre.com>
Date: Tue, 3 Sep 2024 10:17:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 7/8] iio: dac: ad3552r: add axi platform driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-7-b6da6015327a@baylibre.com>
 <20240831131322.494119f3@jic23-huawei>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240831131322.494119f3@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan,

On 31/08/24 2:13 PM, Jonathan Cameron wrote:
> On Thu, 29 Aug 2024 14:32:05 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>
>> From: Angelo Dureghello <adureghello@baylibre.com>
>>
>> Add support for ad3552r AXI DAC IP version.
>>
>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Hi Angelo
>
> To me this feels like the interface is much closer to SPI + SPI offload
> than to a conventional IIO backend on the basis it carries the configuration
> path as well.
>
> Can we see if it can be fitted into that model?  You will need to define
> a new bus type etc for it but should be fairly simple given constrained
> setup (at least today!)
>
> That will resolve a bunch of questions around the binding as well.

thanks for all the feedbacks.

I see, spi offload may have more sense but as of now looks like moving to
AXI SPI engine instead of AXI DAC would require quite a lot of work from the
ADI HDL guys and also then, for me some work reworking all this stuff.
 From an initial discussion with Nuno and David, we was oriented to use the
iio backend for the current HDL, so at least for this chip at this stage 
would
be good, if possible, to stay this way.


> Jonathan
>
>> diff --git a/drivers/iio/dac/ad3552r-axi.c b/drivers/iio/dac/ad3552r-axi.c
>> new file mode 100644
>> index 000000000000..98e5da08c973
>> --- /dev/null
>> +++ b/drivers/iio/dac/ad3552r-axi.c
>> @@ -0,0 +1,572 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Analog Devices AD3552R
>> + * Digital to Analog converter driver, AXI DAC backend version
>> + *
>> + * Copyright 2024 Analog Devices Inc.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/backend.h>
>> +#include <linux/of.h>
> Why?  Probably want mod_devicetable.h


with mod_devicetable.h in place of of.h i get

drivers/iio/dac/ad3552r-axi.c:272:9: error: cleanup argument not a function
   struct fwnode_handle *child __free(fwnode_handle) = NULL;
          ^~~~~~~~~~~~~


>> +#include <linux/platform_device.h>
>> +#include <linux/units.h>
>
>> +static int ad3552r_axi_update_scan_mode(struct iio_dev *indio_dev,
>> +					const unsigned long *active_scan_mask)
>> +{
>> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
>> +
>> +	st->active_scan_mask = *active_scan_mask;
> We probably want another accessor for this, but for now that variable
> can still be read from iio_dev->active_scan_mask so no need
> for the copy here (and hence no need for this callback).
thanks a lot, removed the accessor, not needed
>> +
>> +	return 0;
>> +}
>> +
>> +static int ad3552r_axi_buffer_postenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
>> +	struct iio_backend_data_fmt fmt = {
>> +		.type = IIO_BACKEND_DATA_UNSIGNED
>> +	};
>> +	int loop_len, val, err;
>> +
>> +	/* Inform DAC chip to switch into DDR mode */
>> +	err = axi3552r_qspi_update_reg_bits(st->back,
>> +					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
>> +					    AD3552R_MASK_SPI_CONFIG_DDR,
>> +					    AD3552R_MASK_SPI_CONFIG_DDR, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Inform DAC IP to go for DDR mode from now on */
>> +	err = iio_backend_ddr_enable(st->back);
>> +	if (err)
>> +		goto exit_err;
>> +
>> +	switch (st->active_scan_mask) {
>> +	case AD3552R_CH0_ACTIVE:
>> +		st->single_channel = true;
>> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;
>> +		val = AD3552R_REG_ADDR_CH_DAC_16B(0);
>> +		break;
>> +	case AD3552R_CH1_ACTIVE:
>> +		st->single_channel = true;
>> +		loop_len = AD3552R_STREAM_2BYTE_LOOP;
>> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
>> +		break;
>> +	case AD3552R_CH0_CH1_ACTIVE:
>> +		st->single_channel = false;
>> +		loop_len = AD3552R_STREAM_4BYTE_LOOP;
>> +		val = AD3552R_REG_ADDR_CH_DAC_16B(1);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
>> +					&loop_len, 1);
>> +	if (err)
>> +		goto exit_err;
>> +
>> +	iio_backend_data_transfer_addr(st->back, val);
> err = ?
thanks, fixed.
>> +	if (err)
>> +		goto exit_err;
>> +	/*
>> +	 * The EXT_SYNC is mandatory in the CN0585 project where 2 instances
>> +	 * of the IP are in the design and they need to generate the signals
>> +	 * synchronized.
>> +	 *
>> +	 * Note: in first IP implementations CONFIG EXT_SYNC (RO) can be 0,
>> +	 * but EXT_SYMC is anabled anyway.
>> +	 */
>> +
>> +	if (st->synced_transfer == AD3552R_EXT_SYNC_ARM)
>> +		err = iio_backend_ext_sync_enable(st->back);
>> +	else
>> +		err = iio_backend_ext_sync_disable(st->back);
>> +	if (err)
>> +		goto exit_err_sync;
>> +
>> +	err = iio_backend_data_format_set(st->back, 0, &fmt);
>> +	if (err)
>> +		goto exit_err;
>> +
>> +	err =  iio_backend_buffer_enable(st->back);
>> +	if (!err)
>> +		return 0;
> Keep the good path inline as that's more idiomatic and what a reviewers
> eyes expect to see.
>
> 	if (err)
> 		goto exit_err_sync;
>
> 	return 0;
ok, fixed
>> +
>> +exit_err_sync:
>> +	iio_backend_ext_sync_disable(st->back);
>> +
>> +exit_err:
>> +	axi3552r_qspi_update_reg_bits(st->back,
>> +				      AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
>> +				      AD3552R_MASK_SPI_CONFIG_DDR,
>> +				      0, 1);
>> +
>> +	iio_backend_ddr_disable(st->back);
>> +
>> +	return err;
>> +}
>> +
>> +static int ad3552r_axi_buffer_predisable(struct iio_dev *indio_dev)
>> +{
>> +	struct ad3552r_axi_state *st = iio_priv(indio_dev);
>> +	int err;
>> +
>> +	err = iio_backend_buffer_disable(st->back);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Inform DAC to set in DDR mode */
> You set the DAC to ddr mode whilst disabling it? That seems backwards.
Thanks, wrong comment, i am setting back to SDR here, comment fixed.
>> +	err = axi3552r_qspi_update_reg_bits(st->back,
>> +					    AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
>> +					    AD3552R_MASK_SPI_CONFIG_DDR,
>> +					    0, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	return iio_backend_ddr_disable(st->back);
>> +}
>> +
>> +
>> +static int ad3552r_axi_reset(struct ad3552r_axi_state *st)
>> +{
>> +	int err;
>> +
>> +	/* AXI reset performed by backend enable() */
> This comment is confusing given it's in a function called
> axi_reset and you don't do the backend enable() here.
> So how is this resetting the AXI bus (or is that name
> referring to the fpga IP?)

Ok, i removed the comment.

Actually, the IP reset is performed by the backend "enable"
while this function resets the target chip.

>
>> +
>> +	st->reset_gpio = devm_gpiod_get_optional(st->dev,
>> +						 "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(st->reset_gpio))
>> +		return PTR_ERR(st->reset_gpio);
>> +
>> +	if (st->reset_gpio) {
>> +		gpiod_set_value_cansleep(st->reset_gpio, 1);
>> +		fsleep(10);
>> +		gpiod_set_value_cansleep(st->reset_gpio, 0);
>> +	} else {
>> +		err = axi3552r_qspi_update_reg_bits(st->back,
>> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
>> +					AD3552R_MASK_SOFTWARE_RESET,
>> +					AD3552R_MASK_SOFTWARE_RESET, 1);
>> +		if (err)
>> +			return err;
>> +	}
>> +	msleep(100);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ad3552r_axi_setup(struct ad3552r_axi_state *st)
>> +{
>> +	struct fwnode_handle *child __free(fwnode_handle) = NULL;
>> +	u8 gs_p, gs_n;
>> +	s16 goffs;
>> +	u16 id, rfb, reg = 0, offset = 0;
> Generally don't mix assignment and non assignment stuff on online.
> Fine to have them all not assigned or all assigned, but a mix
> tends to lead to people missing one in the middle that is
> different.
>
> 	u16 id, rfb,
> 	u16 reg = 0, offset = 0;
Ok, done.
>
>> +	u32 val, range;
>> +	int err;
>> +
>> +	err = ad3552r_axi_reset(st);
>> +	if (err)
>> +		return err;
>> +
>> +	err = iio_backend_ddr_disable(st->back);
>> +	if (err)
>> +		return err;
>> +
>> +	val = AD3552R_SCRATCH_PAD_TEST_VAL1;
>> +	err = iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
>> +					&val, 1);
> as per earlier review, I'd pass an unsigned int instead of a void *
> Then you can avoid the dance with a local variable.
void * was chosen thinking to future busses, please let me know if
it can stay this way.
>> +	if (err)
>> +		return err;
>> +
>> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
>> +				       &val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL1) {
>> +		dev_err(st->dev,
>> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
>> +			AD3552R_SCRATCH_PAD_TEST_VAL1, val);
>> +		return -EIO;
>> +	}
>> +
>> +	val = AD3552R_SCRATCH_PAD_TEST_VAL2;
>> +	err = iio_backend_bus_reg_write(st->back,
>> +					AD3552R_REG_ADDR_SCRATCH_PAD,
>> +					&val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_SCRATCH_PAD,
>> +				       &val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	if (val != AD3552R_SCRATCH_PAD_TEST_VAL2) {
>> +		dev_err(st->dev,
>> +			"SCRATCH_PAD_TEST mismatch. Expected 0x%x, Read 0x%x\n",
>> +			AD3552R_SCRATCH_PAD_TEST_VAL2, val);
>> +		return -EIO;
>> +	}
>> +
>> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_L,
>> +				       &val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	id = val;
>> +	mdelay(100);
> Document this delay as it's odd to need a gap whilst reading ID registers.
I ported that delay from a previous testing driver, but i verified
it is not needed, so i removed it.
>> +
>> +	err = iio_backend_bus_reg_read(st->back, AD3552R_REG_ADDR_PRODUCT_ID_H,
>> +				       &val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	id |= val << 8;
>> +	if (id != AD3552R_ID) {
>> +		dev_err(st->dev, "Chip ID mismatch. Expected 0x%x, Read 0x%x\n",
>> +			AD3552R_ID, id);
> Print an message only on this. We want to enable fallback dt compatibles for
> future devices on old kernels, so we can't require a match on a WHOAMI type register.
> We can put a message in the log though to give us a hint if that fallback
> compatible is wrong.
>
ok, done.
>> +		return -ENODEV;
>> +	}
>> +
>> +	st->chip_id = id;
> This is usually a bad sign.  It is much more extensible for a driver to at
> this point 'pick' between a set of per device type structures that encode
> all the difference between device variants.  So good to do that from
> the start.  Lots of old drivers do it this way, but we've learnt over the years
> that it becomes steadily more messy over time as a driver supports more and
> more devices.
>
> I guess the existing driver is doing it this way though so maybe that's
> a refactor for another day.

Thanks, ok, i reworked the same way as ad3552r.c (spi) since i'll have 
to add
other variants soon.


>
>> +
>> +	val = AD3552R_REF_INIT;
>> +	err = iio_backend_bus_reg_write(st->back,
>> +					AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
>> +					&val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	val = AD3552R_TRANSFER_INIT;
>> +	err = iio_backend_bus_reg_write(st->back,
>> +					AD3552R_REG_ADDR_TRANSFER_REGISTER,
>> +					&val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	err = iio_backend_data_source_set(st->back, 0, IIO_BACKEND_EXTERNAL);
>> +	if (err)
>> +		return err;
>> +
>> +	err = iio_backend_data_source_set(st->back, 1, IIO_BACKEND_EXTERNAL);
>> +	if (err)
>> +		return err;
>> +
>> +	err = ad3552r_get_ref_voltage(st->dev, &val);
>> +	if (err)
>> +		return err;
>> +
>> +	err = axi3552r_qspi_update_reg_bits(st->back,
>> +				AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
>> +				AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
>> +				val, 1);
>> +	if (err)
>> +		return err;
>> +
>> +	err = ad3552r_get_drive_strength(st->dev, &val);
>> +	if (!err) {
>> +		err = axi3552r_qspi_update_reg_bits(st->back,
>> +					AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
>> +					AD3552R_MASK_SDO_DRIVE_STRENGTH,
>> +					val, 1);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	child = device_get_named_child_node(st->dev, "channel");
>> +	if (!child)
>> +		return -EINVAL;
>> +
>> +	err = ad3552r_get_output_range(st->dev, st->chip_id, child, &range);
>> +	if (!err)
>> +		return ad3552r_axi_set_output_range(st, range);
>> +
>> +	if (err != -ENOENT)
>> +		return err;
>> +
>> +	/* Try to get custom range */
>> +	err = ad3552r_get_custom_gain(st->dev, child,
>> +					&gs_p, &gs_n, &rfb, &goffs);
>> +	if (err)
>> +		return err;
>> +
>> +	ad3552r_calc_custom_gain(gs_p, gs_n, goffs, &reg);
>> +
>> +	offset = abs((s32)goffs);
>> +
>> +	err = iio_backend_bus_reg_write(st->back,
>> +					AD3552R_REG_ADDR_CH_OFFSET(0),
>> +					&offset, 1);
>> +	if (err)
>> +		return dev_err_probe(st->dev, err,
>> +					"Error writing register\n");
>> +
>> +	err = iio_backend_bus_reg_write(st->back,
>> +					AD3552R_REG_ADDR_CH_OFFSET(1),
>> +					&offset, 1);
>> +	if (err)
>> +		return dev_err_probe(st->dev, err,
>> +					"Error writing register\n");
>> +
>> +	err = iio_backend_bus_reg_write(st->back,
>> +					AD3552R_REG_ADDR_CH_GAIN(0),
>> +					&reg, 1);
>> +	if (err)
>> +		return dev_err_probe(st->dev, err,
>> +					"Error writing register\n");
>> +
>> +	err = iio_backend_bus_reg_write(st->back,
>> +					AD3552R_REG_ADDR_CH_GAIN(1),
>> +					&reg, 1);
>> +	if (err)
>> +		return dev_err_probe(st->dev, err,
>> +					"Error writing register\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct iio_buffer_setup_ops ad3552r_axi_buffer_setup_ops = {
>> +	.postenable = ad3552r_axi_buffer_postenable,
>> +	.predisable = ad3552r_axi_buffer_predisable,
>> +};
>> +
>> +static const char *const synchronous_mode_status[] = {
>> +	[AD3552R_NO_SYNC] = "no_sync",
>> +	[AD3552R_EXT_SYNC_ARM] = "ext_sync_arm",
> I'll comment on this in the ABI docs patch.
>
>> +};
>> +
>> +static const struct iio_enum ad3552r_synchronous_mode_enum = {
>> +	.items = synchronous_mode_status,
>> +	.num_items = ARRAY_SIZE(synchronous_mode_status),
>> +	.get = ad3552r_get_synchronous_mode_status,
>> +	.set = ad3552r_set_synchronous_mode_status,
>> +};
>> +
>> +static const struct iio_chan_spec_ext_info ad3552r_axi_ext_info[] = {
>> +	IIO_ENUM("synchronous_mode", IIO_SHARED_BY_TYPE,
>> +		 &ad3552r_synchronous_mode_enum),
>> +	IIO_ENUM_AVAILABLE("synchronous_mode", IIO_SHARED_BY_TYPE,
>> +			   &ad3552r_synchronous_mode_enum),
>> +	{},
> 	{ }
>
> I'm not blanket fixing this case yet (unlikely the ID ones) but
> generally it's nice to not have a comma after a 'null' terminator
> entry as adding anything after it would be a bug.
ok, done
>
>
>> +};
>> +
>> +#define AD3552R_CHANNEL(ch) { \
>> +	.type = IIO_VOLTAGE, \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>> +	.info_mask_shared_by_all = (((ch) == 0) ? \
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0), \
> If it's shared by all it should be set for all.
> The core code will only create one attr as a result.
>
> Technically it's not a 'bug' to not do this but the semantics
> are wrong if you set something that is for all channels on only
> one of them, so if there are other drivers doing this that I've
> missed we should clean that up.

Ok, i set it for all so.


>
>
>> +	.output = 1, \
>> +	.indexed = 1, \
>> +	.channel = (ch), \
>> +	.scan_index = (ch), \
>> +	.scan_type = { \
>> +		.sign = 'u', \
>> +		.realbits = 16, \
>> +		.storagebits = 16, \
>> +		.shift = 0, \
> Zero shift is the 'obvious' default, so need to specify it in this
> case.
ok, fixed
>
>> +		.endianness = IIO_BE, \
>> +	}, \
>> +	.ext_info = ad3552r_axi_ext_info, \
>> +}
>> +
>> +static const struct of_device_id ad3552r_axi_of_id[] = {
>> +	{ .compatible = "adi,ad3552r" },
>> +	{}
> Trivial, but I'm trying to standardize formats of these in IIO on
> 	{ }
ok, done
>> +};


Thanks a lot,

regards,
Angelo

-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


