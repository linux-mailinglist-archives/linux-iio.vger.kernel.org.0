Return-Path: <linux-iio+bounces-13402-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B669EF8E4
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7712E286FAC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674C8226527;
	Thu, 12 Dec 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHyxdi6b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B4E2248B8;
	Thu, 12 Dec 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025448; cv=none; b=fX8qwABan2IuBgELro/vXSiuLjjZeuFYiAD1QBcu2Gf31vqbqNVvDoY+CHxWNRHwtUG18AAip+64J2LZtUv8DJPuSF158dGeE4Hp9seC595yegAUAM3LfXempXVwhtV+SiEArBjYC83Mu+8D4h47jVYvFisy2jPEou3NgrfIrYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025448; c=relaxed/simple;
	bh=GfRny6D9GpPOkUdXEAQGokd9UWvc6AqKtCtATuIW1sc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GkV6rye7KrJ48tNM1v2qbbWaf1U921LCsBY3OfWzskFOWjrhjdN+H6i9xm29NQCOxMh3io3jzwRu0iOuBe9P5JL1p804ZElp3Yir4eKCUtNSlr3lRkoFGZpzDB3CZxiA2f9besF/8rQPFcnDt22DgI2pNelo+Cl+mJjT3Rtzoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHyxdi6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56219C4CEE2;
	Thu, 12 Dec 2024 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734025447;
	bh=GfRny6D9GpPOkUdXEAQGokd9UWvc6AqKtCtATuIW1sc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=qHyxdi6bisnbuCe/sHYX6c3eIU4PlrsWs4hWZyko93ACT4fGkD1bHzn74W65X3JSl
	 vKMGWTN0asMipmbW/Cl/ne9slrFDY3N4Z0hHXncbA0qb+eDaSi2MOK0ZkG9gdtTozy
	 QJHi7hh7mnSdmpQN40pCotMaQAFx3MxMomg9nFZl4T/fUlHE3oLNkEKZsUcgDhnd/C
	 5iR52z/KSvYKJFes95miWEpwmKk4jz9IITB1KilfR5wUSwf3/E17xGrQQ11oZPH7KD
	 FJn9M3D25zHDJYgspkIM4h4ppjt5Iqmd3PE3tQbjLEtbomjLJ9O4eEqWiZJVU04tsB
	 xuS2TVR/J5+ew==
Date: Thu, 12 Dec 2024 11:44:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, linux-iio@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, 
 quic_jprakash@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Ajit Pandey <quic_ajipan@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
 quic_kamalw@quicinc.com, Taniya Das <quic_tdas@quicinc.com>, 
 Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, 
 Lee Jones <lee@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
Message-Id: <173402544428.2846153.6433110325068634297.robh@kernel.org>
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal
 monitor support


On Thu, 12 Dec 2024 21:41:20 +0530, Satya Priya Kakitapalli wrote:
> Add PM8775 ADC5 GEN3 Channel info and bindings for the MBG Temp
> alarm peripheral found on PM8775 pmic.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 86 ++++++++++++++++++++++
>  .../iio/adc/qcom,spmi-adc5-gen3-pm8775.h           | 41 +++++++++++
>  2 files changed, 127 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
In file included from Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.example.dts:25:
./scripts/dtc/include-prefixes/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h:9:10: fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
    9 | #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


