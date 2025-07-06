Return-Path: <linux-iio+bounces-21382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5BFAFA449
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 652433A5635
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA61F4706;
	Sun,  6 Jul 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlkWpt95"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D12B9BA;
	Sun,  6 Jul 2025 10:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796357; cv=none; b=lrYcUQF0rxdjAPMfUgChUy+kuFtUuOsWJVClbuyAkGJrU46r0QNZCeSahfLs7wggrYn/bfCeOTzR3h/awtloa79UZbj7lThmKulUOsHLtGPnV04g433yB2RkZtpAKGS3HGkXYYG4DiSVTmVnVMzssh/FwtmQGbhJ/nqQYrir7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796357; c=relaxed/simple;
	bh=V2QxA3l1+yabl+QUaYnADnbg1c2TRxhj8dvgt2Yy/4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9u6MFGoCUohEGyQHH2aMHQlrO8i6w6XwqYi6hbBoD1zz+opKkGRDLQGNrL33jeTA12NWlBe6XgZE0AUDRQb4KVoetMDeg/D5UNzAR2QRlwWcgk8oNmjDLcypEj9sKZzPBx4x9URvJVh6IjMYt8EuywckmKKq8vYNke75udLUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlkWpt95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE28C4CEED;
	Sun,  6 Jul 2025 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751796357;
	bh=V2QxA3l1+yabl+QUaYnADnbg1c2TRxhj8dvgt2Yy/4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlkWpt955xAY5Ya8e8kynQ2eUWNs+htJV4ThSWpjR7nYenZpUgchA02em0wgXfzlE
	 lnyDA2u5x3vZTPqcHo5xUs7Y+pRKKcR/3K2Q2N7LXKUMWdfgjMPZEzyQ84R6cJBoKJ
	 rWhIyMCsxcmLFbqDjLE0kyCcP2ZXWOXdPePCXhYfHCtsrUhN7NvZTj8RhycDMbl/q9
	 RMX6sfxYASA/eDsGVLgLwftL150cM+J3ijKwGMISoBmtULXbu5YJ1uVA0TD4YEJKjA
	 8ncDy9t20WMwNR73PeiaHcbiRjNbiIUJMbuVzck/xt3UqILbL5GEBKhPDEszAkawfL
	 BmPI7TDYIKZXw==
Date: Sun, 6 Jul 2025 11:05:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 00/12] iio: adc: ad7173: add SPI offload support
Message-ID: <20250706110548.13605ebf@jic23-huawei>
In-Reply-To: <20250706110417.5182f679@jic23-huawei>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
	<aGToIInJLMHmB4ay@smile.fi.intel.com>
	<20250706110417.5182f679@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Jul 2025 11:04:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 2 Jul 2025 11:04:48 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, Jul 01, 2025 at 04:37:48PM -0500, David Lechner wrote:
> > > Here comes another series for adding SPI offload support to an ADC.
> > > 
> > > The primary target is AD411x, but since this uses the ad_sigma_delta
> > > shared module, a lot of this series is focused on that.
> > > 
> > > To start with, we have some cleanups to the ad_sigma_delta code, so feel
> > > free to pick these up as they are ready as they generally stand on their
> > > own.
> > > 
> > > Then before adding proper SPI offload support, we make use of
> > > spi_optimize_message() to reduce CPU usage of all users of this driver
> > > during buffered reads.
> > > 
> > > Also there is a new dt-binding and driver for a special SPI offload
> > > trigger FPGA IP core that is used in this particular setup.
> > > 
> > > Then finally actual SPI offload support is added to the ad_sigma_delta
> > > module and the ad7173 driver.
> > > 
> > > This was tested using EVAL-AD4112ARDZ on a DE10-Nano.  
> > 
> > This version LGTM,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> 
> Applied 1-7 and 11-12.  Mark picked up 8 and 9 from v2.
1-8 and 11-12. 9 and 10 are now the ones that match with 8 and 9 that
Mark picked up. Oops.
> 
> Thanks,
> 
> Jonathan
> 
> 
> 


