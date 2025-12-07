Return-Path: <linux-iio+bounces-26885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E859CAB68D
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62DF304B23B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F2243968;
	Sun,  7 Dec 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al+qp1m/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2CE264FBD;
	Sun,  7 Dec 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765120901; cv=none; b=rPr4eyEwkv8WZKhjnmrWVhz3L1bp6cdNBAzZ+zQUWk8p1G73IzrEJyLQMqTRvPWP2QQ1HyYJHmbCLcwzCwDMAHi2ULpUFiZODXW+hJyRhF10WfI+KSGvL2CFhJVnQ/ccA9g3j4jhmIB05S8QOB2TTd8jZBMGDXI6DND6WA/WxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765120901; c=relaxed/simple;
	bh=G1j1p/tMyuaqXvyL2ZdmhIMUeVeE8fLU7860VdI+wMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iUNL4Qq+1/PR2SqOuMb78tQm30Tyai74RTu/HYGELneGqME0nN12UGgYQDftFlSVdkAh/oSj/0j53rQ+VnaKfMZtQQUqp1+wHA6NP0QgwVpOA/zhuVx/1l79SiIui3bqE/NHv96O5abQa1+8zHoo69ZoUHXVi6XL0A2AAM9qB6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al+qp1m/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237D5C4CEFB;
	Sun,  7 Dec 2025 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765120900;
	bh=G1j1p/tMyuaqXvyL2ZdmhIMUeVeE8fLU7860VdI+wMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=al+qp1m/pxveawT9Ed4Jk4VuZCvtR85VavTtmGs96Vvcizd7wgZ8N9CNHt4NU17/W
	 WXph07IUc9ZNLqdcL7TdVmuQzyORY72su9vWjxQYXG8Z5g6k41JG6Qwp9vxmZ7qXs0
	 9O/E7rUhuKyuF5yQR7bFRJpMc0ANnP2wDeSltxT+1j3tZougAIjsKa6x9+6dQnJCsz
	 facMAKlD6x1D8M2wh9bb6n5QRavPJ2uyMJ2oLYf0wG3fsYURWaE/vl8gJBATxehv2r
	 DcuXTRRgLbBBG7LE8i02Ybc7FAgGoDY5Nnpan6KFJi22yDnUMXDwsCinl9kcucNAqM
	 Ys21j3iZSdcfw==
Date: Sun, 7 Dec 2025 15:21:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 2/9] iio: imu: st_lsm6dsx: make event_settings more
 generic
Message-ID: <20251207152131.6734c1ca@jic23-huawei>
In-Reply-To: <20251201100018.426749-3-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-3-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:11 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> The st_lsm6dsx_event_settings structure contains fields specific for one
> event type (wakeup). In preparation for adding support for more event
> types, introduce an event id enum and a generic event source structure, and
> replace wakeup-specific data in struct st_lsm6dsx_event_settings with an
> array of event source structures.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Given I've largely forgotten what this looks like but it has some good review
I'm going to do the application one patch at a time.
That should also reduce what we need to handle if there is a clash with
the fix going a different path.

Applied this one to my local tree. I'll rebase that on rc1 once
available and push out as togreg at that time.

Thanks,

Jonathan

