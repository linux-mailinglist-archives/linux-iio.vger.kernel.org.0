Return-Path: <linux-iio+bounces-16946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2043DA649E9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 11:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740B216C94D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94148221D8B;
	Mon, 17 Mar 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gInaH23B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42938B;
	Mon, 17 Mar 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207423; cv=none; b=bW4pkz8bWahWtI88Pc9eWnKgKAK40+NZsrYkXMAQ05HGiECLJ5cRBxy0AFGuhgJ/JVljhIXz5BrhNJfTJo2QtaPyWyLB/arjcgTWaTtDt+/Txo2QttmvIfY2RUmxNOIVR2cyRgKKu2A7B1cw1qESIeKKBcpwYp+eJo+FBZn49fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207423; c=relaxed/simple;
	bh=hv9/X6byP5WTW/LEG12U9OUywdbJKsD9awuuj2uibE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayTjELm8QJFvLPCau/j7qR7jRLuooAc+6IqaFlnrtgthM6UP8k/wArDsyr7CgCTez7ucOdJLUFF4m1TeMJTISHqG5fdsyUq8dmnDQt0XAstbI9iP2HEWhJwrCmb9LBRK0veYEZyYOrxFZdyA/ZAX+uxxst0XE9J5zjza9aCJHcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gInaH23B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBBAC4CEE9;
	Mon, 17 Mar 2025 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742207422;
	bh=hv9/X6byP5WTW/LEG12U9OUywdbJKsD9awuuj2uibE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gInaH23B13hCyN19OZOq/Ey0TrTsnvmjO3RCmat4tfSqbP+l9W0Ww4L7qBUSmfZpm
	 d7s0gYQTXAB4q29w+8t6skicUC9IPHIrWEBOAJltnQPq4v+VisJHir6SKiVTr6PwQd
	 pdiHgP+8k0YhEeq4h703sHchk4G8jOfQF3yXzvQNYLCIwsDOdm9hCdtbE8UZ/rztXS
	 RMdDrra11JH85KkoZ9VAXhdz0o8P07zCWzbbh2MGzd+RE25eYQO9/hWQnHSkm8NJRr
	 2Ai0bSNM890sLfMiDeAsfWEBMKHlxFkVg9mGY2Rp+8KisiBmL3v9LxfCzaeQQjFlt9
	 I/pIpFW7SRW/Q==
Date: Mon, 17 Mar 2025 10:30:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <corbet@lwn.net>,
 <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v1 4/4] Documentation: iio: ad4000: Describe offload
 support
Message-ID: <20250317103012.0053bb42@jic23-huawei>
In-Reply-To: <18df335c2dd4c4db3bf27d68cbf1852425114131.1741970538.git.marcelo.schmitt@analog.com>
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
	<18df335c2dd4c4db3bf27d68cbf1852425114131.1741970538.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 14:19:33 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> When SPI offloading is supported, the IIO device provides different sysfs
> interfaces to allow using the adjusting the sample rate. Document SPI
> offload support for AD4000 and similar devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  Documentation/iio/ad4000.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/iio/ad4000.rst b/Documentation/iio/ad4000.rst
> index 468d30dc9214..2d56b0762570 100644
> --- a/Documentation/iio/ad4000.rst
> +++ b/Documentation/iio/ad4000.rst
> @@ -191,3 +191,20 @@ Typical voltage channel attributes of a differential AD4000 series device:
>  +-------------------------------------------+------------------------------------------+
>  | ``in_voltage0-voltage1_scale_available``  | Toggles input span compression           |
>  +-------------------------------------------+------------------------------------------+
> +
> +SPI offload support
> +-------------------
> +
> +To be able to achieve the maximum sample rate, the driver can be used with the
> +`AXI SPI Engine`_ to provide SPI offload support.

Can we make this more generic?  
"the driver can be used with SPI offload engine, such as the ...

I'm rather hoping we see others in the long run as useful little things!
> +
> +.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
> +
> +When set for SPI offload support, the IIO device will provide different
> +interfaces.
> +
> +* Either ``in_voltage0_sampling_frequency`` or
> +  ``in_voltage0-voltage1_sampling_frequency`` file is provided to allow setting
> +  the sample rate.
> +* IIO trigger device is not provided (no ``trigger`` directory).
> +* ``timestamp`` channel is not provided.


