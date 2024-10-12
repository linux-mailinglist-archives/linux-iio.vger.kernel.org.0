Return-Path: <linux-iio+bounces-10515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900CA99B577
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25361C210A8
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B32119343D;
	Sat, 12 Oct 2024 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/SSccDz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04467178395;
	Sat, 12 Oct 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742859; cv=none; b=Ok/SmhW9lYD5g+xJjIBPyKR7J+lb76mVTQ9k0HUSO9UuILZnPmd+HQd7E7vHg9KxOB0ROlsqJxrQpUMHayVgGRD++eQxpic0y43OuMaSlydnt3EtXs2kzi1w4Er4teXCJuwithx48Tg/KNPhACJU3Dhd1tLq63OOj8hDnYMIxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742859; c=relaxed/simple;
	bh=Oucwl7VO0c/qyXQ84nDnFdXohCCFgLKsGT1zcZyNoRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVCZhmI/8zsEP/g7ILIlpTjT/IUHDOtXTHWsMd6xBxgDUDEE5Li3ZODqYqNxzpOZgkYMzN5y7ym5d57qP7smMDBYCn/dkqVxkyRhuCWyQRSObW+kGH5PwBU2SsmAHCYhHssQTym5IIosSOaxXh8Lfj8dBDj9aWr3O3rCAvJ6OnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/SSccDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F83FC4CECC;
	Sat, 12 Oct 2024 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742858;
	bh=Oucwl7VO0c/qyXQ84nDnFdXohCCFgLKsGT1zcZyNoRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/SSccDzctQHZoyM1gsyDSpqpCGPttWZ12HRK01ElEillWIUC1CpFzG2ZPfcd/sfJ
	 Xb3mCpALfG8r8Fhl4uwl3t2xeoo/lxhYVBJ5pkmKAHA9AwsG9NfRS+9lQF0Cz/Fgsx
	 HeaeHL9Mz4Pn0JzKTwrd22Diz1HNGAO3wrbw3RsM4g20BJrcpJ6wggtsenP+WOMasl
	 b7trgv3HFet91cIJhf83DItn/0DTzzO7kYs3v+zxv7NE8T0o7RuqlVXizuLFRr9OoO
	 uQ5o5cYfn24j2i/pxJXHbA5tPfLee4csMTgWMk8pr7Ifs2gjbbQEXaRTV4dQX5cWLl
	 O3viedFGG929A==
Date: Sat, 12 Oct 2024 15:20:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: magnetometer: document the
 Allegro MicroSystems ALS31300 3-D Linear Hall Effect Sensor
Message-ID: <20241012152051.644e0e61@jic23-huawei>
In-Reply-To: <20241007-topic-input-upstream-als31300-v1-2-2c240ea5cb77@linaro.org>
References: <20241007-topic-input-upstream-als31300-v1-0-2c240ea5cb77@linaro.org>
	<20241007-topic-input-upstream-als31300-v1-2-2c240ea5cb77@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Oct 2024 15:14:39 +0200
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> Document the bindings for the Allegro MicroSystems ALS31300 3-D Linear Hall
> Effect Sensor controller by an I2C interface, mainly used in 3D head-on
> motion sensing applications.
> 
> The device can be configured with different sensitivities in factory,
> but the sensitivity value used to calculate value into the Gauss
> unit is not available from registers, thus the sensitivity is
> provided by the compatible/device-id string which is based
> on the part number as described in the datasheet page 2.
> 
> The datasheet is available on the product website at [1].
> 
> [1] https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
Use Datasheet tag. It's not that common but it makes it clear what this is and some scripting
can pick it up.

> 
Datasheet: https://www.allegromicro.com/en/products/sense/linear-and-angular-position/linear-position-sensor-ics/als31300
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Hi Neil,

> ---
>  .../iio/magnetometer/allegro,als31300.yaml         | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml b/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml
> new file mode 100644
> index 000000000000..0a08e769f3aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/allegro,als31300.yaml

Rob's bot has better eyes than me.  Filename needs to be allegromicro,als31300.yaml

> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/allegromicro,als31300.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allegro MicroSystems ALS31300 3-D Linear Hall Effect sensor
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +properties:
> +  $nodename:
> +    pattern: '^magnetometer@[0-9a-f]+$'
> +
> +  compatible:
> +    enum:
> +      - allegromicro,als31300-500 # Factory configured at 500 Gauss input range
> +      - allegromicro,als31300-1000 # Factory configured at 1000 Gauss input range
> +      - allegromicro,als31300-2000 # Factory configured at 2000 Gauss input range

I was wondering if the range should be a separate property, but given these
are the part numbers the parts are sold under, I think compatibles are fine.
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: 5.5V supply
A quick glance at the pinout google fed me suggests an interrupt pin.
Even though the driver doesn't yet support it (I assume as I've not looked at that yet)
the binding should include it.

> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      sensor@61 {

magnetometer@61 {

> +        compatible = "allegromicro,als31300";
> +        reg = <0x61>;
> +        vcc-supply = <&hall_vcc>;
> +      };
> +    };
> 


