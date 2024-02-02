Return-Path: <linux-iio+bounces-2102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8903B8474F0
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 17:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268D41F2B61F
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A63148FF0;
	Fri,  2 Feb 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2hHkl1Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A96148FEC;
	Fri,  2 Feb 2024 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891702; cv=none; b=t9HnQligZ5/5GYsnhzpLFxjHqQbtdPi7p0mYBO764EHrI6cMJGppaUQVmfzes7UdhcRYncPj/mBTfPMr7ecxbE4BbBXiPwAQSyupE4s40mqplz0ZGozypYp/kCFgeiYATbgXk0lDBs6pj9uUGM7FhptbyI/PMHzdSVlcL1vynO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891702; c=relaxed/simple;
	bh=4GJVsIqv5wIkN4FLeugZ/HuLT/8X2AhKe6NslRjR528=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ToZ0yMBfqai50JZlArJDBC5y1qBCzJriGmb2495ZxIjRaVD7mV+MHHYIAcoGH1d4AR9ruUlM+pVhDFbu9aeLuh4nBL6j1u9p9BtotSd0zKFYkoh5Mg7x7vb4HYQJP9t0HAxUqTS+SZXsEiIESzkqPaCGVO80TEqpPIn3pFxIriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2hHkl1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEB1C43394;
	Fri,  2 Feb 2024 16:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891701;
	bh=4GJVsIqv5wIkN4FLeugZ/HuLT/8X2AhKe6NslRjR528=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=K2hHkl1YbFpglxh3m3P6KXINd9RM5k0DlZgeQGpqxX0t11lwOiXCbc5v0uYyK45Ar
	 9aZnO1o10zBWatjpTn3dTOjdSwBK3FSbxqSQwSUH9FfHUdJxppZ+5JlwWkQ/mOK4G1
	 8TtEFiO8qb9uCEkbPo/OPe91XIT9RnmjAjr8KmI3Z3TldUqI/tSMWKZqeQFk+wJ7as
	 8515p/MnhGoD58/vKdhpc4m9aEOkV0hb6kbQHUUbiqZkbo7/mUYlkvT6pY9GhbH7oG
	 YggDvL66zXg3ghDDlk00nNxITr9ce4kAW4NUv03iBjyY4qRAhJxBsTU9aYrBKnrkFh
	 Xj7PoYcGcLEqA==
Date: Fri, 02 Feb 2024 10:35:00 -0600
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
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
In-Reply-To: <20240202-iio-backend-v8-2-f65ee8c8203d@analog.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
 <20240202-iio-backend-v8-2-f65ee8c8203d@analog.com>
Message-Id: <170689169936.226631.10918544906216773719.robh@kernel.org>
Subject: Re: [PATCH v8 2/7] dt-bindings: adc: axi-adc: update bindings for
 backend framework


On Fri, 02 Feb 2024 16:08:33 +0100, Nuno Sa wrote:
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
> Reviewed-by: Rob Herring <robh@kernel.org>
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
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240202-iio-backend-v8-2-f65ee8c8203d@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


