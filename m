Return-Path: <linux-iio+bounces-17577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D53AA79BEE
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 08:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487551893B24
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 06:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F4919E97C;
	Thu,  3 Apr 2025 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ86fbcj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192941DFF7;
	Thu,  3 Apr 2025 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743661638; cv=none; b=HEiDzgzOY++c/v2UA9FPlMzrEWV1Uhr6JyBbDZxqUHv0eR+QIUN5nq74kzbckvGPNp0utsF/WI1cZzjMVT01iss0tW0iCV6MCxD5oMOwf4ohePOaD3VDe9NjhlvGz7Kc6FROn5Hoywm7kHhlSzOHZ8AH1JHO+blItQ1ZzaaBxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743661638; c=relaxed/simple;
	bh=X8V6uIOiffOO7xHmNHXIgtQraGK/QDMtWqEVtPA3lXQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=R6G2S9NAbvk1JwY5rWgHBVsQMav+WuTXR7+zrBPYdLLBShMoVxoJ6s2c8POUNgRUe5KTPmrzi2caXvYf5BBQU3vDPAxq2uSjxNzWB9yhvBTYTiFH3F/rQWp7LFhWPL8J6CF4qQ9dm+XQjWYnISzA191FW87BxaROeNMbwEnBuDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ86fbcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8F2C4CEE8;
	Thu,  3 Apr 2025 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743661637;
	bh=X8V6uIOiffOO7xHmNHXIgtQraGK/QDMtWqEVtPA3lXQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GZ86fbcjQcd7Oqk1o64brBniMeBX1Vz/gd30Ooo19UlPV/oA39fduqzKMEv52sKpd
	 2tFFYqNsS0z56Bhnm/VgABGFjjx1d+34T7uMoCUdbdnvGSzuFK0ycMftFzyf8b+II8
	 yxJid/4TEKAZfDz5TyqNI9lfrOXCLimGCLIEq6K93OnF1I2L5qo2cKTbv1gcr3E2jE
	 L5rfcNQVkPibGkEG5wRE2wWd2fjztFuFIv5fVwCy5ssizxarHTozgKqyQlJSmBGTGk
	 tQCX7PiPdeQe4UV0DYl8DYc07zKXh72LhcQcDQXN32Jw0ljSP6t6Ps9ueBp+SutpCt
	 Lec083sKmnzBg==
Date: Thu, 03 Apr 2025 01:27:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
In-Reply-To: <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>
References: <20250403-togreg-v3-0-d4b06a4af5a9@analog.com>
 <20250403-togreg-v3-2-d4b06a4af5a9@analog.com>
Message-Id: <174366163644.1411732.10426808100774096920.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: dac: Add adi,ad3530r.yaml


On Thu, 03 Apr 2025 13:33:56 +0800, Kim Seer Paller wrote:
> Document the AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel)
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls. They provide full-scale output spans of 2.5V
> or 5V for reference voltages of 2.5V. These devices operate on a single
> 2.7V to 5.5V supply and are guaranteed to be monotonic by design.
> The "R" variants include a 2.5V, 5ppm/°C internal reference, which is
> disabled by default.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3530r.yaml   | 99 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 106 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dtb: adc@0: pwm-names: ['convst1'] is too short
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/arch/powerpc/cxl.rst references a file that doesn't exist: Documentation/ABI/testing/sysfs-class-cxl
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
Documentation/arch/powerpc/cxl.rst: Documentation/ABI/testing/sysfs-class-cxl
MAINTAINERS: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
lib/Kconfig.debug: Documentation/dev-tools/fault-injection/fault-injection.rst

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250403-togreg-v3-2-d4b06a4af5a9@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


