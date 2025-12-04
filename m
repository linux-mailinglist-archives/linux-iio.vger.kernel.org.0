Return-Path: <linux-iio+bounces-26772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE0CA57BA
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 22:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6BE03161975
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1440307AC0;
	Thu,  4 Dec 2025 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCO0ikji"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331A2E6CAB;
	Thu,  4 Dec 2025 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764883758; cv=none; b=grATss5OIRcjAeSpzOuVQQNXJMBoBZ1OU/sZr1aOk8jMmbpCuyyuJYaojJGgaq8KeDeoqf0dywPz8wRwRpxIGiNpLvPPGKEc7qr5bER99IsbQE7JLOIqtbSGXNo6Zn/Nfhu9C3Z2B8UsFqtpsOhFZHx/tdkeQ4RiivXa+dZOWUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764883758; c=relaxed/simple;
	bh=oocxMjxMjTss2VcOTrnLB6cdCxr9Ue/IeYlg1RPPXP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh0iejrO+UfHkfe0H1iyYENikPCr/sAJWgR8xWgTQleDBxaz96LdGQAYFDNIUnsBes2V+RKQLH0iFCjKEXyEsFYNI6BCjBpvy3vo8TeUDBNXMbOA891h8jUUmIuRwUeK13p9DNPEfiWelq42yHeI7hrsNgETitim9Nr4FQU5I9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCO0ikji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B88C4CEFB;
	Thu,  4 Dec 2025 21:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764883758;
	bh=oocxMjxMjTss2VcOTrnLB6cdCxr9Ue/IeYlg1RPPXP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCO0ikji0XouCXODfe7LrgEdLmYzUO33hEKVycu0yCAtqz+/oSy28wAu9p2fteKe5
	 wxKvxz9HD0cm8LVQlySd6nS3PGAZn5CsXeAFeoQweZ3Eru7OhDkMS4no1tnIGW1k8F
	 fSkS+1kkhXo6k/GkRRbutajF9j118NwGjGDwNRfQ8wosC+Ii3yIMNT/DbRXylBXMSv
	 Ab2vnp4XZqJYAW6ReDsUxrwWWsxJZZlrA55jPvmjU4NDvUHTEcVXoePgN/bgx+EdUO
	 yaVZJ5F7wPVezOnuFhZqsTmrwxO9BUi8scNTIjXnofb2UM7UzIJGdgSg5e5W7MUW3Q
	 MwF9sVNMKyTkw==
Date: Thu, 4 Dec 2025 15:29:14 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 1/7] spi: dt-bindings: Add data-lanes property
Message-ID: <176488375440.2197316.17479968032576108743.robh@kernel.org>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-1-34e05791de83@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-1-34e05791de83@baylibre.com>


On Mon, 01 Dec 2025 20:20:39 -0600, David Lechner wrote:
> Add a data-lanes property to the spi-peripheral-props binding to
> allow specifying the SPI data lane or lanes that a peripheral is
> connected to in cases where the SPI controller has more than one
> physical SPI data lane.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> v3 changes:
> * Renamed spi-buses to data-lanes to reuse existing common property name.
> * Added to description to clarify index is peripheral and value is
>   controller.
> v2 changes:
> * Renamed property from spi-buses to spi-data-buses to make it clear
>   that we are only talking about the SDI/SDO lines and not the entire
>   SPI bus (SCK, CS, etc).
> * Fixed prefix order in subject.
> 
> This patch has been seen before in a different series from Sean [1].
> 
> [1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-2-sean.anderson@linux.dev/
> 
> Changes:
> * Added maxItems. (8 is the most I've seen so far on an ADC)
> * Tweaked the description a bit.
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


