Return-Path: <linux-iio+bounces-27531-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B66B2CFED47
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E17B63247306
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31DD366DA4;
	Wed,  7 Jan 2026 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgAKDX7H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF9BA3F;
	Wed,  7 Jan 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801446; cv=none; b=fl0NhgHir7EbLIe98o0LuaFeKc9f948B6UDH17wGUDi7rwZoMzAv2tSE61pLzyIPYegh64rU+7ucXBQ4+rZKHEweXQ0HGbUm1iMWc6vVRCCBXvUFsf2TOfeNEDr8sA+g0M+aCrosrN3NpVwI/yRVGMwIzXa8gWqKhoVD6c2m9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801446; c=relaxed/simple;
	bh=xWOFtg32OZw8Y8y9UrYrW6PJ2bzQbnugFJ29Z89+cnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjxC7r/KSmPBcOZmXFuFpQYf1RND+RietPKtoCJP8m3UDBMBDYYMjyON60xfKxT0XT6qKRhFZEjC7nToYssYBLk0qsOZ9JhtKeZgweQFxeWZSWvKn8ABKlJPc3NDm8Ob6UwkegpIzgqYN8QtwGtuCKZPPwuan9Ut5FbDYtU4OdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgAKDX7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD0CC4CEF1;
	Wed,  7 Jan 2026 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767801445;
	bh=xWOFtg32OZw8Y8y9UrYrW6PJ2bzQbnugFJ29Z89+cnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgAKDX7HaH5WXezhfMQ8mA48bStcgu6CsBZN0QDdU6QBpfQt2dJ/Mn8Ch7ZqpzYuN
	 sG4Wa/LRWWD+cVeivB199Ig2x7dnNTdQzIflHQqr/eulvx5rUYAweEYEwK2+jSjGcZ
	 UG/lWNnZTZ+r0Gg1ad2u/mX7bXajAmg4wZEuxF6vDLILa/+wZV0wft6NicZ3ZP4jiG
	 pDqyEcXzr9C7Z96up6qgIIfEwjjqILtS4Z/LE/G1vt6t31uvAQcAs+XbTtZrs1UiQi
	 JHco+PTQ9R9uauskHFoD1dRSKhwvF6c1QAg/FbyZ14sVUpz6wdRvaP1Y8T75Q2OFFg
	 8bS7fRv27GQaw==
Date: Wed, 7 Jan 2026 09:57:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH v4 2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map
 properties
Message-ID: <176780144202.1197510.11558178510570306104.robh@kernel.org>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-2-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-2-145dc5204cd8@baylibre.com>


On Fri, 19 Dec 2025 15:32:10 -0600, David Lechner wrote:
> Add spi-tx-lane-map and spi-rx-lane-map properties to the SPI peripheral
> device tree binding. These properties allow specifying the mapping of
> peripheral data lanes to controller data lanes. This is needed e.g. when
> some lanes are skipped on the controller side so that the controller
> can correctly route data to/from the peripheral.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v4 changes:
> - This replaces the data-lanes property from the previous revision. Now
>   there are separate properties for tx and rx lane maps. And instead of
>   being the primary property for determining the number of lanes, this
>   is only needed in special cases where the mapping is non-trivial.
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


