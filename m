Return-Path: <linux-iio+bounces-6413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EE590BB05
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B764B225F8
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B51991A8;
	Mon, 17 Jun 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhqFL1bc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAB1991A9;
	Mon, 17 Jun 2024 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652603; cv=none; b=EurMS34kJvuveyIDNeTtmKrtdVBu+hU80Eh3vkfyi39UFWJpONiJGrWCBd2127yfSmmPBkWCHCEJ2+5K8ULD7G4MjVauM5iM89ytIqD8eYwS3LnttcIM4h7VeF2rhO8sKNkGtY2ru+jFUFjbpENf3mzw9koNLNaPajAuyZ+5p/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652603; c=relaxed/simple;
	bh=BHpVM5S0GjsiRz2Mu5h5JP2x/wqrDe6o0UiG+yaosU0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Qizb5HPj06IN4lSwNxMM1P3AE2mYEi6ya2tX/CjgWNlioJ5t/Xt8W4LWxz1l+sBuOmNfPkE/qICsNwgULnf695JkxZVqt7HIpUeDT7W3HJ1nf/z4dSU9WwZMfMlkqI2ZNigmQhVjyK6o3u9JjhiekpOxpqVi1+nojCqG8MpFxZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhqFL1bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902D6C2BD10;
	Mon, 17 Jun 2024 19:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718652602;
	bh=BHpVM5S0GjsiRz2Mu5h5JP2x/wqrDe6o0UiG+yaosU0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OhqFL1bcDnPvchUBx5UcIMfvG8avkpbb+yRu1UBobKU9w5uo7A5nDQa5afVvwkZF0
	 IERyl79LStBUfhgD86XJziuQWLPhytHZLyGE9AApfDt8xxYwSqyZI71CT+mHay+uMq
	 4JUHtf3ERg5ZUDkJfyua+I+tq7tb/Jp8yl1ggEC9RBEC5wc5dxYK1MYo7h7DS4xZh+
	 V8cccPW+YuVvrOGHennTvIfBatoMgS1W4LOOA+4bQREYsPsw7bzZpeHTuQ/9MNhtVi
	 yOLRN6CswBMZ7i/NBI33fYgG9JQ4n10QmH2/Pmd28JqXXYlpYAPDe6CXUPSncTdB3q
	 v4qX+J5KDNxew==
Date: Mon, 17 Jun 2024 13:30:01 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20240617183215.4080-2-francesco@dolcini.it>
References: <20240617183215.4080-1-francesco@dolcini.it>
 <20240617183215.4080-2-francesco@dolcini.it>
Message-Id: <171865260138.3045376.15728867066959921704.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add ti,ads1119


On Mon, 17 Jun 2024 20:32:14 +0200, Francesco Dolcini wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> with I2C interface.
> 
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v3:
>  - add avdd and dvdd supplies
>  - add Reviewed-by: Conor Dooley <conor.dooley@microchip.com
> 
> v2:
>  - add diff-channels and single-channel
>  - add XOR check to make diff/single channel property required
>  - add interrupts, reset-gpios and vref-supply to the example
>  - fix missing additionalProperties/unevaluatedProperties warning in channels
>  - remove ti,gain and ti,datarate as they aren't fixed hw properties
>  - remove unnecessary |
> ---
>  .../bindings/iio/adc/ti,ads1119.yaml          | 155 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml: single-channel: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240617183215.4080-2-francesco@dolcini.it

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


