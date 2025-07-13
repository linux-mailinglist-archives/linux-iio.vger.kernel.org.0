Return-Path: <linux-iio+bounces-21619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15940B031D2
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 17:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F0C17BFE2
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D44427BF85;
	Sun, 13 Jul 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iezW1LYE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DC1EFF96;
	Sun, 13 Jul 2025 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752421247; cv=none; b=C0xAlY3MEfRfKHOQddHgVwGJimdh56MicBJ403NlQ8a47upS1WPfgi82ZKxPgJEAH5l0e9ahyGxLPETiLWqJU1DYLrLEfp/JUnRPBKC33rk/Ly6xgooosKQWCLUEARue8MxIjtru3EdkdxaRKtwaw5FrQtdDQjqRCFfTStHD6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752421247; c=relaxed/simple;
	bh=WUhaWWvZWlROAQYWxmJ7AIisKbREHb1tosy6iwPFBlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GqxlnmCLDv/zk+p2bbpFEqCWWGt1AdFYO27ywWIfMh3zvE8VbuW3mgOGKhu5nzLQnz93rWTGzUEZvnIUO+eQCOklxgzrC4FGGrEtqFM2ZmqNY58I/YSAC4IXsLsCUhz+D/nTzi7Wkx7dicyOHYsspwHAnxR/pYoyY0YcznKHIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iezW1LYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB99C4CEE3;
	Sun, 13 Jul 2025 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752421245;
	bh=WUhaWWvZWlROAQYWxmJ7AIisKbREHb1tosy6iwPFBlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iezW1LYEBM3RL393QRtxsKNQyvaO8ApN3OPB5eW+w7wujux6FtrQdXY5XoptlOXw3
	 X7sarYWyp02Grm3T122+7EgdnE2xP691DgaL8tw5hs2uID7mBsTnKGm8mh8Li2lZw3
	 sb1VK9/lozanXf51TwidyZ7hUF+yWUK2gTRElmM6g4PM5eFDq+SlZkST7hjGZyrXbZ
	 pzlwLOLLrm9WNEzlUTm4kGCvTV7yfIO926XsRjHhlZefmPosA+DNYInk6vCNFvLwEC
	 +szRJrFIZEdiAhOKP7iLotE37gdTipSwxHZ8xIID3x6Lix/+ccegfvY/TrbaHT5syo
	 hp6mpWUhtG50g==
Date: Sun, 13 Jul 2025 16:40:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yassine Oudjana via B4 Relay
 <devnull+y.oudjana.protonmail.com@kernel.org>
Cc: y.oudjana@protonmail.com, Manivannan Sadhasivam <mani@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
Message-ID: <20250713164033.3488db3c@jic23-huawei>
In-Reply-To: <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com>
	<20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 09:06:30 +0100
Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org> wrote:

> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a driver for sensors exposed by the Qualcomm Sensor Manager service,
> which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> include accelerometers, gyroscopes, pressure sensors, proximity sensors
> and magnetometers.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

As Andy commented - this is big.  Break it up for v3.

So far I haven't understood why a separate accelerometer driver was necessary.
Some comments in the patch description would perhaps help me understand that.

> diff --git a/drivers/iio/accel/qcom_smgr_accel.c b/drivers/iio/accel/qcom_smgr_accel.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ce854312d1d9386300785f1965d5886c16995806
> --- /dev/null
> +++ b/drivers/iio/accel/qcom_smgr_accel.c
> @@ -0,0 +1,138 @@


