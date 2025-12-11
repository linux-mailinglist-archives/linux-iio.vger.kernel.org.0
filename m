Return-Path: <linux-iio+bounces-27022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17421CB6674
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8229230184D1
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7F31354C;
	Thu, 11 Dec 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDBGKf2W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B3189906;
	Thu, 11 Dec 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765468670; cv=none; b=okU6paI1GO1OF7Sj/bbKC6C7p9g1MIqdOp5nYmRuneLgFO0po6PtL558tVzi3Lko/irwobdBYDUcqDdIjsRZBE0qZ+c+D3i8otsRwZgxwSB0/nL7n2jr5Mb6FlodZN+1OcWOz1Uc9goL9QqWXzjtTLEeEGgEwdS8XYXtMVX0zmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765468670; c=relaxed/simple;
	bh=pFsCSVV25XloLK9Jvu2/qNTgDEC1TPVYRi3qn4jGraI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=WpegU+5K26qEJhYrFk9ngHxNF9bjiZJhjEN3JJZtJULUlFNhgVhFOObiMitzBl0zlP8MENm/kZIbRbO12SIzVrqYU62n7n7bwW1WtqiYCt+gn1NBQzGtQ8u01obVttlcmZYCeOsK0FWSr6ht1xtfdHzaJTfMsq9NeVhKTKWbLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDBGKf2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB4CC4CEF7;
	Thu, 11 Dec 2025 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765468669;
	bh=pFsCSVV25XloLK9Jvu2/qNTgDEC1TPVYRi3qn4jGraI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=tDBGKf2Wb8Cl6lzG5cx4vBkzWJr4i/qgbwkSv5JcKhhDLKt4RMd8zBcl8z00VKYK7
	 yfmdbPecn1pr7ynoRhjMU+wNVgUlQx+MK9oEoymM+KMpk80lJadHVtxBjD8+VyPGhy
	 lpgOJx28AznF++QhBe31bMUER/pB9aITcDTVhqkJESwIs1waTYRPjBnghQhdqUbafb
	 XZBeilKLe+y5nt3/Ii8lhjLHe7i8Dk0ldvFavx/oNoq4N6kLcYogdKi3dH8NNqjlAk
	 FiGUG728GtdRqfsleYVeKxM60PgNHtr852oAkaKTYOPmN8O9Zn3rjEfHfNVB7H1Pen
	 t6gnGiv7kyXug==
Date: Thu, 11 Dec 2025 09:57:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
 Linus Walleij <linusw@kernel.org>, devicetree@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 openbmc@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
Message-Id: <176546866607.1487115.6798113196659439308.robh@kernel.org>
Subject: Re: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to
 sdhci-common.yaml


On Thu, 11 Dec 2025 17:45:48 +0900, Andrew Jeffery wrote:
> Enable use of common SDHCI-related properties such as sdhci-caps-mask as
> found in the AST2600 EVB DTS.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.example.dtb: fan-controller@1e786000 (aspeed,ast2500-pwm-tacho): #cooling-cells: 2 was expected
	from schema $id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


