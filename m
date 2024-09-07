Return-Path: <linux-iio+bounces-9293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6391E970306
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C831C213A5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198B15F308;
	Sat,  7 Sep 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Eu53F2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987715B559;
	Sat,  7 Sep 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725724072; cv=none; b=ei2AFqD3AHL35/AZGtQuCajniEXWqrE0zHu4R8iliQwEs0gieyc7kW0/iDoIOSZ6pZdiWXucr4367QZCVtsm1VZxBVyw/yqHX/Hf2WgEdxMI98QOvFCrxjeeL6VoZjojsnGRja+N+MXsvud1iB6JVUtOLcKhEZVdL1FH9hiRbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725724072; c=relaxed/simple;
	bh=Ni1/gHGT/qBIxRvpd9x87loODs4Q4AzVe+rcMgSLif0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExiwgZltSd0YE9IK6eqkv+gCngGq4oX3klyJyrXzl5N55R9PFdDXwDmeMamaBnrnw/1xxNzUPCJfhrqLerM5hLplB0ffcRcjLQOi/ytjlrCNlsobe4IcYxcx8f91YIw7A3ioDmHF+5sjtyKOyCSc8kn17xMIgN+r1PDHFGTpG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Eu53F2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA246C4CEC2;
	Sat,  7 Sep 2024 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725724072;
	bh=Ni1/gHGT/qBIxRvpd9x87loODs4Q4AzVe+rcMgSLif0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t4Eu53F2QnaYtVu7Qm+tcO5Ofp1pxVYqW7oi+LuHMm033YOD0tl47RSi2Bvx+Paq5
	 G9at/Bt7+siQUisOL4SSh1UCCKBNaIzhOv5wV8McV+n3dmTY0xLLp963VpE7ke1ze7
	 4STDz5ghfeVlhF/RbZQ4LU9NSHPsdPIPv13unTcwVu1xAr7iX3IbfCKp5bYfNgdFtC
	 9QFj+Tt3thNrxBW90Y/zZhAavYsWAraoxCCSJ8B3l5dULblWfHJirZFMVDVxqHcgGx
	 oJNu7fR4DkdGzQWLpd/vhNJtfGCPPybbS4V1wSpklt5sma7Ua8RzH9JJhXrddOIA6L
	 udZ6MTO0FP4oA==
Date: Sat, 7 Sep 2024 16:47:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
 Nuno Sa <nuno.sa@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: imu: add bmi270 bindings
Message-ID: <20240907164743.1cb7070e@jic23-huawei>
In-Reply-To: <20240906165322.1745328-2-lanzano.alex@gmail.com>
References: <20240906165322.1745328-1-lanzano.alex@gmail.com>
	<20240906165322.1745328-2-lanzano.alex@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Sep 2024 12:52:50 -0400
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> Add device tree bindings for the bmi270 IMU
> 
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
Hi Alex 

One totally trivial thing inline. If nothing comes up in
driver I'll tidy this up whilst applying

Jonathan

> ---
>  .../bindings/iio/imu/bosch,bmi270.yaml        | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> new file mode 100644
> index 000000000000..7de35b9bfa2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
> @@ -0,0 +1,77 @@
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

pins

Even if they are configurable separately we've previously argued that
it is very unlikely a board designer would want one open drain
and the other push-pull.  So simply making the description plural
should be enough.

> +      open drain. If not set, defaults to push-pull.
> +
> +  mount-matrix:
> +    description:
> +      an optional 3x3 mounting rotation matrix.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - vddio-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        imu@68 {
> +            compatible = "bosch,bmi270";
> +            reg = <0x68>;
> +            vdd-supply = <&vdd>;
> +            vddio-supply = <&vddio>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <16 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-names = "INT1";
> +        };
> +    };


