Return-Path: <linux-iio+bounces-7545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1056892FCA5
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9666CB21C4E
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D58171E69;
	Fri, 12 Jul 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyCXAOeI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB0171E49;
	Fri, 12 Jul 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794874; cv=none; b=hE3T95bi2EQtHRCgyrV84QdZpXR/croQAjJk+vVUWbDzZsTU4glfa4clitLQzU/u8SZuc/QMJZopcEuHWUjycLxN+mi6fo1/mQ254i+dVPZ0AcHoFFrj7LfkAXDfCi6qjPy9oOm8Bx7KuOvm9ma2EjRKioOTxKy0UPGtCuOq9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794874; c=relaxed/simple;
	bh=Rsc8YZHaNuK+LM4JyoZlYijO2KWuj32xA3bxhSdG1Q8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VVKaYQxwnzYGPvNoUZ4YEOWyrW1ILlc4z9tFylWfRAe7wGcb8lTQQ4Fuuhq55/f34NNdnNFf9MNc1z9NPRgz2SN15vQMoKUF6vS8rvCUHGC8wk2ZbPAVQcwtO7g+VHx+ee6vWBJ1U5/SB98oCQSjFUdpOilsaUoN3+HKRpdCFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyCXAOeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77F9C32782;
	Fri, 12 Jul 2024 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720794874;
	bh=Rsc8YZHaNuK+LM4JyoZlYijO2KWuj32xA3bxhSdG1Q8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=kyCXAOeIT4s3VrsTFKGOZ6HJTOOZmELIG6yFsUjVNxpvuXN0kQt870rH0byDWLWeq
	 Gxk8EYPjJ6UlJgt/7vLUs+2xkZlGm7hh4RVgo0WZUa6bG2d0QfagtsKGr0IhtNqdPw
	 lwlm5zA8f3lzRoT0h4NAQvNUmlxrLLNoTlxzogQgM7n77GXGPgb97aQES7O/rgKemF
	 gbgaf3xCVunUWjqQY0YQTiDp9LgaKi2oOAntihc/t4XHaZTT2SnMCOaGrVoc3W5qXL
	 MqNmOVpVWAsjLOEyyZYdqQqlMl04P8rWZOBIxF/nswGb3+tPDxYrv09sH3ig6tMAKa
	 b5NurYSXXnMug==
Date: Fri, 12 Jul 2024 08:34:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Jishnu Prakash <quic_jprakash@quicinc.com>, 
 Amit Kucheria <amitk@kernel.org>, linux-iio@vger.kernel.org, 
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
 Taniya Das <quic_tdas@quicinc.com>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, devicetree@vger.kernel.org, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Imran Shaik <quic_imrashai@quicinc.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-msm@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com>
References: <20240712-mbg-tm-support-v1-0-7d78bec920ca@quicinc.com>
 <20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com>
Message-Id: <172079487284.777333.16103955331263207845.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: thermal: qcom: Add MBG thermal
 monitor bindings


On Fri, 12 Jul 2024 18:13:29 +0530, Satya Priya Kakitapalli wrote:
> Add bindings support for the MBG Temp alarm peripheral found on
> pm8775 pmics.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  .../bindings/thermal/qcom-spmi-mbg-tm.yaml         | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
In file included from Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.example.dts:25:
./scripts/dtc/include-prefixes/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8775.h:9:10: fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory
    9 | #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/thermal/qcom-spmi-mbg-tm.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240712-mbg-tm-support-v1-2-7d78bec920ca@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


