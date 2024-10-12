Return-Path: <linux-iio+bounces-10502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77D99B4B5
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFF71C20A57
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EA315D5B7;
	Sat, 12 Oct 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Va9CV0yX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C7155759;
	Sat, 12 Oct 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734653; cv=none; b=Ny6kEVxDY1v0AFgxqL/ZrLehFVSBEi+ixqn5GhUVQAfdagT73fUgWWCgQIChIiRlxWMoOw5Nf+UHLvDje0QzbNC9lmJE9SSsEXeP5vJfyt1gmQ3o16YBJpwsRWM7wdn0Mmz7JsxUWqUPbroXU7wmjNGKH7DthKXcYvyOFnTCsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734653; c=relaxed/simple;
	bh=YSpdctYsxiigwmcz5G5bEG1McNmz5DhhFYccwPk3OR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBgaYGDbAf/mQ75M00adi/PHqtMf7n2awVSoV8mDkLq3H/D1hGxPaUGaVhoRy6mJThbr7vJL6ddlMD3Fczcbl0v75hbRzCepcK7pxnhEcOO5Y7ssaiieBzaDeV3nzLu9nLuCMJh6of7FOBhS5mA/0hmEXa+jxqEbNDdmRtzG1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Va9CV0yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2689FC4CEC6;
	Sat, 12 Oct 2024 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728734653;
	bh=YSpdctYsxiigwmcz5G5bEG1McNmz5DhhFYccwPk3OR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Va9CV0yXGUWjeMFRTs9DI4NZ5UE8cN5HPZCoThwbC1mdiKw8cogaVGKIm4MNR9PyG
	 3dL7OudMCpymgYgpao9pcXxFclOsGf/BlcQsRu3Ny5qF6fzJML7ClHs8peLOki5c/k
	 CqVrd/WPoxaeBBujCYWL8sfKcKkJQMDWD+2vpeWNaJYdVh9gkFCxikWwC1OwSEhHBN
	 na9xOGpIvSKytgWhexqlDg5trdA+kMQd1XwLFZ4w++9hq08OL2op11VBFnZ9S09yio
	 UkCeFheEsmx4loR8aevEi382cg1ZOktq3f+Yr6Q9KoZ5o7LHPcBNspj4vdGQKHctDf
	 BTwF8jxCDAF1A==
Date: Sat, 12 Oct 2024 13:04:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 12/13] iio: chemical: bme680: Add triggered buffer
 support
Message-ID: <20241012130402.450b7181@jic23-huawei>
In-Reply-To: <Zwl3aBDFiLN9b0TK@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
	<20241010210030.33309-13-vassilisamir@gmail.com>
	<ZwkABN9RycsVPRwo@smile.fi.intel.com>
	<Zwl3aBDFiLN9b0TK@vamoirid-laptop>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 21:07:20 +0200
Vasileios Aoiridis <vassilisamir@gmail.com> wrote:

> On Fri, Oct 11, 2024 at 01:37:56PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 10, 2024 at 11:00:29PM +0200, vamoirid wrote:  
> > > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > 
> > > Add triggered buffer and soft timestamp support. The available scan mask
> > > enables all the channels of the sensor in order to follow the operation of
> > > the sensor. The sensor basically starts to capture from all channels
> > > as long as it enters into FORCED mode.  
> > 
> > ...
> >   
> > >  	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
> > >  	int ambient_temp;
> > >  
> > > +	u8 buffer[ALIGN(sizeof(s32) * BME680_NUM_CHANNELS, sizeof(s64))
> > > +		  + sizeof(s64)] __aligned(sizeof(s64));  
> > 
> > Can it be represented as a structure?
> > We also have aligned_s64 for the timestamp.
> >  
> 
> Hi Andy,
> 
> The same approach was used also for the bmp280 driver and since I was
> working on the bmp280 as well, I did it here. You think the
> representation as a struct would look better? Personally I like the
> nature of this one because of the ALIGN() but I have no problem of using
> a struct here.

Depends if you can enable sufficiently few channels that the timestamp
moves.  If that is the case, a structure is missleading as a representation
of this buffer so I prefer the above fun as it doesn't give the wrong
impression (by giving no impression at all of the data layout!)

Jonathan

