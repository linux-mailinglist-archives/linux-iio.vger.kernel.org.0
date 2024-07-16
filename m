Return-Path: <linux-iio+bounces-7642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D75932F7D
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 19:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5881C22649
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0E1A01D1;
	Tue, 16 Jul 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYa6DURx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FD19FA94;
	Tue, 16 Jul 2024 17:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152368; cv=none; b=J0IYj7uexEYuWzEWu/IGLFx31GXNj91lXX/OntR7d/3JMkwV9Uxr5bKW+qp9+gd+OnKLGeDUSU6XXig6YijocYJTQ1dXp7f6t1qzDivhwuKSTsUehvPrrM6TUng3jj98ER8MDMpLghKySl9HCwgWQPbv2PI8ouTi5GptVLW4AYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152368; c=relaxed/simple;
	bh=Z/FuuYAY8mVsV8m3Aa8Y4k9HQ2e8WGXLvtIU2a/I7nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFDuXsiC299HR+IUTfV2mdFktbQqMJnV9l3USMXEeia8czBcWBK17myv9i6I154yCEd7ZXHClF76fnplM2VTYnRtEXdPQA1nmbB3dSmjs2P4LS5mAZcBfJm08jxphRZhDW1NaAhDR7aXQMDj5WQoNe/LKwm8NQT9d1mPhp+FKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYa6DURx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F33C116B1;
	Tue, 16 Jul 2024 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721152367;
	bh=Z/FuuYAY8mVsV8m3Aa8Y4k9HQ2e8WGXLvtIU2a/I7nQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lYa6DURxuLaei5aJYfNKzPBBCPBzJHTGOENpjPZt3Jjoo7s8Qr5FgjKjvyWc6Wv5U
	 dwc50D2XyIVBM97iwmFHO3zpo9RCq5eyCQZOXhYRK/BCVCgstud7c4rLrv4W72qwtC
	 IItz/1y8S/svfxRnfyqoh2rIYd7TVOIhnSW8DuRbg4adFIV4oafvGYCj8Y3DnD+4EZ
	 1RVSYKNEwlO2qw+N+6ZN+J6PEwDvEkbHVujFsvVqVzzR1+QMRuivH63O3n6BaPt6aI
	 m1NDT1BeGwXjBJyNcgmpCKQGMET4N2jozyU7fyiJLv3r6WjYoY6PI1VldZSD3cvouA
	 TezfQkGNfvZqw==
Date: Tue, 16 Jul 2024 18:52:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Jun Yan <jerrysteve1101@gmail.com>, Mario
 Limonciello <mario.limonciello@amd.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] iio: accel: add ADXL380 driver
Message-ID: <20240716185238.72483333@jic23-huawei>
In-Reply-To: <20240708104114.29894-2-antoniu.miclaus@analog.com>
References: <20240708104114.29894-1-antoniu.miclaus@analog.com>
	<20240708104114.29894-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 13:40:12 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADXL380/ADXL382 is a low noise density, low power, 3-axis
> accelerometer with selectable measurement ranges. The ADXL380 supports
> the +/-4 g, +/-8 g, and +/-16 g ranges, and the ADXL382 supports
> +/-15 g, +/-30 g and +/-60 g ranges.
> The ADXL380/ADXL382 offers industry leading noise, enabling precision
> applications with minimal calibration. The low noise, and low power
> ADXL380/ADXL382 enables accurate measurement in an environment with
> high vibration, heart sounds and audio.
> 
> In addition to its low power consumption, the ADXL380/ADXL382 has many
> features to enable true system level performance. These include a
> built-in micropower temperature sensor, single / double / triple tap
> detection and a state machine to prevent a false triggering. In
> addition, the ADXL380/ADXL382 has provisions for external control of
> the sampling time and/or an external clock.
> 
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

One locking (kind of) issue that I'll tidy up.

Applied to the testing branch of iio.git which will become togreg once
rebased on rc1 when that is available.

In the meantime 0-day will poke at it and see what we missed.

Thanks,

Jonathan

> diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> new file mode 100644
> index 000000000000..684778ace345
> --- /dev/null
> +++ b/drivers/iio/accel/adxl380.c
> @@ -0,0 +1,1906 @@
;
> +
> +static int adxl380_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct adxl380_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = adxl380_read_chn(st, chan->address);
> +		if (ret)
> +			return ret;

This returns without release direct mode which means deadlock
if you enable the buffer (that will wait unlike here).

If nothing else comes up I'll make the minimal change of
moving this down to after the release.


> +
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		*val = sign_extend32(ret >> chan->scan_type.shift,
> +				     chan->scan_type.realbits - 1);
> +		return IIO_VAL_INT;



