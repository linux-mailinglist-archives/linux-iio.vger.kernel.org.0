Return-Path: <linux-iio+bounces-22819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C492B28E20
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995CA5C69C2
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2E02E5B0F;
	Sat, 16 Aug 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhRwEavN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA9BE46;
	Sat, 16 Aug 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755350665; cv=none; b=osRoxPNSKgQ3jax24QUe1Sd4717gW9k/ax6C8WskpqNtwOZt6mxTXx9gmd8/XSEskTTCC/aeM+OGBOTwc3pZuyczliBm7bCTDR1eGpQ2QLbsN0fXZ8i37/ja4+lRk0xNBURabgIAzmslVOf1tyWyzyOTO2SocFffvqNmGFwhbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755350665; c=relaxed/simple;
	bh=oHEiGnFxFtU/G+50iP8aQgUkZU9yifzTqwhFxxZyrSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqIffD75uVnxbtvLiXi9nnzopU2qy3S5J8xEfY7igZjoW5XBC3ygK8y8oRJ1I+ybBcBO7c4gDVdnOc0+Nh90O0TTCJNb9pOemedn3HvmIxQgfamUVD93HpNc06gL7VRjmo88BN3gyfI7zhl4bPmhxWIYnV7DT0kKlKIR5JSQ0kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhRwEavN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E0CC4CEEF;
	Sat, 16 Aug 2025 13:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755350664;
	bh=oHEiGnFxFtU/G+50iP8aQgUkZU9yifzTqwhFxxZyrSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhRwEavN1HGnqLOKneP0njEW6qD4myASz+2qyQNnU0brtQLMtxKqCS4j9UfHYJrLF
	 tqQlu9j24mqiaSsHi7wH6tefcD2+wlRCXkPDxBgSXFDL7X/B7oIu2jryOIEJlhgAyh
	 79/lAge9btXnUUohpZxx9ruj3+osTF5jmTmpbghOf3IQHuL26jWpW7y5DGCYKU+tPS
	 pioOrdkNZKGbGGXJFGXsW3f10iDLABwIM5byOUGkH+6utddSXKDdYa54YtoGce4yS8
	 If20SKPxzqYPn5n0WmnZScza9csXrkHpceijk70PBzarffuiLFRgbpAebAr72lzRPd
	 cdVU+A1b052Ng==
Date: Sat, 16 Aug 2025 14:24:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: Replace bouncing Analog emails
Message-ID: <20250816142415.01e29012@jic23-huawei>
In-Reply-To: <20250812132445.75398-2-krzysztof.kozlowski@linaro.org>
References: <20250812132445.75398-2-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Aug 2025 15:24:46 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Emails to stefan.popa@analog.com and alexandru.tachici@analog.com bounce
> permanently:
>=20
>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Reci=
pient not found by SMTP address lookup'
>=20
> so replace them with Marcelo Schmitt and Nuno S=C3=A1 (listed alphabetica=
lly
> by first name) from Analog where appropriate.
>=20
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thanks for the patch and to Marcelo and Nuno for covering these.

Applied.

> ---
>=20
> Changes in v2:
> 1. Add Nuno, based on discussions on the list.
> 2. Add Rob's Ack.
>=20
> This change got agreement on the list, but still would be nice if you
> folks Ack it formally.
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml | 3 ++-
>  Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml   | 3 ++-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml      | 3 ++-
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml    | 1 -
>  Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml     | 3 ++-
>  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml   | 3 ++-
>  Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml   | 3 ++-
>  7 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.ya=
ml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> index 3dc973b98f81..a92e153705f3 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ADIS16240 Programmable Impact Sensor and Recorder driver
> =20
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> =20
>  description: |
>    ADIS16240 Programmable Impact Sensor and Recorder driver that supports
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml=
 b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> index 88aa67bf2280..0ba0df46c3a9 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer
> =20
>  maintainers:
> -  - Stefan Popa <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> =20
>  description: |
>    Analog Devices ADXL372 3-Axis, +/-(200g) Digital Accelerometer that su=
pports
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 7146a654ae38..4dd5395730c1 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD7124 ADC device driver
> =20
>  maintainers:
> -  - Stefan Popa <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> =20
>  description: |
>    Bindings for the Analog Devices AD7124 ADC device. Datasheet can be
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml =
b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> index 5207c919abe0..eac48166fe72 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
> @@ -9,7 +9,6 @@ title: Linear Technology / Analog Devices LTC2496 ADC
>  maintainers:
>    - Lars-Peter Clausen <lars@metafoo.de>
>    - Michael Hennerich <Michael.Hennerich@analog.com>
> -  - Stefan Popa <stefan.popa@analog.com>
> =20
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> index 82b0eed6a7b7..091cc93f1f90 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
> @@ -8,7 +8,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices AD5770R DAC device driver
> =20
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> =20
>  description: |
>    Bindings for the Analog Devices AD5770R current DAC device. Datasheet =
can be
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml=
 b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> index 53d607441612..2e1ff77fd1de 100644
> --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADF4371/ADF4372 Wideband Synthesizers
> =20
>  maintainers:
> -  - Popa Stefan <stefan.popa@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> =20
>  description: |
>    Analog Devices ADF4371/ADF4372 SPI Wideband Synthesizers
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> index 7a1a74fec281..43ecf46e9c20 100644
> --- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
> @@ -7,7 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Analog Devices ADIS16480 and similar IMUs
> =20
>  maintainers:
> -  - Alexandru Tachici <alexandru.tachici@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +  - Nuno S=C3=A1 <nuno.sa@analog.com>
> =20
>  properties:
>    compatible:


