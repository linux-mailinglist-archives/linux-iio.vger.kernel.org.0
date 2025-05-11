Return-Path: <linux-iio+bounces-19428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B4AB284E
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1F11894015
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 13:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE54256C9E;
	Sun, 11 May 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMfxwY3d"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF71547D2;
	Sun, 11 May 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746968673; cv=none; b=hudkPE78IXpYRWzvRXlyG7HHhZt17yuSJvXEXrTLdc8zfZjurupmDWgGIePIXoEv/iBIR2Vu70Xn2NBnYiebtJ7XAomDvZqFwefBNB9/BmUz6m93Z0eOs2/Zxxe+9444/uih+wZR9xYdpxY9R1fE3YstB/X3ILcFN24dhAZv6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746968673; c=relaxed/simple;
	bh=ysFsldOAymgZKvYbT/mcT2n+lZN/1JlFj857Za7YzEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhKQ6P7cBVRSBn8lX72F+QAI+KpMZVmFNkVkqsu/X0Z1gJEUuH2gJqljYltjE5HIarDZHwfBllXh3X3SnL6pVwB3s4gbcI3Ll64pvQJD9kWfLah2qMiF8DITuCyumwqFWUIwX5lgNSANIdo+F/YXRdDAIyD+IvvqyUyBkfN/V2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMfxwY3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3732C4CEE4;
	Sun, 11 May 2025 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746968671;
	bh=ysFsldOAymgZKvYbT/mcT2n+lZN/1JlFj857Za7YzEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMfxwY3d0jfhu7YNYGe52TkrJmCEe7iEgNyDcoHKmxR1MFmNfoNg6YWb6QGPgmztM
	 ZcZgoI9otjgfLVn36OH2YYbGm30mAN0+/w3mEIdHCaenZi+Kw6nj8HAOUtb4aAqVu6
	 EGQ26jfVpNDpD0cbDXK9TvkeKC0MT/eFW2OD9vXRQJDv7fQ0YicXtuSz2LCHup66xj
	 Arau1XPKdbmoMyOWOMrmpt+VbxREGcmvgNL5ekNnMFJ+z15qf4TrMbj3WjR6x7t6dH
	 WBvGASSTFFkYFA8amuZVqZlHMH5aic3vY5R4GpuWRYECDPqpTN1k9Dfy3BPC9yOVWo
	 17wWJEdrKgncA==
Date: Sun, 11 May 2025 14:04:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
Subject: Re: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20250511140418.33171ca3@jic23-huawei>
In-Reply-To: <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
	<20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 May 2025 16:39:58 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> with all SW communication to ADC going through PMK8550 which
> communicates with other PMICs through PBS.
> 
> One major difference is that the register interface used here is that
> of an SDAM (Shared Direct Access Memory) peripheral present on PMK8550.
> There may be more than one SDAM used for ADC5 Gen3 and each has eight
> channels, which may be used for either immediate reads (same functionality
> as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or recurring measurements
> (same as ADC_TM functionality).
> 
> By convention, we reserve the first channel of the first SDAM for all
> immediate reads and use the remaining channels across all SDAMs for
> ADC_TM monitoring functionality.
> 
> Add support for PMIC5 Gen3 ADC driver for immediate read functionality.
> ADC_TM is implemented as an auxiliary thermal driver under this ADC
> driver.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Hi Jishnu,

I guess I hadn't looked closely at the aux device code before. There
is a fairly nasty lifetime issue. I'm a little surprised you didn't
see it whilst testing driver remove but maybe luck was with / against you!

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
> new file mode 100644
> index 000000000000..edd618b0d39f
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + *
> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
> + * of type ADC5 Gen3.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>
> +
> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +		   u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_read(adc->regmap,
> +				adc->base[sdam_index].base_addr + offset,
> +				data, len);
> +}
> +EXPORT_SYMBOL(adc5_gen3_read);

Consider namespacing these exports.

> +
> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +		    u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_write(adc->regmap,
> +				 adc->base[sdam_index].base_addr + offset,
> +				 data, len);
> +}
> +EXPORT_SYMBOL(adc5_gen3_write);
> +
> +/*
> + * Worst case delay from PBS in readying handshake bit
wrap at 80 chars

> + * can be up to 15ms, when PBS is busy running other
> + * simultaneous transactions, while in the best case, it is
> + * already ready at this point. Assigning polling delay and
> + * retry count accordingly.
> + */

