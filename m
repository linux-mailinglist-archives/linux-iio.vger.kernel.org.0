Return-Path: <linux-iio+bounces-27618-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79374D0F05F
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 15:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33DE6300C5CC
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B000338939;
	Sun, 11 Jan 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFYYUWy4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F192B188596;
	Sun, 11 Jan 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140103; cv=none; b=cwadUktD4iQtiADRbXz6HE3LROneBfUbl+vxz8evcXSEZjgNuNCjyw4LNjGnTXgkfeepPN9+qMq7B14dnQ7Urq18C0S1uuVG2juKQ807kc7LpQ8iWti60ZzxxWlsdZ7bGrTbyErpXr0fZGb2K+qNKZ1CCXTPKVN06pE6bEB6MVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140103; c=relaxed/simple;
	bh=OVfSkBTMqdMMu0fxI2SYdXl5/Db8VN1gnwgbW9dMlOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfwWChAMosbcG28K5RcPpKxz64+sn1D2V4zCPY/hph0BgQU7vXQQmQ0cq3bkTQyErYdnYYPOmONy5SLjFZPDMGxA+9uMKLxDjOf3aBiC8jVUy1vKrKDrMdj8h9sN0yC1Zxl7Ch8FfCygUcDqlPeoh5MXcW1SqAOjdX7VWxvY20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFYYUWy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9A8C4CEF7;
	Sun, 11 Jan 2026 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768140102;
	bh=OVfSkBTMqdMMu0fxI2SYdXl5/Db8VN1gnwgbW9dMlOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFYYUWy4dWs2RApat9l5Ie+JRgSOGDpPe/kF7mr1xaWHghhNmbSULOupNDsVlbyFT
	 JqZnmLCBTFnPLn8vvxIwXuvP3k3jHK45WBwOJrztRlgfmt6p32DzLr81cDQLsOuxy2
	 +uOt4w9I18d3DYRqjJgQOZfqC+F31KhCX8nodeCVY7eCARuRhxtAFyFJk5TkqGFSfF
	 M1ODjOy2GuN28Dsol3IKRdLWoHDqDZe1INV3sPMScPB1Um523ZQjuE6lO7d3qPPPac
	 2hOb+hnfvslEs8Q4Vbzp9Sg0YafffPG+pl/lpicZDIbWr/xV5lrUe42qCJoe0NiPF+
	 TsAxIlH5eGNcg==
Date: Sun, 11 Jan 2026 14:01:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 6/6] Documentation: ABI: testing: add common ABI file
 for iio/frequency
Message-ID: <20260111140132.667a02e3@jic23-huawei>
In-Reply-To: <20260108-adf41513-iio-driver-v3-6-23d1371aef48@analog.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
	<20260108-adf41513-iio-driver-v3-6-23d1371aef48@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 08 Jan 2026 12:14:55 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add ABI documentation file for PLL/DDS devices with frequency_resolution
> sysfs entry attribute used by ADF4350 and ADF41513
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Both docs patches LGTM. thanks,

J
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-frequency | 11 +++++++++++
>  MAINTAINERS                                       |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> new file mode 100644
> index 000000000000..1ce8ae578fd6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency
> @@ -0,0 +1,11 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_resolution
> +KernelVersion:	6.20
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores channel Y frequency resolution/channel spacing in Hz for PLL
> +		devices. The given value directly influences the operating mode when
> +		fractional-N synthesis is required, as it derives values for
> +		configurable modulus parameters used in the calculation of the output
> +		frequency. It is assumed that the algorithm that is used to compute
> +		the various dividers, is able to generate proper values for multiples
> +		of channel spacing.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bb7d9fe7ed8..f0dc0e7c1bbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1615,6 +1615,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-frequency
>  F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
>  F:	Documentation/iio/adf41513.rst
>  F:	drivers/iio/frequency/adf41513.c
> 


