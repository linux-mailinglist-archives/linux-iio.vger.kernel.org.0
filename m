Return-Path: <linux-iio+bounces-15593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD193A37615
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D32E16C438
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0521019CCF5;
	Sun, 16 Feb 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWWL35/y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CC450FE;
	Sun, 16 Feb 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739725010; cv=none; b=JRJc+Qv2oOsbHCKCzXwQ/nSsK4GFW00MIPSz1DEy0DKx2u4kNeLVpyb3IPbv080CcU71wavmGINOd3MKT4pm7HwHRPpGbd7Woybm8YxXWHJR/Tg+45xTP1oG6hZm6GRuhYFhQx7nbzgcTgi6zk2aBMB3Yu9FDirUpWPJG5j/WkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739725010; c=relaxed/simple;
	bh=lyYWlIL5pV+P204PWq9RJs+b2lncRmWinTLyKexeKLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AThv2TAFwm94dyA0Nxyb0npCSP7YR6+giWKVcTqn6S6cMaDD+wyyhwlkAJFftLNEU+iXqLLuNOE9UD3PMRmYIcywAIInvln9D5NhlhQ6Aw45FD4A8fvNZ9gVFgzJQsZ7PGF4tPPxkhvbZpn+PVEPAOF5B0myAjVMAXB0DO3pbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWWL35/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1F1C4CEDD;
	Sun, 16 Feb 2025 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739725010;
	bh=lyYWlIL5pV+P204PWq9RJs+b2lncRmWinTLyKexeKLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rWWL35/yPTnPOWL0B4OV5ivtP906jfLlk95gZBFEFPD1KEU7LxzPTLRF2cbiw4t/f
	 g0IZb/wjC1GLREddI86c3DLrjgnQKARWX++ZbObj7wcz9TBg9L5A+ok85ter9WYEna
	 r1UcfKL2SdvZdEOrekLomhS+jedss3VxXE1r0erQIeqTS2ehhUyrAmozCvOwtdwSI7
	 o2Z71IZuu7Vb10KpVXo+1ia0k89Dsvl/hLv79p7Npad1GL90eD9o7MQI2iGNDy42j+
	 5XFugBKU2eD5fABH/Jiz49YaiN6l15LXqmEYRt8D7k+B9jfJiYK7bAgWZQXj88nxOM
	 W95aP2wUQL9Gg==
Date: Sun, 16 Feb 2025 16:56:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 6/6] docs: iio: add documentation for adis16550
 driver
Message-ID: <20250216165640.2e89f617@jic23-huawei>
In-Reply-To: <20250211175706.276987-7-robert.budai@analog.com>
References: <20250211175706.276987-1-robert.budai@analog.com>
	<20250211175706.276987-7-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 19:57:03 +0200
Robert Budai <robert.budai@analog.com> wrote:

> Add documentation for adis16550 driver which describes the driver device
> files and shows how the user may use the ABI for various scenarios
> (configuration, measurement, etc.).
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
One minor comment inline.
> ---
>  Documentation/iio/adis16550.rst | 376 ++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst     |   1 +
>  2 files changed, 377 insertions(+)
>  create mode 100644 Documentation/iio/adis16550.rst
> 
> diff --git a/Documentation/iio/adis16550.rst b/Documentation/iio/adis16550.rst
> new file mode 100644
> index 000000000..f929c460a
> --- /dev/null
> +++ b/Documentation/iio/adis16550.rst
> @@ -0,0 +1,376 @@
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
> +and a triaxis accelerometer. The factory calibration characterizes each sensor for
> +sensitivity, bias, and alignment. As a result, each sensor has its own dynamic
> +compensation formulas that provide accurate sensor measurements.
> +
> +1. Device attributes

1 Again?

> +====================
...

> +
> +3. Device buffers
> +=================

> +4. IIO Interfacing Tools
> +========================

