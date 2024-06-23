Return-Path: <linux-iio+bounces-6782-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B07A913CE6
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369332832BD
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E55183070;
	Sun, 23 Jun 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MokcOLV7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1038BFA;
	Sun, 23 Jun 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161545; cv=none; b=Ip/LrY7U5MFD+gL7f3eK7BhFAKbqiN/XAcSg68wlg7Y8ZdqpkDkYVxoXTerWqsiPYe2pRtbS2o4YNFIxr7H/aE80wpC6lfKeoVeU0i0NzHUliME7aNWJGwW7sbZgeEJ3Oq54irnoB2kNf6h/hZ+My9bE7ZPcQ/A7kKd8Q92Wwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161545; c=relaxed/simple;
	bh=w3rWc4cJp3prvIAFS9iJKV4UQoSn7/pOlOMHaiefaAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpAkxsywrPbvzDzlaB7PptptjTKbr4QUTgKB3QBVm+eY7AvSHbIjd0BNlw74AzXw4hYRGH7f1EOidTphcdILdMXs7aojzOwE9VNybqccEUZXMaRk7hjjZnmVdAEiUNXrWY2+7k3iXPDM1DhPbckA6LTI0MZuXeFzKDFt16JA6yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MokcOLV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA50AC2BD10;
	Sun, 23 Jun 2024 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719161545;
	bh=w3rWc4cJp3prvIAFS9iJKV4UQoSn7/pOlOMHaiefaAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MokcOLV7qwP2dwx2+1oEOCymfbSejs20W+ZX5sMbFcGViO/GyKqQcpEiPYubmwIc1
	 ad846XLYn9i6s7H3BT+l2VEAzvgINUHQz9rntDlMBJrW3MaR0qRN+sriSuPzvOJhC/
	 6/WkRBvcOwA0dfmr70g1mQGszTwONFq5aE01fofAzg0r6WjC5rK/aUxsmTKBqvgMNt
	 eiVM+P+k2RKy1J4rOeqgsQ7FKTmn7veFw2+5B5BjREONSocVNjPqOZOlMoblkeMhZ1
	 NnV9+BTOkhqbVHE6UcX6PNG0NWb0dgF6xr1391u0AXlZtH71seIlx/LwpzL51UC7JY
	 TT0TqIMDh3yyw==
Date: Sun, 23 Jun 2024 17:52:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Mudit Sharma
 <muditsharma.info@gmail.com>, lars@metafoo.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, ivan.orlov0322@gmail.com,
 javier.carrasco.cruz@gmail.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, "Haikola, Heikki"
 <Heikki.Haikola@fi.rohmeurope.com>, "Mutanen, Mikko"
 <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 2/2] iio: light: ROHM BH1745 colour sensor
Message-ID: <20240623175216.6bb09390@jic23-huawei>
In-Reply-To: <6e5d6734-eae0-49fd-a1ed-beda00e37209@gmail.com>
References: <20240606162948.83903-1-muditsharma.info@gmail.com>
	<20240606162948.83903-2-muditsharma.info@gmail.com>
	<20240608172227.17996c75@jic23-huawei>
	<CANhJrGM9czj0RL3OLCgRHEKc2QOjG9P0AZTrZxvYUk65TCpHRg@mail.gmail.com>
	<20240611181407.00003f61@Huawei.com>
	<c9c0d585-617d-4181-afa2-c5743848f5c9@gmail.com>
	<20240615192348.182eb1b8@jic23-huawei>
	<6e5d6734-eae0-49fd-a1ed-beda00e37209@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > Gut feeling is normally people are actually cranking scaling of light
> > channels up and down together as hopefully they are approximately balanced
> > for 'white' giving similar scales on all sensors (by filters or fixed gains)  
> 
> I appreciate your insight on how people usually use these devices :) 
> It's very valuable to me.

Pah, never trust me on this stuff.  I've not been on the 'ground' with
real sensor for a long time and even then my use cases were far from typical.

These days I just play with big toys (though having just helped moved them
between buildings this week I can say that they are at least real and not all
in the cloud).

> 
> > and people would only need to care if they were trying to measure a weak
> > blue signal in a red world. If we have a case that doesn't work well
> > for that sort of global scaling (I can sort of see that as a possible
> > problem due to the transition states not being possible) then we
> > should make sure that one works!  
> 
> Yes. I think some users will eventually hit to a scale transition which 
> will be NACKed by the driver. Also, I don't think this problem will be 
> specific to the BU27034 sensor, but in some form this will be possible 
> for many gain-time-scale type devices. I just don't have a good generic 
> solution in my mind right now.
> 
> Oh, besides, it seems raining stopped. Time to turn off my computer and 
> go out to the yard :)

Wise!


> 
> Yours,
> 	-- Matti
> 