..

> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..25b58b9be3b7
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> @@ -0,0 +1,763 @@
...

> +/*
> + * Worst case delay from PBS for conversion time can be

wrap at 80

> + * up to 500ms, when PBS has timed out twice, once for
> + * the initial attempt and once for a retry of the same
> + * transaction.
> + */

...

> +
> +static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
> +{
> +	u8 status, tm_status[2], eoc_status, val;
> +	struct adc_tm5_auxiliary_drv *adrv_tm;
> +	struct adc5_chip *adc = dev_id;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_STATUS1, &status, sizeof(status));
> +	if (ret) {
> +		dev_err(adc->dev, "adc read status1 failed with %d\n", ret);

A lot of adc->dev in here.  Maybe worth a local variable.

> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_EOC_STS, &eoc_status, sizeof(eoc_status));
> +	if (ret) {
> +		dev_err(adc->dev, "adc read eoc status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
> +		dev_err_ratelimited(adc->dev,
> +				    "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
> +				    status, eoc_status);
> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
> +		adc5_gen3_status_clear(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/* CHAN0 is the preconfigured channel for immediate conversion */
> +	if (eoc_status & ADC5_GEN3_EOC_CHAN_0)
> +		complete(&adc->complete);
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_TM_HIGH_STS, tm_status, sizeof(tm_status));
> +	if (ret) {
> +		dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (tm_status[0] || tm_status[1]) {
> +		adev = adc->tm_aux;
> +		if (!adev || !adev->dev.driver) {
> +			dev_err(adc->dev,
> +				"adc_tm auxiliary device not initialized\n");
> +			return IRQ_HANDLED;
> +		}
> +
> +		adrv_tm = container_of(adev->dev.driver,
> +				       struct adc_tm5_auxiliary_drv,
> +				       adrv.driver);
> +
> +		if (adrv_tm && adrv_tm->tm_event_notify)
> +			adrv_tm->tm_event_notify(adev);
> +		else
> +			dev_err(adc->dev,
> +				"adc_tm auxiliary driver not initialized\n");

Not return?  Seems odd to print the dbg print only in this error path path.

> +	}
> +
> +	dev_dbg(adc->dev,
> +		"Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
> +		status, eoc_status, tm_status[0], tm_status[1]);
> +
> +	return IRQ_HANDLED;
> +}

> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
> +					 struct adc5_channel_prop *prop,
> +					 struct fwnode_handle *fwnode)
> +{
> +	const char *name = fwnode_get_name(fwnode);
> +	const struct adc5_data *data = adc->data;
> +	u32 chan, value, varr[2], sid = 0;
> +	struct device *dev = adc->dev;
> +	const char *channel_name;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "invalid channel number %s\n",
> +				     name);
> +
> +	/*
> +	 * Value read from "reg" is virtual channel number
> +	 * virtual channel number = sid << 8 | channel number
> +	 */
> +	sid = FIELD_GET(ADC5_GEN3_VIRTUAL_SID_MASK, chan);
> +	chan = FIELD_GET(ADC5_GEN3_CHANNEL_MASK, chan);
> +
> +	if (chan > ADC5_GEN3_OFFSET_EXT2)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "%s invalid channel number %d\n",
> +				     name, chan);
> +
> +	prop->common_props.channel = chan;
> +	prop->common_props.sid = sid;
> +
> +	channel_name = name;
> +	fwnode_property_read_string(fwnode, "label", &channel_name);
> +	prop->common_props.label = channel_name;
> +
> +	value = data->decimation[ADC5_DECIMATION_DEFAULT];
> +	fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
> +	ret = qcom_adc5_decimation_from_dt(value, data->decimation);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "%#x invalid decimation %d\n",
> +				     chan, value);
> +	prop->common_props.decimation = ret;
> +
> +	prop->common_props.prescale = adc->data->adc_chans[chan].prescale_index;
> +	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
> +	if (!ret) {
> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "%#x invalid pre-scaling <%d %d>\n",
> +				chan, varr[0], varr[1]);

Indent to align below line above.
Check for any other cases of this.

