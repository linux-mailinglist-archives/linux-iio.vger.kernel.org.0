Return-Path: <linux-iio+bounces-17910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A22A84324
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6859F8C5351
	for <lists+linux-iio@lfdr.de>; Thu, 10 Apr 2025 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E4C284B3F;
	Thu, 10 Apr 2025 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="m4yLvUYK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23A204594
	for <linux-iio@vger.kernel.org>; Thu, 10 Apr 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288304; cv=none; b=fqWNe/ONCtotub+QTWgixOzXGkATV5sJ37PtnjthqTKwtp3bnjapVi3XPidiwxIDVCtQiwRMzsbL0zt6rOcIJpyfxy8j0Yyc3ZBGMnNBuvr85TWn9qQfQWWbd1M1snbuQ5L1lUJcjm2GCP2xYjjOCd8wuYj0hkbcFWMsqF3lYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288304; c=relaxed/simple;
	bh=AXAIrYdA5K7mk9oH7iLRgku0Phzm9I6EG85S7ojTuN8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BjEzmKswDk/CE9/kmrHP9HNosL5Udmh6d1LqzExV0n+CQICXgIwtLMSKCva7XsgSj60VgoN930aT6uc7IqPHkPBcpbsFhLoKFMBFnrgGXcOJLdsgfniys+jp+EXDuePXWRjn0OUgCOwtlttYUoWFk1bfVVL7Uju2bUuu/0Oj4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=m4yLvUYK; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1744288285; x=1744547485;
	bh=BBbzojdEiyMbNG9hhVEUrlBXjHWl+9+yM1n+K6GSnLM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=m4yLvUYKgR68u7hMgL/8IMIQZ4lZvQ0y+5UR5u/hebDunUkTH3af3P4Tunj9YzyT6
	 YPvjXbL34D/mcCQAFPoPbaW+U4DsKvQkH5yy0F2kB/9dhsAVfTaIVNStfWWKQnhVAX
	 mI+jpholZbdUjw9fnjzCVv+HqinTXckuQXHMNv0v0ioDgKN100BbO91DVzCmeEkEHr
	 lNJlRSlA3ahBGUjp5Qr2hmIFuI5o1AE2MuIkndCNs2jpMB20G8lcHdbLlqe8zVcoAM
	 j/vKuzmwyfbeg872pPqy1/XrV5Ie+dvMkP/zaqRtH66zQ6YZP7HtTg+GPNLYjMuyLU
	 TOam9JB9GiNNw==
Date: Thu, 10 Apr 2025 12:31:20 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Sean Nyekjaer <sean@geanix.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Ramona Gradinariu <ramona.gradinariu@analog.com>, "Yo-Jung (Leo) Lin" <0xff07@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, Danila Tikhonov
	<danila@jiaxyga.com>, Antoni Pokusinski <apokusinski01@gmail.com>, Vasileios Amoiridis <vassilisamir@gmail.com>, Petar Stoykov <pd.pstoykov@gmail.com>, shuaijie wang <wangshuaijie@awinic.com>, Yasin Lee <yasin.lee.x@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Yassine Oudjana <yassine.oudjana@gmail.com>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add Qualcomm Sensor Manager drivers
