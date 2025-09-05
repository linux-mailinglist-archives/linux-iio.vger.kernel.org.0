Return-Path: <linux-iio+bounces-23771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF860B457BA
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4452564518
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CADE34DCEA;
	Fri,  5 Sep 2025 12:23:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0B34DCE8;
	Fri,  5 Sep 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075013; cv=none; b=iAgw96RgDmpuB/slVTYt9AxjVC0jAheDEInscamvsL4/qlFagvUqNIuE5/LiLoUEusw+fWuhCFHxpMZFFMtHXhyUu/elBroib78Y8C8BNip3qM/wuu6hyY6Q5MOff0k8lF91s0mRQjR8n0vpMGXM+uSPlwx2jMqrYonIcp4oln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075013; c=relaxed/simple;
	bh=gd17U06Eb/gYKNUOu/X16uReRUR62UrTZu7XJuPOnx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co1pUX3LuME/JKY7yaHXMvO9x/QGn99uxFkrH0glTSN88n4d/2qBlXh3HKpkjWJmmMQVa7HqRID8/Z2GW/5590z1DfCZUvx7MEzjgzKawLXA+11tmfUo/X+lYeLiYaN4VS3F017VEn4XfhoYmWVZCOIQzoC/CXt7ckUNB5sHnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cJFn25bCCz6M4yN;
	Fri,  5 Sep 2025 20:20:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F0FA01402FC;
	Fri,  5 Sep 2025 20:23:25 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Sep
 2025 14:23:25 +0200
Date: Fri, 5 Sep 2025 13:23:24 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Michal Simek <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>, Salih Erim <salih.erim@amd.com>,
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Andy Shevchenko
	<andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	<jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/6] iio: versal-sysmon: add driver for Versal Sysmon
Message-ID: <20250905132324.00007758@huawei.com>
In-Reply-To: <2780986977702f126416ec442c5336bd541f475b.1757061697.git.michal.simek@amd.com>
References: <cover.1757061697.git.michal.simek@amd.com>
	<2780986977702f126416ec442c5336bd541f475b.1757061697.git.michal.simek@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 5 Sep 2025 10:41:45 +0200
Michal Simek <michal.simek@amd.com> wrote:

> From: Salih Erim <salih.erim@amd.com>
> 
> Sysmon Driver uses Linux IIO framework, which was used to abstract the
> supply voltages and temperatures across the chip as Voltage and Temperature
> Channels in the framework. Since there are only 160 supply voltage
> registers and 184 measurement points, there is no constant mapping of
> supply voltage registers and the measurement points. User has to select
> the voltages to monitor in design tool. Depending on the selection, a
> voltage supply gets mapped to one of the supply registers. So, this mapping
> information is provided to the driver via a device tree. Depending on the
> number of supplies enabled in the design, the device tree will contain the
> information of name of the supply enabled and the supply register it maps
> to.
> 
> Co-developed-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Various comments inline.  Please generalize them to the rest of the
code as some apply in a lot of places.

Thanks,

Jonathan


> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..1a9c5549d0dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27602,6 +27602,13 @@ F:	Documentation/misc-devices/xilinx_sdfec.rst
>  F:	drivers/misc/xilinx_sdfec.c
>  F:	include/uapi/misc/xilinx_sdfec.h
>  
> +XILINX VERSAL SYSMON DRIVER
> +M:	Salih Erim <salih.erim@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml

Bring this maintainers entry in when you add the first file (i.e. the dt
binding patch). Then update it as new files are added in later patches.

> +F:	drivers/iio/adc/versal-sysmon*
> +F:	include/linux/iio/adc/versal-sysmon-events.h


> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> new file mode 100644
> index 000000000000..21b6a413dccb
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon-core.c

> +/**
> + * sysmon_millicelsius_to_q8p7() - converts value from IIO Framework to ADC Raw data
> + * @raw_data: Raw ADC value
> + * @val: The numerator of the fraction provided by the IIO Framework
> + * @val2: Denominator of the fraction provided by the IIO Framework
> + *
> + * The function takes in exponent and mantissa as val and val2 respectively
> + * of temperature value in milliDeg Celsius and returns raw adc value for the
> + * given temperature.
> + */
> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val, int val2)
> +{
> +	(void)val2;

Don't bother - we don't care about unused parameters in the kernel.

> +
> +	*raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / SYSMON_MILLI_SCALE;
> +}
> +
> +static void sysmon_supply_rawtoprocessed(int raw_data, int *val, int *val2)
> +{
> +	int mantissa, format, exponent;
> +
> +	mantissa = raw_data & SYSMON_MANTISSA_MASK;
> +	exponent = 16 - ((raw_data & SYSMON_MODE_MASK) >> SYSMON_MODE_SHIFT);
> +	format = (raw_data & SYSMON_FMT_MASK) >> SYSMON_FMT_SHIFT;

Feels like a FIELD_GET()#?


> +static void sysmon_supply_processedtoraw(int val, int val2, u32 reg_val,
> +					 u32 *raw_data)
> +{
> +	int exponent = (reg_val & SYSMON_MODE_MASK) >> SYSMON_MODE_SHIFT;
> +	int format = (reg_val & SYSMON_FMT_MASK) >> SYSMON_FMT_SHIFT;
> +	int scale = 1 << (16 - exponent);
> +	int tmp;
> +
> +	tmp = (val * scale) / SYSMON_MILLI_SCALE;
> +
> +	/* Set out of bound values to saturation levels */
> +	if (format) {
> +		if (tmp > SYSMON_UPPER_SATURATION_SIGNED)
> +			tmp = 0x7fff;
> +		else if (tmp < SYSMON_LOWER_SATURATION_SIGNED)
> +			tmp = 0x8000;
> +
> +	} else {
> +		if (tmp > SYSMON_UPPER_SATURATION)
> +			tmp = 0xffff;
First MAX_U16 and secondly 

		tmp = min(tmp, MAX_U16);
or even better use clamp.


> +		else if (tmp < SYSMON_LOWER_SATURATION)
> +			tmp = 0x0000;
> +	}
> +
> +	*raw_data = tmp & 0xffff;
> +}

> +static int sysmon_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	u32 ret = -EINVAL;
> +	int i;
> +
> +	mutex_lock(&sysmon->mutex);
guard()
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val2 != 0)
> +			break;
> +
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			for (i = 0; i < sysmon->oversampling_num; i++) {
> +				if (val == sysmon->oversampling_avail[i]) {

Possible flip logic of this and similar to keep indent manageable.

> +					ret = sysmon_osr_write(sysmon,
> +							       IIO_TEMP, val);
> +					if (!ret)
> +						sysmon->temp_oversampling = val;
> +				}
> +			}
> +			break;
> +
> +		case IIO_VOLTAGE:
> +			for (i = 0; i < sysmon->oversampling_num; i++) {
> +				if (val == sysmon->oversampling_avail[i]) {
> +					ret = sysmon_osr_write(sysmon,
> +							       IIO_VOLTAGE, val);
> +					if (!ret)
> +						sysmon->supply_oversampling = val;
> +				}
> +			}
> +			break;
> +
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	mutex_unlock(&sysmon->mutex);
> +	return ret;
> +}

