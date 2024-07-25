Return-Path: <linux-iio+bounces-7884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B3893C2BD
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5591F2210E
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B258199E98;
	Thu, 25 Jul 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhahh3Ya"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4942A224D2;
	Thu, 25 Jul 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913456; cv=none; b=rb+e4E4xcFCFGAc3xlodLrU5msKokMERT7VJVf3ITHMLULvh0/k94q6l0oEJoX3DjiHm96nrzWdCVJ/LdoIOTpqvc7Hxgz3Oz6+CVmc7fsSP6OhRmDYKt7OvT0tOiV6D5aI1XHS3kELVbLHJjKLaMYU9XHkxAc0m3FGwbCdnVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913456; c=relaxed/simple;
	bh=kia5i5oOPSeeB+S1Khygr3d3dqyhKoYT13dTBTwO7yw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=uCBqf1K6Y76RDjgq1tYbplRyT09t+na6FdNZTTXbXUmYjdU02nhm5YhtoBaQDX7OWzX0kBvx2IcS3hWTPRjwXqXFGkceNvPmjKLp3SfAh/RKEdgobBPr9+QiBibhfvb8HxLK6AHuhN7UI/juP5Sk5qLWDGtpsbiIAhsdIvsD/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhahh3Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5E8C116B1;
	Thu, 25 Jul 2024 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721913455;
	bh=kia5i5oOPSeeB+S1Khygr3d3dqyhKoYT13dTBTwO7yw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Fhahh3YaLGYkNrvruq9P1OFCLPsRFyqnEFVg2qmtoh41GA2TB0fSVjlu78GF6kXl1
	 a7nEiIuGI8hhjOT7FopVJVQ2Rn2BmvhQabD/jOwvqf2SdMaO/k9ytNR057e1IO/2cu
	 M/AZPlSZRrl1i9mhG13btPgBGThwSRQqHcG2c/eiR2YhiSbRXKP2fuKgv+ip/w2Hrv
	 AyHMVWPHJ7vaG+9fs4rj9TSJNcgl1VgFd0pC5TWZ8LUhz+xjDo+tIpnsujZm26O8pH
	 mBALkHoVtNUioucpFW5xndoBT26LoMdlVjXViyL0ifpbr3DdruTMmeqD/G4R9lHF3i
	 YcV8t5BKIb70A==
Date: Thu, 25 Jul 2024 08:17:34 -0500
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
Cc: waqar.hameed@axis.com, liweilei@awinic.com, lars@metafoo.de, 
 linux-iio@vger.kernel.org, kangjiajun@awinic.com, jic23@kernel.org, 
 linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, krzk+dt@kernel.org
In-Reply-To: <20240725121252.865836-2-wangshuaijie@awinic.com>
References: <20240725121252.865836-1-wangshuaijie@awinic.com>
 <20240725121252.865836-2-wangshuaijie@awinic.com>
Message-Id: <172191345400.1572973.8660057237993091930.robh@kernel.org>
Subject: Re: [PATCH V4 1/2] dt-bindings: iio: aw9610x: Add bindings for
 aw9610x sensor


On Thu, 25 Jul 2024 12:12:51 +0000, wangshuaijie@awinic.com wrote:
> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> Add device tree bindings for aw9610x proximity sensor.
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  .../iio/proximity/awinic,aw9610x.yaml         | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/input/awinic,aw9610x.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/proximity/awinic,aw9610x.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240725121252.865836-2-wangshuaijie@awinic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


