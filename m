Return-Path: <linux-iio+bounces-8517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49352955710
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CED21C2107D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E091494A3;
	Sat, 17 Aug 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og6DfgjC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73797F507;
	Sat, 17 Aug 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888800; cv=none; b=HEfiUtJYA5hyNOJK7sM14uFvBfxO0HKYOyRC9R85om3bcJ5dJp0NBlruAc36ZagkIXyZtPDchvTC1tQGfI7AiCvaG2h6YGVWsEnpr7kjdA8J7F7H/oOkBMor27W7IsVaA4zG3e1rTJwcCwf0ZRVtj+ziGrGai6/g5OFJ5fmQDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888800; c=relaxed/simple;
	bh=0I3Z/JX3w1vF12YT4+Xa5zhTim9q0NldcHx2aPBgh7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mb2HX7ZlsvT8ii87RdgDjXLGQFCf1obPUq+i2LN4yxzwqYeXgIGuSYOQxNiEiKpHbP8Vi4TIrwrNew/5r9e6Vv9UHnruvOGN58KzK5OHuu70dHJQFRK68CRfqndSTDkfxER6GFc92tn8sK0JxQQ6wr4BWi+0ComZGgqyCK1Sgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og6DfgjC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE02C116B1;
	Sat, 17 Aug 2024 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723888799;
	bh=0I3Z/JX3w1vF12YT4+Xa5zhTim9q0NldcHx2aPBgh7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=og6DfgjCAkZEmiH7KS3to4FVpEC+zIkQb88SO5OmOuYYzGVRKAo/pTrQF0nwOyida
	 OwV0u9Imi5vpqhNaLrzNfoMgl2JxZsQe5oIjdkF6IcizZHF3+cyvvvLCFvFlBRyrpd
	 yNjtBvVmk5Dxk95VvEmBmFhCt4RnLG4OjsI2B/+R/UZuCRpYTdm6YiZ88wGlQrFyft
	 wWDdNK/8JVAOIX57axEMlCpFh89FOOPzRsd27jgZtEU2+1wAfoqwZRvZdsp1NAu+PP
	 uppHaqFdiopgxWjkrCUDOyDHA6hhTvtnfcetLIaz6Ib67QRDHasYePVnReoWTcQQFh
	 V2/ZRB6Tewmzw==
Date: Sat, 17 Aug 2024 10:59:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
 mripard@kernel.org, tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 Chris Morgan <macromorgan@hotmail.com>, Philippe Simons
 <simons.philippe@gmail.com>
Subject: Re: [PATCH V2 14/15] power: supply: axp20x_battery: add support for
 AXP717
Message-ID: <20240817105949.2a091d13@jic23-huawei>
In-Reply-To: <66bd1ddf.ca0a0220.13e5d4.8871@mx.google.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
	<20240802192026.446344-15-macroalpha82@gmail.com>
	<20240803121044.20481897@jic23-huawei>
	<66bd1ddf.ca0a0220.13e5d4.8871@mx.google.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 16:13:01 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> On Sat, Aug 03, 2024 at 12:10:44PM +0100, Jonathan Cameron wrote:
> > On Fri,  2 Aug 2024 14:20:25 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> >   
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add support for the AXP717 PMIC battery charger. The AXP717 differs
> > > greatly from existing AXP battery chargers in that it cannot measure
> > > the discharge current. The datasheet does not document the current
> > > value's offset or scale, so the POWER_SUPPLY_PROP_CURRENT_NOW is left
> > > unscaled.
> > > 
> > > Tested-by: Philippe Simons <simons.philippe@gmail.com>
> > > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
> > Hi.
> > 
> > A few drive by comments,
> > 
> > Jonathan
> >   
> > > ---
> > >  drivers/power/supply/axp20x_battery.c | 444 ++++++++++++++++++++++++++
> > >  1 file changed, 444 insertions(+)
> > > 
> > > diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
> > > index c903c588b361..53af4ad0549d 100644
> > > --- a/drivers/power/supply/axp20x_battery.c
> > > +++ b/drivers/power/supply/axp20x_battery.c
> > > @@ -32,9 +32,19 @@
> > >  #include <linux/mfd/axp20x.h>
> > >  
> > >  #define AXP20X_PWR_STATUS_BAT_CHARGING	BIT(2)
> > > +#define AXP717_PWR_STATUS_MASK		GENMASK(6, 5)
> > > +#define AXP717_PWR_STATUS_BAT_STANDBY	(0 << 5)
> > > +#define AXP717_PWR_STATUS_BAT_CHRG	(1 << 5)
> > > +#define AXP717_PWR_STATUS_BAT_DISCHRG	(2 << 5)  
> > 
> > Fine to match local style in this patch, but just thought I'd
> > comment that this driver would probably be more readable with
> > use of FIELD_PREP and changing convention to not shift the defined
> > values for contents of each field.
> > 
> > To change to that it would either need to be before this patch,
> > or done as a follow up.  
> 
> I'll take your other comments and apply them, but if it's okay with
> you I'll opt to not use FIELD_PREP/FIELD_GET for the moment, so the
> style remains the same. I will make sure to use those macros for
> other drivers I'm working on though as they seem handy.
That's fine, though if you are in a position to test, it would be good to follow
up with a tidy up of this driver as that style is much more compact and
helps with maintenance longer term.

Jonathan

