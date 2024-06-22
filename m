Return-Path: <linux-iio+bounces-6713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F469133E5
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 14:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F0E1F246AC
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 12:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250816B395;
	Sat, 22 Jun 2024 12:20:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A85A14A098;
	Sat, 22 Jun 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719058815; cv=none; b=GHiwVVg288iaLp9iT5wRBdWbBMXYJr2MQe3XOIkgovs98i37aCOiOp3abYB4vdcD2oQOM3yim/FrjF/EEGQDXQ0B9mgwLlmStrUuFZ17lY3KcvNpiqWFHyiDRdPD627zfpCS9kFG5bL3IJeE/29zvAW18aH1nUjw2kFY5fs0zOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719058815; c=relaxed/simple;
	bh=4oSuqcRDnHuW4LEkKJzODublXanoveluuSpNYvSYoUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IFmVLX56tnyias81L9rYDztu9MUrMQRe0wcBIMvloTd0HqNifrA6Aqh3dTZfqmEVRBnoC6/GrwDATKq3OZ7LMHqL9XKUd7Pk2Tl8LjHSsSO6ejzS3kIElk/5XATIYENsN9UizdGs8xxSIHgVXUx5WLGLc6S6Q/QJsR6LERDVtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88B3C3277B;
	Sat, 22 Jun 2024 12:20:14 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id B66535F852;
	Sat, 22 Jun 2024 20:20:12 +0800 (CST)
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
Message-Id: <171905881272.1097480.14266165459685646516.b4-ty@csie.org>
Date: Sat, 22 Jun 2024 20:20:12 +0800
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

Applied to sunxi/shared-clk-ids-for-6.11 in sunxi/linux.git, thanks!

[1/4] dt-bindings: clock: sun50i-h616-ccu: Add GPADC clocks
      https://git.kernel.org/sunxi/linux/c/532857c2a76b

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


