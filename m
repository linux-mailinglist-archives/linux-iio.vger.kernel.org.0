Return-Path: <linux-iio+bounces-11521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3C9B3BD0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C60A1C222D1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780681F757B;
	Mon, 28 Oct 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVBKeMRv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2611E0DC4;
	Mon, 28 Oct 2024 20:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147383; cv=none; b=J+Gz79yvOCCIa/KhYuXrZDWkzI/w+tMIGNXw1i7KFxoK+A6FZgpM2UbQpwgu8+n3SBEWpQMnmMtJdyElEVmjn+CwOx+HtgB1KVDXeGCkJli/zwrxcbqYrG5GxDMjSL53zw0RpU61nj/POoFqrnzxisW0Eq4p1Y7SRqW/+4x/m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147383; c=relaxed/simple;
	bh=dqwS4XaQFmoeo/SXHv13sETXrTAW8zi3udIref74ZGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDRDb8yVQWrNrKrjjboAkSxBk12/yj4lnnmdyy2luA9K1uQBhPpQF6aEOVQouabM1PCKeKPPfXC39MUGC8nU6Fb/5i4OqJ0kr+zV+PgCQo5kwihdhghSEpPsAO8Xf4asKcKr6wcFduleNAk0UDK86l/x9Zt6xYLJ5/QeHVnsqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVBKeMRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A531CC4CEE7;
	Mon, 28 Oct 2024 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147383;
	bh=dqwS4XaQFmoeo/SXHv13sETXrTAW8zi3udIref74ZGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kVBKeMRvflS9wLXtOqnM2Uh4BHGYw8Wy9uE8M1cGSOacqAyyoN6QRVo5S3VbhcKHu
	 Cm61SjQXDtYRZuh4FL6NY+S8qg5w335nfpmcCJsUKUns04+E+Hv67fLyaCthq92iZ1
	 t1luqkDFRDsiCOQ/mA1S0E4MgVhKhksImQqJi09dXHMnPHgIFHy4Mjq+Fxn+X/j+BF
	 NzCv9q2pdc0CHnpKUJFA03dZwxkJzIDSjggY/Z9wQwzImo7OveFG3C3AHWr4TXTgd7
	 XCkQZrxw0HXEFgnRHUhqgm615hmpsEtqec53TVNWeaddkVqE3RlPp4EY84h2yX4Nep
	 fMYjI7ATcvwRQ==
Date: Mon, 28 Oct 2024 20:29:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Harvey Yang <chenghaoyang@google.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: hid-sensor-prox: Add support for more
 channels
Message-ID: <20241028202934.3894a141@jic23-huawei>
In-Reply-To: <20241028-hpd-v2-5-18f6e79154d7@chromium.org>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
	<20241028-hpd-v2-5-18f6e79154d7@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 10:12:25 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Egis620 supports 3 channels: presense, proximity and attention.
> 
> Modify the driver so it can read those channels as well.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Hi Ricardo, one comment inline that I'm fine fixing up if nothing else
comes up. 

Given this series is introducing a new channel type, I'd like to leave
it on the list for a little while to see if there are any comments on that
definition beyond the one I had...

Jonathan

> ---
>  drivers/iio/light/hid-sensor-prox.c | 171 ++++++++++++++++++++----------------
>  1 file changed, 95 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 0f12a8a83790..e6f81d40a492 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -13,16 +13,31 @@
>  #include <linux/iio/buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> -#define CHANNEL_SCAN_INDEX_PRESENCE 0
> +static const u32 prox_usage_ids[] = {
> +	HID_USAGE_SENSOR_HUMAN_PRESENCE,
> +	HID_USAGE_SENSOR_HUMAN_PROXIMITY,
> +	HID_USAGE_SENSOR_HUMAN_ATTENTION,
> +};
> +#define MAX_CHANNELS ARRAY_SIZE(prox_usage_ids)
> +
> +enum {
> +	HID_HUMAN_PRESENCE,
> +	HID_HUMAN_PROXIMITY,
> +	HID_HUMAN_ATTENTION,
> +};
>  
>  struct prox_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
> -	struct hid_sensor_hub_attribute_info prox_attr;
> -	u32 human_presence;
> +	struct hid_sensor_hub_attribute_info prox_attr[MAX_CHANNELS];
> +	struct iio_chan_spec channels[MAX_CHANNELS];
> +	u32 channel2usage[MAX_CHANNELS];
> +	u32 human_presence[MAX_CHANNELS];
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
> +	unsigned long scan_mask[2]; // One entry plus one terminator.
Really trivial, but in IIO and most of the kernel comment are still
'c style' /* One entry plus one terminator */

> +	int num_channels;
>  };
>  
>  static const u32 prox_sensitivity_addresses[] = {
> @@ -30,18 +45,23 @@ static const u32 prox_sensitivity_addresses[] = {
>  	HID_USAGE_SENSOR_DATA_PRESENCE,
>  };

> 


