Return-Path: <linux-iio+bounces-21032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16567AEC800
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA686189F78D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DFD24DCF3;
	Sat, 28 Jun 2025 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql6WblBG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC71FECB1;
	Sat, 28 Jun 2025 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122612; cv=none; b=f+U/Eri+jmfFT2citYwX1fL3bnqOkjTgoVck0rdYC+jqOU2x4sMg/NYUG9DPc2dBuSjet1YkiQSdfNJxHLLyQrb1TWn34tkyOKBkL+Va0mryVJQqDVJ0OBhwaDNVr/F7hegnZYBNf/RN1h+TFWI7HFUvakfJDxBxO6BGC4NslBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122612; c=relaxed/simple;
	bh=UwmRApaqqk7Vfnc8GvHQg4VKRcWyHLNfmC0InMsXCw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXuuFRfG6KJP5OKtXys89NWh3tHWJHUykk3ZfK2gGbBbAd29HAReD4TZ6BfIcsTFVFNx4Jqwg80tXJAcXNhiqG0OmvDkZXUjChCFbiBuP4/x6nOWkKGSd1QbaMk6m6Q/vUjGGUGiXIBctHekWi5VJmLxvln7XJhfMZUi4BznrIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql6WblBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1A9C4CEF0;
	Sat, 28 Jun 2025 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751122611;
	bh=UwmRApaqqk7Vfnc8GvHQg4VKRcWyHLNfmC0InMsXCw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ql6WblBG26HF69ulzCZ3sBM5jZkz5NcZGGfzT+yp9noAhcBHU/9ccChgYoGZk5Goi
	 2LU/SbOZmVfB/zNfC/aO1mToz4RnYthcNbhyEuQ5rGvJ38d/7EE/GVYODlRXpy9qml
	 5bvfa4ZiKQBBLIEgumjSxcwtRuVo19p2dJQESjoKLQoJy+PJNY4AD5AidpQyrwpn0n
	 tDkSnSWmHy3alFD1IxgJqtI2RxAsnecH+ox1HfsKLXiz6aaNQzm3+nvTZzSHL7kuD9
	 g6PpqaVh1mmXkX6zmPsxuG9VTfvEVE4tNufUTRPUNAinZNUnd0GpYBYt/R6Z4S+PXc
	 8c0+5RKyrdEIw==
Date: Sat, 28 Jun 2025 15:56:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 04/11] iio: adc: ad_sigma_delta: use BITS_TO_BYTES()
 macro
Message-ID: <20250628155643.7c18e023@jic23-huawei>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
	<20250627-iio-adc-ad7173-add-spi-offload-support-v2-4-f49c55599113@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 18:40:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
> to bytes.
> 
> This makes it more obvious what unit conversion is taking place.
> 
> In one instance, we also avoid the temporary assignment to a variable
> as it was confusing that reg_size was being used with two different
> units (bits and bytes).
> 
> scan_type is factored out to reduce line wrapping.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

>  
> -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
> +	samples_buf_size = ALIGN(slot * BITS_TO_BYTES(scan_type->storagebits), 8);

Ah. You do it here. Fair enough and no problem wrt to patch 1 then.

>  	samples_buf_size += sizeof(s64);
>  	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
>  				    samples_buf_size, GFP_KERNEL);

