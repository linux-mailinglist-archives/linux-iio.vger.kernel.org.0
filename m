Return-Path: <linux-iio+bounces-9872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E0798953B
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 13:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B378B215A9
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C618716C695;
	Sun, 29 Sep 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiKNX9rv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70042AB1;
	Sun, 29 Sep 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727611083; cv=none; b=Uv1MQbUBxsA63TyIm1ctyXssoN5h8lq4RswwnBk58eOps5Ua/Svbx55TOMJXhocYA5ys6C1TpHSGQNnDVf6Xs4f5wKXUrt+oDfkEfLRDkTUY9Yg8dDOsX2MAJTcWavcOF8hcFiOT/RyCk/CLivIUhunZEHRcbHdOGjFtGzXdeU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727611083; c=relaxed/simple;
	bh=xnzj5weTfaICxOpnTgH952XEztWbNP8I6CAlKV8S6vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=us4PrhvOGm0NvUm73B/KGEKBo18FEwZ7me7N892BZ3pprC99ypgx6d4M6Ol59KxHQsgl8pg20DAhnIcFWs0K4SGsuOkYg8LBCHu47G7P7ljK1W7PtjjUp8GPHy/k2fHZ7qvCBqgbVkwXnZIvl8gteIilKZF8DU07Ml0XdlTWYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiKNX9rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F55C4CEC5;
	Sun, 29 Sep 2024 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727611083;
	bh=xnzj5weTfaICxOpnTgH952XEztWbNP8I6CAlKV8S6vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KiKNX9rvcCPpNHn4sPo1kq1OnWs29lgUUcVfw2G3F0Uzr8vItpG53g2Tny6rUY0CA
	 tPSlAvIi79jnl0GAzDwj8N9myhXOMeB4Fc91c+/jHdAtK642bR2vJVjjhEk4BUqwSs
	 lyp9M5j5+9MmjobfuErdUv3QWnr1/m84QEXxLNTmUnK1X0jq3yajPPiuPnylnjaKQA
	 iY5+Az2hGj4POHAvAvpgBo+3ymlOWZwe2Iwwwykp0Ngc/c7Rj9UKXWn7QDtLBmAZWf
	 CZUNRBfcBl4pUE6p9Q85wUu2ynF8TCrtZi7LnACN8Oy1WPSCSDebC+woNRTRtR2aMG
	 TkuvgMv14B3rQ==
Date: Sun, 29 Sep 2024 12:57:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 08/10] iio: dac: ad3552r: extract common code (no
 changes in behavior intended)
Message-ID: <20240929125753.789bda87@jic23-huawei>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-8-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-8-a17b9b3d05d9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 11:20:04 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extracting common code, to share common code to be used later
> by the AXI driver version (ad3552r-axi.c).
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
For these, main request is to move them to a namespace + GPL is
probably the appropriate choice here.


> ---
>  drivers/iio/dac/Makefile         |   2 +-
>  drivers/iio/dac/ad3552r-common.c | 173 +++++++++++++++++++++++
>  drivers/iio/dac/ad3552r.c        | 293 ++++-----------------------------------
>  drivers/iio/dac/ad3552r.h        | 190 +++++++++++++++++++++++++
>  4 files changed, 390 insertions(+), 268 deletions(-)
> 
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 2cf148f16306..56a125f56284 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> -obj-$(CONFIG_AD3552R) += ad3552r.o
> +obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o
>  obj-$(CONFIG_AD5421) += ad5421.o
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> new file mode 100644
> index 000000000000..624f3f97cdea
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Copyright (c) 2010-2024 Analog Devices Inc.
> +// Copyright (c) 2024 Baylibre, SAS
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "ad3552r.h"
> +
> +const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] = {
> +	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
> +	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
> +	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
> +	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= { -10000, 10000 }
> +};
> +EXPORT_SYMBOL(ad3552r_ch_ranges);

GPL and namespace them to avoid poluting the general namespace with driver
specific exports.

EXPORT_SYMBOL_NS_GPL() etc.


> +
> +u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
> +{
> +	u16 reg;
> +
> +	reg = FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs((s32)goffs) >> 8);
Hmm. Not sure the s32 case does anything useful here.
Also this is a little messy from local view of code. It is not obvious
that only BIT(0) can be set here.  I'd be tempted to mask that
before passing to FIELD_PREP()

