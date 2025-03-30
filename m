Return-Path: <linux-iio+bounces-17354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27FEA75AED
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2303A790E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF621D5172;
	Sun, 30 Mar 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV2cZxLS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE589461;
	Sun, 30 Mar 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743352522; cv=none; b=RXnyTUt7Uqai+/U5nYkgsWhSk60LHZAy6ENEZPKwCjpacaklgUpVkszd0qTDdKibabfqnsSoQ8IsABJHL43aaAovrXZC/liRE5fdbfOejz772l4cq8xTqlhaisv5hvtykpyvWpFLjWyPKihN9bmSg+jBVEjBXimXU04t2Iid88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743352522; c=relaxed/simple;
	bh=O0QJ1S+tuxSySVX10I5InTFb4LaPHEWfNmS9eJeW4i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYOxzMOyletd1sh0xZI8vUtJ85O73jx7HJ65iBrcUvO/rfVuPuf3wSwMrRXqyLbmGVbe5Cvuv6DuEhzcWAMyCA2SRpjyFov2nJatPhdrpmeMJAsC6XUDLZUvjK0KdJYIFx/K88HdwKQ3qTQoCLhtSUZPj1QYm4uPc/I210AvFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV2cZxLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ED8C4CEDD;
	Sun, 30 Mar 2025 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743352521;
	bh=O0QJ1S+tuxSySVX10I5InTFb4LaPHEWfNmS9eJeW4i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eV2cZxLSdjl03dd/h5OucJBUm+skfwhgNH4u6LqnmIDooH0wEbTZzJdDx5NQV0cNp
	 kDp65+jBQ6hinrXemX+9QisDy3XtvF/9tbQaMLLunNYvnJhwywEUnbWojVgg6DjpEg
	 B+FxMzRcY90V48t5nkJeGSK+IJ/UqihfQH1Wfab14TBF4yovbuLoWU6ZgO9vTJRZMF
	 NwI0o+ejp7W0KuJVCCUdWT0mzVg7nX+oHn+UdAdJCpO4pSZSejXvpCCdnZjEf96Ew5
	 50cS2hq+iupRqCjM/uVZJKHX/hjzzlzK+XGEJ1SjNoVVya8C7DfxVGdm38SE5CZNoj
	 ns4t3/IG5+J6A==
Date: Sun, 30 Mar 2025 17:35:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v10 6/8] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250330173511.16ea9ebc@jic23-huawei>
In-Reply-To: <Z-EWmK2r6VgmPAqa@smile.fi.intel.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
	<ca3886c9abcb268ca976e62cd7da28bf5d6e6382.1742560649.git.mazziesaccount@gmail.com>
	<Z-EWmK2r6VgmPAqa@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 10:23:52 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Mar 24, 2025 at 09:13:42AM +0200, Matti Vaittinen wrote:
> > The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> > an automatic measurement mode, with an alarm interrupt for out-of-window
> > measurements. The window is configurable for each channel.
> > 
> > The I2C protocol for manual start of the measurement and data reading is
> > somewhat peculiar. It requires the master to do clock stretching after
> > sending the I2C slave-address until the slave has captured the data.
> > Needless to say this is not well suopported by the I2C controllers.
> > 
> > Thus do not support the BD79124's manual measurement mode but implement
> > the measurements using automatic measurement mode, relying on the
> > BD79124's ability of storing latest measurements into register.
> > 
> > Support also configuring the threshold events for detecting the
> > out-of-window events.
> > 
> > The BD79124 keeps asserting IRQ for as long as the measured voltage is
> > out of the configured window. Thus, prevent the user-space from choking
> > on the events and mask the received event for a fixed duration (1 second)
> > when an event is handled.
> > 
> > The ADC input pins can be also configured as general purpose outputs.
> > Make those pins which don't have corresponding ADC channel node in the
> > device-tree controllable as GPO.  
> 
> Thank you for the nicely written driver!
> However, I have one big issue with it (see below).
> 
> ...
> 
> > +static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int value)
> > +static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *mask,
> > +				    unsigned long *bits)  
> 
> These will be _rv variants anyway as there is no chance this series goes before that.

I don't mind seeing this as a follow up series, but I would like that
to hit this cycle if possible.

> 
> ...
> 
> > +struct bd79124_raw {
> > +	u8 val_bit3_0; /* Is set in high bits of the byte */
> > +	u8 val_bit11_4;
> > +};
> > +#define BD79124_RAW_TO_INT(r) ((r.val_bit11_4 << 4) | (r.val_bit3_0 >> 4))
> > +#define BD79124_INT_TO_RAW(val) {					\
> > +	.val_bit11_4 = (val) >> 4,					\
> > +	.val_bit3_0 = (val) << 4,					\
> > +}  
> 
> All the rest is fine to me and looks good, but above is a principal impediment
> to give you my tag. In case you update the type to __le16, feel free to add
> my Reviewed-by tag.

Matti, I think after all the back and forth it is clear I should have
been fussier about this in the RFC as it would have saved time.
My advice in future is once something has been poked twice by reviewers
just change it.  For what it is worth I prefer what Andy is asking for
but not enough to hold this longer.

So applied (with tweak as per other mail) and with assumption you'll chase
this with the gpio chip stuff cleaned up to use the new functions.

Thanks,

Jonathan



