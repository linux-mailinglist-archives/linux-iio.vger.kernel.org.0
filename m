Return-Path: <linux-iio+bounces-1887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A923C8394D9
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 17:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D598288F44
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jan 2024 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495EE7F7F0;
	Tue, 23 Jan 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw2TdTH0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D897F7E9;
	Tue, 23 Jan 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027808; cv=none; b=toT6lXGTSlEtuCa/UDQ09dR9TOAGd8ACi1meuwRotbmmOqwkcjJsdIet0f6DD5xkzPslqL0/K5AEDoTr/O3o5nOP2giGr8VVnUlIn965j86tIuC7rN+HlCcw2M74pmFVo9soY5JGYHjA6+iOC7d8XKXwiGS8Bz+PA/SidpwcWU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027808; c=relaxed/simple;
	bh=uRS+6enMgBQXGAoRZRenW7XaHudEBWFNK50MuPjRaZE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XH+PvfHtYPO/86gDLLXKxeP6pwi0zj5a1CQU/vy+g0izp8WfaOSHmXyk9N5L8HTkTaPbkV4fMQNGcjn65stVLcIWMRXYKdx9oyeuX0fAj6H1MxguxFZCaxSFxelEFUQwAXdkNY31OOdKisPVog0kQD3eYsd59j7fhcJyJ5cisqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw2TdTH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A545DC43394;
	Tue, 23 Jan 2024 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027807;
	bh=uRS+6enMgBQXGAoRZRenW7XaHudEBWFNK50MuPjRaZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fw2TdTH0mAW2onc6LCht6M1HQn6O29YoHhA7m8ABC0W7+qQMdx0iyy1MKmNWuMA2D
	 vIavuNHiGiB9/UV8UrfLcjsLOYDWKqKL08kg70sWeqJOFBY79YTDz8UAF1YtGSJTLD
	 yUJKo7rRhG6kQbpVQzFFiPklQiMwt2ugW12+ehxIpFcWFqEaNWuqbZ7F/djejjMEX0
	 ybwFNvGh5iu0MVFLIWvZoTM/+O7AwGp3IdYvHXTSQSsoruns5s7ElNWSac3DNl++vv
	 AcZbWXZqBh4aW2tVNTNLmV0d/6QurSOxIaXBRxcfw+a9cJzB5o3E2fcdc6gy4nbQBu
	 NEAaQ4eXl309w==
Date: Tue, 23 Jan 2024 10:36:46 -0600
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
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-iio@vger.kernel.org, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
In-Reply-To: <20240123-iio-backend-v7-3-1bff236b8693@analog.com>
References: <20240123-iio-backend-v7-0-1bff236b8693@analog.com>
 <20240123-iio-backend-v7-3-1bff236b8693@analog.com>
Message-Id: <170602780540.972855.11472809528019876011.robh@kernel.org>
Subject: Re: [PATCH v7 3/9] dt-bindings: adc: axi-adc: update bindings for
 backend framework


On Tue, 23 Jan 2024 16:14:24 +0100, Nuno Sa wrote:
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
./Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml: ignoring, error parsing file
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dts'
Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240123-iio-backend-v7-3-1bff236b8693@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


