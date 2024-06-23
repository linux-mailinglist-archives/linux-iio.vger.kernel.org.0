Return-Path: <linux-iio+bounces-6753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC39E913B8A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E922817AF
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 14:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6474F181D05;
	Sun, 23 Jun 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9aitzc9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66F181B86;
	Sun, 23 Jun 2024 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150661; cv=none; b=g61xvVM2kyjimAQ8sG7JuIglmL1l/Ig277EsjjqHO5FlT13vOyPC25ToPTHF86tEM6e96WGkMTwktuG5GeCeWxLECsSbQSJSVz6evNjHTZKehPooZFaSIIHlMjXfHi8vzG1Q434HH4bIrXQuH4m5rp3QXE336yOZSdu+qVpWsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150661; c=relaxed/simple;
	bh=tgB2Kc8fpHmrItwtmn2wGL1DjsrQKrBO78BJIpjdNeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ow3DN78XpEF1rbKX12Tpc8svvK9Aeqe0W4CVU1yxVctpMEkzOO9d/PiePdFzAIWPDNHtqTbiMWUAoFDhL8fTnm7roaOrV3GPOIdiVWDflsgH+SbrBSb3ykzuNs6vHEROYRSxJe6n+X4EskpMKORY7d4B5xCrCI6OFM+p4jnnOS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9aitzc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A285BC2BD10;
	Sun, 23 Jun 2024 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150660;
	bh=tgB2Kc8fpHmrItwtmn2wGL1DjsrQKrBO78BJIpjdNeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q9aitzc9mekp9bK+jMGz8Dtcg2j++TVyQpDqPFTm3Q9JfVtUDT7sScqT1VG4jF6Vi
	 xTRWoh9NmDvQ5helpOr6HZkdogv0yzqSCIM4549WjxEj9H5d/9xXwWvtZJL1mpMFZA
	 asLY5RtHc93HaRl8UM59+ggrcVoClfiDbqIIOlQP/UtEjXzsx+kNQUjQt8YL1CW19+
	 3gbDfO7YAlWHCSLhPdfcz0i3LR4B8RuGyh1s8IAMAgHV2Tx8K3pG6Ncp/wfDYwSx1E
	 +vIn+idr264ZNLZHg1SToE8KysVAuwFPa7Bf/bxIgb9P33IraafZiWYG0piC1N2CcZ
	 eK18aO9P5H/ZQ==
Date: Sun, 23 Jun 2024 14:50:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael Hennerich"
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
Message-ID: <20240623145050.09cc3bca@jic23-huawei>
In-Reply-To: <20240619064904.73832-6-kimseer.paller@analog.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	<20240619064904.73832-6-kimseer.paller@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 14:49:04 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> LTC2664 4 channel, 12-/16-Bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 12-/16-Bit Current Output Softspan DAC
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Other than oustanding questions on the binding this looks good
to me.

Jonathan