> +
> +static int sysmon_get_event_mask(unsigned long address)
> +{
> +	if (address == TEMP_EVENT)
> +		return BIT(SYSMON_BIT_TEMP);
> +	else if (address == OT_EVENT)

Drop that else as we can't get here if returned in previous
path anyway.

> +		return BIT(SYSMON_BIT_OT);
> +
> +	/* return supply */
> +	return BIT(address / 32);
> +}


> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   int *val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	u32 offset, reg_val;
> +	u32 mask, shift;
> +	u32 ret = -EINVAL;
> +
> +	mutex_lock(&sysmon->mutex);

guard and early returns will make this easier to read.

> +	if (chan->type == IIO_TEMP) {
> +		if (info == IIO_EV_INFO_VALUE) {
> +			offset = sysmon_temp_thresh_offset(chan->address, dir);
> +			sysmon_read_reg(sysmon, offset, &reg_val);
> +			sysmon_q8p7_to_millicelsius(reg_val, val, val2);
> +			ret = IIO_VAL_INT;
> +		} else if (info == IIO_EV_INFO_HYSTERESIS) {
> +			mask = (chan->address == OT_EVENT) ? 0x1 : 0x2;
> +			shift = mask - 1;
> +			sysmon_read_reg(sysmon, SYSMON_TEMP_EV_CFG, &reg_val);
> +			*val = (reg_val & mask) >> shift;
> +			*val2 = 0;
> +			ret = IIO_VAL_INT;
> +		}
> +	} else if (chan->type == IIO_VOLTAGE) {
> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		sysmon_read_reg(sysmon, offset, &reg_val);
> +		sysmon_supply_rawtoprocessed(reg_val, val, val2);
> +		ret = IIO_VAL_INT;
> +	}
> +
> +	mutex_unlock(&sysmon->mutex);
> +	return ret;
> +}


