Return-Path: <linux-iio+bounces-11378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072EF9B1CD0
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 10:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D901F218FB
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66566F2FE;
	Sun, 27 Oct 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmRunZVL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB43FB0E;
	Sun, 27 Oct 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730021646; cv=none; b=Be13/EMa7i+xS0RJmCpl4j8PnvSDum5iVb785CwxmOf4NH27FSzO08lAIpT0YiDbdt5UrW5CWYs0/XliYuTgfg8aBkRbaC4fQkg5qV3lUUrwM6h9kp7mGglrnP9zQYPem3y/aigAE2laytVVLpRYiIVDW0VfzsNuDxYRbQ1vFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730021646; c=relaxed/simple;
	bh=4qDQ7jsENsMqFEtZZDIVOwVaAbLyCb99GgPWAula/hI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/KlfuTkKhl2kh6hfZYLqnYePPbtg7bwX4+0/elkTKAphVQwUfvG+hzSdRKPH0B57TTwth62klBdb/aXCbzj68VCAccqXzme+J8VtoISKjrg0Fm+rIg7ZCHytg5n4WxC25MzJznYLmYb5wIk3lWGaj8pzkxaWcSGsLY4w2qciS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmRunZVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37264C4CEC3;
	Sun, 27 Oct 2024 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730021646;
	bh=4qDQ7jsENsMqFEtZZDIVOwVaAbLyCb99GgPWAula/hI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gmRunZVL/Ouz/wqKELL48Zmk3jPYI75ckfrMzTV6DCbuayoEx/TIkfOBKmq0l8u6n
	 rYrsW1RAjCxYwQpvPow6ktAZl6PahYewGASUeZO5M4OFJIs+YBruk/+A8/HIsLCgjH
	 jXHtFDuqr9muB2N4vlcziJl7UH3Q8WDqJVXZVH5jU7Th8594yL3oH9JhkD+DmnXdgp
	 /XN7Dob1uyRyAr2R3IQ8lFTA8jdgbn1Jo0ElhR7eDqjyq7I9w1+3WPjgbx0m6w3afQ
	 J9vDmAeR4wXfQo8plbgMWTHZig9ndMVYIS9sCjrJhI3NPmDPcA/mk3gjGJWZ1gAigY
	 /xNoeKrR8ZM7g==
Date: Sun, 27 Oct 2024 09:33:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] docs: iio: ad7380: add adaq4370-4 and adaq4380-4
Message-ID: <20241027093355.190689d0@jic23-huawei>
In-Reply-To: <20241024-ad7380-add-adaq4380-4-support-v3-4-6a29bd0f79da@baylibre.com>
References: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
	<20241024-ad7380-add-adaq4380-4-support-v3-4-6a29bd0f79da@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 10:16:59 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Adding documentation for adaq4370-4 and adaq4380-4 supported devices. In
> particular, document the reference voltage mechanism and the gain
> parameter that are specific to adaq devices.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Totally trivial comment inline.

Given the stalled nature behind the fixes, if you could spin a v4 with
this minor stuff addressed that would be great. FWIW under normal circumstances
I'd probably just have tweaked most of them whilst applying.

Jonathan
> ---
>  Documentation/iio/ad7380.rst | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
> index 6f70b49b9ef27c1ac32acaefecd1146e5c8bd6cc..ae408ff2fa9c97427a9fef57020fb54203d2d33e 100644
> --- a/Documentation/iio/ad7380.rst
> +++ b/Documentation/iio/ad7380.rst
> @@ -27,6 +27,8 @@ The following chips are supported by this driver:
>  * `AD7386-4 <https://www.analog.com/en/products/ad7386-4.html>`_
>  * `AD7387-4 <https://www.analog.com/en/products/ad7387-4.html>`_
>  * `AD7388-4 <https://www.analog.com/en/products/ad7388-4.html>`_
> +* `ADAQ4370-4 <https://www.analog.com/en/products/adaq4370-4.html>`_
> +* `ADAQ4380-4 <https://www.analog.com/en/products/adaq4380-4.html>`_
>  
>  
>  Supported features
> @@ -47,6 +49,12 @@ ad7380-4
>  ad7380-4 supports only an external reference voltage (2.5V to 3.3V). It must be
>  declared in the device tree as ``refin-supply``.
>  
> +adaq devices
> +~~~~~~~~~~~~
> +
> +adaq4370-4 and adaq4380-4 don't have an external reference, but use a 3V
> +internal reference derived from one of its supplies (``refin-supply``)
> +
>  All other devices from ad738x family
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> @@ -121,6 +129,16 @@ Example for AD7386/7/8 (2 channels parts):
>  
>  When enabling sequencer mode, the effective sampling rate is divided by two.
>  
> +
The double line break doesn't seem locally consistent.  A double break seems
to be reserved for before sections with === level titles only.

> +Gain (adaq devices only)
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +adaq devices have a pin selectable gain in front of each adc. The appropriate
> +gain is selectable from device tree using the ``adi,gain-milli`` property.
> +Refer to the typical connection diagrams section of the datasheet for pin
> +wiring.
> +
Nor this one.
> +
>  Unimplemented features
>  ----------------------
>  
> 


