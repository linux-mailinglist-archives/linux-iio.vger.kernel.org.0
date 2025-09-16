Return-Path: <linux-iio+bounces-24160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4AB59789
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A238C3B2E94
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384D30DEC0;
	Tue, 16 Sep 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpPPiMz4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7FE1D7E41;
	Tue, 16 Sep 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029116; cv=none; b=pW1ydw5MuNFEAAUugrs1DPZ0qrWTyKWXJkR9Sgcx6DL6vjjm++CSzt2Gmx/3EhgRz4zkW+KML+8oCOun41i5MvxZjjhh81HGVX+tmkG+mc0sH6tzBNevX5wyUeDElaPU/SfbFm3/bu0vziGxUnRpj+Zmi/2UR3pCpbd+yfdCcZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029116; c=relaxed/simple;
	bh=Gwdtq3KT3Skby34FHqWvNTPDYodseuItYXyKgLbVyOk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=t14qU/KLrxp0eUZ14Oe+xABQ+9IWcs4pE//qRfFcuuQPF4xrNXtpOvDFmbdHqXGsg23luWRl24A8dsnE8TDGcTo1OPQlgiPNdkEabrc5bKKr4aRl4QSRqZSnHVXcuI/DxhOE9IUiZOemrB8dOYPhlya9VyC01EcSSng1GXS7n2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpPPiMz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D87C4CEFA;
	Tue, 16 Sep 2025 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758029116;
	bh=Gwdtq3KT3Skby34FHqWvNTPDYodseuItYXyKgLbVyOk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=GpPPiMz4wyZrApHDUFCob37XMpR/vuuYPGluQ2GKX0KCzW3AX9rthjNILfrQNmQ4k
	 wFgaixJ2KbzbQKm5ZFFHavaGE4QrJDy6K40ZMslyB37OGdbxd9OuvJoTM2YMUJNwJq
	 zstWZ2c890fwnk5bOjI2634zzNHR0HDcW9eyC8daUiCf73fGEQ0oH/2PMH/ypMSPp+
	 r/7dWFXTPuPfxHADjukm5U7qRyK4O4x2HVGvUdPkM97o0Ziz9cszs1mw4dQQTnK0WN
	 XzzjlgSp4OAtsCjuNmh1Z84arpLVuDHda6RsRteYteN1TAD/1HzyTUM3KEFY18Obd7
	 uqpQGpeyRxCBw==
Date: Tue, 16 Sep 2025 08:25:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
In-Reply-To: <20250916-ltm8054-driver-v1-1-fd4e781d33b9@bootlin.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-1-fd4e781d33b9@bootlin.com>
Message-Id: <175802889806.3636334.5922063165326624339.robh@kernel.org>
Subject: Re: [PATCH 1/4] regulator: dt-bindings: Add Linear Technology
 LTM8054 regulator


On Tue, 16 Sep 2025 12:24:06 +0200, Romain Gantois wrote:
> The Linear Technology LTM8054 is a Buck-Boost voltage regulator with an
> input range of 5V to 36V and an output range of 1.2V to 36V.
> 
> The LTM8054's output voltage level is typically set using a voltage divider
> between the Vout and FB pins, the FB pin being constantly regulated to
> 1.2V.
> 
> The output current limit of the LTM8054 may be statically set by placing a
> sense resistor on a dedicated pin. This limit can then be lowered by
> controlling the voltage level on the CTL pin.
> 
> Describe the LTM8054 voltage regulator.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../bindings/regulator/lltc,ltm8054.yaml           | 77 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 82 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/lltc,ltm8054.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/lltc,ltm8054.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/lltc,ltm8054.example.dtb: /: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/lltc,ltm8054.example.dtb: /: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250916-ltm8054-driver-v1-1-fd4e781d33b9@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


