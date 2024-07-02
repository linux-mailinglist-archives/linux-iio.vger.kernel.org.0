Return-Path: <linux-iio+bounces-7183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0F9248FC
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 22:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7334328566A
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E536200131;
	Tue,  2 Jul 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNY18xBy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249C282E1;
	Tue,  2 Jul 2024 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719951512; cv=none; b=try5Ay/hGHr0v2m91I9S7y44xRT2Ws+H5dK1oMERYiesydJQ2TcQmTnxDncU7Nd/cVMOsKcXyxvqTBgo5w/KaspfJptMTvfNwYbiC3+fPi74gfA6iZAn7FgsFIMo5MYBeGdy0Ff6TZ3nHbgZamMrwMJ3yD4XyOV+wJ2u/FbVoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719951512; c=relaxed/simple;
	bh=QrEaSpqPgFa3iuRzf3gK2xG05dyli8XIz2bZKs+X6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmdVKLhYc6rDDQxeESuygvYCeUDhyiY4zm7Hpjr9ztnzDy0X6A+qw+rCfiSkk1knNfea45xl+blePJSZrCmR7rPu+WZfKpw/DpNEChjGBpxz5SGl4T8EebVJ8tHIEA9mrNjcdujqMQ7yvVgBZCnFkcsvWwOmIDiuy56nDFKhQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNY18xBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D1CC116B1;
	Tue,  2 Jul 2024 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719951511;
	bh=QrEaSpqPgFa3iuRzf3gK2xG05dyli8XIz2bZKs+X6/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TNY18xByc4X9D3Gr2gpCChpzm8b0bjN7L0aIHGPUbmJWsI5x5ZqDKDdAegVxrOdwW
	 V1mqplb+CwGnQgOCNcKv+68+ADRz6I2McpYPWXn6exnb14Jc3FcDBD6OrVNR5ivykY
	 /MyeX3gjTAKOSAp3D/wnOjFLjvCoUvRSVV88PEmclo04RBWrdIare0krL2on9+GnDe
	 LYKMsWUgYVJd2wImRg+vHZORvVnxQcxwY9clS4Na7hV7dQ7VLLuriTIivBIje7L+Cs
	 Sn7zGORv7FBIwMFEOswxx8yKzFLBO3dl6CDTrPP5q2FZCarAQsAwP8sPhVGERv7KFP
	 KSEVqWGJwBWHQ==
Date: Tue, 2 Jul 2024 21:18:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org>
Cc: pd.pstoykov@gmail.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <20240702211822.3bce44c2@jic23-huawei>
In-Reply-To: <20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com>
References: <20240702-mainline_sdp500-v3-0-0902047b3eee@gmail.com>
	<20240702-mainline_sdp500-v3-1-0902047b3eee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jul 2024 16:59:08 +0200
Petar Stoykov via B4 Relay <devnull+pd.pstoykov.gmail.com@kernel.org> wrote:

> From: Petar Stoykov <pd.pstoykov@gmail.com>
> 
> Sensirion SDP500 is a digital differential pressure sensor. It provides
> a digital I2C output. Add devicetree bindings requiring the compatible
> string and I2C slave address (reg).
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> ---
>  .../bindings/iio/pressure/sensirion,sdp500.yaml    | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> new file mode 100644
> index 000000000000..6b3e54def367
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#

Naming mismatch (as already reporteD).

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: sdp500/sdp510 pressure sensor with I2C bus interface
> +
> +maintainers:
> +  - Petar Stoykov <petar.stoykov@prodrive-technologies.com>
> +
> +description: |
> +  Pressure sensor from Sensirion with I2C bus interface.
> +  There is no software difference between sdp500 and sdp510.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sdp500
> +      - sensirion,sdp510

Include the vdd-supply both as a property and in requried.

  vdd-supply: true; 

is enough for the property.
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pressure@40 {
> +        compatible = "sensirion,sdp500";
> +        reg = <0x40>;
> +        vdd-supply = <&foo>;
> +      };
> +    };
> 


