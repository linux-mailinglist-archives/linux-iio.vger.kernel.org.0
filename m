Return-Path: <linux-iio+bounces-10487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600B299B316
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 12:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CB91C21665
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D640154449;
	Sat, 12 Oct 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXBSJ6ea"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B915252D;
	Sat, 12 Oct 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728729732; cv=none; b=jOp2azXU2ZpTOqUylMMN1CUpTPd6KxG2wsJ9sYC3sknTYrmnNh0EmICGlupdJWToCJhx4HIj7Kmy5hcYytlj8PIFyJRYlCsx4NMe45CYYooK1ImWTr0qOp9TQbJYsVtyXgDYUpvn/e9bozqgTynmf6AYTc6lzuhIUIPeA95XhvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728729732; c=relaxed/simple;
	bh=ytTJI2pyOuq6oQGMwPo/8+EaVQQCWkdGutdxfcmh5ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BySvZJxZWQmHt1nN3lMPKwgPDHCgnha7NqjPFmmT7JsJcAJyLdYix5verL5SCKOubU2ONfmv+Bb7umw6nssjddpgOTkFThSbAfPNtDdwlfA7Tk/NIfX9jdH8J8d7d+ex9ZG0UndBmscS3PbNp2K/8m9Xr3RmZ9em7ukwhojPvXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXBSJ6ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE374C4CED2;
	Sat, 12 Oct 2024 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728729732;
	bh=ytTJI2pyOuq6oQGMwPo/8+EaVQQCWkdGutdxfcmh5ZM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LXBSJ6eaNUJu29YjDbrpRco2OF2rZwsZU4bG0lIy7snbrPID0KAG/oXoe/kuNzsUH
	 9SSfP5qIGiWp/udMdRaqQGmqIz2KV7xm0wupmGJMmiaDgdJAbTf7mmGyvLt2up+Luy
	 NCz0owXhdAORYkJTygjN6xJgGSuzIqHA+lm0Gg7T9TazvXONS7ycMidjmXmE5Xu/ap
	 YUMHG8mXAUeZxoX6jNwOqdz6BdwtA7Y9G31typS9rj/HGVvNyA51WQa2MEn6MyEjpI
	 QYhxGFcIH7XE0CS3ptxj9YUiMmyU6/WiW4YspW/UYca7+o/sb+VM16KKmEnxj5VM+l
	 y4QfbkaMPGK8A==
Date: Sat, 12 Oct 2024 11:42:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: "Nechita, Ramona" <Ramona.Nechita@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, "Schmitt, Marcelo"
 <Marcelo.Schmitt@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20241012114202.425f1b74@jic23-huawei>
In-Reply-To: <Zwgb_Fq4dhVwzpf9@smile.fi.intel.com>
References: <20240926135418.8342-1-ramona.nechita@analog.com>
	<20240926135418.8342-4-ramona.nechita@analog.com>
	<ZvV2mHkl4qxVVmBH@smile.fi.intel.com>
	<DM6PR03MB4315785FB25B980264748BCBF3782@DM6PR03MB4315.namprd03.prod.outlook.com>
	<20241010184516.66826055@jic23-huawei>
	<Zwgb_Fq4dhVwzpf9@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 21:25:00 +0300
Andy Shevchenko <andy@kernel.org> wrote:

> On Thu, Oct 10, 2024 at 06:45:16PM +0100, Jonathan Cameron wrote:
> > On Thu, 10 Oct 2024 14:32:49 +0000
> > "Nechita, Ramona" <Ramona.Nechita@analog.com> wrote:  
> 
> ...
> 
> > > >> +	/*
> > > >> +	 * DMA (thus cache coherency maintenance) requires the
> > > >> +	 * transfer buffers to live in their own cache lines.
> > > >> +	 */
> > > >> +	struct {
> > > >> +		u32 chans[8];
> > > >> +		s64 timestamp;    
> > > >
> > > >	aligned_s64 timestamp;
> > > >
> > > >while it makes no difference in this case, this makes code aligned inside the IIO subsystem.    
> > > 
> > > I might be missing something but I can't find the aligned_s64 data type, should I define it myself
> > > in the driver?  
> > 
> > Recent addition to the iio tree so it is in linux-next but not in mainline yet.
> > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=togreg&id=e4ca0e59c39442546866f3dd514a3a5956577daf
> > It just missed last cycle.
> >   
> > > >> +	} data __aligned(IIO_DMA_MINALIGN);    
> > > >
> > > >Note, this is different alignment to the above. And isn't the buffer below should have it instead?  
> > 
> > While I'm here:  No to this one.  The s64 alignment is about
> > performance of CPU access + consistency across CPU architectures.
> > This one (which happens to always be 8 or more) is about DMA safety.  
> 
> Right, but shouldn't...
> 
> > > >> +	u32			spidata_tx[8];  
> 
> > > >> +	u8			reg_rx_buf[3];
> > > >> +	u8			reg_tx_buf[3];  
> 
> ...one of these also be cache aligned for DMA?
No need as long as driver doesn't do anything bad like
write to these whilst another dma transaction is in flight.
(I haven't checked though, but typical drivers don't)
All you have to do is ensure that any DMA buffer doesn't share
a cacheline with an unrelated bit of data (i.e. a separate allocation or some
state tracking etc). It is fine for multiple DMA buffers  (say rx and tx)
to be in the same cacheline.  Any DMA device that is stupid enough
to stomp it itself is broken (and would be fairly hard to build!). Such
a device would need to be worked around in the controller driver.

They are allowed to write back stale data, but not garbage data to unrelated
parts of the cacheline.  I.e. a tx buffer that was changed whilst
the SPI transaction was going on, might be overwritten with the old value
when the SPI controller DMAs back an updated version of the cacheline
containing the rx data + a cached copy of the early tx data.
The risk we are defending against with this alignment isn't this, it's
unrelated (and typically not protected by lock) fields in the structure
being overwritten with stale data.  The really nasty one being when
the allocator gives the next bit of the cacheline to another allocation.
(avoided here because the structure is sized as a multiple of the maximum
 alignment).

Now, the code that bounces unaligned dma buffers on arm64 will probably
bounce these because it can't tell they are safe :( That's not incorrect
it's just less than optimal.

Jonathan
> 
> > > >> +	u8			reset_buf[8];  
> 


