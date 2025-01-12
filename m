Return-Path: <linux-iio+bounces-14196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB84A0A933
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFEA3A72EE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537221B3925;
	Sun, 12 Jan 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGDA+BpP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E03C1F;
	Sun, 12 Jan 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685567; cv=none; b=hZEciJtPfb9lf4/505dgJR1AnrmpSQBOhVPjaiqqBwtnnyb8A9JTE9+aIg89PUqj4iUqF95HWDZmVOclq6UXvPuTniLR5PATXkdGFWOF+pavevhFTb4PgUoK2sw8dnYyQMw0FU1afjNq7fyAhL5rIOxcOJHdhNpVFF6YAYER6mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685567; c=relaxed/simple;
	bh=/EFhA9xA2Ubvb3DHv1pSzisNFSPYAFmGXK1rjtLYaVU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJ2AxTqMJYdFFp3lg4YzSpkE11VkxXgHv5Wb9OnKLhveq9KJk69xTMeyK4qTFs3Ay/LgKXbcvn+086xGKIf8LznqplTquFiweSSj+t9MXFq6rhFTu8jC/PjKCP8XxJdMC7DLxRtZKtY4fiWHUF8YlQ2PqLR0o9jXKpCH6Mfa2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGDA+BpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ADCC4CEDF;
	Sun, 12 Jan 2025 12:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736685566;
	bh=/EFhA9xA2Ubvb3DHv1pSzisNFSPYAFmGXK1rjtLYaVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YGDA+BpPTr1UdRPsl4qa2VyHuoqudV6c1AXijita433fGQsPnpNfmWP2I+1v66NZP
	 nOvOoR6PGMpYnJfWXQyjnBJAIGhb7AlSaZ+/BKPZni/hHNO5KyLA+fqPmi7cBc/NpI
	 OwBNXje1/g4UDEzxp80vlISuZflCuwLBdGH7Wa62FjpeomasYGyMVn7uY75R4td/ON
	 NU4SfBVHsx5b+PHTYmk5azjvnc3xPH6q/CpC/SklVxvJ9eqSckpdgUVwvzrIam/CKs
	 mBYFB+JQwauC9B4qrC6RrhmF0HuLcU3xUrfM/E1powZPA3YXDtf5ZdBWVGfz+nGoSQ
	 JbFkjNYt1aS0Q==
Date: Sun, 12 Jan 2025 12:39:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v1 09/15] iio: adc: ad7768-1: Move buffer allocation to
 a separate function
Message-ID: <20250112123916.73d3617f@jic23-huawei>
In-Reply-To: <Z4GYv9YmT38OgQAn@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<319a685855eb4b942e05e456a37319d3f73f7cd4.1736201898.git.Jonathan.Santos@analog.com>
	<Z4GYv9YmT38OgQAn@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 19:01:35 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/07, Jonathan Santos wrote:
> > From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > 
> > This change moves the buffer allocation in a separate function, making
> > space for adding another type of iio buffer if needed.
> > 
> > Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > ---
> >  drivers/iio/adc/ad7768-1.c | 64 ++++++++++++++++++++++----------------
> >  1 file changed, 37 insertions(+), 27 deletions(-)
> >   
> ...
> > @@ -625,37 +661,11 @@ static int ad7768_probe(struct spi_device *spi)
> >  		return ret;
> >  	}
> >  
> > -	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > -					  indio_dev->name,
> > -					  iio_device_id(indio_dev));
> > -	if (!st->trig)
> > -		return -ENOMEM;
> > -
> > -	st->trig->ops = &ad7768_trigger_ops;
> > -	iio_trigger_set_drvdata(st->trig, indio_dev);
> > -	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> > -	if (ret)
> > -		return ret;
> > -
> > -	indio_dev->trig = iio_trigger_get(st->trig);
> > -
> > -	init_completion(&st->completion);  
> 
> Isn't the completion also used for single-shot reads?

If so, it should be left in the caller given that. Makes not functional
difference but prevents implication that it is only used for triggered buffer
cases.

> Well, if triggered_buffer_setup fails the whole probe fails and we never get to
> do a single-shot read, but that makes me wonder ... why don't we ever try to
> recover from iio_triggered_buffer_setup()? Should we ever do so?

Nope :)  For it to fail, something is going horribly wrong. Most likely
a bug, so I'm not seeing any reason to carry on.

> 
> > -
> >  	ret = ad7768_set_channel_label(indio_dev, ARRAY_SIZE(ad7768_channels));
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = devm_request_irq(&spi->dev, spi->irq,
> > -			       &ad7768_interrupt,
> > -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > -			       indio_dev->name, indio_dev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> > -					      &iio_pollfunc_store_time,
> > -					      &ad7768_trigger_handler,
> > -					      &ad7768_buffer_ops);
> > +	ret = ad7768_triggered_buffer_alloc(indio_dev);
> >  	if (ret)
> >  		return ret;
> >  
> > -- 
> > 2.34.1
> >   


