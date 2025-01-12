Return-Path: <linux-iio+bounces-14157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17FA0A852
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9639218879ED
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 10:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF3319F424;
	Sun, 12 Jan 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huESVWRE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AA1A8415;
	Sun, 12 Jan 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678563; cv=none; b=ZRr+DiNds5b3kpLZOPnq0A/Nde9qhjSr3Goep/HPzpiSh/AnoyNwl7mcssSnYz6ycPPK606cS42wxD6KId2Av/yJ7tgY0YxP3CGYidwiiYaPqFQsPvSueWMIkg4fkJ61lQI5oRTSIbrtJol6TKdXDc6RtjApNgf9yVqXwMRbVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678563; c=relaxed/simple;
	bh=N5d+VxoaohPXvZgUowU3AklVmznYeFkCse1WzEZ/s/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhH8jW3SCjSvljXAfkZnVrVdEBLQZ3lyv9zCfo7iKZgDMGiVeDICb1krAt+sJzDmAD5fIMjkADMTeO7+0TeGGbR+w1RekOn0s4j2YKfKkm+kEAZHOHtCesw2OSBrcZGAv2K8SvFMBP0sy+2xsKJ6ZkTku4qH4/TdrdxBAV3L0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huESVWRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8DDC4CEDF;
	Sun, 12 Jan 2025 10:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736678562;
	bh=N5d+VxoaohPXvZgUowU3AklVmznYeFkCse1WzEZ/s/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=huESVWREOz9/b6JYWhoAxSQaVz7Z9uB4AUz1HnaNCZomoL3kJfuZnk8K6gmJaXzIR
	 /LaTQOWdS/52gQn7QWNT8iDAdxgB9AYU8m8ak7zXd9fKWOp2Jpkfr36gdljenho8K9
	 XdG7cT0HZ4zfQGEEVsmfPmj6tKOXVA6BzL/A6MAgx0xtbapUFG/r0H9zR1ymglDfbp
	 eivjOeePa+g169RTWaBdzESBO0amiaG/VZYbDdhRsWV0IGVhK1oWZovS8TbK9LOTSR
	 aN3Ln239zADxzxezRJLR6q8m90tSEUW7cZd49d3K5wwslmGnOvCa3+a5c9Z3lD8hFM
	 FxVs4DSeozjpA==
Date: Sun, 12 Jan 2025 10:42:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Markuss Broks <markuss.broks@gmail.com>
Cc: nekodevelopper@gmail.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: accel: mc3230: add OF match table
Message-ID: <20250112104233.593beca0@jic23-huawei>
In-Reply-To: <108b1eeb-7e95-491e-83fc-bbd061697222@gmail.com>
References: <20250111-mainlining-mc3510c-v1-0-57be503addf8@gmail.com>
	<20250111-mainlining-mc3510c-v1-2-57be503addf8@gmail.com>
	<108b1eeb-7e95-491e-83fc-bbd061697222@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 01:07:44 +0200
Markuss Broks <markuss.broks@gmail.com> wrote:

> On 1/11/25 10:11 PM, Vasiliy Doylov via B4 Relay wrote:
> > From: Vasiliy Doylov <nekodevelopper@gmail.com>
> >
> > This will make the driver probe-able via device-tree.
> > While the I2C match table may be sufficient, this should extend the cover
> > of this driver being probed by other methods.
> >
> > Signed-off-by: Vasiliy Doylov <nekodevelopper@gmail.com>
> > ---
> >   drivers/iio/accel/mc3230.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
> > index 48787c0494ae6f0ef1d4d22bc5a4608035cbe123..3cad6f2d7a2a79df38f90e5656763f6ed019a920 100644
> > --- a/drivers/iio/accel/mc3230.c
> > +++ b/drivers/iio/accel/mc3230.c
> > @@ -205,10 +205,17 @@ static const struct i2c_device_id mc3230_i2c_id[] = {
> >   };
> >   MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
> >   
> > +static const struct of_device_id mc3230_of_match[] = {
> > +	{ .compatible = "mcube,mc3230" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, mc3230_of_match);
> > +
> >   static struct i2c_driver mc3230_driver = {
> >   	.driver = {
> >   		.name = "mc3230",
> >   		.pm = pm_sleep_ptr(&mc3230_pm_ops),
> > +		.of_match_table = mc3230_of_match,  
> Should also be alphabetic over here.
Why?

I'm on board with reordering this to be closer to the definitions
in struct device_driver, but alphabetic doesn't make much sense
in general for filling structures.

So I agree with reorder but not for that reason.

Jonathan

> >   	},
> >   	.probe		= mc3230_probe,
> >   	.remove		= mc3230_remove,  


