Return-Path: <linux-iio+bounces-12912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A629DF571
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 12:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893BA2811C4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E114A4C3;
	Sun,  1 Dec 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6WBNGe2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A113A268;
	Sun,  1 Dec 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733054330; cv=none; b=XQl1vHnifffPyJr5JScj2FElRW762WsSjZKCGY6m9sTAlory5sSJRnErh5lxSvyQH38Fs8mBLr8yW5SjLd8rBqhxYB8UlEr3LT1Ibhs6yJMpLPlW8gqK6vWCesnfOpswMNw7sxmVT5C+NLK2fd2pnoRdOqJf8eN1SsaHbZNCxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733054330; c=relaxed/simple;
	bh=ww/5R5QLexsZheajEMB9wIqolOGPQwBsnhwtDOYv5xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PufP7xg9ax8YYAGe9k5DgkGWJoptYRCK0iEJZlVixQVHYpqL8c845AzjXvkM/6OA1JVLqOTjsgyIUF0VC972MncQ1bCROf4n+48eiYA7659Re0/PCHdH1pN1uLVzTMOiZY5Dv4q7PMum6Dge/pa2srjDWV5Fm8fvOmjIV+dzVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6WBNGe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0C1C4CECF;
	Sun,  1 Dec 2024 11:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733054330;
	bh=ww/5R5QLexsZheajEMB9wIqolOGPQwBsnhwtDOYv5xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6WBNGe2dFFCdUPslpLEb8jGQrAiZzdXI64LvDfYeH3lvQc5zZdE1UV1wVILYSSEJ
	 DHvrHnzZKUvSzrGuiRKV+OgBeZp/tO/jfDUXg0/06Cmj6dKe/GKlDDY/OU6bPtGilh
	 qNN5oM/qdFUJTMKNVZSAGacTR+UWn98aheiEErmjO5zPDdfzSD6RL4dHMmcKoIHu3v
	 hm1tKdLGLaIL7Sv1fBXZLLfI9sykXGmg+/U/Z3FgZsxKIvKFs5hkNCgjyWhSAk3w2w
	 X+4T/CECo+OtOieQ8Ck2GTbm6Nyt9buq3aoWNuF7hDgBHj8dKzcjIZdcGNrTBXdJfT
	 GboUAE9yqKeHQ==
Date: Sun, 1 Dec 2024 11:58:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: light: Add support for the AMS TCS3430 color
 sensor
Message-ID: <20241201115841.0ee49736@jic23-huawei>
In-Reply-To: <20241130174239.3298414-2-paulk@sys-base.io>
References: <20241130174239.3298414-1-paulk@sys-base.io>
	<20241130174239.3298414-2-paulk@sys-base.io>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 18:42:39 +0100
Paul Kocialkowski <paulk@sys-base.io> wrote:

> The AMS TCS3430 is a XYZ tristimulus color sensor, with an additional
> infrared channel.
> 
> This driver implements support for all channels, with configurable
> integration time and gain. Both direct reading and triggered-buffer
> modes are supported.
> 
> The device's interrupt can be used to sample all channels at the end
> of conversion and is optional.
> 
> A thereshold mechanism is available in hardware but only applies to
> the Z channel. As a result it is of very low interest and was not
> implemented.
> 
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>

Hi Paul

As at least some of the feedback I gave on your other driver applies
here as well, I'm not going to review this version separately.

I'd generally advise against sending multiple similar drivers for review
at the same time as it is less efficient.  Sad truth is that reviewer
time is generally a bigger bottleneck for kernel code than the time
of driver authors.  Any time you can put in to help with that will generally
also accelerate the rate at which we get to your code!

Absolutely fine to overlap your submissions though. When the first
driver is getting close to being merged, feel free to send the second
one to get review started.

Thanks,

Jonathan

