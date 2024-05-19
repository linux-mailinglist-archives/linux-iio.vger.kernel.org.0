Return-Path: <linux-iio+bounces-5113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 081478C950F
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE01F21881
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5BA4C635;
	Sun, 19 May 2024 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZjYfE/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880404AEDA;
	Sun, 19 May 2024 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129501; cv=none; b=VqxZdEAfvb7fFOOmjtvEgQNXQ0On9Rudfx/iyMGbx7PXHvXwn8Yu5grDBNpeYS3xWrhJZ2dtmwifgFibaADjfOrw29XS6tY5DXIr6hj0EpQSaAB2YT7Giavrkn5gpj7ydjIjSeZOOrqSMWQ6aCAblBw32+t1z7Gc7SR2ldDiG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129501; c=relaxed/simple;
	bh=zuqG7gxGu6jOQkK4xZFwmL6j+4H2TOhQ0a5eY23tRoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erObffkAHgwlwDY0KLrJTCE0xCMo1Tl442nEgdLjVCN4MJ900dkWp5yqrVWvIjiEaRQTQR7MI2bLAoM/stJ4Y0/qWDQMZf2uwFHErOWg6AM4o/vHZWzcI3urUq2CVFJY9IiX8TsjnuH1CbXC4GpxfsCPQxJ4b6wg+0bRjvTIbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZjYfE/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF2AC32781;
	Sun, 19 May 2024 14:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716129501;
	bh=zuqG7gxGu6jOQkK4xZFwmL6j+4H2TOhQ0a5eY23tRoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZjYfE/Pt/eaUxil9rXbB1URr68eY44hOTnQekdIh1K1yLXqlJzTuh+TirmaasBbb
	 ddn6vOo//cEwC4kzHdHpHK/Vvckle8RnJJ6aGjdMsk00tgJS4P0BkRQC5jsUhGp7UX
	 Fxwcue8gzDf+cNzK3TRYIaeaj+UukejuHFeFCXk3I/Km/HL4C5F4knMgBcDS9UiuOF
	 sY2lUWeljiqWGAKpCFY21W9A8G7r6ViOhFA7tyvkj9Ij6AXQ2bYPqp+FMeV/fAJyc0
	 LfyIj0rIrtRsCpl2UtQ4y6Ld78pOzundYDwN5fcqRxQ35LJNmWHkHqnb3H5mOH8P7u
	 VxplgKaI8ZeSw==
Date: Sun, 19 May 2024 15:30:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] iio: pressure: bmp280: Add SCALE, RAW values in
 channels and refactorize them
Message-ID: <20240519153032.428aca57@jic23-huawei>
In-Reply-To: <20240512230524.53990-5-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
	<20240512230524.53990-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 01:05:23 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW channels in order
> to be able to calculate the processed value with standard userspace
> IIO tools. Can be used for triggered buffers as well.
> 
> Even though it is not a good design choice to have SCALE, RAW and
> PROCESSED together, the PROCESSED channel is kept for ABI compatibility.
> 
> While at it, separate BMPxxx and BMExxx device channels since BME
> supports also humidity measurements.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied

Jonathan

