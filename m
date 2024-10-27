Return-Path: <linux-iio+bounces-11394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34FD9B1D64
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 12:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F87281836
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17913B2B8;
	Sun, 27 Oct 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv+xgXHv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35113F9D2;
	Sun, 27 Oct 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730028619; cv=none; b=o/BR495Nk3/LgY8Tj4ycCjxAezw6YB0/H7VNlYoEcLfsB8vtG7fFus4mlPbfX3SCpeEC1vpRcQhxBGUR/NCI7Ip9Eqcv9g8M1dFCC9Tb/YSq0q9K/Bck8pT8yFLtrjxEBSAN3MO/tuKIkWTvs1v3dN1AqjspPATsvp3olBJX4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730028619; c=relaxed/simple;
	bh=SqiAejqnwtdMsmclrn3s3s+9fkQcLWUueQtnzHdx0AI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iji4S5UTAu8lRzupTC2fBzZ37aKaJX4NoYAfEOCxblXwnR0m6r8kST6vfziO095a2HRWkaeCvc7pe2AETw95JKmIBXVXTb1noDoRJfhFRVo/Ev37Y6SnjXlAUHe7DuLoJtbWVvw7XXx807PYpYt9qV+Amaxf9m3MER2m9cOAX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv+xgXHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA78C4CEC3;
	Sun, 27 Oct 2024 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730028619;
	bh=SqiAejqnwtdMsmclrn3s3s+9fkQcLWUueQtnzHdx0AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cv+xgXHvPfbO+FS5+P9ATOUIb8PDSTq12CZrA0rtoo9SzxQ1aTmfDVLQDWSeBisHp
	 gt4LFxyc+Lnk339mrQI3WrrlZWxuLWXXXl761sSLEUQidSsp7TY1c0k2CYU2Ryl/Jk
	 8yiO6fb5j445UYozxq7gikZTwxafLs+Zv5ag4lpbM6of9UHdT376Sac0QyPA79cA9Q
	 ChOkdvzyuhv+taDHbDP/2WW06ur9XerqXx5icy9GfAqjcfQUDJnMIRPU3RiSJH2oaB
	 wu6pSKds0mNH1Af+TzCCkE5VE78Bxh7lZJqvvW/VJgZWzjhqh7iRgbxmzaEjE7Ms0z
	 SLzB1mSMbJawg==
Date: Sun, 27 Oct 2024 11:30:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Harvey Yang <chenghaoyang@google.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: hid-sensor-prox: Add support for more channels
Message-ID: <20241027113010.153fab2b@jic23-huawei>
In-Reply-To: <20241024-hpd-v1-3-2a125882f1f8@chromium.org>
References: <20241024-hpd-v1-0-2a125882f1f8@chromium.org>
	<20241024-hpd-v1-3-2a125882f1f8@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 13:29:07 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Egis620 supports 3 channels: presense, proximity and attention.

It's not obvious to me that these should necessarily be represented
as proximity channels.

Presence and proximity perhaps though I'm confused as to why
both make sense on a device, but maybe there are two forms of sensor.

Attention is an oddity and not the same as proximity from the definition
(see patch 1 review).

So for that we probably need a new channel type.

Jonathan


> 
> Modify the driver so it can read those channels as well.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/iio/light/hid-sensor-prox.c | 161 ++++++++++++++++++++----------------
>  1 file changed, 89 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index d38564fe22df..97550d0d21a9 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -13,16 +13,26 @@
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> -#define CHANNEL_SCAN_INDEX_PRESENCE 0
> +static const u32 prox_usage_ids[] = {
> +	HID_USAGE_SENSOR_HUMAN_PRESENCE,
> +	HID_USAGE_SENSOR_HUMAN_PROXIMITY,
> +	HID_USAGE_SENSOR_HUMAN_ATTENTION,
> +};
Use an enum so that you can set these as entries you can later index.

[HID_HUMAN_PRESENCE] = HID_USAGE_...
etc

> +
> +#define MAX_USAGE ARRAY_SIZE(prox_usage_ids)
Name that something more specific or just use
the ARRAY_SIZE inline.

>  
>  struct prox_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
> -	struct hid_sensor_hub_attribute_info prox_attr;
> -	u32 human_presence;
> +	struct hid_sensor_hub_attribute_info prox_attr[MAX_USAGE];
> +	struct iio_chan_spec channels[MAX_USAGE];
> +	u32 channel2usage[MAX_USAGE];
> +	u32 human_presence[MAX_USAGE];
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
> +	unsigned long scan_mask[2];

Perhaps add a comment that this is one entry plus a terminator.

