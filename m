Return-Path: <linux-iio+bounces-26260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4717FC617BB
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 16:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EF8D4E74EE
	for <lists+linux-iio@lfdr.de>; Sun, 16 Nov 2025 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4F30C600;
	Sun, 16 Nov 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp0PJBmS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5572C234E;
	Sun, 16 Nov 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763308219; cv=none; b=K6tyrsSvtc8+w+N8Mx2LNUJsbxJAULQsNFJZkgwrYROmsrI91elNags8ZNmopoWj/xDhPP6XQ/eNhMSfe9xSPuKtzH/2Y1KrRCrOLhg7vBu/fnNHtcY1MyONuHH+4ikuzpwEspTDsdodNUhd+UmdS3FMsUjA0rf5kCuwFxh14M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763308219; c=relaxed/simple;
	bh=kXjgfMT3ap72t7AEII8TY2g+vPGEOODjnzTwsgQON+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8CgjX0N4WhIhEVx1KZZG3sjKGrNHd/kHOUXQ+D7AXvhATvsSeOrXgJQ6kaTHR9/PrKOX6qvvOJbmpYSS7gEWaX8hWhDOXkOVl94jTFaqBECDOf4526LE2225tDmt+OpN1axyBvQrzXcY2H/hhKhZ+u0p/sfTYCqX5Etrzs0/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp0PJBmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06DEC116B1;
	Sun, 16 Nov 2025 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763308219;
	bh=kXjgfMT3ap72t7AEII8TY2g+vPGEOODjnzTwsgQON+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jp0PJBmS5aXMkiagvH98yMh+3K4KEUk52B/nwYTGJVtXeupj0GXfAxtIWI2TODJ44
	 CZJIMPb3SAWnfkPzh6EtPoMw+qlorC1hgIUKU4lAG7PcO+sycDar1X8kYCvO5wyw80
	 hoY7DppCjW4ZnjKxDYVUotFB7lY+DMaA4nJ0TxgCgIAlDJ2KIJka+0oWPfSrelYDbC
	 wuqttz/q8cnsrFLyhMhwH/nPPPvHPxnBL1xgx/GViwS1bl61RpNYFv+8/G3fr/iXtT
	 /R1rUfk1mPV9daaEYOG6asCwDjnbA6LX/Svk7y8zGqGbfmLMBHUPNBg7VfXLhMyla5
	 RfJaGvPbJtbFA==
Date: Sun, 16 Nov 2025 15:50:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation: ABI: adl8113: add documentation
Message-ID: <20251116155013.2b55af25@jic23-huawei>
In-Reply-To: <20251114115725.5660-4-antoniu.miclaus@analog.com>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
	<20251114115725.5660-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Nov 2025 11:57:25 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add ABI documentation for the ADL8113 Low Noise Amplifier,
> covering the 4 pin-selectable operating modes.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
+CC all the IIO subsystem reviewers as I'm not sure how to handle
what this device does, and would like some more opinions.

Anyone who has expertise or design experience with this sort
of amplifier with external bypass path: how are these actually used?

The development board seems to just be suited to measurement of
device characteristics, not representative of a design using it.

> ---
> 
> Changes in v3:
> - Replace "mode" attribute documentation with "signal_path" attribute
> - Update descriptions to reflect separation of gain control (hardwaregain) and path control (signal_path)
> - Add explanation of automatic bypass mode switching when selecting external paths
> - Update attribute names from mode/mode_available to signal_path/signal_path_available
> - Clarify that external paths enable connection of external components for filtering or amplification
> ---
>  .../testing/sysfs-bus-iio-amplifiers-adl8113  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113 b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> new file mode 100644
> index 000000000000..31fb1e6e80fc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> @@ -0,0 +1,30 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/signal_path
> +Date:		January 2025
> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute controls the signal routing path for the ADL8113
> +		Low Noise Amplifier. The supported signal paths are:
> +
> +		* internal - Signal passes through internal path. Can be used with
> +		  either amplifier mode (14dB gain) or bypass mode (0dB gain).
> +
> +		* external_a - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
> +		  (VA=0, VB=1). External components can be connected for filtering or
> +		  additional amplification. Automatically switches to bypass mode (0dB).
> +
> +		* external_b - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
> +		  (VA=1, VB=0). External components can be connected for filtering or
> +		  additional amplification. Automatically switches to bypass mode (0dB).

I'm still not sure how to handle these external paths.  The one thing they won't be
is truly zero gain (because that would be pointless given the internal bypass path does that).

So how are these used in practice?

Do we need to figure out how to describe the real characteristics of those paths?

All I could find is a brief reference in
https://www.analog.com/en/resources/app-notes/an-2622.html
to high dynamic range receiver applications. So with that as only breadcrumb my
guess would be that they almost always have additional applifiers on those paths
and we should figure out how to describe the aggregate device.

A stop gap might be to merge the driver without this support till we figure out
how to do it.

Jonathan


> +
> +		Note: Selecting an external path automatically sets the hardware gain
> +		to 0dB (bypass mode) since external paths require bypass operation.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/signal_path_available
> +Date:		January 2025
> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this attribute returns a space-separated list of all
> +		available signal paths for the ADL8113 device. The available paths
> +		may depend on the current gain mode (hardwaregain setting).


