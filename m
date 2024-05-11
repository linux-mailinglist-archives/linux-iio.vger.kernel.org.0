Return-Path: <linux-iio+bounces-4955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6B8C311F
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03581C20C39
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 11:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B943255C26;
	Sat, 11 May 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aay+PLzq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6358F2F26;
	Sat, 11 May 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428763; cv=none; b=mxvAJWBAcbHZe26vsbPbiD1x9pDwliYIoI0QwWZLoGesk6vRjNm1DlsQ+xaqTF3qb/I8HpJC2Os0s5t4bEQbRS6fGQSbjdS9itgmzBD3NGBvfWKk2zrjUzJLqIcGq/61uPbuSaXf5SxFONqhJ7+m1mQsWqGyNNFoQ4wlLFXnGXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428763; c=relaxed/simple;
	bh=ewewQeHMxrtOWqA/HQOi5zrRUH//pG5ayxcyfM2myGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj49vWK8yl7AYk6FRyWPLtEekCe6tEd/rVOjg8KA4zV1rOiZCceiT/YY2fpGQ4bhie+5eSeFk1lQIupCkCPzk1Ba9bfsQgThJUCvYyl43b535cUUJjF1+oWbbdNh/VnoEl0KLfdgW/n0ep6GKoMdzNg3lJ8Cfrl6T2fbgT6dlwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aay+PLzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F830C2BBFC;
	Sat, 11 May 2024 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715428762;
	bh=ewewQeHMxrtOWqA/HQOi5zrRUH//pG5ayxcyfM2myGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aay+PLzqN9AOAKa5kSJmgKxh3pCYgtHWOpK0jF5l3SUAWofElY4pLrThFlW/BPxeq
	 6Nholz9eM4457oAomxiP61F6J+81IzZnWcB9WroRh4Zwx5CYz1F6UEIJ3+sQT9Ld+c
	 mf7ZE3US00rSsUTJnrqIkC+lDxFsl00nFjHein2MoEX6AZxToR1kNT0D9aRcAHUeGb
	 wVS2ms1bq4kafEzgng4ZBLPL6RJKIsENA1SziUGkkCHHv/KKhFwHCa10px3Qq3hLuA
	 qBJUHdLLz5g/MUp5WmMz9CJ8lsFuc3fr0geKKeDg0ek5Y80giO5FXJEzXauEqVMPR9
	 Lc1ehBkKWdbXw==
Date: Sat, 11 May 2024 12:59:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v2 1/2] iio: imu: bmi160: add support for bmi120
Message-ID: <20240511125910.18e874cf@jic23-huawei>
In-Reply-To: <20240511125436.520e3ff4@jic23-huawei>
References: <20240504-bmi120-v2-0-3b3ce6e1c3c6@gmail.com>
	<20240504-bmi120-v2-1-3b3ce6e1c3c6@gmail.com>
	<CAMknhBFUOUy+TVi+baCN-FoLT8N=G4vOD5CgVgaKzvsu502CDQ@mail.gmail.com>
	<20240511125436.520e3ff4@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >   
> > > +       }
> > > +
> > > +       return -ENODEV;
> > > +}
> > > +
> > >  static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> > >  {
> > >         int ret;
> > > @@ -737,12 +753,10 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
> > >                 dev_err(dev, "Error reading chip id\n");
> > >                 goto disable_regulator;
> > >         }
> > > -       if (val != BMI160_CHIP_ID_VAL) {
> > > -               dev_err(dev, "Wrong chip id, got %x expected %x\n",
> > > -                       val, BMI160_CHIP_ID_VAL);
> > > -               ret = -ENODEV;
> > > -               goto disable_regulator;
> > > -       }
> > > +
> > > +       ret = bmi160_check_chip_id(val);
> > > +       if (ret)
> > > +               dev_warn(dev, "Chip id not found: %x\n", val);    
> > 
> > This changes the error with probe failure to a warning, but the commit
> > message doesn't explain why. We always want to know why changes were
> > made. :-)
> > 
> > Should also probably be in a separate patch since changing the
> > behavior here is a separate change from adding support for a new chip.  
> True, separate patch would be ideal as maybe someone will backport this change and
> not the rest.

Given I'd already picked up v3, I added a note on this to the commit rather
than splitting it.

I doubt anyone will care about dragging in bmi120 IDs along with the relaxation
of matching if they just want the relaxation.

Jonathan

> >   
> > >
> > >         ret = bmi160_set_mode(data, BMI160_ACCEL, true);
> > >         if (ret)    
> > 
> > ...  
> 
> 


