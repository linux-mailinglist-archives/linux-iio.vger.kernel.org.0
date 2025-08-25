Return-Path: <linux-iio+bounces-23213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C510DB33D68
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02121A80D22
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 11:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5302DF71E;
	Mon, 25 Aug 2025 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCLr83Gw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED02DF6F6;
	Mon, 25 Aug 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119589; cv=none; b=JbNqnzXj3T0qj8dkcf0WQPFnleY7m3aKB8c3Rl+XWBeHzSiDqQokfuRefA0HnsmUA0Ckgl2dOowobn8WY9ohnEBHTwWEoC7YGLW1DLooa5UC0TX6iMD68dpwlBDZBKXKSs0HZ6uOr+tYxtVIinLPUHy//1GW67RbdOkXGyuT6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119589; c=relaxed/simple;
	bh=EOtA8SKJ/vn/02jndM1Pn0wXRabI3Xe7rGLvRvp8CoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKF82wEvjYCS185qCTyvSrtHj+xO578cd/6/YiRkwFITkqrVSd1pF2CkVKz5R7KOTAcFPLVGCDjxb/N8qkKUELzwEcDIk/L/8pkTuyjkJDZtXaDmgupd9vWHVG9TS/RNf6vWKZjR5tbTh1AhaS0O63KaUAORfEqowQbPhaAgqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCLr83Gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7CAC4CEED;
	Mon, 25 Aug 2025 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756119588;
	bh=EOtA8SKJ/vn/02jndM1Pn0wXRabI3Xe7rGLvRvp8CoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UCLr83GwUsc21vVMFNXDz14gxt+XNXS0AEO4hBQTs5yyKLkq18/+6nVkZZLKOhF27
	 C+eJ7lqID1TIxUxLFUyOU+h1hP9BcGfJlnb2Cx3J5wc7j4tgFe1RkEkwW4idlDDtzH
	 rugFmgigH+DvKnXGC8he5Bz/jxHnHzftcr8j8BWsOgzE8MYNNRm696HYX0MLu+yVU9
	 fynz3ourbUA3RYdYwqlUpLgsUjjYPx8iYFwj43B9AadrLeXHiJs2UaiN8WXGHbhj1p
	 2uSM6ZkwJnHvLDOTnwYBctPlJSTyUptvNpW+D3TCdmbrofDxdVbI2T6S2RzJytMidC
	 Q8GR27k+QvHFg==
Date: Mon, 25 Aug 2025 11:59:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Kim Seer Paller
 <kimseer.paller@analog.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH] dt-bindings: iio: adi,ltc2664: Minor whitespace cleanup
 in example
Message-ID: <20250825115939.4c1ed3b7@jic23-huawei>
In-Reply-To: <175589097127.178922.52729764188594464.robh@kernel.org>
References: <20250821083150.46554-2-krzysztof.kozlowski@linaro.org>
	<175589097127.178922.52729764188594464.robh@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 14:29:31 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Thu, 21 Aug 2025 10:31:51 +0200, Krzysztof Kozlowski wrote:
> > The DTS code coding style expects exactly one space around '='
> > character.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
> 

Applied. thanks

