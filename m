Return-Path: <linux-iio+bounces-16562-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75416A57B40
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671673A71A7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFBF1DD0C7;
	Sat,  8 Mar 2025 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNIcDDZc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04611FC8;
	Sat,  8 Mar 2025 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445390; cv=none; b=R5INOqSBZq59u9Vqd1eGTgkeQjNTxX9JiKO1sR2mfCXYd0Ngqtrf2NOMNGY++zsxX3jI7MSd5Gh7eLw0lzc1S+OQ+hghi8iaTBKLW96Q7CXv2AFwIHsI6t7wHzdzVEAyLPm3825P1tu2FHAtLbdlusCABiWpYDmw1fbXJbyYCAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445390; c=relaxed/simple;
	bh=R8wIqEEh7oZBD4/sfetEpw/Svjr9aZZPk0tYe3G4/i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzBHRz9AvTey9L7GtGIGmO/lREmpUEg9i5G8NUgpJUM9YVMIYkuC4wpVT4DKAc1zlFUTYdYl6zqk5pgE5E5OkWfPIjQqsOVQyuU0ByzQzsuyR2FVuhkW3fJRSUiDr/eUArqFV4d3yCaIRkJcFBvctYcZh2SeSuirDqdx2VMN9Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNIcDDZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E321FC4CEE0;
	Sat,  8 Mar 2025 14:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741445390;
	bh=R8wIqEEh7oZBD4/sfetEpw/Svjr9aZZPk0tYe3G4/i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mNIcDDZcJ7rpK3ytm/2AB+YbYYCPtu4Jh9rIo1a2NZynXZa9BhED3KfBC5H1sd4xC
	 katP8D/ejb8x6XJ4LJwX/vUc6KH1rqW120vwj+KtZIOmxENelqPM966EKJCYb1ff4o
	 MWqw/qrOUmJGWocxfM/pkRZMm0//o7ifH9v69AKzX/y+AE672+f8EMrGJetUYR9+1t
	 DDNjF7ItGDr4zEipRCJK1tVYy28IX/91G4Rv4mBS01pURQX8OMm3NI0iMv5I4kxtoZ
	 P11fZsKsVGfH5GUffjUl6szRlfR0idgLNg1yJgyEyUGW4+SR26c9KDnyrxDiL/MdaY
	 WFJv3SSCcsG6Q==
Date: Sat, 8 Mar 2025 14:49:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com,
 gregkh@linuxfoundation.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, lars@metafoo.d
Subject: Re: [PATCH 0/2] iio: accel: adis16203: cleanup and standardization
Message-ID: <20250308144944.668d79b5@jic23-huawei>
In-Reply-To: <20250308144357.20f24fa6@jic23-huawei>
References: <20250305155712.49833-2-simeddon@gmail.com>
	<20250308144357.20f24fa6@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Mar 2025 14:43:57 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  5 Mar 2025 20:59:10 +0530
> Siddharth Menon <simeddon@gmail.com> wrote:
> 
> > This series improves the adis16203 driver by using standard unit macros
> > and removing an unused spi_set_drvdata() call.
> > 
> > Siddharth Menon (2):
> >   iio: accel: adis16203: Use units.h macros for voltage values
> >   iio: accel: adis16203: Remove spi_set_drvdata()
> > 
> >  drivers/staging/iio/accel/adis16203.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >   
> 
> I'm not going to apply these because I think you correct
> identified that the device support should just be added
> to the adis16201 driver and this one dropped.
> Good thing you were more awake on this than me ;)
> 
Sorry - wrong person.  
https://lore.kernel.org/all/20250306002645.1555569-1-danascape@gmail.com/

I'm definitely not awake today.

Jonathan

> Jonathan


