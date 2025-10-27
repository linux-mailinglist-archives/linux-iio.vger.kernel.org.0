Return-Path: <linux-iio+bounces-25471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B86C0E449
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0112421EAC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8C307AF4;
	Mon, 27 Oct 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HihCMwKt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC7306B1A;
	Mon, 27 Oct 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573870; cv=none; b=nEeCLKswa1f6u+/niiOtXc+h3BfLdTuYlY6Y7yyOI9W25uS+cGbj9JKHHRoSbh1wKfOOFCNZY82dT8ImF4WaaEsNgfsrzhVhVsDVBA89bzwby3WaSLSvR3Zf5QZ1a32/9ih1e5OuclWqqSLx2fDQtnRNXZa/skXA1WpvitCByUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573870; c=relaxed/simple;
	bh=ylzl9ZrQ1VTqBSBsE4EtAeYnesF+yl7Al++Z2aaqGVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWNbivwTi40gCVkZH8HdLKe2PMm09/eNaWXYqMnwnGiBSbmchvEBw23uydP0GNj6ZQa1eRfSG0zvf8o6/KXwCDdYRoDFTk0wYSJp7wAmM+mjZ9DxeJmayi1NGyTUZhkCCsD0VSauRr6N4qo2Rv2VnwxZEuP22f6dUArueDbPS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HihCMwKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ABFC4CEF1;
	Mon, 27 Oct 2025 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573870;
	bh=ylzl9ZrQ1VTqBSBsE4EtAeYnesF+yl7Al++Z2aaqGVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HihCMwKtP3kVwDkSg1HY7x8dD1LztfR9dGaWPjYDfb811P6oEkII1mSP5j//6JRs4
	 TVdTemdHe2LqJ9yCJ9X3/WnVVOAaZpGIEp+xzSg+qhQnjxNFCKQ2z/mnbZSMOEyoTm
	 oAA0ZRJ0+MdkPkhZIwX75oGow81dvsyh+KQDgp5iaV4+fbC3NR0fUxdwhssqlYDC80
	 7bNDmJvNq7wsc33y0lhO56JUzACPH0Y+gAHv2FmBjefIvwQjwEL/r5gRnQh6zQsU9c
	 kwnPJitiZbo2E0HIyJOew/QAdELVzy05Em1C/JVG0N1kfJdTUnJeFZlBUkosSGb94J
	 8Sb2ZiuqLWvNA==
Date: Mon, 27 Oct 2025 14:04:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
 <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v6 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
Message-ID: <20251027140423.61d96e88@jic23-huawei>
In-Reply-To: <3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
References: <cover.1760984107.git.marcelo.schmitt@analog.com>
	<3fadbf22973098c4be9e5f0edd8c22b8b9b18ca6.1760984107.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 16:15:39 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4030 and similar devices can read common-mode voltage together with
> ADC sample data. When enabled, common-mode voltage data is provided in a
> separate IIO channel since it measures something other than the primary
> ADC input signal and requires separate scaling to convert to voltage
> units. The initial SPI offload support patch for AD4030 only provided
> differential channels. Now, extend the AD4030 driver to also provide
> common-mode IIO channels when setup with SPI offloading capability.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> New patch.
> I hope this works for ADCs with two channels. It's not clear if works as
> expected with current HDL and single-channel ADCs (like ADAQ4216).
> 
> The ad4630_fmc HDL project was designed for ADCs with two channels and
> always streams two data channels to DMA (even when the ADC has only one
> physical channel). Though, if the ADC has only one physical channel, the
> data that would come from the second ADC channel comes in as noise and
> would have to be discarded. Because of that, when using single-channel
> ADCs, the ADC driver would need to use a special DMA buffer to filter out
> half of the data that reaches DMA memory. With that, the ADC sample data
> could be delivered to user space without any noise being added to the IIO
> buffer. I have implemented a prototype of such specialized buffer
> (industrialio-buffer-dmaengine-filtered), but it is awful and only worked
> with CONFIG_IIO_DMA_BUF_MMAP_LEGACY (only present in ADI Linux tree). Usual
> differential channel data is also affected by the extra 0xFFFFFFFF data
> pushed to DMA. Though, for the differential channel, it's easier to see it
> shall work for two-channel ADCs (the sine wave appears "filled" in
> iio-oscilloscope).
> 
> So, I sign this, but don't guarantee it to work.

So what's the path to resolve this?  Waiting on HDL changes or not support
those devices until we have a clean solution?

Also, just to check, is this only an issue with the additional stuff this
patch adds or do we have a problem with SPI offload in general (+ this
IP) and those single channel devices?

Jonathan




