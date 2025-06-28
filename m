Return-Path: <linux-iio+bounces-21036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7BAEC829
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004BF17E307
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023A23CEE5;
	Sat, 28 Jun 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnYRt0vt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFA17A30F;
	Sat, 28 Jun 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123451; cv=none; b=HfP4OIng6zH/fFSpr8eysFCrq9RQCZeqHoCFXRxX36YS1zZKad5RuKm2+RPXPFlY9pR8ar2hWmxSYA4RGm4bRkZCiHNp4EtTmCSzRBEumiZmO3ESU27X24p8+pbM4qBld172WdrwyiCUjshF1VoJqT+lu3ihqI9Tx2T07L37eRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123451; c=relaxed/simple;
	bh=eLsqj/fOVCPWf9o+Sbx0y/JVneX7UpFssHR5B8t2+mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4PIB0DJLYQqsvITZilnSBB5ZsFAPQehSRryQU5iTze2BEKzMISfqU7CJ5Ao09njRdWoFtc8BvWrMPo6T/SAM1FxBXDIl54z40aFcxHZRZQwD+W8LdzaM4rSPum5s/Bvzx3GjJsimFo1A0KkZyPvYMUaqXO/OOlg8UqcQikoaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnYRt0vt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3A2C4CEEA;
	Sat, 28 Jun 2025 15:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751123450;
	bh=eLsqj/fOVCPWf9o+Sbx0y/JVneX7UpFssHR5B8t2+mk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AnYRt0vt/m4FcrDhVlA0Q/LiE1SRbWaroFZOG+8/hYqOz3W2ZYmgORlWpe3/SEf0r
	 h4+hTatOTlDHF5/V9jJ06+I6zEbX+LDd34C/NoTQWqrN33VZSj+9P3oMtqyJ84SG1S
	 S9no5GXCiO0YzvH0BIGhqrozZQHNwPqOKBK2Lpg7q2mXINGm2caWRHHCBor4YbI1lE
	 2PxiSfzZWtpk/+A84ggF5MdskNITCpMX+UiwPju6ixUDUDWAPEc+7h2qc72A6dtFMU
	 3KCAeT0PntBbvJEY3BlNaqy8YrDoVMCUalpkhx94UYBddqb1r7ltlAheZpBYDGRgX/
	 0VWf2HQ1F9y6Q==
Date: Sat, 28 Jun 2025 16:10:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Gabriel Shahrouzi
 <gshahrouzi@gmail.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "open
 list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Subject: Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
Message-ID: <20250628161040.3d21e2c4@jic23-huawei>
In-Reply-To: <2025062815-resolute-cornflake-48c4@gregkh>
References: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
	<2025062815-resolute-cornflake-48c4@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 07:08:46 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Jun 27, 2025 at 08:51:14PM +0300, Abdalla Al-Dalleh wrote:
> > - drivers/staging/iio/frequency/ad9832.c: Changed .h file location
> > - drivers/staging/iio/frequency/ad9832.h: Removed struct definition
> > - include/linux/iio/dac/ad9832.h: Added header file according to the
> >   TODO note.
> > 
> > Signed-off-by: Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c |  3 +--
> >  drivers/staging/iio/frequency/ad9832.h | 23 ------------------
> >  include/linux/iio/dac/ad9832.h         | 33 ++++++++++++++++++++++++++  
> 
> Staging drivers need to be "self-contained" for now.
> 
> Why do you even need a .h file for a single .c file anyway?  Why not
> just remove it?
> 

Better yet would be to switch away from platform data as that belongs
to a long gone era.

However in this case it's all a bit pointless as we don't normally support 'power
up settings' of things like this. Power up state until someone opts in
should be to output nothing at all. That should be same as before the driver
loads if the device doesn't have non volatile storage to save a requested
setup from a previous boot.

The policy decision on what to output is a user space script problem, not
something that we should provide from firmware.

Jonathan


> thanks,
> 
> greg k-h


