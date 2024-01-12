Return-Path: <linux-iio+bounces-1623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B9A82C66B
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 21:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4251F233ED
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jan 2024 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D54F168C1;
	Fri, 12 Jan 2024 20:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6q5j4nD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E715ACF;
	Fri, 12 Jan 2024 20:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EBC43390;
	Fri, 12 Jan 2024 20:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705092160;
	bh=tPZgZxHydhuYbfNQ7WW8vBIWYVhDQ4GMJXS3txxKGyw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=S6q5j4nDJ2oYTGHjupcGhJGsFlVcg0+XF8+xsTRW2kUY0ZdarPx7vEfvtJLnt8+te
	 hTHs4c0xYJ5GySAiBgetlrG3sNiXGTlQVo02PLesyDSlwYHTBHzx6GskhM2A8TQef9
	 RvVEqZ8cwhbEy0iDRfP9Bibpv9z5J58YUw794eztVnhSuP7dB/Vqft2G/hbVyrx3TA
	 6w3f2MesAF2MM6ZAvwpZ0I/+xC3O2QqrkvJCGTStwr5wflOwIXVGzkDVVV9zghrNSD
	 5kj+Ny+dctq1DAtF62CX7JQsyLIzsZw2oKBIVtf+C1ihL3a1tvuiSFK7JzhZT79zgX
	 MKJc7gBZRWHDg==
Date: Fri, 12 Jan 2024 14:42:39 -0600
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
Cc: linux-iio@vger.kernel.org, Olivier Moysan <olivier.moysan@foss.st.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Rowand <frowand.list@gmail.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
In-Reply-To: <20240112-iio-backend-v5-2-bdecad041ab4@analog.com>
References: <20240112-iio-backend-v5-0-bdecad041ab4@analog.com>
 <20240112-iio-backend-v5-2-bdecad041ab4@analog.com>
Message-Id: <170509215851.3477727.2303747175739152195.robh@kernel.org>
Subject: Re: [PATCH v5 2/8] dt-bindings: adc: axi-adc: update bindings for
 backend framework


On Fri, 12 Jan 2024 17:40:16 +0100, Nuno Sa wrote:
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
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240112-iio-backend-v5-2-bdecad041ab4@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


