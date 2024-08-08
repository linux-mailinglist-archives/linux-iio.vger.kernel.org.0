Return-Path: <linux-iio+bounces-8325-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0B94BB25
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D1E1C2243B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4FB18A944;
	Thu,  8 Aug 2024 10:33:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-27.us.a.mail.aliyun.com (out198-27.us.a.mail.aliyun.com [47.90.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB5F18A6C7;
	Thu,  8 Aug 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113225; cv=none; b=ORbDuBOiNaqSMp4fRayxlvMz55zIaSv9xKbRZvksvediD9Bg8JgMUct/kNTssHEqDbc/kDifF8kx23YC2zmM/4gPEW+FtU3sX8SLkLAZt8t7ZnElyX4UQnIOg63NzDZFsczM334pno/HcVeZwxxVZgFXwCNdx56sqMZqP8Tq89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113225; c=relaxed/simple;
	bh=sB5eVYzozK5UeLkzKGb11rMntIwr6+yqbwdmr59szCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGVjcHQGJxxcCfgEM6rlUghPAWwYyDUZRu69aWf7xGOgf1emZEFXVl5pyHhtc2lcr5OGKMUY9tA8jazHkTzAqcA82Q2kZCEDdnuSn4jBF/KiLMlHivS/arqaUfNs4AOUduMXvOnhI3QKGSZR9wfjIZe236ePvvCu22ZXQ0W4xPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0415989-0.0246649-0.933736;FP=7446490164482491419|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023181100;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.Ylkb51Q_1723112873;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.Ylkb51Q_1723112873)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 18:28:03 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	kangjiajun@awinic.com,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	robh@kernel.org,
	wangshuaijie@awinic.com,
	waqar.hameed@axis.com
Subject: Re: [PATCH V5 2/2] iio: proximity: aw9610x: Add support for aw9610x proximity sensor
Date: Thu,  8 Aug 2024 10:27:52 +0000
Message-ID: <20240808102753.4023286-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240727160216.2488ed29@jic23-huawei>
References: <20240727160216.2488ed29@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,=0D
=0D
On Sat, 27 Jul 2024 16:02:16 +0100, jic23@kernel.org wrote:=0D
>On Fri, 26 Jul 2024 06:13:12 +0000=0D
>wangshuaijie@awinic.com wrote:=0D
>=0D
>> From: shuaijie wang <wangshuaijie@awinic.com>=0D
>> =0D
>> AW9610X is a low power consumption capacitive touch and proximity contro=
ller.=0D
>> Each channel can be independently config as sensor input, shield output.=
=0D
>=0D
>Needs more information, particularly what the USB powersupply notification=
 is about.=0D
>It's unlikely that belongs directly in an IIO driver, unless that supply i=
s=0D
>part of this same chip.=0D
>=0D
>> =0D
>> Channel Information:=0D
>>   aw96103: 3-channel=0D
>>   aw96105: 5-channel=0D
>I don't see where this is implemented. Seems to assume 5 channels for both=
.=0D
>=0D
>> =0D
>> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>=0D
>> ---=0D
>>  drivers/iio/proximity/Kconfig   |  11 +=0D
>>  drivers/iio/proximity/Makefile  |   1 +=0D
>>  drivers/iio/proximity/aw9610x.c | 791 ++++++++++++++++++++++++++++++++=
=0D
>>  drivers/iio/proximity/aw9610x.h | 140 ++++++=0D
>>  4 files changed, 943 insertions(+)=0D
>>  create mode 100644 drivers/iio/proximity/aw9610x.c=0D
>>  create mode 100644 drivers/iio/proximity/aw9610x.h=0D
>> =0D
>>  =0D
=0D
...=0D
=0D
=0D
>> +static int aw9610x_cfg_all_loaded(const struct firmware *cont,=0D
>> +		struct aw9610x *aw9610x)=0D
>> +{=0D
>> +	struct aw_bin *aw_bin;=0D
>> +	int ret;=0D
>> +=0D
>> +	if (!cont)=0D
>> +		return -EINVAL;=0D
>> +=0D
>> +	aw_bin =3D kzalloc(cont->size + sizeof(*aw_bin), GFP_KERNEL);=0D
>Use __free(kfree) =0D
>=0D
>lots of examples in tree, but will avoid need to manually free and=0D
>simplify this code a little.=0D
>=0D
=0D
I'm sorry, I didn't quite understand what you meant. Are you suggesting=0D
the use of devm_? Could you please provide more detailed suggestions?=0D
Thank you!=0D
=0D
>> +	if (!aw_bin)=0D
>> +		return -ENOMEM;=0D
>> +=0D
>> +	aw_bin->len =3D cont->size;=0D
>> +	memcpy(aw_bin->data, cont->data, cont->size);=0D
>> +	aw9610x_parsing_bin_file(aw_bin);=0D
>> +=0D
>> +	snprintf(aw9610x->chip_type, sizeof(aw9610x->chip_type), "%s",=0D
>> +			aw_bin->chip_type);=0D
>> +	ret =3D aw9610x_bin_valid_loaded(aw9610x, aw_bin);=0D
>> +	kfree(aw_bin);=0D
>> +=0D
>> +	return ret;=0D
>> +}=0D
>> +=0D
>> +static int aw9610x_cfg_update(struct aw9610x *aw9610x)=0D
>> +{=0D
>> +	const struct firmware *fw;=0D
>> +	int ret;=0D
>> +=0D
>> +	ret =3D request_firmware(&fw, "aw9610x_0.bin", aw9610x->dev);=0D
>=0D
>No wild cards in this either.=0D
>=0D
>> +	if (ret)=0D
>> +		return ret;=0D
>> +	ret =3D aw9610x_cfg_all_loaded(fw, aw9610x);=0D
>> +	if (ret)=0D
>> +		ret =3D aw9610x_para_loaded(aw9610x);=0D
>> +	release_firmware(fw);=0D
>> +=0D
>> +	return ret;=0D
>> +}=0D
>> +=0D
>> +static void aw9610x_cfg_work_routine(struct work_struct *work)=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D container_of(work, struct aw9610x,=0D
>> +			cfg_work.work);=0D
>> +=0D
>> +	aw9610x_cfg_update(aw9610x);=0D
>=0D
>So this is polling in driver.   We'd normally hook up to a hrtimer=0D
>trigger for that.  Perhaps you need this for your events sampling though?=
=0D
>If so that may be fine to do somewhat like this. I'm just not sure=0D
>of the usecase currently.=0D
>=0D
=0D
The primary objective of this delayed task is to load the register=0D
configuration file. The chip needs to load the register configuration=0D
file during power-on initialization. In cases where the driver is compiled=
=0D
directly into the kernel, rather than existing as a dynamically loaded=0D
module, there may be a situation where the driver attempts to load before=0D
the file system is fully prepared, resulting in an inability to access the=
=0D
register configuration file. Therefore, a delayed task mechanism is employe=
d=0D
to ensure the register configuration file is loaded properly.=0D
=0D
If there are any concerns about my understanding or approach, please feel=0D
free to offer suggestions. Thank you very much!=0D
=0D
>> +}=0D
>> +=0D
>> +static int aw9610x_sar_cfg_init(struct aw9610x *aw9610x)=0D
>> +{=0D
>> +	INIT_DELAYED_WORK(&aw9610x->cfg_work, aw9610x_cfg_work_routine);=0D
>> +	schedule_delayed_work(&aw9610x->cfg_work, msecs_to_jiffies(5000));=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +=0D
>> +static int aw9610x_sw_reset(struct aw9610x *aw9610x)=0D
>> +{=0D
>> +	int ret;=0D
>> +=0D
>> +	ret =3D aw9610x_i2c_write(aw9610x, REG_RESET, 0);=0D
>> +	msleep(20);=0D
>> +=0D
>> +	return ret;=0D
>> +}=0D
>> +=0D
>> +static ssize_t update_store(struct device *dev, struct device_attribute=
 *attr,=0D
>> +		const char *buf, size_t count)=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D dev_get_drvdata(dev);=0D
>> +	unsigned int state;=0D
>> +	ssize_t ret;=0D
>> +=0D
>> +	ret =3D kstrtouint(buf, 10, &state);=0D
>> +	if (ret)=0D
>> +		return ret;=0D
>> +	if (state) {=0D
>> +		aw9610x_i2c_write(aw9610x, REG_IRQEN, 0);=0D
>> +		aw9610x_sw_reset(aw9610x);=0D
>> +		schedule_delayed_work(&aw9610x->cfg_work,=0D
>> +					msecs_to_jiffies(10));=0D
>> +	}=0D
>> +=0D
>> +	return count;=0D
>> +}=0D
>> +=0D
>> +static DEVICE_ATTR_WO(update);=0D
>> +=0D
>> +static struct attribute *aw9610x_sar_attributes[] =3D {=0D
>> +	&dev_attr_update.attr,=0D
>=0D
>This needs documenting as it's custom ABI.=0D
>Note that we don't often accept custom ABI.=0D
>Particularly not a hook that seems to reset the device.=0D
>If you want to do that, unbind and rebind the whole drive so=0D
>we are in a known state etc.=0D
>=0D
>=0D
>> +	NULL=0D
>> +};=0D
>> +=0D
>> +static struct attribute_group aw9610x_sar_attribute_group =3D {=0D
>> +	.attrs =3D aw9610x_sar_attributes=0D
>> +};=0D
>> +=0D
>> +static void aw9610x_irq_handle(struct aw9610x *aw9610x)=0D
>> +{=0D
>> +	u32 curr_status_val;=0D
>> +	u32 curr_status;=0D
>> +	unsigned char i;=0D
>> +	int ret;=0D
>> +=0D
>> +	ret =3D aw9610x_i2c_read(aw9610x, REG_STAT0, &curr_status_val);=0D
>> +	if (ret)=0D
>> +		return;=0D
>> +=0D
>> +	for (i =3D 0; i < AW_CHANNEL_MAX; i++) {=0D
>> +		curr_status =3D (((curr_status_val >> (24 + i)) & 0x1)) |=0D
>> +			(((curr_status_val >> (16 + i)) & 0x1) << 1) |=0D
>> +			(((curr_status_val >> (8 + i)) & 0x1) << 2) |=0D
>> +			(((curr_status_val >> (i)) & 0x1) << 3);=0D
>=0D
>Add a comment on what is going on here as it's tricky to read.=0D
>Also, no brackets around the i in last line.=0D
>Probably better expressed as a series of FIELD_GET() calls with appropriat=
=0D
>masks of the 32 bit value.=0D
>=0D
>=0D
=0D
The work processed here is to parse the interrupt status of different chann=
els.=0D
bit0/bit8/bit16/bit24 represent the interrupt status of channel 0, with eac=
h of=0D
the 4 bits corresponding to an interrupt status for approaching a threshold=
.=0D
Similarly, bit1/bit9/bit17/bit25 represent the interrupt status of channel =
1.=0D
To facilitate subsequent interrupt status judgments, the 4 interrupt status=
es=0D
of the same channel are combined into a single data.=0D
=0D
Sorry, I have not found a suitable way to utilize FIELD_GET for this purpos=
e.=0D
=0D
>> +=0D
>> +		if (!aw9610x->channels_arr[i].used ||=0D
>> +				(aw9610x->channels_arr[i].last_channel_info =3D=3D=0D
>> +				curr_status))=0D
>Align as=0D
>		if (!aw=0D
>		    (aw9610...=0D
>=0D
>> +			continue;=0D
>> +=0D
>> +		switch (curr_status) {=0D
>> +		case FAR:=0D
>> +			iio_push_event(aw9610x->aw_iio_dev,=0D
>> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,=0D
>> +						IIO_EV_TYPE_THRESH,=0D
>> +						IIO_EV_DIR_RISING),=0D
>> +					iio_get_time_ns(aw9610x->aw_iio_dev));=0D
>> +			break;=0D
>> +		case TRIGGER_TH0:=0D
>> +		case TRIGGER_TH1:=0D
>> +		case TRIGGER_TH2:=0D
>> +		case TRIGGER_TH3:=0D
>4 thresholds on the same channel? This is confusing given we are reporting=
 them=0D
>as events on different channels. but this loop is over the channels.=0D
>=0D
>=0D
=0D
There are 4 proximity thresholds on the same channel, each representing=0D
a different level of proximity. TRIGGER_TH0/TRIGGER_TH1/TRIGGER_TH2/TRIGGER=
_TH3=0D
all represent proximity states, but with varying degrees of proximity.=0D
=0D
Here I have a question to ask. I'm not sure how to use iio to report=0D
different proximity states. Can you give me some suggestions? Thank you!=0D
=0D
>> +			iio_push_event(aw9610x->aw_iio_dev,=0D
>> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,=0D
>> +						IIO_EV_TYPE_THRESH,=0D
>> +						IIO_EV_DIR_FALLING),=0D
>> +					iio_get_time_ns(aw9610x->aw_iio_dev));=0D
>> +			break;=0D
>> +		default:=0D
>> +			return;=0D
>> +		}=0D
>> +		aw9610x->channels_arr[i].last_channel_info =3D curr_status;=0D
>> +	}=0D
>> +}=0D
>> +=0D
=0D
Kind regards,=0D
Wang Shuaijie=

