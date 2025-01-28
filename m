Return-Path: <linux-iio+bounces-14683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C0A21203
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 20:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D82A166E4D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 19:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC001DE8BE;
	Tue, 28 Jan 2025 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXD+CBSk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357061C5F2C;
	Tue, 28 Jan 2025 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091615; cv=none; b=pfBTGcuJ2OMYInlu+RBh/V1VG+Dun+1n9POvi48/GrFNdO2pwcpyzgS7KjAISqtv5KmO/0/gb72a4iMivprjJ5fDZkreC/T/ICL6TwWcVMFtAv68AsspwFY77I5p27oZLl/Dl5NW6o67ibVyG3cWe5w4bJaJ1vW8Bj+OmjIvl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091615; c=relaxed/simple;
	bh=E/dzq8SoH58AxiaQJdgepZZjNNh0QmxWsFeJsObOpQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgLhGg+HDhlP33i3spwOraOJXVKUPZnaLM52BuLwyVvrQAz1yZis9EdnMy4KM1/AognNhDuXImc+zSiL0CIy2HKx8ilTZklCtqdQ8q7eTNLY5K2NHlaMWysxd8dLiE7o6DdBhMxdqjlj5v/otAB0hVa2hZyqoHf1wsADw9DcWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXD+CBSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10A3C4CED3;
	Tue, 28 Jan 2025 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738091614;
	bh=E/dzq8SoH58AxiaQJdgepZZjNNh0QmxWsFeJsObOpQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WXD+CBSkLBsLC0V53TiuKwdKW5CAEZ/Nnisg0J5Db11HaraxlEKpJI73v6oHuyU2p
	 /xF9mM808nATtWoQSCPwAkDjioUsxMowwudI6SoYXKm0t2AqZTSfUd+YUyx+oJ4Z06
	 KkOxf9XIcIPNcJtIQlw6TdhfK4uuyGL1OoCVobbEnsnxZoNV1wl6oT00YDffNO8NSD
	 dUlHQohleYo0UXBYguOyg8Q8o4q9WQrI2fzzkBP2OAHgan0C4EQlyPwWSFgnxPLLJe
	 r7E1okiNG9z0d73MuuTSMss4ad2NIgYyYhRecBHLIFipVxwi4Ojv9jj+NVu1tpVf7o
	 LtBaylXtqGWIw==
Date: Tue, 28 Jan 2025 19:13:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 0/2] iio: light: fix scale in veml6030
Message-ID: <20250128191327.32263a03@jic23-huawei>
In-Reply-To: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
References: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 20:30:21 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series follows a similar approach as recently used for the veml3235
> by using iio-gts to manage the scale as stated in the ABI. In its
> current form, the driver exposes the hardware gain instead of the
> multiplier for the raw value to obtain a value in lux.
> 
> Although this driver and the veml3235 have many similarities, there are
> two main differences in this series compared to the one used to fix the
> other driver:
> 
> - The veml6030 has fractional gains, which are not supported by the
>   iio-gts helpers. My first attempt was adding support for them, but
>   that made the whole iio-gts implementation more complex, cumbersome,
>   and the risk of affecting existing clients was not negligible.
>   Instead, a x8 factor has been used for the hardware gain to present
>   the minimum value (x0.125) as x1, keeping linearity. The scales
>   iio-gts generates are therefore right without any extra conversion,
>   and they match the values provided in the different datasheets.
> 
> - This driver included a processed value for the ambient light, maybe
>   because the scale did not follow the ABI and the conversion was not
>   direct. To avoid breaking userspace, the functionality has been kept,
>   but of course using the fixed scales. In order to ease the
>   calculations, iio_gts_get_total_gain() has been exported to avoid
>   working directly with the scale in NANO, that would require 64-bit
>   operations.
> 
> This issue has been present since the original implementation, and it
> affects all devices it supports.
> 
> This series has been tested with a veml7700 (same gains as veml6030) and
> a veml6035 with positive results.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied to the togreg branch of iio.git. Initially pushed out as testing.

I've rebased on char-misc, but will almost certainly rebase once more on rc1
once available.

> ---
> Changes in v3:
> - Rebase onto iio/testing and drop [1/4], [2/4] (applied).
> - iio-gts: document exported function.
> - Link to v2: https://lore.kernel.org/r/20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com
> 
> Changes in v2:
> - Rename SEL_GAIN to indicate they are in MILLI.
> - Split first patch (regfields and chaching).
> - Use regfield structs in chip struct instead of function pointer.
> - Use total gain to derive scale, avoiding 64-bit divisions.
> - Link to v1: https://lore.kernel.org/r/20250107-veml6030-scale-v1-0-1281e3ad012c@gmail.com
> 
> ---
> Javier Carrasco (2):
>       iio: gts-helper: export iio_gts_get_total_gain()
>       iio: light: veml6030: fix scale to conform to ABI
> 
>  drivers/iio/industrialio-gts-helper.c |  11 +-
>  drivers/iio/light/Kconfig             |   1 +
>  drivers/iio/light/veml6030.c          | 528 ++++++++++++++--------------------
>  include/linux/iio/iio-gts-helper.h    |   1 +
>  4 files changed, 229 insertions(+), 312 deletions(-)
> ---
> base-commit: ed2010907caa1c838d2e565d67bbc08fe023663e
> change-id: 20241231-veml6030-scale-8142f387e7e6
> 
> Best regards,


