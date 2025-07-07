Return-Path: <linux-iio+bounces-21415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F5AFAC0F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 08:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E755189A1C7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jul 2025 06:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCAA27A12F;
	Mon,  7 Jul 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paua9nDR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98902263889;
	Mon,  7 Jul 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751870666; cv=none; b=iO0yPY5wQC/tgfVwYqHBbVLbAKV9ba7hQiz2rYSFe9O1azsXwIDtK+sPN4Zuj/ZpPF26YcPHBWNZaZGGbfrOzdFAxsTc3HyQbUVai8pZoy43v3n2ilUiOab13BoHraW98vf4YtgqWkG4UjeBQj+tNNa7IJ7If894cKrolzOe63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751870666; c=relaxed/simple;
	bh=SJ8/47tbP+hzfpsBFEyc7qON0FE+gBuhowLxlpL7PCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKK06lEUeZsJ4JRNMRpbXZ1Pji3/gzTEqL1gd3rJyNGHy+txvBQr7xDlbCDB6V6tmRp3v2ay0kTlJ8U7h+HAZB3cwtI7IQYXQ03IhwPowAKZqo2x7T4lA8VLKw7jOTgHFfRy+d1njRkX7m23nC+jMt4IlbqDTA3P2Ri23xPATc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paua9nDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A38BC4CEE3;
	Mon,  7 Jul 2025 06:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751870666;
	bh=SJ8/47tbP+hzfpsBFEyc7qON0FE+gBuhowLxlpL7PCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=paua9nDRJNTPwe+tg/mKW34+Qh5THlW+i+LW7ilwSjGod4oTZ7J8Abnlhefoq14li
	 c9EPbTFNfULQLpYijxRXWgrjWAPszmO1G0cGiw1xXePyje1m2p3zArUCoi/Ekql/Iu
	 R3Gfln2XV98dpDBw1CzvIU1mVGRODJabr4xi9d+ipN4RyA5xq5PaMmjFoHIzuu3tdy
	 CoxULU0Tt76XT/Gsfk09hDthBnGTvWHumNAWCrEWg399Qh5q91juzzvj1sZ2XXEAej
	 r5MwMGhG7pbBwG5qwNAw4S8xpTjArI8X5AamccLHnPcj0tqPqcjcqTk0qazWTfuCYT
	 yjq8IfEczfKNQ==
Date: Mon, 7 Jul 2025 08:44:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@axis.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: proximity: Add Nicera D3-323-AA
 PIR sensor
Message-ID: <20250707-curvy-fat-ostrich-00bc6a@krzk-bin>
References: <cover.1751636734.git.waqar.hameed@axis.com>
 <19a2744cebaee57fe5349986094168524baa9838.1751636734.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19a2744cebaee57fe5349986094168524baa9838.1751636734.git.waqar.hameed@axis.com>

On Fri, Jul 04, 2025 at 06:14:38PM +0200, Waqar Hameed wrote:
> Nicera D3-323-AA is a PIR sensor for human detection. It has two GPIOs
> for detection and data communication.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  .../iio/proximity/nicera,d3323aa.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


