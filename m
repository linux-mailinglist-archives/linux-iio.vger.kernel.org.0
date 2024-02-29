Return-Path: <linux-iio+bounces-3239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E7086D08A
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 18:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F36C1C22028
	for <lists+linux-iio@lfdr.de>; Thu, 29 Feb 2024 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2056E70AD4;
	Thu, 29 Feb 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIem7WRT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545670AC7;
	Thu, 29 Feb 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227588; cv=none; b=EqtYBV5iocwe1T5FxBIkYEv+ozk7HyJb9Qi9zXC/ucL7+cinpvVKF/iRxb/58fpL3U3DhHQQi59mMWU7AGTpZNOoxw9wtafe7T13uQ1I4rUXIQJUwr8jo7QiJJkSZKeI3uMov6zYtwxUjm5JKtDIJ6g+FTsTeIqY7M9fdUGkqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227588; c=relaxed/simple;
	bh=8JDg67miyT0xxLvt03PdzmniTBXZ3ZQYPMH1H6j5l70=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FJ5BTI6+t1GxlUqaVK3fT4JbOZETBoFExH9YV8R4AznskRgBWz7SeLNwYXxgVjQhqzcyveEosnkG/4GYeY+gKzujvk67nCw5zE7WXMlnuf7rDIP50nmclskdtHwSGhpbBPLuOMwz7WB30AkdpMERno5scLzM2obSsE7zp44Z/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIem7WRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B598C433C7;
	Thu, 29 Feb 2024 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227588;
	bh=8JDg67miyT0xxLvt03PdzmniTBXZ3ZQYPMH1H6j5l70=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RIem7WRTQNXEIjALZ4+XTZ3M8kByh9hsrsUNirNX2gMjqwEMwcDPwS+AA/iDfaNLc
	 39lBPUL+Ayy1w73hKMYf9W8/Ubqq65lYi1RMaXD2d3MDplCEWLunpcYcn3VTdfdReu
	 hV1gdOaZ3UMhgt4QR/m8DIa+q6DFuVBrmU/j8jG3jw90PxqE5ue01EXSQocL6Yvwny
	 JQ95VEfRRe5UIUmlPmECEVG+oke3apnO6pVd6+NnDBTQjYZIvc4ZYO8FOERdLCiTUj
	 zuKh7IamYwJDNh/KCUW9SFPXnTcbMJgJtFTyaUaOoOCY7fR1dIjhLIY20+E8tXLhaB
	 lxAg9HKWUOitw==
Date: Thu, 29 Feb 2024 11:26:27 -0600
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
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20240229-ltc2983-misc-improv-v2-2-cc6f03da2529@analog.com>
References: <20240229-ltc2983-misc-improv-v2-0-cc6f03da2529@analog.com>
 <20240229-ltc2983-misc-improv-v2-2-cc6f03da2529@analog.com>
Message-Id: <170922758600.4099132.651212743562426191.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: temperature: ltc2983:
 document power supply


On Thu, 29 Feb 2024 17:11:42 +0100, Nuno Sa wrote:
> Add a property for the VDD power supply regulator.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.dtb: temperature-sensor@0: 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240229-ltc2983-misc-improv-v2-2-cc6f03da2529@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


