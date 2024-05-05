Return-Path: <linux-iio+bounces-4811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB508BC003
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 12:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF301F21680
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1B179FE;
	Sun,  5 May 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8e4nQqY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF86BA45;
	Sun,  5 May 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714904430; cv=none; b=JTinHWljxhqos8Gi1BXrjNTbLoHKRAqsiRR/oBeNZt0CRsupewxDPQUM6ueXPIAYFnTSuRlEhQJ31nGX6ITnT4mzYTqWbtzRpjV0xkqLF2HY2T7BlC6uqfp0aDmGb74vuMGHnIlBgGSCRpiKXGH6Z0hzwhEJ7jUjtSnDL25iZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714904430; c=relaxed/simple;
	bh=dpjRYpT+BU4zpN6asVLx0KY/cBkt90r8VxWECtL1bJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgzOMO3amY1M3U4yhPN2maQXlkIop5jJuciiHyDO/u7F4krY3JXEMLVZtjJQJlrLLLmsLfGBNU7+5IzkBIdWSZ6ino5lzFb5byS++joRHpgStzsORiAC7L0b0qP0oDnW0GWULQDF2ix3WaPjpzMJg3qPoBpvrJ3ikWiKxvhWfwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8e4nQqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0E8C113CC;
	Sun,  5 May 2024 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714904429;
	bh=dpjRYpT+BU4zpN6asVLx0KY/cBkt90r8VxWECtL1bJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P8e4nQqYf2G9m+a5OTjWQXyxV5an+WlSUTTfLQ7ZiHX1JqJzPnfimpxl98jv4eFRR
	 ZIuRrbAWUSKki+lNoIJu2U9eFPwLtWXL4MBAhsh0Tph6Onwp6vvEJVSp8hqDz1UWsH
	 H717/UmlHR0g5IF2TF2cDxtmPnflxMeFFcIZou6EIrUXoRRdIrEGrfwCs/6ZXrY4Be
	 pdCtQZn6LGaghMbt7aQG1QVNvznNqGrICOYXAnLWxZzZVfEcKiTQHfl/wKARIsrLKt
	 bQ3EebNCnLYNSKDBLzVhFCgoqEaJLlZTH3og+Ds6DE8QIj5OtH21huu2CKrXfh/rJt
	 26NZFQ/XOnqZw==
Date: Sun, 5 May 2024 11:20:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: linux-iio@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
Message-ID: <20240505112017.69e6787c@jic23-huawei>
In-Reply-To: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
References: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 17:27:20 +0200
Petar Stoykov <pd.pstoykov@gmail.com> wrote:

> From 60f5cc7f65b07124f19428a713c3bc33b9e4a7a7 Mon Sep 17 00:00:00 2001
> From: Petar Stoykov <pd.pstoykov@gmail.com>
> Date: Mon, 15 Jan 2024 14:29:25 +0100
> Subject: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
> 
> Sensirion SDP500 is a digital differential pressure sensor. It provides
> a digital I2C output. Add devicetree bindings requiring the compatible
> string and I2C slave address (reg).
> 
> Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
> ---
>  .../iio/pressure/sensirion,sdp500.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> new file mode 100644
> index 000000000000..3cdf17df7d52
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: sdp500/sdp510 pressure sensor with I2C bus interface
> +
> +maintainers:
> +  - Petar Stoykov <pd.pstoykov@gmail.com>
> +
> +description: |
> +  Pressure sensor from Sensirion with I2C bus interface.
> +  There is no software difference between sdp500 and sdp510.
> +
> +properties:
> +  compatible:
> +    const: sensirion,sdp500
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

This isn't in the binding that I can see.  It should be! 

> +      };
> +    };


