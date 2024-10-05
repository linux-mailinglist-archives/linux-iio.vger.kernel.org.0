Return-Path: <linux-iio+bounces-10186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA759918A3
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563AD282D56
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49924158853;
	Sat,  5 Oct 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAOjZsX7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E6155C87;
	Sat,  5 Oct 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147733; cv=none; b=FOth4bwAOgDMH/D6d634RAr1kB4C0l2uAmWmrVCgQC7G/EiY0BviN1y72OhdculcSwtb3ojH+NR7R4J9wxuNNP14BfAxgis/NlLVlVt6c63NtSpn+pQXmPSChN1U0ButDPNbwa33I9cTlk3m3X8bgOda6NWvTwAHRyKcxgwchqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147733; c=relaxed/simple;
	bh=S+e+JF0dZsn511VhwVceu6wRmxg9cTck6zJkgByEUEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZeKE6OJ5B/Of7E1BX8V0fs1zMxS8vMEHH4XlMqxb7YnriPreZr7K2BYLCHFrUFg635ylQbg41uPaOWOK0ZPQYJeG+3BzI99B2y/tXl34vjV4CyNG8IgJf1wQwuUMXXttCkXCY7U464cOnTO0ZXquaIdIfkGI/kwJNfcsTXFTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAOjZsX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BA8C4CEC2;
	Sat,  5 Oct 2024 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728147732;
	bh=S+e+JF0dZsn511VhwVceu6wRmxg9cTck6zJkgByEUEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAOjZsX7DkJMht225xrXAMbwpfkvKYi6m2xsfznnCw5CG1iOCj8Wuc5PaCx6t/CQ7
	 Q+vkBqGhhaKKdIXzogXSHZ6BoY+F3zmCYdjO8yzCkwcOE49XHNrfI8gnMGf5RsbuVV
	 I/A3iiwe2lLRshll2BZyi/RxB4ysdUmeurGq40ujzD6BBFM/opgr1FgKgPsMpZUPZf
	 YYHM+zkiLX+Enz7gZwS4EgpJkL+qmWbE0sVnzGixIrcJ0KzzX5FimbtTN1YqymDMe1
	 m9wgKHCaZhVfXKZo+wuaTGvEdOvk24H9VUqKCl3VUYsrDWTKV1VX35jZGzfWUme9Po
	 N+fB4pDpcgq5Q==
Date: Sat, 5 Oct 2024 18:01:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhash Jha <abhashkumarjha123@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Interrupt and Continuous mode support for VL6180
Message-ID: <20241005180151.2f70cbef@jic23-huawei>
In-Reply-To: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
References: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Oct 2024 21:22:22 +0530
Abhash Jha <abhashkumarjha123@gmail.com> wrote:

> Hello,
> 
> The first patch adds support for configuring the Sampling frequency
> (inter-measurement period) of the sensor. The values must be provided
> in miliseconds. The default value for the inter-measurement period for
> ALS is 10ms and for Range is 50ms.
> 
> The second patch adds support for interrupt based single shot reading.
> We registered an irq_handler that fires everytime the data is ready.
> And then we read the appropriate value in the `vl6180_measure` routine.
> 
> The third patch adds support for continuous mode in the sensor by using
> buffers. We enable the sensor's continuous mode in the buffer_postenable
> function depending on the `active_scan_mask`.
> The continuous mode can be disabled by disabling the buffer.
> Added a trigger to the device for the continuous mode. Also validating that
> the device uses the internal trigger provided by us.
> 
> Changes in v2:
> - Fixed `label followed by a declaration is a C23 extension [-Wc23-extensions]`
>   by moving the guard(mutex)(&data->lock) above the switch statement.
> 
> - The above error was pointed out during testing by kernel-test-robot
> 
> Thanks,
> Abhash Jha
Hi Abhash,

I left comments on v1.  Even for a compile issue like this one, maybe just
a quick reply to the earlier posting saying what you will change is more
appropriate than sending a new version just one day after the first.

Not a bit thing, so just check those reviews on v1.

Thanks,

Jonathan

> 
> 
> Abhash Jha (3):
>   iio: light: vl6180: Add configurable inter-measurement period support
>   iio: light: vl6180: Added Interrupt support for single shot access
>   iio: light: vl6180: Add support for Continuous Mode
> 
>  drivers/iio/light/vl6180.c | 266 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 249 insertions(+), 17 deletions(-)
> 


