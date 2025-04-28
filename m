Return-Path: <linux-iio+bounces-18783-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F44A9F524
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 18:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F016B938
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9389F27A12E;
	Mon, 28 Apr 2025 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmjY4p1q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C5190072;
	Mon, 28 Apr 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745856394; cv=none; b=sxI1jtnwJh3gra5hKiMPlyjIHVgwO1HDNW9ie7CNCutt+EN2+Nmg6GHmE7V6OEZToZ59uaZvaQuLRe5QJR9D1eykT32oAKzqKwkIwl9Cuk4d/xwzl3urG7QP1C47/q7hMD1NMlsmIhq+lsSRIGNbgv25LeI5j59uCN43KyK1Utg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745856394; c=relaxed/simple;
	bh=1WYVe/VjapenVaazm0EvP9kf7bRJttLvS0GezfpZhwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuI20Hb7j/bC+iIh+GwBx2T13gAHvBw28Mj+R+zVIGbEFvezgZnUjzS2Opqrg4mrVENpUPiQQfx+yQuKMLMesHub8xnNpoXTei8Wgml8w3r4BpNXLUC8Dym5GvF7p3WmbgAFxqgrkyqpUCLUyXWTGm/wWYwvB9JE0RyInoK//Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmjY4p1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8579AC4CEE4;
	Mon, 28 Apr 2025 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745856393;
	bh=1WYVe/VjapenVaazm0EvP9kf7bRJttLvS0GezfpZhwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmjY4p1qWfDzVHjZvYGWNk7BSzmtA/LHu9QexMEwiSlDZ7CCjCSqATdIf48y9Gp7p
	 fQOE2DntxM6kW+zu0HMxqZtBB+voUwZRWTxDVcz6XVPvGZ0OTcil9P0ymU8XYOAXVy
	 yu1WPdfr4ISwOsLS77ErmmROOMqmlf2D9oRs0pCHLa5p99iP/JAyRk6jhFdUBODdbk
	 +7duJOcnGLNKXocHGHLH6Gu+B1atbNIvUK+/219gK58JsQXEQSI3ol09SFpLGk/V5y
	 SJpll3IPiZBLVvy8PrANJJzUeddnaMoFJW4RvYtOCbtumjBWs1u+myM6sgi7Um+p2I
	 68y6/qAj30lTg==
Date: Mon, 28 Apr 2025 11:06:31 -0500
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Siddharth Menon <simeddon@gmail.com>, linux-iio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2] iio: frequency: ad9832: devicetree probing support
Message-ID: <20250428160631.GA1353496-robh@kernel.org>
References: <20250322163211.253009-1-simeddon@gmail.com>
 <20250416185846.GA3735440-robh@kernel.org>
 <20250418152621.70c9511f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418152621.70c9511f@jic23-huawei>

On Fri, Apr 18, 2025 at 03:26:21PM +0100, Jonathan Cameron wrote:
> On Wed, 16 Apr 2025 13:58:46 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sat, Mar 22, 2025 at 09:58:11PM +0530, Siddharth Menon wrote:
> > > Introduce struct for device match of_device_id to avoid relying on fallback
> > > mechanisms, which could lead to false matches against other AD9832 variants
> > > in the future.
> > > 
> > > Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > > Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> > > ---
> > >  v1->v2:
> > >  - updated commit message to be more informative
> > >  - minor changes to code formatting
> > >  drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > > index 140ee4f9c137..7d4f655f6df1 100644
> > > --- a/drivers/staging/iio/frequency/ad9832.c
> > > +++ b/drivers/staging/iio/frequency/ad9832.c
> > > @@ -431,6 +431,13 @@ static int ad9832_probe(struct spi_device *spi)
> > >  	return devm_iio_device_register(&spi->dev, indio_dev);
> > >  }
> > >  
> > > +static const struct of_device_id ad9832_of_match[] = {
> > > +	{ .compatible = "adi,ad9832" },
> > > +	{ .compatible = "adi,ad9835" },  
> > 
> > Is there some reason we can't add a binding for this?
> > 
> It might take some thought on how to actually describe some aspects
> of this device that aren't yet supported by the driver,
> but in principle we certainly should.  For drivers that have been
> in staging a long time I'm a little reluctant to do merge a binding
> until we are fairly sure the driver is going to move out of staging though.

Okay, I suppose I could exclude staging from looking for compatible 
strings.

Rob

