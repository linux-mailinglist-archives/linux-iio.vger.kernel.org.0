Return-Path: <linux-iio+bounces-12064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B09C2C2B
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 12:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1571F21E34
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585A4155306;
	Sat,  9 Nov 2024 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egz8hSQO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE3F13DDA7;
	Sat,  9 Nov 2024 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731151670; cv=none; b=F+8ngNLq38ZhUUDXZeiuKBF8i2y0dMvA3VWeBSQXmgkR4QQ+UdjCBLqTkGe/hCym/LZ2irtt67EZpdrrPdN4fkj4I3p9zMUQfyA8DwBfX5KM4CGh0eBdkSkqZTiDTVctx//xHS7eMQHzaIBp9JT7WzJwobmMI93r4Cq7UWIKm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731151670; c=relaxed/simple;
	bh=8bOTzZiVf55W83Wg3LaFw+ZXGUO/wNOGdn5iQGfS5q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrD36u7RoBSyj/wlGmlOo5wrg0pnpG6dfdBQ6EKYF1HKvbaxQX6aTI2MATFOLsJ3l4PLcU6Use+eIqR6IZQgqjBAI79vFC5z9o59rBeH7UflpLYpcK3efxmI2uW2ZE34ucGA64jKD00ax3nVCunVnotVUXsDWI8KLUOGMHn4qVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egz8hSQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FFA4C4CECE;
	Sat,  9 Nov 2024 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731151669;
	bh=8bOTzZiVf55W83Wg3LaFw+ZXGUO/wNOGdn5iQGfS5q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egz8hSQOr1y2+Ill2AOR1YHaJvZPy2jIKMckm/iTO1MWJq/yCxOJ120ZIiLLRC9og
	 vlNlmzuzILdSpsbbANukpCVxlBDYdqR+7ZLBWOw1wLNmoEef6WTU8mYY4qEjBq9NP9
	 70oET4lZ8ycXgY+912rcfvsVNV4wc3kpVqwrDxyc47V5gAJ0bVv3lxb6n1n1kUAT1Z
	 Vh+Jm2OAVDRNYSb+xX1NJZTvw85UwJRYc1NRnb3bwbfKnxpqMYj/YckLVehSmg65NN
	 wdd3txCifj+UtIUqxdt4H94Qu5jjran3nQEL56thUFMFMRWzBrc3RaiWCHKrWZ1s/z
	 Zm33hpTnsy9PQ==
Date: Sat, 9 Nov 2024 11:27:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, <megi@xff.cz>,
 Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 <hpa@zytor.com>, "Peter Zijlstra" <peterz@infradead.org>,
 <linux-kernel@vger.kernel.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: magnetometer: fix if () scoped_guard() formatting
Message-ID: <20241109112741.456ce2f9@jic23-huawei>
In-Reply-To: <20241108180243.00000c27@huawei.com>
References: <20241108154258.21411-1-przemyslaw.kitszel@intel.com>
	<20241108180243.00000c27@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Nov 2024 18:02:43 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri,  8 Nov 2024 16:41:27 +0100
> Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:
> 
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > Add mising braces after an if condition that contains scoped_guard().
> > 
> > This style is both preferred and necessary here, to fix warning after
> > scoped_guard() change in commit fcc22ac5baf0 ("cleanup: Adjust
> > scoped_guard() macros to avoid potential warning") to have if-else inside
> > of the macro. Current (no braces) use in af8133j_set_scale() yields
> > the following warnings:
> > af8133j.c:315:12: warning: suggest explicit braces to avoid ambiguous 'else' [-Wdangling-else]
> > af8133j.c:316:3: warning: add explicit braces to avoid dangling else [-Wdangling-else]
> > 
> > Fixes: fcc22ac5baf0 ("cleanup: Adjust scoped_guard() macros to avoid potential warning")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202409270848.tTpyEAR7-lkp@intel.com/
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > ---
> > I have forgot to add this patch prior to the cited Fixes: commit,
> > so Stephen Rothwell had to reinvent it, in order to fix linux-next.
> > original posting by Stephen Rothwell:
> > https://lore.kernel.org/lkml/20241028165336.7b46ce25@canb.auug.org.au/
> > ---
> >  drivers/iio/magnetometer/af8133j.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/af8133j.c
> > index d81d89af6283..acd291f3e792 100644
> > --- a/drivers/iio/magnetometer/af8133j.c
> > +++ b/drivers/iio/magnetometer/af8133j.c
> > @@ -312,10 +312,11 @@ static int af8133j_set_scale(struct af8133j_data *data,
> >  	 * When suspended, just store the new range to data->range to be
> >  	 * applied later during power up.
> >  	 */
> > -	if (!pm_runtime_status_suspended(dev))
> > +	if (!pm_runtime_status_suspended(dev)) {  
> 
> I thought I replied to say don't do it this way. Ah well probably went astray
> as I was having some email issues yesterday.
> 
Also, for the fixes tag to make sense this will need got through the same tree as
that rather than IIO which doesn't have that commit yet.

Given timing I'm fine with this version getting picked up and if I care enough
I can chase it with a tidy up to the guard() form next cycle.  

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Jonathan

> 		guard(mutex)(&data->mutex);
> 		ret = regmap_write...
> 
> >  		scoped_guard(mutex, &data->mutex)
> >  			ret = regmap_write(data->regmap,
> >  					   AF8133J_REG_RANGE, range);
> > +	}
> >  
> >  	pm_runtime_enable(dev);
> >    
> 


