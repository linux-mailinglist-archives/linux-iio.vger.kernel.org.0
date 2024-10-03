Return-Path: <linux-iio+bounces-10103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1298FA83
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 01:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E712FB21E05
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0701CEE95;
	Thu,  3 Oct 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ40HjYS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671184E0D;
	Thu,  3 Oct 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998481; cv=none; b=hiJ5jiB9sJ2HqgUNgWBPRxF6oj3lWJabXJxv9RAt0o9IfQEeR6AoNGsGT8myApnXeZSfMZpbeLhwMpk5jDP1ZggsnDt/Ixsi7/W+BTplZlQwQuAbLSpgtgx1lFz4eJgATj/VCrR6gEi2MqZpMP71rkI5ffoEvGFW3O08L+xPZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998481; c=relaxed/simple;
	bh=EHsC3/L/h7cmzJqUtgelOzRFEvR0wI9S5FiKWJ+vQao=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=JZGJXF3f0JFh21K+gaP9YqcpaW3BpwMmNJthLIMHHkvhIvldYjYuisxJViSAfV9tnZSDcjMSERpd7nf7YH3IdrMKa3Sy3Bjh6WGnth8g21v+Ge9YgK55W9y+FftSFRvOFii/SzBls8a7RBV9PNArVvNKDGToxX9Y7tMeLCONiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ40HjYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DF1C4CEC5;
	Thu,  3 Oct 2024 23:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727998481;
	bh=EHsC3/L/h7cmzJqUtgelOzRFEvR0wI9S5FiKWJ+vQao=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fJ40HjYSo3RcsKuNHZDO309IT0vQBHUL7SJ1wX50bG0XrlFjqkWM9QVpg4QcRgFS3
	 3FQpDvPnS7LK+X0A9BfOv9nD+04534tu/1Zp3JRJbV0QZ33tEKAGCQtAHS5QWcgxNT
	 m79UJzynE7RHRvaV0o1GbkE8ZnSWiRr+tvQ6tMYyQA0v7YsjfUYA6KZ0S+6MBQeEkU
	 x45mj+Zid3FVNQsFw6wyEgwuSdhEqOuY6Lo0MRJLduX78YReXZdePVjTwNiWVHfNOF
	 X3kdmbkzz3Aggajkz0A1OFutnPc5A31pOkW7FtBUHcJP9auhrnknrj4ObWy7nhbeNJ
	 7iRjhkrd2YrHA==
Date: Thu, 03 Oct 2024 18:34:39 -0500
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
Cc: dlechner@baylibre.com, Nuno Sa <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com>
Message-Id: <172799847830.1778120.2943655597402379925.robh@kernel.org>
Subject: Re: [PATCH v4 03/11] dt-bindings: iio: dac: adi-axi-dac: add
 ad3552r axi variant


On Thu, 03 Oct 2024 19:29:00 +0200, Angelo Dureghello wrote:
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
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 49 +++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: 'io-backends' does not match any of the regexes: '^channel@([0-1])$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


