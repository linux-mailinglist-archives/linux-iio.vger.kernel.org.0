Return-Path: <linux-iio+bounces-13412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584A59F0690
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 09:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA33D1888D3D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2024 08:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECA1AB52F;
	Fri, 13 Dec 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJzxf3hN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643019992D;
	Fri, 13 Dec 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079245; cv=none; b=bUnAHZMRqrQq55TSDSWUojcIsZRjuG1qumGp4ycPJkms7YhwQGsWrFC8i8xL2GAhrB6gfA9pyocB0eo0aJqaC3uFJJYcoYo3zhJkOvZ1J3+On4ddNz400EIxifQ/76hIBDO0ZUFTed+C3WUr939b3sfJdJVj+4+ShziTiS8ecBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079245; c=relaxed/simple;
	bh=BSxOztl6ioFFWVKIwGhNgOe3RZfrGoXPDt2Zg6L5wZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxIafJ53K68dXDTEMqfapIcmz+G3gNitzKnrYKgMX5UQOfEuD8W5vprrWavAQZZtZkU5KsM4wp2pukgdazBhcCu62meOIAIKd15vIH8ic8Z/jxwFE8/Q1vfuSxImUb2Un9h0PZWidTl9aX/aY0SJIdSNLG5Pm6ONgYkuc97zIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJzxf3hN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF8FC4CED0;
	Fri, 13 Dec 2024 08:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734079245;
	bh=BSxOztl6ioFFWVKIwGhNgOe3RZfrGoXPDt2Zg6L5wZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJzxf3hNAXIVG0N/2YZF7zl1rNZ5BShDF2MBV3UvBDBta4ZP5qJ8aO+suGgE4nD69
	 lcf894XyeSmPkWQbtpxx5C3edWWElQDLBNP/GVK1hsZbRqdxH4vJHMolTIrVrVol3V
	 rp+NoyToxyaUHXN96ud6LRUj1moDm1soTS46MGHxBdrL1FVn8+CBqQunApvxX2UmMn
	 tqcRJ+/OdeHFkVSHKofqtq4enxq9cy+8NLwkZnU3aZj51w1MG8dhf8kgaN4qTMkX0T
	 HUrbkJUckxy3d9qF33Kz2r07nWqL9hX/dncITsr+utWkghM9YdeeXQ7GTZuMvbcCR+
	 6T/LHkmpgqz/Q==
Date: Fri, 13 Dec 2024 09:40:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com, quic_jprakash@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/5] dt-bindings: mfd: qcom,spmi-pmic: Add MBG
 thermal monitor ref
Message-ID: <gvothokc3brwmpujgbbu4d4w7nmkovyr36wx4aqn35di7ugiwx@gbjmgyngweak>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-2-3249a4339b6e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241212-mbg-v2-support-v2-2-3249a4339b6e@quicinc.com>

On Thu, Dec 12, 2024 at 09:41:21PM +0530, Satya Priya Kakitapalli wrote:
> Add reference to the newly added MBG thermal monitor bindings.
> 
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>

You must explain the dependencies between in changelog or cover letter,
because you trick now maintainers into applying something which will
lead to broken tree.

Just squash the patch, it is not a separate feature.

Best regards,
Krzysztof


