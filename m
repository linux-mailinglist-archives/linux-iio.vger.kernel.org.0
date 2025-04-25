Return-Path: <linux-iio+bounces-18626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F8A9C0DE
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CAD2468565
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00A1F4180;
	Fri, 25 Apr 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbpnqXiJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64A17A2EE
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569477; cv=none; b=pT+mZ4VhTc8dxxOT4Aq4eubYmFUDgOzFlXFAr2ZrEI7pifa0ZsKD8r/L5ACWWPsLtaqVclt/3IdnlnHTmduqME83DvOEsilp099q3GId+VXcQwvEaZnq7ocwEoS+w2ZPmjugbhPajfIfXN1o17avod0vAExjct7WUSuaIBntQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569477; c=relaxed/simple;
	bh=yaX3w4DfcX3TMo4x0MUdyXmOAsmyKJ9+vwqLSlAWwoA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RF7ZdYb6SNScap7CACzSi0dTbZC9b69m+jiZBL2EGogG98ElT0KiJthP/qUj7nj8woZL98G0Fd4cV3j29iFi5hGJ5OxtiLSDlooIkuAtvg9sFhCIpbUJ6YlRFxA0PvZRz0qtxdT/5/S+J2A4pYONlhkb3VEI1xUQlM9CgWZx7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbpnqXiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68219C4CEE4;
	Fri, 25 Apr 2025 08:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745569476;
	bh=yaX3w4DfcX3TMo4x0MUdyXmOAsmyKJ9+vwqLSlAWwoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bbpnqXiJBwtdsPVTFBFxc5de7F2/pwqYOvlF29RMk2Az6ELHq79MSfBZNxvEicmuK
	 zUYEDWj37k4HY1qHG5NOwfW32E1b6HteyqxPVHK2wc01OVICMlWj24VsoRRGRrj/Y6
	 kn78/450ekBQTHMi1PpvAGP3HEYz9yjqtA28uotBXUL7gm1RWMHeki9ykHC3klULj+
	 Uw61dKYTMMvXfbQ5m8Z5bSptsn+pVxK5c4j3DYs79UR2lkw+1Td0zf6P/WyxZ1VruU
	 IvVsMcMOz+QqpCTXCW7PgK8tO0HhhjymGii/vuZSdvP09+iNmpr1XsQaznwVixmcWj
	 ed9yF92eLhyVA==
Date: Fri, 25 Apr 2025 09:24:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur Pilone <art.pilone@gmail.com>
Cc: marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
 bruno.stephan@usp.br, aschwarz@usp.br
Subject: Re: [PATCH v2] iio: adc: ad7091r-base: Move reg volatility check to
 new macro
Message-ID: <20250425092431.3c128be2@jic23-huawei>
In-Reply-To: <CA+m-LuUn0awgWBK6TfKo0z_BYf9+5ZJdyNVF3vN+ywquPYsE0A@mail.gmail.com>
References: <20250420222512.173029-1-arthurpilone@usp.br>
	<20250421140842.08e4d26b@jic23-huawei>
	<CA+m-LuUn0awgWBK6TfKo0z_BYf9+5ZJdyNVF3vN+ywquPYsE0A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 12:05:49 -0300
Arthur Pilone <art.pilone@gmail.com> wrote:

> Thanks for the comment, Jonathan.
> 
> Jonathan Cameron <jic23@kernel.org> wrote:
> > I'm late to the game but to me, simpler to not have a macro but avoid
> > duplication by having one function call the other. Also a more
> > minimal comment can convey the point you want to make.
> >  
> ...
> >
> > On Sun, 20 Apr 2025 19:25:12 -0300
> > Arthur Pilone <art.pilone@gmail.com> wrote:  
> > >  EXPORT_SYMBOL_NS_GPL(ad7091r_writeable_reg, "IIO_AD7091R");
> > >
> > >  bool ad7091r_volatile_reg(struct device *dev, unsigned int reg)
> > >  {
> > > -     switch (reg) {
> > > -     case AD7091R_REG_RESULT:
> > > -     case AD7091R_REG_ALERT:
> > > -             return true;
> > > -     default:
> > > -             return false;
> > > -     }
> > > +     /*
> > > +      * The volatile ad7091r registers happen to be precisely the
> > > +      * two read-only registers.
> > > +      */
> > > +     return AD7091R_IS_READ_ONLY_REG(reg);  
> >
> >          /* The volatile ad7091r registers are also the only RO ones. */
> >         return !ad7981r_writeable_reg(dev, reg);  
> 
> Perfect. Addressed your suggestion on v3:
> https://lore.kernel.org/linux-iio/20250421145534.91146-1-arthurpilone@usp.br/T/#u

I'm replying to a few people about this today.

Don't bother replying to say you are taking a suggestion on board and
sending a new version.  That information is implicit in the new version
existing.

It is noise on the list and slows things down a little.

Thanks,

Jonathan



