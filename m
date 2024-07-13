Return-Path: <linux-iio+bounces-7599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F119305EC
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DA3B21A13
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 14:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4413A271;
	Sat, 13 Jul 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGHuM3kr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D861139D16;
	Sat, 13 Jul 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720880829; cv=none; b=UqVEZ8uzN9kFrcoWQ6Dj+55CmB4mZstPdY4DP/Kx7sSf1oISK1BW9n99XoRN9F30v1aRIq9+q5nS81+HR7oLFPQ0pergkCQQ1H1MKZyU4S6Ei5LkCaH3YyG7cXQzKlcX1g6B4zrJzViltWOYREsAhWzO2b7+jvGbjNxYoR2YqH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720880829; c=relaxed/simple;
	bh=T2qaGux5CQcmVVQ4YRj0tp3wh2nVyEFkVeBt1wIeV1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzbPOmmNBeK9zVF1zOKsFRbXeDVYsZIInfLqlgU9lHHalzS+ER0e7UwMQzH+4inPOHJD91gC+gy+zS3GxyItGudEIKO4FdAHRzWDjeBYR5OpUm3oXda5D6xKtEouwNZCNTER/mZwBa5Qflw0Xou2xqUky3YR6/bMSwl6cTMbOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGHuM3kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3148AC32781;
	Sat, 13 Jul 2024 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720880829;
	bh=T2qaGux5CQcmVVQ4YRj0tp3wh2nVyEFkVeBt1wIeV1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KGHuM3krdgZVMe9qV0j6IXBBHKQH4yPSahHyL3kzaIK1cTk5r7fiyxO86mxNPYp1e
	 qGCMrHYeXdGVnekEfzj4DoD0AwUVGi97T9NGpA4wl05dbR3kPNm3ZE4zPaGOfaEwtJ
	 nUkaCexDzJJisqmrezg900/V3LcoewamIGFg1vNmtszP7+ytFRXHa3D1IkY6vBo/7E
	 JUTQGEeuJmwLY3LwYdH7ih+jeKTZdFxtmg0S+ABJrzBVJ8kxgm/blKaMDpJYTHZukt
	 tCGgbNGX8Z68HWB/nxaXbdgp0p0sFA//Rv8vuIFas+TIVbD9YLaUoYVdCv3YBLkLC1
	 ADRmogGQc6tTA==
Date: Sat, 13 Jul 2024 15:27:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, waqar.hameed@axis.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V3 2/2] Add support for Awinic proximity sensor
Message-ID: <20240713152700.3c395608@jic23-huawei>
In-Reply-To: <20240712113200.2468249-3-wangshuaijie@awinic.com>
References: <20240712113200.2468249-1-wangshuaijie@awinic.com>
	<20240712113200.2468249-3-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 11:32:00 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> 1. Modify the structure of the driver.
> 2. Change the style of the driver's comments.
> 3. Remove unnecessary log printing.
> 4. Modify the function used for memory allocation.
> 5. Modify the driver registration process.
> 6. Remove the functionality related to updating firmware.
> 7. Change the input subsystem in the driver to the iio subsystem.
> 8. Modify the usage of the interrupt pin.
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>

As others have observed this is a change log not a patch description so belongs
below the ---
Also, should be a patch description.

The patch is very large and hard to review as a result.
Break it up in to parts.  Common infrastructure, then add support
for one part then for the next one etc.  Given size of this, I'd start
with a submission supporting only one part.  Don't abstract anything that
isn't needed for that part initially.  That abstraction should occur
in a separate series that adds the parts where things differ etc.

That way we get bite sized parts to review.  I'll take a quick look but given current status
this probably won't be a thorough review.

Superficial feedback is this seems like a very complex driver for a not
very complex of devices. Please look to drop any flexibility in the driver
that isn't used etc. 

Anyhow, I'm out of time, so the feedback is patch at best and I've not cropped
the reply down.

For next version aim for no patch > 1000 lines and typically much smaller than
that and ask us to review a subset of what you have here.  Build it up in several
goes.  The feedback on that first subset will help you fix up later ones to be
closer to what we are looking at.

Jonathan


> ---
>  drivers/iio/proximity/Kconfig                 |   10 +
>  drivers/iio/proximity/Makefile                |    2 +
>  drivers/iio/proximity/aw9610x.c               | 1150 ++++++++++
>  drivers/iio/proximity/aw963xx.c               | 1371 ++++++++++++
>  drivers/iio/proximity/aw_sar.c                | 1850 +++++++++++++++++
>  drivers/iio/proximity/aw_sar.h                |   23 +
>  drivers/iio/proximity/aw_sar_comm_interface.c |  550 +++++
>  drivers/iio/proximity/aw_sar_comm_interface.h |  172 ++
>  drivers/iio/proximity/aw_sar_type.h           |  371 ++++
>  9 files changed, 5499 insertions(+)
>  create mode 100644 drivers/iio/proximity/aw9610x.c
>  create mode 100644 drivers/iio/proximity/aw963xx.c
>  create mode 100644 drivers/iio/proximity/aw_sar.c
>  create mode 100644 drivers/iio/proximity/aw_sar.h
>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.c
>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.h
>  create mode 100644 drivers/iio/proximity/aw_sar_type.h
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index 2ca3b0bc5eba..a60d3dc955b3 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -219,4 +219,14 @@ config VL53L0X_I2C
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called vl53l0x-i2c.
>  
> +config AWINIC_SAR
> +	tristate "Awinic AW96XXX proximity sensor"
> +	depends on I2C
> +	help
> +	  Say Y here to build a driver for Awinic's AW96XXX capacitive
> +	  proximity sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called awinic_sar.
> +
>  endmenu
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index f36598380446..d4bd9edd8362 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -21,4 +21,6 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> +obj-$(CONFIG_AWINIC_SAR)	+= awinic_sar.o
> +awinic_sar-objs			:= aw_sar_comm_interface.o aw_sar.o aw9610x.o aw963xx.o
>  
> diff --git a/drivers/iio/proximity/aw9610x.c b/drivers/iio/proximity/aw9610x.c
> new file mode 100644
> index 000000000000..15e53d55d2a1
> --- /dev/null
> +++ b/drivers/iio/proximity/aw9610x.c
> @@ -0,0 +1,1150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AWINIC sar sensor driver (aw9610x)
> + *
> + * Author: Shuaijie Wang<wangshuaijie@awinic.com>
> + *
> + * Copyright (c) 2024 awinic Technology CO., LTD
> + */
> +#include "aw_sar.h"
> +
> +#define AW9610X_I2C_NAME "aw9610x_sar"
> +#define AW9610X_CHANNEL_MAX	(5)

No brackets around numeric values. They add nothing.

> +
> +#define AFE_BASE_ADDR					(0x0000)


> +
> +enum aw9610x_sar_vers {
> +	AW9610X = 2,
> +	AW9610XA = 6,
> +	AW9610XB = 0xa,
> +};
> +
> +enum aw9610x_operation_mode {
> +	AW9610X_ACTIVE_MODE = 1,
> +	AW9610X_SLEEP_MODE,
> +	AW9610X_DEEPSLEEP_MODE,
> +	AW9610XB_DEEPSLEEP_MODE,
> +};
> +
> +enum aw9610x_spereg_addr_offset {
> +	AW_CL1SPE_CALI_OS = 20,
> +	AW_CL1SPE_DEAL_OS = 60,
> +	AW_CL2SPE_CALI_OS = 4,
> +	AW_CL2SPE_DEAL_OS = 4,
> +};
> +
> +enum aw9610x_function_flag {
> +	AW9610X_FUNC_OFF,
> +	AW9610X_FUNC_ON,
> +};
> +
> +enum aw9610x_irq_trigger_position {
> +	AW9610X_FAR,
> +	AW9610X_TRIGGER_TH0,
> +	AW9610X_TRIGGER_TH1 = 0x03,
> +	AW9610X_TRIGGER_TH2 = 0x07,
> +	AW9610X_TRIGGER_TH3 = 0x0f,
> +};
> +
> +struct aw_i2c_package {
> +	unsigned char addr_bytes;
> +	unsigned char data_bytes;
> +	unsigned char reg_num;
> +	unsigned char init_addr[4];
> +	unsigned char *p_reg_data;
> +};
> +
> +struct aw9610x {
> +	unsigned char vers;
> +	unsigned char channel;
> +	unsigned int irq_status;
> +	unsigned char chip_name[9];
> +	unsigned char chip_type[9];
> +	bool satu_release;
> +	struct aw_i2c_package aw_i2c_package;
> +	unsigned char satu_flag[6];
> +	unsigned int satu_data[6];
> +	unsigned int last_blfilta[AW9610X_CHANNEL_MAX];
> +	unsigned int last_irq_en;
> +};
> +
> +struct aw_reg_data {
> +	unsigned char rw;
> +	unsigned short reg;

> +};
> +#define REG_NONE_ACCESS					(0)
> +#define REG_RD_ACCESS					(1 << 0)
> +#define REG_WR_ACCESS					(1 << 1)
> +

> +
> +static struct aw_sar *g_aw_sar;
> +
> +static int aw9610x_baseline_filter(struct aw_sar *p_sar)
> +{
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	unsigned int status0;
> +	unsigned int status1;

u32 for 32 bit register to make it explicit that they are 32 bits.

> +	unsigned char i;
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_STAT1, &status1);
Check return value of all reads.

> +	aw_sar_i2c_read(p_sar->i2c, REG_STAT0, &status0);
> +
> +	for (i = 0; i < AW9610X_CHANNEL_MAX; i++) {
> +		if (((status1 >> i) & 0x01) == 1) {
> +			if (aw9610x->satu_flag[i] == 0) {
> +				aw_sar_i2c_read(p_sar->i2c, REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS,
> +						&aw9610x->satu_data[i]);
> +				aw_sar_i2c_write(p_sar->i2c, REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS,
> +						((aw9610x->satu_data[i] | 0x1fc) & 0x3fffffff));

Masks should be associated with defines.  I have no idea what this code
is doing so a comment would be good. It looks to be reading current state
into a satu_data[i] then writing back something different but not updating
local state.  That needs some documentation.


> +				aw9610x->satu_flag[i] = 1;
> +			}
> +		} else if (((status1 >> i) & 0x01) == 0) {
Given a bit can only be 0 or 1 and previous branch was for 1.
		} else {

> +			if (aw9610x->satu_flag[i] == 1) {
> +				if (((status0 >> (i + 24)) & 0x01) == 0) {
> +					aw_sar_i2c_write(p_sar->i2c,
> +							REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS,
> +							aw9610x->satu_data[i]);
> +					aw9610x->satu_flag[i] = 0;
> +				}
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void aw9610x_saturat_release_handle(struct aw_sar *p_sar)
> +{
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	unsigned int satu_irq;
> +	unsigned int status0;
> +	unsigned char i;
> +
> +	satu_irq = (aw9610x->irq_status >> 7) & 0x01;
> +	if (satu_irq == 1) {
> +		aw9610x_baseline_filter(p_sar);
> +	} else {
> +		aw_sar_i2c_read(p_sar->i2c, REG_STAT0, &status0);
> +		for (i = 0; i < AW9610X_CHANNEL_MAX; i++) {
> +			if (aw9610x->satu_flag[i] == 1) {

If it's a flag, make it boolean.

> +				if (((status0 >> (i + 24)) & 0x01) == 0) {
> +					aw_sar_i2c_write(p_sar->i2c,
> +							REG_BLFILT_CH0 + i * AW_CL1SPE_DEAL_OS,
> +							aw9610x->satu_data[i]);
> +					aw9610x->satu_flag[i] = 0;
> +				}
> +			}
> +		}
> +	}
> +}
> +
> +static void aw9610x_irq_handle(struct aw_sar *p_sar)
> +{
> +	unsigned int curr_status_val;
> +	unsigned int curr_status;
> +	unsigned char i;
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_STAT0, &curr_status_val);
> +	if (!p_sar->channels_arr) {
> +		dev_err(p_sar->dev, "p_sar->channels_arr err!!!");
> +		return;
> +	}
> +
> +	for (i = 0; i < AW9610X_CHANNEL_MAX; i++) {
> +		curr_status =
> +			(((unsigned char)(curr_status_val >> (24 + i)) & 0x1))
WHy is the cast needed?
> +#ifdef AW_INPUT_TRIGGER_TH1

No ifdefs like this should be seen in a submitted driver.

> +			| (((unsigned char)(curr_status_val >> (16 + i)) & 0x1) << 1)
> +#endif
> +#ifdef AW_INPUT_TRIGGER_TH2
> +			| (((unsigned char)(curr_status_val >> (8 + i)) & 0x1) << 2)
> +#endif
> +#ifdef AW_INPUT_TRIGGER_TH3
> +			| (((unsigned char)(curr_status_val >> (i)) & 0x1) << 3)
> +#endif
> +			;
> +
> +		if (p_sar->channels_arr[i].used == AW_FALSE)

Use a boolean and don't invent your own idea of true adn flase.


> +			continue;
> +
> +		if (p_sar->channels_arr[i].last_channel_info == curr_status)
> +			continue;
> +
> +		switch (curr_status) {
> +		case AW9610X_FAR:
> +			iio_push_event(p_sar->aw_iio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +						IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> +					iio_get_time_ns(p_sar->aw_iio_dev));
> +			break;
> +		case AW9610X_TRIGGER_TH0:
> +#ifdef AW_INPUT_TRIGGER_TH1
> +		case AW9610X_TRIGGER_TH1:
> +#endif
> +#ifdef AW_INPUT_TRIGGER_TH2
> +		case AW9610X_TRIGGER_TH2:
> +#endif
> +#ifdef AW_INPUT_TRIGGER_TH3
> +		case AW9610X_TRIGGER_TH3:
> +#endif
> +			iio_push_event(p_sar->aw_iio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +						IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
> +					iio_get_time_ns(p_sar->aw_iio_dev));
> +			break;
> +		default:
> +			dev_err(p_sar->dev, "error abs distance");
> +			return;
> +		}
> +		p_sar->channels_arr[i].last_channel_info = curr_status;
> +	}
> +}
> +
> +static void aw9610x_version_aw9610x_private(struct aw_sar *p_sar)

For an unusual bit of code like this, add a comment on what is goig on.

> +{
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +
> +	if (aw9610x->satu_release == AW9610X_FUNC_ON)
> +		aw9610x_saturat_release_handle(p_sar);
> +}
> +
> +static void aw9610x_irq_handle_func(unsigned int irq_status, void *data)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +
> +	switch (aw9610x->vers) {
> +	case AW9610X:
> +		aw9610x_version_aw9610x_private(p_sar);
> +		break;
> +	case AW9610XA:
If it's the same as default, rely on default.

> +		break;
> +	default:
> +		break;
> +	}
> +
> +	aw9610x_irq_handle(p_sar);
> +}
> +
> +int aw9610x_check_chipid(void *data)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	if (!p_sar)
> +		return -EINVAL;
> +
> +	ret = aw_sar_i2c_read(p_sar->i2c, REG_CHIPID, &reg_val);
> +	if (ret < 0) {
> +		dev_err(p_sar->dev, "read CHIP ID failed: %d", ret);
> +		return ret;
> +	}
> +	reg_val = reg_val >> 16;

FIELD_GET() with appropriately defined mask.

> +
> +	if (reg_val != AW9610X_CHIP_ID) {
> +		dev_err(p_sar->dev, "unsupport dev, chipid is (0x%04x)", reg_val);


To allow use of fallback compatibles in DT we normally accept chipid missmatches.
So at most dev_info and carry on anyway.

> +		return -EINVAL;
> +	}
> +	memcpy(p_sar->chip_name, "AW9610X", 8);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(aw9610x_check_chipid, AWINIC_PROX);
> +
> +static const struct aw_sar_check_chipid_t g_aw9610x_check_chipid = {
> +	.p_check_chipid_fn = aw9610x_check_chipid,
> +};
> +
> +static ssize_t aw9610x_operation_mode_get(void *data, char *buf)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	ssize_t len = 0;
> +
> +	if (p_sar->last_mode == AW9610X_ACTIVE_MODE)
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: Active\n");	
		return snprintf()

	if ()
		return sprintf;
etc

However this sort of custom ABI needs docs in Documenation/ABI/testing/sysfs-bus-iio*
and we are reluctant to accept it because it's the sort of thing userspace has no idea
how to use. These sleep / deepsleep are marketing terms.  Much better the driver uses
runtime_pm or similar to work out what state it should be in dependent on how it is
being used etc.

> +	else if (p_sar->last_mode == AW9610X_SLEEP_MODE)
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: Sleep\n");
> +	else if ((p_sar->last_mode == AW9610X_DEEPSLEEP_MODE) && (aw9610x->vers == AW9610XA))
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: DeepSleep\n");
> +	else
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: Unconfirmed\n");
> +
> +	return len;
> +}
> +
> +static void aw9610x_chip_info_get(void *data, char *buf, ssize_t *p_len)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	unsigned int reg_data;
> +
I can't actually work out where this ends up, but as a general rule formatted data
doesn't make sense. If this needs to be exposed. One value per file si the way
to go - not a block of text.

> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len,
> +			"sar%u\n", p_sar->dts_info.sar_num);
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len, "The driver supports UI\n");
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_CHIPID, &reg_data);
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len, "chipid is 0x%08x\n", reg_data);
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_IRQEN, &reg_data);
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len, "REG_HOSTIRQEN is 0x%08x\n", reg_data);
> +
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len,
> +			"chip_name:%s bin_prase_chip_name:%s\n",
> +			aw9610x->chip_name, aw9610x->chip_type);
> +}
> +
> +static const struct aw_sar_get_chip_info_t g_aw9610x_get_chip_info = {
> +	.p_get_chip_info_node_fn = aw9610x_chip_info_get,
> +};
> +
> +static void aw9610x_reg_version_comp(struct aw_sar *p_sar, struct aw_bin *aw_bin)
> +{
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	unsigned int blfilt1_data;
> +	unsigned int blfilt1_tmp;
> +	unsigned char i;
> +
> +	if ((aw9610x->chip_name[7] == 'A') &&

If there is somthing that is chip specific encode it properly as a
field in the chip specific structure, not based on chip_name.

> +		(aw_bin->header_info[0].chip_type[7] == '\0')) {
> +		for (i = 0; i < 6; i++) {
> +			aw_sar_i2c_read(p_sar->i2c, REG_BLFILT_CH0 + (0x3c * i), &blfilt1_data);
> +			blfilt1_tmp = (blfilt1_data >> 25) & 0x1;
FIELD_GET() and appropriately defined mask.

> +			if (blfilt1_tmp == 1)
> +				aw_sar_i2c_write_bits(p_sar->i2c, REG_BLRSTRNG_CH0 + (0x3c * i),
> +						~(0x3f), 1 << i);
> +		}
> +	}
> +}
> +
> +static int aw9610x_load_reg_bin(struct aw_bin *aw_bin, void *load_bin_para)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)load_bin_para;
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	int ret;
> +
> +	snprintf(aw9610x->chip_type, sizeof(aw9610x->chip_type), "%s",
> +			aw_bin->header_info[0].chip_type);
> +	ret = strncmp(aw9610x->chip_name, aw_bin->header_info[0].chip_type,
> +			sizeof(aw_bin->header_info[0].chip_type));
> +	if (ret != 0)
> +		dev_err(p_sar->dev, "load_binname(%s) incompatible with chip type(%s)",
> +			p_sar->chip_name, aw_bin->header_info[0].chip_type);
Why carry on? It failed, return the error without the next bit.

> +
> +	p_sar->load_bin.bin_data_ver = aw_bin->header_info[0].bin_data_ver;
> +
> +	ret = aw_sar_load_reg(aw_bin, p_sar->i2c);
> +	aw9610x_reg_version_comp(p_sar, aw_bin);
> +
> +	return ret;
> +}
> +
> +static ssize_t aw9610x_get_self_cap_offset(void *data, char *buf)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	unsigned char temp_data[20] = { 0 };
> +	unsigned int coff_data_int;
> +	unsigned int coff_data_dec;
> +	unsigned int coff_data;
> +	unsigned int reg_val;
> +	ssize_t len = 0;
> +	unsigned char i;
> +
> +	for (i = 0; i < AW9610X_CHANNEL_MAX; i++) {
> +		aw_sar_i2c_read(p_sar->i2c,
> +			REG_AFECFG1_CH0 + i * AW_CL1SPE_CALI_OS, &reg_val);
> +		coff_data = (reg_val >> 24) * 900 + ((reg_val >> 16) & 0xff) * 13;
> +		coff_data_int = coff_data / 1000;
> +		coff_data_dec = coff_data % 1000;
> +		snprintf(temp_data, sizeof(temp_data), "%u.%u", coff_data_int, coff_data_dec);
> +		len += snprintf(buf+len, PAGE_SIZE-len, "PARASITIC_DATA_CH%d = %s pf\n",
> +				i, temp_data);
> +	}
> +
> +	return len;
> +}
> +
> +static const struct aw_sar_offset_t g_aw9610x_offset = {
> +	.p_get_offset_node_fn = aw9610x_get_self_cap_offset,
> +};
>
> +
> +static void aw9610x_datablock_load(struct aw_sar *p_sar, const char *buf)
> +{
> +	struct aw9610x *aw9610x = p_sar->priv_data;
> +	unsigned char addr_bytes = aw9610x->aw_i2c_package.addr_bytes;
> +	unsigned char data_bytes = aw9610x->aw_i2c_package.data_bytes;
> +	unsigned char reg_num = aw9610x->aw_i2c_package.reg_num;
> +	unsigned char reg_data[220] = { 0 };
> +	unsigned int databuf[220] = { 0 };
Too big for the stack.

> +	unsigned char temp_buf[2] = { 0 };
> +	unsigned int i;
> +
> +	for (i = 0; i < data_bytes * reg_num; i++) {
> +		if (reg_num < attr_buf[1]) {
> +			temp_buf[0] = buf[attr_buf[0] + (addr_bytes + i) * 5];
> +			temp_buf[1] =
> +				buf[attr_buf[0] + (addr_bytes + i) * 5 + 1];
> +		} else if (reg_num >= attr_buf[1] && reg_num < attr_buf[3]) {
> +			temp_buf[0] = buf[attr_buf[2] + (addr_bytes + i) * 5];
> +			temp_buf[1] =
> +				buf[attr_buf[2] + (addr_bytes + i) * 5 + 1];
> +		} else if (reg_num >= attr_buf[3] && reg_num < attr_buf[5]) {
> +			temp_buf[0] = buf[attr_buf[4] + (addr_bytes + i) * 5];
> +			temp_buf[1] =
> +				buf[attr_buf[4] + (addr_bytes + i) * 5 + 1];
> +		}
> +		sscanf(temp_buf, "%02x", &databuf[i]);
> +		reg_data[i] = (unsigned char)databuf[i];
> +	}
> +	aw9610x->aw_i2c_package.p_reg_data = reg_data;
> +	aw9610x_awrw_write_seq(p_sar);
> +}
> +
> +static int aw9610x_awrw_read_seq(struct aw_sar *p_sar, unsigned char *reg_data)
> +{
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	unsigned char data_bytes = aw9610x->aw_i2c_package.data_bytes;
> +	unsigned char addr_bytes = aw9610x->aw_i2c_package.addr_bytes;
> +	unsigned char reg_num = aw9610x->aw_i2c_package.reg_num;
> +	unsigned short msg_cnt = (unsigned short)(data_bytes * reg_num);
> +	unsigned char w_buf[4];
> +	unsigned char buf[228];
> +	unsigned int msg_idx;
> +	int ret;
> +
> +	for (msg_idx = 0; msg_idx < addr_bytes; msg_idx++)
> +		w_buf[msg_idx] = aw9610x->aw_i2c_package.init_addr[msg_idx];
> +
> +	ret = aw_sar_i2c_read_seq(p_sar->i2c, w_buf, 2, (unsigned char *)buf, msg_cnt);

If there was an error, don't update the data passed out of here as it's
garbage.

> +
> +	for (msg_idx = 0; msg_idx < msg_cnt; msg_idx++)
> +		reg_data[msg_idx] = buf[msg_idx];
> +
> +	return ret;
> +}

> +
> +static void aw9610x_power_on_prox_detection(void *data, unsigned char en_flag)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	struct aw9610x *aw9610x = (struct aw9610x *)p_sar->priv_data;
> +	unsigned char ch;
> +
> +	if (en_flag == true) {

if (en_flag) {

> +		for (ch = 0; ch < AW9610X_CHANNEL_MAX; ch++) {
> +			aw_sar_i2c_read(p_sar->i2c,
> +				REG_BLFILT_CH0 + (REG_BLFILT_CH1 - REG_BLFILT_CH0) * ch,
> +				&(aw9610x->last_blfilta[ch]));
> +			aw_sar_i2c_write_bits(p_sar->i2c,
> +				REG_BLFILT_CH0 + (REG_BLFILT_CH1 - REG_BLFILT_CH0) * ch,
> +				~(0x3f << 13), (1 << 13));
> +		}
> +		aw_sar_i2c_read(p_sar->i2c, REG_IRQEN, &aw9610x->last_irq_en);
> +		aw_sar_i2c_write_bits(p_sar->i2c, REG_IRQEN, ~(1 << 3), 1 << 3);
> +	} else if (en_flag == false) {

} else {

> +		for (ch = 0; ch < AW9610X_CHANNEL_MAX; ch++) {
> +			aw_sar_i2c_write(p_sar->i2c,
> +				REG_BLFILT_CH0 + (REG_BLFILT_CH1 - REG_BLFILT_CH0) * ch,
> +				aw9610x->last_blfilta[ch]);
> +		}
> +		aw_sar_i2c_write(p_sar->i2c, REG_IRQEN, aw9610x->last_irq_en);
> +	}
> +}
> +
> +static const struct aw_sar_power_on_prox_detection_t g_aw9610x_power_on_prox_detection = {
> +	.p_power_on_prox_detection_en_fn = aw9610x_power_on_prox_detection,
> +	.irq_en_cali_bit = 3,
> +	.power_on_prox_en_flag = true,
> +};

Why not embed this structure directly in aw_sar_chip_info?
Seems like a number of the other structures would also be better handled that way

