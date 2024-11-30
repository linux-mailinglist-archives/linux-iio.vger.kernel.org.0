Return-Path: <linux-iio+bounces-12867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 545129DF241
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF1A1628A8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23B1A42D8;
	Sat, 30 Nov 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVNlgHYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5D18660C;
	Sat, 30 Nov 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988088; cv=none; b=gZvaMRXnKoLjk5tPtrGZxMH11/wHcAfnHWbpd3kaAsZQqF5m7d99EgyREXBj/J7YiIEYMbGLHUew77bJDUdvrzsnoDvwyVmGErxC8UAyBkwKeoyrt0Awer4aAnbIVP/jDaI/ZfrRH8O1QmrBWaolHU/kkMBxhDJw6Hy3TjHB7yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988088; c=relaxed/simple;
	bh=TpK7DzD3wmUq0s8TiCBjMT1MKmazlW1Mk1fBjNF9jJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyIaHRjoU9Jcz5esQ82wWhuMfVge38FLXKuRvqm93mG8TxLRkmGnHYbm8D5hFecGFpp8RIfjD0jVBwWCk/FDqoSMmYnt0AW/zvluRfPS408wvb45ci+RgBkwcRYjkJcoqfOjQjIs6moKVoNNfxI1u3t4/YVgz0V51o9WgZTxSaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVNlgHYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112C7C4CED4;
	Sat, 30 Nov 2024 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732988087;
	bh=TpK7DzD3wmUq0s8TiCBjMT1MKmazlW1Mk1fBjNF9jJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sVNlgHYVWNX2SDGLtuWqRNCom0k/Q3IK5t96mviA0c73l+LaOXZMqlhYRpuRuhLEo
	 BZouJug9oeFzcgnNBGOVjmZaUvyIddtQUpV9xLzCK18Wab6mGomSyUZGVt9kU2xWaQ
	 29XjgYkLH1ZzyvzkGSUeBTw6aVXEc83Fe47M5JGQspsFwlL/ttYWq4+IeklUb7S+C3
	 fRNOxIxATMQPaYep0ua6feBSadFRu/lD4dTHaaVwaVmFBjX1UDIQK+S1IJU1xClD39
	 9k6v/kLiWSHysnvDVaJZpcnO0LJ0yLva1gm2l+rN8+q40l9qX+2dgEH9mX73OSz80B
	 XzuGGOTmXwkiw==
Date: Sat, 30 Nov 2024 17:34:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Denis Ciocca <denis.ciocca@st.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: st-sensors: Re-add IIS2MDC
 magnetometer
Message-ID: <20241130173437.6211e96b@jic23-huawei>
In-Reply-To: <20241129-dictation-outplayed-0a6a0844158f@spud>
References: <20241129-stmagdt-v1-1-963f0347fb0a@geanix.com>
	<20241129-dictation-outplayed-0a6a0844158f@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 15:29:21 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Nov 29, 2024 at 03:54:42PM +0100, Sean Nyekjaer wrote:
> > "iio: st-sensors: Update ST Sensor bindings" accidentially dropped
> > the compatible for the IIS2MDC magnetometer.
> > 
> > Fixes: 0cd71145803d ("iio: st-sensors: Update ST Sensor bindings")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

