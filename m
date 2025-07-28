Return-Path: <linux-iio+bounces-22102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94ECB13BEC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAABD1720E0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 13:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7E626A0EB;
	Mon, 28 Jul 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlaUkiCe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4F263892;
	Mon, 28 Jul 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710551; cv=none; b=WEXeANZZ1vma4PRISgOge9PNHi5DpupgcEkmiIwndzSLnNdCpMkCIeBFq7WnJ7A1BaVPGB10zVUQWZHlYTFJHZZ3RlHsYqtSD/dRlVq/hmwBSQl2VIH4jnhifqJk7nGEVb45IZhpatISxtwTmCq9lbhhUk3Ke+ISgxyUcld3tlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710551; c=relaxed/simple;
	bh=od5DlWzr8ZxOGKLJlF8DEQL3SKzHtIKCKx+PtzJGfwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aC19B1wEy2fpvVpci89GjBWTStHDIxTQL5kl2DsklxprqWXadbp6oOJa76aL7j+3mT78jas4Bk8kwaBslLKAeEGJlyxNv8rYebc2AUSQ8PGiHhX7U6WVVfEPeQUhVHXO7XW7CXzTxg2cKscAxG8DI5jHyIj2171vr/4C1zG6cGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlaUkiCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B72C4CEE7;
	Mon, 28 Jul 2025 13:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753710551;
	bh=od5DlWzr8ZxOGKLJlF8DEQL3SKzHtIKCKx+PtzJGfwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GlaUkiCe205QUnF7uZXQbPWlhqYyDHMDtN4UHPm4gcX7/1UTDXx+JEdhzpbKHJwbY
	 bKeTMSZnT68AMrf0KCFJtNn56Xx82ZS3F3jxNOBeNwjejo898se8sjf3tg0WQD3Ipf
	 CsjQbcakcyCtSUFxxk+QvBeiZKxFEo9RiOt9JKmyWiGHFO5loXY1d10e9nia5oCsln
	 lfndmOHBBhNROdbnPJC19q9kXlqcHYSQXD4NWcOiIo2qjTFN/DlTycQgLS2DpcEkm6
	 7xVRZ5FEKKSKWHrFO0EoQDepBBxsAKsCqQyQb4DhCGtYTco/H96XdIMZkPYx7XM3aZ
	 HlyMEIuJ5p7sw==
Date: Mon, 28 Jul 2025 14:49:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <20250728144901.3f646a4c@jic23-huawei>
In-Reply-To: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
References: <20250724113826.61998-2-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 13:38:27 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
> permanently:
> 
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'
> 
> so replace them with Marcelo Schmitt from Analog where appropriate.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I don't know who from Analog should maintain these devices, so I chosen
> author from Analog of one of last commits.
> 
> Marcelo Schmitt, could you confirm that you are okay (or not) with this?

Nuno, Michael, other ADI folk.  Can someone confirm if we are making these Marcelo's
problem?

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 2 +-
>  Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 2 +-
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 2 +-
>  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 2 +-
>  7 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> index 3dc973b98f81..40e9a40a7a60 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ADIS16240 Programmable Impact Sensor and Recorder driver
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  description: |
>    ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> index 88aa67bf2280..55e44c9292cf 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
>  
>  maintainers:
> -  - Stefan Popa <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  description: |
>    Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that supports
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 7146a654ae38..958a37def56c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD7124 ADC device driver
>  
>  maintainers:
> -  - Stefan Popa <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  description: |
>    Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> index 5207c919abe0..eac48166fe72 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> @@ -9,7 +9,6 @@ title: Linear Technology / Analog Devices LTC2496 ADC
>  maintainers:
>    - Lars-Peter Clausen <lars@metafoo.de>
>    - Michael Hennerich <Michael.Hennerich@analog.com>
> -  - Stefan Popa <stefan.popa@analog.com>
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> index 82b0eed6a7b7..058df4c8ddf8 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD5770R DAC device driver
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  description: |
>    Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 53d607441612..031b1657cde1 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
>  
>  maintainers:
> -  - Popa Stefan <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  description: |
>    Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> index 7a1a74fec281..e49d5e6fab61 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADIS16480 and similar IMUs
>  
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
>  
>  properties:
>    compatible:


