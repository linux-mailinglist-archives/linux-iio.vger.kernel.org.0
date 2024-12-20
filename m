Return-Path: <linux-iio+bounces-13735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707FD9F9AE9
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 21:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FF916A24E
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442FA157A48;
	Fri, 20 Dec 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGRbc2cc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDCD21B1BF;
	Fri, 20 Dec 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725376; cv=none; b=qJ1G4H1LF/ngHqvSy924qAkhCvaJcjR21pPv/vxibnDQ5hA3BcKUDlResYw3Hh4eOoTFG4814KHdbORWoizAByJdzSe86CQq/6B6FVzSmh98AbMbCbh3Pdu1d+xWqJWO9Q0AM5IWUcm4tgSG4gIL9k1N4UnffFN2xyqROyQJnqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725376; c=relaxed/simple;
	bh=NiubEGwL32goWTVWGWZCjRqyuj/w2Jz2YOYyclIVTX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhi7Kd/c13W0P7ND7owU1kXtot8lExW+ngmCJ3XPWTfvIOc/6aQ7CfAur1pjlOCt/TGhse5dOIyXeD6Mt9mNkdnBBfs/YxlMIknmoG1m6PVY0eeR3syDECMt6DChtc9GwWd9iitYeqNdyhF31fx7JyyPuz6SorfUVUnRoU7IezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGRbc2cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5565AC4CECD;
	Fri, 20 Dec 2024 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734725375;
	bh=NiubEGwL32goWTVWGWZCjRqyuj/w2Jz2YOYyclIVTX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WGRbc2ccm++0a9dKG7ITPYX7Q3jZaQ6mWul7KHxnGSOG1lNrGg2yWNcPeW4yLjUYu
	 pTfDIjcRKw+pI933jtlrqGwHjdLBKfxcsJffMxqvQaMHp/sVV60ZKiFd5zfJZTVJiQ
	 Oggw0rp5EbjPszPyheBXoe6Zzr7nfhDoPNSc+hGttwMRMo1NAhC7BVhBE1ivXMkwxm
	 wTcryjNmSi2+djRLfDtKkv897iojr6xwiw0OWhrYCbr8LoyrBBkT6xn6OfGu7VAinW
	 KR4vaVEJ9We5ftd8MXVU392fLKmiR/dOI3T2YKZKecZ9g/6WJCmkrEsbwkt9YrsK/u
	 cjMqsyy+tv9DQ==
Date: Fri, 20 Dec 2024 20:09:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: ABI: combine current input sections
Message-ID: <20241220200928.224f7313@jic23-huawei>
In-Reply-To: <20241219-iio-abi-combine-current-input-sections-v1-1-8dcd8221d469@baylibre.com>
References: <20241219-iio-abi-combine-current-input-sections-v1-1-8dcd8221d469@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 13:25:23 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Combine two duplicate sections describing in_currentY_raw.
> 
> This went unnoticed until we renamed in_currentX_raw to in_currentY_raw
> and the kernel test robot found the duplication.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412200256.OB5Hmw5Q-lkp@intel.com/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
Thanks,

J
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d97c35057a034c76ed433e3e6de0aff8ec4bbb70..25d366d452a55293c420300335a0271a28855107 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -168,18 +168,6 @@ Description:
>  		is required is a consistent labeling.  Units after application
>  		of scale and offset are millivolts.
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
> -KernelVersion:	3.17
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Raw (unscaled no bias removal etc.) current measurement from
> -		channel Y. In special cases where the channel does not
> -		correspond to externally available input one of the named
> -		versions may be used. The number must always be specified and
> -		unique to allow association with event codes. Units after
> -		application of scale and offset are milliamps.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
>  KernelVersion:	4.5
>  Contact:	linux-iio@vger.kernel.org
> @@ -1700,15 +1688,18 @@ Description:
>  		or without compensation from tilt sensors.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
> -KernelVersion:	3.18
> +KernelVersion:	3.17
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw current measurement from channel Y. Units are in milliamps
>  		after application of scale and offset. If no offset or scale is
>  		present, output should be considered as processed with the
> -		unit in milliamps.
> +		unit in milliamps. In special cases where the channel does not
> +		correspond to externally available input one of the named
> +		versions may be used.
>  
>  		Channels with 'i' and 'q' modifiers always exist in pairs and both
>  		channels refer to the same signal. The 'i' channel contains the in-phase
> 
> ---
> base-commit: fe2a04fbcbfe44694fcb36ff6212fce54b8f56cc
> change-id: 20241219-iio-abi-combine-current-input-sections-c62cf5dbfa9b
> 
> Best regards,


