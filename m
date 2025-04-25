Return-Path: <linux-iio+bounces-18627-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4473AA9C0E9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F9468691
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1B2356BC;
	Fri, 25 Apr 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKjbqAU9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8122615;
	Fri, 25 Apr 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569607; cv=none; b=dRn7X/BdFiqeMaEwrMUKxy+AlBZN72NFzXmIeBse03W9APWpOZKMT2vAmjj8+95WDKPI+tZqVIUKRDHjGbpJ9CiY3E7ekF8GkwLW2urMcPSleF9SHXkojuxEOZchOLBQb/+Mp6L9xn4YP5hyrefvJsjDFaHTrD2yEAtuA/chUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569607; c=relaxed/simple;
	bh=3hyYZAdzYUDm/qiRZiyh2oVm8XKUZX7B2vVFFia68xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHqTJKxmMCs93Hic/O13B81S5XoXG46mAzT1ahS2sc+dZhEeTwRSkm9pGPsYlsYb2Jt3tAtfmon8UyXDUcgo8Y0yV6bHd0JK3nWF5JKmlMkvF6ZnNCwFZg74IjqDePxGaKRrjUs/65C2WvGrhXgseOb7erImYsNAoXoRTR2mJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKjbqAU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E95C4CEE4;
	Fri, 25 Apr 2025 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745569606;
	bh=3hyYZAdzYUDm/qiRZiyh2oVm8XKUZX7B2vVFFia68xg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bKjbqAU9VzJTI6ooBoSzm4opSTonEAXPBzv+uSe5rGiZ6alQsb3d6JkidnXEXkyog
	 VIoCnCoEfWgGEgHsX7NT4T+Kk+Kl41q8AzGHQxeofx1J0+nV7kkmU5OcM552Dou5T8
	 bNRGtDWxJRSO9g8CWJUPzjXTpv5DHvSBPJclJ+RXzncU4Ew6gi0pB2wNNCako7uoVf
	 RUYk6ElTrwR0kWaxEShcwokyI8AWsU/nfJwA0fVWv3M4PhucHUz7L7TcRsB0yq7vEh
	 W1ofP0vRDSooOEiMMhfCFMupSMkjXhMHZGNMQXUBklusM43N7iZnT5W4GyGiHbdOyO
	 82dZSEZOeMIRg==
Date: Fri, 25 Apr 2025 09:26:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: "Paller, Kim Seer" <KimSeer.Paller@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
Message-ID: <20250425092637.0c019531@jic23-huawei>
In-Reply-To: <aAkavQVd7Px3qPU0@smile.fi.intel.com>
References: <20250421-togreg-v5-0-94341574240f@analog.com>
	<20250421-togreg-v5-3-94341574240f@analog.com>
	<20250421144800.0db0a84e@jic23-huawei>
	<PH0PR03MB7141E6D1A077B0E02368CBDDF9BA2@PH0PR03MB7141.namprd03.prod.outlook.com>
	<aAkavQVd7Px3qPU0@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 19:52:13 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Wed, Apr 23, 2025 at 07:50:51AM +0000, Paller, Kim Seer wrote:
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Monday, April 21, 2025 9:48 PM
> > > To: Paller, Kim Seer <KimSeer.Paller@analog.com>
> > > On Mon, 21 Apr 2025 12:24:54 +0800
> > > Kim Seer Paller <kimseer.paller@analog.com> wrote:  
> 
> ...
> 
> > > > +	mask = GENMASK(chan->address + 1, chan->address);  
> > > 
> > > I think maybe we need a macro to get the mask from the channel number?
> > > Using address for this seems overkill given how simple that maths is.
> > > Ideally that macro could perhaps be used in the code below to avoid
> > > all the defines I suggested.  
> > 
> > The motivation for using the chan->address field was to hide the calculation a bit.
> > However, would using a macro like 
> > #define AD3530R_OP_MODE_CHAN_MSK(chan)	GENMASK(2 * chan + 1, 2 * chan) 
> > be a good approach in this case? This drops the need for the address field and
> > can also be used to explicitly set the operating mode for the 4 fields of the register.
> > What do you think?  
> 
> Please, note that doing GENMASK(foo + X, foo) is highly discouraged as it may
> give a very bad generated code (although I haven't checked recently if it's
> still the case). The preferred way is GENMASK(X, 0) << foo. Where X is a
> compile time constant.
> 

With what Andy suggested as the implementation, this sort of macro
looks like a good solution to me.

Jonathan

