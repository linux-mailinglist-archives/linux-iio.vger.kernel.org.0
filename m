Return-Path: <linux-iio+bounces-8914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A39967177
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 14:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ABD1F2184B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Aug 2024 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38B17E005;
	Sat, 31 Aug 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ6qhqly"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FC193;
	Sat, 31 Aug 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106521; cv=none; b=ubnuHnwNVTChc63bng55+TjiHf+HvVMJ5vZnpZ54DPXfKrqxCRQ1SRGv7098zyLkgZPSET3p7TropnO8ISbr45yAT0y+HxYCFCBDwE03bN6CN7f4ZpsnhoemNtryu/U6mnFvdCOHINmCLYByUCFhuV+jy8dVjCzH042d2zCtae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106521; c=relaxed/simple;
	bh=3m8j/b+dEWGBlzW4DZaiz+BCrW2VrLzgKQcu92RYzGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVn2+3NjBZVDODEG+2qM4eRSIh/cc/L73o5tU7gTDxOTi2iBnfEtvMWoJLWu6uubpF480/JP1mHmyLvZEhqjmjYT6QF0hbwjTbepjiHV2iVkCQ7pd3ugSW0g/qwnOhbJVqkBM+UXfYcVpBoHb1D6bM0Hecdc/bgdkpxmEOkoC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ6qhqly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8844FC4CEC0;
	Sat, 31 Aug 2024 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725106520;
	bh=3m8j/b+dEWGBlzW4DZaiz+BCrW2VrLzgKQcu92RYzGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQ6qhqlypC6vwLQrGxtvhO39plVvS4gFy/i3m4S6BlLcIyi1SL6chyYtIepmRUUF1
	 xJibguU7an4GY+BlR+CK7aMSm80GSGZRuaNuPlzy/XYxB8aZSPGfFu2qxdyBTl/IiK
	 tb8V8pc/65F/TSuflMIKu4OZ8nyKST1/48FPJVqOzJyJK4BQt6GV1rJ6Ptm4exX0rS
	 hmPcTZ7SswUBctCZ0wbERgPjtLdSxuNIyt3LqEA8X06Prmgg90/W8a00aCOJhQ4cYm
	 qPjzC7LrZSbMm6T2oZZ/tz1FpzF8uhgWKNos8fNUO8WbKL+DI7ZkEGLRM7rr/AI+X7
	 DyUmEAxJuQDEw==
Date: Sat, 31 Aug 2024 13:15:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 8/8] iio: ABI: add DAC sysfs synchronous_mode
 parameter
Message-ID: <20240831131512.7c5746e0@jic23-huawei>
In-Reply-To: <20240829-wip-bl-ad3552r-axi-v0-v1-8-b6da6015327a@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-8-b6da6015327a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 14:32:06 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Some DACs as ad3552r need a synchronous mode setting, adding
> this parameter for ad3552r and for future use on other DACs,
> if needed.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dac | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac b/Documentation/ABI/testing/sysfs-bus-iio-dac
> index 810eaac5533c..a3012baf90b3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-dac
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac
> @@ -59,3 +59,10 @@ Description:
>  		multiple predefined symbols. Each symbol corresponds to a different
>  		output, denoted as out_voltageY_rawN, where N is the integer value
>  		of the symbol. Writing an integer value N will select out_voltageY_rawN.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_synchronous_mode
> +KernelVersion:	6.13
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows a specific synchronization mode, mainly
> +		intended for DACs where multiple synchronization methods are available.

If we accept this it needs an _available as well + a list of the possible modes.
That list must be exhaustive across all devices so we constrain these appropriately.

However, right now this seems more like picking a trigger, or potentially the PWM
feeds into the spi offload code than anything else, so I'm not sure we want to
introduce new ABI for it.

Jonathan

> 