> +	int num_channels;
>  };
>  
>  static const u32 prox_sensitivity_addresses[] = {
> @@ -30,17 +40,23 @@ static const u32 prox_sensitivity_addresses[] = {
>  	HID_USAGE_SENSOR_DATA_PRESENCE,
>  };
>  
> -/* Channel definitions */
> -static const struct iio_chan_spec prox_channels[] = {
> -	{
> -		.type = IIO_PROXIMITY,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SCALE) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> -		.scan_index = CHANNEL_SCAN_INDEX_PRESENCE,
> +#define PROX_CHANNEL(_indexed, _channel) \
> +	{\
> +		.type = IIO_PROXIMITY,\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
> +		BIT(IIO_CHAN_INFO_SCALE) |\
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> +		BIT(IIO_CHAN_INFO_HYSTERESIS),\
> +		.indexed = _indexed,\
> +		.channel = _channel,\
>  	}
> +
> +/* Channel definitions (same order as prox_usage_ids) */
> +static const struct iio_chan_spec prox_channels[] = {
> +	PROX_CHANNEL(false, 0), // PRESENCE
With a suitable enum as suggested above can use
[HID_HUMAN_PRESENCE] = PROX_CHANNEL(false, 0) etc

Combining index and not is unusual. If we have to do this
I think we should consider the technical ABI breakage of adding
an index to the first one.  It 'shouldn't' break code using the ABI
correctly but it is a risk.

> +	PROX_CHANNEL(true, 1), // PROXIMITY
> +	PROX_CHANNEL(true, 2), // ATTENTION
>  };
>  
>  /* Adjust channel real bits based on report descriptor */
> @@ -62,7 +78,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct prox_state *prox_state = iio_priv(indio_dev);
>  	struct hid_sensor_hub_device *hsdev;
> -	int report_id = -1;
> +	int report_id;
>  	u32 address;
>  	int ret_type;
>  	s32 min;
> @@ -71,29 +87,22 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>  	*val2 = 0;
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		switch (chan->scan_index) {
> -		case  CHANNEL_SCAN_INDEX_PRESENCE:
> -			report_id = prox_state->prox_attr.report_id;
> -			min = prox_state->prox_attr.logical_minimum;
> -			address = HID_USAGE_SENSOR_HUMAN_PRESENCE;
> -			hsdev = prox_state->common_attributes.hsdev;
> -			break;
> -		default:
> -			report_id = -1;
> -			break;
> -		}
> -		if (report_id >= 0) {
> -			hid_sensor_power_state(&prox_state->common_attributes,
> -						true);
> -			*val = sensor_hub_input_attr_get_raw_value(
> -				hsdev, hsdev->usage, address, report_id,
> -				SENSOR_HUB_SYNC, min < 0);
> -			hid_sensor_power_state(&prox_state->common_attributes,
> -						false);
> -		} else {
> +		if (chan->scan_index >= prox_state->num_channels) {
>  			*val = 0;
No need to set this in an error path. Not sure why original code did.

>  			return -EINVAL;
>  		}
> +		address = prox_state->channel2usage[chan->scan_index];
> +		report_id = prox_state->prox_attr[chan->scan_index].report_id;
> +		hsdev = prox_state->common_attributes.hsdev;
> +		min = prox_state->prox_attr[chan->scan_index].logical_minimum;
> +		hid_sensor_power_state(&prox_state->common_attributes, true);
> +		*val = sensor_hub_input_attr_get_raw_value(hsdev,
> +							   hsdev->usage,
> +							   address,
> +							   report_id,
> +							   SENSOR_HUB_SYNC,
> +							   min < 0);
> +		hid_sensor_power_state(&prox_state->common_attributes, false);
>  		ret_type = IIO_VAL_INT;
>  		break;

> @@ -178,48 +187,63 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>  	struct prox_state *prox_state = iio_priv(indio_dev);
> -	int ret = -EINVAL;
> -
> -	switch (usage_id) {
> -	case HID_USAGE_SENSOR_HUMAN_PRESENCE:
> -		switch (raw_len) {
> -		case 1:
> -			prox_state->human_presence = *(u8 *)raw_data;
> -			return 0;
> -		case 4:
> -			prox_state->human_presence = *(u32 *)raw_data;
> -			return 0;
> -		default:
> +	int chan;
> +
> +	for (chan = 0; chan < prox_state->num_channels; chan++)
> +		if (prox_state->channel2usage[chan] == usage_id)
>  			break;
> -		}
> +	if (chan == prox_state->num_channels)
> +		return -EINVAL;
> +
> +	switch (raw_len) {
> +	case 1:
> +		prox_state->human_presence[chan] = *(u8 *)raw_data;
> +		break;
Might as well return here.
> +	case 4:
> +		prox_state->human_presence[chan] = *(u32 *)raw_data;
>  		break;
and here.

>  	}
>  
> -	return ret;
> +	return 0;
>  }
>
>

