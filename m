Return-Path: <linux-iio+bounces-13680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2459F82B9
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 18:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF748169108
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD719AD5C;
	Thu, 19 Dec 2024 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MULLzKP3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D9198845;
	Thu, 19 Dec 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631105; cv=none; b=Zz4l5OdipBTIsRtle+taPA9oDvSarrn7uxwYm8ZL5zhofLJNxsdgg51pADArGjMIwLhXrxNL+V2Fd6ezoilYFqZKFPSu/HXjTYWoHVrXFpzDUkzOyBnFLq9vMiWuY0upMsXZKxDsVkLKDl43wAqa8hIgNZpaQdMlAcuhD5s1vQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631105; c=relaxed/simple;
	bh=7wCwtFksg50cHD8A+kd1Anc6XSnGUsUgCpIadOy0csc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqwYPHBYewW+I4kpGqTaG3Pf8Bzz/DoFyc6JFXqvUtKogrLPgRt65RsJS89P3wNQEFwKDT6rWhpxAt+VhS1GNBNkfDsl2G1Vn3UmUQCUlLn3ltLTReEB6hXZk+Xcmg0SXNNRjUAmsRwhmShG3Gw+3EeEHy3LvJ+Gqq53GGF76g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MULLzKP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFE8C4CED4;
	Thu, 19 Dec 2024 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734631104;
	bh=7wCwtFksg50cHD8A+kd1Anc6XSnGUsUgCpIadOy0csc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MULLzKP3rwLBahQWiKmfT/fjjBqUDLGVNnmy8YHd4yoMpP0J5vXReTeinaP0lyKJ9
	 CGSqtj+pOxB1ahCA9OBbbFrsGk+Er6KN7Vqmwg4wInTLfgGFamxf/ahPaHsnnpuEML
	 odfz5eFBb6/yz8hviGDadQyg3e+wHqi/iIO9m6Jz4IxmnKoB3R0avKWTWS9rA6sjh4
	 Qc0Yp+4KNhtfZfvJi959o51JbrIlgeo0EjI7+MbqnNO7K88DbobxwzCCfJ9yJSUtqU
	 MvwLrp0i3PzYHz+hrEncdBcyv1IZEFKlGa7N4OosiMubPpF7xKDIKSRDYeq4iP+qMV
	 YcNGJiCTqjmow==
Date: Thu, 19 Dec 2024 17:58:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v7 3/7] dt-bindings: iio: accel: adxl345: add
 interrupt-names
Message-ID: <20241219175815.797b376a@jic23-huawei>
In-Reply-To: <20241215-satisfied-expiring-9200ec935768@spud>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-4-l.rubusch@gmail.com>
	<20241214121057.5b12a236@jic23-huawei>
	<20241215-satisfied-expiring-9200ec935768@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 14:56:58 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Sat, Dec 14, 2024 at 12:10:57PM +0000, Jonathan Cameron wrote:
> > On Fri, 13 Dec 2024 21:19:05 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> >   
> > > Add interrupt-names INT1 and INT2 for the two interrupt lines of the
> > > sensor.
> > > 
> > > When one of the two interrupt lines is connected, the interrupt as its
> > > interrupt-name, need to be declared in the devicetree. The driver then
> > > configures the sensor to indicate its events on either INT1 or INT2.
> > > 
> > > If no interrupt is configured, then no interrupt-name should be
> > > configured, and vice versa. In this case the sensor runs in FIFO BYPASS
> > > mode. This allows sensor measurements, but none of the sensor events.
> > > 
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>  
> > 
> > Just to repeat what I sent in reply to v6 (well after you'd posted this).
> > Maybe we can maintain compatibility with the binding before this by adding
> > a default of INT1.  
> 
> But can you make that assumption? If we did, and it's not universally
> true, we break systems that had INT2 connected that previously worked.

I guess there is a possibility of a driver in some other OS assuming INT2, but
seems an odd 'default' choice.  Also odd for a writer of DT for a platform
to assume it.

There is a thing that comes up in spec orgs when discussing whether to
rush out an errata.  "Is this bug something people would get wrong
thinking the answer was clear, or something where the would ask a question?"
Anyone who thinks INT2 is the obvious choice for me falls into the would
ask category.

However, in the linux driver we would would go from assuming no interrupts
to assuming the wrong one.  That's indeed bad.  So I guess this doesn't work.
Oh well no default it is.

Jonathan

> 
> > Then you'd need to drop the dependency on interrupt-names.
> > 
> > I'm not sure though if the checking of number of entries will work against
> > a default. Give it a go and see what happens :)
> > 
> > We are lucky that we can't have bindings in the wild assuming ordering
> > of the two interrupts due to the maxItems being set for interrupts.
> > 
> > It's a messy corner, perhaps we should just not bother in the binding,
> > but keep that default handling in the driver?
> > 
> > DT binding folk, what do you think the best way of handling this is?  


