Return-Path: <linux-iio+bounces-13403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC27D9EF8EA
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 18:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DAFE28832A
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4522839C;
	Thu, 12 Dec 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nulGjpnD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98752226553;
	Thu, 12 Dec 2024 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025449; cv=none; b=NCI6Xmrtn6APUr77YuCsu8XP7IAj1iu8w4a28ByFtdfI0LWlraVtrFpOkSiEhmRQJ8bwzNqdipsmhh+Kf+7ag+O5GrCeMwTN7vLjfffv83aDgaT0RSLCo/SkixBlupN/1Haz6TE3WwrGm95fQ3Gm2qJ+dsk2e2TioWiWbqX2kPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025449; c=relaxed/simple;
	bh=cFMOz22sOiQyouMW+74HETQ+kS9MQ985jtqNxbPZeNM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=JfikDtmMSqiaPI2ijcItyu2e3PJ9rKebBzcpTS3ELtLVhNHJdjFeULvplUuzCgolDymUBfnkWh1z1mPDk+Uowd5Q2x3i4gHHzx1Zo9Yr2/05NU8P432RVQ+92XSf8h9UEQ3X8wmTV2OU9pKBzcSWkzdAoauCwpVKlGs7TxA/kYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nulGjpnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB30C4CED0;
	Thu, 12 Dec 2024 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734025449;
	bh=cFMOz22sOiQyouMW+74HETQ+kS9MQ985jtqNxbPZeNM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=nulGjpnDUff/djHrFoAol9oxQzm1LdBsrf6iD/cz4tYWMex8KaiJaaXiyrNrJwILM
	 fHkZBOri0g4XxumvHqw0BiH+6ww8sNWA0TsS3WGjukujlbzgXOpljU/GrDjxBugLK/
	 njdhGmI50lwXHKbssAX2B/988r+dlQyAGyCBPuDjRIVi4rOM1517lCwQm93CyBNw0B
	 nwOD4WYgMMqZsn9835qYvTn/2sMcfgC9NgQVP9x5o5iCVU88HJlM1NdbCv9wU7IR2F
	 CIauAx/Ug37XNGhujoCSVNmAzJHxXbTxX66OxABgiUxGIdKIGIwTCBanBB19C//I/F
	 Pvig786WmFfrg==
Date: Thu, 12 Dec 2024 11:44:07 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, Imran Shaik <quic_imrashai@quicinc.com>, 
 Amit Kucheria <amitk@kernel.org>, quic_kamalw@quicinc.com, 
 Thara Gopinath <thara.gopinath@gmail.com>, linux-arm-msm@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Ajit Pandey <quic_ajipan@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
 quic_jprakash@quicinc.com, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lukasz Luba <lukasz.luba@arm.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lee Jones <lee@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
In-Reply-To: <20241212-mbg-v2-support-v2-2-3249a4339b6e@quicinc.com>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-2-3249a4339b6e@quicinc.com>
Message-Id: <173402544564.2846212.8371517817699165963.robh@kernel.org>
Subject: Re: [PATCH RFC v2 2/5] dt-bindings: mfd: qcom,spmi-pmic: Add MBG
 thermal monitor ref


On Thu, 12 Dec 2024 21:41:21 +0530, Satya Priya Kakitapalli wrote:
> Add reference to the newly added MBG thermal monitor bindings.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241212-mbg-v2-support-v2-2-3249a4339b6e@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


