Return-Path: <linux-iio+bounces-27503-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4AACF9633
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 17:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24BF9302C854
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD66322A24;
	Tue,  6 Jan 2026 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6ZkKAOS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB130274B42;
	Tue,  6 Jan 2026 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717437; cv=none; b=ozO4iKTMoRcpMcJlXoZCVmj2EqX0Js5vyipvgLVB0YrSoQ5GVSkFuf8dayqfPLk+2cqKvJBMa/zMvtISp1+uA8kUrvYudYXiU0bnlo9FZdB/ah2W6pFg1oPoU58ZfgS8egmCm8OT9kynt4BJoaZXWv2kC2BFHMZSR+f11jRA1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717437; c=relaxed/simple;
	bh=u4qncAIY/cpRgrdi2t4oOvG1OSeSwJkdTHwCR7W900k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYzgHT71gynYQ789iov5OAR8vwQjK9cpCU3hsuSse/SDxSHcHIM7NalowXBt6OGuPWEYG2MCV/l7++gJry0OT5xD96l4Npj3yxfejx2TRaSmYsb8WCOirVAcaEVedkc3V9IYgl4a9tg76iyyZt2w+sPS+6quYF5E1Zb0kXrN8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6ZkKAOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401AAC116C6;
	Tue,  6 Jan 2026 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767717437;
	bh=u4qncAIY/cpRgrdi2t4oOvG1OSeSwJkdTHwCR7W900k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6ZkKAOShyuovXO/a7H+sCFepZbp9x8KnS4i6Vh+IxmVVfenMtCtJSR/kNLpDuGMN
	 gzVC/N4e0gVjCcVX9Afy0Zsowqof7aDW//XwoNWAfW4SJwDmwVnqBnTR7t3UM2ZsBI
	 0nfud0Ubebv1YvPyVBrMfxVneb3b8KxjvVkHMsqEn+Ia04sGEr7kuTQ1mizC6aj/QS
	 PYt97a+3cmk1XYl3m3G8c6qiCVIkcvnvbDkYmMQxF2EOPPerLzqgFTz3VrgaAgMpRj
	 EDRtiohXJhDrfOrNNp3BJynoz3d86MFn5NtKoMM90y1iz9eLUz/Hlbo7TJWhqJYwyX
	 i0Cc/gzGtlumA==
Date: Tue, 6 Jan 2026 10:37:16 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 8/9] dt-bindings: iio: adc: adi,ad7380: add
 spi-rx-bus-width property
Message-ID: <176771743572.2227331.2597115591316587546.robh@kernel.org>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-8-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-8-145dc5204cd8@baylibre.com>


On Fri, 19 Dec 2025 15:32:16 -0600, David Lechner wrote:
> Add spi-rx-bus-width property to describe how many SDO lines are wired
> up on the ADC. These chips are simultaneous sampling ADCs and have one
> SDO line per channel, either 2 or 4 total depending on the part number.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v4 changes:
> * Change to use spi-rx-bus-width property instead of spi-lanes.
> 
> v3 changes:
> * Renamed "buses" to "lanes" to reflect devicetree property name change.
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


