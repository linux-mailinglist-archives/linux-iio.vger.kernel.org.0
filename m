Return-Path: <linux-iio+bounces-17211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1BA6CF0F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 12:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870083B5462
	for <lists+linux-iio@lfdr.de>; Sun, 23 Mar 2025 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BBE204C38;
	Sun, 23 Mar 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pd8fH2KE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8C1E5B6B;
	Sun, 23 Mar 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742731192; cv=none; b=cqOWdT0cZlzRPEsbc2UAaUMIbfXFvfNUwz3TK2lfKs91jsQoGyfXbzwAXeo9ABzju+tI8LkJvuxX+25UtiGzjvjXU3Y8w8MuHaqA15nXOtQqC4PmyMPioeFV0qjCXC62yt9qWBkBTjnzeeMcckCl7a+tgkjZ3h8x0Q7ysLvAEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742731192; c=relaxed/simple;
	bh=BCUqxCEYrRl38QQnY9UsQYipkTAwN/+KlfXG37n/a8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDC7uQxdX4MWf0f0Qrlro0HBO+dFPhTa3WPKZ0DQ1t62+j8vYsMUqVq6wi4rOwcWU852dXzp49SvsILZD19O6UoTpBfGw3J/GhwKHwaaLgIfWPtfzR7Iq05V+NE2oIyC4cGr34WJhW5JLj2X7xTiFO6P0X3Im3ZVHQMhpUxHvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pd8fH2KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D07C4CEE2;
	Sun, 23 Mar 2025 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742731191;
	bh=BCUqxCEYrRl38QQnY9UsQYipkTAwN/+KlfXG37n/a8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pd8fH2KEzRdGkjP7KHtMz0xgANl/rhdv89o8bTmrawdmP6WKCvGlqvNqjAwkY4ST5
	 RvkySsc3sO2pS6ZzfTf6wzMvxym9pNJoZRglMo+MQ85rbZimRURD3dlBdG/ZKXPXTf
	 KgsCye0eq6Ic9z2pmMAnZ0y62zBx4VF/niXdsSqGf7QUPPzB8gXraLqfPmylNROYT4
	 K2Nxl+BjPB/DpGTFxJCS+7kinRfln6thUGs2NWH5Q5vUlml4ft4lE6NW6JX/a59UDV
	 5eCbR2rda8tY6LSwSV1Dijl8y8faCvv5CC4jv9yYp8SllR/3fy4BvqL90gMHjNHkSj
	 AYxW1fEqqIxjQ==
Date: Sun, 23 Mar 2025 11:59:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Siddharth Menon <simeddon@gmail.com>, linux-iio@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] iio: frequency: ad9832: devicetree probing support
Message-ID: <20250323115947.4f23b6a6@jic23-huawei>
In-Reply-To: <Z969wZRJxMCyVuqy@debian-BULLSEYE-live-builder-AMD64>
References: <20250322081108.202654-1-simeddon@gmail.com>
	<Z969wZRJxMCyVuqy@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Mar 2025 10:40:17 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> LGTM, one minor suggestion inline.
> With that applied,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> On 03/22, Siddharth Menon wrote:
> > Introduce struct for device match of_device_id
> > 
> > Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index 9a27acd88926..506478ddede3 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -439,6 +439,13 @@ static int ad9832_probe(struct spi_device *spi)
> >  	return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> >  
> > +static const struct of_device_id ad9832_of_match[] = {
> > +	{ .compatible = "adi,ad9832" },
> > +	{ .compatible = "adi,ad9835" },
> > +	{},  
> I think Jonathan prefers to have a space separating the null terminator braces.
> 	{ },
Indeed, but just for the record, no trailing comma on 'terminating entries'.

Whilst that's not in the style guide that is pretty much default preference
across the kernel (unlike the bracket things which is my random choice :)

Jonathan

> 
> > +};
> > +MODULE_DEVICE_TABLE(of, ad9832_of_match);
> > +
> >  static const struct spi_device_id ad9832_id[] = {
> >  	{"ad9832", 0},
> >  	{"ad9835", 0},
> > @@ -449,6 +456,7 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
> >  static struct spi_driver ad9832_driver = {
> >  	.driver = {
> >  		.name	= "ad9832",
> > +		.of_match_table = ad9832_of_match,
> >  	},
> >  	.probe		= ad9832_probe,
> >  	.id_table	= ad9832_id,
> > -- 
> > 2.48.1
> >   


