Return-Path: <linux-iio+bounces-16966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0294DA64E95
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FB5188A1F6
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 12:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB1238D2B;
	Mon, 17 Mar 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QykA/HDk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7D21D3DF;
	Mon, 17 Mar 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214057; cv=none; b=IYwmcDT+vuMLlSyaX6+k5zAZN2132PnT8UshNBr4/UMoL+ZaMlB6edD7ZUtyUw+PIr0TZL137JtaeCeS8ralAVNkSlI5qPRnNjK6+f4UnG3E3KPTdzi0AYOl1DB38tZ6ill07YuuneLqL8b7N1tAwXECmYwKFAbuMpHawxzsYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214057; c=relaxed/simple;
	bh=40vcEAUQB/bv58lTJzX5uqa7lcv5qYAezG282mEVYsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZde3esXASJJEoqGtiQ5I0AcBtWghvTPkGqqJAeUusHklVrGhfjPo0FjezWJmgd2il72D3O24ZX1mks1HYTq4TqXhtF3rKbDEpHXlteYtBE0gdBy6tVD+6x6X2EseZXZXTRXzchceE0WCFqMsES73ySqBdvzplnK7TFLTuTm48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QykA/HDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD8FC4CEE3;
	Mon, 17 Mar 2025 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214056;
	bh=40vcEAUQB/bv58lTJzX5uqa7lcv5qYAezG282mEVYsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QykA/HDkqJIjV+jEvq04bBLhBvBywSOOZAdkY/1l5Pq0HzBIff/M1Pwyijj7NOCEE
	 piY3n6lFIQRuJbXUKRlmoseIdeiLDubD5DiNwHRjIKDldUclAwunj7PkmMsmxGOQLp
	 5JIBTG+tIkGmKdRNS1hz7i3X7TItdN/rbyQb/ireUkPhg2+PEchx4413sozS5stUlQ
	 xNIaNrPnJmMZuQT9Pvmyjx8p28KaQwS+1E2+VELNUk20Jkrw4lHANvMYtUrp1UQ7xq
	 PZ3AWcYuo4gKNZCjQPxRJZ+HXWMW44ZiHjbQWH1qGpABM8/tQ9yedqzQuA0JO2uT3w
	 DE+tzLn5EX0IA==
Date: Mon, 17 Mar 2025 12:20:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com, lars@metafoo.de,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hid-sensor-prox: Add support for 16-bit report
 size
Message-ID: <20250317122044.22091c4b@jic23-huawei>
In-Reply-To: <20250317013634.4117399-1-lixu.zhang@intel.com>
References: <20250317013634.4117399-1-lixu.zhang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 09:36:34 +0800
Zhang Lixu <lixu.zhang@intel.com> wrote:

> On Intel platforms, the HID_USAGE_SENSOR_HUMAN_PROXIMITY report size is 16
> bits. This patch adds support for handling 16-bit report sizes for the
> HID_USAGE_SENSOR_HUMAN_PROXIMITY usage in the HID sensor proximity driver.
> 
> Previously, the driver only supported 8-bit and 32-bit report sizes. With
> this change, the driver can now correctly process 16-bit proximity data,
> ensuring accurate human presence detection on platforms where this report
> size is used.
> 
> Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied. Thanks.

If it is reasonably urgent we could slip this in after rc1 as it smells a bit
fix like.  For now I've queued it for next cycle.

Jonathan

> ---
>  drivers/iio/light/hid-sensor-prox.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 76b76d12b388..3a7b48803d50 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -213,6 +213,9 @@ static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
>  	case 1:
>  		prox_state->human_presence[chan] = *(u8 *)raw_data * multiplier;
>  		return 0;
> +	case 2:
> +		prox_state->human_presence[chan] = *(u16 *)raw_data * multiplier;
> +		return 0;
>  	case 4:
>  		prox_state->human_presence[chan] = *(u32 *)raw_data * multiplier;
>  		return 0;
> 
> base-commit: eea255893718268e1ab852fb52f70c613d109b99


