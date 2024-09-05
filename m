Return-Path: <linux-iio+bounces-9192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2776B96D6CB
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D6C281D62
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 11:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B5199238;
	Thu,  5 Sep 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx4FtIHZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F76194A61;
	Thu,  5 Sep 2024 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534719; cv=none; b=fPWbaPcrd8J/FycsaJpDyg+CjL4JWv07zz+B6adrMcIlaCzsevYHKHzeLLokXzR61DJs0+Lsr29WDd90UhdQ0irKL+n4K6JWJ/wKuL9JIifZdTnljvRgKabGP2FDhGqb5cVHzosC7YWDfNj+UdPOsgkz6YASf7kDTvgWm71F2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534719; c=relaxed/simple;
	bh=IcY+P+y/j/IEo8kvhtDOZN3wwwCRu9Vys1CDWZHyjpU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XX0O35ALYCQOKMgpUqR+vesw06OgKzlfXGRlmuR+iwcznq2PaqiR4RB3D9dKhm8FFs4zp8Pz64f89raC47jzyku9OY4d8WZ1MF/FndZxMjEPyQfreTIMiYD3yvopD2bMryiqUz4W4W4DDTIwEtjY7q5VZXz6BGU/3xmX+zhCS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx4FtIHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E5C4CEC3;
	Thu,  5 Sep 2024 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725534718;
	bh=IcY+P+y/j/IEo8kvhtDOZN3wwwCRu9Vys1CDWZHyjpU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rx4FtIHZicQKBHi8Hm/kS6CHF8bbUNcL9MvT70avHxczrIMJb0myRsT7J4EddEaBo
	 lwfrG6LPK2FxvqPIX9KDgYdikmr4V4g4JPJt7/ie/x2v6mm+ztf1y5zZ9frJ3WaNM2
	 EbJQ8jzV/8GP3yDhoGH0feTTiq8UveX7eK/nKMFwfMTGRrbTfjXA20hBAAXOmsPgrs
	 qVd9JdLw1Sb4n8wZqF0p3dc8QbXJZMeSeA2dAL4WCUiSTjSF1Zzsonjiu/SgBT6UU8
	 1keQgUyczgZKu4kTo+Y2mwVLsEkQ+eDAnQtTxfqPO3vweSvjkc/u0KwG+T1qJx5OtU
	 3ICz93ge8d+4Q==
Date: Thu, 05 Sep 2024 06:11:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Emil Gedenryd <emil.gedenryd@axis.com>
Cc: linux-iio@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@axis.com, 
 Andreas Dannenberg <dannenberg@ti.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20240905-add_opt3002-v1-3-a5ae21b924fb@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
 <20240905-add_opt3002-v1-3-a5ae21b924fb@axis.com>
Message-Id: <172553471735.1030504.6260506598710907447.robh@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: iio: light: opt3001: add compatible
 for opt3002


On Thu, 05 Sep 2024 12:20:47 +0200, Emil Gedenryd wrote:
> OPT3002 is a Light-to-Digital Sensor by TI with support for wide-range
> spectrum light.
> Add the compatible string of opt3002 to the existing list.
> 
> Signed-off-by: Emil Gedenryd <emil.gedenryd@axis.com>
> ---
>  Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml:19:5: [error] duplication of key "const" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml:19:5: found duplicate key "const" with value "ti,opt3002" (original value: "ti,opt3001")
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/light/ti,opt3001.example.dts'
Documentation/devicetree/bindings/iio/light/ti,opt3001.yaml:19:5: found duplicate key "const" with value "ti,opt3002" (original value: "ti,opt3001")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/light/ti,opt3001.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240905-add_opt3002-v1-3-a5ae21b924fb@axis.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


