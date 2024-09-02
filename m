Return-Path: <linux-iio+bounces-8956-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3B968078
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 09:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941801C21E94
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE5177992;
	Mon,  2 Sep 2024 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYMZFl5R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEE1547C3;
	Mon,  2 Sep 2024 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261698; cv=none; b=Qc0WM/F+iHt3vlI52bH76U46SaCxaxmMA/Namd+Kt844PxQDZehjkWLv9cwQWjB4prIVHEucJm/J1b3shvnUqcUovDLBTPS89TjC0mjGRXBtkv4TTTZ+s3ilj8zmROxBAZIrqVFabZbOJDb4hdCOaDzLKalg55zjuGYhc2wKyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261698; c=relaxed/simple;
	bh=E8IFSuEGmDCnUmRzlrw+q1btyLEC2hHX28IN1qiv0DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL0LLpfLggnS0BuHY+Y6DBiiqWky/Hnw++7lOA1y9P+gLJGCkJSOb9MfqVQkkHcEASWO2VuWTrRhRA/vD3oTHrtag+IRhPOI+r5LnQX05rHfFQ0HvazhINMBwwyVmj1rbR2VU00/ZJN49phxHRNSJ7MMGSY3W5YA9RC/YmI7BZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYMZFl5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7520C4CEC2;
	Mon,  2 Sep 2024 07:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725261697;
	bh=E8IFSuEGmDCnUmRzlrw+q1btyLEC2hHX28IN1qiv0DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYMZFl5RkQHHHAlJW3FZ/FoSAjFfZ2t3qYRLc06sDl1UH+QTGDi3DdLJiSiHUuZsM
	 Qil+GLZ/kq9TkoF6WxABuxQcLQm1WL/usleYcJGF3hF5w7X3otPqepJfO/OLtDOuvr
	 S7R6NxRGyvxCrUbodq2Q+vCm460+RiMUxqnyDReMXFlxYdTHYMrmRAWZH9QidRrRfx
	 ebGgw6trLFo6XhzfiUtsj53zAHS7uTqvaXe0yZo7qWbrm8/P8MQ0nEf2S4nNcxeg50
	 t5gbqaLm59AzHDSnOqBzB244CPDZHZasX7vVWE0RzKufmub6E/2kM/iDMk6cBVumxf
	 oTTbxT1lioDYg==
Date: Mon, 2 Sep 2024 09:21:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jagath Jog J <jagathjog1996@gmail.com>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: add bmi270 bindings
Message-ID: <y43rxkvcg5fnvef2pezzg5ckotqvfs2io6ohungfdpd7abcfm5@z62ruivg6p35>
References: <20240901205354.3201261-1-lanzano.alex@gmail.com>
 <20240901205354.3201261-2-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240901205354.3201261-2-lanzano.alex@gmail.com>

On Sun, Sep 01, 2024 at 04:53:23PM -0400, Alex Lanzano wrote:
> Add device tree bindings for the bmi270 IMU
> 
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> ---
>  .../bindings/iio/imu/bosch,bmi270.yaml        | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> new file mode 100644
> index 000000000000..44534ef36378
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi270.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMI270 6-Axis IMU
> +
> +maintainers:
> +  - Alex Lanzano <lanzano.alex@gmail.com>
> +
> +description: |
> +  BMI270 is a 6-axis inertial measurement unit that can measure acceleration and
> +  angular velocity. The sensor also supports configurable interrupt events such
> +  as motion, step counter, and wrist motion gestures. The sensor can communicate
> +  I2C or SPI.
> +  https://www.bosch-sensortec.com/products/motion-sensors/imus/bmi270/
> +
> +properties:
> +  compatible:
> +    const: bosch,bmi270
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +
> +  drive-open-drain:
> +    description:
> +      set if the specified interrupt pin should be configured as
> +      open drain. If not set, defaults to push-pull.
> +
> +  mount-matrix:
> +    description:
> +      an optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg

Device can operate without power provided?

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imu@68 {
> +            compatible = "bosch,bmi270";
> +            reg = <0x68>;
> +        };
> +    };

Keep just one, complete example. You miss here several properties.

> +  - |
> +    spi {

Not much differences in this example, but if you want to keep it, then
make it complete and fix the node name,

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Best regards,
Krzysztof


