Return-Path: <linux-iio+bounces-14216-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF27A0AA4A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653C03A71E2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC791B983E;
	Sun, 12 Jan 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTU/anH6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5C1A8F7F;
	Sun, 12 Jan 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693987; cv=none; b=oyT79Wyy6YLRshIfpzESKNaAYM9MH4nzjaNA8PZHo6jB7/8C9oIviDLWhlrAYioiacASErBM0SCCLw64+XOUQT7g/m9VPRoMtLqh/19+NJoTTfeiyAK5b5dO5ZQPbXnSEb0n26upd9WE73js9QCGcBAYqGW6t8BhL0trLJlSJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693987; c=relaxed/simple;
	bh=yTK6dID88MbcHcZhpOGsfFRFfCpI4L0A/YmG1unsfiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e09vpOlr/xyphPtrDvurkHlMoZG3JBNVvOOtPy3FMOpuTri8HslzW6/s96pOyCpsnEm1YS5704+2upRLrgq6QQYu05aVwwmq2lXb/AV5z1rkb+A8bBmJLfwX7nXnYqMkI7aRJ9xQxxX4xckBSwTeeqvdemzFeYiwQQMnzSAq49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTU/anH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71122C4CEDF;
	Sun, 12 Jan 2025 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736693986;
	bh=yTK6dID88MbcHcZhpOGsfFRFfCpI4L0A/YmG1unsfiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTU/anH69d0j6QwfMBJohwHI6TQYoNC2uO7rPpkLVWXeG7exMOADOrXcwJWMY+4Av
	 8+pKHsOiczmSWmJ9S4FsuStsNxptUp+Vy1Fl9BRz8GvJykPMtl0bjF3LVgf7jvDUxl
	 OZzoUoWXtqHaHOypfW0xIIaRexAKHhk+hKavfIktOJ7OV0sB/ySxXtJBf+8gYWf6ZS
	 fyoXrvZTF3g8rbs2aezkwsIW9hOmdb4Emm6lKuQip35DuGBVfNEmgGPGWBY8CWQ2s0
	 eSMAUQ/ZrESGi+w4SWcaPg4a5VcT8IYcVCAPjF/vgprBZ7fqOgOSyaZ6VI9GMRUPqf
	 Y6ut7iapCfXQw==
Date: Sun, 12 Jan 2025 14:59:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Zijlstra
 <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor-attributes: validate sensitivity
 attributes
Message-ID: <20250112145938.7138c922@jic23-huawei>
In-Reply-To: <20250109040006.1273797-1-acelan.kao@canonical.com>
References: <20250109040006.1273797-1-acelan.kao@canonical.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 12:00:06 +0800
"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com> wrote:

> An invalid sensor device was observed which provided valid index and
> report_ids for poll, report_state and power_state attributes, but had
> invalid report_latency, sensitivity, and timestamp attributes. This would
> cause the system to hang when using iio_info to access attributes, as
> runtime PM tried to wake up an unresponsive sensor.
> 
> [    2.594565] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
> [    2.594573] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff ffffffff:ffffffff
> [    2.595485] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
> [    2.595492] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:11, 3:11, 1:11 ffffffff:ffffffff ffffffff:ffffffff
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
If you can come up with an appropriate fixes tag that would be great
as will help us figure out how far this might be backported.

Also, can we add any info on what device this was seen on?
+CC Jiri and Srinivas who are the other listed maintainers of this driver.

Thanks,

Jonathan

> ---
>  .../hid-sensors/hid-sensor-attributes.c       | 23 +++++++++++--------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index ad1882f608c0..b7ffd97e6c56 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -564,8 +564,21 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  	} else
>  		st->timestamp_ns_scale = 1000000000;
>  
> +	ret = 0;
> +	if (st->sensitivity.index < 0 || st->sensitivity_rel.index < 0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
>  
> +	ret = sensor_hub_get_feature(hsdev,
> +				st->power_state.report_id,
> +				st->power_state.index, sizeof(value), &value);
> +	if (value < 0)
> +		ret = -EINVAL;
> +
> +out:
>  	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
>  		st->poll.index, st->poll.report_id,
>  		st->report_state.index, st->report_state.report_id,
> @@ -573,15 +586,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
>  		st->sensitivity.index, st->sensitivity.report_id,
>  		timestamp.index, timestamp.report_id);
>  
> -	ret = sensor_hub_get_feature(hsdev,
> -				st->power_state.report_id,
> -				st->power_state.index, sizeof(value), &value);
> -	if (ret < 0)
> -		return ret;
> -	if (value < 0)
> -		return -EINVAL;
> -
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
>  


