Return-Path: <linux-iio+bounces-21712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C7B06F7A
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A862D1A6094A
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 07:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F38296152;
	Wed, 16 Jul 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNduwhFf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92973295DAF;
	Wed, 16 Jul 2025 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652288; cv=none; b=NzUMFgqdUSscg/ILUnUXyl+4H2PRJeuk3ltF35A58Xk0++lolFBmbQr/CbkAHCPodtNhVTMGWmHuTVjWpAlTRTbaJ+oVXHjgTYAh0iy5YsXMyMQ6AXTd8914n8p+sYOAxwYtSubGW5wqtA/13Ul37ZMo9BDQvbOIqI70Mb/Wwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652288; c=relaxed/simple;
	bh=U8Mh4S7lOWS6Z8WRstAiin9KcVarTK32JSGdG4ESDsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTTxSqN9Kba6yhEi7qjdfBol4a0/6w4mCoCAUSL8Oyk3RBxc6ZsHjDsMPkrYNVQ0Gqii4No6+gFMypxMUn3xxWwK+k/SCJWHAGEmdRusFiyHQ3wKU0xalzmAIv2J4Ngc6WG6TBJSWjAg7S4oBMyfoKd4z8tc2HgkNL1AwkZ87Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNduwhFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BB2C4CEF9;
	Wed, 16 Jul 2025 07:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752652288;
	bh=U8Mh4S7lOWS6Z8WRstAiin9KcVarTK32JSGdG4ESDsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dNduwhFffjzJxhr7WCkga7usg8nsCLV/LTlHucyMgwASD9HjdFZFS5t4TFStwcTE+
	 24rt6apUSQEyxnK8atH/L+BvEVORfBzQbxH3n4Ua645MXdKFw9IVeysphLg108+C3l
	 BaPi5hQG4dWnoJVGagiJMcspy5d0zUx2vlOamAc/TYsMp8X3kDvhJvGH3lfdDhlK2N
	 ufxnuO94Xr/fqU9fkebD8TDQbkz+4yr/e/fBGOnye1RNu1+w6YNTZo18L73ZHwbYoh
	 8T3qxqrb5GvFbQBQegrm/HBlgCrQ0kIGwyGgqkkny4kP122T6+Jz71w83VjOYWqGoP
	 FSc7s2SgiupIw==
Date: Wed, 16 Jul 2025 08:51:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: Select IIO_BUFFER_DMAENGINE
 and SPI_OFFLOAD
Message-ID: <20250716085120.51e8c130@jic23-huawei>
In-Reply-To: <764c464e-a45e-4d19-b9d4-a238f1ca84c0@baylibre.com>
References: <20250714-iio-ad_sigma_delta-fix-kconfig-selects-v1-1-32e0d6da0423@kernel.org>
	<764c464e-a45e-4d19-b9d4-a238f1ca84c0@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 10:40:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/14/25 1:30 PM, Nathan Chancellor wrote:
> > CONFIG_AD_SIGMA_DELTA uses several symbols that it does not explicitly
> > select. If no other enabled driver selects them, the build fails with
> > either a linker failure if the driver is built in or a modpost failure
> > if the driver is a module.
> > 
> >   ld.lld: error: undefined symbol: devm_spi_offload_rx_stream_request_dma_chan
> >   ld.lld: error: undefined symbol: devm_iio_dmaengine_buffer_setup_with_handle
> >   ld.lld: error: undefined symbol: devm_spi_offload_trigger_get
> >   ld.lld: error: undefined symbol: devm_spi_offload_get
> >   ld.lld: error: undefined symbol: spi_offload_trigger_enable
> >   ld.lld: error: undefined symbol: spi_offload_trigger_disable
> > 
> > Select the necessary Kconfig symbols to include these functions in the
> > build to clear up the errors.
> > 
> > Fixes: 219da3ea842a ("iio: adc: ad_sigma_delta: add SPI offload support")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---  
> 
> Thanks for the fix.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied to the togreg branch of iio.git and pushed out (briefly) as
testing for 0-day to take a look.

Thanks,

Jonathan

