Return-Path: <linux-iio+bounces-16833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE1A60DBA
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 10:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4E01779E2
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176231F1927;
	Fri, 14 Mar 2025 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqWbMK3I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46191EEA36;
	Fri, 14 Mar 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945658; cv=none; b=APHAej6wLStY7qVGpvIPl92wTTWDfOCkNTSoFinUl/K413eTNPj7JDIbAMytu3ig4gBpebuefp8NPwDuoqx5Wfq3J3Sfa2PZQ1HXR9V7d+CHAe0KW80fYvz82PuvG0CmheqcKcNRu5Gvn+PRO06YymSBemFW+2udxDGyLlpifDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945658; c=relaxed/simple;
	bh=GiqhQYgwNaCAQ86P7jRzLoUtt/6XmyAbfRPrIv6/4/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip3q6g4tlqho46fgOZVr69unyXdllDuNAeR5rKRcSUBvnxLBh0awKKtwMA77499A999y+kS2OztUN3ZCpe+3IVYzkJdy9sZNnqKnctjqeYP47wWt3LwUsX2aQyrZO7qA5XndIRQIRFQX4IB3oXQJ/LYEtu2+uN8bF2NGImUXmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqWbMK3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD2AC4CEE3;
	Fri, 14 Mar 2025 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741945658;
	bh=GiqhQYgwNaCAQ86P7jRzLoUtt/6XmyAbfRPrIv6/4/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqWbMK3I8GlUQbAG7hEG6Hq4IeCZA+8ts7oj147BauszkdwI+h11xzROAPJ+9jT+e
	 9Xf4r7T5SBwV1UvsaiAYMsp7s3d2NleLznfpfhmcyE8ocT7jLUgUwJkgAsQ3pQXave
	 OK85ozDXGsmtZlNF2HyUtSLf44VszdJuvYUKg+qp8/6JBi+Yzp39qNt/caKfjRHh9u
	 z+tEmcQIpJv+r3NoE66YplPYJWcEfDpmT0tyQYlNEi/B7jV/lx/Gf8pv4ivSVqGE85
	 aJr3EXiVrSbf3XniXSvqEowF25cs3wquigGpYsL4OsqZPcohUmFTRzHEme98dgrMOJ
	 JSUPHqE9Bo5kg==
Date: Fri, 14 Mar 2025 09:47:31 +0000
From: Lee Jones <lee@kernel.org>
To: Lu Tang =?utf-8?B?KOaxpOeSkCk=?= <Lu.Tang@mediatek.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Chen Zhong =?utf-8?B?KOmSn+i+sCk=?= <Chen.Zhong@mediatek.com>,
	Sen Chu =?utf-8?B?KOWCqOajrik=?= <Sen.Chu@mediatek.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH 3/5] pmic: mediatek:
 Add spmi pmic mfd driver
Message-ID: <20250314094731.GA3890718@google.com>
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
 <20250314073307.25092-4-Lu.Tang@mediatek.com>
 <SEZPR03MB6891D404A7AA2BC5244A992A80D22@SEZPR03MB6891.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR03MB6891D404A7AA2BC5244A992A80D22@SEZPR03MB6891.apcprd03.prod.outlook.com>

On Fri, 14 Mar 2025, Lu Tang (汤璐) wrote:

> Update email address

What is this?

Please refrain from top-posting.

> -----邮件原件-----
> 发件人: Lu.Tang <Lu.Tang@mediatek.com> 
> 发送时间: 2025年3月14日 15:32
> 收件人: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Dmitry Torokhov <dmitry.torokhov@gmail.com>; Lee Jones <lee@kernel.org>; Matthias Brugger <matthias.bgg@gmail.com>; AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>; Sean Wang <sean.wang@kernel.org>; Linus Walleij <linus.walleij@linaro.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Stephen Boyd <sboyd@kernel.org>; Chen Zhong (钟辰) <Chen.Zhong@mediatek.com>; Sen Chu <shen.chu@mediatek.com>
> 抄送: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-input@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org; linux-gpio@vger.kernel.org; Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>; Lu Tang (汤璐) <Lu.Tang@mediatek.com>
> 主题: [PATCH 3/5] pmic: mediatek: Add spmi pmic mfd driver

Fix your mailer.  Headers have no place in the body of an email.

> From: "Lu.Tang" <lu.tang@mediatek.com>
> 
> Add spmi pmic mfd driver for mt8196

7 words for a 900 line change is not going to fly.

What is this device?  What does it provide?  What are its dependencies?

Etc.

> Signed-off-by: Lu Tang <lu.tang@mediatek.com>
> ---
>  drivers/mfd/Kconfig                  |  26 ++
>  drivers/mfd/Makefile                 |   2 +
>  drivers/mfd/mt6685-core.c            |  83 +++++
>  drivers/mfd/mtk-spmi-pmic.c          | 518 +++++++++++++++++++++++++++
>  include/linux/mfd/mt6363/core.h      | 134 +++++++
>  include/linux/mfd/mt6363/registers.h | 168 +++++++++
>  include/linux/mfd/mt6373/core.h      |  94 +++++
>  include/linux/mfd/mt6373/registers.h |  53 +++
>  8 files changed, 1078 insertions(+)
>  create mode 100644 drivers/mfd/mt6685-core.c  create mode 100644 drivers/mfd/mtk-spmi-pmic.c  create mode 100644 include/linux/mfd/mt6363/core.h  create mode 100644 include/linux/mfd/mt6363/registers.h
>  create mode 100644 include/linux/mfd/mt6373/core.h  create mode 100644 include/linux/mfd/mt6373/registers.h

Please try again.

-- 
Lee Jones [李琼斯]

