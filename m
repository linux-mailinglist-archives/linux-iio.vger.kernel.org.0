Return-Path: <linux-iio+bounces-26573-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7254CC95236
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 17:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D52E3342B62
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C1298CA6;
	Sun, 30 Nov 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYE/JBe2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D915A864;
	Sun, 30 Nov 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764519364; cv=none; b=QlL3fFkHePuKSFl4agbdfPY4530VkUp65Gd+Zv4jibAgsFttN+xB4pzsREV5YUz3QHryWBkGRMYjTbwcF4+5lraCeADJdeWNraVnz9bNt0ndbqXMQkxrLi/DpC5XbLjdcBGure5wV22G1SyeHRTYatGPBpiRD2CTtexLTDEZfQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764519364; c=relaxed/simple;
	bh=UQoyz7NmQApLDrpw/+9aqo8k2qLruHLlwuq3Ky/pYhw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FZLScvBTFJOO1DGL7oAc3ASnTOyv1OW76+kSDkh9Ad0IkdLxIlLUbD7mA+GRBtXjV/WfsCW8514wT+qHEmFZ6Qbo5d1C4iKgx6Ws9tyVJRhdMFG+U2IjrSVz6tin4ZaiA6CrC0dFMu+Xd2jInnYOOuba6RMDx6EPgSJ6xmc4UPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYE/JBe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE665C4CEF8;
	Sun, 30 Nov 2025 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764519364;
	bh=UQoyz7NmQApLDrpw/+9aqo8k2qLruHLlwuq3Ky/pYhw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lYE/JBe2eQXWYsMoSlJL9EO+KBiyUQM9s0eBrNmNCSTTX2dSpftjhdMIcE9wkGd0B
	 QOSgtkw2cSLIi0UeLPpdEqDiV0s7nwG8eT+KdTff4rQ962hUTNeB2OLU5Hf9V3Lml9
	 UHxHdpoQBoG1sSX0vuE7gSk95foSTdJxlOjONKWXamZbxiqcZ/WjEu8Cle0mxGrL/a
	 W83IcchPi/BJ+BbH9rxbc6EqfM0imOe2NXNu/om6O8Btb7jC3aHa3qUtkrSjYv+WCF
	 qz4F4I7igt/IynTt2Z2+zZvbqtHZi3EjW4+aPUP0OUjz2KxpL5rRjddeiXF84AMGsm
	 R9agoE3/D8cnw==
Date: Sun, 30 Nov 2025 10:16:02 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dlechner@baylibre.com, conor+dt@kernel.org, neil.armstrong@linaro.org, 
 krzk+dt@kernel.org, linux-iio@vger.kernel.org, skhan@linuxfoundation.org, 
 nuno.sa@analog.com, heiko@sntech.de, andy@kernel.org, 
 david.hunter.linux@gmail.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jic23@kernel.org
To: Shrikant Raskar <raskar.shree97@gmail.com>
In-Reply-To: <20251130153712.6792-2-raskar.shree97@gmail.com>
References: <20251130153712.6792-1-raskar.shree97@gmail.com>
 <20251130153712.6792-2-raskar.shree97@gmail.com>
Message-Id: <176451936113.1126569.7335546829589054725.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: proximity: Add RF Digital
 RFD77402 ToF sensor


On Sun, 30 Nov 2025 21:07:09 +0530, Shrikant Raskar wrote:
> The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and distance
> sensor that provides absolute and highly accurate distance measurements
> from 100 mm up to 2000 mm over an I²C interface. It includes an optional
> interrupt pin that signals when new measurement data is ready.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> ---
> Changelog:
> Changes since v1:
> - Fix patch heading
> - Fix commit message
> - Remove '|' from description
> - Update interrupt description
> - Add 'vdd-supply' to required
> - Add 'vdd-supply' to example
> 
> Link to v1:https://lore.kernel.org/all/20251126031440.30065-2-raskar.shree97@gmail.com/
> ---
>  .../iio/proximity/rfdigital,rfd77402.yaml     | 53 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251130153712.6792-2-raskar.shree97@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


