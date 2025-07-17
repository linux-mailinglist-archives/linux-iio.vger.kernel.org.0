Return-Path: <linux-iio+bounces-21749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB25AB08F7F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587D5584B3E
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589A72F7CF5;
	Thu, 17 Jul 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="dxRP0qCh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23B14E2E2;
	Thu, 17 Jul 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762697; cv=none; b=m1tpp0m0lkw3+yAvTlVD+etHU1L8T8tTOuyOa+7+ySFp2yt5sStVD+w5fKPSyhM38zTDD5mWCGvLjIEBpduc1TQSTeOzVwkaSxeVu2eMZ+JRiMPSHn+RGC3y8PbCy4s0kEIw3o7pQOSBVQvmmnep1RDwDDj1jfjOgcDWzvU73h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762697; c=relaxed/simple;
	bh=NdwNFXWtMogRp4YWUYMbunBRN567VkQcaxeX/3skx4o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Et8QZ8g9E1GvbRWvjms+wlhVfyj51hZJCYCyGSLHrJpglEOJ0bHWImM69Y6drzrnCx6k0jFhgf8VTH1eOR+Nr12JZmSpTH/k4oJyoeDcZptDZs8ptzo/fVP6a85NiEqMI85dkAKkw8HE3Sd5zPsNEV+Y/7zF94Cp1Z5l5v8iHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=dxRP0qCh; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1752762684; x=1753021884;
	bh=NdwNFXWtMogRp4YWUYMbunBRN567VkQcaxeX/3skx4o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dxRP0qCh16Y5Ztd7oq3YG+BllVeTLxAFBOqfvlfxkAl4C6x8jlpc1mu0hVcwdfdXK
	 lNhbPK/Nhrhr4CnygyNDoTAlyFPBYNXH2bjcOJrXtmxZp5OoBCZ605/p/LRJ4YvynS
	 J57aAHg0Lcl+Gc5ZB1Qia1ISz9LeHpUnqFS08nTiwu24KdzOXdm+w1JFmTGJ469DdQ
	 aW/DPYhu4klf1Sl1QpoGTIhfnw2iXHbZk+7rjLaeBshjaA8n7TDmXandybxMgyERLx
	 I/I7gGvo+xy/zy2qFy3dVtTmwjL82mlr86f6xqZIHwS0DcHRKC8eFHoJeXkMDfKoEj
	 b60DEl1JHt69g==
Date: Thu, 17 Jul 2025 14:31:17 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana via B4 Relay <devnull+y.oudjana.protonmail.com@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: Add Qualcomm Sensor Manager driver
Message-ID: <nSoiRmruHeLNNxpRCxJ5M5aQ-Vx7lE3U9wtVwYh6MVZHr0pkk9Cwl5ggSN3xAZ09zA8bk_RJS6mRAgxWkCIrNGogaElh4x8VKaQPO_Rzrqs=@protonmail.com>
In-Reply-To: <20250713164033.3488db3c@jic23-huawei>
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com> <20250710-qcom-smgr-v2-4-f6e198b7aa8e@protonmail.com> <20250713164033.3488db3c@jic23-huawei>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 9b818cdac7c7487394e950d685285a7caa2b039a
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, July 13th, 2025 at 4:40 PM, Jonathan Cameron <jic23@kernel.org> =
wrote:

> On Thu, 10 Jul 2025 09:06:30 +0100
> Yassine Oudjana via B4 Relay devnull+y.oudjana.protonmail.com@kernel.org =
wrote:
>=20
> > From: Yassine Oudjana y.oudjana@protonmail.com
> >=20
> > Add a driver for sensors exposed by the Qualcomm Sensor Manager service=
,
> > which is provided by SLPI or ADSP on Qualcomm SoCs. Supported sensors
> > include accelerometers, gyroscopes, pressure sensors, proximity sensors
> > and magnetometers.
> >=20
> > Signed-off-by: Yassine Oudjana y.oudjana@protonmail.com
>=20
>=20
> As Andy commented - this is big. Break it up for v3.

Ok

>=20
> So far I haven't understood why a separate accelerometer driver was neces=
sary.
> Some comments in the patch description would perhaps help me understand t=
hat.

That was not supposed to be here still. My bad.

