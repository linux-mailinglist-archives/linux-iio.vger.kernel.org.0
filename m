Return-Path: <linux-iio+bounces-4378-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21698ABAF0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CCD1F21C3A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02417BD5;
	Sat, 20 Apr 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT3+ivAw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68CEAE5;
	Sat, 20 Apr 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713607849; cv=none; b=YNeLDafNzPwekhx66cJj4FFCO+SKRVSu0lqpYhaPiV5sFOXFD+CmBk4NmfKvEQFgbz/I8f/DgVwvzp1KSGt0p9aO8rdbbD+lgKaC1p5QcKJ6w8lYOgdSnGthAC7NX84ytHoJ/PUBuFsesB55BklfbG2viSt+ZqyQv6Lg/5IBxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713607849; c=relaxed/simple;
	bh=uk0pVEWCGbr3TBbjkduaSqh9FacH2xhZgqD7X6xJQUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaHXmCIHmjaDsTnUbEQ6c4uDquMzfKCoTPqdCAB+4vV8VYGRD/IedLpicO6AHyZp3CHq4W6qUwwAOldv6QSKoTne7OVVVISC+g3j1ZOO6jC4VFJxn85WMzq/H0+B8i6+++Xys5k8tSs5Y0mawHEEszkGQJjJLtsYlrUrzEvATVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT3+ivAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720D6C072AA;
	Sat, 20 Apr 2024 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713607848;
	bh=uk0pVEWCGbr3TBbjkduaSqh9FacH2xhZgqD7X6xJQUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AT3+ivAwM9+Gvs9pmXWfbISAc5nlQtPxhT5HzkTQm090zDk0692NY2InqWSh0HGLq
	 Yrd6r3ct9lkGhZM3s6hdIJqVEH2/ahZ10Wyz7YDXTpTnB90RpxtcPo23EYbXosZA7u
	 son/yySLzsagddbwelMaqyZKOSlxa9Xz8dd7dd22GmmArY5f3ounV4VaXYLL5yfBNx
	 WEEO3D+6qmGBcm4tNZ1Hc1MB8be0PIaRR8pYVRvs60jzyOj2QRYUwcTK4rtfFuilDT
	 PSI5CZzqguFtLBmJU+kFjhMXkyWXnwgrl+M+ib6tJkx/TvL8J4v7pwpu+e8HNLWukX
	 7NOh1Ip88Ysfw==
Date: Sat, 20 Apr 2024 11:10:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, sboyd@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-iio@vger.kernel.org, Chris Morgan <macromorgan@hotmail.com>,
 wens@csie.org, mturquette@baylibre.com, samuel@sholland.org,
 linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com, krzk+dt@kernel.org,
 p.zabel@pengutronix.de
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: Add GPADC for Allwinner H616
Message-ID: <20240420111032.5d9d94c9@jic23-huawei>
In-Reply-To: <171345342441.1843687.15293376169534019509.robh@kernel.org>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
	<20240417170423.20640-3-macroalpha82@gmail.com>
	<171345342441.1843687.15293376169534019509.robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 10:17:33 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, 17 Apr 2024 12:04:22 -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the GPADC for the Allwinner H616. It is identical to
> > the existing ADC for the D1/T113s/R329/T507 SoCs.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  .../bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml      | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >   
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> 
> 

Applied this patch to the IIO tree.

Jonathan

