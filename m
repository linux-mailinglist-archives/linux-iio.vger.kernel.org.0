Return-Path: <linux-iio+bounces-19062-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A5AA8877
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993D71896448
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EFD1E5B88;
	Sun,  4 May 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ5K0Caj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6363F185B73;
	Sun,  4 May 2025 17:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379639; cv=none; b=DGXINgD8UqBT3ZUrPUQSfcydko9Xe759zMkhY0iVeK4FVpvhjt9cMidUm50RzBbWgNS68Ri1a2CwCcPhAI1NhN1FWtqyp3TlxL46p/0Re3fBkJypFIbJzEmSV4SLkAJPgOt7Wi2IUDIaLj6pRQ12mo9BtAvwUxNgEdAo9f+LtAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379639; c=relaxed/simple;
	bh=tSn3dJVZ+9ZNzeso5zb514vh1iRfO9z/dmDK28sIEGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvHID++8QpSE7M99diTec0mNqxP3u/XyLJcdqNMFWUFF2zTR3JlTE4PiJP6B3zW7dpv4yOzyij7XQ9ZCbb6zc7+ChIL0l51waZR44XdZVc2oup5LtWGcpgnAEYS0UuP1SH0My4QKzYTYdx7XrqhSFAHKAWCHZr7XqLrZ0nEm0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ5K0Caj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDA8C4CEE7;
	Sun,  4 May 2025 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746379637;
	bh=tSn3dJVZ+9ZNzeso5zb514vh1iRfO9z/dmDK28sIEGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DZ5K0CajDZt0z4ChDLSRlif6B73xBfZThEuIOXgeiRypLOHV9E3x+qkN+rx+kLKMs
	 XfSHGGa8ZNpPpBFdX/PC5aFTIF8TYsMLep5CwGh/IpS5RuVenZ3vjWgCI+twdLxb3g
	 k6pEXR/0Myxq6fetAqfxZ8+/YutQwv4bZAhGWN0Ca+Xg67WhjmFj/UHSuyqxhAelO8
	 U7lWRdSy5v/9wMGEHDKc5z3qoHShFHkdiJ0q9ty0noNXtNM2WWIlzmU0t9P3IjrukC
	 91w2PJCQTLSqF5nCLzs7nydySMLopb7cfKvJ+IEOkBebhr1kmYMkzALaiH0cYE+qbi
	 xB3vF8LyluiPA==
Date: Sun, 4 May 2025 18:27:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v2 3/7] iio: adc: ad4170: Add support for buffered data
 capture
Message-ID: <20250504182708.42eff56f@jic23-huawei>
In-Reply-To: <aBIoRc-gpBswohe-@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
	<db98c6cc188b501d914293268b67b0bdf26a4a46.1745841276.git.marcelo.schmitt@analog.com>
	<CAHp75Vc9CMqkkrEjgGEYPnmkb1R=u+RUvD3FAZ+7bFqi5aDzdw@mail.gmail.com>
	<aBIoRc-gpBswohe-@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 10:40:21 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Andy, thank you for your review.
> 
> ...
> > > +static int ad4170_prepare_spi_message(struct ad4170_state *st)
> > > +{
> > > +       /*
> > > +        * Continuous data register read is enabled on buffer postenable so
> > > +        * no instruction phase is needed meaning we don't need to send the
> > > +        * register address to read data. Transfer only needs the read buffer.
> > > +        */
> > > +       st->xfer.rx_buf = &st->rx_buf;
> > > +       st->xfer.len = BITS_TO_BYTES(ad4170_channel_template.scan_type.realbits);  
> > 
> > This will give, e.g., 3 for the realbits == 24. Is this expected?  
> 
> Yes, in continuous read mode the ADC outputs just the conversion result bits
> (24-bits) so a 3-byte length transfer is enough to get the conversion data for a
> channel.
> 
> >   
> ...
> >   
> > > +               return dev_err_probe(&st->spi->dev, ret,
> > > +                                    "Failed to register trigger\n");  
> > 
> > One line?  
> 
> It goes up to 89 columns if make in one line. I know there are other places in
> this driver where 80 columns are exceeded, but in this case it's easier to
> avoid going beyond 80 columns without drying up the error message.
> Anyway, I'll make it one line if it's confirmed to be the preferable way to have
> it.
In here there are what I think are multiple ways to get to the same ultimate
device. (indio->dev.parent is used the line above).  Better perhaps to
have one 'dev' that is appropriate for use in both places.

> 
> Thanks,
> Marcelo
> 


