Return-Path: <linux-iio+bounces-5118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51318C9561
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 18:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755CC1F211C2
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844345BE4;
	Sun, 19 May 2024 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDolRsKn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259B8BE0;
	Sun, 19 May 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716137896; cv=none; b=FUgoc4p7xHgAf+xWJNyOa8zpPZqvVIUGSzV8Tu5V10h6vo/aWjdfXqaEwu0nA9k/DN6VubHMDhxH5okwu+aSWU/o2LPYHjYsfUG8ktS+3AwGr3khn7b4Z2zlhO5rnnSTA/qU26+Oye8LQMnK4+T9AWpoxquCgf5F+YqUCZ/STCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716137896; c=relaxed/simple;
	bh=Cfoes/lsrzIeaqNypbBmxhOUBPcXRxD7h5OWjdIY+V8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aguLZ+3dsabdXri/2g7M+2gIK1t+j3ucrifVD2bkbZWABUMtiZ5dzndM6+h0R6BwaSEp3kkNumwDrHCy6mPt0a+VvaeTUU22qo2wMVSXjS4iEOvkgXtjKhbouLi/ZehdyCqTC+MZm8C/gANeRifXx31ly7KR7f0bwTv6dG/QuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDolRsKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8811EC32781;
	Sun, 19 May 2024 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716137896;
	bh=Cfoes/lsrzIeaqNypbBmxhOUBPcXRxD7h5OWjdIY+V8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDolRsKnX4UjKfRWGxWIFCAuM1w/U0MRQtJrmU9VyqcAGkDzQsVwV8yaXujFqlrCk
	 ageleoHvVTonAPGpE6xCOGCJkAKXqOJBy16gzPJpQyKI0K0Lfy5IYaCqdgHbmV2cqT
	 CJtbHJhDrgW+7u9xjriCxb/lfOc9MXR+wa6/T05VS4DOO6pdI8wvcSv8GjLE/Vljk8
	 TaJx0Rxou/3J2AXpR+OtA1+Sw7Ka8R34D502UbqnPYUDxpXyuQ7E3pUvRigAHGe+2Q
	 FrVxCD/g++XBjfVqgQFe+VKQAM4jK0PP81It2m+xwMmpxaeLTf5lLr2yhnZ+Eig+0R
	 duOC1/j+WwZpA==
Date: Sun, 19 May 2024 17:58:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 3/9] iio: adc: ad7173: refactor channel configuration
 parsing
Message-ID: <20240519175802.6ee5b46d@jic23-huawei>
In-Reply-To: <20240514-ad4111-v2-3-29be6a55efb5@analog.com>
References: <20240514-ad4111-v2-0-29be6a55efb5@analog.com>
	<20240514-ad4111-v2-3-29be6a55efb5@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 10:22:48 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Move configurations regarding number of channels from
> *_fw_parse_device_config to *_fw_parse_channel_config.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/all/20240303162148.3ad91aa2@jic23-huawei/
> 
These are all part of the tag block so no blank line here.
Having one will break some scripts that parse these blocks and


> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>



