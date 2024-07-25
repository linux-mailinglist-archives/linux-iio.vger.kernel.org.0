Return-Path: <linux-iio+bounces-7880-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F6B93C24D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 14:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995B5282498
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE5219A296;
	Thu, 25 Jul 2024 12:48:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E261D199EBE;
	Thu, 25 Jul 2024 12:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911684; cv=none; b=l7tc945RzXsaCuYBDArkX+947TJ53MILkTquuQ8KYlMCoVc44uFLJVAQcdAkgbU5Dxv2HtB+yDjUeukVGSksBDgOagOZ3t4ZZlMt6i/oZpixHA9gEC5E9DhozaGbkfvMs4tfFM3E/5xtjrpKt8/RwypChpCKxeZKuuKCblbhWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911684; c=relaxed/simple;
	bh=gGgW6kRoRPhwMvTCwiPvJ5V0t6RN6mbpo1cxyRt6xyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9lVKov2vX/futAOYDcjJEGIrKpunSkYp/zAbZrlV3xlATLSA48n9uzqVrjEIAvP5IdqGSRi+WD7eZgAQKE9GHVCFNXiqz0JiAFEMgxam4yuW4Cm4vt2zvxQ/30Iskr+pZ3UNC/6z2YJ9aJv0AO7B7gnNmEPyy112QxppvF8Sik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.105583-0.000163184-0.894254;FP=16949781092339565683|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037136014;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.YZXxoLK_1721911652;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YZXxoLK_1721911652)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 20:47:38 +0800
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
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Date: Thu, 25 Jul 2024 12:47:32 +0000
Message-ID: <20240725124732.890375-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240713152700.3c395608@jic23-huawei>
References: <20240713152700.3c395608@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,=0D
=0D
On Sat, 13 Jul 2024 15:27:00 +0100, jic23@kernel.org wrote:=0D
>On Fri, 12 Jul 2024 11:32:00 +0000=0D
>wangshuaijie@awinic.com wrote:=0D
>=0D
>> From: shuaijie wang <wangshuaijie@awinic.com>=0D
>> =0D
>> 1. Modify the structure of the driver.=0D
>> 2. Change the style of the driver's comments.=0D
>> 3. Remove unnecessary log printing.=0D
>> 4. Modify the function used for memory allocation.=0D
>> 5. Modify the driver registration process.=0D
>> 6. Remove the functionality related to updating firmware.=0D
>> 7. Change the input subsystem in the driver to the iio subsystem.=0D
>> 8. Modify the usage of the interrupt pin.=0D
>> =0D
>> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>=0D
>=0D
>As others have observed this is a change log not a patch description so be=
longs=0D
>below the ---=0D
>Also, should be a patch description.=0D
>=0D
>The patch is very large and hard to review as a result.=0D
>Break it up in to parts.  Common infrastructure, then add support=0D
>for one part then for the next one etc.  Given size of this, I'd start=0D
>with a submission supporting only one part.  Don't abstract anything that=
=0D
>isn't needed for that part initially.  That abstraction should occur=0D
>in a separate series that adds the parts where things differ etc.=0D
>=0D
>That way we get bite sized parts to review.  I'll take a quick look but gi=
ven current status=0D
>this probably won't be a thorough review.=0D
>=0D
>Superficial feedback is this seems like a very complex driver for a not=0D
>very complex of devices. Please look to drop any flexibility in the driver=
=0D
>that isn't used etc. =0D
>=0D
>Anyhow, I'm out of time, so the feedback is patch at best and I've not cro=
pped=0D
>the reply down.=0D
>=0D
>For next version aim for no patch > 1000 lines and typically much smaller =
than=0D
>that and ask us to review a subset of what you have here.  Build it up in =
several=0D
>goes.  The feedback on that first subset will help you fix up later ones t=
o be=0D
>closer to what we are looking at.=0D
>=0D
>Jonathan=0D
>=0D
=0D
Thank you very much for your valuable feedback. The driver for this proximi=
ty=0D
sensor is indeed overly complex, and the software architecture is not well=
=0D
designed.=0D
 =0D
