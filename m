Return-Path: <linux-iio+bounces-11935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC57C9BE1CB
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 10:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C801F247C3
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B611DA0EB;
	Wed,  6 Nov 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzZbmJRB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733F1D9682;
	Wed,  6 Nov 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883869; cv=none; b=UmR+LXV6XmOi8+t3QbKbJTFhwdqhhfuvTC2v42oj0Z1QieIZvA0SMZ0cykTvJWn2ap/3Klg/HEWyMYjbkK6BrSpbURpYo1Lhk9bjnrO9DjU6HOaHQ3Ef1N1NDdOMJp1O23AswyofmUm0fQeeb4zPrGpPCjoEUD/g6w701EulRPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883869; c=relaxed/simple;
	bh=14LiskvmrAxH19seuwybTIAIS03TefkfmGN9gcOpSRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfJtm0fClXrs3/Mv01jPeZT2UnMeoHOBx+aQwLnkYohn0HIaUP7anMxOJvUCvv6i3w5HtqUXwq1/XqRhIjb4nZVpGTYFWcdpOSCp57Vz3WxY76gzAl4HprAuRTgpzEfBQehxm15P0CwLdBaB5QgaoMeNt+tmkAIfwdz+OW9zsCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzZbmJRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C73AC4CECD;
	Wed,  6 Nov 2024 09:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730883868;
	bh=14LiskvmrAxH19seuwybTIAIS03TefkfmGN9gcOpSRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rzZbmJRBcqbgXgYaBOLVAb4F+VwDv1meTvq6TBFHewgm2Ax2UD6+6FrJ27eIReMxq
	 dlSxKDl9FhR1If78kCtPjRT8X04YZ4mc+vsUMJTFQvx9z7sFQM7iRIWFqSWsMA9D9C
	 PTcjuo95TRk7WNj+zsBA7zZ57j8ADRpnNa0bkD/nhnJYwMDXNA4QXXL5TeA72xxPmh
	 jcUnBoFNOlTLbL0owGm38XvpbioneVAYp3+uyVpOc3cxlPhrbS6Whb0wNzEdlH/5kX
	 eWfIgZWKRTZuJakpBUP6XnyPlxyvK+vYRG7gAt+a3wLBNY1xBXgyCB3wjNxdQr+jxM
	 q7WniXc2AkyJQ==
Date: Wed, 6 Nov 2024 09:04:22 +0000
From: Lee Jones <lee@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <20241106090422.GK1807686@google.com>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>

On Mon, 04 Nov 2024, Stanislav Jakubek wrote:

> Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> filename to match the compatible of the only in-tree user, SC2731.
> Change #interrupt-cells value to 1, as according to [1] that is the
> correct value.
> Move partial examples of child nodes in the child node schemas to this new
> MFD schema to have one complete example.
> 
> [1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V3:
> - remove $ref to nvmem/sc2731-efuse and list the compatibles with
>   additionalProperties: true (Krzysztof)
> 
> Changes in V2:
> - rebase on next-20241029
> - drop partial examples in child node schemas, move them here (Rob)
> 
> Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> 
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  17 --
>  .../bindings/leds/sprd,sc2731-bltc.yaml       |  31 ---
>  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 252 ++++++++++++++++++
>  .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ---
>  .../bindings/power/supply/sc2731-charger.yaml |  21 +-
>  .../bindings/power/supply/sc27xx-fg.yaml      |  38 +--
>  .../regulator/sprd,sc2731-regulator.yaml      |  21 --
>  .../bindings/rtc/sprd,sc2731-rtc.yaml         |  16 --

Is everyone happy with me merging this through MFD?

-- 
Lee Jones [李琼斯]

