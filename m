Return-Path: <linux-iio+bounces-12110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC7E9C351E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 23:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01256B2118F
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 22:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E59158D79;
	Sun, 10 Nov 2024 22:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="JCoGsG4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B70149011;
	Sun, 10 Nov 2024 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731278283; cv=none; b=suiNM6bJiTVqTIdgyoEAS1F5o5gHeoZ9fnyBtZZVTvW5ENgv4qKcCqmYzYtVHsm5UjJI0rZj6ZTiEnKUO14WRDB9DXflExo3uXsFXloxcOx7cLAHTWaKxoUPYDB+0yvj2CZXK5i/QEGMZQ3rTdJmwmdcm9mXujvDTBSw5togOOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731278283; c=relaxed/simple;
	bh=9hkl6dXSpQpYY3J+vmbhVG+9S37EpWR2G7m6e5A7ATQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/qHrU41A7HqegoEOmeYCLv4f0us9H20JT6OpamElCxqgqEDOzQ6YkGR92GsUxW2AZZAHY1aiZGfNt3x0IRniX7+ZPDuTfdmXjNLmJeHlewQ69oDZrX4TTGuaCs1rb0h2fR6coB7GYdrmXcagqSR6xACwYgn/NOrHIi+JlWeRBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=JCoGsG4K; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 9861E4C954;
	Sun, 10 Nov 2024 22:37:58 +0000 (UTC)
Date: Sun, 10 Nov 2024 17:37:56 -0500
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic with
 devm callbacks
Message-ID: <qqk4rbx6wxr7vofepk63yvuimavafbiy2srkqx2zvl2kxttlrk@axpphmdxffis>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-7-aren@peacevolution.org>
 <ZyiGiK6bSd_d0VQ6@smile.fi.intel.com>
 <mlvzaskgxqjfu6yiib2u7m3pczsifsluc4mqnzy6w3xzxblvm6@xrxvvruzftn2>
 <ZzEOqC9dAHCRX5a9@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzEOqC9dAHCRX5a9@surfacebook.localdomain>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1731278280;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=mxdzehp9E1yxMOm96JOXj/7tzWysSA5vOI9pS4TNxug=;
	b=JCoGsG4KLKcpc4jAcywobkNkrZK3tdmgMdqJpCz10h79Xv0fvSFkWe2uMcpRrIr5S59UOn
	urWG6uJB44+OePGrN6eLIyXkcUYf0Rn4MFnQgtS54HNmEivIPX/8PQdkOXzs6ZsbAS6b7n
	RMuK70nMMwGFCx88FZJ9flsKH8Cvf88=

On Sun, Nov 10, 2024 at 09:51:04PM +0200, Andy Shevchenko wrote:
> Sun, Nov 10, 2024 at 01:38:39PM -0500, Aren kirjoitti:
> > On Mon, Nov 04, 2024 at 10:32:08AM +0200, Andy Shevchenko wrote:
> > > On Sat, Nov 02, 2024 at 03:50:37PM -0400, Aren Moynihan wrote:
> 
> ...
> 
> > > > +	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);
> > > 
> > > Why not simply 'dev' as in below call?
> > 
> > I was trying to avoid refactoring the entire function to replace
> > &client->dev with dev, I'll add a patch for that to the next revision.
> 
> I'm not talking about refactoring, I'm talking only about the lines that you
> have touched / added.

Ah right, this one makes sense, my comment should have been on the next
patch in this series which is a little more complex. For that patch it
seemed inconsistent to use dev only in new code and mix it with calls
using &client->dev.

 - Aren

