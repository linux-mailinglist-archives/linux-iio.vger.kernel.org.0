Return-Path: <linux-iio+bounces-17252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B5A6DCE7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0411B3B1FB7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA9262D08;
	Mon, 24 Mar 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIYa30e5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8126281E;
	Mon, 24 Mar 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826087; cv=none; b=Yjc0Flvhd9h1oPIQSC06L6Xs0An3lPOPZkH5TQgzOufYC7mH1h53ur6ZWdtnlXKU6AgaKvPSI/mOV9ygFb4qt8Qrjs9JBkVoPDwO2fj2E3J+ay6HN/Gkq4ao4f21WnK73K84kMiy1zHORu8PBJyuRmHO53VAkTjnaz6fcs+wXM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826087; c=relaxed/simple;
	bh=dCI8OSKIxwwr1ihOWrRWoMsJjtQccnPBuJUUErjyEUU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SLvton0Rn2PeytFMMs7JgI4ahSmBfYUy9UtRcEYuPG3BL4zfMoAOnwc5tJ+McoWOSEEsD4VjDpiuBVQirWfe/uhMS/yvRRSq9KSGMn8TcOoxq+cBPIilSX7/zSTudZhU0PJ68KtAFU0Ves12f04tBPmRphxHFw7z8LpGEol97WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIYa30e5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4FCC4CEE9;
	Mon, 24 Mar 2025 14:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826086;
	bh=dCI8OSKIxwwr1ihOWrRWoMsJjtQccnPBuJUUErjyEUU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=LIYa30e5tYKCYgBaox0Rz26b4cPeJNI16cmoMT7/nDSBYc9y5Vvoob+acSoPqD+3y
	 6bT3fiitpOSgWL4USFBcHjxFKmFB+7Nq/WSdEC9hf1ICUh9M5Izu8GMAc2+clWPtGs
	 7pNxjCC7Xruz5Kwj/pbIEQx0oTfKo7AhquWkfckW7iRSSKVSpbjuELDl0a3vN8aPJ6
	 AEZf0zKIYKYnbI0o4BCdkTQWT4fCYCb877ho5YN7Kb82aUhgoMbNNY9nB3K/pJbLfG
	 hXIYmS+i8mzPY5/gLb8wVMzeO0mOawp7K2xIPbKs70pyc9loWEYmsmJBR7OnlSw4Lr
	 i7+Dhe4gwOHvw==
Date: Mon, 24 Mar 2025 09:21:24 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
In-Reply-To: <20250324-togreg-v2-3-f211d781923e@analog.com>
References: <20250324-togreg-v2-0-f211d781923e@analog.com>
 <20250324-togreg-v2-3-f211d781923e@analog.com>
Message-Id: <174282608144.6314.4370780992261179576.robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: iio: dac: Add adi,ad3530r.yaml


On Mon, 24 Mar 2025 19:22:57 +0800, Kim Seer Paller wrote:
> Document the AD3530R/AD3530, an 8-Channel, 16-bit Voltage Output DAC,
> while the AD3531R/AD3531 is a 4-Channel, 16-Bit Voltage Output DAC.
> These devices include software-programmable gain controls that provide
> full-scale output spans of 2.5V or 5V for reference voltages of 2.5V.
> They operate from a single supply voltage range of 2.7V to 5.5V and are
> guaranteed to be monotonic by design. Additionally, these devices
> features a 2.5V, 5ppm/°C internal reference, which is disabled by default.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 91 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 92 insertions(+)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250324-togreg-v2-3-f211d781923e@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


