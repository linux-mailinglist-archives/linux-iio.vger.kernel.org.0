Return-Path: <linux-iio+bounces-11872-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750979BA6A1
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F86B21B53
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB883187FE2;
	Sun,  3 Nov 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="WmOQ1duW"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB938185B7B;
	Sun,  3 Nov 2024 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730650995; cv=none; b=Zi/rA4OLGlUQ/Kkx0cYPc95ThXeRAzFJ2JSnb2dxBjgJ9hLD0gbwofvSS+9/PqHPDpKPenjAKGkCmf2PbiJ+FqGLCULdssSMaXq67YhxdV/1uVNHYcNH3NohsNAZFMYyLQYBsRa0Mh1oWb9DhTB92y5yC7A4302kwq+cqMTTO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730650995; c=relaxed/simple;
	bh=Th3OOXZJfsZuk7HXCZ7L6IU6s2r0I+j2t7q7eIgzWNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CctC7duLLFCKj3wLPN0KvOLiRsKs/5B1GFLHo37uloRMrpPVYIRWR0o+zWO6OWX1q82DdwmVpWcKVH6oGsYjvrswVJdSt+1Mj+3s3Glx8lBbdI6eL4Xo4a8gp+wxhjuhPSNb2ZrCIDFRAuWcm/OpWQvhdQf8VvZo6b1c5IO2m0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=WmOQ1duW; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id A69264C891;
	Sun,  3 Nov 2024 16:23:10 +0000 (UTC)
Date: Sun, 3 Nov 2024 11:23:08 -0500
From: Aren <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic with
 devm callbacks
Message-ID: <iyasbuxwpgqeeuaimcpnycrze3xg6u55uusfxnvy3i3k2ejy57@lbrrc7c3r4fx>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-7-aren@peacevolution.org>
 <20241103112208.233f7180@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103112208.233f7180@jic23-huawei>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730650991;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=je3uCAcHsGiyDOgvqOvzEM2tjCfi8IWbvFmZvz9katU=;
	b=WmOQ1duWnvM+PHINwEcVOHgkXZK4Gu49qiTEWLXeIMTTD/95JdSpVS0QcU3as8OuqLbPA0
	4vz3fZ7Jz7e2JgJIISbRBSCnHvGJhOECg4IO3GkWuibDZjDsncPb2JZgLwL/2Mah+Uj381
	pqrN4ROz0kl2cw9L99XRu7qgNhuCrGc=

On Sun, Nov 03, 2024 at 11:22:08AM +0000, Jonathan Cameron wrote:
> Hi Aren,
> 
> > @@ -624,7 +640,7 @@ static int stk3310_probe(struct i2c_client *client)
> >  	device_property_read_u32(&client->dev, "proximity-near-level",
> >  				 &data->ps_near_level);
> >  
> > -	mutex_init(&data->lock);
> > +	devm_mutex_init(&client->dev, &data->lock);
> ret = devm_mutex_init()
> if (ret)
> 	return ret;
> 
> It is very unlikely to fail but technically it can.  Andy has been fixing
> this up across the kernel (including IIO) so let's not introduce another
> case that doesn't check it!

Right, I'll take this as my periodic reminder to read the docs / types
more carefully :)

> If nothing else comes up I can probably tidy that up whilst applying.

That would be great

Thanks
 - Aren

