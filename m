Return-Path: <linux-iio+bounces-27244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9E3CD21F9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 23:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 075543082FC7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DECA2BE7B6;
	Fri, 19 Dec 2025 22:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1NdgSPV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4060929898B;
	Fri, 19 Dec 2025 22:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184023; cv=none; b=pGtOj08T22XXy0tWqN3PkuBVDZJWcgX3JnXz74jaVO8wAA/1GTVIdnzAyxIBw02gcf6/kpPyVxFmpoxdGFhnM4EEZ9eMHE+FpYA77YrSAnAYsvnoOpGils1/NJMlWhlLHLaOk4h4B8fzD+VV3bN7HpGFDQELYuczhIPhnByAiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184023; c=relaxed/simple;
	bh=eJ34FuUpR/pTBKcemDB/lmpM059p4btRCSTLSk38njs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=TvuFDKbwLj3l2vkWVzcHLpeiaUhPhPyKvcQZLBnQxymjrRAvLA1H6zy0FzZicVwoErWbGu7VY8PW8SwL7kB13RsdEkGtnM81QqPIMt+HV7LU1fr8nJ+/1cf2RtMGmBNS5Ixz5VK1Z0kGKHg43hHWZ32gIT1CoPDkgOECMVonEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1NdgSPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6FAC116D0;
	Fri, 19 Dec 2025 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766184021;
	bh=eJ34FuUpR/pTBKcemDB/lmpM059p4btRCSTLSk38njs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=A1NdgSPVagiS95pWjYZApVLCSBDZev4fdTdTGoWPAeEp9IPp2syXq3uT43mp8dVkV
	 j2XsVyHXWecMWi1kxCWJo4e/kVL7Szwb8IqGMgyqMLA5Z3k0/XKMLN7CR7oZ5gK/6q
	 tG6eMRpks9k4Xa9vwU76EGltnMbmeQENHsHREjP7iIMuhEZgIjqSNBsOZMcrzIC73m
	 aeWc0KwlyayxTJybAgO8Db69invu2N6fU+/BT4r5k6T5OU/Q7ARF1rGDzdy1l95R/t
	 zBtfW33HD4LeXibst5c8tEW37XYiMoCnXdQGh68b40oC+MdVrhXx6gu4aM1zVso3st
	 H8FeFdEwHt+2g==
Date: Fri, 19 Dec 2025 16:40:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
To: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-2-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-2-145dc5204cd8@baylibre.com>
Message-Id: <176618401962.78408.15730875002100053150.robh@kernel.org>
Subject: Re: [PATCH v4 2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map
 properties


On Fri, 19 Dec 2025 15:32:10 -0600, David Lechner wrote:
> Add spi-tx-lane-map and spi-rx-lane-map properties to the SPI peripheral
> device tree binding. These properties allow specifying the mapping of
> peripheral data lanes to controller data lanes. This is needed e.g. when
> some lanes are skipped on the controller side so that the controller
> can correctly route data to/from the peripheral.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v4 changes:
> - This replaces the data-lanes property from the previous revision. Now
>   there are separate properties for tx and rx lane maps. And instead of
>   being the primary property for determining the number of lanes, this
>   is only needed in special cases where the mapping is non-trivial.
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/andestech,ae350-spi.example.dtb: spi@f0b00000 (andestech,ae350-spi): flash@0:spi-rx-bus-width: [4] is not one of [1, 4]
	from schema $id: http://devicetree.org/schemas/spi/andestech,ae350-spi.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/spi/andestech,ae350-spi.example.dtb: spi@f0b00000 (andestech,ae350-spi): flash@0:spi-tx-bus-width: [4] is not one of [1, 4]
	from schema $id: http://devicetree.org/schemas/spi/andestech,ae350-spi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251219-spi-add-multi-bus-support-v4-2-145dc5204cd8@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


