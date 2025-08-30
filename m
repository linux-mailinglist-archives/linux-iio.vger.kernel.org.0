Return-Path: <linux-iio+bounces-23479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C50B3CE0B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7397D177AC3
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46494211290;
	Sat, 30 Aug 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKnJB8/Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A21E1C22;
	Sat, 30 Aug 2025 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756574495; cv=none; b=AKvjoLYokAdZKbyDp4RaZX85Bl8fmp5uy1wzDC46QbZeX1ZApQFH/fE1W03UrakOtzum+6t3VmvU1jXGjJyiQ8iDzD8briKCiGIb8xYeIBA5rnMPZgodL+4GPFyvvrK1Y1x6FjcQo+o82lkhp3tBMbLwoN2ALP4MqGtF4DkKiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756574495; c=relaxed/simple;
	bh=gyMnoqo+xjq8pXK5bVxUydoqTpi7GPulBctYPRephCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgLNNXw6yJcBwB+ZugylL4BiErd5ceuMsyXne2OaWfWx8y6hcj6Zbiz8JiIX7MFeV3vVK2vijYxWjy2So487mgzWxu9szPxFpySjfdaT3zvyeoRaVT9pfwDo3QViFYam1yCSLYhhbW1uwRM//FQ7521DV25sRpmzf6bVDpDtErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKnJB8/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9C5C4CEEB;
	Sat, 30 Aug 2025 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756574494;
	bh=gyMnoqo+xjq8pXK5bVxUydoqTpi7GPulBctYPRephCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cKnJB8/YYJGyHrmrxd6q51qYehTNddinX2TkZJqPRcoY1Og0CmjQ23dFwkPbFcdo3
	 sUmD65Xef8GXv7xapAP6ypxpHJaZC8Qns4reqazBSKCQH4v62qfrMPUpwrSiASkeMI
	 QvnrQeRCzp/IIPeaT45MIWLAN49eXLyRvEpsuUYecHGtSTC1MFOLIWYEVfvK5ilc33
	 6Mk6WalAfwKrvTcmx/4tnlXYujqxLwsJzVvUNn+pIvJSzX5HTrJHpeIHVS7nnlhRLp
	 INKMidyIPioYlBuhjpuHYieLvGdY3/8VJwRX1UjMROabGw/jJzgP/FCHXzB3YPl/d6
	 Ug7e0XtNdpFow==
Date: Sat, 30 Aug 2025 18:21:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: lanzano.alex@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: ABI: document accel and roc event
 attributes
Message-ID: <20250830182125.03ff6e6b@jic23-huawei>
In-Reply-To: <20250830115858.21477-3-gustavograzs@gmail.com>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
	<20250830115858.21477-3-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 08:58:57 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Add accelerometer and rate of change event-related sysfs attributes
> exposed by the bmi270 driver.
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 40 +++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 2fb2cea4b192..75a88f0dc533 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -908,6 +908,7 @@ What:		/sys/.../iio:deviceX/events/in_accel_y_roc_rising_en
>  What:		/sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
>  What:		/sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
>  What:		/sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
> +What:		/sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_en
>  What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_rising_en
>  What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_falling_en
>  What:		/sys/.../iio:deviceX/events/in_anglvel_y_roc_rising_en
> @@ -1129,6 +1130,7 @@ Description:
>  		will get activated once in_voltage0_raw goes above 1200 and will become
>  		deactivated again once the value falls below 1150.
>  
> +What:		/sys/.../events/in_accel_roc_rising_value
>  What:		/sys/.../events/in_accel_x_raw_roc_rising_value
>  What:		/sys/.../events/in_accel_x_raw_roc_falling_value
>  What:		/sys/.../events/in_accel_y_raw_roc_rising_value
> @@ -1177,6 +1179,7 @@ Description:
>  
>  What:		/sys/.../events/in_accel_x_thresh_rising_period
>  What:		/sys/.../events/in_accel_x_thresh_falling_period
> +What:		/sys/.../events/in_accel_roc_rising_period
>  What:		/sys/.../events/in_accel_x_roc_rising_period
>  What:		/sys/.../events/in_accel_x_roc_falling_period
>  What:		/sys/.../events/in_accel_y_thresh_rising_period
> @@ -1187,6 +1190,7 @@ What:		/sys/.../events/in_accel_z_thresh_rising_period
>  What:		/sys/.../events/in_accel_z_thresh_falling_period
>  What:		/sys/.../events/in_accel_z_roc_rising_period
>  What:		/sys/.../events/in_accel_z_roc_falling_period
> +What:		/sys/.../events/in_accel_mag_adaptive_rising_period
>  What:		/sys/.../events/in_anglvel_x_thresh_rising_period
>  What:		/sys/.../events/in_anglvel_x_thresh_falling_period
>  What:		/sys/.../events/in_anglvel_x_roc_rising_period
> @@ -1344,6 +1348,23 @@ Description:
>  		number or direction is not specified, applies to all channels of
>  		this type.
>  
> +What:		/sys/.../iio:deviceX/events/in_accel_x_mag_adaptive_rising_en
> +What:		/sys/.../iio:deviceX/events/in_accel_y_mag_adaptive_rising_en
> +What:		/sys/.../iio:deviceX/events/in_accel_z_mag_adaptive_rising_en
> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Similar to in_accel_x_thresh[_rising|_falling]_en, but here the
> +		adaptive magnitude of the channel is compared to the threshold.
That seems backwards.  I was thinking of this as

the magnitude of the channel is compared to an adaptive threshold. 

I'm not sure what 'adaptive magnitude of the channel' would mean.

> +
> +What:		/sys/.../events/in_accel_mag_adaptive_rising_value
I'm not sure this one needs it's own block.

For the nearest equivalent which is _adaptive_rising_value (which is only documented
for capacitive channels we just put it in the same block as the non _adaptive_ variant.

> +KernelVersion:	2.6.37
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The value to which the reference adaptive magnitude of the channel is
> +		compared. If the axis is not specified, it applies to all channels
> +		of this type.
> +
>  What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_en
>  What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_rising_en
>  What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_falling_en
> @@ -2386,3 +2407,22 @@ Description:
>  		Value representing the user's attention to the system expressed
>  		in units as percentage. This usually means if the user is
>  		looking at the screen or not.
> +
> +What:		/sys/.../events/in_accel_value_available
> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of available acceleration threshold values that can be
> +		configured for event generation. Units after application of
> +		scale and offset are m/s^2. Expressed as:
> +

This is generic. What sort of event does it apply to?  Seems like it should
be in_accel_mag_adaptive_value or something along those lines? Might also need
in_acecl_mag_reference_value or even direction specific variants of each.

Whilst the ABI does allow for a broader 'available' to cover for
all channels for instance so this is sort of valid ABI, to me it just
feels non intuitive for a user.    Maybe just adding tot this document
to say that this applies to all forms of event for in_accel channels on
this device is sufficient.

> +		- a range specified as "[min step max]"
> +
> +What:		/sys/.../events/in_accel_period_available

This one feels more reasonable as the idea of all events sharing a period control
is more likely than the values that are accepted being the same for all.

> +KernelVersion:	6.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of available periods for accelerometer event detection in
> +		seconds, expressed as:
> +
> +		- a range specified as "[min step max]"


