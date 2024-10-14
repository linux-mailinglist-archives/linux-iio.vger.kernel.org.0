Return-Path: <linux-iio+bounces-10562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E9999C8A9
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 13:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B8F1C233EF
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AEC198826;
	Mon, 14 Oct 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLdZnnEf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6933C5;
	Mon, 14 Oct 2024 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904864; cv=none; b=YJETjrN52sEaDpgsvoHNwpZaj98lIg5SxxDDwLTzeDb31qREILP3DJh+o+cl534gn1PC8f5xGDpkRfu6zOx1go+ULFFJzLTJbGcngCo97RWWVnTNURrTiE4Xl5X3R+bHlUdxd7Kw3iIhNQd71CZiH4CtMZhA2nHGwv7gJoFKxn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904864; c=relaxed/simple;
	bh=Xqko9V57lWW0rPEqMq5h99rHhyWdWTenF1P68Pwcwqo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZmwqJ+llhLdVty6ipD9UK9pkj0A1+yT0Kb5mQV6flMxm9o0wR6yRPhuWeDyORnzcWg0Y9RzI7OteyvsHAEEoT4gZF4F+ucE69q9S/f0+WmlLj64Iz9HXi8R0bHzxXfVAmY4xwWVp43BIfdkcolCe9jo4xystkRAOglsCrD+1T88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLdZnnEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF7EFC4CEC3;
	Mon, 14 Oct 2024 11:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728904863;
	bh=Xqko9V57lWW0rPEqMq5h99rHhyWdWTenF1P68Pwcwqo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iLdZnnEfbChFRYWGWGQ0+hfo5wmBIyWpdA12yqph+iiWnF1sAqtAJnWvISKPoapXc
	 1saCR1uK+cvmzU85vZnjjCf3REnpd3onFi1dwIPDhOiz+7BpoJMZmnVlTlCwrBrdCQ
	 +vREwD8tWXU9FrBjs1jkdQQT0ZxVAqSXPh4TJBB+FC+ruOhtWNi5kCiURo7SG6toYh
	 BOy2uGUCd6prZ36v5LqSBf+tWADBbpT/9dQp1Bu1g6PK7LJ9nKXkQJQOTZ6cYlZErI
	 b/pVgTZ/F3lRYgFEwP5CnO83nLf8ETfVB2eyrg7i5GF2d45EWcm0vNvIgnqUk9vu+V
	 xo3MvdbyO2Ilw==
Date: Mon, 14 Oct 2024 06:21:02 -0500
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
Cc: linux-iio@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dlechner@baylibre.com, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
Message-Id: <172890486251.793259.16216468875581353928.robh@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant


On Mon, 14 Oct 2024 12:08:08 +0200, Angelo Dureghello wrote:
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
> Note, #io-backend is present because it is possible (in theory anyway)
> to use a separate controller for the control path than that used
> for the datapath.
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