> +
> +static const struct aw_sar_chip_config g_aw9610x_chip_config = {
> +	.ch_num_max = AW9610X_CHANNEL_MAX,
> +
> +	.p_platform_config = &g_aw9610x_platform_config,
> +
> +	.p_check_chipid = &g_aw9610x_check_chipid,
> +	.p_soft_rst = &g_aw9610x_soft_rst,
> +	.p_init_over_irq = &g_aw9610x_init_over_irq,
> +	.p_reg_bin = &g_aw9610x_load_reg_bin,
> +	.p_chip_mode = &g_aw9610x_chip_mode,
> +
> +	/* Node usage parameters */
> +	.p_reg_list = &g_aw9610x_reg_list,
> +	.p_reg_arr = &g_aw9610x_reg_arr_para,
> +	.p_aot = &g_aw9610x_aot,
> +	.p_diff = &g_aw9610x_diff,
> +	.p_offset = &g_aw9610x_offset,
> +	.p_mode = &g_aw9610x_mode,
> +	.p_get_chip_info = &g_aw9610x_get_chip_info,
> +	.p_aw_sar_awrw = &g_aw9610x_awrw,
> +
> +	.p_other_operation = aw9610x_get_chip_version,
> +	.p_other_opera_free = NULL,
> +	.power_on_prox_detection = &g_aw9610x_power_on_prox_detection,
> +};
> +
> +int aw9610x_init(struct aw_sar *p_sar)
> +{
> +	if (!p_sar)
> +		return -EINVAL;
> +
> +	g_aw_sar = p_sar;
> +
> +	p_sar->priv_data = devm_kzalloc(p_sar->dev, sizeof(struct aw9610x), GFP_KERNEL);
> +	if (!p_sar->priv_data)
> +		return -ENOMEM;
> +
> +	/* Chip private function operation */
> +	p_sar->p_sar_para = &g_aw9610x_chip_config;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(aw9610x_init, AWINIC_PROX);
> +
> +void aw9610x_deinit(struct aw_sar *p_sar)
> +{
> +	if (p_sar->priv_data != NULL)
> +		devm_kfree(p_sar->dev, p_sar->priv_data);

I haven't checked but dev_kfree() calls that aren't clearly an error path cleanup
are almost always a bug..  The whole point is that they happen automatically and
you don't need to call them.

> +}
> +EXPORT_SYMBOL_NS_GPL(aw9610x_deinit, AWINIC_PROX);
> +
> diff --git a/drivers/iio/proximity/aw963xx.c b/drivers/iio/proximity/aw963xx.c
> new file mode 100644
> index 000000000000..c7d4daacef40
> --- /dev/null
> +++ b/drivers/iio/proximity/aw963xx.c
> @@ -0,0 +1,1371 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AWINIC sar sensor driver (aw963xx)
> + *
> + * Author: Shuaijie Wang<wangshuaijie@awinic.com>
> + *
> + * Copyright (c) 2024 awinic Technology CO., LTD
> + */
> +#include "aw_sar.h"
> +
> +#define AW963XX_I2C_NAME "aw963xx_sar"
> +#define AW963XX_CHANNEL_NUM_MAX				(12)
> +#define AW963XX_VALID_TH				(2)
> +#define AW963XX_DATA_PROCESS_FACTOR			(1024)
> +#define AW963XX_SAR_VCC_MIN_UV				(1700000)
> +#define AW963XX_SAR_VCC_MAX_UV				(3600000)
> +#define AW963XX_STEP_LEN_UNSIGNED_CAP_ROUGH_ADJ		(9900)
> +#define AW963XX_STEP_LEN_UNSIGNED_CAP_FINE_ADJ		(152)
> +#define AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE		(10000)
> +#define AW963XX_CPU_OSC_CTRL_MASK			(1)
> +#define ONE_WORD					(0xff)
> +#define AW_BIT8						(8)
> +#define AW_BIT16					(16)
> +#define AW96303						("AW96303")
> +#define AW96305						("AW96305")
> +#define AW96305BFOR					("AW96305BFOR")
> +#define AW96308						("AW96308")
> +#define AW96310						("AW96310")
> +#define AW963XX_FILTCTRL0_CHX_REFAEN			(16)
> +#define AW963XX_FILTCTRL0_CHX_REFASEL			(11)
> +#define AW963XX_FILTCTRL0_CHX_REFBEN			(9)
> +#define AW963XX_FILTCTRL0_CHX_REFBSEL			(4)
> +#define AW963XX_REF_EN					(1)
> +#define REG_SA_RSTNALL					(0xFF0C)
> +#define AW963XX_SOFT_RST_EN				(0)
> +#define AW963XX_CHIP_INIT_MAX_TIME_MS			(30)
> +
> +#define AFE_BASE_ADDR					(0x0000)
> +#define DSP_BASE_ADDR					(0x0000)
> +#define STAT_BASE_ADDR					(0x0000)
> +#define DATA_BASE_ADDR					(0x0000)
> +#define SFR_BASE_ADDR					(0x0000)
> +#define HIDDEN_BASE_ADDR				(0x0000)
> +#define REG_STAT0					((0x0020) + STAT_BASE_ADDR)
> +#define REG_STAT1					((0x0024) + STAT_BASE_ADDR)
> +#define REG_FWVER					((0x005C) + STAT_BASE_ADDR)
> +#define REG_DIFF_CH0					((0x01EC) + DATA_BASE_ADDR)
> +#define REG_DIFF_CH1					((0x0304) + DATA_BASE_ADDR)
> +#define REG_FILTCTRL0_CH0				((0x0130) + DSP_BASE_ADDR)
> +#define REG_FILTCTRL0_CH1				((0x0248) + DSP_BASE_ADDR)
> +#define REG_SCANCTRL1					((0x0004) + AFE_BASE_ADDR)
> +#define REG_AFESOFTCFG0_CH0				((0x010C) + AFE_BASE_ADDR)
> +#define REG_AFECFG1_CH0					((0x0118) + AFE_BASE_ADDR)
> +#define REG_AFECFG3_CH0					((0x0120) + AFE_BASE_ADDR)
> +#define REG_AFESOFTCFG0_CH1				((0x0224) + AFE_BASE_ADDR)
> +#define REG_AFECFG1_CH1					((0x0230) + AFE_BASE_ADDR)
> +#define REG_AFECFG3_CH1					((0x0238) + AFE_BASE_ADDR)
> +#define REG_AFECFG1_M_CH0				((0x10F8) + HIDDEN_BASE_ADDR)
> +#define REG_AFECFG1_M_CH1				((0x1184) + HIDDEN_BASE_ADDR)
> +#define REG_IRQSRC					((0xF080) + SFR_BASE_ADDR)
> +#define REG_IRQEN					((0xF084) + SFR_BASE_ADDR)
> +#define REG_CHIPSTAT					((0xFF00) + SFR_BASE_ADDR)
> +#define REG_CHIP_ID0					((0xFF10) + SFR_BASE_ADDR)
> +#define	REG_CMD						((0xf008) + SFR_BASE_ADDR)
> +#define REG_AFECFG2_CH0					((0x011c) + AFE_BASE_ADDR)
> +#define REG_AFECFG2_CH1					((0x0234) + AFE_BASE_ADDR)
> +
> +enum aw963xx_cap_mode {
> +	AW963XX_UNSIGNED_CAP = 0,
> +	AW963XX_SIGNED_CAP = 4,
> +	AW963XX_MUTUAL_CAP = 5,
> +};
> +
> +enum aw963xx_cs_2_irq {
> +	AW963XX_CS2_IRQ = 2,
> +	AW963XX_CS5_IRQ = 5,
> +};
> +
> +enum aw963xx_operation_mode {
> +	AW963XX_ACTIVE_MODE = 0x01,
> +	AW963XX_SLEEP_MODE = 0x02,
> +	AW963XX_DEEPSLEEP_MODE = 0x03,
> +};
> +
> +enum aw963xx_chip_id {
> +	AW96303_CHIP_ID = 0xA9630340,
> +	AW96305_CHIP_ID = 0xA9630520,
> +	AW96305BFOR_CHIP_ID = 0xA9630500,
> +	AW96308_CHIP_ID = 0xA9630810,
> +	AW96310_CHIP_ID = 0xA9631010,
> +};
> +
> +struct aw963xx {
> +	unsigned int irq_mux;
> +	unsigned int ref_ch_en[AW963XX_CHANNEL_NUM_MAX];
> +	void *p_aw_sar;
> +	unsigned int last_blfilta[AW963XX_CHANNEL_NUM_MAX];
> +	unsigned int last_irq_en;
> +};
> +
> +struct reg_data {
> +	unsigned char rw;
> +	unsigned short reg;
> +};
> +#define REG_NONE_ACCESS					(0)
> +#define REG_RD_ACCESS					(1 << 0)
> +#define REG_WR_ACCESS					(1 << 1)
> +static const struct reg_data g_aw963xx_reg_access[] = {
> +	{ .reg = REG_SCANCTRL1,			.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFESOFTCFG0_CH0,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFECFG1_CH0,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFECFG3_CH0,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFESOFTCFG0_CH1,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFECFG1_CH1,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFECFG3_CH1,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_STAT0,			.rw = REG_RD_ACCESS, },
> +	{ .reg = REG_STAT1,			.rw = REG_RD_ACCESS, },
> +	{ .reg = REG_FWVER,			.rw = REG_RD_ACCESS, },
> +	{ .reg = REG_DIFF_CH0,			.rw = REG_RD_ACCESS, },
> +	{ .reg = REG_DIFF_CH1,			.rw = REG_RD_ACCESS, },
> +	{ .reg = REG_FILTCTRL0_CH0,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_FILTCTRL0_CH1,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFECFG1_M_CH0,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_AFECFG1_M_CH1,		.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_IRQSRC,			.rw = REG_RD_ACCESS, },
> +	{ .reg = REG_IRQEN,			.rw = REG_RD_ACCESS | REG_WR_ACCESS, },
> +	{ .reg = REG_CHIPSTAT,			.rw = REG_RD_ACCESS, },
> +	{ .reg = REG_CHIP_ID0,			.rw = REG_RD_ACCESS, },
> +};
> +
> +static const unsigned int aw963xx_reg_default[] = {
> +	0x0000, 0x000000FF,
> +	0x0004, 0x00000FFF,
> +	0x0008, 0x00000FFF,
> +	0x000C, 0x00000064,
> +	0x0010, 0x0000705F,
> +	0x0014, 0x80000000,
> +	0x0060, 0x00000000,
> +	0x0064, 0x00000000,
> +	0x0068, 0x00000000,
> +	0x006C, 0x00000000,
> +	0x0070, 0x00000000,
> +	0x0074, 0x00000000,
> +	0x0078, 0x00000000,
> +	0x007C, 0x00000000,
> +	0x0080, 0x00000000,
> +	0x0084, 0x00000000,
> +	0x0088, 0x00000000,
> +	0x008C, 0x00000000,
> +	0x0168, 0x00000000,
> +	0x016C, 0x003F0000,
> +	0x0170, 0x00050100,
> +	0x0174, 0x00000000,
> +	0x0178, 0x341C9207,
> +	0x017C, 0x00008000,
> +	0x0180, 0x00000909,
> +	0x0184, 0x00000001,
> +	0x0188, 0x00000000,
> +	0x0318, 0x00000000,
> +	0x031C, 0x003F0000,
> +	0x0320, 0x00050100,
> +	0x0324, 0x00000000,
> +	0x0328, 0x341C9207,
> +	0x032C, 0x00008000,
> +	0x0330, 0x00000909,
> +	0x0334, 0x00000008,
> +	0x0338, 0x00000000,
> +	0x04C8, 0x00000000,
> +	0x04CC, 0x003F0000,
> +	0x04D0, 0x00050100,
> +	0x04D4, 0x00000000,
> +	0x04D8, 0x341C9207,
> +	0x04DC, 0x00008000,
> +	0x04E0, 0x00000909,
> +	0x04E4, 0x00000040,
> +	0x04E8, 0x00000000,
> +	0x0678, 0x00000000,
> +	0x067C, 0x003F0000,
> +	0x0680, 0x00050100,
> +	0x0684, 0x00000000,
> +	0x0688, 0x341C9207,
> +	0x068C, 0x00008000,
> +	0x0690, 0x00000909,
> +	0x0694, 0x00000200,
> +	0x0698, 0x00000000,
> +	0x0828, 0x00000000,
> +	0x082C, 0x003F0000,
> +	0x0830, 0x00050100,
> +	0x0834, 0x00000000,
> +	0x0838, 0x341C9207,
> +	0x083C, 0x00008000,
> +	0x0840, 0x00000909,
> +	0x0844, 0x00001000,
> +	0x0848, 0x00000000,
> +	0x09D8, 0x00000000,
> +	0x09DC, 0x003F0000,
> +	0x09E0, 0x00050100,
> +	0x09E4, 0x00000000,
> +	0x09E8, 0x341C9207,
> +	0x09EC, 0x00008000,
> +	0x09F0, 0x00000909,
> +	0x09F4, 0x00008000,
> +	0x09F8, 0x00000000,
> +	0x0B88, 0x00000000,
> +	0x0B8C, 0x003F0000,
> +	0x0B90, 0x00050100,
> +	0x0B94, 0x00000000,
> +	0x0B98, 0x341C9207,
> +	0x0B9C, 0x00008000,
> +	0x0BA0, 0x00000909,
> +	0x0BA4, 0x00040000,
> +	0x0BA8, 0x00000000,
> +	0x0D38, 0x00000000,
> +	0x0D3C, 0x003F0000,
> +	0x0D40, 0x00050100,
> +	0x0D44, 0x00000000,
> +	0x0D48, 0x341C9207,
> +	0x0D4C, 0x00008000,
> +	0x0D50, 0x00000909,
> +	0x0D54, 0x00200000,
> +	0x0D58, 0x00000000,
> +	0x0EE8, 0x00000000,
> +	0x0EEC, 0x003F0000,
> +	0x0EF0, 0x00050100,
> +	0x0EF4, 0x00000000,
> +	0x0EF8, 0x341C9207,
> +	0x0EFC, 0x00008000,
> +	0x0F00, 0x00000909,
> +	0x0F04, 0x00000000,
> +	0x0F08, 0x00000000,
> +	0x1098, 0x00000000,
> +	0x109C, 0x003F0000,
> +	0x10A0, 0x00050100,
> +	0x10A4, 0x00000000,
> +	0x10A8, 0x341C9207,
> +	0x10AC, 0x00008000,
> +	0x10B0, 0x00000909,
> +	0x10B4, 0x00000000,
> +	0x10B8, 0x00000000,
> +	0x1248, 0x00000000,
> +	0x124C, 0x003F0000,
> +	0x1250, 0x00050100,
> +	0x1254, 0x00000000,
> +	0x1258, 0x341C9207,
> +	0x125C, 0x00008000,
> +	0x1260, 0x00000909,
> +	0x1264, 0x00000000,
> +	0x1268, 0x00000000,
> +	0x13F8, 0x00000000,
> +	0x13FC, 0x003F0000,
> +	0x1400, 0x00050100,
> +	0x1404, 0x00000000,
> +	0x1408, 0x341C9207,
> +	0x140C, 0x00008000,
> +	0x1410, 0x00000909,
> +	0x1414, 0x00000000,
> +	0x1418, 0x00000000,
> +	0x018C, 0xE0400000,
> +	0x0190, 0x00000000,
> +	0x0194, 0x00000000,
> +	0x0198, 0x000A0000,
> +	0x019C, 0x000008D2,
> +	0x01A0, 0x00000000,
> +	0x01A4, 0x00000040,
> +	0x01A8, 0x000186A0,
> +	0x01AC, 0x00030D40,
> +	0x01B0, 0x00061A80,
> +	0x01B4, 0x000C3500,
> +	0x01B8, 0x00000000,
> +	0x01BC, 0x00000000,
> +	0x01C0, 0x00000000,
> +	0x01C4, 0x00000000,
> +	0x01C8, 0x00000000,
> +	0x01CC, 0x00000000,
> +	0x033C, 0xE0400000,
> +	0x0340, 0x00000000,
> +	0x0344, 0x00000000,
> +	0x0348, 0x000A0000,
> +	0x034C, 0x000008D2,
> +	0x0350, 0x00000000,
> +	0x0354, 0x00000040,
> +	0x0358, 0x000186A0,
> +	0x035C, 0x00030D40,
> +	0x0360, 0x00061A80,
> +	0x0364, 0x000C3500,
> +	0x0368, 0x00000000,
> +	0x036C, 0x00000000,
> +	0x0370, 0x00000000,
> +	0x0374, 0x00000000,
> +	0x0378, 0x00000000,
> +	0x037C, 0x00000000,
> +	0x04EC, 0xE0400000,
> +	0x04F0, 0x00000000,
> +	0x04F4, 0x00000000,
> +	0x04F8, 0x000A0000,
> +	0x04FC, 0x000008D2,
> +	0x0500, 0x00000000,
> +	0x0504, 0x00000040,
> +	0x0508, 0x000186A0,
> +	0x050C, 0x00030D40,
> +	0x0510, 0x00061A80,
> +	0x0514, 0x000C3500,
> +	0x0518, 0x00000000,
> +	0x051C, 0x00000000,
> +	0x0520, 0x00000000,
> +	0x0524, 0x00000000,
> +	0x0528, 0x00000000,
> +	0x052C, 0x00000000,
> +	0x069C, 0xE0400000,
> +	0x06A0, 0x00000000,
> +	0x06A4, 0x00000000,
> +	0x06A8, 0x000A0000,
> +	0x06AC, 0x000008D2,
> +	0x06B0, 0x00000000,
> +	0x06B4, 0x00000040,
> +	0x06B8, 0x000186A0,
> +	0x06BC, 0x00030D40,
> +	0x06C0, 0x00061A80,
> +	0x06C4, 0x000C3500,
> +	0x06C8, 0x00000000,
> +	0x06CC, 0x00000000,
> +	0x06D0, 0x00000000,
> +	0x06D4, 0x00000000,
> +	0x06D8, 0x00000000,
> +	0x06DC, 0x00000000,
> +	0x084C, 0xE0400000,
> +	0x0850, 0x00000000,
> +	0x0854, 0x00000000,
> +	0x0858, 0x000A0000,
> +	0x085C, 0x000008D2,
> +	0x0860, 0x00000000,
> +	0x0864, 0x00000040,
> +	0x0868, 0x000186A0,
> +	0x086C, 0x00030D40,
> +	0x0870, 0x00061A80,
> +	0x0874, 0x000C3500,
> +	0x0878, 0x00000000,
> +	0x087C, 0x00000000,
> +	0x0880, 0x00000000,
> +	0x0884, 0x00000000,
> +	0x0888, 0x00000000,
> +	0x088C, 0x00000000,
> +	0x09FC, 0xE0400000,
> +	0x0A00, 0x00000000,
> +	0x0A04, 0x00000000,
> +	0x0A08, 0x000A0000,
> +	0x0A0C, 0x000008D2,
> +	0x0A10, 0x00000000,
> +	0x0A14, 0x00000040,
> +	0x0A18, 0x000186A0,
> +	0x0A1C, 0x00030D40,
> +	0x0A20, 0x00061A80,
> +	0x0A24, 0x000C3500,
> +	0x0A28, 0x00000000,
> +	0x0A2C, 0x00000000,
> +	0x0A30, 0x00000000,
> +	0x0A34, 0x00000000,
> +	0x0A38, 0x00000000,
> +	0x0A3C, 0x00000000,
> +	0x0BAC, 0xE0400000,
> +	0x0BB0, 0x00000000,
> +	0x0BB4, 0x00000000,
> +	0x0BB8, 0x000A0000,
> +	0x0BBC, 0x000008D2,
> +	0x0BC0, 0x00000000,
> +	0x0BC4, 0x00000040,
> +	0x0BC8, 0x000186A0,
> +	0x0BCC, 0x00030D40,
> +	0x0BD0, 0x00061A80,
> +	0x0BD4, 0x000C3500,
> +	0x0BD8, 0x00000000,
> +	0x0BDC, 0x00000000,
> +	0x0BE0, 0x00000000,
> +	0x0BE4, 0x00000000,
> +	0x0BE8, 0x00000000,
> +	0x0BEC, 0x00000000,
> +	0x0D5C, 0xE0400000,
> +	0x0D60, 0x00000000,
> +	0x0D64, 0x00000000,
> +	0x0D68, 0x000A0000,
> +	0x0D6C, 0x000008D2,
> +	0x0D70, 0x00000000,
> +	0x0D74, 0x00000040,
> +	0x0D78, 0x000186A0,
> +	0x0D7C, 0x00030D40,
> +	0x0D80, 0x00061A80,
> +	0x0D84, 0x000C3500,
> +	0x0D88, 0x00000000,
> +	0x0D8C, 0x00000000,
> +	0x0D90, 0x00000000,
> +	0x0D94, 0x00000000,
> +	0x0D98, 0x00000000,
> +	0x0D9C, 0x00000000,
> +	0x0F0C, 0xE0400000,
> +	0x0F10, 0x00000000,
> +	0x0F14, 0x00000000,
> +	0x0F18, 0x000A0000,
> +	0x0F1C, 0x000008D2,
> +	0x0F20, 0x00000000,
> +	0x0F24, 0x00000040,
> +	0x0F28, 0x000186A0,
> +	0x0F2C, 0x00000000,
> +	0x0F30, 0x00000000,
> +	0x0F34, 0x00000000,
> +	0x0F38, 0x00000000,
> +	0x0F3C, 0x00000000,
> +	0x0F40, 0x00000000,
> +	0x0F44, 0x00000000,
> +	0x0F48, 0x00000000,
> +	0x0F4C, 0x00000000,
> +	0x10BC, 0xE0400000,
> +	0x10C0, 0x00000000,
> +	0x10C4, 0x00000000,
> +	0x10C8, 0x000A0000,
> +	0x10CC, 0x000008D2,
> +	0x10D0, 0x00000000,
> +	0x10D4, 0x00000040,
> +	0x10D8, 0x00000000,
> +	0x10DC, 0x00000000,
> +	0x10E0, 0x00000000,
> +	0x10E4, 0x00000000,
> +	0x10E8, 0x00000000,
> +	0x10EC, 0x00000000,
> +	0x10F0, 0x00000000,
> +	0x10F4, 0x00000000,
> +	0x10F8, 0x00000000,
> +	0x10FC, 0x00000000,
> +	0x126C, 0xE0400000,
> +	0x1270, 0x00000000,
> +	0x1274, 0x00000000,
> +	0x1278, 0x000A0000,
> +	0x127C, 0x000008D2,
> +	0x1280, 0x00000000,
> +	0x1284, 0x00000040,
> +	0x1288, 0x00000000,
> +	0x128C, 0x00000000,
> +	0x1290, 0x00000000,
> +	0x1294, 0x00000000,
> +	0x1298, 0x00000000,
> +	0x129C, 0x00000000,
> +	0x12A0, 0x00000000,
> +	0x12A4, 0x00000000,
> +	0x12A8, 0x00000000,
> +	0x12AC, 0x00000000,
> +	0x141C, 0xE0400000,
> +	0x1420, 0x00000000,
> +	0x1424, 0x00000000,
> +	0x1428, 0x000A0000,
> +	0x142C, 0x000008D2,
> +	0x1430, 0x00000000,
> +	0x1434, 0x00000040,
> +	0x1438, 0x00000000,
> +	0x143C, 0x00000000,
> +	0x1440, 0x00000000,
> +	0x1444, 0x00000000,
> +	0x1448, 0x00000000,
> +	0x144C, 0x00000000,
> +	0x1450, 0x00000000,
> +	0x1454, 0x00000000,
> +	0x1458, 0x00000000,
> +	0x145C, 0x00000000,
> +	0x01D0, 0x00000000,
> +	0x01D4, 0x00000000,
> +	0x01D8, 0x00000000,
> +	0x01DC, 0x00000000,
> +	0x01E0, 0x00000000,
> +	0x01E4, 0xFFFFFFFF,
> +	0x01E8, 0x00000000,
> +	0x01EC, 0x00000000,
> +	0x01F0, 0x00000000,
> +	0x01F4, 0x00000000,
> +	0x01F8, 0x070004B0,
> +	0x01FC, 0x0E000000,
> +	0x0200, 0xF2000000,
> +	0x0204, 0x02000000,
> +	0x0208, 0x02000000,
> +	0x020C, 0x00002000,
> +	0x0210, 0x00010000,
> +	0x0214, 0x80007530,
> +	0x0220, 0x00000000,
> +	0x0224, 0x00000000,
> +	0x0380, 0x00000000,
> +	0x0384, 0x00000000,
> +	0x0388, 0x00000000,
> +	0x038C, 0x00000000,
> +	0x0390, 0x00000000,
> +	0x0394, 0xFFFFFFFF,
> +	0x0398, 0x00000000,
> +	0x039C, 0x00000000,
> +	0x03A0, 0x00000000,
> +	0x03A4, 0x00000000,
> +	0x03A8, 0x070004B0,
> +	0x03AC, 0x0E000000,
> +	0x03B0, 0xF2000000,
> +	0x03B4, 0x02000000,
> +	0x03B8, 0x02000000,
> +	0x03BC, 0x00002000,
> +	0x03C0, 0x00010000,
> +	0x03C4, 0x80007530,
> +	0x03D0, 0x00000000,
> +	0x03D4, 0x00000000,
> +	0x0530, 0x00000000,
> +	0x0534, 0x00000000,
> +	0x0538, 0x00000000,
> +	0x053C, 0x00000000,
> +	0x0540, 0x00000000,
> +	0x0544, 0xFFFFFFFF,
> +	0x0548, 0x00000000,
> +	0x054C, 0x00000000,
> +	0x0550, 0x00000000,
> +	0x0554, 0x00000000,
> +	0x0558, 0x070004B0,
> +	0x055C, 0x0E000000,
> +	0x0560, 0xF2000000,
> +	0x0564, 0x02000000,
> +	0x0568, 0x02000000,
> +	0x056C, 0x00002000,
> +	0x0570, 0x00010000,
> +	0x0574, 0x80007530,
> +	0x0580, 0x00000000,
> +	0x0584, 0x00000000,
> +	0x06E0, 0x00000000,
> +	0x06E4, 0x00000000,
> +	0x06E8, 0x00000000,
> +	0x06EC, 0x00000000,
> +	0x06F0, 0x00000000,
> +	0x06F4, 0xFFFFFFFF,
> +	0x06F8, 0x00000000,
> +	0x06FC, 0x00000000,
> +	0x0700, 0x00000000,
> +	0x0704, 0x00000000,
> +	0x0708, 0x070004B0,
> +	0x070C, 0x0E000000,
> +	0x0710, 0xF2000000,
> +	0x0714, 0x02000000,
> +	0x0718, 0x02000000,
> +	0x071C, 0x00002000,
> +	0x0720, 0x00010000,
> +	0x0724, 0x80007530,
> +	0x0730, 0x00000000,
> +	0x0734, 0x00000000,
> +	0x0890, 0x00000000,
> +	0x0894, 0x00000000,
> +	0x0898, 0x00000000,
> +	0x089C, 0x00000000,
> +	0x08A0, 0x00000000,
> +	0x08A4, 0xFFFFFFFF,
> +	0x08A8, 0x00000000,
> +	0x08AC, 0x00000000,
> +	0x08B0, 0x00000000,
> +	0x08B4, 0x00000000,
> +	0x08B8, 0x070004B0,
> +	0x08BC, 0x0E000000,
> +	0x08C0, 0xF2000000,
> +	0x08C4, 0x02000000,
> +	0x08C8, 0x02000000,
> +	0x08CC, 0x00002000,
> +	0x08D0, 0x00010000,
> +	0x08D4, 0x80007530,
> +	0x08E0, 0x00000000,
> +	0x08E4, 0x00000000,
> +	0x0A40, 0x00000000,
> +	0x0A44, 0x00000000,
> +	0x0A48, 0x00000000,
> +	0x0A4C, 0x00000000,
> +	0x0A50, 0x00000000,
> +	0x0A54, 0xFFFFFFFF,
> +	0x0A58, 0x00000000,
> +	0x0A5C, 0x00000000,
> +	0x0A60, 0x00000000,
> +	0x0A64, 0x00000000,
> +	0x0A68, 0x070004B0,
> +	0x0A6C, 0x0E000000,
> +	0x0A70, 0xF2000000,
> +	0x0A74, 0x02000000,
> +	0x0A78, 0x02000000,
> +	0x0A7C, 0x00002000,
> +	0x0A80, 0x00010000,
> +	0x0A84, 0x80007530,
> +	0x0A90, 0x00000000,
> +	0x0A94, 0x00000000,
> +	0x0BF0, 0x00000000,
> +	0x0BF4, 0x00000000,
> +	0x0BF8, 0x00000000,
> +	0x0BFC, 0x00000000,
> +	0x0C00, 0x00000000,
> +	0x0C04, 0xFFFFFFFF,
> +	0x0C08, 0x00000000,
> +	0x0C0C, 0x00000000,
> +	0x0C10, 0x00000000,
> +	0x0C14, 0x00000000,
> +	0x0C18, 0x070004B0,
> +	0x0C1C, 0x0E000000,
> +	0x0C20, 0xF2000000,
> +	0x0C24, 0x02000000,
> +	0x0C28, 0x02000000,
> +	0x0C2C, 0x00002000,
> +	0x0C30, 0x00010000,
> +	0x0C34, 0x80007530,
> +	0x0C40, 0x00000000,
> +	0x0C44, 0x00000000,
> +	0x0DA0, 0x00000000,
> +	0x0DA4, 0x00000000,
> +	0x0DA8, 0x00000000,
> +	0x0DAC, 0x00000000,
> +	0x0DB0, 0x00000000,
> +	0x0DB4, 0xFFFFFFFF,
> +	0x0DB8, 0x00000000,
> +	0x0DBC, 0x00000000,
> +	0x0DC0, 0x00000000,
> +	0x0DC4, 0x00000000,
> +	0x0DC8, 0x070004B0,
> +	0x0DCC, 0x0E000000,
> +	0x0DD0, 0xF2000000,
> +	0x0DD4, 0x02000000,
> +	0x0DD8, 0x02000000,
> +	0x0DDC, 0x00002000,
> +	0x0DE0, 0x00010000,
> +	0x0DE4, 0x80007530,
> +	0x0DF0, 0x00000000,
> +	0x0DF4, 0x00000000,
> +	0x0F50, 0x00000000,
> +	0x0F54, 0x00000000,
> +	0x0F58, 0x00000000,
> +	0x0F5C, 0x00000000,
> +	0x0F60, 0x00000000,
> +	0x0F64, 0xFFFFFFFF,
> +	0x0F68, 0x00000000,
> +	0x0F6C, 0x00000000,
> +	0x0F70, 0x00000000,
> +	0x0F74, 0x00000000,
> +	0x0F78, 0x070004B0,
> +	0x0F7C, 0x0E000000,
> +	0x0F80, 0xF2000000,
> +	0x0F84, 0x02000000,
> +	0x0F88, 0x02000000,
> +	0x0F8C, 0x00002000,
> +	0x0F90, 0x00010000,
> +	0x0F94, 0x80007530,
> +	0x0FA0, 0x00000000,
> +	0x0FA4, 0x00000000,
> +	0x1100, 0x00000000,
> +	0x1104, 0x00000000,
> +	0x1108, 0x00000000,
> +	0x110C, 0x00000000,
> +	0x1110, 0x00000000,
> +	0x1114, 0xFFFFFFFF,
> +	0x1118, 0x00000000,
> +	0x111C, 0x00000000,
> +	0x1120, 0x00000000,
> +	0x1124, 0x00000000,
> +	0x1128, 0x070004B0,
> +	0x112C, 0x0E000000,
> +	0x1130, 0xF2000000,
> +	0x1134, 0x02000000,
> +	0x1138, 0x02000000,
> +	0x113C, 0x00002000,
> +	0x1140, 0x00010000,
> +	0x1144, 0x80007530,
> +	0x1150, 0x00000000,
> +	0x1154, 0x00000000,
> +	0x12B0, 0x00000000,
> +	0x12B4, 0x00000000,
> +	0x12B8, 0x00000000,
> +	0x12BC, 0x00000000,
> +	0x12C0, 0x00000000,
> +	0x12C4, 0xFFFFFFFF,
> +	0x12C8, 0x00000000,
> +	0x12CC, 0x00000000,
> +	0x12D0, 0x00000000,
> +	0x12D4, 0x00000000,
> +	0x12D8, 0x070004B0,
> +	0x12DC, 0x0E000000,
> +	0x12E0, 0xF2000000,
> +	0x12E4, 0x02000000,
> +	0x12E8, 0x02000000,
> +	0x12EC, 0x00002000,
> +	0x12F0, 0x00010000,
> +	0x12F4, 0x80007530,
> +	0x1300, 0x00000000,
> +	0x1304, 0x00000000,
> +	0x1460, 0x00000000,
> +	0x1464, 0x00000000,
> +	0x1468, 0x00000000,
> +	0x146C, 0x00000000,
> +	0x1470, 0x00000000,
> +	0x1474, 0xFFFFFFFF,
> +	0x1478, 0x00000000,
> +	0x147C, 0x00000000,
> +	0x1480, 0x00000000,
> +	0x1484, 0x00000000,
> +	0x1488, 0x070004B0,
> +	0x148C, 0x0E000000,
> +	0x1490, 0xF2000000,
> +	0x1494, 0x02000000,
> +	0x1498, 0x02000000,
> +	0x149C, 0x00002000,
> +	0x14A0, 0x00010000,
> +	0x14A4, 0x80007530,
> +	0x14B0, 0x00000000,
> +	0x14B4, 0x00000000,
> +	0xF084, 0x00000006,
> +	0x004C, 0xFFFFFFFF,
> +	0x0050, 0xFFFFFFFF,
> +	0x0054, 0xFFFFFFFF,
> +	0x0058, 0xFFFFFFFF,
> +	0x0090, 0x00000000,
> +	0x0094, 0x00000064,
> +	0x0098, 0x40000000,
> +	0x009C, 0x00000000,
> +	0x00A0, 0x00140014,
> +	0x00A4, 0x0019000D,
> +	0x00A8, 0x0096004B,
> +};
> +
> +static void aw963xx_set_cs_as_irq(struct aw_sar *p_sar, int flag);
> +
> +static int aw963xx_load_reg_bin(struct aw_bin *aw_bin, void *load_bin_para)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)load_bin_para;
> +	struct aw963xx *aw963xx = (struct aw963xx *)p_sar->priv_data;
> +	int ret;
> +
> +	ret = strncmp(p_sar->chip_name, aw_bin->header_info[0].chip_type,
> +			sizeof(aw_bin->header_info[0].chip_type));
> +	if (ret != 0)
> +		dev_err(p_sar->dev, "load_binname(%s) incompatible with chip type(%s)",
> +			p_sar->chip_name, aw_bin->header_info[0].chip_type);
> +
> +	p_sar->load_bin.bin_data_ver = aw_bin->header_info[0].bin_data_ver;
> +
> +	ret = aw_sar_load_reg(aw_bin, p_sar->i2c);
> +
> +	if (!strncmp(p_sar->chip_name, AW96308, sizeof(AW96308)) ||
> +		!strncmp(p_sar->chip_name, AW96305BFOR, sizeof(AW96305BFOR)))
> +		aw963xx_set_cs_as_irq(p_sar, aw963xx->irq_mux);
> +
> +	return ret;
> +}
> +
> +static void aw963xx_irq_handle_func(unsigned int irq_status, void *data)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	unsigned int ch_th[AW963XX_CHANNEL_NUM_MAX] = { 0 };
> +	unsigned int curr_status_val[4] = { 0 };
> +	unsigned char i;
> +	unsigned char j;
> +
> +	if (((irq_status & 0x01) == 1) && (p_sar->driver_code_initover_flag == 1))
> +		p_sar->fault_flag = AW_SAR_UNHEALTHY;
> +
> +	for (i = 0; i < AW963XX_VALID_TH; i++)
> +		aw_sar_i2c_read(p_sar->i2c, REG_STAT0 + i * (REG_STAT1 - REG_STAT0),
> +				&curr_status_val[i]);
> +
> +	for (j = 0; j < AW963XX_CHANNEL_NUM_MAX; j++) {
> +		for (i = 0; i < AW963XX_VALID_TH; i++)
> +			ch_th[j] |= ((curr_status_val[i] >> j) & 0x01) << i;
> +
> +		if (p_sar->channels_arr[j].last_channel_info != ch_th[j]) {
> +			if (ch_th[j] == 0) {
> +				/* far */
> +				iio_push_event(p_sar->aw_iio_dev,
> +						IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, j,
> +							IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> +						iio_get_time_ns(p_sar->aw_iio_dev));
> +			} else {
> +				/* near */
> +				iio_push_event(p_sar->aw_iio_dev,
> +						IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, j,
> +							IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING),
> +						iio_get_time_ns(p_sar->aw_iio_dev));
> +			}
> +			p_sar->channels_arr[j].last_channel_info = ch_th[j];
> +		}
> +	}
> +}
> +
> +static ssize_t aw963xx_operation_mode_get(void *data, char *buf)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	ssize_t len = 0;
> +
> +	if (p_sar->last_mode == AW963XX_ACTIVE_MODE)
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: Active\n");
> +	else if (p_sar->last_mode == AW963XX_SLEEP_MODE)
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: Sleep\n");
> +	else if (p_sar->last_mode == AW963XX_DEEPSLEEP_MODE)
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: DeepSleep\n");
> +	else
> +		len += snprintf(buf + len, PAGE_SIZE - len, "operation mode: Unconfirmed\n");
> +
> +	return len;
> +}
> +
> +static void aw963xx_sar_chip_info_get(void *data, char *buf, ssize_t *p_len)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	unsigned int reg_data;
> +
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len,
> +			"sar%u\n", p_sar->dts_info.sar_num);
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len, "The driver supports UI\n");
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_CHIP_ID0, &reg_data);
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len, "chipid is 0x%08x\n", reg_data);
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_IRQEN, &reg_data);
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len, "REG_HOSTIRQEN is 0x%08x\n", reg_data);
> +
> +	*p_len += snprintf(buf + *p_len, PAGE_SIZE - *p_len, "aw963xx Bin data version:0x%08x\n",
> +			p_sar->load_bin.bin_data_ver);
> +}
> +
> +static int aw963xx_get_signed_cap(void *data, unsigned short reg_addr)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	int s_ofst_c = 0;
> +	unsigned int off_m_bit;
> +	unsigned int off_c_bit;
> +	unsigned int reg_data;
> +	unsigned int off_c;
> +	unsigned int off_m;
> +	int off_f;
> +	unsigned int i;
> +
> +	aw_sar_i2c_read(p_sar->i2c, reg_addr, &reg_data);
> +
> +	off_f = ((reg_data >> AW_BIT16) & ONE_WORD) * AW963XX_STEP_LEN_UNSIGNED_CAP_FINE_ADJ;
> +	off_c = (reg_data >> AW_BIT8) & ONE_WORD;
> +	off_m = reg_data & ONE_WORD;
> +
> +	for (i = 0; i < 8; i++) {
> +		off_m_bit = (off_m >> i) & 0x01;
> +		off_c_bit = (off_c >> i) & 0x01;
> +		s_ofst_c += ((1 - 2 * off_m_bit) * off_c_bit * aw_sar_pow2(i)) *
> +			AW963XX_STEP_LEN_UNSIGNED_CAP_ROUGH_ADJ;
> +	}
> +
> +	return (s_ofst_c + off_f);
> +}
> +
> +static unsigned int aw963xx_get_unsigned_cap(void *data, unsigned short reg_addr)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	unsigned int reg_data;
> +	unsigned int rough;
> +	unsigned int fine;
> +
> +	aw_sar_i2c_read(p_sar->i2c, reg_addr, &reg_data);
> +
> +	rough = ((reg_data >> AW_BIT8) & ONE_WORD) * AW963XX_STEP_LEN_UNSIGNED_CAP_ROUGH_ADJ;
> +	fine = ((reg_data >> AW_BIT16) & ONE_WORD) * AW963XX_STEP_LEN_UNSIGNED_CAP_FINE_ADJ;
> +
> +	return (rough + fine);
> +}
> +
> +static void aw963xx_get_ref_ch_enable(struct aw_sar *p_sar)
> +{
> +	struct aw963xx *aw963xx = (struct aw963xx *)p_sar->priv_data;
> +	unsigned int refa_ch;
> +	unsigned int refb_ch;
> +	unsigned int reg_data;
> +	int i;
> +
> +	for (i = 0; i < AW963XX_CHANNEL_NUM_MAX; i++) {
> +		aw_sar_i2c_read(p_sar->i2c,
> +				REG_FILTCTRL0_CH0 +
> +				i * (REG_FILTCTRL0_CH1 - REG_FILTCTRL0_CH0),
> +				&reg_data);
> +		if ((reg_data >> AW963XX_FILTCTRL0_CHX_REFAEN) & 0x01) {
> +			refa_ch = (reg_data >> AW963XX_FILTCTRL0_CHX_REFASEL) & 0x1f;
> +			aw963xx->ref_ch_en[refa_ch] = AW963XX_REF_EN;
> +		}
> +		if ((reg_data >> AW963XX_FILTCTRL0_CHX_REFBEN) & 0x01) {
> +			refb_ch = (reg_data >> AW963XX_FILTCTRL0_CHX_REFBSEL) & 0x1f;
> +			aw963xx->ref_ch_en[refb_ch] = AW963XX_REF_EN;
> +		}
> +	}
> +}
> +
> +/* Note: Because the kernel cannot handle floating-point types, it expands mul by 10 times */
> +static unsigned char aw963xx_get_offset_multiple(struct aw_sar *p_sar, unsigned char ch)
> +{
> +	unsigned int reg_data;
> +	unsigned char mul = 1;
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_AFECFG2_CH0 + ch * (REG_AFECFG2_CH1 - REG_AFECFG2_CH0),
> +			&reg_data);
> +	if ((reg_data >> 27) & 0x1) {
> +		if (((reg_data >> 29) & 0x3) == 0)
> +			mul = 16;
> +		else if (((reg_data >> 29) & 0x3) == 1)
> +			mul = 20;
> +		else if (((reg_data >> 29) & 0x3) == 2)
> +			mul = 26;
> +		else if (((reg_data >> 29) & 0x3) == 3)
> +			mul = 40;
> +		return mul;
> +	}
> +
> +	aw_sar_i2c_read(p_sar->i2c, REG_AFECFG3_CH0 +
> +			ch * (REG_AFECFG3_CH1 - REG_AFECFG3_CH0),
> +			&reg_data);
> +	if ((reg_data >> 11) & 0x1)
> +		mul = 20;
> +	else
> +		mul = 10;
> +
> +	return mul;
> +}
> +
> +static ssize_t aw963xx_get_cap_offset(void *data, char *buf)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	struct aw963xx *aw963xx = (struct aw963xx *)p_sar->priv_data;
> +	int signed_cap_ofst;
> +	unsigned int mode = 0xff;
> +	unsigned int reg_data;
> +	unsigned int cap_ofst;
> +	unsigned char mul = 10;
> +	ssize_t len = 0;
> +	unsigned int tmp;
> +	unsigned int i;
> +
> +	aw963xx_get_ref_ch_enable(p_sar);
> +
> +	for (i = 0; i < AW963XX_CHANNEL_NUM_MAX; i++) {
> +		aw_sar_i2c_read(p_sar->i2c,
> +				REG_AFESOFTCFG0_CH0 +
> +				i * (REG_AFESOFTCFG0_CH1 - REG_AFESOFTCFG0_CH0),
> +				&reg_data);
> +		mul = aw963xx_get_offset_multiple(p_sar, i);
> +		mode = reg_data & 0x0ff;
> +		switch (mode) {
> +		case AW963XX_UNSIGNED_CAP:	/* self-capacitance mode unsigned cail */
> +			cap_ofst = aw963xx_get_unsigned_cap(p_sar,
> +				REG_AFECFG1_CH0 + i * (REG_AFECFG1_CH1 - REG_AFECFG1_CH0));
> +		/*
> +		 * Because it has been expanded by 1000 times before,
> +		 * the accuracy of removing mul's expansion loss can be ignored
> +		 */
> +			cap_ofst = cap_ofst * mul / 10;
> +			len += snprintf(buf + len, PAGE_SIZE - len,
> +					"unsigned cap ofst ch%u: %u.%u pf\r\n",
> +					i,
> +					cap_ofst / AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE,
> +					cap_ofst % AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE);
> +			break;
> +		case AW963XX_SIGNED_CAP:	/* self-capacitance mode signed cail */
> +			signed_cap_ofst = aw963xx_get_signed_cap(p_sar,
> +					REG_AFECFG1_CH0 + i * (REG_AFECFG1_CH1 - REG_AFECFG1_CH0));
> +			signed_cap_ofst = signed_cap_ofst * mul / 10;
> +			if (signed_cap_ofst < 0) {
> +				tmp = -signed_cap_ofst;
> +				len += snprintf(buf + len, PAGE_SIZE - len,
> +						"signed cap ofst ch%u: -%u.%upf\r\n",
> +						i,
> +						tmp / AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE,
> +						tmp % AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE);
> +			} else {
> +				len += snprintf(buf + len, PAGE_SIZE - len,
> +						"signed cap ofst ch%u: %d.%dpf\r\n",
> +						i,
> +						signed_cap_ofst /
> +						AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE,
> +						signed_cap_ofst %
> +						AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE);
> +			}
> +			break;
> +		case AW963XX_MUTUAL_CAP:	/* mutual-capacitance mode */
> +			if (aw963xx->ref_ch_en[i] == AW963XX_REF_EN) {
> +				cap_ofst = aw963xx_get_unsigned_cap(p_sar,
> +					REG_AFECFG1_M_CH0 +
> +					i * (REG_AFECFG1_M_CH1 - REG_AFECFG1_M_CH0));
> +				cap_ofst = cap_ofst * mul / 10;
> +				len += snprintf(buf + len, PAGE_SIZE - len,
> +						"ref unsigned cap ofst ch%u: %u.%udpf\r\n",
> +						i,
> +						cap_ofst / AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE,
> +						cap_ofst % AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE);
> +			} else {
> +				signed_cap_ofst = aw963xx_get_signed_cap(p_sar,
> +							REG_AFECFG1_CH0 +
> +							i * (REG_AFECFG1_CH1 - REG_AFECFG1_CH0));
> +				signed_cap_ofst = signed_cap_ofst * mul / 10;
> +				if (signed_cap_ofst < 0) {
> +					tmp = -signed_cap_ofst;
> +					len += snprintf(buf + len, PAGE_SIZE - len,
> +							"mutual cap ofst ch%u: -%u.%udpf\r\n",
> +							i,
> +							tmp / AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE,
> +							tmp % AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE);
> +				} else {
> +					len += snprintf(buf + len, PAGE_SIZE - len,
> +							"mutual cap ofst ch%u: %d.%dpf\r\n",
> +							i,
> +							signed_cap_ofst /
> +							AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE,
> +							signed_cap_ofst %
> +							AW963XX_STEP_LEN_UNSIGNED_CAP_ENLARGE);
> +				}
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return len;
> +}
> +
> +static void aw963xx_set_cs_as_irq(struct aw_sar *p_sar, int flag)
> +{
> +	if (flag == AW963XX_CS2_IRQ) {
> +		aw_sar_i2c_write(p_sar->i2c, 0xfff4, 0x3c00d013);
> +		aw_sar_i2c_write(p_sar->i2c, 0xc100, 0x00000020);
> +		aw_sar_i2c_write(p_sar->i2c, 0xe018, 0x00000004);
> +	} else if (flag == AW963XX_CS5_IRQ) {
> +		aw_sar_i2c_write(p_sar->i2c, 0xfff4, 0x3c00d013);
> +		aw_sar_i2c_write(p_sar->i2c, 0xc100, 0x00000800);
> +		aw_sar_i2c_write(p_sar->i2c, 0xe018, 0x00000020);
> +	} else {
> +		aw_sar_i2c_write(p_sar->i2c, 0xfff4, 0x3c00d013);
> +		aw_sar_i2c_write(p_sar->i2c, 0xc100, 0x00000000);
> +		aw_sar_i2c_write(p_sar->i2c, 0xe018, 0x00000000);
> +	}
> +}
> +
> +int aw963xx_check_chipid(void *data)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	if (!p_sar)
> +		return -EINVAL;
> +
> +	ret = aw_sar_i2c_read(p_sar->i2c, REG_CHIP_ID0, &reg_val);
> +	if (ret < 0) {
> +		dev_err(p_sar->dev, "read CHIP ID failed: %d", ret);
> +		return ret;
> +	}
> +
> +	switch (reg_val) {
> +	case AW96303_CHIP_ID:
> +		memcpy(p_sar->chip_name, AW96303, 8);
> +		ret = 0;
> +		break;
> +	case AW96305_CHIP_ID:
> +		memcpy(p_sar->chip_name, AW96305, 8);
> +		ret = 0;
> +		break;
> +	case AW96305BFOR_CHIP_ID:
> +		memcpy(p_sar->chip_name, AW96305BFOR, 8);
> +		ret = 0;
> +		break;
> +	case AW96308_CHIP_ID:
> +		memcpy(p_sar->chip_name, AW96308, 8);
> +		ret = 0;
> +		break;
> +	case AW96310_CHIP_ID:
> +		memcpy(p_sar->chip_name, AW96310, 8);
> +		ret = 0;
> +		break;
> +	default:
> +		dev_err(p_sar->dev, "chip id error, 0x%04x", reg_val);
> +		ret = -EIO;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(aw963xx_check_chipid, AWINIC_PROX);
> +
> +static void aw963xx_enable_clock(void *i2c)
> +{
> +	aw_sar_i2c_write_bits(i2c, REG_CHIPSTAT, ~AW963XX_CPU_OSC_CTRL_MASK,
> +			AW963XX_CPU_OSC_CTRL_MASK);
> +}
> +
> +static unsigned int aw963xx_rc_irqscr(void *i2c)
> +{
> +	unsigned int val;
> +
> +	aw_sar_i2c_read(i2c, REG_IRQSRC, &val);
> +
> +	return val;
> +}
> +
> +static void aw963xx_set_active_cmd(void *i2c)
> +{
> +	aw_sar_i2c_write(i2c, REG_CMD, AW963XX_ACTIVE_MODE);
> +}
> +
> +static void aw963xx_set_sleep_cmd(void *i2c)
> +{
> +	aw_sar_i2c_write(i2c, REG_CMD, AW963XX_SLEEP_MODE);
> +}
> +
> +static void aw963xx_set_deepsleep_cmd(void *i2c)
> +{
> +	aw_sar_i2c_write(i2c, REG_CMD, AW963XX_DEEPSLEEP_MODE);
> +}
> +
> +static const struct aw_sar_mode_set_t g_aw963xx_mode_set[] = {
> +	{
> +		.chip_id = AW_SAR_NONE_CHECK_CHIP,
> +		.chip_mode = {
> +			.curr_mode = AW963XX_ACTIVE_MODE,
> +			.last_mode = AW963XX_DEEPSLEEP_MODE,
> +		},
> +		.mode_switch_ops = {
> +			.enable_clock = aw963xx_enable_clock,
> +			.rc_irqscr = NULL,
> +			.mode_update = aw963xx_set_active_cmd,
> +		},
> +	},
> +	{
> +		.chip_id = AW_SAR_NONE_CHECK_CHIP,
> +		.chip_mode = {
> +			.curr_mode = AW963XX_ACTIVE_MODE,
> +			.last_mode = AW963XX_SLEEP_MODE,
> +		},
> +		.mode_switch_ops = {
> +			.enable_clock = NULL,
> +			.rc_irqscr = NULL,
> +			.mode_update = aw963xx_set_active_cmd,
> +		},
> +	},
> +	{
> +		.chip_id = AW_SAR_NONE_CHECK_CHIP,
> +		.chip_mode = {
> +			.curr_mode = AW963XX_ACTIVE_MODE,
> +			.last_mode = AW963XX_ACTIVE_MODE,
> +		},
> +		.mode_switch_ops = {
> +			.enable_clock = NULL,
> +			.rc_irqscr = NULL,
> +			.mode_update = aw963xx_set_active_cmd,
> +		},
> +	},
> +	{
> +		.chip_id = AW_SAR_NONE_CHECK_CHIP,
> +		.chip_mode = {
> +			.curr_mode = AW963XX_SLEEP_MODE,
> +			.last_mode = AW963XX_DEEPSLEEP_MODE,
> +		},
> +		.mode_switch_ops = {
> +			.enable_clock = aw963xx_enable_clock,
> +			.rc_irqscr = aw963xx_rc_irqscr,
> +			.mode_update = aw963xx_set_sleep_cmd,
> +		},
> +	},
> +	{
> +		.chip_id = AW_SAR_NONE_CHECK_CHIP,
> +		.chip_mode = {
> +			.curr_mode = AW963XX_SLEEP_MODE,
> +			.last_mode = AW963XX_ACTIVE_MODE,
> +		},
> +		.mode_switch_ops = {
> +			.enable_clock = NULL,
> +			.rc_irqscr = aw963xx_rc_irqscr,
> +			.mode_update = aw963xx_set_sleep_cmd,
> +		},
> +	},
> +	{
> +		.chip_id = AW_SAR_NONE_CHECK_CHIP,
> +		.chip_mode = {
> +			.curr_mode = AW963XX_DEEPSLEEP_MODE,
> +			.last_mode = AW963XX_SLEEP_MODE,
> +		},
> +		.mode_switch_ops = {
> +			.enable_clock = NULL,
> +			.rc_irqscr = aw963xx_rc_irqscr,
> +			.mode_update = aw963xx_set_deepsleep_cmd,
> +		},
> +	},
> +	{
> +		.chip_id = AW_SAR_NONE_CHECK_CHIP,
> +		.chip_mode = {
> +			.curr_mode = AW963XX_DEEPSLEEP_MODE,
> +			.last_mode = AW963XX_ACTIVE_MODE,
> +		},
> +		.mode_switch_ops = {
> +			.enable_clock = NULL,
> +			.rc_irqscr = aw963xx_rc_irqscr,
> +			.mode_update = aw963xx_set_deepsleep_cmd,
> +		},
> +	},
> +};
> +
> +static int aw963xx_parse_dts(void *data)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	struct aw963xx *aw963xx = (struct aw963xx *)p_sar->priv_data;
> +	struct device_node *np = p_sar->i2c->dev.of_node;
> +	int val;
> +
> +	val = of_property_read_u32(np, "awinic,irq-mux", &aw963xx->irq_mux);
> +	if (val != 0)
> +		dev_err(p_sar->dev, "irq-mux not detected");
> +
> +	return 0;
> +}
> +
> +static const struct aw_sar_mode_t g_aw963xx_mode = {
> +	.mode_set_arr = &g_aw963xx_mode_set[0],
> +	.mode_set_arr_len = ARRAY_SIZE(g_aw963xx_mode_set),
> +	.p_set_mode_node_fn = NULL,
> +	.p_get_mode_node_fn = aw963xx_operation_mode_get,
> +};
> +
> +static const struct aw_sar_diff_t g_aw963xx_diff = {
> +	.diff0_reg = REG_DIFF_CH0,
> +	.diff_step = REG_DIFF_CH1 - REG_DIFF_CH0,
> +	.rm_float = AW963XX_DATA_PROCESS_FACTOR,
> +	.p_get_diff_node_fn = NULL,
> +};
> +
> +static const struct aw_sar_offset_t g_aw963xx_offset = {
> +	.p_get_offset_node_fn = aw963xx_get_cap_offset,
> +};
> +
> +static const struct aw_sar_aot_t g_aw963xx_aot = {
> +	.aot_reg = REG_SCANCTRL1,
> +	.aot_mask = ~0xfff,
> +	.aot_flag = 0xfff,
> +};
> +
> +static const struct aw_sar_para_load_t g_aw963xx_reg_arr_para = {
> +	.reg_arr = aw963xx_reg_default,
> +	.reg_arr_len = ARRAY_SIZE(aw963xx_reg_default),
> +};
> +
> +static const struct aw_sar_regulator_config_t g_regulator_config = {
> +	.vcc_name = "vcc",
> +	.min_uV = AW963XX_SAR_VCC_MIN_UV,
> +	.max_uV = AW963XX_SAR_VCC_MAX_UV,
> +};
> +
> +static const struct aw_sar_reg_list_t g_aw963xx_reg_list = {
> +	.reg_none_access = REG_NONE_ACCESS,
> +	.reg_rd_access = REG_RD_ACCESS,
> +	.reg_wd_access = REG_WR_ACCESS,
> +	.reg_perm = (struct aw_sar_reg_data *)&g_aw963xx_reg_access[0],
> +	.reg_num = ARRAY_SIZE(g_aw963xx_reg_access),
> +};
> +
> +static const struct aw_sar_chip_mode_t g_aw963xx_chip_mode = {
> +	.init_mode = AW963XX_ACTIVE_MODE,
> +	.active = AW963XX_ACTIVE_MODE,
> +	.pre_init_mode = AW963XX_SLEEP_MODE,
> +};
> +
> +static const struct aw_sar_load_bin_t g_aw963xx_load_reg_bin = {
> +	.bin_name = "aw963xx_reg",
> +	.bin_opera_func = aw963xx_load_reg_bin,
> +	.p_update_fn = NULL,
> +};
> +
> +static const struct aw_sar_get_chip_info_t g_aw963xx_get_chip_info = {
> +	.p_get_chip_info_node_fn = aw963xx_sar_chip_info_get,
> +};
> +
> +static const struct aw_sar_check_chipid_t g_aw963xx_check_chipid = {
> +	.p_check_chipid_fn = aw963xx_check_chipid,
> +};
> +
> +static const struct aw_sar_irq_init_t g_aw963xx_irq_init = {
> +	.flags = GPIOF_DIR_IN | GPIOF_INIT_HIGH,
> +	.irq_flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +	.handler = NULL,
> +	.thread_fn = NULL,
> +	.rc_irq_fn = aw963xx_rc_irqscr,
> +	.irq_spec_handler_fn = aw963xx_irq_handle_func,
> +
> +	.p_irq_init_fn = NULL,
> +	.p_irq_deinit_fn = NULL,
> +};
> +
> +static const struct aw_sar_soft_rst_t g_aw963xx_soft_rst = {
> +	.reg_rst = REG_SA_RSTNALL,
> +	.reg_rst_val = AW963XX_SOFT_RST_EN,
> +	.delay_ms = AW963XX_CHIP_INIT_MAX_TIME_MS,
> +	.p_soft_reset_fn = NULL,
> +};
> +
> +static const struct aw_sar_init_over_irq_t g_aw963xx_init_over_irq = {
> +	.wait_times = 100,
> +	.daley_step = 1,
> +	.reg_irqsrc = REG_IRQSRC,
> +	.irq_offset_bit = 0,
> +	.irq_mask = 0x1,
> +	.irq_flag = 0x1,
> +
> +	.p_check_init_over_irq_fn = NULL,
> +	.p_get_err_type_fn = NULL,
> +};
> +
> +static const struct aw_sar_pm_t g_aw963xx_pm_chip_mode = {
> +	.suspend_set_mode = AW963XX_SLEEP_MODE,
> +	.resume_set_mode = AW963XX_ACTIVE_MODE,
> +	.shutdown_set_mode = AW963XX_SLEEP_MODE,
> +};
> +
> +static const struct aw_sar_platform_config g_aw963xx_platform_config = {
> +	.p_add_parse_dts_fn = &aw963xx_parse_dts,
> +	.p_regulator_config = &g_regulator_config,
> +	.p_irq_init = &g_aw963xx_irq_init,
> +	.p_pm_chip_mode = &g_aw963xx_pm_chip_mode,
> +};
> +
> +static void aw963xx_power_on_prox_detection(void *data, unsigned char en_flag)
> +{
> +
> +}
> +
> +static const struct aw_sar_power_on_prox_detection_t g_aw933xx_power_on_prox_detection = {
> +	.p_power_on_prox_detection_en_fn = aw963xx_power_on_prox_detection,
> +	.irq_en_cali_bit = 3,
> +	.power_on_prox_en_flag = true,
> +};
> +
> +static const struct aw_sar_chip_config g_aw963xx_chip_config = {
> +	.ch_num_max = AW963XX_CHANNEL_NUM_MAX,
> +	.p_platform_config = &g_aw963xx_platform_config,
> +
> +	.p_check_chipid = &g_aw963xx_check_chipid,
> +	.p_soft_rst = &g_aw963xx_soft_rst,
> +	.p_init_over_irq = &g_aw963xx_init_over_irq,
> +	.p_reg_bin = &g_aw963xx_load_reg_bin,
> +	.p_chip_mode = &g_aw963xx_chip_mode,
> +
> +	/* Node usage parameters */
> +	.p_reg_list = &g_aw963xx_reg_list,
> +	.p_reg_arr = &g_aw963xx_reg_arr_para,
> +	.p_aot = &g_aw963xx_aot,
> +	.p_diff = &g_aw963xx_diff,
> +	.p_offset = &g_aw963xx_offset,
> +	.p_mode = &g_aw963xx_mode,
> +	.p_get_chip_info = &g_aw963xx_get_chip_info,
> +
> +	.power_on_prox_detection = &g_aw933xx_power_on_prox_detection,
> +};
> +
> +int aw963xx_init(struct aw_sar *p_sar)
> +{
> +	if (!p_sar)
> +		return -EINVAL;
> +
> +	p_sar->priv_data = devm_kzalloc(p_sar->dev, sizeof(struct aw963xx), GFP_KERNEL);
> +	if (!p_sar->priv_data)
> +		return -ENOMEM;
> +
> +	/* Chip private function operation */
> +	p_sar->p_sar_para = &g_aw963xx_chip_config;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(aw963xx_init, AWINIC_PROX);
> +
> +void aw963xx_deinit(struct aw_sar *p_sar)
> +{
> +	if ((!p_sar) || (!p_sar->priv_data))
> +		return;
> +
> +	if (p_sar->priv_data != NULL)
> +		devm_kfree(p_sar->dev, p_sar->priv_data);
> +}
> +EXPORT_SYMBOL_NS_GPL(aw963xx_deinit, AWINIC_PROX);
> diff --git a/drivers/iio/proximity/aw_sar.c b/drivers/iio/proximity/aw_sar.c
> new file mode 100644
> index 000000000000..1e62788c54ae
> --- /dev/null
> +++ b/drivers/iio/proximity/aw_sar.c
> @@ -0,0 +1,1850 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AWINIC sar sensor driver
> + *
> + * Author: Shuaijie Wang<wangshuaijie@awinic.com>
Space before < normally in email addresses.

> + *
> + * Copyright (c) 2024 awinic Technology CO., LTD
> + */
> +#include "aw_sar.h"
> +
> +#define AW_SAR_I2C_NAME		"awinic_sar"
Just put that string inline.  There is no requirement that the various
places you've used it have the same string, so having a single define
doesn't really bring any advantage. I'd much rather see it where it
is used.

> +
> +/*
> + * Please check which power_supply on your platform
> + * can get the charger insertion information, then select it.
> + * eg: "usb"/"charger"/"mtk-master-charger"/"mtk_charger_type"
> + */
> +#define USB_POWER_SUPPLY_NAME	"charger"

I'm confused that a SAR driver cares about a USB charger power supply..

> +/*
> + * Check which of your power_supply properties is available
> + * for the charger insertion information and select it.
> + * eg: POWER_SUPPLY_PROP_ONLINE/POWER_SUPPLY_PROP_PRESENT
> + */
> +#define AW_USB_PROP_ONLINE	POWER_SUPPLY_PROP_ONLINE

That extra local define brings nothing. Use POWERS_SUPPLY_PROP_ONLINE
where ever you currently have this version.

> +
> +#define AW_I2C_RW_RETRY_TIME_MIN		(2000)
> +#define AW_I2C_RW_RETRY_TIME_MAX		(3000)
> +#define AW_RETRIES				(5)
> +
> +#define AW_SAR_AWRW_OffSET			(20)
> +#define AW_SAR_AWRW_DATA_WIDTH			(5)
> +#define AW_DATA_OffSET_2			(2)
> +#define AW_DATA_OffSET_3			(3)
> +#define AW_POWER_ON_SYSFS_DELAY_MS		(5000)
> +#define AW_SAR_MONITOR_ESD_DELAY_MS		(5000)
> +#define AW_SAR_OFFSET_LEN			(15)
> +#define AW_SAR_VCC_MIN_UV			(1700000)
> +#define AW_SAR_VCC_MAX_UV			(3600000)
No brackets needed around numeric values for defines.

> +
> +static const struct aw_sar_driver_type g_aw_sar_driver_list[] = {
> +	{ AW_SAR_AW9610X, aw9610x_check_chipid, aw9610x_init, aw9610x_deinit },
> +	{ AW_SAR_AW963XX, aw963xx_check_chipid, aw963xx_init, aw963xx_deinit },
I'd prefer to see c99 style structure initialization here as it makes it easeri
to understand what is going on.

.init = ...

> +};
> +
> +static struct mutex aw_sar_lock;

A global lock? Firstly needs documentation of what data is is protecting and
secondly I doubt it needs to be global.

> +
> +/* Because disable/enable_irq api Therefore, IRQ is embedded */
> +static void aw_sar_disable_irq(struct aw_sar *p_sar)
> +{
> +	if (p_sar->irq_init.host_irq_stat == IRQ_ENABLE) {
> +		disable_irq(p_sar->i2c->irq);
No means to disable at source end?  If that is possible it would be much better
than disabling the interrupt at the SoC end.

> +		p_sar->irq_init.host_irq_stat = IRQ_DISABLE;
> +	}
> +}
> +
> +/*
> + * Chip logic part start
> + * Load default array function
If there is a need for docs for a function because it's not self explanatory then
kernel-doc style.  If not drop the documentation and let the code speak for itself.

> + */
> +static int
> +aw_sar_para_loaded_func(struct i2c_client *i2c, const struct aw_sar_para_load_t *para_load)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < para_load->reg_arr_len; i = i + 2) {
i += 2
Though that rather implies all tehse registers are 15 bit. In which case better
to treat them as that.


> +		ret = aw_sar_i2c_write(i2c, (unsigned short)para_load->reg_arr[i],
> +						para_load->reg_arr[i + 1]);
> +		if (ret != 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Mode setting function */
> +static void aw_sar_mode_set_func(struct i2c_client *i2c,
> +		struct aw_sar_mode_set_t *mode_set_para,
> +		const struct aw_sar_mode_set_t *mode_set, unsigned char len)
> +{
> +	unsigned char i;
> +
> +	for (i = 0; i < len; i++) {
> +		if ((mode_set[i].chip_mode.curr_mode == mode_set_para->chip_mode.curr_mode) &&
> +				(mode_set[i].chip_mode.last_mode == mode_set_para->chip_mode.last_mode) &&
> +				((mode_set[i].chip_id == AW_SAR_NONE_CHECK_CHIP) ||
> +				 ((mode_set[i].chip_id & mode_set_para->chip_id) != 0))) {
> +			if (mode_set[i].mode_switch_ops.enable_clock != NULL)
> +				mode_set[i].mode_switch_ops.enable_clock(i2c);
> +			if (mode_set[i].mode_switch_ops.rc_irqscr != NULL)
> +				mode_set[i].mode_switch_ops.rc_irqscr(i2c);
> +			if (mode_set[i].mode_switch_ops.mode_update != NULL)
> +				mode_set[i].mode_switch_ops.mode_update(i2c);
> +			break;
> +		}
> +	}
> +}
> +
> +static int aw_sar_check_init_over_irq_func(struct i2c_client *i2c,
> +					const struct aw_sar_init_over_irq_t *p_check_irq)
> +{
> +	short cnt = p_check_irq->wait_times;
> +	unsigned int irq_stat;
> +	int ret;
> +
> +	do {
> +		ret = aw_sar_i2c_read(i2c, p_check_irq->reg_irqsrc, &irq_stat);
> +		if (ret < 0)
> +			return ret;
> +		if (((irq_stat >> p_check_irq->irq_offset_bit) & p_check_irq->irq_mask) ==
> +				p_check_irq->irq_flag)
> +			return 0;
> +		mdelay(1);
> +	} while (cnt--);
> +
> +	if (cnt < 0)
> +		dev_err(&i2c->dev, "init over irq error!");
> +
> +	return AW_ERR_IRQ_INIT_OVER;
> +}
> +
> +static int
> +aw_sar_soft_reset_func(struct i2c_client *i2c, const struct aw_sar_soft_rst_t *p_soft_rst)
> +{
> +	int ret;
> +
> +	ret = aw_sar_i2c_write(i2c, p_soft_rst->reg_rst, p_soft_rst->reg_rst_val);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "soft_reset error: %d", ret);
> +		return ret;
> +	}
> +
> +	msleep(p_soft_rst->delay_ms);
> +
> +	return 0;
> +}
> +/* Chip logic part end */
> +
> +static int aw_sar_parse_bin(const struct firmware *cont, struct aw_sar *p_sar)
> +{
> +	enum aw_bin_err_val bin_ret;
> +	struct aw_bin *aw_bin;
> +	int ret;
> +
> +	if (!cont) {
> +		dev_err(p_sar->dev, "def_reg_bin request error!");
> +		return -EINVAL;
> +	}
> +
> +	aw_bin = kzalloc(cont->size + sizeof(*aw_bin), GFP_KERNEL);
> +	if (!aw_bin) {
> +		release_firmware(cont);
> +		dev_err(p_sar->dev, "failed to allcating memory!");
> +		return -ENOMEM;
> +	}
> +
> +	aw_bin->info.len = cont->size;
> +	memcpy(aw_bin->info.data, cont->data, cont->size);
> +
> +	bin_ret = aw_sar_parsing_bin_file(aw_bin);
> +	if (bin_ret < 0) {
> +		dev_err(p_sar->dev, "parse bin fail! bin_ret = %d", bin_ret);
> +		goto err;
> +	}
> +
> +	/* Write bin file execution process */
> +	if (p_sar->load_bin.bin_opera_func != NULL) {
> +		ret = p_sar->load_bin.bin_opera_func(aw_bin, p_sar);
> +		if (ret != 0) {
> +			dev_err(p_sar->dev, "load_bin_to_chip error!");
> +			if (p_sar->load_bin.bin_load_fail_opera_func != NULL) {
> +				ret = p_sar->load_bin.bin_load_fail_opera_func(aw_bin, p_sar);
> +				if (ret != 0) {
> +					dev_err(p_sar->dev, "bin_load_fail_opera_func error!");
> +					goto err;
> +				}
> +			} else {
> +				goto err;
> +			}
> +		}
> +	} else {
> +		dev_err(p_sar->dev, "bin_opera_func is null error!");
> +	}
> +
> +	if (aw_bin != NULL)
> +		kfree(aw_bin);
> +
> +	return 0;
> +err:
> +	if (aw_bin != NULL)
> +		kfree(aw_bin);
> +
> +	return -EINVAL;
> +}
> +
> +static int aw_sar_load_bin_comm(struct aw_sar *p_sar)
> +{
> +	const struct firmware *fw;
> +	int ret;
> +
> +	ret = request_firmware(&fw, p_sar->load_bin.bin_name, p_sar->dev);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "parse %s error!", p_sar->load_bin.bin_name);
> +		return ret;
> +	}
> +
> +	ret = aw_sar_parse_bin(fw, p_sar);
> +	if (ret != 0)
> +		dev_err(p_sar->dev, "reg_bin %s load error!", p_sar->load_bin.bin_name);
> +	release_firmware(fw);
> +
> +	return ret;
> +}
> +
> +static int aw_sar_parse_dts_comm(struct device *dev, struct device_node *np,
> +		struct aw_sar_dts_info *p_dts_info)
> +{
> +	int val;
> +
> +	val = of_property_read_u32(np, "awinic,sar-label", &p_dts_info->sar_num);
> +	if (val != 0) {
> +		dev_err(dev, "multiple sar failed!");
> +		return -EINVAL;
> +	}
> +
> +	val = of_property_read_u32(np, "awinic,channel-use-mask", &p_dts_info->channel_use_flag);
> +	if (val != 0) {
> +		dev_err(dev, "channel_use_flag failed!");
> +		return -EINVAL;
> +	}
> +
> +	/* GPIO is set as internal pull-up input */
> +	p_dts_info->use_inter_pull_up = of_property_read_bool(np, "awinic,pin-set-inter-pull-up");
> +	p_dts_info->use_pm = of_property_read_bool(np, "awinic,using-pm-ops");
> +	p_dts_info->use_plug_cail_flag = of_property_read_bool(np, "awinic,use-plug-cail");
> +	p_dts_info->monitor_esd_flag = of_property_read_bool(np, "awinic,monitor-esd");
> +
> +	return 0;
> +}
> +
> +static int aw_sar_parse_dts(struct aw_sar *p_sar)
> +{
> +	int ret;
> +
> +	ret = aw_sar_parse_dts_comm(p_sar->dev, p_sar->i2c->dev.of_node, &p_sar->dts_info);
> +
> +	/* Special requirements of SAR chip */
> +	if (p_sar->p_sar_para->p_platform_config->p_add_parse_dts_fn != NULL)
> +		ret |= p_sar->p_sar_para->p_platform_config->p_add_parse_dts_fn(p_sar);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t aw_sar_irq(int irq, void *data)
> +{
> +	struct aw_sar *p_sar = (struct aw_sar *)data;
> +	unsigned int irq_status = 0;
> +
> +	/* step1: read clear interrupt */
> +	if (p_sar->p_sar_para->p_platform_config->p_irq_init->rc_irq_fn != NULL)
> +		irq_status = p_sar->p_sar_para->p_platform_config->p_irq_init->rc_irq_fn(p_sar->i2c);
> +
> +	/* step2: Read the status register for status reporting */
> +	if (p_sar->p_sar_para->p_platform_config->p_irq_init->irq_spec_handler_fn != NULL)
> +		p_sar->p_sar_para->p_platform_config->p_irq_init->irq_spec_handler_fn(irq_status,
> +				p_sar);
> +
> +	/* step3: The chip */
> +	if ((!p_sar->dts_info.monitor_esd_flag) && (p_sar->fault_flag == AW_SAR_UNHEALTHY)) {
> +		p_sar->fault_flag = AW_SAR_HEALTHY;
> +		disable_irq_nosync(p_sar->i2c->irq);
> +		p_sar->irq_init.host_irq_stat = IRQ_DISABLE;
> +		schedule_delayed_work(&p_sar->update_work, msecs_to_jiffies(500));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int aw_sar_irq_init_comm(struct aw_sar *p_sar, const struct aw_sar_irq_init_t *p_irq_init)
> +{
> +	irq_handler_t thread_fn = p_irq_init->thread_fn;
> +	int ret;
> +
> +	snprintf(p_sar->irq_init.dev_id, sizeof(p_sar->irq_init.dev_id),
> +			"aw_sar%u_irq", p_sar->dts_info.sar_num);
> +
> +	if (!thread_fn)
> +		thread_fn = aw_sar_irq;
> +	ret = devm_request_threaded_irq(p_sar->dev,
> +			p_sar->i2c->irq,
> +			p_irq_init->handler,
> +			thread_fn,
> +			p_irq_init->irq_flags,
> +			p_sar->irq_init.dev_id,
> +			p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "failed to request IRQ %d: %d", p_sar->i2c->irq, ret);
> +		return ret;
> +	}
> +
> +	p_sar->irq_init.host_irq_stat = IRQ_DISABLE;
> +	disable_irq(p_sar->i2c->irq);
> +
> +	return 0;
> +}
> +
> +static int aw_sar_irq_init(struct aw_sar *p_sar)
> +{
> +
> +	if (!p_sar->p_sar_para->p_platform_config->p_irq_init) {
> +		dev_err(p_sar->dev, "AW_INVALID_PARA");
> +		return -EINVAL;
> +	}
> +
> +	if (p_sar->p_sar_para->p_platform_config->p_irq_init->p_irq_init_fn != NULL) {
> +		dev_err(p_sar->dev, "p_irq_init_fn");
> +		return p_sar->p_sar_para->p_platform_config->p_irq_init->p_irq_init_fn(p_sar);
> +	}
> +
> +	return aw_sar_irq_init_comm(p_sar, p_sar->p_sar_para->p_platform_config->p_irq_init);
> +}
> +
> +static void aw_sar_irq_free(struct aw_sar *p_sar)
> +{
> +	if ((p_sar->p_sar_para->p_platform_config != NULL) &&
> +		(p_sar->p_sar_para->p_platform_config->p_irq_init != NULL) &&
> +		(p_sar->p_sar_para->p_platform_config->p_irq_init->p_irq_deinit_fn != NULL)) {
> +		p_sar->p_sar_para->p_platform_config->p_irq_init->p_irq_deinit_fn(p_sar);
> +		dev_err(p_sar->dev, "AW_INVALID_PARA");
> +		return;
> +	}
> +}
> +
> +static const struct iio_event_spec aw_common_events[2] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
> +	},
> +};
> +
> +static int aw_sar_get_diff_raw(struct aw_sar *p_sar, unsigned int chan, int *buf)
> +{
> +	const struct aw_sar_diff_t *diff = p_sar->p_sar_para->p_diff;
> +	unsigned int data;
> +	int ret;
> +
> +	if (!p_sar->p_sar_para->p_diff)
> +		return -EINVAL;
> +
> +	ret = aw_sar_i2c_read(p_sar->i2c, diff->diff0_reg + chan * diff->diff_step, &data);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "read diff err: %d", ret);
> +		return ret;
> +	}
> +	*buf = (int)data / (int)diff->rm_float;
> +
> +	return ret;
> +}
> +
> +static int aw_sar_read_raw(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long mask)
> +{
> +	struct aw_sar *p_sar;
> +
> +	p_sar = iio_priv(indio_dev);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		aw_sar_get_diff_raw(p_sar, chan->channel, val);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +struct iio_info iio_info = {
> +	.read_raw = aw_sar_read_raw,
> +};
> +
> +static int aw_sar_iio_init(struct aw_sar *p_sar)
> +{
> +	struct iio_chan_spec *aw_sar_channels;
> +	unsigned int chan_num = 0, j = 0;
> +	unsigned int i;
> +
> +	p_sar->channels_arr = devm_kcalloc(p_sar->dev,
> +			p_sar->p_sar_para->ch_num_max,
> +			sizeof(struct aw_channels_info),
> +			GFP_KERNEL);
> +	if (!p_sar->channels_arr)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < p_sar->p_sar_para->ch_num_max; i++) {
> +		p_sar->channels_arr[i].last_channel_info = 0;
> +		if ((p_sar->dts_info.channel_use_flag >> i) & 0x01) {
> +			p_sar->channels_arr[i].used = AW_TRUE;
> +			chan_num++;
> +		} else {
> +			p_sar->channels_arr[i].used = AW_FALSE;
> +		}
> +	}
> +
> +	aw_sar_channels = devm_kcalloc(p_sar->dev, chan_num, sizeof(*aw_sar_channels), GFP_KERNEL);
> +	if (!aw_sar_channels)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < p_sar->p_sar_para->ch_num_max; i++) {
> +		if (p_sar->channels_arr[i].used) {
> +			aw_sar_channels[j].type = IIO_PROXIMITY;
> +			aw_sar_channels[j].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +			aw_sar_channels[j].indexed = 1;
> +			aw_sar_channels[j].channel = i;
> +			aw_sar_channels[j].event_spec = aw_common_events;
> +			aw_sar_channels[j].num_event_specs = ARRAY_SIZE(aw_common_events);
> +			j++;
> +		}
> +	}
> +
> +	p_sar->aw_iio_dev->modes = INDIO_DIRECT_MODE;
> +	p_sar->aw_iio_dev->num_channels = chan_num;
> +	p_sar->aw_iio_dev->channels = aw_sar_channels;
> +	p_sar->aw_iio_dev->info = &iio_info;
> +	p_sar->aw_iio_dev->name = AW_SAR_I2C_NAME;
> +	p_sar->aw_iio_dev->dev.parent = p_sar->dev;
> +
> +	return devm_iio_device_register(p_sar->dev, p_sar->aw_iio_dev);
> +}
> +
> +static int aw_sar_check_init_over_irq_comm(struct aw_sar *p_sar)
> +{
> +	int ret;
> +
> +	if (!p_sar->p_sar_para->p_init_over_irq)
> +		return -EINVAL;
> +
> +	ret = aw_sar_check_init_over_irq_func(p_sar->i2c, p_sar->p_sar_para->p_init_over_irq);
> +	if (ret == AW_ERR_IRQ_INIT_OVER) {
> +		if (p_sar->p_sar_para->p_init_over_irq->p_get_err_type_fn != NULL) {
> +			/* Consider the abnormality reasonable */
> +			if (p_sar->p_sar_para->p_init_over_irq->p_get_err_type_fn(p_sar) == 0) {
> +				p_sar->fw_fail_flag = AW_TRUE;
> +				return 0;
> +			}
> +		}
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/* If there is no special operation on the chip, execute the common process */
> +static int aw_sar_check_init_over_irq(struct aw_sar *p_sar)
> +{
> +	if (!p_sar->p_sar_para->p_init_over_irq)
> +		return -EINVAL;
> +
> +	if (p_sar->p_sar_para->p_init_over_irq->p_check_init_over_irq_fn != NULL)
> +		return p_sar->p_sar_para->p_init_over_irq->p_check_init_over_irq_fn(p_sar);
> +
> +	return aw_sar_check_init_over_irq_comm(p_sar);
> +}
> +
> +static int aw_sar_chip_other_operation(struct aw_sar *p_sar)
> +{
> +	if (p_sar->p_sar_para->p_other_operation != NULL)
> +		return p_sar->p_sar_para->p_other_operation(p_sar);
> +
> +	return 0;
> +}
> +
> +static void aw_sar_chip_other_operation_free(struct aw_sar *p_sar)
> +{
> +	if (p_sar->p_sar_para->p_other_opera_free != NULL)
> +		p_sar->p_sar_para->p_other_opera_free(p_sar);
> +}
> +
> +static int aw_sar_soft_reset(struct aw_sar *p_sar)
> +{
> +	if (!p_sar->p_sar_para->p_soft_rst)
> +		return -EINVAL;
> +
> +	/* If a private interface is defined, the private interface is used */
> +	if (p_sar->p_sar_para->p_soft_rst->p_soft_reset_fn != NULL)
> +		return p_sar->p_sar_para->p_soft_rst->p_soft_reset_fn(p_sar);
> +
> +	return aw_sar_soft_reset_func(p_sar->i2c, p_sar->p_sar_para->p_soft_rst);
> +}
> +
> +static int aw_sar_check_chipid(struct aw_sar *p_sar)
> +{
> +	if (!p_sar->p_sar_para)
> +		return -EINVAL;
> +
> +	if (p_sar->p_sar_para->p_check_chipid != NULL) {
> +		if (p_sar->p_sar_para->p_check_chipid->p_check_chipid_fn != NULL)
> +			return p_sar->p_sar_para->p_check_chipid->p_check_chipid_fn(p_sar);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void aw_sar_mode_set(struct aw_sar *p_sar, unsigned char curr_mode)
> +{
> +	struct aw_sar_mode_set_t mode_set_para;
> +
> +	if (!p_sar->p_sar_para->p_mode)
> +		return;
> +
> +	/* If a private interface is defined, the private interface is used */
> +	if (p_sar->p_sar_para->p_mode->p_set_mode_node_fn != NULL) {
> +		p_sar->p_sar_para->p_mode->p_set_mode_node_fn(p_sar, curr_mode);
> +		return;
> +	}
> +
> +	mode_set_para.chip_id = p_sar->chip_type;
> +	mode_set_para.chip_mode.curr_mode = curr_mode;
> +	mode_set_para.chip_mode.last_mode = p_sar->last_mode;
> +
> +	aw_sar_mode_set_func(p_sar->i2c, &mode_set_para,
> +		p_sar->p_sar_para->p_mode->mode_set_arr,
> +		p_sar->p_sar_para->p_mode->mode_set_arr_len);
> +	p_sar->last_mode = curr_mode;
> +}
> +
> +static int aw_sar_load_def_reg_bin(struct aw_sar *p_sar)
> +{
> +	if ((!p_sar->p_sar_para->p_reg_bin) ||
> +		(!p_sar->p_sar_para->p_reg_bin->bin_name)) {
> +		dev_err(p_sar->dev, "p_reg_bin is NULL or bin_name is NULL error");
> +		p_sar->ret_val = AW_BIN_PARA_INVALID;
> +		return -EINVAL;
> +	}
> +
> +	snprintf(p_sar->load_bin.bin_name, sizeof(p_sar->load_bin.bin_name),
> +			"%s_%u.bin", p_sar->p_sar_para->p_reg_bin->bin_name,
> +			p_sar->dts_info.sar_num);
> +
> +	p_sar->load_bin.bin_opera_func = p_sar->p_sar_para->p_reg_bin->bin_opera_func;
> +
> +	return aw_sar_load_bin_comm(p_sar);
> +}
> +
> +static int aw_sar_para_loaded(struct aw_sar *p_sar)
> +{
> +	if (!p_sar->p_sar_para->p_reg_arr)
> +		return -EINVAL;
> +
> +	aw_sar_para_loaded_func(p_sar->i2c, p_sar->p_sar_para->p_reg_arr);
> +
> +	return 0;
> +}
> +
> +static int aw_sar_awrw_data_analysis(struct aw_sar *p_sar, const char *buf, unsigned char len)
> +{
> +	unsigned int theory_len = len * AW_SAR_AWRW_DATA_WIDTH + AW_SAR_AWRW_OffSET;
> +	unsigned int actual_len = strlen(buf);
> +	unsigned char data_temp[2] = { 0 };
> +	unsigned int tranfar_data_temp;
> +	unsigned char index = 0;
> +	unsigned int i;
> +
> +	if (theory_len != actual_len) {
> +		dev_err(p_sar->dev, "error theory_len = %d actual_len = %d",
> +				theory_len, actual_len);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < len * AW_SAR_AWRW_DATA_WIDTH; i += AW_SAR_AWRW_DATA_WIDTH) {
> +		data_temp[0] = buf[AW_SAR_AWRW_OffSET + i + AW_DATA_OffSET_2];
> +		data_temp[1] = buf[AW_SAR_AWRW_OffSET + i + AW_DATA_OffSET_3];
> +
> +		if (sscanf(data_temp, "%02x", &tranfar_data_temp) == 1)
> +			p_sar->awrw_info.p_i2c_tranfar_data[index] = (unsigned char)tranfar_data_temp;
> +		index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_sar_awrw_write(struct aw_sar *p_sar, const char *buf)
> +{
> +	int ret;
> +
> +	ret = aw_sar_awrw_data_analysis(p_sar, buf, p_sar->awrw_info.i2c_tranfar_data_len);
> +	if (ret == 0)
> +		aw_sar_i2c_write_seq(p_sar->i2c, p_sar->awrw_info.p_i2c_tranfar_data,
> +					p_sar->awrw_info.i2c_tranfar_data_len);
> +
> +	return ret;
> +}
> +
> +static int aw_sar_awrw_read(struct aw_sar *p_sar, const char *buf)
> +{
> +	int ret = 0;
> +	unsigned char *p_buf = p_sar->awrw_info.p_i2c_tranfar_data + p_sar->awrw_info.addr_len;
> +	unsigned short len = (unsigned short)(p_sar->awrw_info.data_len * p_sar->awrw_info.reg_num);
> +
> +	ret = aw_sar_awrw_data_analysis(p_sar, buf, p_sar->awrw_info.addr_len);
> +	if (ret == 0) {
> +		ret = aw_sar_i2c_read_seq(p_sar->i2c,
> +				p_sar->awrw_info.p_i2c_tranfar_data,
> +				p_sar->awrw_info.addr_len,
> +				p_sar->awrw_info.p_i2c_tranfar_data + p_sar->awrw_info.addr_len,
> +				(unsigned short)(p_sar->awrw_info.data_len * p_sar->awrw_info.reg_num));
> +		if (ret != 0)
> +			memset(p_buf, 0xff, len);
> +	}
> +
> +	return ret;
> +}
> +
> +static int aw_sar_awrw_get_func(struct aw_sar *p_sar, char *buf)
> +{
> +	unsigned int len = 0;
> +	unsigned int i;
> +
> +	if (!p_sar->awrw_info.p_i2c_tranfar_data) {
> +		dev_err(p_sar->dev, "p_i2c_tranfar_data is NULL");
> +		return len;
> +	}
> +
> +	if (p_sar->awrw_info.rw_flag == AW_SAR_PACKAGE_RD) {
> +		for (i = 0; i < p_sar->awrw_info.i2c_tranfar_data_len; i++) {
> +			len += snprintf(buf + len, PAGE_SIZE - len, "0x%02x,",
> +				p_sar->awrw_info.p_i2c_tranfar_data[i]);
> +		}
> +	} else {
> +		for (i = 0; i < (p_sar->awrw_info.data_len) * (p_sar->awrw_info.reg_num); i++) {
> +			len += snprintf(buf + len, PAGE_SIZE - len, "0x%02x,",
> +				p_sar->awrw_info.p_i2c_tranfar_data[p_sar->awrw_info.addr_len + i]);
> +		}
> +	}
> +	snprintf(buf + len - 1, PAGE_SIZE - len, "\n");
> +
> +	kfree(p_sar->awrw_info.p_i2c_tranfar_data);
> +	p_sar->awrw_info.p_i2c_tranfar_data = NULL;
> +
> +	return len;
> +}
> +
> +/* Function: continuous read register interface */
> +static ssize_t awrw_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	ssize_t ret;
> +
> +	mutex_lock(&aw_sar_lock);
> +	if ((p_sar->p_sar_para->p_aw_sar_awrw != NULL) &&
> +		(p_sar->p_sar_para->p_aw_sar_awrw->p_get_awrw_node_fn != NULL)) {
> +		ret = (ssize_t)p_sar->p_sar_para->p_aw_sar_awrw->p_get_awrw_node_fn(p_sar, buf);
> +		mutex_unlock(&aw_sar_lock);
> +		return ret;
> +	}
> +
> +	ret = (ssize_t)aw_sar_awrw_get_func(p_sar, buf);
> +
> +	mutex_unlock(&aw_sar_lock);
> +
> +	return ret;
> +}
> +
> +static int aw_sar_awrw_handle(struct aw_sar *p_sar, const char *buf)
> +{
> +	int ret;
> +
> +	p_sar->awrw_info.i2c_tranfar_data_len = p_sar->awrw_info.addr_len +
> +						p_sar->awrw_info.data_len *
> +						p_sar->awrw_info.reg_num;
> +
> +	if (p_sar->awrw_info.p_i2c_tranfar_data != NULL) {
> +		kfree(p_sar->awrw_info.p_i2c_tranfar_data);
> +		p_sar->awrw_info.p_i2c_tranfar_data = NULL;
> +	}
> +
> +	p_sar->awrw_info.p_i2c_tranfar_data = kzalloc(
> +			p_sar->awrw_info.i2c_tranfar_data_len, GFP_KERNEL);
> +	if (!p_sar->awrw_info.p_i2c_tranfar_data)
> +		return -ENOMEM;
> +
> +	if (p_sar->awrw_info.rw_flag == AW_SAR_I2C_WR) {
> +		ret = aw_sar_awrw_write(p_sar, buf);
> +		if (ret != 0)
> +			dev_err(p_sar->dev, "awrw_write error");
> +		if (p_sar->awrw_info.p_i2c_tranfar_data != NULL) {
> +			kfree(p_sar->awrw_info.p_i2c_tranfar_data);
> +			p_sar->awrw_info.p_i2c_tranfar_data = NULL;
> +		}
> +	} else if (p_sar->awrw_info.rw_flag == AW_SAR_I2C_RD) {
> +		ret = aw_sar_awrw_read(p_sar, buf);
> +		if (ret != 0)
> +			dev_err(p_sar->dev, "awrw_read error");
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_sar_awrw_set_func(struct aw_sar *p_sar, const char *buf)
> +{
> +	unsigned int rw_flag;
> +	unsigned int addr_bytes;
> +	unsigned int data_bytes;
> +	unsigned int package_nums;
> +	unsigned int addr_tmp;
> +	unsigned int buf_index0;
> +	unsigned int buf_index1;
> +	unsigned int r_buf_len = 0;
> +	unsigned int tr_offset = 0;
> +	unsigned char addr[4] = { 0 };
> +	unsigned int theory_len;
> +	unsigned int actual_len;
> +	unsigned int reg_num;
> +	unsigned int i;
> +	unsigned int j;
> +
> +	/* step1: Parse frame header */
> +	if (sscanf(buf, "0x%02x 0x%02x 0x%02x ", &rw_flag, &addr_bytes, &data_bytes) != 3) {
> +		dev_err(p_sar->dev, "sscanf0 parse error!");
> +		return -EINVAL;
> +	}
> +	p_sar->awrw_info.rw_flag = (unsigned char)rw_flag;
> +	p_sar->awrw_info.addr_len = (unsigned char)addr_bytes;
> +	p_sar->awrw_info.data_len = (unsigned char)data_bytes;
> +
> +	if (addr_bytes > 4) {
> +		dev_err(p_sar->dev, "para error!");
> +		return -EINVAL;
> +	}
> +
> +	if ((rw_flag == AW_SAR_I2C_WR) || (rw_flag == AW_SAR_I2C_RD)) {
> +		if (sscanf(buf + AW_SAR_OFFSET_LEN, "0x%02x ", &reg_num) != 1) {
> +			dev_err(p_sar->dev, "sscanf1 parse error!");
> +			return -EINVAL;
> +		}
> +		p_sar->awrw_info.reg_num = (unsigned char)reg_num;
> +		aw_sar_awrw_handle(p_sar, buf);
> +	} else if (rw_flag == AW_SAR_PACKAGE_RD) {
> +		/* step2: Get number of packages */
> +		if (sscanf(buf + AW_SAR_OFFSET_LEN, "0x%02x ", &package_nums) != 1) {
> +			dev_err(p_sar->dev, "sscanf2 parse error!");
> +			return -EINVAL;
> +		}
> +		theory_len = AW_SAR_OFFSET_LEN + AW_SAR_AWRW_DATA_WIDTH +
> +				package_nums * (AW_SAR_AWRW_DATA_WIDTH +
> +				AW_SAR_AWRW_DATA_WIDTH * addr_bytes);
> +		actual_len = strlen(buf);
> +		if (theory_len != actual_len) {
> +			dev_err(p_sar->dev, "theory_len:%d, actual_len:%d error!",
> +					theory_len, actual_len);
> +			return -EINVAL;
> +		}
> +
> +		/* step3: Get the size of read data and apply for space */
> +		for (i = 0; i < package_nums; i++) {
> +			buf_index0 = AW_SAR_OFFSET_LEN + AW_SAR_AWRW_DATA_WIDTH +
> +				(AW_SAR_AWRW_DATA_WIDTH * addr_bytes +
> +				 AW_SAR_AWRW_DATA_WIDTH) * i;
> +			if (sscanf(buf + buf_index0, "0x%02x", &reg_num) != 1) {
> +				dev_err(p_sar->dev, "sscanf3 parse error!");
> +				return -EINVAL;
> +			}
> +			r_buf_len += reg_num * data_bytes;
> +		}
> +
> +		p_sar->awrw_info.i2c_tranfar_data_len = r_buf_len;
> +
> +		if (p_sar->awrw_info.p_i2c_tranfar_data != NULL) {
> +			kfree(p_sar->awrw_info.p_i2c_tranfar_data);
> +			p_sar->awrw_info.p_i2c_tranfar_data = NULL;
> +		}
> +		p_sar->awrw_info.p_i2c_tranfar_data = kzalloc(r_buf_len, GFP_KERNEL);
> +		if (!p_sar->awrw_info.p_i2c_tranfar_data)
> +			return -ENOMEM;
> +
> +		/* step3: Resolve register address and read data in packets */
> +		for (i = 0; i < package_nums; i++) {
> +			buf_index0 = AW_SAR_OFFSET_LEN + AW_SAR_AWRW_DATA_WIDTH +
> +				(AW_SAR_AWRW_DATA_WIDTH * addr_bytes + AW_SAR_AWRW_DATA_WIDTH) * i;
> +			if (sscanf(buf + buf_index0, "0x%02x", &reg_num) != 1) {
> +				dev_err(p_sar->dev, "sscanf4 parse error!");
> +				return -EINVAL;
> +			}
> +
> +			for (j = 0; j < addr_bytes; j += 1) {
> +				buf_index1 = buf_index0 + AW_SAR_AWRW_DATA_WIDTH +
> +					(j * AW_SAR_AWRW_DATA_WIDTH);
> +				if (sscanf(buf + buf_index1, "0x%02x", &addr_tmp) == 1) {
> +					addr[j] = (unsigned char)addr_tmp;
> +				} else {
> +					dev_err(p_sar->dev, "sscanf5 parse error!");
> +					return -EINVAL;
> +				}
> +			}
> +			aw_sar_i2c_read_seq(p_sar->i2c,
> +					addr,
> +					addr_bytes,
> +					p_sar->awrw_info.p_i2c_tranfar_data + tr_offset,
> +					(unsigned short)(data_bytes * reg_num));
> +			tr_offset += data_bytes * reg_num;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* Function: continuous write register interface */
> +static ssize_t
> +awrw_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +
> +	mutex_lock(&aw_sar_lock);
> +
> +	if ((p_sar->p_sar_para->p_aw_sar_awrw != NULL) &&
> +		(p_sar->p_sar_para->p_aw_sar_awrw->p_set_awrw_node_fn != NULL)) {
> +		p_sar->p_sar_para->p_aw_sar_awrw->p_set_awrw_node_fn(p_sar, buf, count);
> +		mutex_unlock(&aw_sar_lock);
> +		return count;
> +	}
> +
> +	aw_sar_awrw_set_func(p_sar, buf);
> +
> +	mutex_unlock(&aw_sar_lock);
> +
> +	return count;
> +}
> +/* Print all readable register values */
> +static ssize_t reg_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	unsigned char reg_rd_access;
> +	unsigned int reg_data;
> +	ssize_t len = 0;
> +	int ret;
> +	unsigned short i;
> +
> +	if (!p_sar->p_sar_para->p_reg_list)
> +		return len;
> +
> +	reg_rd_access = p_sar->p_sar_para->p_reg_list->reg_rd_access;
> +
> +	for (i = 0; i < p_sar->p_sar_para->p_reg_list->reg_num; i++) {
> +		if (p_sar->p_sar_para->p_reg_list->reg_perm[i].rw & reg_rd_access) {
> +			ret = aw_sar_i2c_read(p_sar->i2c,
> +					p_sar->p_sar_para->p_reg_list->reg_perm[i].reg, &reg_data);
> +			if (ret < 0)
> +				len += snprintf(buf + len, PAGE_SIZE - len,
> +						"i2c read error ret = %d\n", ret);
> +			len += snprintf(buf + len, PAGE_SIZE - len,
> +						"%x,%x\n",
> +						p_sar->p_sar_para->p_reg_list->reg_perm[i].reg,
> +						reg_data);
> +		}
> +	}
> +
> +	return len;
> +}
> +
> +/* Write register interface with write permission */
> +static ssize_t
> +reg_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	unsigned int databuf[2] = { 0, 0 };
> +	unsigned char reg_wd_access;
> +	unsigned short i;
> +
> +	if (!p_sar->p_sar_para->p_reg_list) {
> +		dev_err(p_sar->dev, "AW_INVALID_PARA");
> +		return count;
> +	}
> +
> +	reg_wd_access = p_sar->p_sar_para->p_reg_list->reg_wd_access;
> +
> +	if (sscanf(buf, "%x %x", &databuf[0], &databuf[1]) != 2)
> +		return count;
> +
> +	for (i = 0; i < p_sar->p_sar_para->p_reg_list->reg_num; i++) {
> +		if ((unsigned short)databuf[0] == p_sar->p_sar_para->p_reg_list->reg_perm[i].reg) {
> +			if (p_sar->p_sar_para->p_reg_list->reg_perm[i].rw & reg_wd_access) {
> +				aw_sar_i2c_write(p_sar->i2c,
> +					(unsigned short)databuf[0], (unsigned int)databuf[1]);
> +			}
> +			break;
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +/* set chip Soft reset */
> +static ssize_t
> +soft_rst_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	unsigned int flag;
> +
> +	if (kstrtouint(buf, 0, &flag) != 0) {
> +		dev_err(p_sar->dev, "kstrtouint parse err");
> +		return count;
> +	}
> +
> +	if (flag == AW_TRUE)
> +		aw_sar_soft_reset(p_sar);
> +
> +	return count;
> +}
> +
> +static int aw_sar_aot(struct aw_sar *p_sar)
> +{
> +	if (!p_sar->p_sar_para->p_aot)
> +		return -EINVAL;
> +
> +	if (p_sar->p_sar_para->p_aot->p_set_aot_node_fn != NULL)
> +		return p_sar->p_sar_para->p_aot->p_set_aot_node_fn(p_sar);
> +
> +	return aw_sar_i2c_write_bits(p_sar->i2c, p_sar->p_sar_para->p_aot->aot_reg,
> +					p_sar->p_sar_para->p_aot->aot_mask,
> +					p_sar->p_sar_para->p_aot->aot_flag);
> +}
> +
> +/* Perform Auto-Offset-Tuning (AOT) */
> +static ssize_t
> +aot_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	unsigned int cali_flag;
> +
> +	if (kstrtouint(buf, 0, &cali_flag) != 0)
> +		return count;
> +
> +	if (cali_flag == AW_TRUE)
> +		aw_sar_aot(p_sar);
> +	else
> +		dev_err(p_sar->dev, "fail to set aot cali");
> +
> +	return count;
> +}
> +
> +/* update Register configuration and set the chip active mode */
> +static int aw_sar_update_reg_set_func(struct aw_sar *p_sar)
> +{
> +	aw_sar_load_def_reg_bin(p_sar);
> +	aw_sar_mode_set(p_sar, p_sar->p_sar_para->p_chip_mode->active);
> +
> +	return 0;
> +}
> +
> +/* Update register configuration */
> +static ssize_t
> +update_reg_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	unsigned int flag;
> +
> +	if (kstrtouint(buf, 0, &flag) != 0) {
> +		dev_err(p_sar->dev, "kstrtouint parse error");
> +		return count;
> +	}
> +
> +	if (flag == AW_TRUE) {
> +		mutex_lock(&aw_sar_lock);
> +		aw_sar_soft_reset(p_sar);
> +		aw_sar_update_reg_set_func(p_sar);
> +		mutex_unlock(&aw_sar_lock);
> +	}
> +
> +	return count;
> +}
> +
> +/* get chip diff val */
> +static ssize_t aw_sar_get_diff(struct aw_sar *p_sar, char *buf)
> +{
> +	const struct aw_sar_diff_t *diff = p_sar->p_sar_para->p_diff;
> +	int diff_val;
> +	ssize_t len = 0;
> +	unsigned int data;
> +	int ret;
> +	unsigned int i;
> +
> +	if (!p_sar->p_sar_para->p_diff)
> +		return -EINVAL;
> +
> +	/* If a private interface is defined, the private interface is used */
> +	if (p_sar->p_sar_para->p_diff->p_get_diff_node_fn != NULL)
> +		return p_sar->p_sar_para->p_diff->p_get_diff_node_fn(p_sar, buf);
> +
> +	for (i = 0; i < p_sar->p_sar_para->ch_num_max; i++) {
> +		ret = aw_sar_i2c_read(p_sar->i2c, diff->diff0_reg + i * diff->diff_step, &data);
> +		if (ret != 0) {
> +			dev_err(p_sar->dev, "read diff err: %d", ret);
> +			return ret;
> +		}
> +		diff_val = (int)data / (int)diff->rm_float;
> +		len += snprintf(buf + len, PAGE_SIZE - len, "DIFF_CH%u = %d\n", i, diff_val);
> +	}
> +
> +	return len;
> +}
> +
> +
> +/* Print diff values of all channels of the chip. */
> +static ssize_t diff_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +
> +	return aw_sar_get_diff(p_sar, buf);
> +}
> +
> +/* Set the chip to enter different modes */
> +static ssize_t mode_operation_store(struct device *dev, struct device_attribute *attr,
> +						const char *buf, size_t count)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	unsigned int mode;
> +
> +	if (kstrtouint(buf, 0, &mode) != 0) {
> +		dev_err(p_sar->dev, "kstrtouint parse err");
> +		return count;
> +	}
> +	aw_sar_mode_set(p_sar, mode);
> +
> +	return count;
> +}
> +
> +/* Get the current mode of the chip */
> +static ssize_t mode_operation_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	ssize_t len = 0;
> +
> +	if (!p_sar->p_sar_para->p_mode)
> +		return len;
> +
> +	if (p_sar->p_sar_para->p_mode->p_get_mode_node_fn != NULL)
> +		len = p_sar->p_sar_para->p_mode->p_get_mode_node_fn(p_sar, buf);
> +
> +	return len;
> +}
> +
> +/* Print information related information */
> +static ssize_t chip_info_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	ssize_t len = 0;
> +
> +	len += snprintf(buf + len, PAGE_SIZE - len, "reg_load_state: %d\n", p_sar->ret_val);
> +
> +	if ((p_sar->p_sar_para->p_get_chip_info != NULL) &&
> +		(p_sar->p_sar_para->p_get_chip_info->p_get_chip_info_node_fn != NULL)) {
> +		p_sar->p_sar_para->p_get_chip_info->p_get_chip_info_node_fn(p_sar, buf, &len);
> +	}
> +
> +	return len;
> +}
> +
> +static ssize_t offset_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct aw_sar *p_sar = dev_get_drvdata(dev);
> +	ssize_t len = 0;
> +
> +	if ((p_sar->p_sar_para->p_offset != NULL) &&
> +		(p_sar->p_sar_para->p_offset->p_get_offset_node_fn != NULL))
> +		len = (ssize_t)p_sar->p_sar_para->p_offset->p_get_offset_node_fn(p_sar, buf);
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RW(awrw);
> +static DEVICE_ATTR_RW(reg);
> +static DEVICE_ATTR_WO(soft_rst);
> +static DEVICE_ATTR_WO(aot);
> +static DEVICE_ATTR_WO(update_reg);
> +static DEVICE_ATTR_RO(diff);
> +static DEVICE_ATTR_RW(mode_operation);
> +static DEVICE_ATTR_RO(chip_info);
> +static DEVICE_ATTR_RO(offset);
> +
> +static struct attribute *aw_sar_attributes[] = {
> +	&dev_attr_awrw.attr,
> +	&dev_attr_reg.attr,
> +	&dev_attr_soft_rst.attr,
> +	&dev_attr_aot.attr,
> +	&dev_attr_update_reg.attr,
> +	&dev_attr_diff.attr,
> +	&dev_attr_mode_operation.attr,
> +	&dev_attr_chip_info.attr,
> +	&dev_attr_offset.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group aw_sar_attribute_group = {
> +	.attrs = aw_sar_attributes,
> +};
> +
> +static void aw_sar_update_work(struct work_struct *work)
> +{
> +	struct aw_sar *p_sar = container_of(work, struct aw_sar, update_work.work);
> +	int ret;
> +
> +	mutex_lock(&aw_sar_lock);
> +
> +	/* 2.Parse the bin file and load the register configuration */
> +	ret = aw_sar_load_def_reg_bin(p_sar);
> +	if (ret != 0) {
> +		p_sar->ret_val = AW_REG_LOAD_ERR;
> +		dev_err(p_sar->dev, "reg_bin load err!");
> +		aw_sar_para_loaded(p_sar);
> +	}
> +
> +	/* 3.active chip */
> +	aw_sar_mode_set(p_sar, p_sar->p_sar_para->p_chip_mode->init_mode);
> +	if (p_sar->irq_init.host_irq_stat == IRQ_DISABLE) {
> +		enable_irq(p_sar->i2c->irq);
> +		p_sar->irq_init.host_irq_stat = IRQ_ENABLE;
> +	}
> +	p_sar->driver_code_initover_flag = 1;
> +	mutex_unlock(&aw_sar_lock);
> +}
> +
> +static void aw_sar_update(struct aw_sar *p_sar)
> +{
> +	if (!p_sar->p_sar_para->p_reg_bin)
> +		return;
> +
> +	if (p_sar->p_sar_para->p_reg_bin->p_update_fn != NULL)
> +		p_sar->p_sar_para->p_reg_bin->p_update_fn(p_sar);
> +
> +	if (p_sar->driver_code_initover_flag) {
> +		schedule_delayed_work(&p_sar->update_work, msecs_to_jiffies(0));
> +	} else {
> +		INIT_DELAYED_WORK(&p_sar->update_work, aw_sar_update_work);
> +		schedule_delayed_work(&p_sar->update_work,
> +				msecs_to_jiffies(AW_POWER_ON_SYSFS_DELAY_MS));
> +	}
> +}
> +
> +static int aw_sar_create_node(struct aw_sar *p_sar)
> +{
> +	int ret;
> +
> +	i2c_set_clientdata(p_sar->i2c, p_sar);
> +
> +	ret = sysfs_create_group(&p_sar->i2c->dev.kobj, &aw_sar_attribute_group);
> +
> +	/* Special requirements of SAR chip */
> +	if (p_sar->p_sar_para->p_platform_config->p_add_node_create_fn != NULL)
> +		ret |= p_sar->p_sar_para->p_platform_config->p_add_node_create_fn(p_sar);
> +
> +	return ret;
> +}
> +
> +static void aw_sar_node_free(struct aw_sar *p_sar)
> +{
> +	sysfs_remove_group(&p_sar->i2c->dev.kobj, &aw_sar_attribute_group);
> +
> +	/* Special requirements of SAR chip */
> +	if ((p_sar->p_sar_para->p_platform_config != NULL) &&
> +		(p_sar->p_sar_para->p_platform_config->p_add_node_free_fn != NULL))
> +		p_sar->p_sar_para->p_platform_config->p_add_node_free_fn(p_sar);
> +}
> +
> +/* The interrupt pin is set to internal pull-up start */
> +static void aw_sar_int_output(struct aw_sar *p_sar, int level)
> +{
> +	if (level == 0) {
> +		if (p_sar->pinctrl.pinctrl)
> +			pinctrl_select_state(p_sar->pinctrl.pinctrl, p_sar->pinctrl.int_out_low);
> +		else
> +			dev_err(p_sar->dev, "Failed set int pin output low\n");
> +	} else if (level == 1) {
> +		if (p_sar->pinctrl.pinctrl)
> +			pinctrl_select_state(p_sar->pinctrl.pinctrl, p_sar->pinctrl.int_out_high);
> +		else
> +			dev_err(p_sar->dev, "Failed set int pin output high\n");
> +	}
> +}
> +
> +static int aw_sar_pinctrl_init(struct aw_sar *p_sar)
> +{
> +	struct aw_sar_pinctrl *pinctrl = &p_sar->pinctrl;
> +	unsigned char pin_default_name[50] = { 0 };
> +	unsigned char pin_output_low_name[50] = { 0 };
> +	unsigned char pin_output_high_name[50] = { 0 };
> +
> +	pinctrl->pinctrl = devm_pinctrl_get(p_sar->dev);
> +	if (IS_ERR_OR_NULL(pinctrl->pinctrl)) {
> +		dev_err(p_sar->dev, "No pinctrl found\n");
> +		pinctrl->pinctrl = NULL;
> +		return -EINVAL;
> +	}
> +
> +	snprintf(pin_default_name, sizeof(pin_default_name),
> +					"aw_default_sar%u", p_sar->dts_info.sar_num);
> +	pinctrl->default_sta = pinctrl_lookup_state(pinctrl->pinctrl, pin_default_name);
> +	if (IS_ERR_OR_NULL(pinctrl->default_sta)) {
> +		dev_err(p_sar->dev, "Failed get pinctrl state:default state");
> +		goto exit_pinctrl_init;
> +	}
> +
> +	snprintf(pin_output_high_name, sizeof(pin_output_high_name),
> +				"aw_int_output_high_sar%u", p_sar->dts_info.sar_num);
> +	pinctrl->int_out_high = pinctrl_lookup_state(pinctrl->pinctrl, pin_output_high_name);
> +	if (IS_ERR_OR_NULL(pinctrl->int_out_high)) {
> +		dev_err(p_sar->dev, "Failed get pinctrl state:output_high");
> +		goto exit_pinctrl_init;
> +	}
> +
> +	snprintf(pin_output_low_name, sizeof(pin_output_low_name),
> +				"aw_int_output_low_sar%u", p_sar->dts_info.sar_num);
> +	pinctrl->int_out_low = pinctrl_lookup_state(pinctrl->pinctrl, pin_output_low_name);
> +	if (IS_ERR_OR_NULL(pinctrl->int_out_low)) {
> +		dev_err(p_sar->dev, "Failed get pinctrl state:output_low");
> +		goto exit_pinctrl_init;
> +	}
> +
> +	return 0;
> +
> +exit_pinctrl_init:
> +	devm_pinctrl_put(pinctrl->pinctrl);
> +	pinctrl->pinctrl = NULL;
> +
> +	return -EINVAL;
> +}
> +
> +static void aw_sar_pinctrl_deinit(struct aw_sar *p_sar)
> +{
> +	if (p_sar->pinctrl.pinctrl)
> +		devm_pinctrl_put(p_sar->pinctrl.pinctrl);
> +}
> +/* The interrupt pin is set to internal pull-up end */
> +
> +/* AW_SAR_REGULATOR_POWER_ON start */
> +static int aw_sar_regulator_power_init(struct aw_sar *p_sar)
> +{
> +	unsigned char vcc_name[20] = { 0 };
> +	int rc;
> +
> +	snprintf(vcc_name, sizeof(vcc_name), "vcc%u", p_sar->dts_info.sar_num);
> +	p_sar->vcc = regulator_get(p_sar->dev, vcc_name);
> +	if (IS_ERR(p_sar->vcc)) {
> +		rc = PTR_ERR(p_sar->vcc);
> +		dev_err(p_sar->dev, "regulator get failed vcc rc = %d", rc);
> +		return rc;
> +	}
> +
> +	if (regulator_count_voltages(p_sar->vcc) > 0) {
> +		rc = regulator_set_voltage(p_sar->vcc, AW_SAR_VCC_MIN_UV, AW_SAR_VCC_MAX_UV);

It's pretty rare to see a driver enforcing regulator constraints.  Normally we just
leave that to the firmware. Do you have a particular reason to do this here?

> +		if (rc) {
> +			dev_err(p_sar->dev, "regulator set vol failed rc = %d", rc);
> +			goto reg_vcc_put;
> +		}
> +	}
> +
> +	return 0;
> +
> +reg_vcc_put:
> +	regulator_put(p_sar->vcc);
> +	return rc;
> +}
> +
> +static void aw_sar_power_deinit(struct aw_sar *p_sar)
> +{
> +	if (p_sar->power_enable) {
> +		/*
> +		 * Turn off the power output. However,
> +		 * it may not be turned off immediately
> +		 * There are scenes where power sharing can exist
> +		 */
> +		regulator_disable(p_sar->vcc);
> +		regulator_put(p_sar->vcc);
> +	}
> +}
> +
> +static void aw_sar_power_enable(struct aw_sar *p_sar, bool on)
> +{
> +	int rc;
> +
> +	if (on) {
> +		rc = regulator_enable(p_sar->vcc);
> +		if (rc) {
> +			dev_err(p_sar->dev, "regulator_enable vol failed rc = %d", rc);
> +		} else {
> +			p_sar->power_enable = AW_TRUE;
> +			msleep(20);
> +		}
> +	} else {
> +		rc = regulator_disable(p_sar->vcc);
> +		if (rc)
> +			dev_err(p_sar->dev, "regulator_disable vol failed rc = %d", rc);
> +		else
> +			p_sar->power_enable = AW_FALSE;
> +	}
> +}
> +
> +static int regulator_is_get_voltage(struct aw_sar *p_sar)
> +{
> +	unsigned int cnt = 10;
> +	int voltage_val;
> +
> +	while (cnt--) {
> +		voltage_val = regulator_get_voltage(p_sar->vcc);
> +		if (voltage_val >= AW_SAR_VCC_MIN_UV)
> +			return 0;
> +		mdelay(1);
> +	}
> +	/* Ensure that the chip initialization is completed */
> +	msleep(20);
> +
> +	return -EINVAL;
> +}
> +/* AW_SAR_REGULATOR_POWER_ON end */
> +
> +static void aw_sar_init_lock(struct aw_sar *p_sar)
> +{
> +	/* Initialize lock, To protect the thread safety of updating bin file */
> +	mutex_init(&aw_sar_lock);
> +	/* Required for mode setting */
> +	p_sar->last_mode = p_sar->p_sar_para->p_chip_mode->pre_init_mode;
> +	p_sar->fw_fail_flag = AW_FALSE;
> +	p_sar->ret_val = 0;
> +}
> +
> +/* AW_SAR_USB_PLUG_CAIL start */
> +static void aw_sar_ps_notify_callback_work(struct work_struct *work)
> +{
> +	struct aw_sar *p_sar = container_of(work, struct aw_sar, ps_notify_work);
> +
> +	aw_sar_aot(p_sar);
> +}
> +
> +static int aw_sar_ps_get_state(struct aw_sar *p_sar, struct power_supply *psy, bool *present)
> +{
> +	union power_supply_propval pval = { 0 };
> +	int retval;
> +
> +	retval = power_supply_get_property(psy, AW_USB_PROP_ONLINE, &pval);
> +	if (retval) {
> +		dev_err(p_sar->dev, "%s psy get property failed", psy->desc->name);
> +		return retval;
> +	}
> +	*present = (pval.intval) ? true : false;
> +
> +	return 0;
> +}
> +
> +static int aw_sar_ps_notify_callback(struct notifier_block *self,
> +		unsigned long event, void *p)
> +{
> +	struct aw_sar *p_sar = container_of(self, struct aw_sar, ps_notif);
> +	struct power_supply *psy = p;
> +	bool present;
> +	int retval;
> +
> +	if (event == PSY_EVENT_PROP_CHANGED
> +		&& psy && psy->desc->get_property && psy->desc->name &&
> +		!strncmp(psy->desc->name, USB_POWER_SUPPLY_NAME,
> +			sizeof(USB_POWER_SUPPLY_NAME))) {
> +		retval = aw_sar_ps_get_state(p_sar, psy, &present);
> +		if (retval) {
> +			dev_err(p_sar->dev, "psy get property failed");
> +			return retval;
> +		}
> +		if (event == PSY_EVENT_PROP_CHANGED) {
> +			if (p_sar->ps_is_present == present)
> +				return 0;
> +		}
> +		p_sar->ps_is_present = present;
> +		schedule_work(&p_sar->ps_notify_work);
> +	}
> +	return 0;
> +}
> +
> +static int aw_sar_ps_notify_init(struct aw_sar *p_sar)
> +{
> +	struct power_supply *psy;
> +	int ret;
> +
> +	INIT_WORK(&p_sar->ps_notify_work, aw_sar_ps_notify_callback_work);
> +	p_sar->ps_notif.notifier_call = (notifier_fn_t)aw_sar_ps_notify_callback;
> +	ret = power_supply_reg_notifier(&p_sar->ps_notif);
> +	if (ret) {
> +		dev_err(p_sar->dev, "Unable to register ps_notifier: %d", ret);
> +		return ret;
> +	}
> +	psy = power_supply_get_by_name(USB_POWER_SUPPLY_NAME);
> +	if (!psy) {
> +		dev_err(p_sar->dev, "Unable to get power_supply: %s", USB_POWER_SUPPLY_NAME);
> +		goto free_ps_notifier;
> +	}
> +	ret = aw_sar_ps_get_state(p_sar, psy, &p_sar->ps_is_present);
> +	if (ret) {
> +		dev_err(p_sar->dev, "psy get property failed rc=%d", ret);
> +		goto free_ps_notifier;
> +	}
> +	return 0;
> +
> +free_ps_notifier:
> +	power_supply_unreg_notifier(&p_sar->ps_notif);
> +
> +	return -EINVAL;
> +}
> +/* AW_SAR_USB_PLUG_CAIL end */
> +
> +static int aw_sar_platform_rsc_init(struct aw_sar *p_sar)
> +{
> +	int ret;
> +
> +	if (!p_sar->p_sar_para->p_platform_config)
> +		return -EINVAL;
> +
> +	/* step 1.parsing dts data */
> +	ret = aw_sar_parse_dts(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "parse dts error!");
> +		return ret;
> +	}
> +
> +	/* Initialization lock and some variables */
> +	aw_sar_init_lock(p_sar);
> +
> +	/*
> +	 * Configure whether to use USB plug-in calibration in DTS
> +	 * according to customer requirements
> +	 */
> +	if (p_sar->dts_info.use_plug_cail_flag == true) {
> +		ret = aw_sar_ps_notify_init(p_sar);
> +		if (ret < 0) {
> +			dev_err(p_sar->dev, "error creating power supply notify");
> +			goto err_ps_notify_init;
> +		}
> +	}
> +
> +	/* The interrupt pin is set to internal pull-up and configured by DTS */
> +	if (p_sar->dts_info.use_inter_pull_up == true) {
> +		ret = aw_sar_pinctrl_init(p_sar);
> +		if (ret < 0) {
> +			/*
> +			 * if define pinctrl must define the following state
> +			 * to let int-pin work normally: default, int_output_high,
> +			 * int_output_low, int_input
> +			 */
> +			dev_err(p_sar->dev, "Failed get wanted pinctrl state");
> +			goto err_pinctrl_init;
> +		}
> +		aw_sar_int_output(p_sar, 1);
> +	}
> +
> +	/* step 2.Create debug file node */
> +	ret = aw_sar_create_node(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "create node error!");
> +		goto err_sysfs_nodes;
> +	}
> +
> +	/* step 3.Initialization interrupt */
> +	ret = aw_sar_irq_init(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "interrupt initialization error!");
> +		goto err_irq_init;
> +	}
> +
> +	/* step 4.Initialization iio Subsystem */
> +	ret = aw_sar_iio_init(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "iio_init error!");
> +		goto err_iio_init;
> +	}
> +
> +	return 0;
> +
> +err_iio_init:
> +	aw_sar_irq_free(p_sar);
> +err_irq_init:
> +	aw_sar_node_free(p_sar);
> +err_sysfs_nodes:
> +	if (p_sar->dts_info.use_inter_pull_up == true)
> +		aw_sar_pinctrl_deinit(p_sar);
> +err_pinctrl_init:
> +	if (p_sar->dts_info.use_plug_cail_flag == true)
> +		power_supply_unreg_notifier(&p_sar->ps_notif);
> +err_ps_notify_init:
> +	mutex_destroy(&aw_sar_lock);
> +
> +	return ret;
> +}
> +
> +static int aw_sar_chip_init(struct aw_sar *p_sar)
> +{
> +	int ret;
> +
> +	/* step 1.check chipid,Verify whether the chip communication is successful */
> +	ret = aw_sar_check_chipid(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "check_chipid error!");
> +		goto communication_fail;
> +	}
> +
> +	/* step 2.Check chip initialization completed, */
> +	ret = aw_sar_soft_reset(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "soft_reset error!");
> +		goto communication_fail;
> +	}
> +
> +	ret = aw_sar_check_init_over_irq(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "check_init_over_irqt error!");
> +		goto communication_fail;
> +	}
> +
> +	/* step 3.chip other operation */
> +	ret = aw_sar_chip_other_operation(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "chip_other_operation error!");
> +		goto free_other_opera;
> +	}
> +
> +	/* step 4.Parse the bin file, upgrade the firmware, and load the register prize */
> +	aw_sar_update(p_sar);
> +
> +	return 0;
> +
> +free_other_opera:
> +	aw_sar_chip_other_operation_free(p_sar);
> +communication_fail:
> +
> +	return ret;
> +}
> +
> +static int aw_sar_init(struct aw_sar *p_sar)
> +{
> +	int ret;
> +
> +	/* step 1: Platform resource initialization */
> +	ret = aw_sar_platform_rsc_init(p_sar);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "platform_rsc_init error!");
> +		return ret;
> +	}
> +
> +	/* step 2: Chip initialization */
> +	ret = aw_sar_chip_init(p_sar);
> +	if (ret != 0) {
> +		aw_sar_irq_free(p_sar);
> +		aw_sar_node_free(p_sar);
> +		if (p_sar->dts_info.use_inter_pull_up == true)
> +			aw_sar_pinctrl_deinit(p_sar);
> +		if (p_sar->dts_info.use_plug_cail_flag == true)
> +			power_supply_unreg_notifier(&p_sar->ps_notif);
> +		mutex_destroy(&aw_sar_lock);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw_sar_regulator_power(struct aw_sar *p_sar)
> +{
> +	struct aw_sar_dts_info *p_dts_info = &p_sar->dts_info;
> +	int ret = 0;
> +
> +	p_dts_info->use_regulator_flag =
> +		of_property_read_bool(p_sar->i2c->dev.of_node, "awinic,regulator-power-supply");
> +
> +	/* Configure the use of regulator power supply in DTS */
> +	if (p_sar->dts_info.use_regulator_flag == true) {
> +		ret = aw_sar_regulator_power_init(p_sar);
> +		if (ret != 0) {
> +			dev_err(p_sar->dev, "power init failed");
> +			return ret;
> +		}
> +		aw_sar_power_enable(p_sar, AW_TRUE);
> +		ret = regulator_is_get_voltage(p_sar);
> +		if (ret != 0) {
> +			dev_err(p_sar->dev, "get_voltage failed");
> +			aw_sar_power_deinit(p_sar);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int aw_sar_get_chip_info(struct aw_sar *p_sar)
> +{
> +	int ret;
> +	unsigned char i;
> +
> +	for (i = 0; i < AW_SAR_DRIVER_MAX; i++) {
> +		if (g_aw_sar_driver_list[i].p_who_am_i != NULL) {
> +			ret = g_aw_sar_driver_list[i].p_who_am_i(p_sar);
> +			if (ret == 0) {
> +				p_sar->curr_use_driver_type = g_aw_sar_driver_list[i].driver_type;
> +				if (!g_aw_sar_driver_list[i].p_chip_init) {
> +					dev_err(p_sar->dev,
> +							"drvier:%d p_chip_init is null error!", i);
> +					continue;
> +				}
> +				g_aw_sar_driver_list[i].p_chip_init(p_sar);
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void aw_sar_monitor_work(struct work_struct *aw_work)
> +{
> +	struct aw_sar *p_sar = container_of(aw_work, struct aw_sar, monitor_work.work);
> +	unsigned int data;
> +	int ret;
> +
> +	ret = aw_sar_i2c_read(p_sar->i2c, 0x0000, &data);
> +	if (ret != 0) {
> +		dev_err(p_sar->dev, "read 0x0000 err: %d", ret);
> +		return;
> +	}
> +	if (data == 0 && p_sar->driver_code_initover_flag) {
> +		dev_err(p_sar->dev, "aw_chip may reset");
> +		aw_sar_disable_irq(p_sar);
> +		ret = aw_sar_chip_init(p_sar);
> +		if (ret != 0)
> +			return;
> +	}
> +	queue_delayed_work(p_sar->monitor_wq, &p_sar->monitor_work,
> +			msecs_to_jiffies(AW_SAR_MONITOR_ESD_DELAY_MS));
> +}
> +
> +static int aw_sar_monitor_esd_init(struct aw_sar *p_sar)
> +{
> +	p_sar->monitor_wq = create_singlethread_workqueue("aw_sar_workqueue");
> +	if (!p_sar->monitor_wq) {
> +		dev_err(&p_sar->i2c->dev, "aw_sar_workqueue error");
> +		return -EINVAL;
> +	}
> +	INIT_DELAYED_WORK(&p_sar->monitor_work, aw_sar_monitor_work);
> +	queue_delayed_work(p_sar->monitor_wq, &p_sar->monitor_work,
> +			msecs_to_jiffies(AW_SAR_MONITOR_ESD_DELAY_MS));
> +
> +	return 0;
> +}
> +
> +static void aw_sar_sensor_free(struct aw_sar *p_sar)
> +{
> +	if (g_aw_sar_driver_list[p_sar->curr_use_driver_type].p_chip_deinit != NULL)
> +		g_aw_sar_driver_list[p_sar->curr_use_driver_type].p_chip_deinit(p_sar);
> +}
> +
> +
> +/* Drive logic entry */
> +static int aw_sar_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct iio_dev *sar_iio_dev;
> +	struct aw_sar *p_sar;
> +	int ret;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> +		pr_err("check_functionality failed!\n");
> +		return -EIO;
> +	}
> +
> +	sar_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*p_sar));
> +	if (!sar_iio_dev)
> +		return -ENOMEM;
> +	p_sar = iio_priv(sar_iio_dev);
> +	p_sar->aw_iio_dev = sar_iio_dev;
> +	p_sar->dev = &i2c->dev;
> +	p_sar->i2c = i2c;
> +	i2c_set_clientdata(i2c, p_sar);
> +
> +	/* 1.Judge whether to use regular power supply. If yes, supply power */
> +	ret = aw_sar_regulator_power(p_sar);
> +	if (ret != 0) {
> +		dev_err(&i2c->dev, "regulator_power error!");
> +		return ret;
> +	}
> +
> +	/* 2.Get chip initialization resources */
> +	ret = aw_sar_get_chip_info(p_sar);
> +	if (ret != 0) {
> +		dev_err(&i2c->dev, "chip_init error!");
> +		goto err_chip_init;
> +	}
> +
> +	/* 3.Chip initialization process */
> +	ret = aw_sar_init(p_sar);
> +	if (ret != 0) {
> +		dev_err(&i2c->dev, "sar_init error!");
> +		goto err_sar_init;
> +	}
> +
> +	if (p_sar->dts_info.monitor_esd_flag) {
> +		ret = aw_sar_monitor_esd_init(p_sar);
> +		if (ret != 0) {
> +			dev_err(&i2c->dev, "monitor_esd_init error!");
> +			goto err_esd_init;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_esd_init:
> +	aw_sar_irq_free(p_sar);
> +	aw_sar_node_free(p_sar);
> +	if (p_sar->dts_info.use_inter_pull_up == true)
> +		aw_sar_pinctrl_deinit(p_sar);
> +	if (p_sar->dts_info.use_plug_cail_flag == true)
> +		power_supply_unreg_notifier(&p_sar->ps_notif);
> +	mutex_destroy(&aw_sar_lock);
> +err_sar_init:
> +	aw_sar_sensor_free(p_sar);
> +err_chip_init:
> +	if (p_sar->dts_info.use_regulator_flag == true)
> +		aw_sar_power_deinit(p_sar);
> +
> +	return ret;
> +}
> +
> +static void aw_sar_i2c_remove(struct i2c_client *i2c)
> +{
> +	struct aw_sar *p_sar = i2c_get_clientdata(i2c);
> +
> +	aw_sar_chip_other_operation_free(p_sar);
> +
> +	aw_sar_node_free(p_sar);
> +
> +	aw_sar_irq_free(p_sar);
> +
> +	if (p_sar->dts_info.use_inter_pull_up == true)
> +		aw_sar_pinctrl_deinit(p_sar);
> +
> +	if (p_sar->dts_info.use_regulator_flag == true)
> +		aw_sar_power_deinit(p_sar);
> +
> +	if (p_sar->dts_info.use_plug_cail_flag == true)
> +		power_supply_unreg_notifier(&p_sar->ps_notif);
> +
> +	aw_sar_sensor_free(p_sar);
> +}
> +
> +static int aw_sar_suspend(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct aw_sar *p_sar = i2c_get_clientdata(client);
> +
> +	if (p_sar->dts_info.use_pm == true) {
> +		if ((!p_sar->p_sar_para->p_platform_config) ||
> +			(!p_sar->p_sar_para->p_platform_config->p_pm_chip_mode))
> +			return 0;
> +		if (p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->p_suspend_fn) {
> +			p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->p_suspend_fn(p_sar);
> +			return 0;
> +		}
> +		aw_sar_mode_set(p_sar,
> +			p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->suspend_set_mode);
> +	}
> +
> +	if (p_sar->dts_info.monitor_esd_flag)
> +		cancel_delayed_work_sync(&p_sar->monitor_work);
> +
> +	return 0;
> +}
> +
> +static int aw_sar_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct aw_sar *p_sar = i2c_get_clientdata(client);
> +
> +	if (p_sar->dts_info.use_pm == true) {
> +		if ((!p_sar->p_sar_para->p_platform_config) ||
> +			(!p_sar->p_sar_para->p_platform_config->p_pm_chip_mode))
> +			return 0;
> +		if (p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->p_resume_fn) {
> +			p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->p_resume_fn(p_sar);
> +			return 0;
> +		}
> +		aw_sar_mode_set(p_sar,
> +			p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->resume_set_mode);
> +	}
> +
> +	if (p_sar->dts_info.monitor_esd_flag)
> +		queue_delayed_work(p_sar->monitor_wq, &p_sar->monitor_work,
> +				msecs_to_jiffies(AW_SAR_MONITOR_ESD_DELAY_MS));
> +
> +	return 0;
> +}
> +
> +static void aw_sar_i2c_shutdown(struct i2c_client *i2c)
> +{
> +	struct aw_sar *p_sar = i2c_get_clientdata(i2c);
> +
> +	if ((!p_sar->p_sar_para->p_platform_config) ||
> +		(!p_sar->p_sar_para->p_platform_config->p_pm_chip_mode))
> +		return;
> +
> +	if (p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->p_shutdown_fn) {
> +		p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->p_shutdown_fn(p_sar);
> +		return;
> +	}
> +
> +	aw_sar_mode_set(p_sar,
> +		p_sar->p_sar_para->p_platform_config->p_pm_chip_mode->shutdown_set_mode);
> +}
> +
> +static const struct dev_pm_ops aw_sar_pm_ops = {
> +	.suspend = aw_sar_suspend,
> +	.resume = aw_sar_resume,
> +};
> +
> +static const struct of_device_id aw_sar_dt_match[] = {
> +	{ .compatible = "awinic,aw96103" },
> +	{ .compatible = "awinic,aw96105" },
> +	{ .compatible = "awinic,aw96303" },
> +	{ .compatible = "awinic,aw96305" },
> +	{ .compatible = "awinic,aw96308" },
> +	{ },
> +};
> +
> +static const struct i2c_device_id aw_sar_i2c_id[] = {
> +	{ AW_SAR_I2C_NAME, 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(i2c, aw_sar_i2c_id);
> +
> +static struct i2c_driver aw_sar_i2c_driver = {
> +	.driver = {
> +		.name = AW_SAR_I2C_NAME,
> +		.of_match_table = aw_sar_dt_match,
> +		.pm = &aw_sar_pm_ops,
> +	},
> +	.probe = aw_sar_i2c_probe,
> +	.remove = aw_sar_i2c_remove,
> +	.shutdown = aw_sar_i2c_shutdown,
> +	.id_table = aw_sar_i2c_id,
> +};
> +module_i2c_driver(aw_sar_i2c_driver);
> +
> +MODULE_DESCRIPTION("AWINIC SAR Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(AWINIC_PROX);
> diff --git a/drivers/iio/proximity/aw_sar.h b/drivers/iio/proximity/aw_sar.h
> new file mode 100644
> index 000000000000..43abf1fdc19d
> --- /dev/null
> +++ b/drivers/iio/proximity/aw_sar.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _AW_SAR_H_
> +#define _AW_SAR_H_
> +#include "aw_sar_type.h"
> +
> +enum aw_sar_driver_list_t {
> +	AW_SAR_AW9610X,
> +	AW_SAR_AW963XX,
> +
> +	AW_SAR_DRIVER_MAX,
> +};
> +
> +int aw9610x_check_chipid(void *data);
> +int aw9610x_init(struct aw_sar *p_sar);
> +void aw9610x_deinit(struct aw_sar *p_sar);
> +
> +int aw963xx_check_chipid(void *data);
> +int aw963xx_init(struct aw_sar *p_sar);
> +void aw963xx_deinit(struct aw_sar *p_sar);
> +
> +
> +
> +#endif
> diff --git a/drivers/iio/proximity/aw_sar_comm_interface.c b/drivers/iio/proximity/aw_sar_comm_interface.c
> new file mode 100644
> index 000000000000..8a7d437d100b
> --- /dev/null
> +++ b/drivers/iio/proximity/aw_sar_comm_interface.c
> @@ -0,0 +1,550 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "aw_sar_comm_interface.h"
> +
> +#define AW_I2C_RW_RETRY_TIME_MIN		(2000)
> +#define AW_I2C_RW_RETRY_TIME_MAX		(3000)
> +#define AW_RETRIES				(5)
> +
> +static int awinic_i2c_write(struct i2c_client *i2c, unsigned char *tr_data, unsigned short len)
> +{
> +	struct i2c_msg msg;
> +
> +	msg.addr = i2c->addr;
> +	msg.flags = 0;
> +	msg.len = len;
> +	msg.buf = tr_data;
> +
> +	return i2c_transfer(i2c->adapter, &msg, 1);

Looks like i2c_master_send() 

Use that inline rather than having your own version.

> +}
> +
> +static int awinic_i2c_read(struct i2c_client *i2c, unsigned char *addr,
> +				unsigned char addr_len, unsigned char *data, unsigned short data_len)
Why would a length be a char?  u8 maybe.
Also data as u8 not char. 
> +{
> +	struct i2c_msg msg[2];
> +
> +	msg[0].addr = i2c->addr;
> +	msg[0].flags = 0;
> +	msg[0].len = addr_len;
> +	msg[0].buf = addr;
> +
> +	msg[1].addr = i2c->addr;
> +	msg[1].flags = 1;
> +	msg[1].len = data_len;
> +	msg[1].buf = data;
> +
> +	return i2c_transfer(i2c->adapter, msg, 2);
> +}
> +
> +int aw_sar_i2c_read(struct i2c_client *i2c, unsigned short reg_addr16, unsigned int *reg_data32)
> +{
> +	unsigned char r_buf[6] = { 0 };
> +	unsigned char cnt = 5;
> +	int ret;
> +
> +	if (!i2c)
> +		return -EINVAL;
> +
> +	r_buf[0] = (unsigned char)(reg_addr16 >> OFFSET_BIT_8);
> +	r_buf[1] = (unsigned char)(reg_addr16);

put_unaligned_be16()

> +
> +	do {
> +		ret = awinic_i2c_read(i2c, r_buf, 2, &r_buf[2], 4);
Use two buffers as easeir to read and you can type them correctly as __be16 and
__be32 I think.

> +		if (ret < 0)
> +			dev_err(&i2c->dev, "i2c read error reg: 0x%04x, ret= %d cnt= %d",
> +					reg_addr16, ret, cnt);
> +		else
> +			break;
> +		usleep_range(2000, 3000);

Any retry needs documentation on why it might be necessary + why these values.

> +	} while (cnt--);
> +
> +	if (cnt < 0) {
> +		dev_err(&i2c->dev, "i2c read error!");
> +		return ret;
> +	}
> +
> +	*reg_data32 = ((unsigned int)r_buf[5] << OFFSET_BIT_0) | ((unsigned int)r_buf[4] << OFFSET_BIT_8) |
> +		((unsigned int)r_buf[3] << OFFSET_BIT_16) | ((unsigned int)r_buf[2] << OFFSET_BIT_24);
get_unaligned_be32()
or be32_to_cpu() if you use a __be32 as the buffer in the first place
> +
> +	return 0;
> +}
> +
> +int aw_sar_i2c_write(struct i2c_client *i2c, unsigned short reg_addr16, unsigned int reg_data32)

u16 and u32 to get kernel fixed width types.


> +{
> +	unsigned char w_buf[6] = { 0 };
You fill it all so don't initialize.

> +	unsigned char cnt = 5;
> +	int ret;
> +
> +	if (!i2c)
> +		return -EINVAL;
> +
> +	/* reg_addr */
> +	w_buf[0] = (unsigned char)(reg_addr16 >> OFFSET_BIT_8);
> +	w_buf[1] = (unsigned char)(reg_addr16);

put_unaligned_be16()

> +	/* data */
> +	w_buf[2] = (unsigned char)(reg_data32 >> OFFSET_BIT_24);
> +	w_buf[3] = (unsigned char)(reg_data32 >> OFFSET_BIT_16);
> +	w_buf[4] = (unsigned char)(reg_data32 >> OFFSET_BIT_8);
> +	w_buf[5] = (unsigned char)(reg_data32);
put_unaligned_be32() or similar.

> +
> +	do {
> +		ret = awinic_i2c_write(i2c, w_buf, ARRAY_SIZE(w_buf));
> +		if (ret < 0) {
> +			dev_err(&i2c->dev,
> +					"i2c write error reg: 0x%04x data: 0x%08x, ret= %d cnt= %d",
> +					reg_addr16, reg_data32, ret, cnt);
> +		} else {
> +			break;
> +		}
> +	} while (cnt--);
Why are retries needed?  Very unlikely that they are on a sensible circuit board.
Prefer to just report an error to the caller if one occurs rather than try again.

> +
> +	if (cnt < 0) {
> +		dev_err(&i2c->dev, "i2c write error!");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int
> +aw_sar_i2c_write_bits(struct i2c_client *i2c, unsigned short reg_addr16, unsigned int mask, unsigned int val)
> +{
> +	unsigned int reg_val;
> +
> +	aw_sar_i2c_read(i2c, reg_addr16, &reg_val);
> +	reg_val &= mask;
> +	reg_val |= (val & (~mask));
> +	aw_sar_i2c_write(i2c, reg_addr16, reg_val);

May well makes sense to use a custom regmap as then you will get all this stuff for
free.

> +
> +	return 0;
> +}
> +
> +int aw_sar_i2c_write_seq(struct i2c_client *i2c, unsigned char *tr_data, unsigned short len)
> +{
> +	unsigned char cnt = AW_RETRIES;
> +	int ret;
> +
> +	do {
> +		ret = awinic_i2c_write(i2c, tr_data, len);
> +		if (ret < 0)
> +			dev_err(&i2c->dev, "awinic i2c write seq error %d", ret);
> +		else
> +			break;
> +		usleep_range(AW_I2C_RW_RETRY_TIME_MIN, AW_I2C_RW_RETRY_TIME_MAX);
> +	} while (cnt--);

As above. Why retries?

> +
> +	if (cnt < 0) {
> +		dev_err(&i2c->dev, "awinic i2c write error!");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int aw_sar_i2c_read_seq(struct i2c_client *i2c, unsigned char *addr,
> +				unsigned char addr_len, unsigned char *data, unsigned short data_len)
> +{
> +	unsigned char cnt = AW_RETRIES;
> +	int ret;
> +
> +	do {
> +		ret = awinic_i2c_read(i2c, addr, addr_len, data, data_len);
> +		if (ret < 0)
> +			dev_err(&i2c->dev, "awinic sar i2c write error %d", ret);
> +		else
> +			break;
> +		usleep_range(AW_I2C_RW_RETRY_TIME_MIN, AW_I2C_RW_RETRY_TIME_MAX);
> +	} while (cnt--);
> +
> +	if (cnt < 0) {
> +		dev_err(&i2c->dev, "awinic sar i2c read error!");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +enum bin_header_version_enum {
> +	HEADER_VERSION_1_0_0 = 0x01000000,
> +};
> +
> +enum data_type_enum {
> +	DATA_TYPE_REGISTER = 0x00000000,
> +	DATA_TYPE_DSP_REG = 0x00000010,
> +	DATA_TYPE_DSP_CFG = 0x00000011,
> +	DATA_TYPE_SOC_REG = 0x00000020,
> +	DATA_TYPE_SOC_APP = 0x00000021,
> +	DATA_TYPE_MULTI_BINS = 0x00002000,
> +};
> +
> +#define BigLittleSwap16(A)	((((unsigned short int)(A) & 0xff00) >> 8) | \
> +				(((unsigned short int)(A) & 0x00ff) << 8))
Why?  We have standard functions for this swab16()

> +
> +#define BigLittleSwap32(A)	((((unsigned long)(A) & 0xff000000) >> 24) | \
> +				(((unsigned long)(A) & 0x00ff0000) >> 8) | \
> +				(((unsigned long)(A) & 0x0000ff00) << 8) | \
> +				(((unsigned long)(A) & 0x000000ff) << 24))
swab32()

> +
> +static enum aw_bin_err_val aw_parse_bin_header_1_0_0(struct aw_bin *bin);
> +
> +static enum aw_bin_err_val aw_check_sum(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned char *p_check_sum;
> +	unsigned int sum_data = 0;
> +	unsigned int check_sum;
> +	unsigned int i;
> +
> +	p_check_sum = &(bin->info.data[(bin->header_info[bin_num].valid_data_addr -
> +			bin->header_info[bin_num].header_len)]);
> +	check_sum = AW_SAR_GET_32_DATA(*(p_check_sum + 3), *(p_check_sum + 2),
> +				*(p_check_sum + 1), *(p_check_sum));
> +
> +	for (i = 4; i < bin->header_info[bin_num].bin_data_len +
> +			bin->header_info[bin_num].header_len; i++)
> +		sum_data += *(p_check_sum + i);
> +
> +	if (sum_data != check_sum) {
> +		p_check_sum = NULL;
> +		return AW_BIN_ERROR_SUM_OR_DATA_LEN;
> +	}
> +	p_check_sum = NULL;
> +
> +	return AW_BIN_ERROR_NONE;
> +}
> +
> +static enum aw_bin_err_val aw_check_register_num_v1(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned int check_register_num;
> +	unsigned int parse_register_num;
> +	char *p_check_sum;
> +
> +	p_check_sum =
> +		&(bin->info.data[(bin->header_info[bin_num].valid_data_addr)]);
> +	parse_register_num = AW_SAR_GET_32_DATA(*(p_check_sum + 3), *(p_check_sum + 2),
> +					*(p_check_sum + 1), *(p_check_sum));
> +	check_register_num = (bin->header_info[bin_num].bin_data_len - 4) /
> +				(bin->header_info[bin_num].reg_byte_len +
> +				bin->header_info[bin_num].data_byte_len);
> +	if (parse_register_num != check_register_num) {
> +		p_check_sum = NULL;
> +		return AW_BIN_ERROR_REGISTER_NUM;
> +	}
> +	bin->header_info[bin_num].reg_num = parse_register_num;
> +	bin->header_info[bin_num].valid_data_len = bin->header_info[bin_num].bin_data_len - 4;
> +	p_check_sum = NULL;
> +	bin->header_info[bin_num].valid_data_addr =
> +		bin->header_info[bin_num].valid_data_addr + 4;
> +
> +	return AW_BIN_ERROR_NONE;
> +}
> +
> +static enum aw_bin_err_val aw_check_dsp_reg_num_v1(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned int check_dsp_reg_num;
> +	unsigned int parse_dsp_reg_num;
> +	char *p_check_sum;
> +
> +	p_check_sum =
> +		&(bin->info.data[(bin->header_info[bin_num].valid_data_addr)]);
> +	parse_dsp_reg_num = AW_SAR_GET_32_DATA(*(p_check_sum + 7),
> +					*(p_check_sum + 6),
> +					*(p_check_sum + 5),
> +					*(p_check_sum + 4));
> +	bin->header_info[bin_num].reg_data_byte_len =
> +		AW_SAR_GET_32_DATA(*(p_check_sum + 11), *(p_check_sum + 10),
> +			*(p_check_sum + 9), *(p_check_sum + 8));
> +	check_dsp_reg_num = (bin->header_info[bin_num].bin_data_len -
> +				12) / bin->header_info[bin_num].reg_data_byte_len;
> +	if (parse_dsp_reg_num != check_dsp_reg_num) {
> +		p_check_sum = NULL;
> +		return AW_BIN_ERROR_DSP_REG_NUM;
> +	}
> +	bin->header_info[bin_num].download_addr =
> +		AW_SAR_GET_32_DATA(*(p_check_sum + 3), *(p_check_sum + 2),
> +			*(p_check_sum + 1), *(p_check_sum));
> +	bin->header_info[bin_num].reg_num = parse_dsp_reg_num;
> +	bin->header_info[bin_num].valid_data_len = bin->header_info[bin_num].bin_data_len - 12;
> +	p_check_sum = NULL;
> +	bin->header_info[bin_num].valid_data_addr =
> +		bin->header_info[bin_num].valid_data_addr + 12;
> +
> +	return AW_BIN_ERROR_NONE;
> +}
> +
> +static enum aw_bin_err_val aw_check_soc_app_num_v1(struct aw_bin *bin, int bin_num)
> +{
> +	unsigned int check_soc_app_num;
> +	unsigned int parse_soc_app_num;
> +	char *p_check_sum;
> +
> +	p_check_sum = &(bin->info.data[(bin->header_info[bin_num].valid_data_addr)]);
> +	bin->header_info[bin_num].app_version = AW_SAR_GET_32_DATA(*(p_check_sum + 3),
> +			*(p_check_sum + 2), *(p_check_sum + 1), *(p_check_sum));
> +	parse_soc_app_num = AW_SAR_GET_32_DATA(*(p_check_sum + 11), *(p_check_sum + 10),
> +					*(p_check_sum + 9), *(p_check_sum + 8));
> +	check_soc_app_num = bin->header_info[bin_num].bin_data_len - 12;
> +	if (parse_soc_app_num != check_soc_app_num) {
> +		p_check_sum = NULL;
> +		return AW_BIN_ERROR_SOC_APP_NUM;
> +	}
> +	bin->header_info[bin_num].reg_num = parse_soc_app_num;
> +	bin->header_info[bin_num].download_addr =
> +		AW_SAR_GET_32_DATA(*(p_check_sum + 7), *(p_check_sum + 6),
> +				*(p_check_sum + 5), *(p_check_sum + 4));
> +	bin->header_info[bin_num].valid_data_len =
> +		bin->header_info[bin_num].bin_data_len - 12;
> +	p_check_sum = NULL;
> +	bin->header_info[bin_num].valid_data_addr =
> +		bin->header_info[bin_num].valid_data_addr + 12;
> +
> +	return AW_BIN_ERROR_NONE;
> +}
> +
> +static void aw_get_single_bin_header_1_0_0(struct aw_bin *bin)
> +{
> +	int i;
> +
> +	bin->header_info[bin->all_bin_parse_num].header_len = 60;
> +	bin->header_info[bin->all_bin_parse_num].check_sum =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 3), *(bin->p_addr + 2),
> +				*(bin->p_addr + 1), *(bin->p_addr));
> +	bin->header_info[bin->all_bin_parse_num].header_ver =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 7), *(bin->p_addr + 6),
> +				*(bin->p_addr + 5), *(bin->p_addr + 4));
> +	bin->header_info[bin->all_bin_parse_num].bin_data_type =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 11), *(bin->p_addr + 10),
> +				*(bin->p_addr + 9), *(bin->p_addr + 8));
> +	bin->header_info[bin->all_bin_parse_num].bin_data_ver =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 15), *(bin->p_addr + 14),
> +				*(bin->p_addr + 13), *(bin->p_addr + 12));
> +	bin->header_info[bin->all_bin_parse_num].bin_data_len =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 19), *(bin->p_addr + 18),
> +				*(bin->p_addr + 17), *(bin->p_addr + 16));
> +	bin->header_info[bin->all_bin_parse_num].ui_ver =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 23), *(bin->p_addr + 22),
> +				*(bin->p_addr + 21), *(bin->p_addr + 20));
> +	bin->header_info[bin->all_bin_parse_num].reg_byte_len =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 35), *(bin->p_addr + 34),
> +				*(bin->p_addr + 33), *(bin->p_addr + 32));
> +	bin->header_info[bin->all_bin_parse_num].data_byte_len =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 39), *(bin->p_addr + 38),
> +				*(bin->p_addr + 37), *(bin->p_addr + 36));
> +	bin->header_info[bin->all_bin_parse_num].device_addr =
> +		AW_SAR_GET_32_DATA(*(bin->p_addr + 43), *(bin->p_addr + 42),
> +				*(bin->p_addr + 41), *(bin->p_addr + 40));
> +	for (i = 0; i < 8; i++) {
> +		bin->header_info[bin->all_bin_parse_num].chip_type[i] =
> +			*(bin->p_addr + 24 + i);
> +	}
> +
> +	bin->header_info[bin->all_bin_parse_num].reg_num = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].reg_data_byte_len = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].download_addr = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].app_version = 0x00000000;
> +	bin->header_info[bin->all_bin_parse_num].valid_data_len = 0x00000000;
> +	bin->all_bin_parse_num += 1;
> +}
> +
> +static enum aw_bin_err_val aw_parse_each_of_multi_bins_1_0_0(unsigned int bin_num,
> +		int bin_serial_num, struct aw_bin *bin)
> +{
> +	unsigned int bin_start_addr;
> +	unsigned int valid_data_len;
> +	enum aw_bin_err_val ret;
> +
> +	if (!bin_serial_num) {
> +		bin_start_addr = AW_SAR_GET_32_DATA(*(bin->p_addr + 67), *(bin->p_addr + 66),
> +				*(bin->p_addr + 65), *(bin->p_addr + 64));
> +		bin->p_addr += (60 + bin_start_addr);
> +		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
> +			bin->header_info[bin->all_bin_parse_num - 1].valid_data_addr +
> +			4 + 8 * bin_num + 60;
> +	} else {
> +		valid_data_len =
> +			bin->header_info[bin->all_bin_parse_num - 1].bin_data_len;
> +		bin->p_addr += (60 + valid_data_len);
> +		bin->header_info[bin->all_bin_parse_num].valid_data_addr =
> +			bin->header_info[bin->all_bin_parse_num - 1].valid_data_addr +
> +			bin->header_info[bin->all_bin_parse_num - 1].bin_data_len + 60;
> +	}
> +
> +	ret = aw_parse_bin_header_1_0_0(bin);
> +	return ret;
> +}
> +
> +/* Get the number of bins in multi bins, and set a for loop, loop processing each bin data */
> +static enum aw_bin_err_val aw_get_multi_bin_header_1_0_0(struct aw_bin *bin)
> +{
> +	unsigned int bin_num;
> +	enum aw_bin_err_val ret;
> +	int i;
> +
> +	bin_num = AW_SAR_GET_32_DATA(*(bin->p_addr + 63), *(bin->p_addr + 62),
> +			*(bin->p_addr + 61), *(bin->p_addr + 60));
> +	if (bin->multi_bin_parse_num == 1)
> +		bin->header_info[bin->all_bin_parse_num].valid_data_addr = 60;
> +	aw_get_single_bin_header_1_0_0(bin);
> +
> +	for (i = 0; i < bin_num; i++) {
> +		ret = aw_parse_each_of_multi_bins_1_0_0(bin_num, i, bin);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return AW_BIN_ERROR_NONE;
> +}
> +
> +/*
> + * If the bin framework header version is 1.0.0,
> + * determine the data type of bin, and then perform different processing
> + * according to the data type
> + * If it is a single bin data type, write the data directly into the structure array
> + * If it is a multi-bin data type, first obtain the number of bins,
> + * and then recursively call the bin frame header processing function
> + * according to the bin number to process the frame header information of each bin separately
> + */
> +static enum aw_bin_err_val aw_parse_bin_header_1_0_0(struct aw_bin *bin)
> +{
> +	unsigned int bin_data_type;
> +	enum aw_bin_err_val ret;
> +
> +	bin_data_type = AW_SAR_GET_32_DATA(*(bin->p_addr + 11), *(bin->p_addr + 10),
> +			*(bin->p_addr + 9), *(bin->p_addr + 8));
> +	switch (bin_data_type) {
> +	case DATA_TYPE_REGISTER:
> +	case DATA_TYPE_DSP_REG:
> +	case DATA_TYPE_SOC_APP:
> +		/*
> +		 * Divided into two processing methods,
> +		 * one is single bin processing,
> +		 * and the other is single bin processing in multi bin
> +		 */
> +		bin->single_bin_parse_num += 1;
> +		if (!bin->multi_bin_parse_num)
> +			bin->header_info[bin->all_bin_parse_num].valid_data_addr = 60;
> +		aw_get_single_bin_header_1_0_0(bin);
> +		break;
> +	case DATA_TYPE_MULTI_BINS:
> +		/* Get the number of times to enter multi bins */
> +		bin->multi_bin_parse_num += 1;
> +		ret = aw_get_multi_bin_header_1_0_0(bin);
> +		if (ret < 0)
> +			return ret;
> +		break;
> +	default:
> +		return AW_BIN_ERROR_DATA_TYPE;
> +	}
> +	return AW_BIN_ERROR_NONE;
> +}
> +
> +/* get the bin's header version */
> +static enum aw_bin_err_val aw_check_bin_header_version(struct aw_bin *bin)
> +{
> +	unsigned int header_version;
> +	enum aw_bin_err_val ret;
> +
> +	header_version = AW_SAR_GET_32_DATA(*(bin->p_addr + 7), *(bin->p_addr + 6),
> +			*(bin->p_addr + 5), *(bin->p_addr + 4));
> +
> +
> +	/*
> +	 * Write data to the corresponding structure array
> +	 * according to different formats of the bin frame header version
> +	 */
> +	switch (header_version) {
> +	case HEADER_VERSION_1_0_0:
> +		ret = aw_parse_bin_header_1_0_0(bin);
> +		return ret;
> +	default:
> +		return AW_BIN_ERROR_HEADER_VERSION;
> +	}
> +}
> +
> +enum aw_bin_err_val aw_sar_parsing_bin_file(struct aw_bin *bin)
> +{
> +	enum aw_bin_err_val ret;
> +	int i;
> +
> +	if (!bin)
> +		return AW_BIN_ERROR_NULL_POINT;
> +	bin->p_addr = bin->info.data;
> +	bin->all_bin_parse_num = 0;
> +	bin->multi_bin_parse_num = 0;
> +	bin->single_bin_parse_num = 0;
> +
> +	/* filling bins header info */
> +	ret = aw_check_bin_header_version(bin);
> +	if (ret < 0)
> +		return ret;
> +	bin->p_addr = NULL;
> +
> +	/* check bin header info */
> +	for (i = 0; i < bin->all_bin_parse_num; i++) {
> +		/* check sum */
> +		ret = aw_check_sum(bin, i);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* check register num */
> +		if (bin->header_info[i].bin_data_type == DATA_TYPE_REGISTER) {
> +			ret = aw_check_register_num_v1(bin, i);
> +			if (ret < 0)
> +				return ret;
> +			/* check dsp reg num */
> +		} else if (bin->header_info[i].bin_data_type == DATA_TYPE_DSP_REG) {
> +			ret = aw_check_dsp_reg_num_v1(bin, i);
> +			if (ret < 0)
> +				return ret;
> +			/* check soc app num */
> +		} else if (bin->header_info[i].bin_data_type == DATA_TYPE_SOC_APP) {
> +			ret = aw_check_soc_app_num_v1(bin, i);
> +			if (ret < 0)
> +				return ret;
> +		} else {
> +			bin->header_info[i].valid_data_len = bin->header_info[i].bin_data_len;
> +		}
> +	}
> +
> +	return AW_BIN_ERROR_NONE;
> +}
> +
> +unsigned int aw_sar_pow2(unsigned int cnt)
> +{
> +	unsigned int sum = 1;
> +	unsigned int i;
> +
> +	if (cnt == 0) {
> +		sum = 1;
> +	} else {
> +		for (i = 0; i < cnt; i++)
> +			sum *= 2;
> +	}
> +
> +	return sum;
> +}
> +
> +int aw_sar_load_reg(struct aw_bin *aw_bin, struct i2c_client *i2c)
> +{
> +	unsigned int start_addr = aw_bin->header_info[0].valid_data_addr;
> +	unsigned short reg_addr;
> +	unsigned int reg_data;
> +	int ret;
> +	unsigned int i;
> +
> +	for (i = 0; i < aw_bin->header_info[0].valid_data_len; i += 6, start_addr += 6) {
> +		reg_addr = (aw_bin->info.data[start_addr]) |
> +				aw_bin->info.data[start_addr + 1] << OFFSET_BIT_8;
> +		reg_data = aw_bin->info.data[start_addr + 2] |
> +			(aw_bin->info.data[start_addr + 3] << OFFSET_BIT_8) |
> +			(aw_bin->info.data[start_addr + 4] << OFFSET_BIT_16) |
> +			(aw_bin->info.data[start_addr + 5] << OFFSET_BIT_24);
> +
> +		ret = aw_sar_i2c_write(i2c, reg_addr, reg_data);
> +		if (ret < 0) {
> +			dev_err(&i2c->dev, "i2c write err");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/iio/proximity/aw_sar_comm_interface.h b/drivers/iio/proximity/aw_sar_comm_interface.h
> new file mode 100644
> index 000000000000..bc543bceb17d
> --- /dev/null
> +++ b/drivers/iio/proximity/aw_sar_comm_interface.h
> @@ -0,0 +1,172 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _AW_SAR_PLAT_HW_INTERFACE_H_
> +#define _AW_SAR_PLAT_HW_INTERFACE_H_
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_gpio.h>
> +#include <linux/power_supply.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +enum aw_sar_chip_list_t {
> +	AW_SAR_NONE_CHECK_CHIP,
> +
> +	SAR_AW9610X = 1 << 1,
> +	SAR_AW9610XA = 1 << 2,
> +
> +	SAR_AW96303 = 1 << 6,
> +	SAR_AW96305 = 1 << 7,
> +	SAR_AW96308 = 1 << 8,
> +	SAR_AW96310 = 1 << 9,
> +	SAR_AW96312 = 1 << 10,
> +};
> +
> +#ifndef AW_TRUE
> +#define AW_TRUE					(1)
> +#endif
> +
> +#ifndef AW_FALSE
> +#define AW_FALSE				(0)
> +#endif
Just use true and false rather than adding your own definitions.

> +
> +#define AW_ERR_IRQ_INIT_OVER			(0xAA)
> +
> +enum aw_sar_rst_val {
> +	AW_OK,
> +	AW_BIN_PARA_INVALID,
> +	AW_PROT_UPDATE_ERR,
> +	AW_REG_LOAD_ERR,
> +};
> +
> +#ifndef OFFSET_BIT_0
> +#define OFFSET_BIT_0				(0)
> +#endif
> +
> +#ifndef OFFSET_BIT_8
> +#define OFFSET_BIT_8				(8)
> +#endif
> +
> +#ifndef OFFSET_BIT_16
> +#define OFFSET_BIT_16				(16)
> +#endif
> +
> +#ifndef OFFSET_BIT_24
> +#define OFFSET_BIT_24				(24)
> +#endif
> +
> +#define AW_SAR_GET_32_DATA(w, x, y, z)	((unsigned int)(((w) << 24) | ((x) << 16) | ((y) << 8) | (z)))
> +
> +enum AW_SAR_HOST_IRQ_STAT {
> +	IRQ_ENABLE,
> +	IRQ_DISABLE,
> +};
> +
> +#define AW_SAR_BIN_NUM_MAX	100
> +
> +enum aw_bin_err_val {
> +	AW_BIN_ERROR_NONE = 0,
> +	AW_BIN_ERROR_HEADER_VERSION = -1,
> +	AW_BIN_ERROR_DATA_TYPE = -2,
> +	AW_BIN_ERROR_SUM_OR_DATA_LEN = -3,
> +	AW_BIN_ERROR_DATA_VERSION = -4,
> +	AW_BIN_ERROR_REGISTER_NUM = -5,
> +	AW_BIN_ERROR_DSP_REG_NUM = -6,
> +	AW_BIN_ERROR_SOC_APP_NUM = -7,
> +	AW_BIN_ERROR_NULL_POINT = -8,
> +};
> +
> +/**
> + * struct bin_header_info -
> + * @header_len: Frame header length
> + * @check_sum: Frame header information-Checksum
> + * @header_ver: Frame header information-Frame header version
> + * @bin_data_type: Frame header information-Data type
> + * @bin_data_ver: Frame header information-Data version
> + * @bin_data_len: Frame header information-Data length
> + * @ui_ver: Frame header information-ui version
> + * @chip_type: Frame header information-chip type
> + * @reg_byte_len: Frame header information-reg byte len
> + * @data_byte_len: Frame header information-data byte len
> + * @device_addr: Frame header information-device addr
> + * @valid_data_len: Length of valid data obtained after parsing
> + * @valid_data_addr: The offset address of the valid data obtained
> + *		after parsing relative to info
> + * @reg_num: The number of registers obtained after parsing
> + * @reg_data_byte_len: The byte length of the register obtained after parsing
> + * @download_addr: The starting address or download address obtained after parsing
> + * @app_version: The software version number obtained after parsing
> + */
> +struct bin_header_info {
> +	unsigned int header_len;
> +	unsigned int check_sum;
> +	unsigned int header_ver;
> +	unsigned int bin_data_type;
> +	unsigned int bin_data_ver;
> +	unsigned int bin_data_len;
> +	unsigned int ui_ver;
> +	unsigned char chip_type[8];
> +	unsigned int reg_byte_len;
> +	unsigned int data_byte_len;
> +	unsigned int device_addr;
> +	unsigned int valid_data_len;
> +	unsigned int valid_data_addr;
> +	unsigned int reg_num;
> +	unsigned int reg_data_byte_len;
> +	unsigned int download_addr;
> +	unsigned int app_version;
> +};
> +
> +/**
> + * struct bin_container -
> + * @len: The size of the bin file obtained from the firmware
> + * @data: Store the bin file obtained from the firmware
> + */
> +struct bin_container {
> +	unsigned int len;
> +	unsigned char data[];
> +};
> +
> +/**
> + * struct aw_bin -
> + * @p_addr: Offset pointer (backward offset pointer to obtain frame header information and
> + *		important information)
> + * @all_bin_parse_num: The number of all bin files
> + * @multi_bin_parse_num: The number of single bin files
> + * @single_bin_parse_num: The number of multiple bin files
> + * @header_info: Frame header information and other important data obtained after parsing
> + * @info: Obtained bin file data that needs to be parsed
> + */
> +struct aw_bin {
> +	char *p_addr;
> +	unsigned int all_bin_parse_num;
> +	unsigned int multi_bin_parse_num;
> +	unsigned int single_bin_parse_num;
> +	struct bin_header_info header_info[AW_SAR_BIN_NUM_MAX];
> +	struct bin_container info;
> +};
> +
> +/* I2C communication API */
> +int aw_sar_i2c_read(struct i2c_client *i2c, unsigned short reg_addr16, unsigned int *reg_data32);
> +int aw_sar_i2c_write(struct i2c_client *i2c, unsigned short reg_addr16, unsigned int reg_data32);
> +int aw_sar_i2c_write_bits(struct i2c_client *i2c, unsigned short reg_addr16,
> +		unsigned int mask, unsigned int val);
> +int aw_sar_i2c_write_seq(struct i2c_client *i2c, unsigned char *tr_data, unsigned short len);
> +int aw_sar_i2c_read_seq(struct i2c_client *i2c, unsigned char *addr,
> +		unsigned char addr_len, unsigned char *data, unsigned short data_len);
> +
> +enum aw_bin_err_val aw_sar_parsing_bin_file(struct aw_bin *bin);
> +unsigned int aw_sar_pow2(unsigned int cnt);
> +int aw_sar_load_reg(struct aw_bin *aw_bin, struct i2c_client *i2c);
> +
> +#endif
> diff --git a/drivers/iio/proximity/aw_sar_type.h b/drivers/iio/proximity/aw_sar_type.h
> new file mode 100644
> index 000000000000..e6744855315c
> --- /dev/null
> +++ b/drivers/iio/proximity/aw_sar_type.h
> @@ -0,0 +1,371 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _SAR_TYPE_H_
> +#define _SAR_TYPE_H_
> +
> +#include "aw_sar_comm_interface.h"
> +
> +typedef int (*aw_sar_chip_other_operation_t)(void *data);
> +typedef void (*aw_sar_chip_other_opera_free_t)(void *data);
> +
> +enum aw_i2c_flags {
> +	AW_SAR_I2C_WR,
> +	AW_SAR_I2C_RD,
> +	AW_SAR_PACKAGE_RD,
> +};
> +
> +enum sar_health_check {
> +	AW_SAR_HEALTHY = 0,
> +	AW_SAR_UNHEALTHY = 1,
> +};
> +typedef int (*aw_sar_bin_opera_t)(struct aw_bin *aw_bin, void *load_bin_para);
> +typedef int (*aw_sar_bin_load_fail_opera_t)(struct aw_bin *aw_bin, void *load_bin_para);
> +
> +struct aw_sar_get_chip_info_t {
> +	void (*p_get_chip_info_node_fn)(void *data, char *buf, ssize_t *p_len);
> +};
> +
> +struct aw_sar_load_bin_t {
> +	const unsigned char *bin_name;
> +	aw_sar_bin_opera_t bin_opera_func;
> +	aw_sar_bin_load_fail_opera_t bin_load_fail_opera;
> +
> +	void (*p_get_prot_update_fw_node_fn)(void *data, char *buf, ssize_t *p_len);
> +
> +	/* Perform different operations to update parameters */
> +	int (*p_update_fn)(void *data);
> +};
> +
> +struct aw_sar_reg_data {
> +	unsigned char rw;
> +	unsigned short reg;
> +};
> +
> +struct aw_sar_awrw_t {
> +	ssize_t (*p_set_awrw_node_fn)(void *data, const char *buf, size_t count);
> +	ssize_t (*p_get_awrw_node_fn)(void *data, char *buf);
> +};
> +
> +struct aw_sar_reg_list_t {
> +	unsigned char reg_none_access;
> +	unsigned char reg_rd_access;
> +	unsigned char reg_wd_access;
> +	const struct aw_sar_reg_data *reg_perm;
> +	unsigned int reg_num;
> +};
> +
> +typedef void (*aw_sar_update_work_t)(struct work_struct *work);
> +struct aw_sar_update_static_t {
> +	aw_sar_update_work_t update_work_func;
> +	unsigned int delay_ms;
> +};
> +
> +typedef irqreturn_t (*aw_sar_irq_t)(int irq, void *data);
> +typedef unsigned int (*sar_rc_irqscr_t)(void *i2c);
> +/*
> + * If the return value is 1, there is an initialization completion interrupt;
> + * if the return value is 0, there is no
> + */
> +typedef unsigned int (*aw_sar_is_init_over_irq)(unsigned int irq_status);
> +typedef void (*aw_sar_irq_spec_handler_t)(unsigned int irq_status, void *data);
> +
> +struct aw_sar_check_chipid_t {
> +	/* Read chipid and check chipid, Must be implemented externally */
> +	int (*p_check_chipid_fn)(void *data);
> +};
> +
> +struct aw_sar_irq_init_t {
> +	unsigned long flags;
> +	unsigned long irq_flags;
> +	irq_handler_t handler;
> +	irq_handler_t thread_fn;
> +	/* Interrupt processing parameters */
> +	sar_rc_irqscr_t rc_irq_fn;
> +	/* aw_sar_is_init_over_irq is_init_over_irq_fn; */
> +	aw_sar_irq_spec_handler_t irq_spec_handler_fn;
> +
> +	/* Use a different initialization interrupt to initialize the operation */
> +	int (*p_irq_init_fn)(void *data);
> +	/* Release interrupt resource */
> +	int (*p_irq_deinit_fn)(void *data);
> +};
> +
> +struct aw_sar_pm_t {
> +	unsigned int suspend_set_mode;
> +	unsigned int resume_set_mode;
> +	unsigned int shutdown_set_mode;
> +	/* system api */
> +	int (*p_suspend_fn)(void *data);
> +	int (*p_resume_fn)(void *data);
> +	int (*p_shutdown_fn)(void *data);
> +};
> +
> +struct aw_sar_chip_mode_t {
> +	unsigned int init_mode;
> +	unsigned int active;
> +	unsigned int pre_init_mode;
> +};
> +
> +struct aw_sar_regulator_config_t {
> +	/* Note that "_sar_num" after VCC name is defined by SAR C auto add */
> +	const unsigned char *vcc_name;
> +	int min_uV;
> +	int max_uV;
> +};
> +
> +struct aw_channels_info {
> +	unsigned short used;
> +	unsigned int last_channel_info;
> +};
> +
> +struct aw_sar_dts_info {
> +	unsigned int sar_num;
> +	unsigned int channel_use_flag;
> +	bool use_regulator_flag;
> +	bool use_inter_pull_up;
> +	bool use_pm;
> +	bool use_plug_cail_flag;
> +	bool monitor_esd_flag;
> +};
> +
> +struct aw_sar_irq_init_comm_t {
> +	unsigned char host_irq_stat;
> +	void *data;
> +	unsigned char dev_id[30];
> +};
> +
> +struct aw_sar_load_bin_comm_t {
> +	unsigned char bin_name[30];
> +	unsigned int bin_data_ver;
> +	aw_sar_bin_opera_t bin_opera_func;
> +	aw_sar_bin_load_fail_opera_t bin_load_fail_opera_func;
> +};
> +
> +struct aw_awrw_info {
> +	unsigned char rw_flag;
> +	unsigned char addr_len;
> +	unsigned char data_len;
> +	unsigned char reg_num;
> +	unsigned int i2c_tranfar_data_len;
> +	unsigned char *p_i2c_tranfar_data;
> +};
> +
> +typedef void (*sar_enable_clock_t)(void *i2c);
> +typedef void (*sar_operation_irq_t)(int to_irq);
> +typedef void (*sar_mode_update_t)(void *i2c);
> +
> +struct aw_sar_mode_switch_ops {
> +	sar_enable_clock_t enable_clock;

Just use the type directly. The typdef doesn't help with readability.

> +	sar_rc_irqscr_t rc_irqscr;
> +	sar_mode_update_t mode_update;
> +};
> +
> +struct aw_sar_chip_mode {
> +	unsigned char curr_mode;
> +	unsigned char last_mode;
> +};
> +
> +struct aw_sar_mode_set_t {
> +	unsigned char chip_id;
> +	struct aw_sar_chip_mode chip_mode;
> +	struct aw_sar_mode_switch_ops mode_switch_ops;
> +};
> +
> +struct aw_sar_mode_t {
> +	const struct aw_sar_mode_set_t *mode_set_arr;
> +	unsigned char mode_set_arr_len;
> +	ssize_t (*p_set_mode_node_fn)(void *data, unsigned char curr_mode);
> +	ssize_t (*p_get_mode_node_fn)(void *data, char *buf);
> +};
> +
> +struct aw_sar_init_over_irq_t {
> +	short wait_times;
> +	unsigned char daley_step;
> +	unsigned int reg_irqsrc;
> +	unsigned int irq_offset_bit;
> +	unsigned int irq_mask;
> +	unsigned int irq_flag;
> +	/*
> +	 * Perform different verification initialization
> +	 * to complete the interrupt operation
> +	 */
> +	int (*p_check_init_over_irq_fn)(void *data);
> +	/*
> +	 * When initialization fails, get the corresponding error type and
> +	 * apply it to the chip with flash
> +	 */
> +	int (*p_get_err_type_fn)(void *data);
> +};
> +
> +struct aw_sar_soft_rst_t {
> +	unsigned short reg_rst;
> +	unsigned int reg_rst_val;
> +	unsigned int delay_ms;
> +	/* Perform different soft reset operations */
> +	int (*p_soft_reset_fn)(void *data);
> +};
> +
> +struct aw_sar_aot_t {
> +	unsigned int aot_reg;
> +	unsigned int aot_mask;
> +	unsigned int aot_flag;
> +	ssize_t (*p_set_aot_node_fn)(void *data);
> +};
> +
> +struct aw_sar_diff_t {
> +	unsigned short diff0_reg;
> +	unsigned short diff_step;
> +	/* Data format:S21.10, Floating point types generally need to be removed */
> +	unsigned int rm_float;
> +	ssize_t (*p_get_diff_node_fn)(void *data, char *buf);
> +};
> +
> +struct aw_sar_offset_t {
> +	ssize_t (*p_get_offset_node_fn)(void *data, char *buf);
> +};
> +
> +struct aw_sar_pinctrl {
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *default_sta;
> +	struct pinctrl_state *int_out_high;
> +	struct pinctrl_state *int_out_low;
> +};
> +
> +/* update reg node */
> +struct aw_sar_para_load_t {
> +	const unsigned int *reg_arr;
> +	unsigned int reg_arr_len;
> +};
> +
> +struct aw_sar_platform_config {
> +	/* The chip needs to parse more DTS contents for addition */
> +	int (*p_add_parse_dts_fn)(void *data);
> +
> +	const struct aw_sar_regulator_config_t *p_regulator_config;
> +
> +	/* The chip needs to add more nodes */
> +	int (*p_add_node_create_fn)(void *data);
> +	/* Release the added node */
> +	int (*p_add_node_free_fn)(void *data);
> +
> +	/* Use a different initialization interrupt to initialize the operation */
> +	int (*p_input_init_fn)(void *data);
> +	/* Release input resource */
> +	int (*p_input_deinit_fn)(void *data);
> +
> +	/* The parameters passed in are required for interrupt initialization */
> +	const struct aw_sar_irq_init_t *p_irq_init;
> +
> +	/* The chip is set to different modes in different power management interfaces */
> +	const struct aw_sar_pm_t *p_pm_chip_mode;
> +};
> +
> +struct aw_sar_power_on_prox_detection_t {
> +	/* en_flag is true enable */
> +	void (*p_power_on_prox_detection_en_fn)(void *data, unsigned char en_flag);
> +	unsigned int irq_en_cali_bit;
> +	unsigned char power_on_prox_en_flag;
> +};
> +
> +/**
> + * struct aw_sar_chip_config -
A lot of this is not 'config' as such. It's per chip type constant data.
As such better to name it to reflect that. chip_info is typical choice.

> + * @ch_num_max:	Number of channels of the chip
> + * @p_platform_config:	Chip related platform content configuration
> + * @p_check_chipid:	Parameters required for verification of chipid
> + * @p_soft_rst:	Parameters required for soft reset
> + * @p_init_over_irq:	Verify the parameters required to initialize a complete interrupt
> + * @p_reg_bin:	Parameters required for load register bin file
> + * @p_chip_mode:	The mode set before and after the initialization of the chip
> + * @p_reg_list:	Register permission table
> + * @p_reg_arr:	Default register table
> + * @p_aot:	Parameters required for set Auto-Offset-Tuning(aot)
> + * @p_diff:	Parameters required for get chip diff val
> + * @p_offset:	Parameters required for get chip offset val
> + * @p_mode:	Set the parameters of different working modes of the chip
> + * @p_get_chip_info:	Obtain the necessary information of the chip
> + * @p_aw_sar_awrw:	Continuous read/write register interface
> + * @p_other_operation:	Other operations during initialization, Add according to different usage
> + * @p_other_opera_free:	If requested by resources, please release
> + */
> +struct aw_sar_chip_config {
> +	unsigned char ch_num_max;
> +	const struct aw_sar_platform_config *p_platform_config;
> +	const struct aw_sar_check_chipid_t *p_check_chipid;
> +	const struct aw_sar_soft_rst_t *p_soft_rst;
don't do the _t thing. It's obviously a type because it's a struct.

> +	const struct aw_sar_init_over_irq_t *p_init_over_irq;
> +	const struct aw_sar_load_bin_t *p_reg_bin;
> +	const struct aw_sar_chip_mode_t *p_chip_mode;
> +	const struct aw_sar_reg_list_t *p_reg_list;
> +	const struct aw_sar_para_load_t *p_reg_arr;
> +	const struct aw_sar_aot_t *p_aot;
> +	const struct aw_sar_diff_t *p_diff;
> +	const struct aw_sar_offset_t *p_offset;
> +	const struct aw_sar_mode_t *p_mode;
> +	const struct aw_sar_get_chip_info_t *p_get_chip_info;
> +	const struct aw_sar_awrw_t *p_aw_sar_awrw;
> +	aw_sar_chip_other_operation_t p_other_operation;
> +	aw_sar_chip_other_opera_free_t p_other_opera_free;
> +	const struct aw_sar_power_on_prox_detection_t *power_on_prox_detection;
> +};
> +
> +struct aw_sar {
> +	struct i2c_client *i2c;
> +	struct device *dev;
> +	struct regulator *vcc;
> +	struct delayed_work update_work;
> +	/* Set pin pull-up mode */
> +	struct aw_sar_pinctrl pinctrl;
> +	/* eds work */
> +	struct delayed_work monitor_work;
> +	struct workqueue_struct *monitor_wq;
> +	struct iio_dev *aw_iio_dev;
> +
> +	unsigned char chip_type;
> +	unsigned char chip_name[20];
> +
> +	bool power_enable;
> +	bool fw_fail_flag;
> +	unsigned char last_mode;
> +
> +	/* handler_anomalies */
> +	unsigned char fault_flag;
> +	unsigned char driver_code_initover_flag;
> +	/* handler_anomalies */
> +
> +	unsigned char ret_val;
> +	unsigned char curr_use_driver_type;
> +	int prot_update_state;
> +
> +	unsigned char aot_irq_num;
> +	unsigned char enter_irq_handle_num;
> +	unsigned char exit_power_on_prox_detection;
> +
> +	struct work_struct ps_notify_work;
> +	struct notifier_block ps_notif;
> +	bool ps_is_present;
> +
> +	/* Parameters related to platform logic */
> +	struct aw_sar_dts_info dts_info;
> +	struct aw_sar_load_bin_comm_t load_bin;
> +	struct aw_sar_irq_init_comm_t irq_init;
> +	struct aw_awrw_info awrw_info;
> +	struct aw_channels_info *channels_arr;
> +
> +	/* Private arguments required for public functions */
> +	const struct aw_sar_chip_config *p_sar_para;
> +	/* Private arguments required for private functions */
> +	void *priv_data;
> +};
> +
> +/* Determine whether the chip exists by verifying chipid */
> +typedef int (*aw_sar_who_am_i_t)(void *data);
> +typedef int (*aw_sar_chip_init_t)(struct aw_sar *p_sar);
> +typedef void (*aw_sar_chip_deinit_t)(struct aw_sar *p_sar);

Just use these inline.  They don't help readability enough to
be worth typdefs.


> +
> +struct aw_sar_driver_type {

Used in one place. Push it down into that file.
> +	unsigned char driver_type;
> +	aw_sar_who_am_i_t p_who_am_i;
> +	aw_sar_chip_init_t p_chip_init;
> +	aw_sar_chip_deinit_t p_chip_deinit;
> +};
> +
> +#endif