Message-ID: <fc9af95b-abbf-454c-97e1-b884baa5317c@protonmail.com>
In-Reply-To: <20250406172904.1521881e@jic23-huawei>
References: <20250406140706.812425-1-y.oudjana@protonmail.com> <20250406140706.812425-4-y.oudjana@protonmail.com> <20250406172904.1521881e@jic23-huawei>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 57e4469934b6101244ebbe53e5b2a395fe26a34d
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/04/2025 7:29 pm, Jonathan Cameron wrote:
> On Sun, 06 Apr 2025 14:08:03 +0000
> Yassine Oudjana <y.oudjana@protonmail.com> wrote:
>=20
>> Add drivers for sensors exposed by the Qualcomm Sensor Manager service,
>> which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
>> include accelerometers, gyroscopes, pressure sensors, proximity sensors
>> and magnetometers.
>>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   MAINTAINERS                                 |  18 +
>>   drivers/iio/accel/Kconfig                   |  10 +
>>   drivers/iio/accel/Makefile                  |   2 +
>>   drivers/iio/accel/qcom_smgr_accel.c         | 138 ++++
>>   drivers/iio/common/Kconfig                  |   1 +
>>   drivers/iio/common/Makefile                 |   1 +
>>   drivers/iio/common/qcom_smgr/Kconfig        |  16 +
>>   drivers/iio/common/qcom_smgr/Makefile       |   8 +
>>   drivers/iio/common/qcom_smgr/qcom_smgr.c    | 589 ++++++++++++++++
>>   drivers/iio/common/qcom_smgr/qmi/Makefile   |   3 +
>>   drivers/iio/common/qcom_smgr/qmi/sns_smgr.c | 711 ++++++++++++++++++++
>>   drivers/iio/common/qcom_smgr/qmi/sns_smgr.h | 163 +++++
>>   drivers/iio/gyro/Kconfig                    |  10 +
>>   drivers/iio/gyro/Makefile                   |   2 +
>>   drivers/iio/gyro/qcom_smgr_gyro.c           | 138 ++++
>>   drivers/iio/magnetometer/Kconfig            |   9 +
>>   drivers/iio/magnetometer/Makefile           |   2 +
>>   drivers/iio/magnetometer/qcom_smgr_mag.c    | 138 ++++
>>   drivers/iio/pressure/Kconfig                |  10 +
>>   drivers/iio/pressure/Makefile               |   1 +
>>   drivers/iio/pressure/qcom_smgr_pressure.c   | 106 +++
>>   drivers/iio/proximity/Kconfig               |  10 +
>>   drivers/iio/proximity/Makefile              |   1 +
>>   drivers/iio/proximity/qcom_smgr_prox.c      | 106 +++
>>   include/linux/iio/common/qcom_smgr.h        |  64 ++
>>   25 files changed, 2257 insertions(+)
> Split this up.  Common library code first, then
> individual drivers making use of it.

Ack.

>=20
>=20
>>   create mode 100644 drivers/iio/accel/qcom_smgr_accel.c
>>   create mode 100644 drivers/iio/common/qcom_smgr/Kconfig
>>   create mode 100644 drivers/iio/common/qcom_smgr/Makefile
>>   create mode 100644 drivers/iio/common/qcom_smgr/qcom_smgr.c
>>   create mode 100644 drivers/iio/common/qcom_smgr/qmi/Makefile
>>   create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.c
>>   create mode 100644 drivers/iio/common/qcom_smgr/qmi/sns_smgr.h
>>   create mode 100644 drivers/iio/gyro/qcom_smgr_gyro.c
>>   create mode 100644 drivers/iio/magnetometer/qcom_smgr_mag.c
>>   create mode 100644 drivers/iio/pressure/qcom_smgr_pressure.c
>>   create mode 100644 drivers/iio/proximity/qcom_smgr_prox.c
>>   create mode 100644 include/linux/iio/common/qcom_smgr.h
>=20
>=20
>> diff --git a/drivers/iio/accel/qcom_smgr_accel.c b/drivers/iio/accel/qco=
m_smgr_accel.c
>> new file mode 100644
>> index 000000000000..ce854312d1d9
>> --- /dev/null
>> +++ b/drivers/iio/accel/qcom_smgr_accel.c
>> @@ -0,0 +1,138 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Qualcomm Sensor Manager accelerometer driver
>> + *
>> + * Copyright (c) 2022, Yassine Oudjana <y.oudjana@protonmail.com>
> Given ongoing work, a range on that date to go up to this year
> probably makes sense!

Yeah

