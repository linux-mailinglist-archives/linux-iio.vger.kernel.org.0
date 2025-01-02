Return-Path: <linux-iio+bounces-13874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7D9FF6D5
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 09:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621BF161869
	for <lists+linux-iio@lfdr.de>; Thu,  2 Jan 2025 08:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83C194C67;
	Thu,  2 Jan 2025 08:24:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5014293;
	Thu,  2 Jan 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735806298; cv=none; b=T23n20pz/7lFgU7sguVB53isIE/9fJSe85C/FpuCRGESMejzC5EcDNLCGs/b3JvVDq9niMkFKjMEw5uj0Pup65MktYe0RyJ4KMEHsXug7iEKsUT6vYQ4UqNcxmO8+gYtL/11LIaR1NysbgiaG9ZEw5C2MEwwKJkI37jjA1N/f3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735806298; c=relaxed/simple;
	bh=nERRCssiTvKNvSGmZk1nkZOrH4iGbCVvV1P1JdEP2zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWPlSccBBqUE3JNgqB5xYKni0Dyv4A970hOXcZ34YrXOiQE4zY5+r/2WGZ02Z3j/th2O6aMtfNqqnEpwPZ9ErcPG+FxhKzXZlkP6fV9c4Nzg7fO/dYQnCe9WY0EOzwncWQ0GrbUSWdlp1WMy1Rl0LAOyA3gsCIuB9aaK98ZgGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52568C4CED0;
	Thu,  2 Jan 2025 08:24:57 +0000 (UTC)
Date: Thu, 2 Jan 2025 09:24:54 +0100
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, 
	conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org, 
	danila@jiaxyga.com, icenowy@aosc.io, javier.carrasco.cruz@gmail.com, andy@kernel.org, 
	megi@xff.cz, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add binding for
 Si7210
Message-ID: <rinmairelmsxzo2vy5jbs6t7elxuhwdyo55bvr6yg666ikkas2@qnu4pd5sccsr>
References: <20241231132513.6944-1-apokusinski01@gmail.com>
 <20241231132513.6944-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241231132513.6944-2-apokusinski01@gmail.com>

On Tue, Dec 31, 2024 at 02:25:12PM +0100, Antoni Pokusinski wrote:
> Silicon Labs Si7210 is an I2C Hall effect magnetic position
> and temperature sensor.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  .../iio/magnetometer/silabs,si7210.yaml       | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
> new file mode 100644
> index 000000000000..ef29d12811e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/silabs,si7210.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Si7210 magnetic position and temperature sensor
> +
> +maintainers:
> +  - Antoni Pokusinski <apokusinski01@gmail.com>
> +
> +description: |
> +  Silabs Si7210 I2C Hall effect magnetic position and temperature sensor.
> +  https://www.silabs.com/documents/public/data-sheets/si7210-datasheet.pdf
> +
> +properties:
> +  compatible:
> +    const: silabs,si7210
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1


You miss the vdd-supply, because otherwise it would fit into
trivial-devices.

Best regards,
Krzysztof


