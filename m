Return-Path: <linux-iio+bounces-12109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 106339C3509
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 23:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AF72817AB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2759158848;
	Sun, 10 Nov 2024 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jgvAhVq8"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2E52B9A9;
	Sun, 10 Nov 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731277215; cv=none; b=A5Nyur6G4Kdxfi7NWIVpfBK8XAIysQnUTjBvP2q74VBtQC4gzrR0f6Zv09NtOCDPN6NiA6LcvdX6P6PQ3qTEEj6rRAEdGXzn24xn6vCh5AdaYMyz9TIZ1jnOP3LpbPcnQhrNCLTgR7Uq6ia0j7EvDLvQuEAc7a9QwjOIWEDl1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731277215; c=relaxed/simple;
	bh=vWiAnPDvzJ7D0NhtAYKIk8U+AVw3hjK1fZbqqvO6PfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpGHq7E2eyDUTB2yNjXWv2kZlchjy3aDpE9py8BNhrQJ1YD742rndxEO/vlTsFU4omRYBj6Yk0zI+rZT6PwwZFqd8Ln8rOVb1uqiwfbVdEQbPoB/jl6z6w4XGYn9UP2NysavIvpQrcrqE3Iyefod+1cseVGM/7B2EFQGx90Gfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jgvAhVq8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA228240002;
	Sun, 10 Nov 2024 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731277204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9orySFqiLkR/qY+bcxW2Z/J3ieCCiSxmMOqWc/cVx04=;
	b=jgvAhVq8nz+iOOzk69MseaQRS8fuzamkE0JFjN9bMWZlr0PfZY4POo38flHp15iJLhInar
	jLKq4Wz5g9h6UB6i+LqJmkAGxjyDIVxRIs16vhSEx6HqVXfINdx6o0zv2cyj3ejuF0ii9S
	5Uj8z5vdvdD7Ta/QLXNXg3l3QqTLQ3klv7zc6agCNGhLOLkA3DyY2WpPtmMzeJXjhFtY+V
	GB9g5SoggFvMqkTj50de74DHp8jJOQSsWj9dt5JMWEeEBgtgc0OULDeEH6TRFJKJTckEjw
	G1QZ9dgGhbsSYUAjxY4LnKvvBYCzFM+OZQY3ufLJFfztzLnXZVsuGU7xAB+TVg==
Date: Sun, 10 Nov 2024 23:20:03 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Lee Jones <lee@kernel.org>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <20241110222003bbcff5ad@mail.local>
References: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
 <20241106090422.GK1807686@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106090422.GK1807686@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 06/11/2024 09:04:22+0000, Lee Jones wrote:
> On Mon, 04 Nov 2024, Stanislav Jakubek wrote:
> 
> > Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
> > filename to match the compatible of the only in-tree user, SC2731.
> > Change #interrupt-cells value to 1, as according to [1] that is the
> > correct value.
> > Move partial examples of child nodes in the child node schemas to this new
> > MFD schema to have one complete example.
> > 
> > [1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > Changes in V3:
> > - remove $ref to nvmem/sc2731-efuse and list the compatibles with
> >   additionalProperties: true (Krzysztof)
> > 
> > Changes in V2:
> > - rebase on next-20241029
> > - drop partial examples in child node schemas, move them here (Rob)
> > 
> > Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
> > Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/
> > 
> >  .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  17 --
> >  .../bindings/leds/sprd,sc2731-bltc.yaml       |  31 ---
> >  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 252 ++++++++++++++++++
> >  .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ---
> >  .../bindings/power/supply/sc2731-charger.yaml |  21 +-
> >  .../bindings/power/supply/sc27xx-fg.yaml      |  38 +--
> >  .../regulator/sprd,sc2731-regulator.yaml      |  21 --
> >  .../bindings/rtc/sprd,sc2731-rtc.yaml         |  16 --
> 
> Is everyone happy with me merging this through MFD?
> 

This is fine for me.

> -- 
> Lee Jones [李琼斯]
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

