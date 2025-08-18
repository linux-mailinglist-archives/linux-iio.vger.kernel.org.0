Return-Path: <linux-iio+bounces-22897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A7B299C9
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFCC3BEC7F
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CD62750F3;
	Mon, 18 Aug 2025 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGvBJyay"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240024635E;
	Mon, 18 Aug 2025 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498784; cv=none; b=fWOSa44NimtUyRJkgXK1ocPMDXtW/18wNFkzlZPMC9tu8UCNwR51p8HkzgIHJel0gs998nGCondWi45gHQgxec9C5Ei7+i6GDV0XDsOwfM8sXM3BpWeIzKCATbUHaYhK8E4ritBAFTye4I98YfRJwFfSdkFfpCwVfRqwSf4hijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498784; c=relaxed/simple;
	bh=oVqPB105dPgeJNsyt7OogjJUI5zWm9tJwOKP48ly5z0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=rtsJbP0jCDGyie+n/GmeOPNugkpIsGNpXnbclxE2kEFDHBiHH4PLCNuIBycbDRjbK4AEbAyEisN7r3zSrthOndjDO1fhStN55pn8JD+s1gIM705RkwsHFTRbROMxHwZY3JaKNwpOZoJv9z/ZatI2rgZkb7+ECBEvI//bdIOjwwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGvBJyay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C767EC4CEEB;
	Mon, 18 Aug 2025 06:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755498784;
	bh=oVqPB105dPgeJNsyt7OogjJUI5zWm9tJwOKP48ly5z0=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TGvBJyay/SLO5sF1wvYqbmSPJFxQU1yWuMRjj/uV7m2USicmYoQ/i3DXIUnnEOqOp
	 57PgpDMQKa2OcSlVwReVkg/9qWFGOqmgwdaWCL5IAQuzeJzEi6d4yqAh6vmnO3op1E
	 8f2LadiX8Nve1vjGj99EepjfuZ9o3WAXmk0n7XQc9W1/f3JaTt7Yrml03eOns4RVND
	 jJ/fbH8D/8blCXj614n7X6gDUmQPVhyPfmzd8z3bk7R4IsNm49chp/gZECVmOdHaI0
	 vHbirMALRa732CYkzn4chwPRvIT/SsdAUtzt2mD7IjxpwH55BXKf0bYl/8OKkSH5wi
	 7e7izWMS/ZcSQ==
Date: Mon, 18 Aug 2025 01:33:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andrew Hepp <andrew.hepp@ahepp.dev>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ben Collins <bcollins@watter.com>, 
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
To: Ben Collins <bcollins@kernel.org>
In-Reply-To: <20250818035953.35216-2-bcollins@kernel.org>
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-2-bcollins@kernel.org>
Message-Id: <175549878302.4073296.5081888197780869494.robh@kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: iio: mcp9600: Add
 microchip,mcp9601 and add constraints


On Sun, 17 Aug 2025 23:59:49 -0400, Ben Collins wrote:
> From: Ben Collins <bcollins@watter.com>
> 
> The mcp9600 driver supports the mcp9601 chip, but complains about not
> recognizing the device id on probe. A separate patch...
> 
> 	iio: mcp9600: Recognize chip id for mcp9601
> 
> ...addresses this. This patch updates the dt-bindings for this chip to
> reflect the change to allow explicitly setting microchip,mcp9601 as
> the expected chip type.
> 
> The mcp9601 also supports features not found on the mcp9600, so this
> will also allow the driver to differentiate the support of these
> features.
> 
> In addition, the thermocouple-type needs a default of 3 (k-type). The
> driver doesn't support this, yet. A later patch in this series adds it:
> 
> 	iio: mcp9600: Add support for thermocouple-type
> 
> Lastly, the open/short circuit functionality is dependent on mcp9601
> chipsset. Add constraints for this and a new property, microchip,vsense,
> enables this feature since it depends on the chip being wired
> properly.
> 
> Passed dt_binding_check.
> 
> Signed-off-by: Ben Collins <bcollins@watter.com>
> ---
>  .../iio/temperature/microchip,mcp9600.yaml    | 69 +++++++++++++++----
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.example.dts:34.34-35 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1527: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250818035953.35216-2-bcollins@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