>=20
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/common/qcom_smgr.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/kfifo_buf.h>
>> +
>> +static const struct iio_chan_spec qcom_smgr_accel_iio_channels[] =3D {
>> +=09{
>> +=09=09.type =3D IIO_ACCEL,
>> +=09=09.modified =3D true,
>> +=09=09.channel2 =3D IIO_MOD_X,
>> +=09=09.scan_index =3D 0,
>> +=09=09.scan_type =3D {
>> +=09=09=09.sign =3D 's',
>> +=09=09=09.realbits =3D 32,
>> +=09=09=09.storagebits =3D 32,
>> +=09=09=09.endianness =3D IIO_LE,
>> +=09=09},
>> +=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
>> +=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +=09=09.ext_info =3D qcom_smgr_iio_ext_info
>> +=09},
>> +=09{
>> +=09=09.type =3D IIO_ACCEL,
>> +=09=09.modified =3D true,
>> +=09=09.channel2 =3D IIO_MOD_Y,
>> +=09=09.scan_index =3D 1,
>> +=09=09.scan_type =3D {
>> +=09=09=09.sign =3D 's',
>> +=09=09=09.realbits =3D 32,
>> +=09=09=09.storagebits =3D 32,
>> +=09=09=09.endianness =3D IIO_LE,
>> +=09=09},
>> +=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
>> +=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +=09=09.ext_info =3D qcom_smgr_iio_ext_info
>> +=09},
>> +=09{
>> +=09=09.type =3D IIO_ACCEL,
>> +=09=09.modified =3D true,
>> +=09=09.channel2 =3D IIO_MOD_Z,
>> +=09=09.scan_index =3D 2,
>> +=09=09.scan_type =3D {
>> +=09=09=09.sign =3D 's',
>> +=09=09=09.realbits =3D 32,
>> +=09=09=09.storagebits =3D 32,
>> +=09=09=09.endianness =3D IIO_LE,
>> +=09=09},
>> +=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
>> +=09=09=09=09=09    BIT(IIO_CHAN_INFO_SAMP_FREQ),
>> +=09=09.ext_info =3D qcom_smgr_iio_ext_info
>> +=09},
>> +=09{
>> +=09=09.type =3D IIO_TIMESTAMP,
>> +=09=09.channel =3D -1,
>> +=09=09.scan_index =3D 3,
>> +=09=09.scan_type =3D {
>> +=09=09=09.sign =3D 'u',
>> +=09=09=09.realbits =3D 32,
>> +=09=09=09.storagebits =3D 64,
>> +=09=09=09.endianness =3D IIO_LE,
>> +=09=09},
>> +=09},
>> +};
>> +
>> +static int qcom_smgr_accel_probe(struct platform_device *pdev)
>> +{
>> +=09struct iio_dev *iio_dev;
>> +=09struct qcom_smgr_iio_priv *priv;
>> +=09int ret;
>> +
>> +=09iio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>> +=09if (!iio_dev)
>> +=09=09return -ENOMEM;
>> +
>> +=09priv =3D iio_priv(iio_dev);
>> +=09priv->sensor =3D *(struct qcom_smgr_sensor **)pdev->dev.platform_dat=
a;
>> +=09priv->sensor->iio_dev =3D iio_dev;
>> +
>> +=09iio_dev->name =3D "qcom-smgr-accel";
>> +=09iio_dev->info =3D &qcom_smgr_iio_info;
>> +=09iio_dev->channels =3D qcom_smgr_accel_iio_channels;
>> +=09iio_dev->num_channels =3D ARRAY_SIZE(qcom_smgr_accel_iio_channels);
>> +
>> +=09ret =3D devm_iio_kfifo_buffer_setup(&pdev->dev, iio_dev,
>> +=09=09=09=09=09  &qcom_smgr_buffer_ops);
>> +=09if (ret) {
>> +=09=09dev_err(&pdev->dev, "Failed to setup buffer: %pe\n",
>> +=09=09=09ERR_PTR(ret));
> For all error message in probe() use
> =09=09return dev_err_probe(&pdev->dev, ERR_PTR(ret), "Failed to setup buf=
fer\n")
> etc.

Ack.

>=20
>> +=09=09return ret;
>> +=09}
>> +
>> +=09ret =3D devm_iio_device_register(&pdev->dev, iio_dev);
>> +=09if (ret) {
>> +=09=09dev_err(&pdev->dev, "Failed to register IIO device: %pe\n",
>> +=09=09=09ERR_PTR(ret));
>> +=09=09return ret;
>> +=09}
>> +
>> +=09platform_set_drvdata(pdev, priv->sensor);
>> +
>> +=09return 0;
>> +}
>> +
>> +static void qcom_smgr_accel_remove(struct platform_device *pdev)
>=20
> I'm surprised to see a platform device here - will read on but I
> doubt that is the way to go.  Maybe an auxbus or similar or
> just squashing this all down to be registered directly by
> the parent driver.
I got the idea from cros_ec_sensors which also deals with a similar=20
sensor hub paradigm.

>=20
>=20
>> +{
>> +=09struct qcom_smgr_sensor *sensor =3D platform_get_drvdata(pdev);
>> +
>> +=09sensor->iio_dev =3D NULL;
>> +}
>> +
>> +static const struct platform_device_id qcom_smgr_accel_ids[] =3D {
>> +=09{ .name =3D "qcom-smgr-accel" },
>> +=09{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, qcom_smgr_accel_ids);
>> +
>> +static struct platform_driver qcom_smgr_accel_driver =3D {
>> +=09.probe =3D qcom_smgr_accel_probe,
>> +=09.remove =3D qcom_smgr_accel_remove,
>> +=09.driver=09=3D {
>> +=09=09.name =3D "qcom_smgr_accel",
>> +=09},
>> +=09.id_table =3D qcom_smgr_accel_ids,
>> +};
>> +module_platform_driver(qcom_smgr_accel_driver);
>> +
>> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
>> +MODULE_DESCRIPTION("Qualcomm Sensor Manager accelerometer driver");
>> +MODULE_LICENSE("GPL");
>=20
>> diff --git a/drivers/iio/common/qcom_smgr/qcom_smgr.c b/drivers/iio/comm=
on/qcom_smgr/qcom_smgr.c
>> new file mode 100644
>> index 000000000000..8d46be11d5b6
>> --- /dev/null
>> +++ b/drivers/iio/common/qcom_smgr/qcom_smgr.c
>> @@ -0,0 +1,589 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Qualcomm Sensor Manager core driver
>> + *
>> + * Copyright (c) 2021, Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> As above, I'd add a date range to reflect that this is ongoing.

Ack.

>=20
>> + */
>> +
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/common/qcom_smgr.h>
>> +#include <linux/iio/iio.h>
>=20
> Be consistent with ordering. Above you have iio as a separate block.
> Either option is fine, but not a mixture.

Ack.

>=20
>> +#include <linux/math64.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
> Unless there are very strong reasons for of specific code please
> use property.h and the generic firmware accessors.

Ack.

>=20
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc/qcom_rproc.h>
>> +#include <linux/soc/qcom/qmi.h>
>> +#include <linux/soc/qcom/qrtr.h>
>> +#include <linux/types.h>
>> +#include <net/sock.h>
>=20
>=20
>> +static void qcom_smgr_buffering_report_handler(struct qmi_handle *hdl,
>> +=09=09=09=09=09       struct sockaddr_qrtr *sq,
>> +=09=09=09=09=09       struct qmi_txn *txn,
>> +=09=09=09=09=09       const void *data)
>> +{
>> +=09struct qcom_smgr *smgr =3D
>> +=09=09container_of(hdl, struct qcom_smgr, sns_smgr_hdl);
>> +=09struct sns_smgr_buffering_report_ind *ind =3D
>> +=09=09(struct sns_smgr_buffering_report_ind *)data;
>=20
> Casting away a const isn't a good sign. Why do you need to do that?
> =09const struct sns_smg_buffer_repor_ind *ind =3D data;
> should be fine I think.

The casted struct was previously not const so I was only casting from=20
void *. I made it const lately but didn't notice this cast. Will change it.

>=20
>=20
>> +=09struct qcom_smgr_sensor *sensor;
>> +=09u8 i;
>> +
>> +=09for (i =3D 0; i < smgr->sensor_count; ++i) {
>> +=09=09sensor =3D &smgr->sensors[i];
>> +
>> +=09=09/* Find sensor matching report */
>> +=09=09if (sensor->id !=3D ind->report_id)
>> +=09=09=09continue;
>> +
>> +=09=09if (!sensor->iio_dev)
>> +=09=09=09/* Corresponding driver was unloaded. Ignore remaining reports=
. */
>> +=09=09=09return;
>> +
>> +=09=09/*
>> +=09=09 * Since we are matching report rate with sample rate, we only
>> +=09=09 * get a single sample in every report.
>> +=09=09 */
>> +=09=09iio_push_to_buffers_with_timestamp(sensor->iio_dev,
>> +=09=09=09=09=09=09   ind->samples[0].values,
>> +=09=09=09=09=09=09   ind->metadata.timestamp);
> You are using a 64 bit timestamp writer that doesn't know about the endia=
nness of
> that timestamp. I'd not do this.  Just write the timestamp in like any no=
rmal
> channel and call iio_push_to_buffers().

Will look into it.

>=20
>> +
>> +=09=09break;
>=20
> return;
>=20
>> +=09}
>> +}
>> +
>> +static const struct qmi_msg_handler qcom_smgr_msg_handlers[] =3D {
>> +=09{
>> +=09=09.type =3D QMI_INDICATION,
>> +=09=09.msg_id =3D SNS_SMGR_BUFFERING_REPORT_MSG_ID,
>> +=09=09.ei =3D sns_smgr_buffering_report_ind_ei,
>> +=09=09.decoded_size =3D sizeof(struct sns_smgr_buffering_report_ind),
>> +=09=09.fn =3D qcom_smgr_buffering_report_handler,
>> +=09},
>> +=09{}
> =09{ }
>=20
> given it's in IIO and I get to pick silly formatting rules.
> More seriously I wanted this consistent so picked a choice mostly at rand=
om.

No objections on my side.

>=20
>> +};
>=20
>> +
>> +static int qcom_smgr_iio_write_raw(struct iio_dev *iio_dev,
>> +=09=09=09=09   struct iio_chan_spec const *chan, int val,
>> +=09=09=09=09   int val2, long mask)
>> +{
>> +=09struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
>> +
>> +=09switch (mask) {
>> +=09case IIO_CHAN_INFO_SAMP_FREQ:
>> +=09=09priv->sensor->data_types[0].cur_sample_rate =3D val;
>> +
>> +=09=09/*
>> +=09=09 * Send new SMGR buffering request with updated rates
>> +=09=09 * if buffer is enabled
>> +=09=09 */
>> +=09=09if (iio_buffer_enabled(iio_dev))
>> +=09=09=09return iio_dev->setup_ops->postenable(iio_dev);
>=20
> Generally we'd just refuse to set the sampling frequency.
> This is racy as nothing holds the buffer enabled.
> So I'd do
> =09=09if (!iio_device_claim_direct(iio_dev);
> =09=09=09return -EBUSY;
>=20
> =09=09priv->sensor->data_types[0].cur_sample_rate =3D val;
> =09=09iio_device_release_diect(iio_dev);
>=20
> Change sampling frequency when doing buffered capture is really confusing
> anyway for userspace software as it has no way to know when the
> change occurred so just don't bother supporting that.

Makes sense.

>=20
>> +
>> +=09=09return 0;
>> +=09}
>> +
>> +=09return -EINVAL;
> Put this in a default in the switch.  That makes it clear we don't
> expect to see anything else.
> Same for other similar cases above.

Ack.

>=20
>> +}
>> +
>> +static int qcom_smgr_iio_read_avail(struct iio_dev *iio_dev,
>> +=09=09=09=09    struct iio_chan_spec const *chan,
>> +=09=09=09=09    const int **vals, int *type, int *length,
>> +=09=09=09=09    long mask)
>> +{
>> +=09struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
>> +=09const int samp_freq_vals[3] =3D {
>> +=09=091, 1, priv->sensor->data_types[0].cur_sample_rate
>> +=09};
>=20
> Lifetime of this needs to last beyond the end of this call as some users
> or read_avail hang on to it.  Embed the storage in your priv
> structure rather than local in this function.

Ack.

> I'm also a little confused how the maximum comes from something called cu=
r_sample_rate.

This was max_sample_rate previously but at some point while trying to=20
understand how the sampling rate works on the SMGR side I removed=20
max_sample_rate and replaced it here with cur_sample_rate without=20
understanding what I was changing. When I brought back max_sample_rate I=20
missed this change. Will change it back.

>=20
>> +
>> +=09switch (mask) {
>> +=09case IIO_CHAN_INFO_SAMP_FREQ:
>> +=09=09*type =3D IIO_VAL_INT;
>> +=09=09*vals =3D samp_freq_vals;
>> +=09=09*length =3D ARRAY_SIZE(samp_freq_vals);
>> +=09=09return IIO_AVAIL_RANGE;
>> +=09}
>> +
>> +=09return -EINVAL;
>> +}
>=20
> ...
>=20
>> +const struct iio_chan_spec_ext_info qcom_smgr_iio_ext_info[] =3D {
>> +=09IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, qcom_smgr_iio_get_mount_matrix),
>> +=09{}
> trivial but I'm trying to standardize on
> =09{ }
> for this in IIO.

Ack.

>=20
>> +};
>> +EXPORT_SYMBOL_GPL(qcom_smgr_iio_ext_info);
>> +
>> +static int qcom_smgr_probe(struct qrtr_device *qdev)
>> +{
>> +=09struct qcom_smgr *smgr;
>> +=09int i, j;
>> +=09int ret;
>> +
>> +=09smgr =3D devm_kzalloc(&qdev->dev, sizeof(*smgr), GFP_KERNEL);
>> +=09if (!smgr)
>> +=09=09return -ENOMEM;
>> +
>> +=09smgr->dev =3D &qdev->dev;
>> +
>> +=09smgr->sns_smgr_info.sq_family =3D AF_QIPCRTR;
>> +=09smgr->sns_smgr_info.sq_node =3D qdev->node;
>> +=09smgr->sns_smgr_info.sq_port =3D qdev->port;
>> +
>> +=09dev_set_drvdata(&qdev->dev, smgr);
>> +
>> +=09ret =3D qmi_handle_init(&smgr->sns_smgr_hdl,
>> +=09=09=09      SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN, NULL,
>> +=09=09=09      qcom_smgr_msg_handlers);
> On error this handle doesn't seem to be released.

Will fix.

>=20
>> +=09if (ret < 0) {
>> +=09=09dev_err(smgr->dev,
>> +=09=09=09"Failed to initialize sensor manager handle: %d\n",
>> +=09=09=09ret);
>> +=09=09return ret;
>=20
> return dev_err_probe()
> Same in all other similar cases that are only called from probe.

Ack.

>=20
>> +=09}
>> +
>> +=09ret =3D qcom_smgr_request_all_sensor_info(smgr, &smgr->sensors);
>> +=09if (ret < 0) {
>> +=09=09dev_err(smgr->dev, "Failed to get available sensors: %pe\n",
>> +=09=09=09ERR_PTR(ret));
>> +=09=09return ret;
>> +=09}
>> +=09smgr->sensor_count =3D ret;
>> +
>> +=09/* Get primary and secondary sensors from each sensor ID */
>> +=09for (i =3D 0; i < smgr->sensor_count; i++) {
>> +=09=09ret =3D qcom_smgr_request_single_sensor_info(smgr,
>> +=09=09=09=09=09=09=09   &smgr->sensors[i]);
>> +=09=09if (ret < 0) {
>> +=09=09=09dev_err(smgr->dev,
>> +=09=09=09=09"Failed to get sensors from ID 0x%02x: %pe\n",
>> +=09=09=09=09smgr->sensors[i].id, ERR_PTR(ret));
>> +=09=09=09return ret;
>> +=09=09}
>> +
>> +=09=09for (j =3D 0; j < smgr->sensors[i].data_type_count; j++) {
>> +=09=09=09/* Default to maximum sample rate */
>> +=09=09=09smgr->sensors[i].data_types->cur_sample_rate =3D
>> +=09=09=09=09smgr->sensors[i].data_types->max_sample_rate;
>> +
>> +=09=09=09dev_dbg(smgr->dev, "0x%02x,%d: %s %s\n",
>> +=09=09=09=09smgr->sensors[i].id, j,
>> +=09=09=09=09smgr->sensors[i].data_types[j].vendor,
>> +=09=09=09=09smgr->sensors[i].data_types[j].name);
>> +=09=09}
>> +
>> +=09=09qcom_smgr_register_sensor(smgr, &smgr->sensors[i]);
> Above I suggest that maybe you should just skip the platform devices and =
register
> directly with IIO as you find the sensors. So have the struct iio_dev->de=
vice
> parent directly off this one.

As I said previously I followed the model used in cros_ec_sensors, and=20
it made sense to me since I always see platform devices used to=20
represent firmware-backed devices like this.

>=20
>> +=09}
>> +
>> +=09return 0;
>> +}
>> +
>> +static void qcom_smgr_remove(struct qrtr_device *qdev)
>> +{
>> +=09struct qcom_smgr *smgr =3D dev_get_drvdata(&qdev->dev);
>> +
>> +=09qmi_handle_release(&smgr->sns_smgr_hdl);
> If that is all you have, use a devm_add_action_or_reset() to
> register a handler and drop this remove entirely.

Ack.

>=20
>> +}
>> +
>> +static const struct qrtr_device_id qcom_smgr_qrtr_match[] =3D {
>> +=09{
>> +=09=09.service =3D SNS_SMGR_QMI_SVC_ID,
>> +=09=09.instance =3D QRTR_INSTANCE(SNS_SMGR_QMI_SVC_V1,
>> +=09=09=09=09=09  SNS_SMGR_QMI_INS_ID)
>> +=09},
>> +=09{},
> =09{ }
>=20
> for IIO terminating entries like this.

Ack.

>=20
>> +};
>> +MODULE_DEVICE_TABLE(qrtr, qcom_smgr_qrtr_match);


