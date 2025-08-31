Return-Path: <linux-iio+bounces-23541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C027B3D42B
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10B53BABC4
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2E026E6E2;
	Sun, 31 Aug 2025 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQJrXKhl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D152080C0;
	Sun, 31 Aug 2025 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756654620; cv=none; b=DgwSV9DtVOza1uj+uv1JqB5iPA0C8ZCzcZeb64ydUMMm298ShsKArYxOFBMpkNHOEG6OLiGnCh5YwdVYMNz6O6DsbDeutW9TEPml06zosZd1/uzTksyFByL/g64D1FLPv8NTPabI6h2Q1H79wfq0pM7PoHVMDrgKuP/NSMKjyCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756654620; c=relaxed/simple;
	bh=ifYaRs57UYOQrGLzjXP5Nk2vToZ0HAhHWjEve55W3hM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YctQwQjutfvlmdvh7Nty3FTbB+BYrUnJdVvc1npyW/Sz29sMREvER1dFkY67B75PFpG0zsCjta4ZlPFMvk35c05XdpNJsyO6L8d+fCDC7pGVB+NqEf+e2KULC7wurwo5fW9GYXyLGfiBwRV3cXhfXYkwaxb1Yy0wRjdoYVA6zDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQJrXKhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C498BC4CEED;
	Sun, 31 Aug 2025 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756654619;
	bh=ifYaRs57UYOQrGLzjXP5Nk2vToZ0HAhHWjEve55W3hM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQJrXKhlR0USur85N5lln0dpcIf/2LrAk3Mvw1k7GTw9a4LUAGz8LahRxFURt1e1N
	 t6gkLY6wAxVWQu02Sna775q9dWw5s2ccPiDD68G27RiPDg+SD/wZ/UTkHgEGAZtQVh
	 Sj4U8q3RAfgkJHFmPixaKTlqkXQA7nexzbv9yC3WDkHMpEWUsbju3KTqNESMFIxyxb
	 pwRrWk7LnFLn9QKsFwjk+wBZa1tJAlW51U01TiE7IYqLpurcByOflzV6Y9dHUgymBg
	 xsDTbj0UbrqhVyR7qntZ2ugEOtMmFMyIWYFtP02yHL6O/2zJjk6tFmQdtbho2wQNY7
	 mQXAnS4NviIWg==
Date: Sun, 31 Aug 2025 16:36:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: Gyeyoung Baek <gye976@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/2] Added mhz19c to compatible list in mhz19b
 driver.
Message-ID: <20250831163651.41d79348@jic23-huawei>
In-Reply-To: <CAJE-K+CiQdZ9mpqom0HdGoCqrt3v7Dkj2DM5WtumoGhhtduumQ@mail.gmail.com>
References: <CAJE-K+CiQdZ9mpqom0HdGoCqrt3v7Dkj2DM5WtumoGhhtduumQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Aug 2025 13:54:20 +0545
Sidharth Seela <sidharthseela@gmail.com> wrote:

> The pin-compatiblity and UART configuration are same. Although
> documentation on mhz19c's UART commands is sparse. It can be reasonably
> thought of that the commands from mhz19b will be supported in mhz19c.
> The mhz19b document mentions all the different commands. Still the
> uncertainity is noted.
> 
> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> ---
>  drivers/iio/chemical/mhz19b.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> index 3c64154918b1..4899aad895d5 100644
> --- a/drivers/iio/chemical/mhz19b.c
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -297,7 +297,17 @@ static int mhz19b_probe(struct serdev_device *serdev)
>  }
> 
>  static const struct of_device_id mhz19b_of_match[] = {
> +       /* It should be noted that mhz19b is discontinued*/
>         { .compatible = "winsen,mhz19b", },
> +       /* Beware that mhz19c has same pinout, UART characteristics.But there
> +        * are gaps in the official user-manual[1], specifically
> +        * regarding.
> +        *              Calibrate Zero Point.
> +        *              Calibrate Span Point.
> +        *              Detection range setting.

If those are not documented, unless we can definitely confirm they are
present, we should not enable those features for this device.

That means you'll need more substantial driver changes and a chip_info type
structure via the data fields in these firmware match tables.

That structure would have a bunch of boolean flags for features so
we can work out what to turn on for a given part.  We shouldn't expose
any interface that doesn't make sense for a given part.

Jonathan




> +        * Ref [1]:
> https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19c-pins-type-co2-manual-ver1_0.pdf
> +        */
> +       { .compatible = "winsen,mhz19c", },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, mhz19b_of_match);
> --
> 2.39.5 (Apple Git-154)


