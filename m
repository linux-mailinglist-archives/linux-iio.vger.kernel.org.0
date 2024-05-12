Return-Path: <linux-iio+bounces-4980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301138C3647
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 13:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D871F212F4
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F775208B8;
	Sun, 12 May 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8eCumQg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12F208AD;
	Sun, 12 May 2024 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715514783; cv=none; b=MvifbRfTRnehbYMsXeGwLGoJhqmVLlN/b7A6QY42ypsCBwGJZRfRHgoaG4gSqLaJ9iYZkNpE00IpXCt4X1xGPPeHalEPdnNTouGu+KgtqSc8kc73BDxoDChGKWkCq5Yrk44p2i74Evw/fmJXDVgorrRmoEexmGFyJLNgxdF64FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715514783; c=relaxed/simple;
	bh=EV5hOtBRZoACEd3ofs5zsHiQzho+I7OVwriKzAsb/iE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvukEQV+akzyBzp59hf7uM7eYqHOLO/JTcvRbvb/MVmYd/0zcPHIbb5h2TZft0J1dRf+m5x9JnbVdTBBeWpv1Saj6G0auys53iYGNIjqZGWDxt5ernFSgGGGtBtQFY/miNBD7Loh3UsZrkjmO/z1tPeIy2ZyynTVz7VD9zZvznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8eCumQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F71C116B1;
	Sun, 12 May 2024 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715514783;
	bh=EV5hOtBRZoACEd3ofs5zsHiQzho+I7OVwriKzAsb/iE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8eCumQgcg1UC3/G+H4OfDG37QQ+BovQueGPuCYuYI3UiP5sx4cyAVsA6pvlD2fGy
	 wDLmsUp6PBzZB4lVb7IyWQMno8Oi2XSjSaknTknePMA9d8Dh2kThLNxzAz9hZkBajs
	 ly95NUXStV7MfLncaOTKVECeNaCSfLIl4gDlrl24zZB5VHw2cCT9GUefXAnYdtWvgI
	 NGxe6nknBUZrJezpv9JIYgAzSV0Kz9ho2zygisA1qbfSrmEiXw29GsEXOJBvDZxkCo
	 nUmBSpSPdE/4I6ogPsze1w42wspN/jCSCW6OyuaNFNo0Ve9mhKvmHqDYMFqybLaUaa
	 8a5UnUCf5ymRg==
Date: Sun, 12 May 2024 12:52:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: adi,axi-adc: tweak example node
 name
Message-ID: <20240512125252.7b4ed1fb@jic23-huawei>
In-Reply-To: <20240511-overeater-prodigy-7f41e66762ac@spud>
References: <20240510-b4-iio-axi-adc-dt-binding-tweak-v1-1-a1f633c4602c@baylibre.com>
	<20240511-overeater-prodigy-7f41e66762ac@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 May 2024 14:00:40 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, May 10, 2024 at 04:04:38PM -0500, David Lechner wrote:
> > It is always recommended to use generic node names for devicetree nodes.
> > The documentation [1] of the AXI ADC IP core says "The most important
> > part of the core is the Receiver PHY module.", so using phy as the node
> > name seems appropriate.
> > 
> > [1]: https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
Sure, I guess phy is sort of applicable here.

Applied,

> Cheers,
> Conor.


