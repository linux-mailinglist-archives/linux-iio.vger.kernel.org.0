Return-Path: <linux-iio+bounces-10349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022B899558C
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A251F26237
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E01FAC55;
	Tue,  8 Oct 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu4OvjtI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF61FAC4B;
	Tue,  8 Oct 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408127; cv=none; b=Yo373DTHetYdhh7Js5tTuRGvScUuRkNKRbwWL/YfYen9cV1Gwfx/tghgWpUai4pqDvEdlhWG6szeUc9Ow9T7hCvtUSA/SbXSEumLgqysrfmC5D7moJQS19kG9WwwEUG3wKJ29U0FuFoKTyBN4t0TBPLEwNrwwS6c5UBAQWcWBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408127; c=relaxed/simple;
	bh=1bMYdO3pQcpZWDdsYwMovLeFjs0vbYhDIVKZ9zvB+2U=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=US1xjEPK1nB5qqtkvShXVdlLxqfNkhFP9Oxn5/BKg1U5e6GhRlo+SpHl/aCC76lyh4kOgheO5GJqENZXbWiMR+4xXerd3sPSyeIby/CzpsvswWeIT+KwcgiqJ/5HgOW2mAWcF+9DhvT5CueTmBSMt135D1oZk2i9jWzQAwzMYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu4OvjtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1F0C4CECE;
	Tue,  8 Oct 2024 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728408126;
	bh=1bMYdO3pQcpZWDdsYwMovLeFjs0vbYhDIVKZ9zvB+2U=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Nu4OvjtIyqiL1qJSPDSdnvs4zAnDewEsZa4Vqx4GkQHqNOX+XC5D5e3avKpxBBZgL
	 HmV7/jfsepvnMtyl4uWgDXBqiOULpuWO8MCtY7MiRN3svnAg/9ohbCqc9oFhEqb6Id
	 mKImagEHTkADom6yqzsMcCRWFDQT/QznHXYfYJzzwbu96lDZif8UUANRGCAR1MytZZ
	 GciP1PYndh4eBJajpmm6e6xNHkcbuoj4+PdLr7naeWrhaDCLjuawufYIrMgA73+7cY
	 uUGpqHZ+bcePN8gzDoMmJG9TezP6Hn2Sd0TnGg8rtQZM1h+v3uNsSlH60Kj0dKXqgx
	 BIqTnJWyH1OZQ==
Date: Tue, 08 Oct 2024 12:22:06 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Nuno Sa <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 dletchner@baylibre.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
 <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com>
Message-Id: <172840812598.1881490.11957892692384833449.robh@kernel.org>
Subject: Re: [PATCH v5 04/10] dt-bindings: iio: dac: adi-axi-dac: add
 ad3552r axi variant


On Tue, 08 Oct 2024 17:43:36 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add a new compatible and related bindigns for the fpga-based
> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> 
> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> mainly to reach high speed transfer rates using a QSPI DDR
> (dobule-data-rate) interface.
> 
> The ad3552r device is defined as a child of the AXI DAC, that in
> this case is acting as an SPI controller.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