> +/**
> + * sysmon_register_temp_ops - register temperature based event handler for a
> + *				given region.
> + * @cb: callback function pointer.
> + * @data: private data to be passed to the callback.
> + * @region_id: id of the region for which the callback is to be set.
> + * @return: 0 for success and negative number in case of failure.
> + */
> +int sysmon_register_temp_ops(void (*cb)(void *data, struct regional_node *node),
> +			     void *data, enum sysmon_region region_id)
> +{
> +	struct sysmon *sysmon = g_sysmon;
> +	struct region_info *region;
> +	int ret = 0, found = 0;
> +
> +	if (!cb || !sysmon)
> +		return -EINVAL;
> +
> +	ret = mutex_lock_interruptible(&sysmon->mutex);

as below. We have ACQUIRE() to deal this these in a similar fashion to guard().

> +	if (ret) {
> +		dev_err(sysmon->dev, "Failed to acquire a lock. Process was interrupted by fatal signals");
> +		return ret;
> +	}
> +
> +	if (list_empty(&sysmon->region_list)) {
> +		dev_err(sysmon->dev, "Failed to set a callback. HW node info missing in the device tree/ Not supported for this device");
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	list_for_each_entry(region, &sysmon->region_list, list) {
> +		if (region->id == region_id) {
Flip logic to reduce indent a little.

> +			found = 1;
> +			if (region->cb) {
> +				dev_err(sysmon->dev, "Error callback already set. Unregister the existing callback to set a new one.");

at least wrap so the string starts as far to the left as is reasonable.

> +				ret = -EINVAL;
> +				goto exit;
> +			}
> +			region->cb = cb;
> +			region->data = data;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		dev_err(sysmon->dev, "Error invalid region. Please select the correct region");
> +		ret = -EINVAL;
> +	}
> +
> +exit:
> +	mutex_unlock(&sysmon->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sysmon_register_temp_ops);
> +
> +/**
> + * sysmon_unregister_temp_ops - Unregister the callback for temperature
> + *				notification.
> + * @region_id: id of the region for which the callback is to be set.
> + * @return: 0 for success and negative number in case of failure.
> + */
> +int sysmon_unregister_temp_ops(enum sysmon_region region_id)
> +{
> +	struct sysmon *sysmon = g_sysmon;
> +	struct region_info *region;
> +	int ret = 0, found = 0;
> +
> +	if (!sysmon)
> +		return -EINVAL;
> +
> +	ret = mutex_lock_interruptible(&sysmon->mutex);

The new ACQUIRE() stuff would probably clean this up.

> +	if (ret) {
> +		dev_err(sysmon->dev, "Failed to acquire a lock. Process was interrupted by fatal signals");
> +		return ret;
> +	}
> +
> +	if (list_empty(&sysmon->region_list)) {
> +		dev_err(sysmon->dev, "Failed to set a callback. HW node info missing in the device tree/ Not supported for this device");
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	list_for_each_entry(region, &sysmon->region_list, list) {
> +		if (region->id == region_id) {
> +			found = 1;
> +			region->cb = NULL;
> +			region->data = NULL;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		dev_err(sysmon->dev, "Error no such region. Please select the correct region");
> +		ret = -EINVAL;
> +	}
> +
> +exit:
> +	mutex_unlock(&sysmon->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sysmon_unregister_temp_ops);

> +
> +static void sysmon_push_event(struct iio_dev *indio_dev, u32 address)
> +{
> +	u32 i;
> +	const struct iio_chan_spec *chan;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		if (indio_dev->channels[i].address == address) {
Flip logic 
		if (indio_dev->channels[i].address != address)
			continue;

		chan = ...

> +			chan = &indio_dev->channels[i];
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(chan->type,
> +							    chan->channel,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_EITHER),
> +				       iio_get_time_ns(indio_dev));
> +		}
> +	}
> +}
> +
> +int sysmon_create_avg_en_sysfs_entries(struct iio_dev *indio_dev)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	int max_attrs_num, ret, i;
> +	u8 supply_index;
> +
> +	/* Allocate memory for temp. sat attribute list dynamically */

You are mixing and matching devm calls and non devm ones (manual
iio_device_register() is before this).  That is a bad idea for maintainabilty.
Once you have to stop doing devm for some reason you can't start again
later in probe without reordering the tear down to not be strict reverse order.

> +	sysmon->temp_avg_en_attrs =
> +		devm_kzalloc(&indio_dev->dev,
> +			     SYSMON_TEMP_SAT_COUNT *
> +			     sizeof(*sysmon->temp_avg_en_attrs), GFP_KERNEL);
> +	if (!sysmon->temp_avg_en_attrs)
> +		return -ENOMEM;
> +
> +	/* Allocate memory for supply attribute list dynamically */
> +	sysmon->supply_avg_en_attrs =
> +		devm_kzalloc(&indio_dev->dev,
> +			     sysmon->num_supply_chan *
> +			     sizeof(*sysmon->supply_avg_en_attrs), GFP_KERNEL);
> +	if (!sysmon->supply_avg_en_attrs)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Maximum attribute number is max temp. satellite number plus
> +	 * enabled supply channel number.
> +	 */
> +	max_attrs_num = SYSMON_TEMP_SAT_COUNT + sysmon->num_supply_chan;
> +
> +	sysmon->avg_attrs = devm_kzalloc(&indio_dev->dev,
> +					 (max_attrs_num + 1) *
> +					 sizeof(*sysmon->avg_attrs), GFP_KERNEL);
> +	if (!sysmon->avg_attrs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < SYSMON_TEMP_SAT_COUNT; i++) {
> +		/*
> +		 * Temp. satellites are indexed from 1 to 64 on the register
> +		 * mapping, so the attr. sysfs entry will have appropriate
> +		 * postfix index number, plus one, accordingly. We are adding
> +		 * loop index number to attributes address because enable bit
> +		 * fields starts from 0.
> +		 */
> +		sysmon->temp_avg_en_attrs[i].dev_attr.attr.name =
> +			devm_kasprintf(&indio_dev->dev, GFP_KERNEL,
> +				       "averaging_en_tempsat%d", (i + 1));
> +		sysmon->temp_avg_en_attrs[i].dev_attr.attr.mode = 0644;
> +		sysmon->temp_avg_en_attrs[i].dev_attr.show = tempsat_avg_en_show;
> +		sysmon->temp_avg_en_attrs[i].dev_attr.store = tempsat_avg_en_store;
> +		sysmon->temp_avg_en_attrs[i].address = i;
> +
> +		/* Add all temp. sat averaging attrs to array of avg attributes */
> +		sysmon->avg_attrs[i] =
> +			&sysmon->temp_avg_en_attrs[i].dev_attr.attr;
> +	}
> +
> +	for (i = 0; i < sysmon->num_supply_chan; i++) {
> +		/*
> +		 * Even each Sysmon device has max. 160 supply/voltage
> +		 * channels, they are enabled by dt discretely. There is no
> +		 * point of create attributes for all supply channels. We only
> +		 * create which is enabled by design and reflected in dt as
> +		 * supply channels. Supply index values are address of the
> +		 * IIO channel.
> +		 */
> +		supply_index = indio_dev->channels[i].address;
> +		sysmon->supply_avg_en_attrs[i].dev_attr.attr.name =
> +			devm_kasprintf(&indio_dev->dev, GFP_KERNEL,
> +				       "averaging_en_supply%d", supply_index);
> +		sysmon->supply_avg_en_attrs[i].dev_attr.attr.mode = 0644;
> +		sysmon->supply_avg_en_attrs[i].dev_attr.show = supply_avg_en_show;
> +		sysmon->supply_avg_en_attrs[i].dev_attr.store = supply_avg_en_store;
> +		sysmon->supply_avg_en_attrs[i].address = supply_index;
> +
> +		sysmon->avg_attrs[SYSMON_TEMP_SAT_COUNT + i] =
> +			&sysmon->supply_avg_en_attrs[i].dev_attr.attr;
> +	}
> +
> +	/* Null-terminate the attribute array */
> +	sysmon->avg_attrs[max_attrs_num + 1] = NULL;
> +
> +	/*
> +	 * Assign all dynamically created attributes to averaging
> +	 * attributes group with "averaging" name. It will create
> +	 * a subfolder for this group under the IIO device folder.
> +	 */
> +	sysmon->avg_attr_group.name = "averaging";

This almost certainly needs to be standard ABI, not custom.  However to even start
that discussion we need ABI documentation of what you want to do
in Documentation/ABI/testing/sysfs-bus-iio-*

> +	sysmon->avg_attr_group.attrs = sysmon->avg_attrs;
> +
> +	/* Create the sysfs group for the attributes */
> +	ret = sysfs_create_group(&indio_dev->dev.kobj,
> +				 &sysmon->avg_attr_group);

This interface is both racey from a userspace point of view and more
generally we have a bunch of ways to add extra stuff to IIO ABI and
the directory bit is not a way we tend to do it.

> +	if (ret) {
> +		dev_err(&indio_dev->dev,
> +			"Failed to create averaging attribute group\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(sysmon_create_avg_en_sysfs_entries);

> +static irqreturn_t sysmon_iio_irq(int irq, void *data)
> +{
> +	u32 isr, imr;
> +	struct iio_dev *indio_dev = data;
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +
> +	spin_lock(&sysmon->lock);
> +
> +	sysmon_read_reg(sysmon, SYSMON_ISR, &isr);
> +	sysmon_read_reg(sysmon, SYSMON_IMR, &imr);
> +
> +	/* only process alarm that are not masked */
> +	isr &= ~imr;
> +
> +	/* clear interrupt */
> +	sysmon_write_reg(sysmon, SYSMON_ISR, isr);
> +
> +	if (isr) {
> +		sysmon_handle_events(indio_dev, isr);
> +
> +		schedule_delayed_work(&sysmon->sysmon_unmask_work,
> +				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
> +	}
> +
> +	spin_unlock(&sysmon->lock);

Here guard() would be fine.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sysmon_events_worker(struct work_struct *work)
> +{
> +	u32 isr, imr;
> +	struct sysmon *sysmon = container_of(work, struct sysmon,
> +					     sysmon_events_work.work);
> +
> +	spin_lock(&sysmon->lock);

Perhaps scoped_guard()

> +
> +	sysmon_read_reg(sysmon, SYSMON_ISR, &isr);
> +	sysmon_read_reg(sysmon, SYSMON_IMR, &imr);
> +
> +	/* only process alarm that are not masked */
> +	isr &= ~imr;
> +
> +	/* clear interrupt */
> +	sysmon_write_reg(sysmon, SYSMON_ISR, isr);
> +
> +	if (isr) {
> +		sysmon_handle_events(sysmon->indio_dev, isr);
> +		schedule_delayed_work(&sysmon->sysmon_unmask_work,
> +				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
> +	}
> +	spin_unlock(&sysmon->lock);
> +
> +	schedule_delayed_work(&sysmon->sysmon_events_work,
> +			      msecs_to_jiffies(SYSMON_EVENT_WORK_DELAY_MS));
> +}

> +int sysmon_parse_dt(struct iio_dev *indio_dev, struct device *dev)

As below. Try to use property.h and avoid dt specific code.
It's normally possible for almost everything.

> +{
> +	struct sysmon *sysmon;
> +	struct iio_chan_spec *sysmon_channels;
> +	struct device_node *child_node = NULL, *np = dev->of_node;
> +	int ret, i = 0;
> +	u32 num_supply_chan = 0;
> +	u32 reg = 0, num_temp_chan = 0;
> +	const char *name;
> +	u32 chan_size = sizeof(struct iio_chan_spec);
> +	u32 temp_chan_size;
> +
> +	sysmon = iio_priv(indio_dev);
> +	ret = of_property_read_u32(np, "xlnx,numchannels", &num_supply_chan);
> +	if (ret < 0)
> +		return ret;
> +
> +	sysmon->num_supply_chan = num_supply_chan;
> +
> +	INIT_LIST_HEAD(&sysmon->region_list);
> +
> +	if (sysmon->irq > 0)
> +		get_hw_node_properties(dev, &sysmon->region_list);
> +
> +	/* Initialize buffer for channel specification */
> +	if (sysmon->master_slr) {
> +		temp_chan_size = (sizeof(temp_channels) + sizeof(temp_events));
> +		num_temp_chan = ARRAY_SIZE(temp_channels);
> +	} else if (sysmon->hbm_slr) {
> +		temp_chan_size = (sizeof(temp_hbm_channels));
> +		num_temp_chan = ARRAY_SIZE(temp_hbm_channels);
> +	} else {
> +		temp_chan_size = sizeof(temp_events);
> +		num_temp_chan = 0;
> +	}
> +
> +	sysmon_channels = devm_kzalloc(dev, (chan_size * num_supply_chan) +
> +					    temp_chan_size,
> +					    GFP_KERNEL);
> +	if (!sysmon_channels)
> +		return -ENOMEM;
> +
> +	for_each_child_of_node(np, child_node) {

Look at scoped variants of this.

> +		ret = of_property_read_u32(child_node, "reg", &reg);
> +		if (ret < 0) {
> +			of_node_put(child_node);
> +			return ret;
> +		}
> +
> +		ret = of_property_read_string(child_node, "xlnx,name", &name);
> +		if (ret < 0) {
> +			of_node_put(child_node);
> +			return ret;
> +		}
> +
> +		sysmon_channels[i].type = IIO_VOLTAGE;
likely that something like

		sysmon_channels[i] = (struct iio_chan_spec) {
			.indexed = 1,
			.address = reg,
			...
		};

Will be easier to read here.

> +		sysmon_channels[i].indexed = 1;
> +		sysmon_channels[i].address = reg;
> +		sysmon_channels[i].channel = reg;
> +		sysmon_channels[i].info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED);
> +		sysmon_channels[i].info_mask_shared_by_type =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +		sysmon_channels[i].info_mask_shared_by_type_available =
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
> +
> +		sysmon_channels[i].event_spec = sysmon_supply_events;
> +		sysmon_channels[i].num_event_specs = ARRAY_SIZE(sysmon_supply_events);
> +
> +		sysmon_channels[i].scan_index = i;
> +		sysmon_channels[i].scan_type.realbits = 19;
> +		sysmon_channels[i].scan_type.storagebits = 32;
> +
> +		sysmon_channels[i].scan_type.endianness = IIO_CPU;
> +		sysmon_channels[i].extend_name = name;
> +
> +		if (of_property_read_bool(child_node, "xlnx,bipolar"))
> +			sysmon_channels[i].scan_type.sign = 's';
> +		else
> +			sysmon_channels[i].scan_type.sign = 'u';
> +
> +		i++;
> +	}
> +
> +	/* Append static temperature channels to the channel list */
> +	indio_dev->num_channels = num_supply_chan;
> +
> +	if (sysmon->master_slr) {
> +		memcpy(sysmon_channels + num_supply_chan, temp_channels,
> +		       sizeof(temp_channels));
> +		indio_dev->num_channels += ARRAY_SIZE(temp_channels);
> +	}
> +
> +	if (sysmon->hbm_slr) {
> +		memcpy(sysmon_channels + num_supply_chan, temp_hbm_channels,
> +		       sizeof(temp_hbm_channels));
> +		indio_dev->num_channels += num_temp_chan;
> +	} else {
> +		memcpy(sysmon_channels + num_supply_chan + num_temp_chan,
> +		       temp_events, sizeof(temp_events));
> +		indio_dev->num_channels += ARRAY_SIZE(temp_events);
> +	}
> +
> +	indio_dev->channels = sysmon_channels;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(sysmon_parse_dt);
> +
> +int sysmon_init_interrupt(struct sysmon *sysmon)
> +{
> +	u32 imr;
> +	int ret;
> +
> +	INIT_DELAYED_WORK(&sysmon->sysmon_unmask_work,
> +			  sysmon_unmask_worker);
> +
> +	sysmon_read_reg(sysmon, SYSMON_IMR, &imr);
> +	sysmon->temp_mask = imr & SYSMON_TEMP_MASK;
Slight preference for FIELD_GET() as then we don't need to look at
whether the bottom bits of SYSMON_TEMP_MASK are set.

> +
> +	if (sysmon->irq > 0) {
> +		g_sysmon = sysmon;
> +		ret = devm_request_irq(sysmon->dev, sysmon->irq, &sysmon_iio_irq,
> +				       0, "sysmon-irq", sysmon->indio_dev);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		INIT_DELAYED_WORK(&sysmon->sysmon_events_work,
> +				  sysmon_events_worker);
> +		schedule_delayed_work(&sysmon->sysmon_events_work,
> +				      msecs_to_jiffies(SYSMON_EVENT_WORK_DELAY_MS));
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(sysmon_init_interrupt);
> diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
> new file mode 100644
> index 000000000000..79be5111b56c
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon.c

> +
> +#include <linux/bits.h>
> +#include <linux/moduleparam.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include "versal-sysmon.h"
> +
> +static LIST_HEAD(sysmon_list_head);
Why do we need a list? Add a comment.
> +
> +static struct iio_map sysmon_therm_static_maps[] = {
> +	IIO_MAP("temp", "versal-thermal", "sysmon-temp-channel"),
> +	{}
> +};
> +
> +static inline int sysmon_direct_read_reg(struct sysmon *sysmon, u32 offset, u32 *data)
> +{
> +	*data = readl(sysmon->base + offset);
> +
> +	return 0;
> +}
> +
> +static inline void sysmon_direct_write_reg(struct sysmon *sysmon, u32 offset, u32 data)
> +{
> +	writel(data, sysmon->base + offset);
> +}
> +
> +static inline void sysmon_direct_update_reg(struct sysmon *sysmon, u32 offset,
> +					    u32 mask, u32 data)
> +{
> +	u32 val;
> +
> +	sysmon_direct_read_reg(sysmon, offset, &val);
> +	sysmon_direct_write_reg(sysmon, offset, (val & ~mask) | (mask & data));
> +}

> +
> +/**
> + * sysmon_find_extreme_temp() - Finds extreme temperature
> + * value read from each device.
> + * @sysmon: Pointer to the sysmon instance
> + * @offset: Register offset address of temperature channels
> + *
> + * The function takes offset address of temperature channels
> + * returns extreme value (highest/lowest) of that channel
> + *
> + * @return: - The highest/lowest temperature found from
> + * current or historic min/max temperature of all devices.
> + */
> +static int sysmon_find_extreme_temp(struct sysmon *sysmon, int offset)

I would separate out this interface from the initial driver.
Also rip out all infrastructure that isn't needed for other things.
Then we can have a patch that clearly explains why this is needed.

> +{
> +	u32 extreme_val = SYSMON_LOWER_SATURATION_SIGNED;
> +	bool is_min_channel = false, skip_hbm = true;
> +	u32 regval;
> +
> +	if (offset == SYSMON_TEMP_MIN || offset == SYSMON_TEMP_MIN_MIN) {
> +		is_min_channel = true;
> +		extreme_val = SYSMON_UPPER_SATURATION_SIGNED;
> +	} else if (offset == SYSMON_TEMP_HBM) {
> +		skip_hbm = false;
> +	}
> +
> +	list_for_each_entry(sysmon, &sysmon_list_head, list) {
> +		if (skip_hbm && sysmon->hbm_slr)
> +			/* Skip if HBM SLR and need non HBM reading */
> +			continue;
> +
> +		if (!skip_hbm && !sysmon->hbm_slr)
> +			/* Skip if not HBM SLR and need a HBM reading */
> +			continue;
> +
> +		sysmon_read_reg(sysmon, offset, &regval);
> +
> +		if (sysmon->hbm_slr)
> +			return regval;
> +
> +		if (!is_min_channel) {
> +			/* Find the highest value */
> +			if (compare(regval, extreme_val))
> +				extreme_val = regval;
> +		} else {
> +			/* Find the lowest value */
> +			if (compare(extreme_val, regval))
> +				extreme_val = regval;
> +		}
> +	}
> +
> +	return extreme_val;
> +}
> +
> +static int sysmon_probe(struct platform_device *pdev)
> +{
> +	struct sysmon *sysmon, *temp_sysmon;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	bool exist = false;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*sysmon));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	sysmon = iio_priv(indio_dev);
> +
> +	sysmon->dev = &pdev->dev;
> +	sysmon->indio_dev = indio_dev;

That usually means you have a design problem  Why do you need
to go from iio_priv() back to the containing structure.  We intentionally
do not have generic code to do that because it normally indicates the
wrong data was passed somewhere and there are loops in references that
should not exist.

> +
> +	mutex_init(&sysmon->mutex);

For new code
	ret = devm_mutex_init()
	if (ret)
		return ret;

> +	spin_lock_init(&sysmon->lock);
> +
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
You should I think need to set either of those by hand. The IIO core
should do that for you.

> +	indio_dev->name = "xlnx,versal-sysmon";
> +	sysmon_set_iio_dev_info(indio_dev);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	sysmon->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(sysmon->base))
> +		return PTR_ERR(sysmon->base);
> +
> +	sysmon->ops = &direct_access;
> +
> +	INIT_LIST_HEAD(&sysmon->list);
> +
> +	mutex_lock(&sysmon->mutex);
> +
> +	if (list_empty(&sysmon_list_head)) {
> +		sysmon->master_slr = true;
> +	} else {

Bring declaratoin of exist into this scope.  It sounds very general but isn't.

> +		list_for_each_entry(temp_sysmon, &sysmon_list_head, list) {
> +			if (temp_sysmon->master_slr)
> +				exist = true;
> +		}
> +		sysmon->master_slr = !exist;
> +	}
> +
> +	mutex_unlock(&sysmon->mutex);
> +
> +	sysmon->hbm_slr = of_property_read_bool(pdev->dev.of_node, "xlnx,hbm");

Please use generic property accessors from property.h.  That gives more
flexibility for firmwares and in general means we don't introduce of specific
new code into IIO that will get cut and paste into more drivers.

> +	if (!sysmon->hbm_slr) {
> +		sysmon_write_reg(sysmon, SYSMON_NPI_LOCK, NPI_UNLOCK);
> +		sysmon_write_reg(sysmon, SYSMON_IDR, 0xffffffff);

GENMASK() is easier to read when it's writing all.

> +		sysmon_write_reg(sysmon, SYSMON_ISR, 0xffffffff);
> +		sysmon->irq = platform_get_irq_optional(pdev, 0);
> +	}
> +
> +	ret = sysmon_parse_dt(indio_dev, &pdev->dev);

parse_fw() given comment above about not doing DT specific handling.

> +	if (ret)
> +		return ret;
> +
> +	if (!sysmon->hbm_slr) {
> +		ret = sysmon_init_interrupt(sysmon);
> +			if (ret)
> +				return ret;
> +	}
> +
> +	/*
> +	 * Sysmon dev info is cleared initially.

Wrap at 80 chars.

> +	 * temperature satellites and supply channels
> +	 * oversampling values will be 0. No need to
> +	 * assign them again.
> +	 */
> +	sysmon->oversampling_avail = sysmon_oversampling_avail;
> +	sysmon->oversampling_num = ARRAY_SIZE(sysmon_oversampling_avail);
> +
> +	sysmon->temp_read = &sysmon_find_extreme_temp;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	if (sysmon->master_slr) {
> +		ret = devm_iio_map_array_register(&pdev->dev, indio_dev,
> +						  sysmon_therm_static_maps);
> +		if (ret < 0)
> +			return dev_err_probe(&pdev->dev, ret, "IIO map register failed\n");
> +	}
> +
> +	ret = iio_device_register(indio_dev);

I'd normally expect to find this last as it is where the userspace
interface becomes visible.

> +	if (ret < 0)
> +		goto error_exit;
> +
> +	/* Create the sysfs entries for the averaging enable bits */
> +	ret = sysmon_create_avg_en_sysfs_entries(indio_dev);
> +	if (ret < 0)
> +		goto error_exit;
> +
> +	mutex_lock(&sysmon->mutex);
> +	list_add(&sysmon->list, &sysmon_list_head);
> +	mutex_unlock(&sysmon->mutex);
> +
> +	return 0;
> +
> +error_exit:
> +	if (sysmon->irq < 0)
> +		cancel_delayed_work_sync(&sysmon->sysmon_events_work);
> +
> +	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);

Look at whether you can register custom devm callbacks to clean this up and
the list removal.


> +	return ret;
> +}
> +
> +static void sysmon_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +
> +	/* cancel SSIT based events */
> +	if (sysmon->irq < 0)
> +		cancel_delayed_work_sync(&sysmon->sysmon_events_work);
> +
> +	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);
> +
> +	mutex_lock(&sysmon->mutex);
> +	list_del(&sysmon->list);
> +	mutex_unlock(&sysmon->mutex);
> +
> +	sysfs_remove_group(&indio_dev->dev.kobj, &sysmon->avg_attr_group);
> +	/* Unregister the device */

Comment doesn't add anything not obvious from code.

> +	iio_device_unregister(indio_dev);
> +}

> +
> +static const struct of_device_id sysmon_of_match_table[] = {
> +	{ .compatible = "xlnx,versal-sysmon" },
> +	{}
Trivial preference for 
	{ }

I had to pick something when trying to standardize this formatting and
I chose that one.

> +};
> +MODULE_DEVICE_TABLE(of, sysmon_of_match_table);
> +
> +static struct platform_driver sysmon_driver = {
> +	.probe = sysmon_probe,
> +	.remove = sysmon_remove,
> +	.resume = sysmon_resume,

I think I'd rather see this done with pm in the .driver
That tends to be a lot more flexible unless I'm missing some reason
this resume needs to be used here.

> +	.driver = {
> +		.name = "sysmon",
> +		.of_match_table = sysmon_of_match_table,
> +	},
> +};
> +module_platform_driver(sysmon_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Xilinx Versal SysMon Driver");
> +MODULE_AUTHOR("Advanced Micro Devices, Inc");
> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> new file mode 100644
> index 000000000000..ba47b6d32f4d
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -0,0 +1,275 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD SYSMON for Versal
> + *
> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
> + * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
> + *
> + * Description:
> + * This driver is developed for SYSMON on Versal. The driver supports INDIO Mode
> + * and supports voltage and temperature monitoring via IIO sysfs interface.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/adc/versal-sysmon-events.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/of_address.h>

Include only what is used in this header. The rest need to get
pushed down to the files where they are needed.

> +
> +/* Channel IDs for Temp Channels */

Combine these comments into one block and use the syntax below.

> +/* TEMP_MAX gives the current temperature for Production
> + * silicon.
> + * TEMP_MAX gives the current maximum temperature for ES1
> + * silicon.
> + */
> +#define TEMP_MAX	160

Prefix constants like this that have very generic names.

> +
> +/* TEMP_MIN is not applicable for Production silicon.

Multiline comment syntax

/*
 * TEMP_MIN...

> + * TEMP_MIN gives the current minimum temperature for ES1 silicon.
> + */

Do you need to support engineering samples upstream?  As a general
rule we don't bother unless there are a lot of them out there.

> +#define TEMP_MIN	161
> +
> +#define TEMP_MAX_MAX	162
> +#define TEMP_MIN_MIN	163
> +#define TEMP_EVENT	164
> +#define OT_EVENT	165
> +#define TEMP_HBM	166
> +
> +/* Register Unlock Code */
> +#define NPI_UNLOCK	0xF9E8D7C6
> +
> +/* Register Offsets */
> +#define SYSMON_NPI_LOCK		0x000C
> +#define SYSMON_ISR		0x0044
> +#define SYSMON_CONFIG		0x0100
> +#define SYSMON_TEMP_MASK	0x300
> +#define SYSMON_IMR		0x0048
> +#define SYSMON_IER		0x004C
> +#define SYSMON_IDR		0x0050
> +#define SYSMON_ALARM_FLAG	0x1018
> +#define SYSMON_TEMP_MAX		0x1030
> +#define SYSMON_TEMP_MIN		0x1034
> +#define SYSMON_SUPPLY_BASE	0x1040
> +#define SYSMON_ALARM_REG	0x1940
> +#define SYSMON_TEMP_TH_LOW	0x1970
> +#define SYSMON_TEMP_TH_UP	0x1974
> +#define SYSMON_OT_TH_LOW	0x1978
> +#define SYSMON_OT_TH_UP		0x197C
> +#define SYSMON_SUPPLY_TH_LOW	0x1980
> +#define SYSMON_SUPPLY_TH_UP	0x1C80
> +#define SYSMON_TEMP_MAX_MAX	0x1F90
> +#define SYSMON_TEMP_MIN_MIN	0x1F8C
> +#define SYSMON_TEMP_HBM	0x0000
> +#define SYSMON_TEMP_EV_CFG	0x1F84
> +#define SYSMON_NODE_OFFSET	0x1FAC
> +#define SYSMON_STATUS_RESET	0x1F94
> +#define SYSMON_SUPPLY_EN_AVG_OFFSET	0x1958
> +#define SYSMON_TEMP_SAT_EN_AVG_OFFSET	0x24B4
> +
> +/* Average Sampling Rate macros */
> +#define SYSMON_AVERAGE_FULL_SAMPLE_RATE	0 /* Full sample rate */
> +#define SYSMON_AVERAGE_2_SAMPLE_RATE	1 /* Full sample rate/2 */
> +#define SYSMON_AVERAGE_4_SAMPLE_RATE	2 /* Full sample rate/4 */
> +#define SYSMON_AVERAGE_8_SAMPLE_RATE	4 /* Full sample rate/8 */
> +#define SYSMON_AVERAGE_16_SAMPLE_RATE	8 /* Full sample rate/16 */

That is an amusing mapping.  Maybe the names can be tweaked to be
self explanatory enough that the we don't need comments? This looks
like classic oversampling, in which case just call them something
related to that as it's the oversampling ratio.

> +
> +#define SYSMON_TEMP_SAT_IDX_FIRST	1
> +#define SYSMON_TEMP_SAT_IDX_MAX		64
> +#define SYSMON_TEMP_SAT_COUNT		64
> +#define SYSMON_SUPPLY_IDX_MAX		159
> +
> +#define SYSMON_SUPPLY_CONFIG_MASK	GENMASK(17, 14)
> +#define SYSMON_SUPPLY_CONFIG_SHIFT	14
> +#define SYSMON_TEMP_SAT_CONFIG_MASK	GENMASK(27, 24)
> +#define SYSMON_TEMP_SAT_CONFIG_SHIFT	24
> +
> +#define SYSMON_NO_OF_EVENTS	32
> +
> +/* Supply Voltage Conversion macros */
> +#define SYSMON_MANTISSA_MASK		0xFFFF

GENMASK() for all masks.

> +#define SYSMON_FMT_MASK			0x10000
> +#define SYSMON_FMT_SHIFT		16
> +#define SYSMON_MODE_MASK		0x60000
> +#define SYSMON_MODE_SHIFT		17
> +#define SYSMON_MANTISSA_SIGN_SHIFT	15
> +#define SYSMON_UPPER_SATURATION_SIGNED	32767
> +#define SYSMON_LOWER_SATURATION_SIGNED	-32768

S16_MIN and S16_MAX from limits.h

> +#define SYSMON_UPPER_SATURATION		65535

U16_MAX, U16_MIN

> +#define SYSMON_LOWER_SATURATION		0
> +
> +#define SYSMON_MILLI_SCALE		1000

units.h

> +
> +#define SYSMON_CHAN_TEMP_EVENT(_address, _ext, _events) { \
> +	.type = IIO_TEMP, \
> +	.indexed = 1, \
> +	.address = _address, \
> +	.channel = _address, \

Not really any point in setting address if you can always look up
channel.

> +	.event_spec = _events, \
> +	.num_event_specs = ARRAY_SIZE(_events), \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 15, \

15 bit devices are unusual but fair enough if that's the case.

> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
> +	}, \
> +	.extend_name = _ext, \
As below.
> +	}
> +
> +#define SYSMON_CHAN_TEMP(_address, _ext) { \
> +	.type = IIO_TEMP, \
> +	.indexed = 1, \
> +	.address = _address, \
> +	.channel = _address, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_PROCESSED), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +	.info_mask_shared_by_type_available = \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 15, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
> +	}, \
> +	.extend_name = _ext, \

Don't set extend_name in a new driver.   That makes a horrible mess of
the userspace ABI.  Instead use the read_label() callback to provide
a suitable string for each channel.

> +	.datasheet_name = _ext,\
> +}
> +
> +#define SYSMON_CHAN_TEMP_HBM(_address, _ext) { \
> +	.type = IIO_TEMP, \
> +	.indexed = 1, \
> +	.address = _address, \
> +	.channel = _address, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_PROCESSED), \
> +	.scan_type = { \
> +		.sign = 's', \
> +		.realbits = 15, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
> +	}, \
> +	.extend_name = _ext, \
> +	.datasheet_name = _ext, \
> +}
> +
> +#define twoscomp(val) ((((val) ^ 0xFFFF) + 1) & 0x0000FFFF)
Not sure why this is needed yet, but generally no to this.
Treat it as an s16 and I don't think you need to do anything other than
negate if needed.

