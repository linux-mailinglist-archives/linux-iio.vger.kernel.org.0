Return-Path: <linux-iio+bounces-18101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BBA88B39
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B817D517
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC603291147;
	Mon, 14 Apr 2025 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqnsx9Kr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83060291143;
	Mon, 14 Apr 2025 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655503; cv=none; b=m1kV172qwUnS6JfA4xvwsW5JL1ONaQ4O69zIwL6cnJrsFCRMDnxQK0bQGSSSnZMU1OjhrI7BgqcaomrQwg+uLqNSbAxDkuF4AjUCgSLjpzWBWzkHz38KxkVtyf17qi5KB4NWvKaMmjwUnlcQ/eepNB2MS4XOk4qO7cuqx30y/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655503; c=relaxed/simple;
	bh=vR+6NtAywWyJ5U9ZGWwP9/rand9/g91svJvYpIUjs14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUsRHJSDmvEyXv5o15Ru8ffydgX2F8IpUpgvvsE8rK5oqsxpRifbR7QCHctlMwE8f+fMmFKEa10xyIw8v+FrtwtyxEHoyU3PBvDddyZLrFVsMoDBEfmzYBgBOd8xsmFupE7QT14zuRRPnSz6uty1G8eflgChKmboZhDkGxU1/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqnsx9Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8352C4CEE2;
	Mon, 14 Apr 2025 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744655503;
	bh=vR+6NtAywWyJ5U9ZGWwP9/rand9/g91svJvYpIUjs14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lqnsx9KrDqj15U/Okx450n2RZyM6ph+6fccS7+pmVyJLd8xJzzxwOyUv6H4FLIaKm
	 vpU0PQAyw5GAaqegaX/0nDBjdLVLvzLMATZSvNa8J2TFCMiVImSp7FhOHtUCeXWGih
	 KNBMcb9AtYYi72p5qDJ3EYEgUh504e1TKsWkQLy/Xs/mm6x+rjJ7UPthKUoTkF3L9Z
	 QmsIYqSf605UoK+wdrCrH0sfcy0mf/sWmsZnUCzlg4DOvvYAwhh9Oc5skPQdGwkLXL
	 0k8a2nLtc2ajO3hy7nvKXgvq5m5E9HBQSd8SybQF2WrAXJ1fTBqe3wIMB0YUESdgQ/
	 wwMEMO4Oo+0kw==
Date: Mon, 14 Apr 2025 19:31:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 08/11] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250414193136.3daf0176@jic23-huawei>
In-Reply-To: <CAFXKEHY59F54Wq7Z7MXc4cnDBq3E2gCNM6Js7CS7K+CarbwSiQ@mail.gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
	<20250318230843.76068-9-l.rubusch@gmail.com>
	<20250331114029.2d828b19@jic23-huawei>
	<CAFXKEHY59F54Wq7Z7MXc4cnDBq3E2gCNM6Js7CS7K+CarbwSiQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > > @@ -1347,6 +1542,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> > >               if (ret)
> > >                       return ret;
> > >
> > > +             ret = regmap_write(st->regmap, ADXL345_REG_ACT_INACT_CTRL, 0);
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > > +             ret = regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, 6);  
> >
> > 6 is a fairly random number. Add a comment for why this default.
> >  
> 
> My general intention is to provide +/- reasonable default configs,
> rather than leave it all to 0 or undefined, to allow to turn the event
> on and already catch at least something. In many cases those
> will be the default values from the older input driver, to keep a bit
> of a compatibility.
> Particular cases have actually recommendations in the datasheet and
> differ slightly to the input
> driver. I'm aware that the input driver probably is not a golden
> standard, but it worked at least for
> my tests. I may leave a general comment on the section, pls have a
> look into v6 if this is ok.
Comment sounds like what we need here so all good.

> 
> > > +             if (ret)
> > > +                     return ret;
> > > +
> > >               ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, tap_threshold);
> > >               if (ret)
> > >                       return ret;  
> >  