> +static void qcom_smgr_accel_remove(struct platform_device *pdev)
> +{
> +	struct qcom_smgr_sensor *sensor = platform_get_drvdata(pdev);
> +
> +	sensor->iio_dev = NULL;

Add a comment for why this is needed. I can't immediately spot anything
explicitly checking it so it doesn't seem to be about safe handling
of device removal or similar.


> +}
> +
> +static const struct platform_device_id qcom_smgr_accel_ids[] = {
> +	{ .name = "qcom-smgr-accel" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, qcom_smgr_accel_ids);
> +
> +static struct platform_driver qcom_smgr_accel_driver = {
> +	.probe = qcom_smgr_accel_probe,
> +	.remove = qcom_smgr_accel_remove,
> +	.driver	= {
> +		.name = "qcom_smgr_accel",
> +	},
> +	.id_table = qcom_smgr_accel_ids,
> +};
> +module_platform_driver(qcom_smgr_accel_driver);
> +
> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
> +MODULE_DESCRIPTION("Qualcomm Sensor Manager accelerometer driver");
> +MODULE_LICENSE("GPL");

I'm struggling to understand what the relationship between this driver
the main sensor driver is.

> diff --git a/drivers/iio/common/qcom_smgr/qcom_smgr.c b/drivers/iio/common/qcom_smgr/qcom_smgr.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..79d1160f7a5c32f1a9e0a20f29e304e5cb18be8f
> --- /dev/null
> +++ b/drivers/iio/common/qcom_smgr/qcom_smgr.c
> @@ -0,0 +1,840 @@

> +static void qcom_smgr_buffering_report_handler(struct qmi_handle *hdl,
> +					       struct sockaddr_qrtr *sq,
> +					       struct qmi_txn *txn,
> +					       const void *data)
> +{
> +	struct qcom_smgr *smgr =
> +		container_of(hdl, struct qcom_smgr, sns_smgr_hdl);
> +	const struct sns_smgr_buffering_report_ind *ind = data;
> +	struct qcom_smgr_sensor *sensor;
> +	struct qcom_smgr_iio_data iio_data;
> +	int temp;
> +	u8 i, j;
> +
> +	for (i = 0; i < smgr->sensor_count; ++i) {
> +		sensor = &smgr->sensors[i];
> +
> +		/* Find sensor matching report */
> +		if (sensor->id == ind->report_id)
> +			break;
> +	}
> +
> +	if (i == smgr->sensor_count) {
> +		dev_warn_ratelimited(smgr->dev,
> +			"Received buffering report with unknown ID: %02x",
> +			ind->report_id);
> +		return;
> +	}
> +
> +	/*
> +	 * Construct data to be passed to IIO. Since we are matching report rate
> +	 * with sample rate, we only get a single sample in every report.
> +	 */
> +	for (j = 0; j < ARRAY_SIZE(ind->samples[0].values); ++j)
> +		iio_data.values[j] = ind->samples[0].values[j];
> +
> +	/*
> +	 * SMGR reports sensor data in 32-bit fixed-point values, with 16 bits
> +	 * holding the integer part and the other 16 bits holding the numerator
> +	 * of a fraction with the denominator 2**16.
> +	 *
> +	 * Proximity sensor values are reported differently from other sensors.
> +	 * The value reported is a boolean (0 or 1, still in the same fixed-point
> +	 * format) where 1 means the sensor is activated, i.e. something is
> +	 * within its range. Use the reported range to pass an actual distance
> +	 * value to IIO. We pass the sensor range when nothing is within range
> +	 * (sensor maxed out) and 0 when something is within range (assume
> +	 * sensor is covered).
> +	 */
> +	if (sensor->type == SNS_SMGR_SENSOR_TYPE_PROX_LIGHT) {
> +		temp = le32_to_cpu(iio_data.values[0]);
> +		temp >>= SMGR_VALUE_DECIMAL_OFFSET;
> +		temp = ~temp & 1;
> +		temp *= sensor->data_types[0].range;
> +		iio_data.values[0] = cpu_to_le32(temp);
> +	}
> +
> +	iio_push_to_buffers(sensor->iio_dev, &iio_data);
You have a structure with space for timestamps but don't provide one which
is odd.  Either don't make space, or provide it.

> +}

> +
> +static int qcom_smgr_sensor_predisable(struct iio_dev *iio_dev)
> +{
> +	struct qcom_smgr *smgr = dev_get_drvdata(iio_dev->dev.parent);
> +	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
> +	struct qcom_smgr_sensor *sensor = priv->sensor;
> +
> +	dev_info(smgr->dev, "disable buffering %02x\n", sensor->id);

Too nosy. dev_dbg()

> +	return qcom_smgr_request_buffering(smgr, sensor, false);
> +}

> +static int qcom_smgr_iio_read_raw(struct iio_dev *iio_dev,
> +				  struct iio_chan_spec const *chan, int *val,
> +				  int *val2, long mask)
> +{
> +	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
> +
> +	switch (mask) {

No sysfs access at all to data is unusual but not completely unheard of.

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = priv->sensor->data_types[0].cur_sample_rate;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		*val2 = 1 << SMGR_VALUE_DECIMAL_OFFSET;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}

> +
> +static const struct iio_chan_spec qcom_smgr_pressure_iio_channels[] = {
> +	{
> +		.type = IIO_PRESSURE,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_LE,
> +		},
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ)
> +	},
> +	{
> +		.type = IIO_TIMESTAMP,
> +		.channel = -1,
> +		.scan_index = 3,

Why 3?

> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,

If it's realbits 32 and no shift, why not store it in a 32 bit value?
I assume this is a hardware provided timestamp rather than typical software
filled in one?  Anyhow, I'm not immediately spotting it being used yet
so for now perhaps best to drop the channel descriptions.

> +			.storagebits = 64,
> +			.endianness = IIO_LE,
> +		},
> +	}
> +};