> +#define REG32_OFFSET(address) (4 * ((address) / 32))
> +#define REG32_SHIFT(address) ((address) % 32)

SIZEOF(u32)*BITS_PER_BYTE.

> +
> +#define compare(val, thresh) (((val) & 0x8000) || ((thresh) & 0x8000) ? \
> +			      ((val) < (thresh)) : ((val) > (thresh)))  \

This smells like you can just used signed comparison of s16s but I'm not quite
sure what intent is.

> +
> +enum sysmon_alarm_bit {
> +	SYSMON_BIT_ALARM0 = 0,
> +	SYSMON_BIT_ALARM1 = 1,
> +	SYSMON_BIT_ALARM2 = 2,
> +	SYSMON_BIT_ALARM3 = 3,
> +	SYSMON_BIT_ALARM4 = 4,
> +	SYSMON_BIT_ALARM5 = 5,
> +	SYSMON_BIT_ALARM6 = 6,
> +	SYSMON_BIT_ALARM7 = 7,
> +	SYSMON_BIT_OT = 8,
> +	SYSMON_BIT_TEMP = 9,
> +};
> +
> +static const unsigned int sysmon_oversampling_avail[5] = {
> +	SYSMON_AVERAGE_FULL_SAMPLE_RATE,

No oversampling is value 1, not 0.  I'm not following
how the mapping works for the otehrs.

> +	SYSMON_AVERAGE_2_SAMPLE_RATE,
> +	SYSMON_AVERAGE_4_SAMPLE_RATE,
> +	SYSMON_AVERAGE_8_SAMPLE_RATE,
> +	SYSMON_AVERAGE_16_SAMPLE_RATE,
> +};
> +
> +/**
> + * struct sysmon - Driver data for Sysmon
> + * @base: physical base address of device
> + * @dev: pointer to device struct
> + * @indio_dev: pointer to the iio device
> + * @client: pointer to the i2c client
> + * @mutex: to handle multiple user interaction
> + * @lock: to help manage interrupt registers correctly
> + * @irq: interrupt number of the sysmon
> + * @region_list: list of the regions of sysmon
> + * @list: list of sysmon instances
> + * @masked_temp: currently masked due to alarm
> + * @temp_mask: temperature based interrupt configuration
> + * @sysmon_unmask_work: re-enables event once the event condition disappears
> + * @sysmon_events_work: poll for events on SSIT slices
> + * @ops: read write operations for sysmon registers
> + * @pm_info: plm address of sysmon
> + * @master_slr: to keep master sysmon info
> + * @hbm_slr: flag if HBM slr is present
> + * @temp_oversampling: current oversampling ratio for temperature satellites
> + * @supply_oversampling: current oversampling ratio for supply nodes
> + * @oversampling_avail: list of available overampling ratios
> + * @oversampling_num: total number of available oversampling ratios
> + * @num_supply_chan: number of supply channels that are enabled
> + * @supply_avg_en_attrs: dynamic array of supply averaging enable attributes
> + * @temp_avg_en_attrs: dynamic array of temp. sat. averaging enable attributes
> + * @avg_attrs: dynamic array of pointers to averaging attributes
> + * @avg_attr_group: attribute group for averaging
> + * @temp_read: function pointer for the special temperature read
> + *
> + * This structure contains necessary state for Sysmon driver to operate
> + */
> +struct sysmon {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct iio_dev *indio_dev;
> +	struct i2c_client *client;
> +	/* kernel doc above */
> +	struct mutex mutex;
> +	/* kernel doc above */
> +	spinlock_t lock;
> +	int irq;
> +	struct list_head region_list;
> +	struct list_head list;
> +	unsigned int masked_temp;
> +	unsigned int temp_mask;
> +	struct delayed_work sysmon_unmask_work;
> +	struct delayed_work sysmon_events_work;
> +	struct sysmon_ops *ops;
> +	u32 pm_info;
> +	bool master_slr;
> +	bool hbm_slr;
> +	unsigned int temp_oversampling;
> +	unsigned int supply_oversampling;
> +	const unsigned int *oversampling_avail;
> +	unsigned int oversampling_num;
> +	unsigned int num_supply_chan;
> +	struct iio_dev_attr *supply_avg_en_attrs;
> +	struct iio_dev_attr *temp_avg_en_attrs;
> +	struct attribute **avg_attrs;
> +	struct attribute_group avg_attr_group;
> +	int (*temp_read)(struct sysmon *sysmon, int offset);
> +};
> +
> +struct sysmon_ops {
> +	int (*read_reg)(struct sysmon *sysmon, u32 offset, u32 *data);
> +	void (*write_reg)(struct sysmon *sysmon, u32 offset, u32 data);
> +	void (*update_reg)(struct sysmon *sysmon, u32 offset,
> +			   u32 mask, u32 data);
> +};
> +
> +int sysmon_register_temp_ops(void (*cb)(void *data, struct regional_node *node),
> +			     void *data, enum sysmon_region region_id);
> +int sysmon_unregister_temp_ops(enum sysmon_region region_id);
> +struct list_head *sysmon_nodes_by_region(enum sysmon_region region_id);
> +int sysmon_get_node_value(int sat_id);
> +int sysmon_parse_dt(struct iio_dev *indio_dev, struct device *dev);
> +int sysmon_init_interrupt(struct sysmon *sysmon);
> +int sysmon_read_reg(struct sysmon *sysmon, u32 offset, u32 *data);
> +void sysmon_write_reg(struct sysmon *sysmon, u32 offset, u32 data);
> +void sysmon_set_iio_dev_info(struct iio_dev *indio_dev);
> +int sysmon_create_avg_en_sysfs_entries(struct iio_dev *indio_dev);
> diff --git a/include/linux/iio/adc/versal-sysmon-events.h b/include/linux/iio/adc/versal-sysmon-events.h
> new file mode 100644
> index 000000000000..d0a8b3e959c4
> --- /dev/null
> +++ b/include/linux/iio/adc/versal-sysmon-events.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Xilinx SYSMON hardware info
> + *
> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
> + * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
> + *
> + */
> +#ifndef _VERSAL_SYSMON_EVENTS_H_
> +#define _VERSAL_SYSMON_EVENTS_H_
> +
> +#include <linux/types.h>
> +#include <linux/iio/types.h>

