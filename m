Return-Path: <linux-iio+bounces-22045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD87DB12FB0
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 15:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300B53AF8BE
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3F1922F5;
	Sun, 27 Jul 2025 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDVjGufd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34214C9D;
	Sun, 27 Jul 2025 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753622331; cv=none; b=EHoKKZSpj05wYMySlrbKiQcqiQpvFOKqj7blVwi4Z0WL51j8gBNAIh/Wp/0wkPkSBLEt1efSQtprvsy4OsIhIs633yenZ70RJdrp1VglLIjaXfC7EG1IBLFtu9QW5Bd/Iw1pdPcSmgPzcZ3xmPEvPRYkrpPtvSN0+vm/JmqVQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753622331; c=relaxed/simple;
	bh=gJhuErowi/ktLtcvHrXlWxqi4/II7FRN7mkvKcdyM5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMlGToZyNC+fbOOhH817FuUgbucxcTOm1czhGocPItFlQSDq9tiQsMK2yT140Uk3zeJa2l8X8uyEQETnhbXGxynEusgOveSS9n2ytwBZPm05Pwnu8dP8I6b6QYoeg1vBSPc0vZHzRTUbf2Fc4zMq7nixQskfgwY0WCO93MqRF3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDVjGufd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1893C4CEEB;
	Sun, 27 Jul 2025 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753622331;
	bh=gJhuErowi/ktLtcvHrXlWxqi4/II7FRN7mkvKcdyM5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDVjGufd2h+rsUOt1LTp+YH09F/DrgnYAT4njNGx+uaFbdo9q3xiHeBNIyh7jG52K
	 UAINic1KYEglX5BOwQK3S1pQJWouVbwfa6eRsJW3rJQD8ArAogl1uOfiQaE37g9UwU
	 dQ5TW3fCjNbmde1Bv/AnatMxUMhl/93GeuWpO3FLp+9pOauRt/WIaPKxjqRYIvUznx
	 scOK2ACDe4qt6Y/O5hTZexNnsGM5Ow6WabUXrxC95E6kVZQkfgXdHhzduiGizgB9qO
	 bFyZfdqFQhT/CRLj//NTvHqFSMV1TwHnxiVG+hVAMMYUruw8aVvRSgGaz+V9Bq4HAg
	 1PbZWdPPzuETw==
Date: Sun, 27 Jul 2025 14:18:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: add power and energy measurement modifiers
Message-ID: <20250727141844.500c7416@jic23-huawei>
In-Reply-To: <20250721112455.23948-1-antoniu.miclaus@analog.com>
References: <20250721112455.23948-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 14:24:41 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add new IIO modifiers to support power and energy measurement devices:
> 
> Power modifiers:
> - IIO_MOD_ACTIVE: Real power consumed by the load
> - IIO_MOD_REACTIVE: Power that oscillates between source and load
> - IIO_MOD_APPARENT: Magnitude of complex power
> - IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency
> - IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)
> 
> Signal quality modifiers:
> - IIO_MOD_RMS: Root Mean Square value
> 
> These modifiers enable proper representation of power measurement
> devices like energy meters and power analyzers.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

This series seems to have dropped it's cover letter between v1 and v2.
Make sure it's there for v3.

> ---
> changes in v2:
>  - drop _accum modifiers
>  - drop dip/swell modifiers
>  - change power factor to be a chan_info

Do we ever need to getting for an IIO buffer? 

>  - voltage -> altvoltage for rms
>  Documentation/ABI/testing/sysfs-bus-iio | 14 ++++++++++++++
>  drivers/iio/industrialio-core.c         |  5 +++++
>  include/linux/iio/types.h               |  1 +
>  include/uapi/linux/iio/types.h          |  4 ++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 3bc386995fb6..0948611227a8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -169,7 +169,12 @@ Description:
>  		is required is a consistent labeling.  Units after application
>  		of scale and offset are millivolts.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_active_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_reactive_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_apparent_raw
>  KernelVersion:	4.5
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -178,6 +183,8 @@ Description:
>  		unique to allow association with event codes. Units after
>  		application of scale and offset are milliwatts.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_power_factor
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
>  KernelVersion:	3.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -1593,6 +1600,12 @@ Description:
>  
>  What:		/sys/.../iio:deviceX/in_energy_input
>  What:		/sys/.../iio:deviceX/in_energy_raw
> +What:		/sys/.../iio:deviceX/in_energyY_active_raw
> +What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
> +What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
> +What:		/sys/.../iio:deviceX/in_energyY_active_accum_raw
> +What:		/sys/.../iio:deviceX/in_energyY_reactive_accum_raw
> +What:		/sys/.../iio:deviceX/in_energyY_apparent_accum_raw

Seems the docs are still here from v1 for accum versions.



>  /* relies on pairs of these shared then separate */
> @@ -189,6 +193,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
>  	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
>  	[IIO_CHAN_INFO_CONVDELAY] = "convdelay",
> +	[IIO_CHAN_INFO_POWER_FACTOR] = "power_factor",

I thought David comment on this in v1.  No _ in new info elements because
of the complexity it makes for userspace. We sometimes do accept them still
if they are related to an existing element - hence trough_raw a few lines up.

>  };
>  /**
>   * iio_device_id() - query the unique ID for the device
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index ad2761efcc83..f26a0fbd6ab4 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -70,6 +70,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_ZEROPOINT,
>  	IIO_CHAN_INFO_TROUGH,
>  	IIO_CHAN_INFO_CONVDELAY,
> +	IIO_CHAN_INFO_POWER_FACTOR,
>  };

>  enum iio_event_type {