In the next version of the patch, I will abandon the previous architecture=
=0D
and focus only on supporting the aw9610x series. This will make the code mo=
re=0D
concise and easier to read. In the long run, when designing for compatibili=
ty,=0D
I will study the designs of other drivers to make it more compliant with=0D
Linux kernel specifications.=0D
=0D
>=0D
>> ---=0D
>>  drivers/iio/proximity/Kconfig                 |   10 +=0D
>>  drivers/iio/proximity/Makefile                |    2 +=0D
>>  drivers/iio/proximity/aw9610x.c               | 1150 ++++++++++=0D
>>  drivers/iio/proximity/aw963xx.c               | 1371 ++++++++++++=0D
>>  drivers/iio/proximity/aw_sar.c                | 1850 +++++++++++++++++=
=0D
>>  drivers/iio/proximity/aw_sar.h                |   23 +=0D
>>  drivers/iio/proximity/aw_sar_comm_interface.c |  550 +++++=0D
>>  drivers/iio/proximity/aw_sar_comm_interface.h |  172 ++=0D
>>  drivers/iio/proximity/aw_sar_type.h           |  371 ++++=0D
>>  9 files changed, 5499 insertions(+)=0D
>>  create mode 100644 drivers/iio/proximity/aw9610x.c=0D
>>  create mode 100644 drivers/iio/proximity/aw963xx.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar.h=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.h=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_type.h=0D
>> =0D
>> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconf=
ig=0D
>> index 2ca3b0bc5eba..a60d3dc955b3 100644=0D
>> --- a/drivers/iio/proximity/Kconfig=0D
>> +++ b/drivers/iio/proximity/Kconfig=0D
>> @@ -219,4 +219,14 @@ config VL53L0X_I2C=0D
>>  	  To compile this driver as a module, choose M here: the=0D
>>  	  module will be called vl53l0x-i2c.=0D
>>  =0D
>> +config AWINIC_SAR=0D
>> +	tristate "Awinic AW96XXX proximity sensor"=0D
>> +	depends on I2C=0D
>> +	help=0D
>> +	  Say Y here to build a driver for Awinic's AW96XXX capacitive=0D
>> +	  proximity sensor.=0D
>> +=0D
>> +	  To compile this driver as a module, choose M here: the=0D
>> +	  module will be called awinic_sar.=0D
>> +=0D
>>  endmenu=0D
>> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Make=
file=0D
>> index f36598380446..d4bd9edd8362 100644=0D
>> --- a/drivers/iio/proximity/Makefile=0D
>> +++ b/drivers/iio/proximity/Makefile=0D
>> @@ -21,4 +21,6 @@ obj-$(CONFIG_SX_COMMON) 	+=3D sx_common.o=0D
>>  obj-$(CONFIG_SX9500)		+=3D sx9500.o=0D
>>  obj-$(CONFIG_VCNL3020)		+=3D vcnl3020.o=0D
>>  obj-$(CONFIG_VL53L0X_I2C)	+=3D vl53l0x-i2c.o=0D
>> +obj-$(CONFIG_AWINIC_SAR)	+=3D awinic_sar.o=0D
>> +awinic_sar-objs			:=3D aw_sar_comm_interface.o aw_sar.o aw9610x.o aw963=
xx.o=0D
>>  =0D
>> diff --git a/drivers/iio/proximity/aw9610x.c b/drivers/iio/proximity/aw9=
610x.c=0D
>> new file mode 100644=0D
>> index 000000000000..15e53d55d2a1=0D
>> --- /dev/null=0D
>> +++ b/drivers/iio/proximity/aw9610x.c=0D
>> @@ -0,0 +1,1150 @@=0D
>> +// SPDX-License-Identifier: GPL-2.0=0D
>> +/*=0D
>> + * AWINIC sar sensor driver (aw9610x)=0D
>> + *=0D
>> + * Author: Shuaijie Wang<wangshuaijie@awinic.com>=0D
>> + *=0D
>> + * Copyright (c) 2024 awinic Technology CO., LTD=0D
>> + */=0D
>> +#include "aw_sar.h"=0D
>> +=0D
>> +#define AW9610X_I2C_NAME "aw9610x_sar"=0D
>> +#define AW9610X_CHANNEL_MAX	(5)=0D
>=0D
>No brackets around numeric values. They add nothing.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +=0D
>> +#define AFE_BASE_ADDR					(0x0000)=0D
>=0D
>=0D
>> +=0D
>> +enum aw9610x_sar_vers {=0D
>> +	AW9610X =3D 2,=0D
>> +	AW9610XA =3D 6,=0D
>> +	AW9610XB =3D 0xa,=0D
>> +};=0D
>> +=0D
>> +enum aw9610x_operation_mode {=0D
>> +	AW9610X_ACTIVE_MODE =3D 1,=0D
>> +	AW9610X_SLEEP_MODE,=0D
>> +	AW9610X_DEEPSLEEP_MODE,=0D
>> +	AW9610XB_DEEPSLEEP_MODE,=0D
>> +};=0D
>> +=0D
>> +enum aw9610x_spereg_addr_offset {=0D
>> +	AW_CL1SPE_CALI_OS =3D 20,=0D
>> +	AW_CL1SPE_DEAL_OS =3D 60,=0D
>> +	AW_CL2SPE_CALI_OS =3D 4,=0D
>> +	AW_CL2SPE_DEAL_OS =3D 4,=0D
>> +};=0D
>> +=0D
>> +enum aw9610x_function_flag {=0D
>> +	AW9610X_FUNC_OFF,=0D
>> +	AW9610X_FUNC_ON,=0D
>> +};=0D
>> +=0D
>> +enum aw9610x_irq_trigger_position {=0D
>> +	AW9610X_FAR,=0D
>> +	AW9610X_TRIGGER_TH0,=0D
>> +	AW9610X_TRIGGER_TH1 =3D 0x03,=0D
>> +	AW9610X_TRIGGER_TH2 =3D 0x07,=0D
>> +	AW9610X_TRIGGER_TH3 =3D 0x0f,=0D
>> +};=0D
>> +=0D
>> +struct aw_i2c_package {=0D
>> +	unsigned char addr_bytes;=0D
>> +	unsigned char data_bytes;=0D
>> +	unsigned char reg_num;=0D
>> +	unsigned char init_addr[4];=0D
>> +	unsigned char *p_reg_data;=0D
>> +};=0D
>> +=0D
>> +struct aw9610x {=0D
>> +	unsigned char vers;=0D
>> +	unsigned char channel;=0D
>> +	unsigned int irq_status;=0D
>> +	unsigned char chip_name[9];=0D
>> +	unsigned char chip_type[9];=0D
>> +	bool satu_release;=0D
>> +	struct aw_i2c_package aw_i2c_package;=0D
>> +	unsigned char satu_flag[6];=0D
>> +	unsigned int satu_data[6];=0D
>> +	unsigned int last_blfilta[AW9610X_CHANNEL_MAX];=0D
>> +	unsigned int last_irq_en;=0D
>> +};=0D
>> +=0D
>> +struct aw_reg_data {=0D
>> +	unsigned char rw;=0D
>> +	unsigned short reg;=0D
>=0D
>> +};=0D
>> +#define REG_NONE_ACCESS					(0)=0D
>> +#define REG_RD_ACCESS					(1 << 0)=0D
>> +#define REG_WR_ACCESS					(1 << 1)=0D
>> +=0D
>=0D
>> +=0D
>> +static struct aw_sar *g_aw_sar;=0D
>> +=0D
>> +static int aw9610x_baseline_filter(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	unsigned int status0;=0D
>> +	unsigned int status1;=0D
>=0D
>u32 for 32 bit register to make it explicit that they are 32 bits.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +	unsigned char i;=0D
>> +=0D
>> +	aw_sar_i2c_read(p_sar->i2c, REG_STAT1, &status1);=0D
>Check return value of all reads.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +	aw_sar_i2c_read(p_sar->i2c, REG_STAT0, &status0);=0D
>> +=0D
>> +	for (i =3D 0; i < AW9610X_CHANNEL_MAX; i++) {=0D
>> +		if (((status1 >> i) & 0x01) =3D=3D 1) {=0D
>> +			if (aw9610x->satu_flag[i] =3D=3D 0) {=0D
>> +				aw_sar_i2c_read(p_sar->i2c, REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS,=
=0D
>> +						&aw9610x->satu_data[i]);=0D
>> +				aw_sar_i2c_write(p_sar->i2c, REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS=
,=0D
>> +						((aw9610x->satu_data[i] | 0x1fc) & 0x3fffffff));=0D
>=0D
>Masks should be associated with defines.  I have no idea what this code=0D
>is doing so a comment would be good. It looks to be reading current state=
=0D
>into a satu_data[i] then writing back something different but not updating=
=0D
>local state.  That needs some documentation.=0D
>=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +				aw9610x->satu_flag[i] =3D 1;=0D
>> +			}=0D
>> +		} else if (((status1 >> i) & 0x01) =3D=3D 0) {=0D
>Given a bit can only be 0 or 1 and previous branch was for 1.=0D
>		} else {=0D
>=0D
>> +			if (aw9610x->satu_flag[i] =3D=3D 1) {=0D
>> +				if (((status0 >> (i + 24)) & 0x01) =3D=3D 0) {=0D
>> +					aw_sar_i2c_write(p_sar->i2c,=0D
>> +							REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS,=0D
>> +							aw9610x->satu_data[i]);=0D
>> +					aw9610x->satu_flag[i] =3D 0;=0D
>> +				}=0D
>> +			}=0D
>> +		}=0D
>> +	}=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +=0D
>> +static void aw9610x_saturat_release_handle(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	unsigned int satu_irq;=0D
>> +	unsigned int status0;=0D
>> +	unsigned char i;=0D
>> +=0D
>> +	satu_irq =3D (aw9610x->irq_status >> 7) & 0x01;=0D
>> +	if (satu_irq =3D=3D 1) {=0D
>> +		aw9610x_baseline_filter(p_sar);=0D
>> +	} else {=0D
>> +		aw_sar_i2c_read(p_sar->i2c, REG_STAT0, &status0);=0D
>> +		for (i =3D 0; i < AW9610X_CHANNEL_MAX; i++) {=0D
>> +			if (aw9610x->satu_flag[i] =3D=3D 1) {=0D
>=0D
>If it's a flag, make it boolean.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +				if (((status0 >> (i + 24)) & 0x01) =3D=3D 0) {=0D
>> +					aw_sar_i2c_write(p_sar->i2c,=0D
>> +							REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS,=0D
>> +							aw9610x->satu_data[i]);=0D
>> +					aw9610x->satu_flag[i] =3D 0;=0D
>> +				}=0D
>> +			}=0D
>> +		}=0D
>> +	}=0D
>> +}=0D
>> +=0D
>> +static void aw9610x_irq_handle(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	unsigned int curr_status_val;=0D
>> +	unsigned int curr_status;=0D
>> +	unsigned char i;=0D
>> +=0D
>> +	aw_sar_i2c_read(p_sar->i2c, REG_STAT0, &curr_status_val);=0D
>> +	if (!p_sar->channels_arr) {=0D
>> +		dev_err(p_sar->dev, "p_sar->channels_arr err!!!");=0D
>> +		return;=0D
>> +	}=0D
>> +=0D
>> +	for (i =3D 0; i < AW9610X_CHANNEL_MAX; i++) {=0D
>> +		curr_status =3D=0D
>> +			(((unsigned char)(curr_status_val >> (24 + i)) & 0x1))=0D
>WHy is the cast needed?=0D
>> +#ifdef AW_INPUT_TRIGGER_TH1=0D
>=0D
>No ifdefs like this should be seen in a submitted driver.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +			| (((unsigned char)(curr_status_val >> (16 + i)) & 0x1) << 1)=0D
>> +#endif=0D
>> +#ifdef AW_INPUT_TRIGGER_TH2=0D
>> +			| (((unsigned char)(curr_status_val >> (8 + i)) & 0x1) << 2)=0D
>> +#endif=0D
>> +#ifdef AW_INPUT_TRIGGER_TH3=0D
>> +			| (((unsigned char)(curr_status_val >> (i)) & 0x1) << 3)=0D
>> +#endif=0D
>> +			;=0D
>> +=0D
>> +		if (p_sar->channels_arr[i].used =3D=3D AW_FALSE)=0D
>=0D
>Use a boolean and don't invent your own idea of true adn flase.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>=0D
>> +			continue;=0D
>> +=0D
>> +		if (p_sar->channels_arr[i].last_channel_info =3D=3D curr_status)=0D
>> +			continue;=0D
>> +=0D
>> +		switch (curr_status) {=0D
>> +		case AW9610X_FAR:=0D
>> +			iio_push_event(p_sar->aw_iio_dev,=0D
>> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,=0D
>> +						IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),=0D
>> +					iio_get_time_ns(p_sar->aw_iio_dev));=0D
>> +			break;=0D
>> +		case AW9610X_TRIGGER_TH0:=0D
>> +#ifdef AW_INPUT_TRIGGER_TH1=0D
>> +		case AW9610X_TRIGGER_TH1:=0D
>> +#endif=0D
>> +#ifdef AW_INPUT_TRIGGER_TH2=0D
>> +		case AW9610X_TRIGGER_TH2:=0D
>> +#endif=0D
>> +#ifdef AW_INPUT_TRIGGER_TH3=0D
>> +		case AW9610X_TRIGGER_TH3:=0D
>> +#endif=0D
>> +			iio_push_event(p_sar->aw_iio_dev,=0D
>> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,=0D
>> +						IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),=0D
>> +					iio_get_time_ns(p_sar->aw_iio_dev));=0D
>> +			break;=0D
>> +		default:=0D
>> +			dev_err(p_sar->dev, "error abs distance");=0D
>> +			return;=0D
>> +		}=0D
>> +		p_sar->channels_arr[i].last_channel_info =3D curr_status;=0D
>> +	}=0D
>> +}=0D
>> +=0D
>> +static void aw9610x_version_aw9610x_private(struct aw_sar *p_sar)=0D
>=0D
>For an unusual bit of code like this, add a comment on what is goig on.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +=0D
>> +	if (aw9610x->satu_release =3D=3D AW9610X_FUNC_ON)=0D
>> +		aw9610x_saturat_release_handle(p_sar);=0D
>> +}=0D
>> +=0D
>> +static void aw9610x_irq_handle_func(unsigned int irq_status, void *data=
)=0D
>> +{=0D
>> +	struct aw_sar *p_sar =3D (struct aw_sar *)data;=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +=0D
>> +	switch (aw9610x->vers) {=0D
>> +	case AW9610X:=0D
>> +		aw9610x_version_aw9610x_private(p_sar);=0D
>> +		break;=0D
>> +	case AW9610XA:=0D
>If it's the same as default, rely on default.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +		break;=0D
>> +	default:=0D
>> +		break;=0D
>> +	}=0D
>> +=0D
>> +	aw9610x_irq_handle(p_sar);=0D
>> +}=0D
>> +=0D
>> +int aw9610x_check_chipid(void *data)=0D
>> +{=0D
>> +	struct aw_sar *p_sar =3D (struct aw_sar *)data;=0D
>> +	unsigned int reg_val;=0D
>> +	int ret;=0D
>> +=0D
>> +	if (!p_sar)=0D
>> +		return -EINVAL;=0D
>> +=0D
>> +	ret =3D aw_sar_i2c_read(p_sar->i2c, REG_CHIPID, &reg_val);=0D
>> +	if (ret < 0) {=0D
>> +		dev_err(p_sar->dev, "read CHIP ID failed: %d", ret);=0D
>> +		return ret;=0D
>> +	}=0D
>> +	reg_val =3D reg_val >> 16;=0D
>=0D
>FIELD_GET() with appropriately defined mask.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +=0D
>> +	if (reg_val !=3D AW9610X_CHIP_ID) {=0D
>> +		dev_err(p_sar->dev, "unsupport dev, chipid is (0x%04x)", reg_val);=0D
>=0D
>=0D
>To allow use of fallback compatibles in DT we normally accept chipid missm=
atches.=0D
>So at most dev_info and carry on anyway.=0D
>=0D
=0D
Sorry, if the chipid does not match, the driver is likely to encounter issu=
es=0D
during operation. We will not consider compatibility with more devices for=
=0D
the time being.=0D
=0D
>> +		return -EINVAL;=0D
>> +	}=0D
>> +	memcpy(p_sar->chip_name, "AW9610X", 8);=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +EXPORT_SYMBOL_NS_GPL(aw9610x_check_chipid, AWINIC_PROX);=0D
>> +=0D
>> +static const struct aw_sar_check_chipid_t g_aw9610x_check_chipid =3D {=
=0D
>> +	.p_check_chipid_fn =3D aw9610x_check_chipid,=0D
>> +};=0D
>> +=0D
>> +static ssize_t aw9610x_operation_mode_get(void *data, char *buf)=0D
>> +{=0D
>> +	struct aw_sar *p_sar =3D (struct aw_sar *)data;=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	ssize_t len =3D 0;=0D
>> +=0D
>> +	if (p_sar->last_mode =3D=3D AW9610X_ACTIVE_MODE)=0D
>> +		len +=3D snprintf(buf + len, PAGE_SIZE - len, "operation mode: Active=
\n");	=0D
>		return snprintf()=0D
>=0D
>	if ()=0D
>		return sprintf;=0D
>etc=0D
>=0D
>However this sort of custom ABI needs docs in Documenation/ABI/testing/sys=
fs-bus-iio*=0D
>and we are reluctant to accept it because it's the sort of thing userspace=
 has no idea=0D
>how to use. These sleep / deepsleep are marketing terms.  Much better the =
driver uses=0D
>runtime_pm or similar to work out what state it should be in dependent on =
how it is=0D
>being used etc.=0D
>=0D
=0D
In the next version of the patch, I will remove unnecessary interfaces.=0D
=0D
>> +	else if (p_sar->last_mode =3D=3D AW9610X_SLEEP_MODE)=0D
>> +		len +=3D snprintf(buf + len, PAGE_SIZE - len, "operation mode: Sleep\=
n");=0D
>> +	else if ((p_sar->last_mode =3D=3D AW9610X_DEEPSLEEP_MODE) && (aw9610x-=
>vers =3D=3D AW9610XA))=0D
>> +		len +=3D snprintf(buf + len, PAGE_SIZE - len, "operation mode: DeepSl=
eep\n");=0D
>> +	else=0D
>> +		len +=3D snprintf(buf + len, PAGE_SIZE - len, "operation mode: Unconf=
irmed\n");=0D
>> +=0D
>> +	return len;=0D
>> +}=0D
>> +=0D
>> +static void aw9610x_chip_info_get(void *data, char *buf, ssize_t *p_len=
)=0D
>> +{=0D
>> +	struct aw_sar *p_sar =3D (struct aw_sar *)data;=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	unsigned int reg_data;=0D
>> +=0D
>I can't actually work out where this ends up, but as a general rule format=
ted data=0D
>doesn't make sense. If this needs to be exposed. One value per file si the=
 way=0D
>to go - not a block of text.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +	*p_len +=3D snprintf(buf + *p_len, PAGE_SIZE - *p_len,=0D
>> +			"sar%u\n", p_sar->dts_info.sar_num);=0D
>> +	*p_len +=3D snprintf(buf + *p_len, PAGE_SIZE - *p_len, "The driver sup=
ports UI\n");=0D
>> +=0D
>> +	aw_sar_i2c_read(p_sar->i2c, REG_CHIPID, &reg_data);=0D
>> +	*p_len +=3D snprintf(buf + *p_len, PAGE_SIZE - *p_len, "chipid is 0x%0=
8x\n", reg_data);=0D
>> +=0D
>> +	aw_sar_i2c_read(p_sar->i2c, REG_IRQEN, &reg_data);=0D
>> +	*p_len +=3D snprintf(buf + *p_len, PAGE_SIZE - *p_len, "REG_HOSTIRQEN =
is 0x%08x\n", reg_data);=0D
>> +=0D
>> +	*p_len +=3D snprintf(buf + *p_len, PAGE_SIZE - *p_len,=0D
>> +			"chip_name:%s bin_prase_chip_name:%s\n",=0D
>> +			aw9610x->chip_name, aw9610x->chip_type);=0D
>> +}=0D
>> +=0D
>> +static const struct aw_sar_get_chip_info_t g_aw9610x_get_chip_info =3D =
{=0D
>> +	.p_get_chip_info_node_fn =3D aw9610x_chip_info_get,=0D
>> +};=0D
>> +=0D
>> +static void aw9610x_reg_version_comp(struct aw_sar *p_sar, struct aw_bi=
n *aw_bin)=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	unsigned int blfilt1_data;=0D
>> +	unsigned int blfilt1_tmp;=0D
>> +	unsigned char i;=0D
>> +=0D
>> +	if ((aw9610x->chip_name[7] =3D=3D 'A') &&=0D
>=0D
>If there is somthing that is chip specific encode it properly as a=0D
>field in the chip specific structure, not based on chip_name.=0D
>=0D
=0D
In the next version of the patch, I will use the chip version for judgment.=
=0D
=0D
>> +		(aw_bin->header_info[0].chip_type[7] =3D=3D '\0')) {=0D
>> +		for (i =3D 0; i < 6; i++) {=0D
>> +			aw_sar_i2c_read(p_sar->i2c, REG_BLFILT_CH0 + (0x3c * i), &blfilt1_da=
ta);=0D
>> +			blfilt1_tmp =3D (blfilt1_data >> 25) & 0x1;=0D
>FIELD_GET() and appropriately defined mask.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +			if (blfilt1_tmp =3D=3D 1)=0D
>> +				aw_sar_i2c_write_bits(p_sar->i2c, REG_BLRSTRNG_CH0 + (0x3c * i),=0D
>> +						~(0x3f), 1 << i);=0D
>> +		}=0D
>> +	}=0D
>> +}=0D
>> +=0D
>> +static int aw9610x_load_reg_bin(struct aw_bin *aw_bin, void *load_bin_p=
ara)=0D
>> +{=0D
>> +	struct aw_sar *p_sar =3D (struct aw_sar *)load_bin_para;=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	int ret;=0D
>> +=0D
>> +	snprintf(aw9610x->chip_type, sizeof(aw9610x->chip_type), "%s",=0D
>> +			aw_bin->header_info[0].chip_type);=0D
>> +	ret =3D strncmp(aw9610x->chip_name, aw_bin->header_info[0].chip_type,=
=0D
>> +			sizeof(aw_bin->header_info[0].chip_type));=0D
>> +	if (ret !=3D 0)=0D
>> +		dev_err(p_sar->dev, "load_binname(%s) incompatible with chip type(%s)=
",=0D
>> +			p_sar->chip_name, aw_bin->header_info[0].chip_type);=0D
>Why carry on? It failed, return the error without the next bit.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +	p_sar->load_bin.bin_data_ver =3D aw_bin->header_info[0].bin_data_ver;=
=0D
>> +=0D
>> +	ret =3D aw_sar_load_reg(aw_bin, p_sar->i2c);=0D
>> +	aw9610x_reg_version_comp(p_sar, aw_bin);=0D
>> +=0D
>> +	return ret;=0D
>> +}=0D
>> +=0D
>> +static ssize_t aw9610x_get_self_cap_offset(void *data, char *buf)=0D
>> +{=0D
>> +	struct aw_sar *p_sar =3D (struct aw_sar *)data;=0D
>> +	unsigned char temp_data[20] =3D { 0 };=0D
>> +	unsigned int coff_data_int;=0D
>> +	unsigned int coff_data_dec;=0D
>> +	unsigned int coff_data;=0D
>> +	unsigned int reg_val;=0D
>> +	ssize_t len =3D 0;=0D
>> +	unsigned char i;=0D
>> +=0D
>> +	for (i =3D 0; i < AW9610X_CHANNEL_MAX; i++) {=0D
>> +		aw_sar_i2c_read(p_sar->i2c,=0D
>> +			REG_AFECFG1_CH0 + i * AW_CL1SPE_CALI_OS, &reg_val);=0D
>> +		coff_data =3D (reg_val >> 24) * 900 + ((reg_val >> 16) & 0xff) * 13;=
=0D
>> +		coff_data_int =3D coff_data / 1000;=0D
>> +		coff_data_dec =3D coff_data % 1000;=0D
>> +		snprintf(temp_data, sizeof(temp_data), "%u.%u", coff_data_int, coff_d=
ata_dec);=0D
>> +		len +=3D snprintf(buf+len, PAGE_SIZE-len, "PARASITIC_DATA_CH%d =3D %s=
 pf\n",=0D
>> +				i, temp_data);=0D
>> +	}=0D
>> +=0D
>> +	return len;=0D
>> +}=0D
>> +=0D
>> +static const struct aw_sar_offset_t g_aw9610x_offset =3D {=0D
>> +	.p_get_offset_node_fn =3D aw9610x_get_self_cap_offset,=0D
>> +};=0D
>>=0D
>> +=0D
>> +static void aw9610x_datablock_load(struct aw_sar *p_sar, const char *bu=
f)=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D p_sar->priv_data;=0D
>> +	unsigned char addr_bytes =3D aw9610x->aw_i2c_package.addr_bytes;=0D
>> +	unsigned char data_bytes =3D aw9610x->aw_i2c_package.data_bytes;=0D
>> +	unsigned char reg_num =3D aw9610x->aw_i2c_package.reg_num;=0D
>> +	unsigned char reg_data[220] =3D { 0 };=0D
>> +	unsigned int databuf[220] =3D { 0 };=0D
>Too big for the stack.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +	unsigned char temp_buf[2] =3D { 0 };=0D
>> +	unsigned int i;=0D
>> +=0D
>> +	for (i =3D 0; i < data_bytes * reg_num; i++) {=0D
>> +		if (reg_num < attr_buf[1]) {=0D
>> +			temp_buf[0] =3D buf[attr_buf[0] + (addr_bytes + i) * 5];=0D
>> +			temp_buf[1] =3D=0D
>> +				buf[attr_buf[0] + (addr_bytes + i) * 5 + 1];=0D
>> +		} else if (reg_num >=3D attr_buf[1] && reg_num < attr_buf[3]) {=0D
>> +			temp_buf[0] =3D buf[attr_buf[2] + (addr_bytes + i) * 5];=0D
>> +			temp_buf[1] =3D=0D
>> +				buf[attr_buf[2] + (addr_bytes + i) * 5 + 1];=0D
>> +		} else if (reg_num >=3D attr_buf[3] && reg_num < attr_buf[5]) {=0D
>> +			temp_buf[0] =3D buf[attr_buf[4] + (addr_bytes + i) * 5];=0D
>> +			temp_buf[1] =3D=0D
>> +				buf[attr_buf[4] + (addr_bytes + i) * 5 + 1];=0D
>> +		}=0D
>> +		sscanf(temp_buf, "%02x", &databuf[i]);=0D
>> +		reg_data[i] =3D (unsigned char)databuf[i];=0D
>> +	}=0D
>> +	aw9610x->aw_i2c_package.p_reg_data =3D reg_data;=0D
>> +	aw9610x_awrw_write_seq(p_sar);=0D
>> +}=0D
>> +=0D
>> +static int aw9610x_awrw_read_seq(struct aw_sar *p_sar, unsigned char *r=
eg_data)=0D
>> +{=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	unsigned char data_bytes =3D aw9610x->aw_i2c_package.data_bytes;=0D
>> +	unsigned char addr_bytes =3D aw9610x->aw_i2c_package.addr_bytes;=0D
>> +	unsigned char reg_num =3D aw9610x->aw_i2c_package.reg_num;=0D
>> +	unsigned short msg_cnt =3D (unsigned short)(data_bytes * reg_num);=0D
>> +	unsigned char w_buf[4];=0D
>> +	unsigned char buf[228];=0D
>> +	unsigned int msg_idx;=0D
>> +	int ret;=0D
>> +=0D
>> +	for (msg_idx =3D 0; msg_idx < addr_bytes; msg_idx++)=0D
>> +		w_buf[msg_idx] =3D aw9610x->aw_i2c_package.init_addr[msg_idx];=0D
>> +=0D
>> +	ret =3D aw_sar_i2c_read_seq(p_sar->i2c, w_buf, 2, (unsigned char *)buf=
, msg_cnt);=0D
>=0D
>If there was an error, don't update the data passed out of here as it's=0D
>garbage.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +	for (msg_idx =3D 0; msg_idx < msg_cnt; msg_idx++)=0D
>> +		reg_data[msg_idx] =3D buf[msg_idx];=0D
>> +=0D
>> +	return ret;=0D
>> +}=0D
>=0D
>> +=0D
>> +static void aw9610x_power_on_prox_detection(void *data, unsigned char e=
n_flag)=0D
>> +{=0D
>> +	struct aw_sar *p_sar =3D (struct aw_sar *)data;=0D
>> +	struct aw9610x *aw9610x =3D (struct aw9610x *)p_sar->priv_data;=0D
>> +	unsigned char ch;=0D
>> +=0D
>> +	if (en_flag =3D=3D true) {=0D
>=0D
>if (en_flag) {=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +		for (ch =3D 0; ch < AW9610X_CHANNEL_MAX; ch++) {=0D
>> +			aw_sar_i2c_read(p_sar->i2c,=0D
>> +				REG_BLFILT_CH0 + (REG_BLFILT_CH1 - REG_BLFILT_CH0) * ch,=0D
>> +				&(aw9610x->last_blfilta[ch]));=0D
>> +			aw_sar_i2c_write_bits(p_sar->i2c,=0D
>> +				REG_BLFILT_CH0 + (REG_BLFILT_CH1 - REG_BLFILT_CH0) * ch,=0D
>> +				~(0x3f << 13), (1 << 13));=0D
>> +		}=0D
>> +		aw_sar_i2c_read(p_sar->i2c, REG_IRQEN, &aw9610x->last_irq_en);=0D
>> +		aw_sar_i2c_write_bits(p_sar->i2c, REG_IRQEN, ~(1 << 3), 1 << 3);=0D
>> +	} else if (en_flag =3D=3D false) {=0D
>=0D
>} else {=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +		for (ch =3D 0; ch < AW9610X_CHANNEL_MAX; ch++) {=0D
>> +			aw_sar_i2c_write(p_sar->i2c,=0D
>> +				REG_BLFILT_CH0 + (REG_BLFILT_CH1 - REG_BLFILT_CH0) * ch,=0D
>> +				aw9610x->last_blfilta[ch]);=0D
>> +		}=0D
>> +		aw_sar_i2c_write(p_sar->i2c, REG_IRQEN, aw9610x->last_irq_en);=0D
>> +	}=0D
>> +}=0D
>> +=0D
>> +static const struct aw_sar_power_on_prox_detection_t g_aw9610x_power_on=
_prox_detection =3D {=0D
>> +	.p_power_on_prox_detection_en_fn =3D aw9610x_power_on_prox_detection,=
=0D
>> +	.irq_en_cali_bit =3D 3,=0D
>> +	.power_on_prox_en_flag =3D true,=0D
>> +};=0D
>=0D
>Why not embed this structure directly in aw_sar_chip_info?=0D
>Seems like a number of the other structures would also be better handled t=
hat way=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +static const struct aw_sar_chip_config g_aw9610x_chip_config =3D {=0D
>> +	.ch_num_max =3D AW9610X_CHANNEL_MAX,=0D
>> +=0D
>> +	.p_platform_config =3D &g_aw9610x_platform_config,=0D
>> +=0D
>> +	.p_check_chipid =3D &g_aw9610x_check_chipid,=0D
>> +	.p_soft_rst =3D &g_aw9610x_soft_rst,=0D
>> +	.p_init_over_irq =3D &g_aw9610x_init_over_irq,=0D
>> +	.p_reg_bin =3D &g_aw9610x_load_reg_bin,=0D
>> +	.p_chip_mode =3D &g_aw9610x_chip_mode,=0D
>> +=0D
>> +	/* Node usage parameters */=0D
>> +	.p_reg_list =3D &g_aw9610x_reg_list,=0D
>> +	.p_reg_arr =3D &g_aw9610x_reg_arr_para,=0D
>> +	.p_aot =3D &g_aw9610x_aot,=0D
>> +	.p_diff =3D &g_aw9610x_diff,=0D
>> +	.p_offset =3D &g_aw9610x_offset,=0D
>> +	.p_mode =3D &g_aw9610x_mode,=0D
>> +	.p_get_chip_info =3D &g_aw9610x_get_chip_info,=0D
>> +	.p_aw_sar_awrw =3D &g_aw9610x_awrw,=0D
>> +=0D
>> +	.p_other_operation =3D aw9610x_get_chip_version,=0D
>> +	.p_other_opera_free =3D NULL,=0D
>> +	.power_on_prox_detection =3D &g_aw9610x_power_on_prox_detection,=0D
>> +};=0D
>> +=0D
>> +int aw9610x_init(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	if (!p_sar)=0D
>> +		return -EINVAL;=0D
>> +=0D
>> +	g_aw_sar =3D p_sar;=0D
>> +=0D
>> +	p_sar->priv_data =3D devm_kzalloc(p_sar->dev, sizeof(struct aw9610x), =
GFP_KERNEL);=0D
>> +	if (!p_sar->priv_data)=0D
>> +		return -ENOMEM;=0D
>> +=0D
>> +	/* Chip private function operation */=0D
>> +	p_sar->p_sar_para =3D &g_aw9610x_chip_config;=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +EXPORT_SYMBOL_NS_GPL(aw9610x_init, AWINIC_PROX);=0D
>> +=0D
>> +void aw9610x_deinit(struct aw_sar *p_sar)=0D
>> +{=0D
>> +	if (p_sar->priv_data !=3D NULL)=0D
>> +		devm_kfree(p_sar->dev, p_sar->priv_data);=0D
>=0D
>I haven't checked but dev_kfree() calls that aren't clearly an error path =
cleanup=0D
>are almost always a bug..  The whole point is that they happen automatical=
ly and=0D
>you don't need to call them.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +}=0D
>> +EXPORT_SYMBOL_NS_GPL(aw9610x_deinit, AWINIC_PROX);=0D
>> +=0D
=0D
=0D
...=0D
=0D
=0D
>> diff --git a/drivers/iio/proximity/aw_sar_comm_interface.c b/drivers/iio=
/proximity/aw_sar_comm_interface.c=0D
>> new file mode 100644=0D
>> index 000000000000..8a7d437d100b=0D
>> --- /dev/null=0D
>> +++ b/drivers/iio/proximity/aw_sar_comm_interface.c=0D
>> @@ -0,0 +1,550 @@=0D
>> +// SPDX-License-Identifier: GPL-2.0=0D
>> +#include "aw_sar_comm_interface.h"=0D
>> +=0D
>> +#define AW_I2C_RW_RETRY_TIME_MIN		(2000)=0D
>> +#define AW_I2C_RW_RETRY_TIME_MAX		(3000)=0D
>> +#define AW_RETRIES				(5)=0D
>> +=0D
>> +static int awinic_i2c_write(struct i2c_client *i2c, unsigned char *tr_d=
ata, unsigned short len)=0D
>> +{=0D
>> +	struct i2c_msg msg;=0D
>> +=0D
>> +	msg.addr =3D i2c->addr;=0D
>> +	msg.flags =3D 0;=0D
>> +	msg.len =3D len;=0D
>> +	msg.buf =3D tr_data;=0D
>> +=0D
>> +	return i2c_transfer(i2c->adapter, &msg, 1);=0D
>=0D
>Looks like i2c_master_send() =0D
>=0D
>Use that inline rather than having your own version.=0D
>=0D
=0D
In the next version of the patch, I will use regmap.=0D
=0D
>> +}=0D
>> +=0D
>> +static int awinic_i2c_read(struct i2c_client *i2c, unsigned char *addr,=
=0D
>> +				unsigned char addr_len, unsigned char *data, unsigned short data_le=
n)=0D
>Why would a length be a char?  u8 maybe.=0D
>Also data as u8 not char. =0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +{=0D
>> +	struct i2c_msg msg[2];=0D
>> +=0D
>> +	msg[0].addr =3D i2c->addr;=0D
>> +	msg[0].flags =3D 0;=0D
>> +	msg[0].len =3D addr_len;=0D
>> +	msg[0].buf =3D addr;=0D
>> +=0D
>> +	msg[1].addr =3D i2c->addr;=0D
>> +	msg[1].flags =3D 1;=0D
>> +	msg[1].len =3D data_len;=0D
>> +	msg[1].buf =3D data;=0D
>> +=0D
>> +	return i2c_transfer(i2c->adapter, msg, 2);=0D
>> +}=0D
>> +=0D
>> +int aw_sar_i2c_read(struct i2c_client *i2c, unsigned short reg_addr16, =
unsigned int *reg_data32)=0D
>> +{=0D
>> +	unsigned char r_buf[6] =3D { 0 };=0D
>> +	unsigned char cnt =3D 5;=0D
>> +	int ret;=0D
>> +=0D
>> +	if (!i2c)=0D
>> +		return -EINVAL;=0D
>> +=0D
>> +	r_buf[0] =3D (unsigned char)(reg_addr16 >> OFFSET_BIT_8);=0D
>> +	r_buf[1] =3D (unsigned char)(reg_addr16);=0D
>=0D
>put_unaligned_be16()=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>=0D
>> +=0D
>> +	do {=0D
>> +		ret =3D awinic_i2c_read(i2c, r_buf, 2, &r_buf[2], 4);=0D
>Use two buffers as easeir to read and you can type them correctly as __be1=
6 and=0D
>__be32 I think.=0D
>=0D
>> +		if (ret < 0)=0D
>> +			dev_err(&i2c->dev, "i2c read error reg: 0x%04x, ret=3D %d cnt=3D %d"=
,=0D
>> +					reg_addr16, ret, cnt);=0D
>> +		else=0D
>> +			break;=0D
>> +		usleep_range(2000, 3000);=0D
>=0D
>Any retry needs documentation on why it might be necessary + why these val=
ues.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +	} while (cnt--);=0D
>> +=0D
>> +	if (cnt < 0) {=0D
>> +		dev_err(&i2c->dev, "i2c read error!");=0D
>> +		return ret;=0D
>> +	}=0D
>> +=0D
>> +	*reg_data32 =3D ((unsigned int)r_buf[5] << OFFSET_BIT_0) | ((unsigned =
int)r_buf[4] << OFFSET_BIT_8) |=0D
>> +		((unsigned int)r_buf[3] << OFFSET_BIT_16) | ((unsigned int)r_buf[2] <=
< OFFSET_BIT_24);=0D
>get_unaligned_be32()=0D
>or be32_to_cpu() if you use a __be32 as the buffer in the first place=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +=0D
>> +int aw_sar_i2c_write(struct i2c_client *i2c, unsigned short reg_addr16,=
 unsigned int reg_data32)=0D
>=0D
>u16 and u32 to get kernel fixed width types.=0D
>=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +{=0D
>> +	unsigned char w_buf[6] =3D { 0 };=0D
>You fill it all so don't initialize.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +	unsigned char cnt =3D 5;=0D
>> +	int ret;=0D
>> +=0D
>> +	if (!i2c)=0D
>> +		return -EINVAL;=0D
>> +=0D
>> +	/* reg_addr */=0D
>> +	w_buf[0] =3D (unsigned char)(reg_addr16 >> OFFSET_BIT_8);=0D
>> +	w_buf[1] =3D (unsigned char)(reg_addr16);=0D
>=0D
>put_unaligned_be16()=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +	/* data */=0D
>> +	w_buf[2] =3D (unsigned char)(reg_data32 >> OFFSET_BIT_24);=0D
>> +	w_buf[3] =3D (unsigned char)(reg_data32 >> OFFSET_BIT_16);=0D
>> +	w_buf[4] =3D (unsigned char)(reg_data32 >> OFFSET_BIT_8);=0D
>> +	w_buf[5] =3D (unsigned char)(reg_data32);=0D
>put_unaligned_be32() or similar.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +=0D
>> +	do {=0D
>> +		ret =3D awinic_i2c_write(i2c, w_buf, ARRAY_SIZE(w_buf));=0D
>> +		if (ret < 0) {=0D
>> +			dev_err(&i2c->dev,=0D
>> +					"i2c write error reg: 0x%04x data: 0x%08x, ret=3D %d cnt=3D %d",=0D
>> +					reg_addr16, reg_data32, ret, cnt);=0D
>> +		} else {=0D
>> +			break;=0D
>> +		}=0D
>> +	} while (cnt--);=0D
>Why are retries needed?  Very unlikely that they are on a sensible circuit=
 board.=0D
>Prefer to just report an error to the caller if one occurs rather than try=
 again.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +	if (cnt < 0) {=0D
>> +		dev_err(&i2c->dev, "i2c write error!");=0D
>> +		return ret;=0D
>> +	}=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +=0D
>> +int=0D
>> +aw_sar_i2c_write_bits(struct i2c_client *i2c, unsigned short reg_addr16=
, unsigned int mask, unsigned int val)=0D
>> +{=0D
>> +	unsigned int reg_val;=0D
>> +=0D
>> +	aw_sar_i2c_read(i2c, reg_addr16, &reg_val);=0D
>> +	reg_val &=3D mask;=0D
>> +	reg_val |=3D (val & (~mask));=0D
>> +	aw_sar_i2c_write(i2c, reg_addr16, reg_val);=0D
>=0D
>May well makes sense to use a custom regmap as then you will get all this =
stuff for=0D
>free.=0D
>=0D
=0D
In the next version of the patch, I will use regmap.=0D
=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +=0D
>> +int aw_sar_i2c_write_seq(struct i2c_client *i2c, unsigned char *tr_data=
, unsigned short len)=0D
>> +{=0D
>> +	unsigned char cnt =3D AW_RETRIES;=0D
>> +	int ret;=0D
>> +=0D
>> +	do {=0D
>> +		ret =3D awinic_i2c_write(i2c, tr_data, len);=0D
>> +		if (ret < 0)=0D
>> +			dev_err(&i2c->dev, "awinic i2c write seq error %d", ret);=0D
>> +		else=0D
>> +			break;=0D
>> +		usleep_range(AW_I2C_RW_RETRY_TIME_MIN, AW_I2C_RW_RETRY_TIME_MAX);=0D
>> +	} while (cnt--);=0D
>=0D
>As above. Why retries?=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +	if (cnt < 0) {=0D
>> +		dev_err(&i2c->dev, "awinic i2c write error!");=0D
>> +		return ret;=0D
>> +	}=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +=0D
>> +int aw_sar_i2c_read_seq(struct i2c_client *i2c, unsigned char *addr,=0D
>> +				unsigned char addr_len, unsigned char *data, unsigned short data_le=
n)=0D
>> +{=0D
>> +	unsigned char cnt =3D AW_RETRIES;=0D
>> +	int ret;=0D
>> +=0D
>> +	do {=0D
>> +		ret =3D awinic_i2c_read(i2c, addr, addr_len, data, data_len);=0D
>> +		if (ret < 0)=0D
>> +			dev_err(&i2c->dev, "awinic sar i2c write error %d", ret);=0D
>> +		else=0D
>> +			break;=0D
>> +		usleep_range(AW_I2C_RW_RETRY_TIME_MIN, AW_I2C_RW_RETRY_TIME_MAX);=0D
>> +	} while (cnt--);=0D
>> +=0D
>> +	if (cnt < 0) {=0D
>> +		dev_err(&i2c->dev, "awinic sar i2c read error!");=0D
>> +		return ret;=0D
>> +	}=0D
>> +=0D
>> +	return 0;=0D
>> +}=0D
>> +=0D
>> +=0D
>> +enum bin_header_version_enum {=0D
>> +	HEADER_VERSION_1_0_0 =3D 0x01000000,=0D
>> +};=0D
>> +=0D
>> +enum data_type_enum {=0D
>> +	DATA_TYPE_REGISTER =3D 0x00000000,=0D
>> +	DATA_TYPE_DSP_REG =3D 0x00000010,=0D
>> +	DATA_TYPE_DSP_CFG =3D 0x00000011,=0D
>> +	DATA_TYPE_SOC_REG =3D 0x00000020,=0D
>> +	DATA_TYPE_SOC_APP =3D 0x00000021,=0D
>> +	DATA_TYPE_MULTI_BINS =3D 0x00002000,=0D
>> +};=0D
>> +=0D
>> +#define BigLittleSwap16(A)	((((unsigned short int)(A) & 0xff00) >> 8) |=
 \=0D
>> +				(((unsigned short int)(A) & 0x00ff) << 8))=0D
>Why?  We have standard functions for this swab16()=0D
>=0D
>> +=0D
>> +#define BigLittleSwap32(A)	((((unsigned long)(A) & 0xff000000) >> 24) |=
 \=0D
>> +				(((unsigned long)(A) & 0x00ff0000) >> 8) | \=0D
>> +				(((unsigned long)(A) & 0x0000ff00) << 8) | \=0D
>> +				(((unsigned long)(A) & 0x000000ff) << 24))=0D
>swab32()=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +static enum aw_bin_err_val aw_parse_bin_header_1_0_0(struct aw_bin *bin=
);=0D
>> +=0D
>> +static enum aw_bin_err_val aw_check_sum(struct aw_bin *bin, int bin_num=
)=0D
>> +{=0D
>> +	unsigned char *p_check_sum;=0D
>> +	unsigned int sum_data =3D 0;=0D
>> +	unsigned int check_sum;=0D
>> +	unsigned int i;=0D
>> +=0D
>> +	p_check_sum =3D &(bin->info.data[(bin->header_info[bin_num].valid_data=
_addr -=0D
>> +			bin->header_info[bin_num].header_len)]);=0D
>> +	check_sum =3D AW_SAR_GET_32_DATA(*(p_check_sum + 3), *(p_check_sum + 2=
),=0D
>> +				*(p_check_sum + 1), *(p_check_sum));=0D
>> +=0D
>> +	for (i =3D 4; i < bin->header_info[bin_num].bin_data_len +=0D
=0D
=0D
...=0D
=0D
=0D
>> +=0D
>> diff --git a/drivers/iio/proximity/aw_sar_comm_interface.h b/drivers/iio=
/proximity/aw_sar_comm_interface.h=0D
>> new file mode 100644=0D
>> index 000000000000..bc543bceb17d=0D
>> --- /dev/null=0D
>> +++ b/drivers/iio/proximity/aw_sar_comm_interface.h=0D
>> @@ -0,0 +1,172 @@=0D
>> +/* SPDX-License-Identifier: GPL-2.0-only */=0D
>> +#ifndef _AW_SAR_PLAT_HW_INTERFACE_H_=0D
>> +#define _AW_SAR_PLAT_HW_INTERFACE_H_=0D
>> +#include <linux/delay.h>=0D
>> +#include <linux/firmware.h>=0D
>> +#include <linux/i2c.h>=0D
>> +#include <linux/input.h>=0D
>> +#include <linux/interrupt.h>=0D
>> +#include <linux/of_gpio.h>=0D
>> +#include <linux/power_supply.h>=0D
>> +#include <linux/pinctrl/consumer.h>=0D
>> +#include <linux/regulator/consumer.h>=0D
>> +#include <linux/slab.h>=0D
>> +=0D
>> +#include <linux/iio/buffer.h>=0D
>> +#include <linux/iio/events.h>=0D
>> +#include <linux/iio/iio.h>=0D
>> +#include <linux/iio/trigger.h>=0D
>> +#include <linux/iio/triggered_buffer.h>=0D
>> +#include <linux/iio/trigger_consumer.h>=0D
>> +=0D
>> +enum aw_sar_chip_list_t {=0D
>> +	AW_SAR_NONE_CHECK_CHIP,=0D
>> +=0D
>> +	SAR_AW9610X =3D 1 << 1,=0D
>> +	SAR_AW9610XA =3D 1 << 2,=0D
>> +=0D
>> +	SAR_AW96303 =3D 1 << 6,=0D
>> +	SAR_AW96305 =3D 1 << 7,=0D
>> +	SAR_AW96308 =3D 1 << 8,=0D
>> +	SAR_AW96310 =3D 1 << 9,=0D
>> +	SAR_AW96312 =3D 1 << 10,=0D
>> +};=0D
>> +=0D
>> +#ifndef AW_TRUE=0D
>> +#define AW_TRUE					(1)=0D
>> +#endif=0D
>> +=0D
>> +#ifndef AW_FALSE=0D
>> +#define AW_FALSE				(0)=0D
>> +#endif=0D
>Just use true and false rather than adding your own definitions.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +=0D
>> +#define AW_ERR_IRQ_INIT_OVER			(0xAA)=0D
>> +=0D
>> +enum aw_sar_rst_val {=0D
>> +	AW_OK,=0D
>> +	AW_BIN_PARA_INVALID,=0D
>> +	AW_PROT_UPDATE_ERR,=0D
>> +	AW_REG_LOAD_ERR,=0D
>> +};=0D
>> +=0D
>> +#ifndef OFFSET_BIT_0=0D
>> +#define OFFSET_BIT_0				(0)=0D
>> +#endif=0D
>> +=0D
>> +#ifndef OFFSET_BIT_8=0D
>> +#define OFFSET_BIT_8				(8)=0D
>> +#endif=0D
>> +=0D
>> +#ifndef OFFSET_BIT_16=0D
>> +#define OFFSET_BIT_16				(16)=0D
>> +#endif=0D
>> +=0D
>> +#ifndef OFFSET_BIT_24=0D
>> +#define OFFSET_BIT_24				(24)=0D
>> +#endif=0D
>> +=0D
>> +#define AW_SAR_GET_32_DATA(w, x, y, z)	((unsigned int)(((w) << 24) | ((=
x) << 16) | ((y) << 8) | (z)))=0D
>> +=0D
>> +enum AW_SAR_HOST_IRQ_STAT {=0D
>> +	IRQ_ENABLE,=0D
>> +	IRQ_DISABLE,=0D
>> +};=0D
>> +=0D
>> +#define AW_SAR_BIN_NUM_MAX	100=0D
>> +=0D
>> +enum aw_bin_err_val {=0D
>> +	AW_BIN_ERROR_NONE =3D 0,=0D
>> +	AW_BIN_ERROR_HEADER_VERSION =3D -1,=0D
>> +	AW_BIN_ERROR_DATA_TYPE =3D -2,=0D
>> +	AW_BIN_ERROR_SUM_OR_DATA_LEN =3D -3,=0D
>> +	AW_BIN_ERROR_DATA_VERSION =3D -4,=0D
>> +	AW_BIN_ERROR_REGISTER_NUM =3D -5,=0D
>> +	AW_BIN_ERROR_DSP_REG_NUM =3D -6,=0D
>> +	AW_BIN_ERROR_SOC_APP_NUM =3D -7,=0D
>> +	AW_BIN_ERROR_NULL_POINT =3D -8,=0D
>> +};=0D
>> +=0D
>> +/**=0D
>> + * struct bin_header_info -=0D
>> + * @header_len: Frame header length=0D
>> + * @check_sum: Frame header information-Checksum=0D
>> + * @header_ver: Frame header information-Frame header version=0D
>> + * @bin_data_type: Frame header information-Data type=0D
>> + * @bin_data_ver: Frame header information-Data version=0D
>> + * @bin_data_len: Frame header information-Data length=0D
>> + * @ui_ver: Frame header information-ui version=0D
>> + * @chip_type: Frame header information-chip type=0D
>> + * @reg_byte_len: Frame header information-reg byte len=0D
>> + * @data_byte_len: Frame header information-data byte len=0D
>> + * @device_addr: Frame header information-device addr=0D
>> + * @valid_data_len: Length of valid data obtained after parsing=0D
>> + * @valid_data_addr: The offset address of the valid data obtained=0D
>> + *		after parsing relative to info=0D
>> + * @reg_num: The number of registers obtained after parsing=0D
>> + * @reg_data_byte_len: The byte length of the register obtained after p=
arsing=0D
>> + * @download_addr: The starting address or download address obtained af=
ter parsing=0D
>> + * @app_version: The software version number obtained after parsing=0D
>> + */=0D
>> +struct bin_header_info {=0D
>> +	unsigned int header_len;=0D
>> +	unsigned int check_sum;=0D
>> +	unsigned int header_ver;=0D
>> +	unsigned int bin_data_type;=0D
>> +	unsigned int bin_data_ver;=0D
>> +	unsigned int bin_data_len;=0D
>> +	unsigned int ui_ver;=0D
>> +	unsigned char chip_type[8];=0D
>> +	unsigned int reg_byte_len;=0D
>> +	unsigned int data_byte_len;=0D
>> +	unsigned int device_addr;=0D
>> +	unsigned int valid_data_len;=0D
>> +	unsigned int valid_data_addr;=0D
>> +	unsigned int reg_num;=0D
>> +	unsigned int reg_data_byte_len;=0D
>> +	unsigned int download_addr;=0D
>> +	unsigned int app_version;=0D
>> +};=0D
>> +=0D
>> +/**=0D
>> + * struct bin_container -=0D
>> + * @len: The size of the bin file obtained from the firmware=0D
>> + * @data: Store the bin file obtained from the firmware=0D
>> + */=0D
>> +struct bin_container {=0D
>> +	unsigned int len;=0D
>> +	unsigned char data[];=0D
>> +};=0D
>> +=0D
>> +/**=0D
>> + * struct aw_bin -=0D
>> + * @p_addr: Offset pointer (backward offset pointer to obtain frame hea=
der information and=0D
>> + *		important information)=0D
>> + * @all_bin_parse_num: The number of all bin files=0D
>> + * @multi_bin_parse_num: The number of single bin files=0D
>> + * @single_bin_parse_num: The number of multiple bin files=0D
>> + * @header_info: Frame header information and other important data obta=
ined after parsing=0D
>> + * @info: Obtained bin file data that needs to be parsed=0D
>> + */=0D
>> +struct aw_bin {=0D
>> +	char *p_addr;=0D
>> +	unsigned int all_bin_parse_num;=0D
>> +	unsigned int multi_bin_parse_num;=0D
>> +	unsigned int single_bin_parse_num;=0D
>> +	struct bin_header_info header_info[AW_SAR_BIN_NUM_MAX];=0D
>> +	struct bin_container info;=0D
>> +};=0D
>> +=0D
>> +/* I2C communication API */=0D
>> +int aw_sar_i2c_read(struct i2c_client *i2c, unsigned short reg_addr16, =
unsigned int *reg_data32);=0D
>> +int aw_sar_i2c_write(struct i2c_client *i2c, unsigned short reg_addr16,=
 unsigned int reg_data32);=0D
>> +int aw_sar_i2c_write_bits(struct i2c_client *i2c, unsigned short reg_ad=
dr16,=0D
>> +		unsigned int mask, unsigned int val);=0D
>> +int aw_sar_i2c_write_seq(struct i2c_client *i2c, unsigned char *tr_data=
, unsigned short len);=0D
>> +int aw_sar_i2c_read_seq(struct i2c_client *i2c, unsigned char *addr,=0D
>> +		unsigned char addr_len, unsigned char *data, unsigned short data_len)=
;=0D
>> +=0D
>> +enum aw_bin_err_val aw_sar_parsing_bin_file(struct aw_bin *bin);=0D
>> +unsigned int aw_sar_pow2(unsigned int cnt);=0D
>> +int aw_sar_load_reg(struct aw_bin *aw_bin, struct i2c_client *i2c);=0D
>> +=0D
>> +#endif=0D
>> diff --git a/drivers/iio/proximity/aw_sar_type.h b/drivers/iio/proximity=
/aw_sar_type.h=0D
>> new file mode 100644=0D
>> index 000000000000..e6744855315c=0D
>> --- /dev/null=0D
>> +++ b/drivers/iio/proximity/aw_sar_type.h=0D
>> @@ -0,0 +1,371 @@=0D
>> +/* SPDX-License-Identifier: GPL-2.0-only */=0D
>> +#ifndef _SAR_TYPE_H_=0D
>> +#define _SAR_TYPE_H_=0D
>> +=0D
>> +#include "aw_sar_comm_interface.h"=0D
>> +=0D
>> +typedef int (*aw_sar_chip_other_operation_t)(void *data);=0D
>> +typedef void (*aw_sar_chip_other_opera_free_t)(void *data);=0D
>> +=0D
>> +enum aw_i2c_flags {=0D
>> +	AW_SAR_I2C_WR,=0D
>> +	AW_SAR_I2C_RD,=0D
>> +	AW_SAR_PACKAGE_RD,=0D
>> +};=0D
>> +=0D
>> +enum sar_health_check {=0D
>> +	AW_SAR_HEALTHY =3D 0,=0D
>> +	AW_SAR_UNHEALTHY =3D 1,=0D
>> +};=0D
>> +typedef int (*aw_sar_bin_opera_t)(struct aw_bin *aw_bin, void *load_bin=
_para);=0D
>> +typedef int (*aw_sar_bin_load_fail_opera_t)(struct aw_bin *aw_bin, void=
 *load_bin_para);=0D
>> +=0D
>> +struct aw_sar_get_chip_info_t {=0D
>> +	void (*p_get_chip_info_node_fn)(void *data, char *buf, ssize_t *p_len)=
;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_load_bin_t {=0D
>> +	const unsigned char *bin_name;=0D
>> +	aw_sar_bin_opera_t bin_opera_func;=0D
>> +	aw_sar_bin_load_fail_opera_t bin_load_fail_opera;=0D
>> +=0D
>> +	void (*p_get_prot_update_fw_node_fn)(void *data, char *buf, ssize_t *p=
_len);=0D
>> +=0D
>> +	/* Perform different operations to update parameters */=0D
>> +	int (*p_update_fn)(void *data);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_reg_data {=0D
>> +	unsigned char rw;=0D
>> +	unsigned short reg;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_awrw_t {=0D
>> +	ssize_t (*p_set_awrw_node_fn)(void *data, const char *buf, size_t coun=
t);=0D
>> +	ssize_t (*p_get_awrw_node_fn)(void *data, char *buf);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_reg_list_t {=0D
>> +	unsigned char reg_none_access;=0D
>> +	unsigned char reg_rd_access;=0D
>> +	unsigned char reg_wd_access;=0D
>> +	const struct aw_sar_reg_data *reg_perm;=0D
>> +	unsigned int reg_num;=0D
>> +};=0D
>> +=0D
>> +typedef void (*aw_sar_update_work_t)(struct work_struct *work);=0D
>> +struct aw_sar_update_static_t {=0D
>> +	aw_sar_update_work_t update_work_func;=0D
>> +	unsigned int delay_ms;=0D
>> +};=0D
>> +=0D
>> +typedef irqreturn_t (*aw_sar_irq_t)(int irq, void *data);=0D
>> +typedef unsigned int (*sar_rc_irqscr_t)(void *i2c);=0D
>> +/*=0D
>> + * If the return value is 1, there is an initialization completion inte=
rrupt;=0D
>> + * if the return value is 0, there is no=0D
>> + */=0D
>> +typedef unsigned int (*aw_sar_is_init_over_irq)(unsigned int irq_status=
);=0D
>> +typedef void (*aw_sar_irq_spec_handler_t)(unsigned int irq_status, void=
 *data);=0D
>> +=0D
>> +struct aw_sar_check_chipid_t {=0D
>> +	/* Read chipid and check chipid, Must be implemented externally */=0D
>> +	int (*p_check_chipid_fn)(void *data);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_irq_init_t {=0D
>> +	unsigned long flags;=0D
>> +	unsigned long irq_flags;=0D
>> +	irq_handler_t handler;=0D
>> +	irq_handler_t thread_fn;=0D
>> +	/* Interrupt processing parameters */=0D
>> +	sar_rc_irqscr_t rc_irq_fn;=0D
>> +	/* aw_sar_is_init_over_irq is_init_over_irq_fn; */=0D
>> +	aw_sar_irq_spec_handler_t irq_spec_handler_fn;=0D
>> +=0D
>> +	/* Use a different initialization interrupt to initialize the operatio=
n */=0D
>> +	int (*p_irq_init_fn)(void *data);=0D
>> +	/* Release interrupt resource */=0D
>> +	int (*p_irq_deinit_fn)(void *data);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_pm_t {=0D
>> +	unsigned int suspend_set_mode;=0D
>> +	unsigned int resume_set_mode;=0D
>> +	unsigned int shutdown_set_mode;=0D
>> +	/* system api */=0D
>> +	int (*p_suspend_fn)(void *data);=0D
>> +	int (*p_resume_fn)(void *data);=0D
>> +	int (*p_shutdown_fn)(void *data);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_chip_mode_t {=0D
>> +	unsigned int init_mode;=0D
>> +	unsigned int active;=0D
>> +	unsigned int pre_init_mode;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_regulator_config_t {=0D
>> +	/* Note that "_sar_num" after VCC name is defined by SAR C auto add */=
=0D
>> +	const unsigned char *vcc_name;=0D
>> +	int min_uV;=0D
>> +	int max_uV;=0D
>> +};=0D
>> +=0D
>> +struct aw_channels_info {=0D
>> +	unsigned short used;=0D
>> +	unsigned int last_channel_info;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_dts_info {=0D
>> +	unsigned int sar_num;=0D
>> +	unsigned int channel_use_flag;=0D
>> +	bool use_regulator_flag;=0D
>> +	bool use_inter_pull_up;=0D
>> +	bool use_pm;=0D
>> +	bool use_plug_cail_flag;=0D
>> +	bool monitor_esd_flag;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_irq_init_comm_t {=0D
>> +	unsigned char host_irq_stat;=0D
>> +	void *data;=0D
>> +	unsigned char dev_id[30];=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_load_bin_comm_t {=0D
>> +	unsigned char bin_name[30];=0D
>> +	unsigned int bin_data_ver;=0D
>> +	aw_sar_bin_opera_t bin_opera_func;=0D
>> +	aw_sar_bin_load_fail_opera_t bin_load_fail_opera_func;=0D
>> +};=0D
>> +=0D
>> +struct aw_awrw_info {=0D
>> +	unsigned char rw_flag;=0D
>> +	unsigned char addr_len;=0D
>> +	unsigned char data_len;=0D
>> +	unsigned char reg_num;=0D
>> +	unsigned int i2c_tranfar_data_len;=0D
>> +	unsigned char *p_i2c_tranfar_data;=0D
>> +};=0D
>> +=0D
>> +typedef void (*sar_enable_clock_t)(void *i2c);=0D
>> +typedef void (*sar_operation_irq_t)(int to_irq);=0D
>> +typedef void (*sar_mode_update_t)(void *i2c);=0D
>> +=0D
>> +struct aw_sar_mode_switch_ops {=0D
>> +	sar_enable_clock_t enable_clock;=0D
>=0D
>Just use the type directly. The typdef doesn't help with readability.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +	sar_rc_irqscr_t rc_irqscr;=0D
>> +	sar_mode_update_t mode_update;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_chip_mode {=0D
>> +	unsigned char curr_mode;=0D
>> +	unsigned char last_mode;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_mode_set_t {=0D
>> +	unsigned char chip_id;=0D
>> +	struct aw_sar_chip_mode chip_mode;=0D
>> +	struct aw_sar_mode_switch_ops mode_switch_ops;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_mode_t {=0D
>> +	const struct aw_sar_mode_set_t *mode_set_arr;=0D
>> +	unsigned char mode_set_arr_len;=0D
>> +	ssize_t (*p_set_mode_node_fn)(void *data, unsigned char curr_mode);=0D
>> +	ssize_t (*p_get_mode_node_fn)(void *data, char *buf);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_init_over_irq_t {=0D
>> +	short wait_times;=0D
>> +	unsigned char daley_step;=0D
>> +	unsigned int reg_irqsrc;=0D
>> +	unsigned int irq_offset_bit;=0D
>> +	unsigned int irq_mask;=0D
>> +	unsigned int irq_flag;=0D
>> +	/*=0D
>> +	 * Perform different verification initialization=0D
>> +	 * to complete the interrupt operation=0D
>> +	 */=0D
>> +	int (*p_check_init_over_irq_fn)(void *data);=0D
>> +	/*=0D
>> +	 * When initialization fails, get the corresponding error type and=0D
>> +	 * apply it to the chip with flash=0D
>> +	 */=0D
>> +	int (*p_get_err_type_fn)(void *data);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_soft_rst_t {=0D
>> +	unsigned short reg_rst;=0D
>> +	unsigned int reg_rst_val;=0D
>> +	unsigned int delay_ms;=0D
>> +	/* Perform different soft reset operations */=0D
>> +	int (*p_soft_reset_fn)(void *data);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_aot_t {=0D
>> +	unsigned int aot_reg;=0D
>> +	unsigned int aot_mask;=0D
>> +	unsigned int aot_flag;=0D
>> +	ssize_t (*p_set_aot_node_fn)(void *data);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_diff_t {=0D
>> +	unsigned short diff0_reg;=0D
>> +	unsigned short diff_step;=0D
>> +	/* Data format:S21.10, Floating point types generally need to be remov=
ed */=0D
>> +	unsigned int rm_float;=0D
>> +	ssize_t (*p_get_diff_node_fn)(void *data, char *buf);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_offset_t {=0D
>> +	ssize_t (*p_get_offset_node_fn)(void *data, char *buf);=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_pinctrl {=0D
>> +	struct pinctrl *pinctrl;=0D
>> +	struct pinctrl_state *default_sta;=0D
>> +	struct pinctrl_state *int_out_high;=0D
>> +	struct pinctrl_state *int_out_low;=0D
>> +};=0D
>> +=0D
>> +/* update reg node */=0D
>> +struct aw_sar_para_load_t {=0D
>> +	const unsigned int *reg_arr;=0D
>> +	unsigned int reg_arr_len;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_platform_config {=0D
>> +	/* The chip needs to parse more DTS contents for addition */=0D
>> +	int (*p_add_parse_dts_fn)(void *data);=0D
>> +=0D
>> +	const struct aw_sar_regulator_config_t *p_regulator_config;=0D
>> +=0D
>> +	/* The chip needs to add more nodes */=0D
>> +	int (*p_add_node_create_fn)(void *data);=0D
>> +	/* Release the added node */=0D
>> +	int (*p_add_node_free_fn)(void *data);=0D
>> +=0D
>> +	/* Use a different initialization interrupt to initialize the operatio=
n */=0D
>> +	int (*p_input_init_fn)(void *data);=0D
>> +	/* Release input resource */=0D
>> +	int (*p_input_deinit_fn)(void *data);=0D
>> +=0D
>> +	/* The parameters passed in are required for interrupt initialization =
*/=0D
>> +	const struct aw_sar_irq_init_t *p_irq_init;=0D
>> +=0D
>> +	/* The chip is set to different modes in different power management in=
terfaces */=0D
>> +	const struct aw_sar_pm_t *p_pm_chip_mode;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar_power_on_prox_detection_t {=0D
>> +	/* en_flag is true enable */=0D
>> +	void (*p_power_on_prox_detection_en_fn)(void *data, unsigned char en_f=
lag);=0D
>> +	unsigned int irq_en_cali_bit;=0D
>> +	unsigned char power_on_prox_en_flag;=0D
>> +};=0D
>> +=0D
>> +/**=0D
>> + * struct aw_sar_chip_config -=0D
>A lot of this is not 'config' as such. It's per chip type constant data.=0D
>As such better to name it to reflect that. chip_info is typical choice.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> + * @ch_num_max:	Number of channels of the chip=0D
>> + * @p_platform_config:	Chip related platform content configuration=0D
>> + * @p_check_chipid:	Parameters required for verification of chipid=0D
>> + * @p_soft_rst:	Parameters required for soft reset=0D
>> + * @p_init_over_irq:	Verify the parameters required to initialize a com=
plete interrupt=0D
>> + * @p_reg_bin:	Parameters required for load register bin file=0D
>> + * @p_chip_mode:	The mode set before and after the initialization of th=
e chip=0D
>> + * @p_reg_list:	Register permission table=0D
>> + * @p_reg_arr:	Default register table=0D
>> + * @p_aot:	Parameters required for set Auto-Offset-Tuning(aot)=0D
>> + * @p_diff:	Parameters required for get chip diff val=0D
>> + * @p_offset:	Parameters required for get chip offset val=0D
>> + * @p_mode:	Set the parameters of different working modes of the chip=0D
>> + * @p_get_chip_info:	Obtain the necessary information of the chip=0D
>> + * @p_aw_sar_awrw:	Continuous read/write register interface=0D
>> + * @p_other_operation:	Other operations during initialization, Add acco=
rding to different usage=0D
>> + * @p_other_opera_free:	If requested by resources, please release=0D
>> + */=0D
>> +struct aw_sar_chip_config {=0D
>> +	unsigned char ch_num_max;=0D
>> +	const struct aw_sar_platform_config *p_platform_config;=0D
>> +	const struct aw_sar_check_chipid_t *p_check_chipid;=0D
>> +	const struct aw_sar_soft_rst_t *p_soft_rst;=0D
>don't do the _t thing. It's obviously a type because it's a struct.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>> +	const struct aw_sar_init_over_irq_t *p_init_over_irq;=0D
>> +	const struct aw_sar_load_bin_t *p_reg_bin;=0D
>> +	const struct aw_sar_chip_mode_t *p_chip_mode;=0D
>> +	const struct aw_sar_reg_list_t *p_reg_list;=0D
>> +	const struct aw_sar_para_load_t *p_reg_arr;=0D
>> +	const struct aw_sar_aot_t *p_aot;=0D
>> +	const struct aw_sar_diff_t *p_diff;=0D
>> +	const struct aw_sar_offset_t *p_offset;=0D
>> +	const struct aw_sar_mode_t *p_mode;=0D
>> +	const struct aw_sar_get_chip_info_t *p_get_chip_info;=0D
>> +	const struct aw_sar_awrw_t *p_aw_sar_awrw;=0D
>> +	aw_sar_chip_other_operation_t p_other_operation;=0D
>> +	aw_sar_chip_other_opera_free_t p_other_opera_free;=0D
>> +	const struct aw_sar_power_on_prox_detection_t *power_on_prox_detection=
;=0D
>> +};=0D
>> +=0D
>> +struct aw_sar {=0D
>> +	struct i2c_client *i2c;=0D
>> +	struct device *dev;=0D
>> +	struct regulator *vcc;=0D
>> +	struct delayed_work update_work;=0D
>> +	/* Set pin pull-up mode */=0D
>> +	struct aw_sar_pinctrl pinctrl;=0D
>> +	/* eds work */=0D
>> +	struct delayed_work monitor_work;=0D
>> +	struct workqueue_struct *monitor_wq;=0D
>> +	struct iio_dev *aw_iio_dev;=0D
>> +=0D
>> +	unsigned char chip_type;=0D
>> +	unsigned char chip_name[20];=0D
>> +=0D
>> +	bool power_enable;=0D
>> +	bool fw_fail_flag;=0D
>> +	unsigned char last_mode;=0D
>> +=0D
>> +	/* handler_anomalies */=0D
>> +	unsigned char fault_flag;=0D
>> +	unsigned char driver_code_initover_flag;=0D
>> +	/* handler_anomalies */=0D
>> +=0D
>> +	unsigned char ret_val;=0D
>> +	unsigned char curr_use_driver_type;=0D
>> +	int prot_update_state;=0D
>> +=0D
>> +	unsigned char aot_irq_num;=0D
>> +	unsigned char enter_irq_handle_num;=0D
>> +	unsigned char exit_power_on_prox_detection;=0D
>> +=0D
>> +	struct work_struct ps_notify_work;=0D
>> +	struct notifier_block ps_notif;=0D
>> +	bool ps_is_present;=0D
>> +=0D
>> +	/* Parameters related to platform logic */=0D
>> +	struct aw_sar_dts_info dts_info;=0D
>> +	struct aw_sar_load_bin_comm_t load_bin;=0D
>> +	struct aw_sar_irq_init_comm_t irq_init;=0D
>> +	struct aw_awrw_info awrw_info;=0D
>> +	struct aw_channels_info *channels_arr;=0D
>> +=0D
>> +	/* Private arguments required for public functions */=0D
>> +	const struct aw_sar_chip_config *p_sar_para;=0D
>> +	/* Private arguments required for private functions */=0D
>> +	void *priv_data;=0D
>> +};=0D
>> +=0D
>> +/* Determine whether the chip exists by verifying chipid */=0D
>> +typedef int (*aw_sar_who_am_i_t)(void *data);=0D
>> +typedef int (*aw_sar_chip_init_t)(struct aw_sar *p_sar);=0D
>> +typedef void (*aw_sar_chip_deinit_t)(struct aw_sar *p_sar);=0D
>=0D
>Just use these inline.  They don't help readability enough to=0D
>be worth typdefs.=0D
>=0D
=0D
The v4 version patch will delete related code.=0D
=0D
>=0D
>> +=0D
>> +struct aw_sar_driver_type {=0D
>=0D
>Used in one place. Push it down into that file.=0D
>> +	unsigned char driver_type;=0D
>> +	aw_sar_who_am_i_t p_who_am_i;=0D
>> +	aw_sar_chip_init_t p_chip_init;=0D
>> +	aw_sar_chip_deinit_t p_chip_deinit;=0D
>> +};=0D
>> +=0D
>> +#endif=0D
=0D
Kind regards,=0D
Wang Shuaijie=

