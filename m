Return-Path: <linux-iio+bounces-24882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6E9BCAD00
	for <lists+linux-iio@lfdr.de>; Thu, 09 Oct 2025 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 650493527D4
	for <lists+linux-iio@lfdr.de>; Thu,  9 Oct 2025 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCB3265CA8;
	Thu,  9 Oct 2025 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvJ9kd+P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC042A96;
	Thu,  9 Oct 2025 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760042111; cv=none; b=qVDPPjCXuNAQnE/qUrxPSIHGy8twP6AMkwLhvxNBdOZuhB81aEdUfQ6R2whF15FnRMuMdqhM3PMwOCc2bVvgTOo8SElSk6X8Ni9fM8s+HI0F6pnkuFtpsEBQ9uQ+MZO/kyyWZoQQ92EWsmONPhiI+tU8bAwN1XIkoCuIcF2nzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760042111; c=relaxed/simple;
	bh=5EGdkQ9M+B67tIEO7OIEuzLktBCbru/Zj3qD3AsMqw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GipZVjSch62lXl3+Dh9s67CBWeu+z5wUxZ90UYgLFJ6LWZXUBgjZeVxtJrpu25urOWFnpLP9yu7NPDZ7zVRIrWGS4HETzm0AFYUrVP//j/gCEYuna5fJe2+5XqnCvAl5zoZM5FkmWzbEY8mPnOdLtnXDCmhL/8BDs0dQBs9PmnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvJ9kd+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3B7C4CEE7;
	Thu,  9 Oct 2025 20:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760042110;
	bh=5EGdkQ9M+B67tIEO7OIEuzLktBCbru/Zj3qD3AsMqw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvJ9kd+PArpQ+PkpP8kxxg++fB/5hhW5qDUj4bfmscWBmIfK0Wz9p0SzA6CFDzMrb
	 XO9toCnEM+CaUhsZqL21sjHUOBLFy5lMwuCzCy5L4HohVhCQ3/wg9BYRE6Dnw625SL
	 cv1GnwCgeq2UQZ2M7/stFRNyPE7U4xjDEjUkWQHMiaMLNoHr5cXNU2KHhjUNaciga3
	 M+Q64CVlOOC4BFMYuAQNJw+zixDZLoenEFnMcotVqMKjBXgyLrTf3baMpptO+ZDico
	 ZpmAOQmk9r0jN71kErSTwnYxZfigPiRxYUNXwvJU2e9WbgOCfYrH/u8RnYVgM+4e/Z
	 5eNde4yAiACqA==
Date: Thu, 9 Oct 2025 15:35:09 -0500
From: Rob Herring <robh@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/2] another 'interrupts-extended' replacement needed?
Message-ID: <20251009203509.GA3296392-robh@kernel.org>
References: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006172119.2888-1-wsa+renesas@sang-engineering.com>

On Mon, Oct 06, 2025 at 07:21:16PM +0200, Wolfram Sang wrote:
> Hi Rob,
> 
> I want to fix the following 'dtbs_check' issue:
> 
> arch/arm/boot/dts/renesas/sh73a0-kzm9g.dtb: accelerometer@1d (adi,adxl345): interrupts-extended: [[18, 2, 4], [18, 3, 4]] is too long
> 	from schema $id: http://devicetree.org/schemas/iio/accel/adi,adxl345.yaml#
> 
> However, this series uncovers another place where 'interrupts-extended'
> is not recognized as an alternative to 'interrupts'. Namely, when this
> is part of a 'dependencies:' like in this binding:
> 
> arch/arm/boot/dts/renesas/sh73a0-kzm9g.dtb: accelerometer@1d (adi,adxl345): 'interrupts' is a dependency of 'interrupt-names'
> 	from schema $id: http://devicetree.org/schemas/iio/accel/adi,adxl345.yaml#
> 
> Now, I wonder if this also needs to be fixed in dtschema? Or do we need
> another way to express the dependency?

In this case, the 'interrupt-names: [ interrupts ]' dependency should be 
dropped because that's *always* the dependency and the core handles it 
correctly:

dependencies:
  interrupt-names:
    oneOf:
      - required:
          - interrupts
      - required:
          - interrupts-extended

Rob

