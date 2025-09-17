Return-Path: <linux-iio+bounces-24234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56DB822DA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 00:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F4482190
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4E310652;
	Wed, 17 Sep 2025 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t13Cxn2e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E02C0F84;
	Wed, 17 Sep 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148922; cv=none; b=G3am9ArYtjbfdlaZThjoREJ+LZHdNHcGOs4ZRj7h/a5xtkh/dFj1FC6QyaX2NGKQdD4jaWcEvtiLj/V9KSiParbb0iS9iOvfSWu0SAIZMbGvZ/2Od6SWvGHi3THcFKNf4VtOzvnDy/i/eqSNbUTIEnsINK3rghPUCrunxp6HH+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148922; c=relaxed/simple;
	bh=m7NPlDhPmAcPAf4wPj+fVtjHQZr8RMeY8ahVFsVwYeE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jop+S9d01fOmKsy0etm8QFvQLhZc6f1SItuveIsazQ8ztcLFqfJeuATmlk3M8jkFJpiyJ23KNFUQ5PeCYeW46lCEBcnr505EG67B2+vP3CpIYnWFwqwb/pt8ggQgfwBRvGoft5k2l8+E18pEtXbTIGLmscTKaRPQlA4RCyhmur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t13Cxn2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD20C4CEF9;
	Wed, 17 Sep 2025 22:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148920;
	bh=m7NPlDhPmAcPAf4wPj+fVtjHQZr8RMeY8ahVFsVwYeE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=t13Cxn2eKh95GIakDQTlj2IMpzHlAoH2zEMOgBiBq8/HzB3778rdLmsLI3/eA03zH
	 ITMoUimwmU2KC/3VP7uU70Zgk2IWdAxkqHb/MWozBY7PJwplAHTvdkXgAsg0RCcdeo
	 b2sEBfJhOZ/k5zKJz1XkOx5MuAuqHbeQi3JihIN7mSCYRjgQCnZ/0LaTdE33cwhyO/
	 SMztgF4ePRMj8ifIxK2LovupR+XEFfTitbO/b19+HaCIMd+HQlJNeQjd+tK9efSiix
	 UhOnUXmE+8KBCWJAq7RjK7QR0gCHKmKzVw2VDjk3sd3NOACp995wAQoVVeDAnBSisz
	 4vXLAtuicGSnA==
Date: Wed, 17 Sep 2025 17:41:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-iio@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, devicetree@vger.kernel.org, 
 Andy Shevchenko <andy@kernel.org>, 
 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
To: Yixun Lan <dlan@gentoo.org>
In-Reply-To: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
References: <20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org>
Message-Id: <175814891315.3653519.7976478405350498859.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: light: APDS9160: fix missing type
 definition warning


On Thu, 18 Sep 2025 05:02:01 +0800, Yixun Lan wrote:
> DT validation will report missing type definition warning for the property of
> 'ps-cancellation-current-picoamp', explicitly add type definition to fix it.
> 
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> I got following DT warning, when running dtbs_check
> 
> $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- dtbs_check W=1
> generic check all files
>   UPD     include/config/kernel.release
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/work/linux-6.y/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml: ps-cancellation-current-picoamp: missing type definition
> ---
>  Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/brcm,apds9160.example.dtb: light-sensor@53 (brcm,apds9160): ps-cancellation-current-picoamp: 62400 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/property-units.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250918-60-dt-iio-apds9160-v1-1-0bd6bcbc547d@gentoo.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


