Return-Path: <linux-iio+bounces-5202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6F8CCB5A
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 06:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01361F224A8
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 04:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F25579F;
	Thu, 23 May 2024 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyPu2ARK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83538FA8;
	Thu, 23 May 2024 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438257; cv=none; b=hO2R3RVyK1HyiycUuyaVejtCp/uB0uSxEIE8dM7Ou4MrA2Sr6jG5o0FOwWo+96zpsAKj6PyQgzTtE7ofWiJnuTuApH80W7v3VaGfGnWkgJ/ryHwiySlpggzy31WLOeaEpPFLiBw7tzHqNTu3zJHUPHcKK7Pnx4WahSLnn3niuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438257; c=relaxed/simple;
	bh=0wOFUajYamp8413E77jipahrUa270OFvH9nZ8xjqUDc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=j8Usu7GqWsxik5PWCc5I5akI5coaZSPLxJA8L0vrWPjKtJSwVFGmXpIIdRK/zBvb6D+Rr0fwVsA9vfW2RoqogAcoC5hhbyg58xA+RV2qAP584Wrm1+lCaHW6smDVIpw/BxfUOaQBMXWnGU2z8FWpw3mO1a1bxJB1+YiGfTp2d3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyPu2ARK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF913C2BD10;
	Thu, 23 May 2024 04:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716438257;
	bh=0wOFUajYamp8413E77jipahrUa270OFvH9nZ8xjqUDc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gyPu2ARKMQyxy+orRMjl2ZUXnvVy0ThmGMjqxmUU3Cc1ETH3Rg5d4YJo3APVVHitK
	 Xiyq+5xsq4RZH8MZNnLaGyHGMY4lSuPFbPnp9Qb1JwxHUhnmNFHJOp3t2L0ym8+XnY
	 CmYmXITon/97HnMByy6IH7DPa8oie9pOnJHA4uFdQPp5QagBW8v6OMr6PDCGfQJ+sV
	 4SOdMErAeNrEF6srWnJWDUoRCdwsiiJlPh+nTXY7mz3+5rQWgvcdmF2XFSLwpd0g5L
	 ghTtWvQF8sqQEdS4QFRD/7JIRILc9/+LDTNJVT9ZYKK5csNkikWk6gb+N2bwuXF4dT
	 UnnyzKAdFlmsw==
Date: Wed, 22 May 2024 23:24:15 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-iio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
In-Reply-To: <20240523031909.19427-5-kimseer.paller@analog.com>
References: <20240523031909.19427-1-kimseer.paller@analog.com>
 <20240523031909.19427-5-kimseer.paller@analog.com>
Message-Id: <171643825573.1037396.2749703571529285460.robh@kernel.org>
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml


On Thu, 23 May 2024 11:19:08 +0800, Kim Seer Paller wrote:
> Add documentation for ltc2672.
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/iio/dac/adi,ltc2672.yaml         | 159 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml: patternProperties:^channel@[0-4]$:properties:adi,output-range-microamp: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240523031909.19427-5-kimseer.paller@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


