Return-Path: <linux-iio+bounces-15174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506CA2D70A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0851673E4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 15:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADE248171;
	Sat,  8 Feb 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxdwfUqJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B3117597;
	Sat,  8 Feb 2025 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739030034; cv=none; b=aTZbsLPsk2VG8CK/PST1giBDd9uVLFHK+oCGq8/towI+wQDAEZ/jGSKOasvnrPPjMAzARMQRWNRaU02XRXS95Vh5heRAr9If1JIAg7OcAxLPTiFMBWz56BnF3UI5/rq3dhlZbSOSx7OH5g6hd7ErQ4sbyQ6ESamoGLKNnhs3YXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739030034; c=relaxed/simple;
	bh=hrd6oBUOsWOJwveXn3feTKiMBZdQKoAvHAAZMfAr5DM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLXOu1ZNQvf7ujCxr4HGiBCxiUc0qeKJzxSmPDctIOe+ALL0b6Ben6J7DneXg3sgu9DLWwDXc0UnxUH4R0fLqmmXOwOve9JA7+MtZ2RTfxibKrjdWIASHLQAUTdoDY2vKALrX9EndeOQpGswSAf+TyPGiGxTpkCRmevJMdSjo/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxdwfUqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A537C4CED6;
	Sat,  8 Feb 2025 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739030034;
	bh=hrd6oBUOsWOJwveXn3feTKiMBZdQKoAvHAAZMfAr5DM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WxdwfUqJaCJuZpuA9ewGIQR9RpNqlmAQrr0PeXFfQSdv58hAvLq6zDeQYH5fBu9DB
	 aL5KMhtsVxSQhSQBWqUjMlQDxIxdqjyoRQ7P+rMyMOL8YhrUpyEgfDm7i/3+HC4AUB
	 JFoQ6LhcgvidsClaTyxcNgW0Vf0V//29eqprnqrQRoEWvJtk7Cxgl1gEWtvkbyJHG8
	 pZtR49lIVPwZVDl1jJRmuHjxmRSdgSCX5zHDLr0I+mK8EIZ4HByf5g2HNlcV9SBjOq
	 81XBvQPfqcTHdnrYGq4X6nYqmt97ADEQm43DJw7tx4cO/6GPitgNA39tHfSIRY06nN
	 4cVNEHgLTBXKA==
Date: Sat, 8 Feb 2025 15:53:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: <robh@kernel.org>, <lars@metafoo.de>, <krzk+dt@kernel.org>,
 <kernel@axis.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: add IIO_MOD_NOX modifier
Message-ID: <20250208155346.3fd5a316@jic23-huawei>
In-Reply-To: <20250206061521.2546108-2-Hermes.Zhang@axis.com>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
	<20250206061521.2546108-2-Hermes.Zhang@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:15:15 +0800
Hermes Zhang <Hermes.Zhang@axis.com> wrote:

> Add modifier IIO_MOD_NOX for NOx concentration reporting. NOx (a generic
> term for the mono-nitrogen oxides) are used in environment sensor as a
> parameter to show the concentration in index format.
> 
> An example case: https://www.sensirion.com/media/documents/9F289B95/
> 6294DFFC/Info_Note_NOx_Index.pdf
Use a Link tag directly at the top of the tag block (no blank line between
it and your SoB)

> 
> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  tools/iio/iio_event_monitor.c           | 2 ++
>  4 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index f83bd6829285..c7d54dc1f226 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1898,6 +1898,8 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_o2_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_o2_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_voc_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentration_nox_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationX_nox_raw

This section defines the units as percent.  Given the link above, this nox value
seems very much to not be in percent and arguably isn't a concentration measure
or if I read that right even a scaled value of that.

I'm not sure how we handle this in a consistent fashion :(
At very least needs a new documentation block with the details of these units.
This a raw attribute so it doesn't have to be possible to scale it to a 'standard'
unit (light color sensors / intensity channels for a similar example).

Is it possible to compare readings off sensors from different companies?




>  KernelVersion:	4.3
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a2117ad1337d..6a85688c9148 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -151,6 +151,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_PITCH] = "pitch",
>  	[IIO_MOD_YAW] = "yaw",
>  	[IIO_MOD_ROLL] = "roll",
> +	[IIO_MOD_NOX] = "nox",
>  };
>  
>  /* relies on pairs of these shared then separate */
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 12886d4465e4..f7dfc4c71495 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -108,6 +108,7 @@ enum iio_modifier {
>  	IIO_MOD_ROLL,
>  	IIO_MOD_LIGHT_UVA,
>  	IIO_MOD_LIGHT_UVB,
> +	IIO_MOD_NOX,
>  };
>  
>  enum iio_event_type {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index cccf62ea2b8f..51c6f753e7d4 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -138,6 +138,7 @@ static const char * const iio_modifier_names[] = {
>  	[IIO_MOD_PITCH] = "pitch",
>  	[IIO_MOD_YAW] = "yaw",
>  	[IIO_MOD_ROLL] = "roll",
> +	[IIO_MOD_NOX] = "nox",
>  };
>  
>  static bool event_is_known(struct iio_event_data *event)
> @@ -236,6 +237,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_MOD_PM4:
>  	case IIO_MOD_PM10:
>  	case IIO_MOD_O2:
> +	case IIO_MOD_NOX:
>  		break;
>  	default:
>  		return false;