> +static int qcom_smgr_register_sensor(struct qcom_smgr *smgr,
> +				     struct qcom_smgr_sensor *sensor)
> +{
> +	struct iio_dev *iio_dev;
> +	struct qcom_smgr_iio_priv *priv;
> +	int ret;

> +	sensor->iio_dev = iio_dev;
> +
> +	ret = devm_iio_kfifo_buffer_setup(smgr->dev, iio_dev,
> +					  &qcom_smgr_buffer_ops);
> +	if (ret) {
> +		dev_err(smgr->dev, "Failed to setup buffer: %pe\n",

Use return dev_err_probe() for all errors that occur in code that only
runs at probe() time.

> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(smgr->dev, iio_dev);
> +	if (ret) {
> +		dev_err(smgr->dev, "Failed to register IIO device: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qcom_smgr_probe(struct qrtr_device *qdev)
> +{
> +	struct qcom_smgr *smgr;
> +	int i, j;
> +	int ret;
> +
> +	smgr = devm_kzalloc(&qdev->dev, sizeof(*smgr), GFP_KERNEL);
> +	if (!smgr)
> +		return -ENOMEM;
> +
> +	smgr->dev = &qdev->dev;
> +
> +	smgr->sns_smgr_info.sq_family = AF_QIPCRTR;
> +	smgr->sns_smgr_info.sq_node = qdev->node;
> +	smgr->sns_smgr_info.sq_port = qdev->port;
> +
> +	dev_set_drvdata(&qdev->dev, smgr);
This code is a bit random on whether it uses qdev->dev, or smgr->dev

I'd be tempted to just introce
	struct device *dev = &qdev->dev; and use that pretty much everywhere.

> +
> +	ret = qmi_handle_init(&smgr->sns_smgr_hdl,
> +			      SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN, NULL,
> +			      qcom_smgr_msg_handlers);
> +	if (ret < 0)
> +		return dev_err_probe(smgr->dev, ret,
> +			"Failed to initialize sensor manager handle\n");
> +
> +	ret = devm_add_action_or_reset(smgr->dev,
> +				       (void(*)(void *))qmi_handle_release,

I'd much prefer a local wrapper to casting types of functions.

> +				       &smgr->sns_smgr_hdl);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_smgr_request_all_sensor_info(smgr, &smgr->sensors);
> +	if (ret < 0)
> +		return dev_err_probe(smgr->dev, ret,
> +			"Failed to get available sensors\n");
> +
> +	smgr->sensor_count = ret;
> +
> +	/* Get primary and secondary sensors from each sensor ID */
> +	for (i = 0; i < smgr->sensor_count; i++) {
> +		ret = qcom_smgr_request_single_sensor_info(smgr,
> +							   &smgr->sensors[i]);
> +		if (ret < 0)
> +			return dev_err_probe(smgr->dev, ret,
> +				"Failed to get sensors from ID 0x%02x\n",
> +				smgr->sensors[i].id);
> +
> +		for (j = 0; j < smgr->sensors[i].data_type_count; j++) {
> +			/* Default to maximum sample rate */
> +			smgr->sensors[i].data_types->cur_sample_rate =
> +				smgr->sensors[i].data_types->max_sample_rate;
> +
> +			dev_dbg(smgr->dev, "0x%02x,%d: %s %s\n",
> +				smgr->sensors[i].id, j,
> +				smgr->sensors[i].data_types[j].vendor,
> +				smgr->sensors[i].data_types[j].name);
> +		}
> +
> +		/* Skip if sensor type is not supported */
> +		if (smgr->sensors[i]->type == SNS_SMGR_SENSOR_TYPE_UNKNOWN ||
> +		    !qcom_smgr_sensor_type_iio_channels[smgr->sensors[i]->type])
> +			continue;
> +
> +		ret = qcom_smgr_register_sensor(smgr, &smgr->sensors[i]);
> +		if (ret)
> +			return dev_err_probe(smgr->dev, ret,
> +				"Failed to register sensor 0x%02x\n",
> +				smgr->sensors[i].id);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct qrtr_device_id qcom_smgr_qrtr_match[] = {
> +	{
> +		.service = SNS_SMGR_QMI_SVC_ID,
> +		/* Found on MSM8953 */
> +		.instance = QRTR_INSTANCE_CONST(0, 1)
> +	},
> +	{
> +		.service = SNS_SMGR_QMI_SVC_ID,
> +		/* Found on MSM8974 and MSM8226 */
> +		.instance = QRTR_INSTANCE_CONST(1, 0)
> +	},
> +	{
> +		.service = SNS_SMGR_QMI_SVC_ID,
> +		/* Found on MSM8996 and SDM660 */
> +		.instance = QRTR_INSTANCE_CONST(1, 50)
> +	},
> +	{ },

No comma on a terminating entry like this.

> +};
> +MODULE_DEVICE_TABLE(qrtr, qcom_smgr_qrtr_match);


> +const struct qmi_elem_info sns_smgr_buffering_report_ind_ei[] = {
> +	{
> +		.data_type = QMI_UNSIGNED_1_BYTE,
> +		.elem_len = 1,
> +		.elem_size = sizeof_field(struct sns_smgr_buffering_report_ind,
> +					  report_id),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x01,
> +		.offset = offsetof(struct sns_smgr_buffering_report_ind,
> +				   report_id),
> +	},
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = 1,
> +		.elem_size = sizeof_field(struct sns_smgr_buffering_report_ind,
> +					  metadata),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x02,
> +		.offset = offsetof(struct sns_smgr_buffering_report_ind,
> +				   metadata),
> +		.ei_array = sns_smgr_buffering_report_metadata_ei,
> +	},
> +	{
> +		.data_type = QMI_DATA_LEN,
> +		.elem_len = 1,
> +		.elem_size = sizeof_field(struct sns_smgr_buffering_report_ind,
> +					  samples_len),
> +		.array_type = NO_ARRAY,
> +		.tlv_type = 0x03,
> +		.offset = offsetof(struct sns_smgr_buffering_report_ind,
> +				   samples_len),
> +	},
> +	{
> +		.data_type = QMI_STRUCT,
> +		.elem_len = SNS_SMGR_SAMPLES_MAX_LEN,
> +		.elem_size = sizeof(struct sns_smgr_buffering_report_sample),
> +		.array_type = VAR_LEN_ARRAY,
> +		.tlv_type = 0x03,
> +		.offset =
> +			offsetof(struct sns_smgr_buffering_report_ind, samples),

I'm fine with slightly over 80 chars to avoid readability issues like this.


> diff --git a/include/linux/iio/common/qcom_smgr.h b/include/linux/iio/common/qcom_smgr.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..fdd3de12bb0a48f1fb9e51cd0463c9a9b9ed500f
> --- /dev/null
> +++ b/include/linux/iio/common/qcom_smgr.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __QCOM_SMGR_H__
> +#define __QCOM_SMGR_H__
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/types.h>

> +
> +struct qcom_smgr_sensor {
> +	u8 id;
> +	enum qcom_smgr_sensor_type type;
> +
> +	u8 data_type_count;
> +	/*
> +	 * Only SNS_SMGR_DATA_TYPE_PRIMARY is used at the moment, but we store
> +	 * SNS_SMGR_DATA_TYPE_SECONDARY when available as well for future use.
> +	 */
> +	struct qcom_smgr_data_type_item *data_types;
> +
> +	struct iio_dev *iio_dev;
> +};
> +
> +struct qcom_smgr_iio_priv {
> +	struct qcom_smgr_sensor *sensor;
> +
> +	int samp_freq_vals[3];
> +};
> +
> +
> +struct qcom_smgr_iio_data {
> +	u32 values[3];
> +	u64 timestamp;

Timestamps in kernel tend to be s64. Also for IIO buffers aligned_s64 required.
Whilst this will probably never be used on an architecture that doesn't naturally
align 8 byte variables, we should still code for it.

Given this tends to be used locally maybe just define it where you need it.


> +};

> 