> +		prop->common_props.prescale = ret;
> +	}
> +
> +	value = data->hw_settle_1[VADC_DEF_HW_SETTLE_TIME];
> +	fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
> +	ret = qcom_adc5_hw_settle_time_from_dt(value, data->hw_settle_1);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "%#x invalid hw-settle-time %d us\n",
> +				     chan, value);
> +	prop->common_props.hw_settle_time_us = ret;
> +
> +	value = BIT(VADC_DEF_AVG_SAMPLES);
> +	fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
> +	ret = qcom_adc5_avg_samples_from_dt(value);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "%#x invalid avg-samples %d\n",
> +				     chan, value);
> +	prop->common_props.avg_samples = ret;
> +
> +	if (fwnode_property_read_bool(fwnode, "qcom,ratiometric"))
> +		prop->common_props.cal_method = ADC5_RATIOMETRIC_CAL;
> +	else
> +		prop->common_props.cal_method = ADC5_ABSOLUTE_CAL;
> +
> +	prop->adc_tm = fwnode_property_read_bool(fwnode, "qcom,adc-tm");
> +	if (prop->adc_tm) {
> +		adc->n_tm_channels++;
> +		if (adc->n_tm_channels > ((adc->dev_data.num_sdams * 8) - 1))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Number of TM nodes %u greater than channels supported:%u\n",
> +					     adc->n_tm_channels,
> +					     (adc->dev_data.num_sdams * 8) - 1);
Excess brackets.

> +	}
> +
> +	return 0;
> +}
> +
> +static const struct adc5_data adc5_gen3_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.adc_chans = adc5_gen3_chans_pmic,
> +	.info = &adc5_gen3_info,
> +	.decimation = (unsigned int [ADC5_DECIMATION_SAMPLES_MAX])
> +				{85, 340, 1360},

Inconsistent spacing. Should be { 85 etc

> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
> +				  1000, 2000, 4000, 8000, 16000, 32000,
> +				  64000, 128000 },
Andy often points this out, but I'll do it this time. Fixed numbers (typically power of 2)
elements per line make it much easier to see which element is which in these arrays.
Reduce the indent a little to allow that here.

