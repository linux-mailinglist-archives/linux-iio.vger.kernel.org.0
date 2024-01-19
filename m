Return-Path: <linux-iio+bounces-1770-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B94832DF8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 18:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC883B26EDF
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jan 2024 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E093C55E79;
	Fri, 19 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9NuIN6k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF6555E42;
	Fri, 19 Jan 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684558; cv=none; b=q8FzZ1I8kfaznZInaIY1qrLcR8gfa/ClcnPVnOMitv6m6MTuaTNFyEkSQ5HYRxAEdECKquaHNSbubE1Kc7dfg6uRmPU9nOh/mmiu5EhqkJGzSuUNVETL4J9p9cy1iJ1qF4YNsOgw62912TLiLDsLODznfIFnQUCx2CNy+hwgGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684558; c=relaxed/simple;
	bh=dJMDxhzTZociBfO2ljuPpmEuwWk9DtIeGRXkj0b469s=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=iV5p3s9ckt6gJ33817l38PBgjwMx+8s9dN7kytVfXQWE4LCerZLczXWI7hJucEsOxDHn9UmQ/QOwfYsm4FNZPT7rlHyG3aFb5rTal1q8D+BZWvWQu6Pb3ZeY7JNblPAIjdqhB1e1s0/Wm8VVVxzLa5HtGzXReCESPJBaG0LPUcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9NuIN6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D904FC43390;
	Fri, 19 Jan 2024 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705684558;
	bh=dJMDxhzTZociBfO2ljuPpmEuwWk9DtIeGRXkj0b469s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=r9NuIN6kKQQQ/QGjuYbs9tziSk1gwe/38VKvTdi1K36MQOGo+zsx2CRd+Yzolf1Sv
	 Nl51cRfq10zWxlgq+VaV/TpV8nJ+flq9St5dtW3JCx8Z90kbaczc17WtrVTg5wLNm/
	 aVfpEb+Q5Qxs8gVWme89rKSJesLo4uZWMBKdB4IKPet0uDDH3CW16kWhST+FLwFgHF
	 OsOjMaJ8RNdnfFFt/JU3nsqULf67ZbedBnY76naXokgPspa3aV/zhIjjIBbaIfxu3P
	 rkWifrsK09hR3PO+ZoHa2b6vDaJCXIOotpoeAGEF52wuE47EYJMEW/53YZQlGkVeV7
	 8MCN90v3hdLwA==
Date: Fri, 19 Jan 2024 11:15:56 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20240119-iio-backend-v6-2-189536c35a05@analog.com>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
 <20240119-iio-backend-v6-2-189536c35a05@analog.com>
Message-Id: <170568455347.599801.4301742729712962299.robh@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: adc: axi-adc: update bindings for
 backend framework


On Fri, 19 Jan 2024 17:00:48 +0100, Nuno Sa wrote:
> 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> also remove it from being required.
> 
> The reason why it's being deprecated is because the axi-adc CORE is now
> an IIO service provider hardware (IIO backends) for consumers to make use
> of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> of consumer referencing other nodes/devices) and that proved to be wrong
> and to not scale.
> 
> Now, IIO consumers of this hardware are expected to reference it using the
> io-backends property. Hence, the new '#io-backend-cells' is being added
> so the device is easily identified as a provider.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dts'
Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240119-iio-backend-v6-2-189536c35a05@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


