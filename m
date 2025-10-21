Return-Path: <linux-iio+bounces-25332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 262DCBF706F
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A3518942A8
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 14:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD22749CA;
	Tue, 21 Oct 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xeut2wRk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D327822FDFF;
	Tue, 21 Oct 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056492; cv=none; b=o9uM35Nd3OF69W7TxVmvg3W6SXSfJoKJY5WO6SX433YxUCtU2yBZ4O2XEsLAxQfV9j/fof9fO4ZCb7OgK0EODL7NkUDpdZVkLpXdKDVsB38pzWyQBREPzBEIgjK2jDKukt5r/rA16tT9UHGDBX9ezrErkDZSq2AtfJydDlIjGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056492; c=relaxed/simple;
	bh=SXu2kCneESoXCkpfGtRLyiuYbh2vZwF+jNxVAoF42Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAF1LfIkwsTo5DK6O3ViQ8H3vOEt5+Ictz2udGtFNqY62609I2LphtxQ5IbsoIdkwm3QztOhFHGPxoiIqKC7EdRAA3H6pEJmoJZ3rKQPs7GjWSOCbmxQPvamQJOx6uKtdIRlsbDSr3D7iIsZjat42b0um/xiDIwTjsaF7dfub+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xeut2wRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391B4C4CEF1;
	Tue, 21 Oct 2025 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761056491;
	bh=SXu2kCneESoXCkpfGtRLyiuYbh2vZwF+jNxVAoF42Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xeut2wRkpHOhdNj2qnGiB5GhnESam4Ne9KqRd7Lds9PUSsdDTumIeJBWhU64HjZVp
	 pAcRFJJjJP6qDARWnfCG8AvOndFwLqPxCgfo/1b00AMApZ8+vAHnCC7LpwQbZyQa/i
	 T6oNstpEy0y/s4lit/fg5thHOfX+OiDTXL/u2VfgmsG/Ldx7erNpqqhXg3T61f6gAF
	 7ORCf2cNVRpL7iemjQo6Bjc9I6uyOfyIkVv+R029+X7yiC3ri0dBPwVIhm+fw+3Ovd
	 dz64QO4ZazG+PTB6Sg+zoNxLRGvy0/YLIftMSrwnoh27n/v88b8HobZV9uY1ke+mvT
	 YsEHJtjx/wNZA==
Date: Tue, 21 Oct 2025 09:21:29 -0500
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
Message-ID: <20251021142129.GA34073-robh@kernel.org>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>

On Tue, Oct 14, 2025 at 05:02:11PM -0500, David Lechner wrote:
> Add a spi-buses property to the spi-peripheral-props binding to allow
> specifying the SPI data bus or buses that a peripheral is connected to
> in cases where the SPI controller has more than one physical SPI data
> bus.

Is there a reason why spi-rx-bus-width property doesn't work for you? 
The only thing I see would be you need to define the order of the pins 
like "data-lanes" property.

Rob

