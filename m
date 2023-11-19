Return-Path: <linux-iio+bounces-168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CC67F0709
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A4D1F227FF
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929A134C7;
	Sun, 19 Nov 2023 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNTtecu+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41537134BA;
	Sun, 19 Nov 2023 15:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A71FC433C7;
	Sun, 19 Nov 2023 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700406489;
	bh=DaOvlUbm/d5dvcv4fwobRa+i+wZixsmjZoJS2PIC9AA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VNTtecu+LhBFOjoSX1gBMP+tbB6apLHBbBKWlvPq9Py3qanifjqE3OLX12lWH+9aN
	 vznns/BAk+RKkNuHR+Gr7f0SX/5at/ixS3cOGxMadfSq4uIr6DbO5pp8wWMLqxXMRb
	 Fde2og3EoUD8tX9moHehS0/o5yfmSgzlL6apfXx+DY66+yEPGXgILZIkC3NPLZgpAm
	 0ABTrcRjkPHLXJUQzJtimhmY5EENUnO6g3Dg7mzkYNIW0hcOjFp08KYqAYok1XxWiE
	 g5hgEWkm+BbmtB2FsS6UUteVCpAKFXaHzxhoZOldmj5/1MQ5s2cU+5yJNEUQ/vX950
	 ZaN0dTD3LIPZQ==
Date: Sun, 19 Nov 2023 15:07:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Naresh Solanki
 <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: isl76682: Document
 ISL76682
Message-ID: <20231119150756.20a023b5@jic23-huawei>
In-Reply-To: <20231118000614.186558-1-marex@denx.de>
References: <20231118000614.186558-1-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Nov 2023 01:06:09 +0100
Marek Vasut <marex@denx.de> wrote:

> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality. Document it as trivial device.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

I'm always a bit in 2 minds about trivial-devices as it doesn't
include a basic power supply.  In this case vdd which I'd prefer
to see documented even on such a simple device as this.
Not everyone is going to leave it powered up all the time!

Still I'm not that fussed. Maybe it's worth allowing vdd-supply in
trivial-devices.yaml?

Jonathan

> ---
> Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
> Cc: Andre Werner <andre.werner@systec-electronic.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <mazziesaccount@gmail.com>
> Cc: Naresh Solanki <naresh.solanki@9elements.com>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
> Cc: Vincent Tremblay <vincent@vtremblay.dev>
> Cc: devicetree@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> ---
> V2: Add AB from Conor
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index c3190f2a168a2..27164e9219276 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -179,6 +179,8 @@ properties:
>            - isil,isl29030
>              # Intersil ISL68137 Digital Output Configurable PWM Controller
>            - isil,isl68137
> +            # Intersil ISL76682 Ambient Light Sensor
> +          - isil,isl76682
>              # Linear Technology LTC2488
>            - lineartechnology,ltc2488
>              # 5 Bit Programmable, Pulse-Width Modulator


