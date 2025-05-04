Return-Path: <linux-iio+bounces-19053-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0007AA8828
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FD41896C64
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301931E0DD1;
	Sun,  4 May 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4D1MN3e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77FA8F7D;
	Sun,  4 May 2025 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746377388; cv=none; b=lZz0Sc8VNWUM9p4UwZPDXnToN/4z8xt7B/9xC5PSNbrIiy/TtXzWYduhcKbkBb5dG/nnag9R1BPm1uzG69wIrxOVAHBeIxg3x3YUfJ/Yg9SHeN+4+3zsj79rHb9ckOILvDlHbxymt4x48OTRGhDPgwbmd5mjxx2t6vNuzajEZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746377388; c=relaxed/simple;
	bh=OgTNb0q1nRT4hHwyCEaahOVLBx/Mv+pL3202dapPhGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyVMomsp1x3GwyCx3Asy1jMwTFQGyLymgpSY5hNU5Njtk+a0w8w+NshzWddX84MpNWNhEcKMbMOQikEf1AJv6QEYgYOvt4rDkQn6vLhqeokJxW33TmPIYsdw82VhhgMCh+kBMcHV8g/YD9bsS2T2v9ScAjYBzoRbecsLfKevMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4D1MN3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F39CC4CEE7;
	Sun,  4 May 2025 16:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746377387;
	bh=OgTNb0q1nRT4hHwyCEaahOVLBx/Mv+pL3202dapPhGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i4D1MN3eEzrwTtmoiuTmxTs/P0PWII0+QUE5gUP/XSUXohMEb53agoo9IKb/pFr8G
	 bokDkQoQWZkdA4ilulw0TZxSx4q7S9eistjQ+RYMUzZ8uZMgRSNIu43MqMUp3JqJnb
	 uXRCJLoXvU/sdQ3I84BdyvA1/q/ahfFVH7esUwFmTlhOeepApzIHgqPHcrFJzW2XeN
	 iZp2awpASOkVw53r/0GriYjDrJeTWEbfIKBQmD+ciBq7FXAl+o1OE81KWrgCTMVwUZ
	 whOK3Io3NkYYot0xR7nE0XWy1FaVVIhzGmXTDCNXJEZGx1GRtqS73iWZD/zabz6OgJ
	 u/wR/h3i30BhA==
Date: Sun, 4 May 2025 17:49:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org,
 srinivas.pandruvada@linux.intel.com, dlechner@baylibre.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sensor-hub: Fix typo and improve documentation
 for sensor_hub_remove_callback()
Message-ID: <20250504174941.1390b21b@jic23-huawei>
In-Reply-To: <20250502003655.1943000-1-chelsyratnawat2001@gmail.com>
References: <20250430182300.122896-1-chelsyratnawat2001@gmail.com>
	<20250502003655.1943000-1-chelsyratnawat2001@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 May 2025 17:36:55 -0700
Chelsy Ratnawat <chelsyratnawat2001@gmail.com> wrote:

> Fixed a typo in "registered" and improved grammar for better readability
> and consistency with kernel-doc standards. No functional changes.
> 
> Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> ---
Even though trivial reason for resend, this is v3.

Posting it as v2 confuses some tooling such as b4.
I manually grabbed the right patch and applied.

Thanks,

Jonathan

> Changes in v2:
>  - Improved the kernel-doc comment for sensor_hub_remove_callback().
>  - Changed "Gyro" to "gyro".
>  - Changed "usage ID" to "usage_id" for consistency with kernel-doc
>    style.
>  - Updated the comment to state that only one callback can be removed
>    per (usage_id, hsdev) pair.
> 
>  include/linux/hid-sensor-hub.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index c27329e2a5ad..0f9f7df865db 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -128,12 +128,13 @@ int sensor_hub_register_callback(struct hid_sensor_hub_device *hsdev,
>  			struct hid_sensor_hub_callbacks *usage_callback);
>  
>  /**
> -* sensor_hub_remove_callback() - Remove client callbacks
> +* sensor_hub_remove_callback() - Remove client callback
>  * @hsdev:	Hub device instance.
> -* @usage_id:	Usage id of the client (E.g. 0x200076 for Gyro).
> +* @usage_id:	Usage id of the client (e.g. 0x200076 for gyro).
>  *
> -* If there is a callback registred, this call will remove that
> -* callbacks, so that it will stop data and event notifications.
> +* Removes a previously registered callback for the given usage_id
> +* and hsdev. Once removed, the client will no longer receive data or
> +* event notifications.
>  */
>  int sensor_hub_remove_callback(struct hid_sensor_hub_device *hsdev,
>  			u32 usage_id);


