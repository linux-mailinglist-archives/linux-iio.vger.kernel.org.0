Return-Path: <linux-iio+bounces-7536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14492FA58
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624021F22945
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510B16F0E4;
	Fri, 12 Jul 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRL6HKO2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC916EC12;
	Fri, 12 Jul 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720787659; cv=none; b=BIX/XDWbUUnc74Xo2uRqf+5Rm2e+2cpTT1RwI4IdtHHoF7hc8ngVa2Z57ZHSStIfLpfzzj+pDagGy9XRTWZd6FXertk37WSqrunYanKAaVe+4z9lAVce0usd73Z1TqFTya5apV3UHrhfvtpB1MHfOfOsgzfHxHOdvK4Gd4wvvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720787659; c=relaxed/simple;
	bh=VFjSUnynA+L091M2ImQynzfo1m8e4R0zxTspPGE8na8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=OH76DnTkr9b1gz9zxdnxC604KWnDj4LeZmx2vlG5XRx/DgJAp+HmT503tM2hRCQ6GOk3tn3oqDy+Bu7tzvTe/xsyKvuCPzXDDY6rPGH/O6wzxgj5BQZUkfwUBxoYS09aOrG8mx+eluIXiy3oo0O0eBJfM52wR326iSEJgwDeVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRL6HKO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312B4C32782;
	Fri, 12 Jul 2024 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720787659;
	bh=VFjSUnynA+L091M2ImQynzfo1m8e4R0zxTspPGE8na8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WRL6HKO2e414MUB0vGx/J9lb/RQQIcz8e+4D7m0EHcZLOSulQaSYeun82L0qMPHRf
	 iMG6K2Sy+wZobfixoo8cmA0PW26svo3eB4UcA4aqK/4glec5V3yJ4ghR1kWPRV0+ii
	 YORNdp8Nk2gjkHHBO829ttBi1sHEfd0oZfloN7Wt0fQrXytRycgSQC4qEwLe2HRoSC
	 8ddC629QPalOKUOmQBbk5v+CFLGJTo3t2yWRKN2F2P8+54EJEjBP9uI2uxopRM+HMw
	 X81RkQmZYqlu4BhP8c5rCPF1mk8pgZewa4QVJBrVBQ+Unz4Ne3QaRS2pt4Rm70PQu9
	 oTpQIrtgvFpwg==
Date: Fri, 12 Jul 2024 06:34:18 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: wangshuaijie@awinic.com
Cc: conor+dt@kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
 linux-iio@vger.kernel.org, liweilei@awinic.com, waqar.hameed@axis.com, 
 kangjiajun@awinic.com, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
 jic23@kernel.org
In-Reply-To: <20240712113200.2468249-2-wangshuaijie@awinic.com>
References: <20240712113200.2468249-1-wangshuaijie@awinic.com>
 <20240712113200.2468249-2-wangshuaijie@awinic.com>
Message-Id: <172078765827.447376.17487276734407379568.robh@kernel.org>
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: Add YAML to Awinic proximity
 sensor


On Fri, 12 Jul 2024 11:31:59 +0000, wangshuaijie@awinic.com wrote:
> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> Add the awinic,aw96xxx.yaml file to adapt to the awinic proximity sensor driver.
> Addressing the issues raised in the previous version.
> 1. Add a description about the hardware device.
> 2. Remove inappropriate configuration items.
> 3. Modify the formatting issues.
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  .../iio/proximity/awinic,aw96xxx.yaml         | 127 ++++++++++++++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml:50:49: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.example.dts'
Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml:50:49: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml:50:49: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240712113200.2468249-2-wangshuaijie@awinic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


