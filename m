Return-Path: <linux-iio+bounces-6715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5059133ED
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03E828387F
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208116D303;
	Sat, 22 Jun 2024 12:22:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE13A15217E;
	Sat, 22 Jun 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058936; cv=none; b=He8Wp+wfeJrFcXVgSVbFOsuhX6/oP59qqFIKEoR/Di+HAJbt8y+1onPa0ZDbG2mLSXP0Kt7s8uCiJImEOx+jIueM5/RsujdhjkEejOvVL17/JJZywYaQtlL9QqYGvzsrLYRTYm02CfD1tw2kKjgiqnuX+sMkKlo5zGYbsGs741g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058936; c=relaxed/simple;
	bh=6lB30XLXSm3uB+E7ckHddxbxdFU97VQ0hG54flT0mjw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NLlo34dgY0gpeh+ukAbVjl4mtCCJSGtUFuNaTAqThCU2SaSR9k/MzEVgKGoiXcQ20QlGJAVq55nBW9kizjhtmzPFTO5sOw3zn+FhFtdOInSUmEbwGYMHXL4voViDBjy4FjMpq/5jadLLOo+gYEHC4xppQcEyREUAoiBO2jGSa9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF5BC3277B;
	Sat, 22 Jun 2024 12:22:15 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id BDACB5F852;
	Sat, 22 Jun 2024 20:22:12 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Chris Morgan <macroalpha82@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, p.zabel@pengutronix.de, sboyd@kernel.org, 
 mturquette@baylibre.com, samuel@sholland.org, jernej.skrabec@gmail.com, 
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
 Chris Morgan <macromorgan@hotmail.com>
In-Reply-To: <20240605172049.231108-1-macroalpha82@gmail.com>
References: <20240605172049.231108-1-macroalpha82@gmail.com>
Subject: Re: (subset) [PATCH V2 0/4] Add GPADC for Allwinner H616
Message-Id: <171905893277.1097963.9993549431272283905.b4-ty@csie.org>
Date: Sat, 22 Jun 2024 20:22:12 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 05 Jun 2024 12:20:45 -0500, Chris Morgan wrote:
> Add support for the general purpose analog-to-digital converter (GPADC)
> for the Allwinner H616 SoC to support the ADC joysticks as found on the
> Anbernic RG35XX-H.
> 
> Changes since V1:
>  - Split dt-binding include additions to a separate patch.
>  - Removed patch adding compatible string as it was already upstreamed.
>  - Added patch to add the adc-joystick function to the RG35XX-H.
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[3/4] arm64: dts: allwinner: h616: Add GPADC device node
      https://git.kernel.org/sunxi/linux/c/59678cc9cc54
[4/4] arm64: dts: allwinner: anbernic-rg35xx-h: Add ADC joysticks
      https://git.kernel.org/sunxi/linux/c/e41e5973bf45

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


