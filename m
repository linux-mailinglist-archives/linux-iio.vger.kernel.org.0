Return-Path: <linux-iio+bounces-9285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBB99702DA
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBFBB23046
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3E15E5D2;
	Sat,  7 Sep 2024 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMMAhNpT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C8515C12F;
	Sat,  7 Sep 2024 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725720830; cv=none; b=UnRdmXEmHoKgixsn7E6p+STOCquUjxAkSxz15x6N4knw45xObtqe+0wh9fmnMlE9Z2psv065TIaRfWg7FDvf4e3TonoKpXIL+cBLX4XMmXv+nfx+M62g4S6o71AlBrUnLEwih86br2Slr0GxIsgnQx/RfAyKzw9ubG5fO87a6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725720830; c=relaxed/simple;
	bh=JMRSL+qHP2CcYLw/eX4taRd+nvcLZr2BQH9kr0FIr0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tzfb67GIgjbUaGj40m6X4YWDi+4Y0EcBtEr6hUOrBTCRB+ViSTloIMEXKGUw3CHvmNpSYG9P0rKVIP62ETEsNHCMo2ndPEnQXxytMcwTtX6hHN02O6YAeBIloU7ydr1xjke0OESR1uZ8PVylHwlozD8JWIPj4NCzpVQ5U6bQfx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMMAhNpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F50EC4CEC2;
	Sat,  7 Sep 2024 14:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725720830;
	bh=JMRSL+qHP2CcYLw/eX4taRd+nvcLZr2BQH9kr0FIr0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AMMAhNpTwaRyUH/hExhcFIUaWqqysDjYQMRw/LeXXYpH/X76YqmvkEM78zGjvqg7B
	 II05CcM8XzKZ64qNtdpcj5tADIwx8Un9I5Zrnszewgec6kMP9BM4tQL6M/U1JY8hVb
	 eee8viizLzTVF01uPKjzx6hmCxjuVRGTpcq/8WjBVTOUBoUkha5TCC5TzJ7QMksDoP
	 +Dg8cnhu8IXM9OLlNXtQqBSgjzilUD3O26jK7I9xAHUw3MG53q6mhfK40JE8mJ6HDu
	 HxJ+6h1FGDqDzoIxHnztu+0dOkwKyu1DdQ3nCakXOFt7L/uDyY98jnau2E4XfrIAmw
	 e9hnql7Zrmyvw==
Date: Sat, 7 Sep 2024 15:53:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v5 2/9] iio: adc: ad7606: add 'bits' parameter to
 channels macros
Message-ID: <20240907155342.56109b37@jic23-huawei>
In-Reply-To: <20240907065043.771364-3-aardelean@baylibre.com>
References: <20240907065043.771364-1-aardelean@baylibre.com>
	<20240907065043.771364-3-aardelean@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  7 Sep 2024 09:50:35 +0300
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> There are some newer additions to the AD7606 family, which support 18 bit
> precision.
> Up until now, all chips were 16 bit.

Trivial but this is really odd style.  Sort of has a paragraph and
a 'sub paragraph' going on. 

Go with this:

There are some newer additions to the AD7606 family, which support 18 bit
precision. Up until now, all chips were 16 bit.

This change adds a 'bits' parameter to the AD760X_CHANNEL macro and renames
'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.

etc.

Patch looks fine to me.


> 
> This change adds a 'bits' parameter to the AD760X_CHANNEL macro and renames
> 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
> 
> The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for IIO
> channels in SW mode.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>

