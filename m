Return-Path: <linux-iio+bounces-9606-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE3979D71
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 10:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3501F23659
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12472148310;
	Mon, 16 Sep 2024 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8FC87Zt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04871465AC;
	Mon, 16 Sep 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477063; cv=none; b=GGfA4cAOoqDBhtAsrtqQ1PC6fEEQdl6d/7Kx+iRfM9HSEIUsxhZVh7cT8zd9xpeP6P9Qan2az5DiwUq5lGl//nBDDiMlDnZ3qX0acAfxnqNm3Ed/58fBaVbhR09/o74ZJlIBfSSQ3BteTZRF5OXDC2Pl1I9v6UgYyA21cRK9xDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477063; c=relaxed/simple;
	bh=w/oguMx1zZBjjdKmEJ/E5b95H0TT593f7ChHGp0cIhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOjQh1PLQ26mk3T35IH6UjYvYD4JQIpd+SOvePMWAOixFwWeFm97IAgi4RPhYBdTvkSmBTYwp1nPA3lhtU0T4TgrwktzC0UumY8kGYKySN7s1gcSiocY6de4acjcyq+i35QN/96DHquaEzzVzqo/jU6Gv8mWSpJK9ZdyYvLZFwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8FC87Zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74179C4CEC4;
	Mon, 16 Sep 2024 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726477063;
	bh=w/oguMx1zZBjjdKmEJ/E5b95H0TT593f7ChHGp0cIhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8FC87Zt1hfC0hc3YHPksnUmwsUHyGCkK4qmJROtW5wKlIz0gzbPbwYdWrF5YPDyq
	 vQO8NHYMkTHVr5caX0cDOJkAVK4h6VYuTOw+6skSatO6T9bbki4xq0uhWqzNnU3FBp
	 NmMSEbVAFnDeNyLKgcbtFTQUhIzTEyBuq03C9jt6hPFrZnTDHSi5EY19gC/EczQuDo
	 GIFZN7uosyQd1ZY+op3dAfEMpNw5uDLqutNUsJCuQBtU1Bzd9UNyHfpbAsJSMzF1DB
	 0hGNBPxm19qxAWwN29/+r4GZ/r4kDdT6g7fL4q2pTyGMOPt+dBePlaqo/oYBpXiIlo
	 FKYSocYcDUwAQ==
Date: Mon, 16 Sep 2024 10:57:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mariel Tinaco <Mariel.Tinaco@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: dac: add docs for ad8460
Message-ID: <s462taudzykzc54v5rbadmirzzle5jll54hg6jbmf6ppo4voe5@yqu645woxumq>
References: <20240912095435.18639-1-Mariel.Tinaco@analog.com>
 <20240912095435.18639-2-Mariel.Tinaco@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912095435.18639-2-Mariel.Tinaco@analog.com>

On Thu, Sep 12, 2024 at 05:54:34PM +0800, Mariel Tinaco wrote:
> This adds the bindings documentation for the 14-bit
> High Voltage, High Current, Waveform Generator
> Digital-to-Analog converter.
> 
> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad8460.yaml          | 164 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


