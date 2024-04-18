Return-Path: <linux-iio+bounces-4331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1C8A9E1D
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 17:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDF6B21FFA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Apr 2024 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D0316C457;
	Thu, 18 Apr 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCuA+8Od"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA973B18D;
	Thu, 18 Apr 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453413; cv=none; b=fG/AWbHQdXoUb3M1DTtFEkkIIBk8Ub2rDYd8twVQLSx3ZI1UtH67MdZfpVRog7JqVAg7dt+QHb9JSEAo/Rf1TcGRkyE1v2wCoXMoYkKBZ/Eg5NLZxkTBm4LggJC5eLnvelKTaPqocp0chUxzZYQqwjoWg1SwSq08MVLPvYqyWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453413; c=relaxed/simple;
	bh=gyqpke4mdKN6g/7pEOb9Jx/mf5rRpnQ/SSaor2er6W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIQzdZD09ti9nZgI+gL6FKRYQp8K3G6NwewRxqf0vWTaAXkDjVVnJi22J+37N+YX0FQky1KdRoek6HvuLg87vPzaqQ7YJr7k7YzryP1IxSaNgWfv/u0SSFxbEd0kPWt7AWn/cXfgdNmwafno9WtB81jRg026qS+NK6hUZx7AR50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCuA+8Od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CDFC113CE;
	Thu, 18 Apr 2024 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453412;
	bh=gyqpke4mdKN6g/7pEOb9Jx/mf5rRpnQ/SSaor2er6W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCuA+8Od8TZUPQvN9vUEYKLAUgNIPe/pf1nrCBKQ2WGAOH/N+eJdU2fr4Gs9Xt+oA
	 VrL7JLUd1+WWGwmbMPKEtFoL1qi/PDDI0PmYzvtF4CSfbor4+M1viguO4GQKPinvqA
	 TtZHKzwRB420GAUh3IsoQg8FRqizawF0r73+iqyoj0znCyXA3ePU/nuWSREHDfQGh6
	 5zywLrZEVPIbD3QfjRrQSRXnHqLZATXHGlU5GYDtSLMCgLSFyk8Ki7XY+bqbBWK9xx
	 kZ5rEko5wG2tu0RB9YSKURjF0Vdfk6ZpW2y0RMnQabLN0Ss9t1AqPWwbHRN7ByI4uK
	 jEB9d2Ux8DYmQ==
Date: Thu, 18 Apr 2024 10:16:50 -0500
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, p.zabel@pengutronix.de, sboyd@kernel.org,
	mturquette@baylibre.com, samuel@sholland.org,
	jernej.skrabec@gmail.com, wens@csie.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add GPADC for Allwinner H616
Message-ID: <20240418151650.GA1824475-robh@kernel.org>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
 <20240417170423.20640-3-macroalpha82@gmail.com>
 <20240417234957.2fcd14bb@minigeek.lan>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417234957.2fcd14bb@minigeek.lan>

On Wed, Apr 17, 2024 at 11:49:57PM +0100, Andre Przywara wrote:
> On Wed, 17 Apr 2024 12:04:22 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:
> 
> Hi,
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the GPADC for the Allwinner H616. It is identical to
> > the existing ADC for the D1/T113s/R329/T507 SoCs.
> 
> The H616 is using the same die as the T507 and the H700, and since the
> T507 is already mentioned in the commit message for the original
> binding, I wonder if we actually need a new compatible?

For same die, I would say no you don't. But adding a compatible is fine, 
too.

Rob

