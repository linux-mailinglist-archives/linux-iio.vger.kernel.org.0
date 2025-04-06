Return-Path: <linux-iio+bounces-17683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC24A7CEF6
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 18:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4BB188DBDA
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A7315B554;
	Sun,  6 Apr 2025 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV+8GDZE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F028373;
	Sun,  6 Apr 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743956959; cv=none; b=ithBN1RQ0z2ALeJTjohdrq9um5a38erehdbxw7zgFiub7H/ckl8PhhW2bhrAxBGnng2aUsisaLujOUkKbLCM9dJyJQHyXnjpi1zGh3Zt2SSfgVv4REWpKDFG+ctCQVuurD0OWcfzLt9J5CKZ4d7GhkjwT2OVRm/O77mhyy5JbRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743956959; c=relaxed/simple;
	bh=b/xAVnixHXUXt03p0bDzhsloPHIQmMn6KiJbzG70nj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nE3ZGNrJeuJ8Gk74Uqg/VXZTqo+r2UO2tKs472QSL+6ndRUJ+xsfNs9jJ0GuFmmkZ5hqpvlggmFhA0gofNDli9k35ZjUHNcYLk9Xm/gHgAjrTnb/ft98IU/jXHeI2ZwW1kEPs2ACh2oQiRMTX3uC4nme/pNms55BZrpaoSvWjOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV+8GDZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA68C4CEE3;
	Sun,  6 Apr 2025 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743956958;
	bh=b/xAVnixHXUXt03p0bDzhsloPHIQmMn6KiJbzG70nj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GV+8GDZEdgt6dp9EKFLEoj6rSx/zxTeLVMdkfCgaMD/s+xpIA6WLEydx+RDrjk6h1
	 8p0ez0B/tOKfETRJqEZxTopc2cEh3FCdGC7ftlfewItNeNc95tJVIR0y9EeDFpLpbB
	 Qy3joaBOIlidLbhOlttrwCpim1lHOTsyXPo1r0G/lSqz8opKSFgavCnfJ3LDSDDvtF
	 0tUVgJ6BA5gO2YKeudNIbPKzQ9XhAU9aXtSgECp3UEdjaNPJcjvDKr0g+qb3JGG/g7
	 ptt6H3I0gBFlQOE9QA7ho1Xrl5l1MOtKTPxdF0DirtMUsVo/4QEsCIMOdP71FL7eZb
	 mC/h/8QznOskQ==
Date: Sun, 6 Apr 2025 17:29:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer
 <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <barnabas.czeman@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>,
 Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie
 wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add Qualcomm Sensor Manager drivers
Message-ID: <20250406172904.1521881e@jic23-huawei>
In-Reply-To: <20250406140706.812425-4-y.oudjana@protonmail.com>
References: <20250406140706.812425-1-y.oudjana@protonmail.com>
	<20250406140706.812425-4-y.oudjana@protonmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Apr 2025 14:08:03 +0000
Yassine Oudjana <y.oudjana@protonmail.com> wrote:

> Add drivers for sensors exposed by the Qualcomm Sensor Manager service,
> which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> include accelerometers, gyroscopes, pressure sensors, proximity sensors
> and magnetometers.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  MAINTAINERS                                 |  18 +
>  drivers/iio/accel/Kconfig                   |  10 +
>  drivers/iio/accel/Makefile                  |   2 +
>  drivers/iio/accel/qcom_smgr_accel.c         | 138 ++++
>  drivers/iio/common/Kconfig                  |   1 +
>  drivers/iio/common/Makefile                 |   1 +
>  drivers/iio/common/qcom_smgr/Kconfig        |  16 +
>  drivers/iio/common/qcom_smgr/Makefile       |   8 +
>  drivers/iio/common/qcom_smgr/qcom_smgr.c    | 589 ++++++++++++++++
>  drivers/iio/common/qcom_smgr/qmi/Makefile   |   3 +
>  drivers/iio/common/qcom_smgr/qmi/sns_smgr.c | 711 ++++++++++++++++++++
>  drivers/iio/common/qcom_smgr/qmi/sns_smgr.h | 163 +++++
>  drivers/iio/gyro/Kconfig                    |  10 +
>  drivers/iio/gyro/Makefile                   |   2 +
>  drivers/iio/gyro/qcom_smgr_gyro.c           | 138 ++++
>  drivers/iio/magnetometer/Kconfig            |   9 +
>  drivers/iio/magnetometer/Makefile           |   2 +
>  drivers/iio/magnetometer/qcom_smgr_mag.c    | 138 ++++
>  drivers/iio/pressure/Kconfig                |  10 +
>  drivers/iio/pressure/Makefile               |   1 +
>  drivers/iio/pressure/qcom_smgr_pressure.c   | 106 +++
>  drivers/iio/proximity/Kconfig               |  10 +
>  drivers/iio/proximity/Makefile              |   1 +
>  drivers/iio/proximity/qcom_smgr_prox.c      | 106 +++
>  include/linux/iio/common/qcom_smgr.h        |  64 ++
>  25 files changed, 2257 insertions(+)
Split this up.  Common library code first, then
individual drivers making use of it.


