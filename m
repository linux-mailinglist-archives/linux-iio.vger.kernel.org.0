Return-Path: <linux-iio+bounces-17076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C85CA6848E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 06:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0022B3B88BF
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 05:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931421129E;
	Wed, 19 Mar 2025 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4IlS7cP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D0382;
	Wed, 19 Mar 2025 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742361764; cv=none; b=OlR2INR7z1NDWxbWnUOnXEPHOyuDIBP4MvoKkkaOnwYuGYYCUbRQ3exGcBUKus39H0T0SO1wq4Cb2nKa1NOdiEc9n7iKmZ2ldt7boSanv6R9e1o48XNPBexf95af9xRO1cUI2vCizqarHv7XBGm3tyjRKtbZL7Qe8MxUuQvXNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742361764; c=relaxed/simple;
	bh=d4PbB06NR/lx+xA+bbBpqYwnNNX/TZz6zR/JsUmdDRA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=muOhEjfmXhsUQL/iD6b+HnZt7Iih8KtHrCScz7GatqmbyNVpZ8JBqk7RmrLENhl00bJif3CgqbZ27PBHCCiW+E1twuAKzeJaA/C6EijjmdaV8PbQom6zL/tkHC1r1n7p8PA8LXMr1eKlQVZEezlla09kHqXju2ziiJh+t5nn90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4IlS7cP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65896C4CEEA;
	Wed, 19 Mar 2025 05:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742361763;
	bh=d4PbB06NR/lx+xA+bbBpqYwnNNX/TZz6zR/JsUmdDRA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=a4IlS7cPcNplgTwqvNVHgRXuYuVQ5VbI93l15KxSSnRXdYn+oUkMhXBtulwpbkuvx
	 i2hT5HA/rglD/wzA3uilcN+bw95BpA6Zl+4YmqdVLmqLBpAcjFt+kA331G26Y5Ddzp
	 YVWbeTMOK/HL21VuUnYecgO0eyoTfZoCYGKeING/nHCZJlL/uHMTfKDc5uPjemmVAC
	 mlI90AIW8/S+NVuIF91zqABhc/7uI97gWoGEwe1+LKcNFp0uFMk0wcwHG6GVvdrPDE
	 wuWjSl+dxUB1PIHpWnoHpwCMB5VAw59jMWJ1aSL4sk5u4S9GjLDtI/TcNqHeqaj5Mw
	 NLAPuABFCoBYg==
Date: Wed, 19 Mar 2025 00:22:42 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
To: Kim Seer Paller <kimseer.paller@analog.com>
In-Reply-To: <20250319-togreg-v1-3-d8244a502f2c@analog.com>
References: <20250319-togreg-v1-0-d8244a502f2c@analog.com>
 <20250319-togreg-v1-3-d8244a502f2c@analog.com>
Message-Id: <174236176222.620075.12480666866175403765.robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml


On Wed, 19 Mar 2025 11:47:57 +0800, Kim Seer Paller wrote:
> The AD3530R/AD3530 is an 8-Channel, 16-Bit Voltage Output DAC, while the
> AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC. These devices
> include software-programmable gain controls that provide full-scale
> output spans of 2.5V or 5V for reference voltages of 2.5V. They operate
> from a single supply voltage range of 2.7V to 5.5V and are guaranteed to
> be monotonic by design. Additionally, these devices features a 2.5V,
> 5ppm/°C internal reference, which is disabled by default.
> 
> This adds the documentation for ad3530r.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 89 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 90 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/arch/powerpc/cxl.rst references a file that doesn't exist: Documentation/ABI/testing/sysfs-class-cxl
Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
Documentation/arch/powerpc/cxl.rst: Documentation/ABI/testing/sysfs-class-cxl
lib/Kconfig.debug: Documentation/dev-tools/fault-injection/fault-injection.rst

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250319-togreg-v1-3-d8244a502f2c@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


