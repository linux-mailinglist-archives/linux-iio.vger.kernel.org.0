Return-Path: <linux-iio+bounces-9465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503AE976A39
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 15:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3D71F24012
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 13:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE61A2641;
	Thu, 12 Sep 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0nWqzBk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9E11712;
	Thu, 12 Sep 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146954; cv=none; b=NoA25bg1MeB4AlOwJ4e7QbNfCxEB9ihPBV/wbGEmm4JYChnUMDIApyHGWmWhVnt9TGJZUNQSphQxZln1fQt92gFwpRPd0BDFOI8gtlVz6YjlL7LcKKjT9bpE6hl3g6qlsrvzWNbPrsPvWdsbcnMAOPk9SAz3skntOz7xASXAYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146954; c=relaxed/simple;
	bh=Mbc7VcX998xWkc6JZN8LW23ul8vOtaHFcVt8+WMqKFg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=J0z2vFHQRCNh6HaGrjA5hurtPl8hWjPvsHH8k3PtCXBFOVR6fGgBCKnX2m3mFMWGMHN6WDLMuUsUJh571iWV0lhL0+vDQ3R9m02SkbtG60iunh7hV49uYzh2Zv7FDCYHavJCuM7S5PMufiwI19ckAA+xZaBwuWWqcEG0C3GlBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0nWqzBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C90C4CEC3;
	Thu, 12 Sep 2024 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726146954;
	bh=Mbc7VcX998xWkc6JZN8LW23ul8vOtaHFcVt8+WMqKFg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B0nWqzBkx03CCcx2KhnpvJlz4SRqvZUVJ5NrLouCXukJGXgAw71v9z/sq8D6Ac6vh
	 D6i5OZ7wPzKDWSFhdHgWw3ddqc7jU0rVrThe576K+ngsDbQaPltAWreRtbDdWdhuMq
	 Uy5SU0rEANZF/e48B6iRrFtORC1ZbPxRsXcbMnBKq+blF9ZiEvjRzUcz/jIpmQ1Bbf
	 UiH/8zBm8liC4MkOUJDbtWC/wxuiCjc1E0fNGKurALPhfmcRw3SPZjp0gU5FLKcwrC
	 e56l7JvUUsYcw39bg/zzUy+XLG2jydcpwk5O4aqvmz5obu08Cdmm4G7cIujkhhRIKq
	 rZS5QIwAKClqg==
Date: Thu, 12 Sep 2024 08:15:52 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisadariana@gmail.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marius Cristea <marius.cristea@microchip.com>, linux-iio@vger.kernel.org, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240912121609.13438-2-ramona.nechita@analog.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
 <20240912121609.13438-2-ramona.nechita@analog.com>
Message-Id: <172614695270.3185531.17275124785979190338.robh@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: iio: adc: add a7779 doc


On Thu, 12 Sep 2024 15:15:45 +0300, Ramona Alexandra Nechita wrote:
> Add dt bindings for AD7779 8-channel, simultaneous sampling ADC
> family with eight full Σ-Δ ADCs on chip and ultra-low input
> current to allow direct sensor connection.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7779.example.dtb: adc@0: Unevaluated properties are not allowed ('vref-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad7779.example.dtb: adc@0: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240912121609.13438-2-ramona.nechita@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