> +};
> +
> +static const struct of_device_id adc5_match_table[] = {
> +	{
> +		.compatible = "qcom,spmi-adc5-gen3",
> +		.data = &adc5_gen3_data_pmic,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adc5_match_table);
> +
> +static int adc5_get_fw_data(struct adc5_chip *adc)
> +{
> +	const struct adc5_channels *adc_chan;
> +	struct adc5_channel_prop *chan_props;
> +	struct fwnode_handle *child = NULL;
> +	struct iio_chan_spec *iio_chan;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	adc->nchannels = device_get_child_node_count(adc->dev);
> +	if (!adc->nchannels) {
> +		dev_err(adc->dev, "No ADC channels found\n");
> +		return -EINVAL;
> +	}
> +
> +	adc->iio_chans = devm_kcalloc(adc->dev, adc->nchannels,
> +				      sizeof(*adc->iio_chans), GFP_KERNEL);
> +	if (!adc->iio_chans)
> +		return -ENOMEM;
> +
> +	adc->chan_props = devm_kcalloc(adc->dev, adc->nchannels,
> +				       sizeof(*adc->chan_props), GFP_KERNEL);
> +	if (!adc->chan_props)
> +		return -ENOMEM;
> +
> +	chan_props = adc->chan_props;
> +	adc->n_tm_channels = 0;
> +	iio_chan = adc->iio_chans;
> +	adc->data = device_get_match_data(adc->dev);
> +
> +	device_for_each_child_node(adc->dev, child) {
> +		ret = adc5_gen3_get_fw_channel_data(adc, chan_props, child);
> +		if (ret < 0)

If this errors out, do you intend to be left holding a reference to
the child node?  I'm guessing not.  In which case look at scoped
variant of the iterator.

> +			return ret;
> +
> +		chan_props->chip = adc;
> +		adc_chan = &adc->data->adc_chans[chan_props->common_props.channel];
> +		chan_props->common_props.scale_fn_type = adc_chan->scale_fn_type;
> +
> +		iio_chan->channel = V_CHAN(chan_props->common_props);
> +		iio_chan->info_mask_separate = adc_chan->info_mask;
> +		iio_chan->type = adc_chan->type;
> +		iio_chan->address = index;
> +		iio_chan->indexed = 1;
> +		iio_chan++;
> +		chan_props++;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void adc5_gen3_uninit_aux(void *data)
> +{
> +	auxiliary_device_uninit(data);
> +}
> +
> +static void adc5_gen3_delete_aux(void *data)
> +{
> +	auxiliary_device_delete(data);
> +}
> +
> +static void adc5_gen3_aux_device_release(struct device *dev)
> +{
> +	struct auxiliary_device *aux = container_of(dev, struct auxiliary_device,
> +						    dev);
> +
> +	kfree(aux);

It wasn't allocated at that granularity.

> +}
> +
> +static int adc5_gen3_add_aux_tm_device(struct adc5_chip *adc)
> +{
> +	struct tm5_aux_dev_wrapper *aux_device;
> +	int i, ret, i_tm = 0;
> +
> +	aux_device = devm_kzalloc(adc->dev, sizeof(*aux_device), GFP_KERNEL);

There is some lifetime management stuff that is going wrong here.
Here you allocate a structure that directly contains the
struct auxiliary_device and use devm managed allocation.

But you free the contained struct auxiliary_device via the release
above. Firstly that's freeing at a different granularity which is going to
go wrong.  Also, that pointer is the same as aux_device here (as first element)
and so you free this via devm_ cleanup and on the reference count of the
auxiliary device dropping to zero.


Take a look at some other drivers that make use of auxdevs for
how to handle this.

Key is that the devm handler should be reducing the refcount, not freeing
the memory as the release will deal with that later.

> +	if (!aux_device)
> +		return -ENOMEM;
> +
> +	aux_device->aux_dev.name = "adc5_tm_gen3";
> +	aux_device->aux_dev.dev.parent = adc->dev;
> +	aux_device->aux_dev.dev.release = adc5_gen3_aux_device_release;
> +
> +	aux_device->tm_props = devm_kcalloc(adc->dev, adc->n_tm_channels,
> +					    sizeof(*aux_device->tm_props),
> +					    GFP_KERNEL);
> +	if (!aux_device->tm_props)
> +		return -ENOMEM;
> +
> +	aux_device->dev_data = &adc->dev_data;
> +
> +	for (i = 0; i < adc->nchannels; i++) {
> +		if (!adc->chan_props[i].adc_tm)
> +			continue;
> +		aux_device->tm_props[i_tm] = adc->chan_props[i].common_props;
> +		i_tm++;
> +	}
> +
> +	device_set_of_node_from_dev(&aux_device->aux_dev.dev, adc->dev);
> +
> +	aux_device->n_tm_channels = adc->n_tm_channels;
> +
> +	ret = auxiliary_device_init(&aux_device->aux_dev);
> +	if (ret) {
> +		kfree(&aux_device->aux_dev);

What is this freeing? 

> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_uninit_aux,
> +				       &aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = auxiliary_device_add(&aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +	ret = devm_add_action_or_reset(adc->dev, adc5_gen3_delete_aux,
> +				       &aux_device->aux_dev);
> +	if (ret)
> +		return ret;
> +
> +	adc->tm_aux = &aux_device->aux_dev;
> +
> +	return 0;
> +}

> +static int adc5_gen3_probe(struct platform_device *pdev)
> +{

> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	init_completion(&adc->complete);
> +	mutex_init(&adc->lock);
If spinning again for other reasons, in new code I have slight preference for
	ret = devm_mutex_init(&adc->lock);
	if (ret)
		return ret;

It was never worth bothering with release until we had devm managed form but
now we do the code complexity cost is low enough to make it reasonable.

> +	indio_dev->name = pdev->name;

Just to check.  Does that end up as a part number or similar?

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc5_gen3_info;
> +	indio_dev->channels = adc->iio_chans;
> +	indio_dev->num_channels = adc->nchannels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> new file mode 100644
> index 000000000000..4f476cd77b37
> --- /dev/null
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -0,0 +1,193 @@
> +/* SPDX-License-Identifier: GPL-2.0 */


> +#define V_CHAN(x)		\

Might be a good idea to prefix this.  Seems likely we might end up with
a V_CHAN macro in some generic header in future.

> +	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)

