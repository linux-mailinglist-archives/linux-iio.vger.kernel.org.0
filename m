Return-Path: <linux-iio+bounces-11522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE269B3BEA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA041C223C4
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D26B1E230E;
	Mon, 28 Oct 2024 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4xDgBgh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54311E1C05;
	Mon, 28 Oct 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147686; cv=none; b=OQxxO/HhGDzrb+m0Eag5T6wRNIthERbaogABxIOU3wD60almLoEAdqUPrAuFqwAZmWC5G3UGHl0lsJSpWbLD2MBmzfeltj3+5y982ttHoWLDluMsG3rc/J6oz5gWhZolUhEKt72VPt1rEqzUJYrKuJvUOnGO+3JmZ4nT8kR3JjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147686; c=relaxed/simple;
	bh=/YMuypyz+/MkpmwAg/7pkGXoHcYY/3lBQaw6J0KOUA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onS8UZklGrI3vwrCVHxzJxzCeqvtCeaoyfnStsQl35WSDeDOWiqThL5CpSmTwPqNd4qdNdtgbl8HystEYyyVaFidJ5XCFbmy+2GE1uKnoYvoJEEXt+JT7xVT4Z2ezfTEUouOhSKmElSDv9pgy8HSG2WRAakpsu3ER0M6/Bf7uNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4xDgBgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C07C4CEC3;
	Mon, 28 Oct 2024 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147685;
	bh=/YMuypyz+/MkpmwAg/7pkGXoHcYY/3lBQaw6J0KOUA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n4xDgBghWuoEv1Av0Tyn63OHCPnTrGr/AtfbrABTtXGxliL+V7X5CrzDRqDC9DzVa
	 FYvLUOZtIfuGqwbM8V0DnM84P73AL7I3DoKur3ZGQO66AQWuttkBfl2FN2V8PTN5pu
	 qRez3vYchkaJyxvcVM6KL6EWihXVELNWSspu2qf8wJR+LVJI3HXU5gvy0hOnoHqNvj
	 VIT2hHfxZN2wlzVcJpKGRu1xTT43HP3N+isq4J2P595u02RQCDwDUoeYKsv6Ykb8L4
	 TSWku7VyQwud29Q67RwPNcjnDxZ3GqnR8gVHkXdEB6v3KHZ8BT9HqRzuSvEXkUgEnH
	 BmCkesNHgjTrg==
Date: Mon, 28 Oct 2024 20:34:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Harvey Yang <chenghaoyang@google.com>,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iio: Add channel type for attention
Message-ID: <20241028203437.3eb5268d@jic23-huawei>
In-Reply-To: <20241028-hpd-v2-3-18f6e79154d7@chromium.org>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
	<20241028-hpd-v2-3-18f6e79154d7@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 10:12:23 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Add a new channel type representing if the user's attention state to the
> the system. This usually means if the user is looking at the screen or
> not.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  tools/iio/iio_event_monitor.c           | 2 ++
>  4 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 89943c2d54e8..d5a2f93bd051 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2339,3 +2339,10 @@ KernelVersion:	6.10
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		The value of current sense resistor in Ohms.
> +
> +What:		/sys/.../iio:deviceX/in_attention_raw
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Boolean value representing the user's attention to the system.
> +		This usually means if the user is looking at the screen or not.

Hmm. I should have thought of this when I replied to suggest a new channel type.
The question is 'units' for a decision.

Last time we hit something like this where processing is used to make a decision
we decided to at least allow for the concept of 'certainty'.

The idea being that smarter sensors would tell us something about how sure they
are that the attention is on the device.
The analogy being with activity detection. See in_activity_walking_input
in Documentation/ABI/testing/sysfs-bus-iio

Do you think that would be appropriate here as well?  For this device
it would take the values 0 and 100 rather than 0 and 1.


> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6a6568d4a2cb..bdfb51275b68 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -95,6 +95,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_DELTA_VELOCITY] = "deltavelocity",
>  	[IIO_COLORTEMP] = "colortemp",
>  	[IIO_CHROMATICITY] = "chromaticity",
> +	[IIO_ATTENTION] = "attention",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index f2e0b2d50e6b..12886d4465e4 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -51,6 +51,7 @@ enum iio_chan_type {
>  	IIO_DELTA_VELOCITY,
>  	IIO_COLORTEMP,
>  	IIO_CHROMATICITY,
> +	IIO_ATTENTION,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 8073c9e4fe46..ed9a677f1028 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -63,6 +63,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_DELTA_VELOCITY] = "deltavelocity",
>  	[IIO_COLORTEMP] = "colortemp",
>  	[IIO_CHROMATICITY] = "chromaticity",
> +	[IIO_ATTENTION] = "attention",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -183,6 +184,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_DELTA_VELOCITY:
>  	case IIO_COLORTEMP:
>  	case IIO_CHROMATICITY:
> +	case IIO_ATTENTION:
>  		break;
>  	default:
>  		return false;
> 