Follow include what you use principles. So here we need
the list.h header, maybe others.

> +
> +/* Sysmon region ids */
> +enum sysmon_region {

sysmon is a heavily overloaded term. I'd prefix all the
places you have sysmon to make them versal_symon_ VERSAL_SYSMON_ etc

> +	SYSMON_AIE = 0,
> +	SYSMON_PMC = 1,
> +	SYSMON_XPIO = 2,
> +	SYSMON_VNOC = 3,
> +	SYSMON_CC = 4,
> +};
> +
> +/**
> + * struct regional_node - regional node properties
> + * @sat_id: node_id
> + * @x: x co-ordinate of the node
> + * @y: y co-ordinate of the node
> + * @temp: raw sensor value
> + * @regional_node_list: list of nodes in the region
> + */
> +struct regional_node {

Probably namespace these as well to avoid a future potential name
clash.  So versal_symon_regional_node etc.


> +	int sat_id;
> +	int x;
> +	int y;
> +	u16 temp;
> +	struct list_head regional_node_list;
> +};
> +
> +/**
> + * struct region_info - information about a regions sensors
> + * @id: region id
> + * @cb: callback to be called when there is a region specific event
> + * @data: pointer to the callback data
> + * @node_list: head to the regional_nodes list
> + * @list: list of regions
> + */
> +struct region_info {
> +	enum sysmon_region id;
> +	void (*cb)(void *data, struct regional_node *node);
> +	void *data;
> +	struct list_head node_list;
> +	struct list_head list;
> +};
> +
> +#endif


