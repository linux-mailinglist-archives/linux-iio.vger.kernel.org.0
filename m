Return-Path: <linux-iio+bounces-9559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2B97914F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD19283FF9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A141CFEA2;
	Sat, 14 Sep 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkPyBMlM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D71CF2B0;
	Sat, 14 Sep 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726323494; cv=none; b=HiiKmRFY1xSJAT+v/hDp2occShLD5df38usMsx+NEx9O3QOIcrvAM91XUPeM0ZShowRwkUwmWUd1jcoEJWrndYMNRgHBUG5LV150EqM2BoiFacpIbgwExbCtBwEvvSUqMeM4+muNKjifm93PlHRhCtDdhKOjX0SP7oRGU12X2nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726323494; c=relaxed/simple;
	bh=YzlIrKa9qROLJ8Xaw/r1jxKSFT05Dy3NWxL/FjHMwig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEP0CdwHlNbIaKgIo6FrdZkYg34RN6g+0PVblbBQMdjwOK48maQDUoeWHqw51x4Ucy+F7ecmvfODaFnq1EkKq9gjpe6oPV3FL+/uOHvwZ7Pfe4jMbqchuQIgH+0jSkauqEYYVqQ74twj5EBvpFfOkx14PTpgZ4nt8eSMEawnA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkPyBMlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77113C4CEC0;
	Sat, 14 Sep 2024 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726323494;
	bh=YzlIrKa9qROLJ8Xaw/r1jxKSFT05Dy3NWxL/FjHMwig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QkPyBMlMruE8ewcrPt7o7wG4IgQF2yRzoiyJrY5xhfsmkSHNwb3sFd9QTC6iPnETM
	 sBLJne1rJM+si+vhC8o7vxUfjkw8g4rlLmSK+yDTisjdL8pozBNg27TlM27yXCd9V+
	 cXxsvENmA6jHqJ4jT2yauxxiJ8Mbsybw206AYkFpfABED7cOTwFfCgv5umhj4dUToq
	 0ZII9M40+uGUuoZoTY1IdLP7umV9FAJbRAUAWgSykFn6L19SzOHcAyNj3ZvBfd6ZKh
	 w8KFBe8i7YMYWud0DRLvA5eHrQnRsMB6BUznru1udel3UuZKA8LNZckBmhLUhXQFY4
	 Gx0cNRsm9GUPQ==
Date: Sat, 14 Sep 2024 15:18:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Auchter
 <michael.auchter@ni.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: adi,ad56xx: Fix duplicate
 compatible strings
Message-ID: <20240914151806.66c58bfd@jic23-huawei>
In-Reply-To: <20240910234440.1045098-1-robh@kernel.org>
References: <20240910234440.1045098-1-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Sep 2024 18:44:39 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> adi,ad5686.yaml and adi,ad5696.yaml duplicate all the I2C device
> compatible strings with the exception of "adi,ad5337r". Since
> adi,ad5686.yaml references spi-peripheral-props.yaml, drop the I2C
> devices from it making it only SPI devices. Update the titles to make
> the distinction clear.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Is this an urgent thing, or can it wait for the merge window after next?
For now I've queued it up for then in my testing branch but can yank it
out and send it as a fix after rc1 if that is useful.

Jonathan
 
> ---
>  .../bindings/iio/dac/adi,ad5686.yaml          | 53 ++++++-------------
>  .../bindings/iio/dac/adi,ad5696.yaml          |  3 +-
>  2 files changed, 19 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> index b4400c52bec3..713f535bb33a 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices AD5360 and similar DACs
> +title: Analog Devices AD5360 and similar SPI DACs
>  
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
> @@ -12,41 +12,22 @@ maintainers:
>  
>  properties:
>    compatible:
> -    oneOf:
> -      - description: SPI devices
> -        enum:
> -          - adi,ad5310r
> -          - adi,ad5672r
> -          - adi,ad5674r
> -          - adi,ad5676
> -          - adi,ad5676r
> -          - adi,ad5679r
> -          - adi,ad5681r
> -          - adi,ad5682r
> -          - adi,ad5683
> -          - adi,ad5683r
> -          - adi,ad5684
> -          - adi,ad5684r
> -          - adi,ad5685r
> -          - adi,ad5686
> -          - adi,ad5686r
> -      - description: I2C devices
> -        enum:
> -          - adi,ad5311r
> -          - adi,ad5337r
> -          - adi,ad5338r
> -          - adi,ad5671r
> -          - adi,ad5675r
> -          - adi,ad5691r
> -          - adi,ad5692r
> -          - adi,ad5693
> -          - adi,ad5693r
> -          - adi,ad5694
> -          - adi,ad5694r
> -          - adi,ad5695r
> -          - adi,ad5696
> -          - adi,ad5696r
> -
> +    enum:
> +      - adi,ad5310r
> +      - adi,ad5672r
> +      - adi,ad5674r
> +      - adi,ad5676
> +      - adi,ad5676r
> +      - adi,ad5679r
> +      - adi,ad5681r
> +      - adi,ad5682r
> +      - adi,ad5683
> +      - adi,ad5683r
> +      - adi,ad5684
> +      - adi,ad5684r
> +      - adi,ad5685r
> +      - adi,ad5686
> +      - adi,ad5686r
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> index 56b0cda0f30a..b5a88b03dc2f 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/dac/adi,ad5696.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices AD5696 and similar multi-channel DACs
> +title: Analog Devices AD5696 and similar I2C multi-channel DACs
>  
>  maintainers:
>    - Michael Auchter <michael.auchter@ni.com>
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - adi,ad5311r
> +      - adi,ad5337r
>        - adi,ad5338r
>        - adi,ad5671r
>        - adi,ad5675r


