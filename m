Return-Path: <linux-iio+bounces-18246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4EA938A6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A415818871F4
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF891925AF;
	Fri, 18 Apr 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeZMtLCP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1F15A87C;
	Fri, 18 Apr 2025 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986389; cv=none; b=TzEz3EJjaKBnrDjF5ETz06+hwqaScJyqHqxAYxuGqABAwSeTxpXWGkhURX0GtzEpEncYLl9UKcSNlr0+MN8ncxkwdmBzLM23a6ed5BqjuazRjfoYxPcDHNMEylnaaPhdMUJNSsG3TV6uAspNhDn8ZwhJwzjYn8ceQv8k8S9ljSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986389; c=relaxed/simple;
	bh=XI9iHwHqxWxBCu3gSyvbo+qrIDUyMLsG6fCN8jDhx24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OB9NlQEFW/Q+EeNdF7ft5d4jyt9NtkwSz7kFnkmkzBoSEIgdGGzi+ISk5Dguqyuko+H2I0Z8KPX+g9PiQzLGsoXB2RxoX/bzL6Bk+9lE26bzKCSWKTAzyUTPYssXJFmjlW91hp0OPh1NgCIs5cPh8PqC1w/kkAg18lJLBZXuPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeZMtLCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9DCC4CEEA;
	Fri, 18 Apr 2025 14:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986388;
	bh=XI9iHwHqxWxBCu3gSyvbo+qrIDUyMLsG6fCN8jDhx24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SeZMtLCPHp4jyi1cGZzmlFtMhnU3gDg0HVi78JjG0+iDLltOrGi21f/5UcwnJLf2S
	 85ok25uc9wmwXii2ZDCmOAo1k8uwUHbp2FU9arxUPAtv95CNd58dX/HaK1986A+Cri
	 9nFFsHtzCJTd61gi9zo2Dreopnv8C4AEW9Rus04PHciPNqxK8RfhHVBbYJmg+b3XL/
	 I/0eF400gu5tH8umkmBoNfN5ITTJx9zE9LuaA8YvGMtyY52Rbf6A5ojrDIvq5eL5ab
	 V/g1d588ZWnR1hv/v1ntQExbJbluuooabR8Was84CrNBSRxF8DGiMEV9RjuS3JghVX
	 Ij3jYlbT+plAQ==
Date: Fri, 18 Apr 2025 15:26:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Siddharth Menon <simeddon@gmail.com>, linux-iio@vger.kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2] iio: frequency: ad9832: devicetree probing support
Message-ID: <20250418152621.70c9511f@jic23-huawei>
In-Reply-To: <20250416185846.GA3735440-robh@kernel.org>
References: <20250322163211.253009-1-simeddon@gmail.com>
	<20250416185846.GA3735440-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 13:58:46 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sat, Mar 22, 2025 at 09:58:11PM +0530, Siddharth Menon wrote:
> > Introduce struct for device match of_device_id to avoid relying on fallback
> > mechanisms, which could lead to false matches against other AD9832 variants
> > in the future.
> > 
> > Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> > ---
> >  v1->v2:
> >  - updated commit message to be more informative
> >  - minor changes to code formatting
> >  drivers/staging/iio/frequency/ad9832.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> > index 140ee4f9c137..7d4f655f6df1 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -431,6 +431,13 @@ static int ad9832_probe(struct spi_device *spi)
> >  	return devm_iio_device_register(&spi->dev, indio_dev);
> >  }
> >  
> > +static const struct of_device_id ad9832_of_match[] = {
> > +	{ .compatible = "adi,ad9832" },
> > +	{ .compatible = "adi,ad9835" },  
> 
> Is there some reason we can't add a binding for this?
> 
It might take some thought on how to actually describe some aspects
of this device that aren't yet supported by the driver,
but in principle we certainly should.  For drivers that have been
in staging a long time I'm a little reluctant to do merge a binding
until we are fairly sure the driver is going to move out of staging though.

> 