>  create mode 100644 drivers/iio/accel/qcom_smgr_accel.c
>  create mode 100644 drivers/iio/common/qcom_smgr/Kconfig
>  create mode 100644 drivers/iio/common/qcom_smgr/Makefile
>  create mode 100644 drivers/iio/common/qcom_smgr/qcom_smgr.c
>  create mode 100644 drivers/iio/common/qcom_smgr/qmi/Makefile
>  create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.c
>  create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
>  create mode 100644 drivers/iio/gyro/qcom_smgr_gyro.c
>  create mode 100644 drivers/iio/magnetometer/qcom_smgr_mag.c
>  create mode 100644 drivers/iio/pressure/qcom_smgr_pressure.c
>  create mode 100644 drivers/iio/proximity/qcom_smgr_prox.c
>  create mode 100644 include/linux/iio/common/qcom_smgr.h


> diff --git a/drivers/iio/accel/qcom_smgr_accel.c b/drivers/iio/accel/qcom_smgr_accel.c
> new file mode 100644
> index 000000000000..ce854312d1d9
> --- /dev/null
> +++ b/drivers/iio/accel/qcom_smgr_accel.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm Sensor Manager accelerometer driver
> + *
> + * Copyright (c) 2022, Yassine Oudjana <y.oudjana@protonmail.com>
Given ongoing work, a range on that date to go up to this year
probably makes sense!

> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/qcom_smgr.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
> +
> +static const struct iio_chan_spec qcom_smgr_accel_iio_channels[] = {
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = true,
> +		.channel2 = IIO_MOD_X,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_LE,
> +		},
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.ext_info = qcom_smgr_iio_ext_info
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = true,
> +		.channel2 = IIO_MOD_Y,
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_LE,
> +		},
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.ext_info = qcom_smgr_iio_ext_info
> +	},
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = true,
> +		.channel2 = IIO_MOD_Z,
> +		.scan_index = 2,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_LE,
> +		},
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +					    BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.ext_info = qcom_smgr_iio_ext_info
> +	},
> +	{
> +		.type = IIO_TIMESTAMP,
> +		.channel = -1,
> +		.scan_index = 3,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 64,
> +			.endianness = IIO_LE,
> +		},
> +	},
> +};
> +
> +static int qcom_smgr_accel_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *iio_dev;
> +	struct qcom_smgr_iio_priv *priv;
> +	int ret;
> +
> +	iio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(iio_dev);
> +	priv->sensor = *(struct qcom_smgr_sensor **)pdev->dev.platform_data;
> +	priv->sensor->iio_dev = iio_dev;
> +
> +	iio_dev->name = "qcom-smgr-accel";
> +	iio_dev->info = &qcom_smgr_iio_info;
> +	iio_dev->channels = qcom_smgr_accel_iio_channels;
> +	iio_dev->num_channels = ARRAY_SIZE(qcom_smgr_accel_iio_channels);
> +
> +	ret = devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
> +					  &qcom_smgr_buffer_ops);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
> +			ERR_PTR(ret));
For all error message in probe() use
		return dev_err_probe(&pdev->dev, ERR_PTR(ret), "Failed to setup buffer\n")
etc.

> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&pdev->dev, iio_dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, priv->sensor);
> +
> +	return 0;
> +}
> +
> +static void qcom_smgr_accel_remove(struct platform_device *pdev)

I'm surprised to see a platform device here - will read on but I
doubt that is the way to go.  Maybe an auxbus or similar or
just squashing this all down to be registered directly by
the parent driver.


> +{
> +	struct qcom_smgr_sensor *sensor = platform_get_drvdata(pdev);
> +
> +	sensor->iio_dev = NULL;
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

> diff --git a/drivers/iio/common/qcom_smgr/qcom_smgr.c b/drivers/iio/common/qcom_smgr/qcom_smgr.c
> new file mode 100644
> index 000000000000..8d46be11d5b6
> --- /dev/null
> +++ b/drivers/iio/common/qcom_smgr/qcom_smgr.c
> @@ -0,0 +1,589 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Qualcomm Sensor Manager core driver
> + *
> + * Copyright (c) 2021, Yassine Oudjana <y.oudjana@protonmail.com>

As above, I'd add a date range to reflect that this is ongoing.

> + */
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/common/qcom_smgr.h>
> +#include <linux/iio/iio.h>

Be consistent with ordering. Above you have iio as a separate block.
Either option is fine, but not a mixture.

> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
Unless there are very strong reasons for of specific code please
use property.h and the generic firmware accessors.

> +#include <linux/platform_device.h>
> +#include <linux/remoteproc/qcom_rproc.h>
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/soc/qcom/qrtr.h>
> +#include <linux/types.h>
> +#include <net/sock.h>


> +static void qcom_smgr_buffering_report_handler(struct qmi_handle *hdl,
> +					       struct sockaddr_qrtr *sq,
> +					       struct qmi_txn *txn,
> +					       const void *data)
> +{
> +	struct qcom_smgr *smgr =
> +		container_of(hdl, struct qcom_smgr, sns_smgr_hdl);
> +	struct sns_smgr_buffering_report_ind *ind =
> +		(struct sns_smgr_buffering_report_ind *)data;

Casting away a const isn't a good sign. Why do you need to do that?
	const struct sns_smg_buffer_repor_ind *ind = data;
should be fine I think.


> +	struct qcom_smgr_sensor *sensor;
> +	u8 i;
> +
> +	for (i = 0; i < smgr->sensor_count; ++i) {
> +		sensor = &smgr->sensors[i];
> +
> +		/* Find sensor matching report */
> +		if (sensor->id != ind->report_id)
> +			continue;
> +
> +		if (!sensor->iio_dev)
> +			/* Corresponding driver was unloaded. Ignore remaining reports. */
> +			return;
> +
> +		/*
> +		 * Since we are matching report rate with sample rate, we only
> +		 * get a single sample in every report.
> +		 */
> +		iio_push_to_buffers_with_timestamp(sensor->iio_dev,
> +						   ind->samples[0].values,
> +						   ind->metadata.timestamp);
You are using a 64 bit timestamp writer that doesn't know about the endianness of
that timestamp. I'd not do this.  Just write the timestamp in like any normal
channel and call iio_push_to_buffers().

> +
> +		break;

return;

> +	}
> +}
> +
> +static const struct qmi_msg_handler qcom_smgr_msg_handlers[] = {
> +	{
> +		.type = QMI_INDICATION,
> +		.msg_id = SNS_SMGR_BUFFERING_REPORT_MSG_ID,
> +		.ei = sns_smgr_buffering_report_ind_ei,
> +		.decoded_size = sizeof(struct sns_smgr_buffering_report_ind),
> +		.fn = qcom_smgr_buffering_report_handler,
> +	},
> +	{}
	{ }

given it's in IIO and I get to pick silly formatting rules.
More seriously I wanted this consistent so picked a choice mostly at random.

> +};

> +
> +static int qcom_smgr_iio_write_raw(struct iio_dev *iio_dev,
> +				   struct iio_chan_spec const *chan, int val,
> +				   int val2, long mask)
> +{
> +	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		priv->sensor->data_types[0].cur_sample_rate = val;
> +
> +		/*
> +		 * Send new SMGR buffering request with updated rates
> +		 * if buffer is enabled
> +		 */
> +		if (iio_buffer_enabled(iio_dev))
> +			return iio_dev->setup_ops->postenable(iio_dev);

Generally we'd just refuse to set the sampling frequency.
This is racy as nothing holds the buffer enabled.
So I'd do
		if (!iio_device_claim_direct(iio_dev);
			return -EBUSY;

		priv->sensor->data_types[0].cur_sample_rate = val;
		iio_device_release_diect(iio_dev);
		
Change sampling frequency when doing buffered capture is really confusing
anyway for userspace software as it has no way to know when the
change occurred so just don't bother supporting that.

> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
Put this in a default in the switch.  That makes it clear we don't
expect to see anything else.
Same for other similar cases above.

> +}
> +
> +static int qcom_smgr_iio_read_avail(struct iio_dev *iio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    const int **vals, int *type, int *length,
> +				    long mask)
> +{
> +	struct qcom_smgr_iio_priv *priv = iio_priv(iio_dev);
> +	const int samp_freq_vals[3] = {
> +		1, 1, priv->sensor->data_types[0].cur_sample_rate
> +	};

Lifetime of this needs to last beyond the end of this call as some users
or read_avail hang on to it.  Embed the storage in your priv
structure rather than local in this function. I'm also a little confused
how the maximum comes from something called cur_sample_rate.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT;
> +		*vals = samp_freq_vals;
> +		*length = ARRAY_SIZE(samp_freq_vals);
> +		return IIO_AVAIL_RANGE;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +const struct iio_chan_spec_ext_info qcom_smgr_iio_ext_info[] = {
> +	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, qcom_smgr_iio_get_mount_matrix),
> +	{}
trivial but I'm trying to standardize on
	{ }
for this in IIO.

> +};
> +EXPORT_SYMBOL_GPL(qcom_smgr_iio_ext_info);
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
> +
> +	ret = qmi_handle_init(&smgr->sns_smgr_hdl,
> +			      SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN, NULL,
> +			      qcom_smgr_msg_handlers);
On error this handle doesn't seem to be released.

> +	if (ret < 0) {
> +		dev_err(smgr->dev,
> +			"Failed to initialize sensor manager handle: %d\n",
> +			ret);
> +		return ret;

return dev_err_probe()
Same in all other similar cases that are only called from probe.

> +	}
> +
> +	ret = qcom_smgr_request_all_sensor_info(smgr, &smgr->sensors);
> +	if (ret < 0) {
> +		dev_err(smgr->dev, "Failed to get available sensors: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +	smgr->sensor_count = ret;
> +
> +	/* Get primary and secondary sensors from each sensor ID */
> +	for (i = 0; i < smgr->sensor_count; i++) {
> +		ret = qcom_smgr_request_single_sensor_info(smgr,
> +							   &smgr->sensors[i]);
> +		if (ret < 0) {
> +			dev_err(smgr->dev,
> +				"Failed to get sensors from ID 0x%02x: %pe\n",
> +				smgr->sensors[i].id, ERR_PTR(ret));
> +			return ret;
> +		}
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
> +		qcom_smgr_register_sensor(smgr, &smgr->sensors[i]);
Above I suggest that maybe you should just skip the platform devices and register
directly with IIO as you find the sensors. So have the struct iio_dev->device
parent directly off this one.

> +	}
> +
> +	return 0;
> +}
> +
> +static void qcom_smgr_remove(struct qrtr_device *qdev)
> +{
> +	struct qcom_smgr *smgr = dev_get_drvdata(&qdev->dev);
> +
> +	qmi_handle_release(&smgr->sns_smgr_hdl);
If that is all you have, use a devm_add_action_or_reset() to
register a handler and drop this remove entirely.

> +}
> +
> +static const struct qrtr_device_id qcom_smgr_qrtr_match[] = {
> +	{
> +		.service = SNS_SMGR_QMI_SVC_ID,
> +		.instance = QRTR_INSTANCE(SNS_SMGR_QMI_SVC_V1,
> +					  SNS_SMGR_QMI_INS_ID)
> +	},
> +	{},
	{ }

for IIO terminating entries like this.

> +};
> +MODULE_DEVICE_TABLE(qrtr, qcom_smgr_qrtr_match);

