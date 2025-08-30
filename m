Return-Path: <linux-iio+bounces-23483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A1AB3CE52
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1951B21069
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5592D660B;
	Sat, 30 Aug 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxZ4GrcS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C921B1BC;
	Sat, 30 Aug 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575770; cv=none; b=MFqePeT6YkUEvI6tiftrQ446YuDeRpznxbw6BwmHSlyIxq/iGkfT67yF4Q/GtboIATE65S90jhD972P0FP03sjFQcVCWH2vdaq1ihZ8HAZCaU4C44dtoxbwJdwDpMuV1tsMJfMcTcVap0n76wscYXcf8OYM6I3S9F1Fo1qg0N70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575770; c=relaxed/simple;
	bh=jFJt86/DZ9iE6qIgTPeN7i5Gs1LDuWlzNpdOtPnpk3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beQighWF3EbJ30VoRfD2k9m1MywIoH4f3dpBlbr4Tyn2ylw0/K0aPIBcBqaX9PGPrx+n/fuT8UlHXW67cdNXNglHeNfuzmMV7T7eQMpuLLeiTvKL2zwvM3upPXz4fJCgg4+VcvQAJ8pceFSFa/Na7irHzX5dCUEsN3K/6qGxyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxZ4GrcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79222C4CEEB;
	Sat, 30 Aug 2025 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756575769;
	bh=jFJt86/DZ9iE6qIgTPeN7i5Gs1LDuWlzNpdOtPnpk3U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lxZ4GrcS5S5b/z6tGf4na0QlKpZFB9j85eIrH11OLgDhO81v3WOLkXUDl/lpoIpff
	 4OENQZYEdo2gR4WxtlMfQbJih5IsZPZOvyZhU0bzO/ywt1cyz2VWQiS/I9KUyiLguV
	 UpUmcifVbJ8tBqRCSMOVvyLXU1CXoPbQyD6/ZYdwbeESyDIBnmEhzMOICuIq8/m6u+
	 yI3YK+37eQP+qKdbCNCmIus4tCxuZIfn5XMEGIl71sdRybtyR3Tg/e30FnA3si7FTs
	 TGQPgO87Y0nt+mU3S8UkJPq9q9UyQVsVKIRcmyBzfOLgex2JKEQ0UUr+M5p4hnfLhh
	 wYtUYF12lFO0Q==
Date: Sat, 30 Aug 2025 18:42:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
 amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
 rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
 david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
 kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
 quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
 stephan.gerhold@linaro.org
Subject: Re: [PATCH V7 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20250830184233.7ddf6ae8@jic23-huawei>
In-Reply-To: <20250826083657.4005727-5-jishnu.prakash@oss.qualcomm.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
	<20250826083657.4005727-5-jishnu.prakash@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 14:06:56 +0530
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

A few additional comments from a fresh read through.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/qcom-adc5-gen3-common.c b/drivers/iio/adc/qcom-adc5-gen3-common.c
> new file mode 100644
> index 000000000000..c84e75859958
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-adc5-gen3-common.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * Code shared between the main and auxiliary Qualcomm PMIC voltage ADCs
> + * of type ADC5 Gen3.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/iio/adc/qcom-adc5-gen3-common.h>

Follow (approximate) include what you use principles for includes.
So here I'd expect to at least see a regmap include.

> +
> +int adc5_gen3_read(struct adc5_device_data *adc, unsigned int sdam_index,
> +		   u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_read(adc->regmap,
> +				adc->base[sdam_index].base_addr + offset,
> +				data, len);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_read, "QCOM_SPMI_ADC5_GEN3");
> +
> +int adc5_gen3_write(struct adc5_device_data *adc, unsigned int sdam_index,
> +		    u16 offset, u8 *data, int len)
> +{
> +	return regmap_bulk_write(adc->regmap,
> +				 adc->base[sdam_index].base_addr + offset,
> +				 data, len);
> +}
> +EXPORT_SYMBOL_NS_GPL(adc5_gen3_write, "QCOM_SPMI_ADC5_GEN3");

> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
> new file mode 100644
> index 000000000000..f01a56363389
> --- /dev/null
> +++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c

> +
> +#define ADC5_GEN3_READ_CONFIG_REGS 7
> +
> +static int adc5_gen3_configure(struct adc5_chip *adc,
> +			       struct adc5_channel_common_prop *prop)
> +{
> +	u8 buf[ADC5_GEN3_READ_CONFIG_REGS];
> +	u8 conv_req = 0;
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM, ADC5_GEN3_SID,
> +			     buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	/* Write SID */
> +	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->sid);
> +
> +	/*
> +	 * Use channel 0 by default for immediate conversion and
> +	 * to indicate there is an actual conversion request

Wrap to 80 chars, not 68ish.

> +	 */

> +static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
> +{
> +	u8 status, tm_status[2], eoc_status, val;
> +	struct adc_tm5_auxiliary_drv *adrv_tm;
> +	struct adc5_chip *adc = dev_id;
> +	struct device *dev = adc->dev;
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_STATUS1, &status, sizeof(status));
> +	if (ret) {
> +		dev_err(dev, "adc read status1 failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = adc5_gen3_read(&adc->dev_data, ADC5_GEN3_VADC_SDAM,
> +			     ADC5_GEN3_EOC_STS, &eoc_status, sizeof(eoc_status));
> +	if (ret) {
> +		dev_err(dev, "adc read eoc status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
> +		dev_err_ratelimited(dev,
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
> +		dev_err(dev, "adc read TM status failed with %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_dbg(dev, "Interrupt status:%#x, EOC status:%#x, high:%#x, low:%#x\n",
> +		status, eoc_status, tm_status[0], tm_status[1]);
> +
> +	if (tm_status[0] || tm_status[1]) {
> +		adev = adc->tm_aux;
> +		if (!adev || !adev->dev.driver) {
> +			dev_err(dev, "adc_tm auxiliary device not initialized\n");
> +			return IRQ_HANDLED;
> +		}
> +
> +		adrv_tm = container_of(adev->dev.driver,
> +				       struct adc_tm5_auxiliary_drv,
> +				       adrv.driver);
> +
> +		if (adrv_tm && adrv_tm->tm_event_notify)

Container_of is never going to return NULL unless the offset is 0 and the thing
passed in is null (already checked above).

Also flip this to keep the error as the only out of line bit.

		if (!adrv_tm->tm_event_notify) {
			dev_err(dev, "adc_tm auxiliary driver not initialized\n");
			return IRQ_HANDLED;
		}

		adrv_tm->tm_event_notify(adev);
	}
> +			adrv_tm->tm_event_notify(adev);
> +		else
> +			dev_err(dev, "adc_tm auxiliary driver not initialized\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
> +					 struct adc5_channel_prop *prop,
> +					 struct fwnode_handle *fwnode)
> +{
> +	const char *name = fwnode_get_name(fwnode);
> +	const struct adc5_data *data = adc->data;
> +	u32 chan, value, varr[2], sid = 0;

Why initialize sid?

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

> +	return 0;
> +}


