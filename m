Return-Path: <linux-iio+bounces-13674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E1A9F8230
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9BA164399
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CFA1A2C29;
	Thu, 19 Dec 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6ip2Jxg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EBB1A2554;
	Thu, 19 Dec 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734629957; cv=none; b=RozRWQB46VPNnqumaP9S7MjKeybUdpzZaxUCXraGCzr+ITiR84ZAL5ig2jSyibVJ/2cVv4+KpfAmwVFvQ+95FxBT7NKAS7mDKQDAz546Fgphdvxe3Zsp1rpomkshptnjfwP77CPadZGfILZcZoU1skD1NicwouMfycUnCxYF2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734629957; c=relaxed/simple;
	bh=tQRnYbvi+pRc6DLDYVspkoo0DDlFqYHUnK2WBupV9tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQPXt38l3soppbZd2yXIXLyuXGe1gCDM1wVt6ZUddCQYh1bfj4Ttqxf1v2p74QnjVXOM4lT86hrnw7WXBu2qtRXt4rgSdElukhviIGTBox/H46dWadOhi/atylYNWoPOEBwY7qToloiYOb605C3YPugjyyX7E0pe2Vcrpo3FBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6ip2Jxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E6FC4CECE;
	Thu, 19 Dec 2024 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734629957;
	bh=tQRnYbvi+pRc6DLDYVspkoo0DDlFqYHUnK2WBupV9tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F6ip2JxgHffcatxOyH8ojZG3YeJ7VRp7u7JOQrmNFHzKwqt1TPUS5D4J/tSktEomM
	 Q09iHz06CdCFVIQX3eWvBFJN9lLPfXcCYwsvrPCaFUTTCO0Yza+YOhUQkBI+0Nbr6f
	 Djrygae+ICRMqudklG1ZRSIQeXShPIdAN1HnODjSi9jri/+512boSb+lQg2Vvcvgxc
	 kk3cWAi2XbpySKA8nQPrV5nV+kfpbjwa+bGezQpu7zQ2md7uLcpoHoJKyikkQidNzI
	 +umxekbHVlwXiJH3DQfQ0TJTNSaUOIHiM9LjS+i3Pr25nJEWT3WGa2HAuyx7RvW07b
	 4vrv8Q6hnlk5w==
Date: Thu, 19 Dec 2024 17:39:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Ramona
 Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shen Jianping
 <Jianping.Shen@de.bosch.com>, Alex Lanzano <lanzano.alex@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <robi_budai@yahoo.com>
Subject: Re: [PATCH v3 7/7] docs: iio: add documentation for adis16550
 driver
Message-ID: <20241219173905.7bad1f71@jic23-huawei>
In-Reply-To: <20241216144818.25344-8-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
	<20241216144818.25344-8-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 16:48:13 +0200
Robert Budai <robert.budai@analog.com> wrote:

> Add documentation for adis16550 driver which describes the driver
> device files and shows how the user may use the ABI for various
> scenarios (configuration, measurement, etc.).
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>  Documentation/iio/adis16550.rst | 389 ++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst     |   1 +
>  2 files changed, 390 insertions(+)
>  create mode 100644 Documentation/iio/adis16550.rst
> 
> diff --git a/Documentation/iio/adis16550.rst b/Documentation/iio/adis16550.rst
> new file mode 100644
> index 000000000000..fde38060f8fe
> --- /dev/null
> +++ b/Documentation/iio/adis16550.rst
> @@ -0,0 +1,389 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +ADIS16550 driver
> +================
> +
> +This driver supports Analog Device's IMUs on SPI bus.
> +
> +1. Supported devices
> +====================
> +
> +* `ADIS16550 <https://www.analog.com/ADIS16550>`_
> +
> +The ADIS16550 is a complete inertial system that includes a triaxis gyroscope
> +and a triaxis accelerometer. Each inertial sensor in the ADIS16550 combines
> +industry leading MEMS only technology with signal conditioning that optimizes

Trim out the marketing bits.  So just loose this sentence.

> +dynamic performance. The factory calibration characterizes each sensor for
> +sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
> +compensation formulas that provide accurate sensor measurements.
> +
> +The ADIS16550 provides a simple, cost-effective method for integrating accurate,
> +multiaxis inertial sensing into industrial systems, especially when compared
> +with the complexity and investment associated with discrete designs. All
> +necessary motion testing and calibration are part of the production process at
> +the factory, greatly reducing system integration time. Tight orthogonal
> +alignment simplifies inertial frame alignment in navigation systems. The serial
> +peripheral interface (SPI) and register structure provide a simple interface for
> +data collection and configuration control.
Drop this whole paragraph for similar reasons.

Otherwise LGTM

Thanks,

Jonathan