>=20
> > diff --git a/drivers/iio/accel/qcom_smgr_accel.c b/drivers/iio/accel/qc=
om_smgr_accel.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..ce854312d1d9386300785f1=
965d5886c16995806
> > --- /dev/null
> > +++ b/drivers/iio/accel/qcom_smgr_accel.c
> > @@ -0,0 +1,138 @@
>=20
>=20
>=20
> > +static void qcom_smgr_accel_remove(struct platform_device *pdev)
> > +{
> > + struct qcom_smgr_sensor *sensor =3D platform_get_drvdata(pdev);
> > +
> > + sensor->iio_dev =3D NULL;
>=20
>=20
> Add a comment for why this is needed. I can't immediately spot anything
> explicitly checking it so it doesn't seem to be about safe handling
> of device removal or similar.
>=20
> > +}
> > +
> > +static const struct platform_device_id qcom_smgr_accel_ids[] =3D {
> > + { .name =3D "qcom-smgr-accel" },
> > + { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(platform, qcom_smgr_accel_ids);
> > +
> > +static struct platform_driver qcom_smgr_accel_driver =3D {
> > + .probe =3D qcom_smgr_accel_probe,
> > + .remove =3D qcom_smgr_accel_remove,
> > + .driver =3D {
> > + .name =3D "qcom_smgr_accel",
> > + },
> > + .id_table =3D qcom_smgr_accel_ids,
> > +};
> > +module_platform_driver(qcom_smgr_accel_driver);
> > +
> > +MODULE_AUTHOR("Yassine Oudjana y.oudjana@protonmail.com");
> > +MODULE_DESCRIPTION("Qualcomm Sensor Manager accelerometer driver");
> > +MODULE_LICENSE("GPL");
>=20
>=20
> I'm struggling to understand what the relationship between this driver
> the main sensor driver is.
>=20
> > diff --git a/drivers/iio/common/qcom_smgr/qcom_smgr.c b/drivers/iio/com=
mon/qcom_smgr/qcom_smgr.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..79d1160f7a5c32f1a9e0a20=
f29e304e5cb18be8f
> > --- /dev/null
> > +++ b/drivers/iio/common/qcom_smgr/qcom_smgr.c
> > @@ -0,0 +1,840 @@
>=20
> > +static void qcom_smgr_buffering_report_handler(struct qmi_handle *hdl,
> > + struct sockaddr_qrtr *sq,
> > + struct qmi_txn *txn,
> > + const void *data)
> > +{
> > + struct qcom_smgr *smgr =3D
> > + container_of(hdl, struct qcom_smgr, sns_smgr_hdl);
> > + const struct sns_smgr_buffering_report_ind *ind =3D data;
> > + struct qcom_smgr_sensor sensor;
> > + struct qcom_smgr_iio_data iio_data;
> > + int temp;
> > + u8 i, j;
> > +
> > + for (i =3D 0; i < smgr->sensor_count; ++i) {
> > + sensor =3D &smgr->sensors[i];
> > +
> > + / Find sensor matching report /
> > + if (sensor->id =3D=3D ind->report_id)
> > + break;
> > + }
> > +
> > + if (i =3D=3D smgr->sensor_count) {
> > + dev_warn_ratelimited(smgr->dev,
> > + "Received buffering report with unknown ID: %02x",
> > + ind->report_id);
> > + return;
> > + }
> > +
> > + /
> > + * Construct data to be passed to IIO. Since we are matching report ra=
te
> > + * with sample rate, we only get a single sample in every report.
> > + /
> > + for (j =3D 0; j < ARRAY_SIZE(ind->samples[0].values); ++j)
> > + iio_data.values[j] =3D ind->samples[0].values[j];
> > +
> > + /
> > + * SMGR reports sensor data in 32-bit fixed-point values, with 16 bits
> > + * holding the integer part and the other 16 bits holding the numerato=
r
> > + * of a fraction with the denominator 2**16.
> > + *
> > + * Proximity sensor values are reported differently from other sensors=
.
> > + * The value reported is a boolean (0 or 1, still in the same fixed-po=
int
> > + * format) where 1 means the sensor is activated, i.e. something is
> > + * within its range. Use the reported range to pass an actual distance
> > + * value to IIO. We pass the sensor range when nothing is within range
> > + * (sensor maxed out) and 0 when something is within range (assume
> > + * sensor is covered).
> > + */
> > + if (sensor->type =3D=3D SNS_SMGR_SENSOR_TYPE_PROX_LIGHT) {
> > + temp =3D le32_to_cpu(iio_data.values[0]);
> > + temp >>=3D SMGR_VALUE_DECIMAL_OFFSET;
> > + temp =3D ~temp & 1;
> > + temp *=3D sensor->data_types[0].range;
> > + iio_data.values[0] =3D cpu_to_le32(temp);
> > + }
> > +
> > + iio_push_to_buffers(sensor->iio_dev, &iio_data);
>=20
> You have a structure with space for timestamps but don't provide one whic=
h
> is odd. Either don't make space, or provide it.

I forgot to copy the timestamp into iio_data. Will fix.

>=20
> > +}
>=20
> > +
> > +static int qcom_smgr_sensor_predisable(struct iio_dev *iio_dev)
> > +{
> > + struct qcom_smgr *smgr =3D dev_get_drvdata(iio_dev->dev.parent);
> > + struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
> > + struct qcom_smgr_sensor *sensor =3D priv->sensor;
> > +
> > + dev_info(smgr->dev, "disable buffering %02x\n", sensor->id);
>=20
>=20
> Too nosy. dev_dbg()

I added this while debugging and missed it while cleaning up to remove it. =
Will remove
entirely.

>=20
> > + return qcom_smgr_request_buffering(smgr, sensor, false);
> > +}
>=20
> > +static int qcom_smgr_iio_read_raw(struct iio_dev *iio_dev,
> > + struct iio_chan_spec const *chan, int *val,
> > + int *val2, long mask)
> > +{
> > + struct qcom_smgr_iio_priv *priv =3D iio_priv(iio_dev);
> > +
> > + switch (mask) {
>=20
>=20
> No sysfs access at all to data is unusual but not completely unheard of.

There is no (known) method to request a single reading from the QMI
service. The only known way to get sensor data is to send a buffering
request to initiate sending data, then the remoteproc sends QMI
indications at a regular interval carrying sensor data which I am
pushing to the IIO buffers. The only way to implement direct sysfs
access would be to store the last received value somewhere then pass
it to sysfs when requested. This will also require enabling buffering
if disabled at the time of reading, then waiting until new data is
received. I didn't like this solution so I skipped direct sysfs access
altogether. Buffer access is enough for the current use case with
iio-sensor-proxy in userspace.

>=20
> > + case IIO_CHAN_INFO_SAMP_FREQ:
> > + *val =3D priv->sensor->data_types[0].cur_sample_rate;
> > + return IIO_VAL_INT;
> > + case IIO_CHAN_INFO_SCALE:
> > + *val =3D 1;
> > + *val2 =3D 1 << SMGR_VALUE_DECIMAL_OFFSET;
> > + return IIO_VAL_FRACTIONAL;
> > + default:
> > + return -EINVAL;
> > + }
>=20
> > +
> > +static const struct iio_chan_spec qcom_smgr_pressure_iio_channels[] =
=3D {
> > + {
> > + .type =3D IIO_PRESSURE,
> > + .scan_index =3D 0,
> > + .scan_type =3D {
> > + .sign =3D 'u',
> > + .realbits =3D 32,
> > + .storagebits =3D 32,
> > + .endianness =3D IIO_LE,
> > + },
> > + .info_mask_separate =3D BIT(IIO_CHAN_INFO_SCALE) |
> > + BIT(IIO_CHAN_INFO_SAMP_FREQ)
> > + },
> > + {
> > + .type =3D IIO_TIMESTAMP,
> > + .channel =3D -1,
> > + .scan_index =3D 3,
>=20
>=20
> Why 3?

Because the same struct is used for this and 3-axis sensors, so we should
skip the unused values.

>=20
> > + .scan_type =3D {
> > + .sign =3D 'u',
> > + .realbits =3D 32,
>=20
>=20
> If it's realbits 32 and no shift, why not store it in a 32 bit value?
> I assume this is a hardware provided timestamp rather than typical softwa=
re
> filled in one? Anyhow, I'm not immediately spotting it being used yet
> so for now perhaps best to drop the channel descriptions.

The hardware (or firmware rather) passes an unsigned 32-bit timestamp
value in a 64-bit QMI field. I was previously passing it as-is to IIO
but now since I introduced a new struct I can make it 32-bit storagebits.

But below you said s64 for timestamp so which is it going to be?

>=20
> > + .storagebits =3D 64,
> > + .endianness =3D IIO_LE,
> > + },
> > + }
> > +};
>=20
> > +static int qcom_smgr_register_sensor(struct qcom_smgr *smgr,
> > + struct qcom_smgr_sensor *sensor)
> > +{
> > + struct iio_dev *iio_dev;
> > + struct qcom_smgr_iio_priv *priv;
> > + int ret;
>=20
> > + sensor->iio_dev =3D iio_dev;
> > +
> > + ret =3D devm_iio_kfifo_buffer_setup(smgr->dev, iio_dev,
> > + &qcom_smgr_buffer_ops);
> > + if (ret) {
> > + dev_err(smgr->dev, "Failed to setup buffer: %pe\n",
>=20
>=20
> Use return dev_err_probe() for all errors that occur in code that only
> runs at probe() time.

Ack

>=20
> > + ERR_PTR(ret));
> > + return ret;
> > + }
> > +
> > + ret =3D devm_iio_device_register(smgr->dev, iio_dev);
> > + if (ret) {
> > + dev_err(smgr->dev, "Failed to register IIO device: %pe\n",
> > + ERR_PTR(ret));
> > + return ret;
> > + }
> > +
> > + return 0;
> > +}
> > +
> > +static int qcom_smgr_probe(struct qrtr_device *qdev)
> > +{
> > + struct qcom_smgr *smgr;
> > + int i, j;
> > + int ret;
> > +
> > + smgr =3D devm_kzalloc(&qdev->dev, sizeof(*smgr), GFP_KERNEL);
> > + if (!smgr)
> > + return -ENOMEM;
> > +
> > + smgr->dev =3D &qdev->dev;
> > +
> > + smgr->sns_smgr_info.sq_family =3D AF_QIPCRTR;
> > + smgr->sns_smgr_info.sq_node =3D qdev->node;
> > + smgr->sns_smgr_info.sq_port =3D qdev->port;
> > +
> > + dev_set_drvdata(&qdev->dev, smgr);
>=20
> This code is a bit random on whether it uses qdev->dev, or smgr->dev
>=20
>=20
> I'd be tempted to just introce
> struct device *dev =3D &qdev->dev; and use that pretty much everywhere.

I think smgr->dev is good, as is used everywhere else in the driver.
Will change this one.

>=20
> > +
> > + ret =3D qmi_handle_init(&smgr->sns_smgr_hdl,
> > + SNS_SMGR_SINGLE_SENSOR_INFO_RESP_MAX_LEN, NULL,
> > + qcom_smgr_msg_handlers);
> > + if (ret < 0)
> > + return dev_err_probe(smgr->dev, ret,
> > + "Failed to initialize sensor manager handle\n");
> > +
> > + ret =3D devm_add_action_or_reset(smgr->dev,
> > + (void(*)(void *))qmi_handle_release,
>=20
>=20
> I'd much prefer a local wrapper to casting types of functions.

A function containing a single function call felt unnecessary to
me but I will add a wrapper if you prefer it that way.

>=20
> > + &smgr->sns_smgr_hdl);
> > + if (ret)
> > + return ret;
> > +
> > + ret =3D qcom_smgr_request_all_sensor_info(smgr, &smgr->sensors);
> > + if (ret < 0)
> > + return dev_err_probe(smgr->dev, ret,
> > + "Failed to get available sensors\n");
> > +
> > + smgr->sensor_count =3D ret;
> > +
> > + /* Get primary and secondary sensors from each sensor ID /
> > + for (i =3D 0; i < smgr->sensor_count; i++) {
> > + ret =3D qcom_smgr_request_single_sensor_info(smgr,
> > + &smgr->sensors[i]);
> > + if (ret < 0)
> > + return dev_err_probe(smgr->dev, ret,
> > + "Failed to get sensors from ID 0x%02x\n",
> > + smgr->sensors[i].id);
> > +
> > + for (j =3D 0; j < smgr->sensors[i].data_type_count; j++) {
> > + / Default to maximum sample rate /
> > + smgr->sensors[i].data_types->cur_sample_rate =3D
> > + smgr->sensors[i].data_types->max_sample_rate;
> > +
> > + dev_dbg(smgr->dev, "0x%02x,%d: %s %s\n",
> > + smgr->sensors[i].id, j,
> > + smgr->sensors[i].data_types[j].vendor,
> > + smgr->sensors[i].data_types[j].name);
> > + }
> > +
> > + / Skip if sensor type is not supported /
> > + if (smgr->sensors[i]->type =3D=3D SNS_SMGR_SENSOR_TYPE_UNKNOWN ||
> > + !qcom_smgr_sensor_type_iio_channels[smgr->sensors[i]->type])
> > + continue;
> > +
> > + ret =3D qcom_smgr_register_sensor(smgr, &smgr->sensors[i]);
> > + if (ret)
> > + return dev_err_probe(smgr->dev, ret,
> > + "Failed to register sensor 0x%02x\n",
> > + smgr->sensors[i].id);
> > + }
> > +
> > + return 0;
> > +}
> > +
> > +static const struct qrtr_device_id qcom_smgr_qrtr_match[] =3D {
> > + {
> > + .service =3D SNS_SMGR_QMI_SVC_ID,
> > + / Found on MSM8953 /
> > + .instance =3D QRTR_INSTANCE_CONST(0, 1)
> > + },
> > + {
> > + .service =3D SNS_SMGR_QMI_SVC_ID,
> > + / Found on MSM8974 and MSM8226 /
> > + .instance =3D QRTR_INSTANCE_CONST(1, 0)
> > + },
> > + {
> > + .service =3D SNS_SMGR_QMI_SVC_ID,
> > + / Found on MSM8996 and SDM660 */
> > + .instance =3D QRTR_INSTANCE_CONST(1, 50)
> > + },
> > + { },
>=20
>=20
> No comma on a terminating entry like this.

Ok. Gotta keep track of all the conventions used in different subsystems.

>=20
> > +};
> > +MODULE_DEVICE_TABLE(qrtr, qcom_smgr_qrtr_match);
>=20
>=20
>=20
> > +const struct qmi_elem_info sns_smgr_buffering_report_ind_ei[] =3D {
> > + {
> > + .data_type =3D QMI_UNSIGNED_1_BYTE,
> > + .elem_len =3D 1,
> > + .elem_size =3D sizeof_field(struct sns_smgr_buffering_report_ind,
> > + report_id),
> > + .array_type =3D NO_ARRAY,
> > + .tlv_type =3D 0x01,
> > + .offset =3D offsetof(struct sns_smgr_buffering_report_ind,
> > + report_id),
> > + },
> > + {
> > + .data_type =3D QMI_STRUCT,
> > + .elem_len =3D 1,
> > + .elem_size =3D sizeof_field(struct sns_smgr_buffering_report_ind,
> > + metadata),
> > + .array_type =3D NO_ARRAY,
> > + .tlv_type =3D 0x02,
> > + .offset =3D offsetof(struct sns_smgr_buffering_report_ind,
> > + metadata),
> > + .ei_array =3D sns_smgr_buffering_report_metadata_ei,
> > + },
> > + {
> > + .data_type =3D QMI_DATA_LEN,
> > + .elem_len =3D 1,
> > + .elem_size =3D sizeof_field(struct sns_smgr_buffering_report_ind,
> > + samples_len),
> > + .array_type =3D NO_ARRAY,
> > + .tlv_type =3D 0x03,
> > + .offset =3D offsetof(struct sns_smgr_buffering_report_ind,
> > + samples_len),
> > + },
> > + {
> > + .data_type =3D QMI_STRUCT,
> > + .elem_len =3D SNS_SMGR_SAMPLES_MAX_LEN,
> > + .elem_size =3D sizeof(struct sns_smgr_buffering_report_sample),
> > + .array_type =3D VAR_LEN_ARRAY,
> > + .tlv_type =3D 0x03,
> > + .offset =3D
> > + offsetof(struct sns_smgr_buffering_report_ind, samples),
>=20
>=20
> I'm fine with slightly over 80 chars to avoid readability issues like thi=
s.

Ok

>=20
> > diff --git a/include/linux/iio/common/qcom_smgr.h b/include/linux/iio/c=
ommon/qcom_smgr.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..fdd3de12bb0a48f1fb9e51c=
d0463c9a9b9ed500f
> > --- /dev/null
> > +++ b/include/linux/iio/common/qcom_smgr.h
> > @@ -0,0 +1,80 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef QCOM_SMGR_H
> > +#define QCOM_SMGR_H
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/types.h>
> > +#include <linux/soc/qcom/qmi.h>
> > +#include <linux/types.h>
>=20
> > +
> > +struct qcom_smgr_sensor {
> > + u8 id;
> > + enum qcom_smgr_sensor_type type;
> > +
> > + u8 data_type_count;
> > + /*
> > + * Only SNS_SMGR_DATA_TYPE_PRIMARY is used at the moment, but we store
> > + * SNS_SMGR_DATA_TYPE_SECONDARY when available as well for future use.
> > + */
> > + struct qcom_smgr_data_type_item *data_types;
> > +
> > + struct iio_dev *iio_dev;
> > +};
> > +
> > +struct qcom_smgr_iio_priv {
> > + struct qcom_smgr_sensor *sensor;
> > +
> > + int samp_freq_vals[3];
> > +};
> > +
> > +
> > +struct qcom_smgr_iio_data {
> > + u32 values[3];
> > + u64 timestamp;
>=20
>=20
> Timestamps in kernel tend to be s64. Also for IIO buffers aligned_s64 req=
uired.
> Whilst this will probably never be used on an architecture that doesn't n=
aturally
> align 8 byte variables, we should still code for it.
>=20
> Given this tends to be used locally maybe just define it where you need i=
t.

Ack


