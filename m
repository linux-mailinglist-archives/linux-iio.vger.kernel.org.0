Return-Path: <linux-iio+bounces-10838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253C99A5D43
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 09:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3131C221E7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348531E0481;
	Mon, 21 Oct 2024 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmHfZtPF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D238A194A73;
	Mon, 21 Oct 2024 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496339; cv=none; b=AUqZ52Og59Q50YfftV2eNvrrl65yb2A9nVQqhEEWgG+hm+yC6hYd+mO1u8rJEZz+gBj47OoM7b3MtdqXNnW2RhQOY+fVbUVJQOSY37AL5bmj4fcLp846k+DAHaGEyiRFnaH2Rwxmij4fJqSGyUo4z/w5UXw3kwnRYR5BsmVWvFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496339; c=relaxed/simple;
	bh=ljL74qSzfYV7vSO8Dk/xSzTXazS1a48G9FtGOkKXhd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SE7MqKWWMdhmLvLc5EUY7HveIGypcJsh16AR1GQVY+NKoSno6eyJmd/wcBKsxyVLQ15b+k9DjrXcfSGw2lAdx0IGOn18mNTtsxqLzOAmjwPriGMzjg5VIoyXeJ17rHAHaFUAmcaThwWuJskVkgFP+kuaeQ3nXN0rK3VV8yaXubI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmHfZtPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C7C4CEC3;
	Mon, 21 Oct 2024 07:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496338;
	bh=ljL74qSzfYV7vSO8Dk/xSzTXazS1a48G9FtGOkKXhd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmHfZtPFoTlMQxYjgRoPrrNLJtm4LiUr/ng0po4i8NNa4aY/ft2ETPcY1w0XXIzyi
	 sAQZhAy5DL2fYo2wXcE5ZjQr5myNDKlEPirnhxYk3+FmIxiwdEtB1uU0ml3h3+n10W
	 S1Exl+2xe05KR5e8820v0QmhlyXOfgYG2W68rxSzj4+PmhhAXDTX9alWzxZdwII5js
	 WzXKLfNvlvPYTgeFRT0Ye2d1GBwmFO+i/a+9fSWy9C8le7ApePej1Mj86oj+10dNFQ
	 ipzRcU/90fXiLUiXMQky/R9nhxmd+m9Wl7tS79Wtw7dkrC1QZvGrvFpkJXPuFNAnW/
	 piJuzaVHrQWRw==
Date: Mon, 21 Oct 2024 09:38:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	Philip =?utf-8?Q?M=C3=BCller?= <philm@manjaro.org>
Subject: Re: [PATCH v3 3/6] dt-bindings: iio: imu: bmi270: Add Bosch BMI260
Message-ID: <ynhv4c4pyj72nsof6wwkaon22i6chd4ux5cb7hv4tmblwhv3aq@564biida44ii>
References: <20241020220011.212395-1-justin@justinweiss.com>
 <20241020220011.212395-4-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020220011.212395-4-justin@justinweiss.com>

On Sun, Oct 20, 2024 at 03:00:07PM -0700, Justin Weiss wrote:
> Add compatible ID for Bosch BMI260 to BMI270 documentation.

This we see from the diff. Say something about the hardware, are they
compatible? No? What are the differences?

Best regards,
Krzysztof