> +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, (s32)goffs < 0);

Why do you need the s32 cast for this last line?

> +
> +	return reg;
> +}
> +
> +int ad3552r_get_ref_voltage(struct device *dev)
> +{
> +	int voltage;
> +	int delta = 100000;
> +
> +	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (voltage < 0 && voltage != -ENODEV)
> +		return dev_err_probe(dev, voltage,
> +				     "Error getting vref voltage\n");
> +
> +	if (voltage == -ENODEV) {
> +		if (device_property_read_bool(dev, "adi,vref-out-en"))
> +			return AD3552R_INTERNAL_VREF_PIN_2P5V;
> +		else
> +			return AD3552R_INTERNAL_VREF_PIN_FLOATING;
> +	}
> +
> +	if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> +		dev_warn(dev, "vref-supply must be 2.5V");
> +		return -EINVAL;
> +	}

Obviously this is legacy code, but why do we care in the driver?
If someone has circuitry or configuration that is wrong, do we need to check
that?  I guess it does little harm though.

> +
> +	return AD3552R_EXTERNAL_VREF_PIN_INPUT;
> +}
> +
> +int ad3552r_get_drive_strength(struct device *dev, u32 *val)
> +{
> +	int err;
> +
> +	err = device_property_read_u32(dev, "adi,sdo-drive-strength", val);
> +	if (err)
> +		return err;
> +
> +	if (*val > 3) {

Usually we avoid setting values passed back on error if it is easy to do so.
I'd bounce via a local variable and only set *val = drive_strength
after you know it is in range.

> +		dev_err(dev,
> +			"adi,sdo-drive-strength must be less than 4\n");
> +		return -EINVAL;
Is dev_err_probe() appropriate here?  I haven't checked if this is called
from non probe paths so ignore this comment if it is.
> +	}
> +
> +	return 0;
> +}
> +
> +int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
> +			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
> +{
> +	int err;
> +	u32 val;
> +	struct fwnode_handle *gain_child __free(fwnode_handle) =
> +				fwnode_get_named_child_node(child,
One tab more than the line above is fine for cases like this and makes for
more readable code.

> +				"custom-output-range-config");

Align this final parameter with c of child.

> +
> +	if (!gain_child)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "custom-output-range-config mandatory\n");
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,gain-scaling-p mandatory\n");
> +	*gs_p = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,gain-scaling-n property mandatory\n");
> +	*gs_n = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,rfb-ohms mandatory\n");
> +	*rfb = val;
> +
> +	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "adi,gain-offset mandatory\n");
> +	*goffs = val;
> +
> +	return 0;
> +}
> +
> +static int ad3552r_find_range(u16 id, s32 *vals)
> +{
> +	int i, len;
> +	const s32 (*ranges)[2];
> +
> +	if (id == AD3542R_ID) {

This is already in your model_data. Use that not another lookup via
an ID enum.  The ID enum approach doesn't scale as we add more parts
as it scatters device specific code through the driver.


> +		len = ARRAY_SIZE(ad3542r_ch_ranges);
> +		ranges = ad3542r_ch_ranges;
> +	} else {
> +		len = ARRAY_SIZE(ad3552r_ch_ranges);
> +		ranges = ad3552r_ch_ranges;
> +	}
> +
> +	for (i = 0; i < len; i++)
> +		if (vals[0] == ranges[i][0] * 1000 &&
> +		    vals[1] == ranges[i][1] * 1000)
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +int ad3552r_get_output_range(struct device *dev, enum ad3552r_id chip_id,
> +			     struct fwnode_handle *child, u32 *val)
As above, don't pass the enum. Either pass the model_data or pass the
actual stuff you need which is the ranges array and size of that array.

> +{
> +	int ret;
> +	s32 vals[2];
> +
> +	/* This property is optional, so returning -ENOENT if missing */
> +	if (!fwnode_property_present(child, "adi,output-range-microvolt"))
> +		return -ENOENT;
> +
> +	ret = fwnode_property_read_u32_array(child,
> +					     "adi,output-range-microvolt",
> +					     vals, 2);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"invalid adi,output-range-microvolt\n");
> +
> +	ret = ad3552r_find_range(chip_id, vals);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +			"invalid adi,output-range-microvolt value\n");
> +
> +	*val = ret;
> +
> +	return 0;
> +}

Thanks,

Jonathan



