Return-Path: <linux-iio+bounces-6054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DB1901208
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20F28288B
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3FB17836A;
	Sat,  8 Jun 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVxr6HeC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD2B1FBB;
	Sat,  8 Jun 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857158; cv=none; b=C1b+WN+vsSHIR1YKYSg1PR+H+Kl2b7edWSIzy7bGiSTc2dWwejgeNlBJ9HwE8+7vJrTrM+YyHn3xDtXSF9E7thcK2jENq9Es4+xwVUS0lO8GWy/Si3YEXkuk1IjOdKAzwOd13CCBV6G0P58ta2kkJ53OXR8kjW3Ass6q5TLpuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857158; c=relaxed/simple;
	bh=zGEPcDt853zwTvT5c/vkd82U97Wq4qbke8w4K0IQ1oU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNXu5WHwCgyQzwbMS/VqspYU9kRV5IkP7LBqljC4dn3Y8RKLp8VNCb8+ZK2kPmCmtDUW+vRn6fJPDsc25h0DLhZV02TkRICO0RToVBigFpA1Iipdrvr1FC5+gHraALk82av/eBF+hmpYXJro51UocuM+vixkUatjP1/PEzyKvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVxr6HeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB9C2BD11;
	Sat,  8 Jun 2024 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717857158;
	bh=zGEPcDt853zwTvT5c/vkd82U97Wq4qbke8w4K0IQ1oU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LVxr6HeCpiXGfDae+9YHPzHKV4zTBtFO+V66iRYJuTFltZ/q52Xsuo4CsH6ZXqb4Q
	 NnOTW6mGV6ix5FBND9wB3pxhJd0VRNbAtHDLMrMsj1p5BV3QX0F6l6eelp0RtOs5QZ
	 pNevnq6SG2FIOZL50RQYMnsEZNTiOUTRYUfIcM5L/tvwIOhvdWPeb5k8kxuByp/ksr
	 1NLtI9rqxb+3NlYPkVBFtM2chX5LxJvucRPKQrtF6agpjGVL5QbAR+ybBY2AKCb0eX
	 bngCHOu8SEkAKs5BwqqWoi1mQrez8+gjucTxGz4GzE+OwT2Y9qf6A8kekrddQI0wOQ
	 ohkiBTM1LBMuA==
Date: Sat, 8 Jun 2024 15:32:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Kim Seer Paller
 <kimseer.paller@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240608153231.02f839fd@jic23-huawei>
In-Reply-To: <3dadacf8-1349-483d-b264-dcb41d2cc3fc@baylibre.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
	<20240603012200.16589-5-kimseer.paller@analog.com>
	<2942a938-19b9-4642-8ed0-8e17e4825bc5@baylibre.com>
	<c4651a18-316b-42e0-a67b-673fedb05b5a@kernel.org>
	<3dadacf8-1349-483d-b264-dcb41d2cc3fc@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 08:53:27 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/4/24 1:47 AM, Krzysztof Kozlowski wrote:
> > On 03/06/2024 21:59, David Lechner wrote:  
> >> On 6/2/24 8:21 PM, Kim Seer Paller wrote:  
> >>> Add documentation for ltc2672.
> >>>
> >>> Reported-by: Rob Herring (Arm) <robh@kernel.org>
> >>> Closes: https://lore.kernel.org/all/171643825573.1037396.2749703571529285460.robh@kernel.org/
> >>> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> >>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> >>> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> >>> ---
> >>>  .../bindings/iio/dac/adi,ltc2672.yaml         | 158 ++++++++++++++++++
> >>>  MAINTAINERS                                   |   1 +
> >>>  2 files changed, 159 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> >>> new file mode 100644
> >>> index 000000000000..d143a9db7010
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> >>> @@ -0,0 +1,158 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/iio/dac/adi,ltc2672.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Analog Devices LTC2672 DAC
> >>> +
> >>> +maintainers:
> >>> +  - Michael Hennerich <michael.hennerich@analog.com>
> >>> +  - Kim Seer Paller <kimseer.paller@analog.com>
> >>> +
> >>> +description: |
> >>> +  Analog Devices LTC2672 5 channel, 16 bit, 300mA DAC
> >>> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2672.pdf
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - adi,ltc2672  
> >>
> >> The linked datasheet describes 12-bit and 16-bit versions, so should we have
> >> two compatibles here? adi,ltc2672-12, adi,ltc2672-16  
> > 
> > Is their programming model different?
> >   
> 
> I replied to myself already with the answer. After looking at it more it
> does not appear that is the case.
> 

For a DAC, this is an interesting question.  The wrong impressions of
precision might be a problem if someone is trying to tune the value.

Say they set it to +15 and look at some other sensor for the affect.
They expect to see something but get no change at all.  They might
assume the circuit is broken.

So I think yes the programming model is different and that should
be discoverable (ideally from hardware, but if not from the compatible)
To take an extreme example of extending the logic of these being
the 'same' from a programming model point of view, would we consider
a regulator that did 0 and 3V only different from one that did 0V,
1V, 2V, 3V just because the second bit in the register was ignored?
I think in that case we'd consider them to have an obviously different
programming model.

We have a few cases where we do paper over similar differences in
resolution, but within one part with different settings rather than
between devices (so that's a driver limitation, not a DT thing).

So I might be persuaded no one cares, but in my view the programming
model is different in a significant way.

Jonathan





