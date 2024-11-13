Return-Path: <linux-iio+bounces-12220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAFD9C7AEC
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 19:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB22C1F2210D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D04205127;
	Wed, 13 Nov 2024 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAl3ZGaJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B607202638;
	Wed, 13 Nov 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521919; cv=none; b=d0AxUZ4Z2UvHdADmvueWqs5CkRk4Mj79zmIAJTIUXEo9FxPjYfLkJm08oIT9CLel0sidnpf0K3fryOzl67kS3TlifptpaUuyCiB+NjmVr+T5Pp+VIRmA7F2aU2jbCTGWA+VlwF/z0WyrfuvJrXsK5zooyhrIAvcYacBq0bp3U7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521919; c=relaxed/simple;
	bh=7QTOKJm9h6+ZK6Y42Sv3dovWm26ZhEmaOQoVIFaR2Wc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dEjlqk3lHylcT968hBKKp81Feyvu/CEPvN6JTSjaFrE9mXlzsGkB217pFSuFwQpSDGHlBEpTmXIvdUHGq+H4X1JDiWxnVO6IHvHFOQOY1M5jLdShjcIMy0esJl1G8FIrQk7GADFR/zSK7vxFCxhlfZXs5pTHB5mKxuDmwXZMEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAl3ZGaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA7EC4CEC3;
	Wed, 13 Nov 2024 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731521918;
	bh=7QTOKJm9h6+ZK6Y42Sv3dovWm26ZhEmaOQoVIFaR2Wc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=HAl3ZGaJwWIkQm2tGzkof42Q24cVTmw/CfbrS71a09fNT7cAgTQqWF0oN5le4Cwfn
	 nOJEsQaR1rnKMC5gqYEo9LAX0rE4yHVfdJACAkzoh3VPPqxs2Ds5kmeAPE+KTFu0+Q
	 T6c8obrHhGEDtG5qNmKgbFa1HChz6EsgYHjnDBtAX2dUIj36X3nUCK72FQ0Tif7F81
	 WsnyNVYrJ2zz8085ccW4Ps7CDdXW9Z2Lmyv8axqaQn3uE4wWNvW4qnmCvQLi7N1IM/
	 6EdMf0SsgSj2opm27IjmxBqG9L0pxPTBt6k0bXa6J5kHX6pZBzbRUGB9292XfBRkXe
	 RJkl45gosHS2A==
Date: Wed, 13 Nov 2024 12:18:36 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michael Hennerich <michael.hennerich@analog.com>
To: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-2-aba1f0f9b628@baylibre.com>
References: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
 <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-2-aba1f0f9b628@baylibre.com>
Message-Id: <173152191678.1024361.7493718883312810903.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: adi,ad4695: change include
 path


On Wed, 13 Nov 2024 10:55:20 -0600, David Lechner wrote:
> Change the include path for the adi,ad4695.h header since it has been
> moved to the include/dt-bindings/iio/adc/ directory.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/adc/adi,ad4695.example.dts:19:18: fatal error: dt-bindings/iio/adc/adi,ad4695.h: No such file or directory
   19 |         #include <dt-bindings/iio/adc/adi,ad4695.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/iio/adc/adi,ad4695.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241113-iio-adc-ad4695-move-dt-bindings-header-v1-2-aba1f0f9b628@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


