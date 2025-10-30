Return-Path: <linux-iio+bounces-25682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5296C20628
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0099B4ECDA6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD722E406;
	Thu, 30 Oct 2025 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npp8d30E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C5194A65;
	Thu, 30 Oct 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832289; cv=none; b=mT+gRXNTyJjcIumiUBWeus/LxpsD7pNgYoOu2+oELTvzD4X02+TsrMhHGqVHlvW5CHomZfBxcon3xUP0vZ0O/BbCHsvFLZN6vveGQC2ZAbNqh/CV3lSZmoUzmXsHkY73NY/s3C5UGzMFbVFO2yBlsg+VLyDB+48xK1ukoN10ZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832289; c=relaxed/simple;
	bh=6VPqUQyQcSRQKEXeyerD21USQXJN+lundDeK7TpzpYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dm6jKsaIPhGr5yVeu/ykVnLsdM1EqiDI0xw3OXCCmXOoLWfdOgtiz8pSsLza+u9vo+gzxcFTL2Xtb36KDThmHL+ARZ1KyttZYwz630guuqAxxwplGyLxb++JWD0exTF1EUjy3rzwp0KT+qeMyNzuBrdUoDz/sIr45jNFEms9bCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npp8d30E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493AFC4CEF1;
	Thu, 30 Oct 2025 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761832288;
	bh=6VPqUQyQcSRQKEXeyerD21USQXJN+lundDeK7TpzpYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npp8d30ERa7Ss6871jkOdtpPHu+a13/I8PlGf4cofbr+Bi+PQ6dxJYT8lWaZI/ukr
	 JkbSAWOObhxx8ecZzSMhYCjGOYaevrRVYnMvPFb7IBKYZxki06VsTwJhSUpmJgvcBD
	 ORJiY1c/nu1GXwLG4EAWo5O7CFIWIZPH0832/UILOzMseFfomrUqGvkTARhDSbRtHW
	 s6QCUxxbmENjR8jVwZpxOjfOccA1mAhlF1kN6begFoOVO4Ybndp6Yvv11jrLhjKuYI
	 vPCLU49/L/ExjKdbFF5wREtUrJFB3CaxJBht/uZyvBF+Ez9h47RTrIYPugbXKukRlY
	 9afaeLexMegOQ==
Date: Thu, 30 Oct 2025 08:51:26 -0500
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
Message-ID: <20251030135126.GA3749313-robh@kernel.org>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
 <20251021142129.GA34073-robh@kernel.org>
 <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>

On Tue, Oct 21, 2025 at 09:59:22AM -0500, David Lechner wrote:
> On 10/21/25 9:21 AM, Rob Herring wrote:
> > On Tue, Oct 14, 2025 at 05:02:11PM -0500, David Lechner wrote:
> >> Add a spi-buses property to the spi-peripheral-props binding to allow
> >> specifying the SPI data bus or buses that a peripheral is connected to
> >> in cases where the SPI controller has more than one physical SPI data
> >> bus.
> > 
> > Is there a reason why spi-rx-bus-width property doesn't work for you? 
> > The only thing I see would be you need to define the order of the pins 
> > like "data-lanes" property.
> > 
> > Rob
> 
> Because we can have both at the same time. In one of the other threads,
> we talked about the AD4630 ADC that will require this since it has 2 data
> buses each with a width of 4 (total of 8 lines).
> 
> See: https://lore.kernel.org/linux-iio/ad929fe5-be03-4628-b95a-5c3523bae0c8@baylibre.com/

But it can't really be 2 independent buses/controllers unless the ADC 
has 2 completely independent interfaces, right? Surely the clock is 
shared across the 2 buses? So aren't you really just borrowing pins and 
the fifo of the 2nd controller? That seems pretty controller specific to 
support that. For example, how would you support this with spi-gpio 
(obviously kind of pointless given the bandwidth needs with 8 data 
lines) or any 2 independent instances of SPI controllers?

Rob

