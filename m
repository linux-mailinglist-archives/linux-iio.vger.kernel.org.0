Return-Path: <linux-iio+bounces-6060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7CA90124A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73943B2187C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB91791F2;
	Sat,  8 Jun 2024 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuR0clWC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044701FBB;
	Sat,  8 Jun 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717860044; cv=none; b=EMvCIYWAAgl6sl0uBG8abv2fI+Y/8KAXNDXXCSYNXXuXhjXv8PIhEQ5qFDjf/ytNNegP/fsKG0tLg7GPWcjdatQK9L2azXrdryzWg4W5O3eoukG/8TBFWRpx/TUwcyntqcH6Yw/Ivd0TxYcpTc5zUxOj4hoURqEwCalkH2vaeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717860044; c=relaxed/simple;
	bh=SBrOG5vtgHcP9Ql3D1Fkja1dS+krqo3w5B2YITbmwFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCR2XNP/jXV0JBec/U8x47MBQCB/v4b39DRqK2CsC3rdNOGJZhMxQi7f9klndU+DseJnNJBxo1K7rEyI3YuLSAvpU+oSa2xzzfROdMwbY6Sg1UT55bFKlh5DnHYTPb6Cl/WCsisTUodJmiS4iYeu95f38cUWjmfkCzu94RWk6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuR0clWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62DAC2BD11;
	Sat,  8 Jun 2024 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717860043;
	bh=SBrOG5vtgHcP9Ql3D1Fkja1dS+krqo3w5B2YITbmwFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CuR0clWCH/pu1MIadrb9SDLdxVu8abrLH02ZEcpbh3z+zU8iGdvCZxXWDAWm4os60
	 sjEAuaQxZZdZP5sNG6shs8cAv7JOwo6pKItN6YYBFeWETejGLAW9oBKqoAG9IfTxmw
	 vEBBBw4e4raMkXyWnHDHL9Of1WdCa8qroaFGPghwnQllB2QFMLjOZS3f0Er3rOae5B
	 KP//JGz+LaiM8tOnChOzMOej6wi2n5byFwoPagGtGb2XtCPBWH0un1dcsecR5CTnJ9
	 f4cUnRLwc/9kcj7ir6jV4hgU1XTSQKDGgeCebP15rVRRq6C/5/f84C2s6z6c643dkI
	 CCLka07fOPcXQ==
Date: Sat, 8 Jun 2024 16:20:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 ivan.orlov0322@gmail.com, lars@metafoo.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240608162035.6965cad5@jic23-huawei>
In-Reply-To: <14ac1188-a018-4ebb-bf64-7818fab9ab7b@gmail.com>
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
	<20240603162122.165943-2-muditsharma.info@gmail.com>
	<39710806-3151-4b57-9af4-c0b4a4d21c28@gmail.com>
	<c0732554-0742-444b-910d-55052e2c0f92@gmail.com>
	<5c4800f4-3345-415b-b4e0-0099f1d22770@gmail.com>
	<14ac1188-a018-4ebb-bf64-7818fab9ab7b@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >>>
> >>> Nit: black line before return (it applies to several functions in this
> >>> driver, but again, not in all of them).  
> >>
> >> Hi Javier,
> >>
> >> Thank you for the review on this.
> >>
> >> Can you please point me to resource/section of code style guide for
> >> reference which talks about new line before 'return'.
> >>
> >> Best regards,
> >> Mudit Sharma
> >>
> >>
> >>  
> > 
> > AFAIK that is not written in stone, but many common practices are not
> > documented anywhere (e.g. names of error/ret variables). They just copy
> > what the majority of the code in that subsystem does. There is indeed a
> > tendency to add a blank line before the last (unconditional, not
> > labeled) return, but I am sure that some code does not follow that.
> > 
> > Having said that, I don't have a strong opinion (it was a nitpick) on
> > that, but what I would definitely recommend you is following **some**
> > pattern. There are some functions where you added a blank line, and some
> > others (the majority, I think), where you didn't. Given that this is new
> > code, uniformity would be appreciated.
> > 
> > Unless an IIO maintainer (I am NOT one) says otherwise, I would find
> > both approaches (blank/no line) reasonable, even though I like the blank
> > line in that particular case :)
> > 
> > Best regards,
> > Javier Carrasco  
> 
> Thanks for the explanation here.
> 
> I agree with having a consistent pattern and will make the necessary 
> changes to v3.
> 
> Best regards,
> Mudit Sharma
> 
I'm feeling grumpy today and you are the unlucky ones, given it's
been a day of much scrolling.

Crop your replies to just the relevant context as I've done here.

Yes, I prefer the blank line in most cases. However as noted the more
important factor is local consistency.  Aim here is to make your code
as easy to review as possible - having it all look the same is a good
way to help that.

Jonathan
 


