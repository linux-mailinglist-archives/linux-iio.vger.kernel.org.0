Return-Path: <linux-iio+bounces-21043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0402AEC853
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6FF1BC1778
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE7E221FBD;
	Sat, 28 Jun 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7Q0s7Bm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594D21ABD5;
	Sat, 28 Jun 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751124803; cv=none; b=lnIIR9NLd+Mykx/I6IAjps0JTj4s0/dzQD+3kHu6tlM9ukRlpF02kS7pGHhl19mpu3UUydTwL6ZQEZ8uj+wM6+mmdlq123TD/XPxtdgwdys3U90ngZM1BppOcpx1jnE2rwuC4pKpacf/O4d6qh5WqiNHUs/9CVNNacgE1qVVxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751124803; c=relaxed/simple;
	bh=5mm/kX2Qk5opcXrPAOn6/s4gypLt8GyVRnR3TC53A+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQQiRHPS3sirfkaK/MN15hlsoU6dDowykpkNhluAif4x5rqLeB3gwnpAccbDplNkeHZ/yrUvILIz1RvGC8nAC7jK8oQL5wBJODCBr4ZWdcF1DaA42oWPB8+AuHBxCsbrGMkGeWshwXEI6KPLcx/sytJCHSRvnBcd31qDm5uZ3KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7Q0s7Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3DAC4CEEA;
	Sat, 28 Jun 2025 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751124802;
	bh=5mm/kX2Qk5opcXrPAOn6/s4gypLt8GyVRnR3TC53A+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7Q0s7Bm0mjkS68t1CIbyBzdvoLx/QYDMgS1DIABPtbitMwL1yb0ZITeiJNpqF0BJ
	 SWxgu9N/Gj+SFPai/QpObpGPU5XMQQ4sNwa63gm6t/gq1pjYP3klBHvv71iaipvqXZ
	 0m4pwbq7H1wAqMjfEIA4PFkzz2Hd3/D3xq4BMsgZ5fTRt3YwAgakcS3K6XhA7GnRFL
	 18aTtHrvMzCAaMEsyZkGiu4Xw+u0sUlbhJLt8FW9ZkE0MAHIJeIyZoJwk/cj5xm0Qt
	 ORCkbao/0FsQA8U2veqHrpzAIwUOzLtJySCP9gwq6N5OREyhbmO259YyqoICx9lW4c
	 1AuxFMos01iiA==
Date: Sat, 28 Jun 2025 16:33:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, Gregory
 Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: iio: adc: nxp,lpc3220-adc: allow
 clocks property
Message-ID: <20250628163313.187d4a3e@jic23-huawei>
In-Reply-To: <175105627901.33520.13967663171471942396.robh@kernel.org>
References: <20250624201302.2515391-1-Frank.Li@nxp.com>
	<175105627901.33520.13967663171471942396.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 15:31:19 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Tue, 24 Jun 2025 16:13:02 -0400, Frank Li wrote:
> > Allow clocks property to fix below CHECK_DTB warning:
> >   arch/arm/boot/dts/nxp/lpc/lpc3250-ea3250.dtb: adc@40048000 (nxp,lpc3220-adc): 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/nxp,lpc3220-adc.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 

I was in two minds on this one wrt to whether to pick it up as a fix.
It's clearly been broken a long time though so I'm not going to rush it in.
Let me know if you think I should!

Applied to the togreg branch of iio.git and pushed out as testing because
other stuff I queued today will benefit from a 0-day pass before I expose
it to linux-next.

Thanks,

Jonathan

