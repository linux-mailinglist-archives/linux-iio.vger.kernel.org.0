Return-Path: <linux-iio+bounces-4773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C48BA8A6
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E51F22964
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386CE148853;
	Fri,  3 May 2024 08:25:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59427148834
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724722; cv=none; b=uIS96HA4ZXvS9bizfwlqGn1+/RjJPGCfks2a3OCFD1wetmlRwDIFMmP8KJBFIK27LIS4t2ItBkQcnijSzhO6bJhh9xYXKQHK2x3d2BV0T/6xfeOxAzNlwq+S0XtIL/eZoj0runghJw2UHBMuNJ+fdLVoyWt1tcNLGDEOtW9yi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724722; c=relaxed/simple;
	bh=UTRkY+Pw9Q0Im/N9foA1h8L1W+CPEXKy5IBaEhVwEMY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gimhl83G0WTPV1i7Hsir9LFye0kT+Y4RzeUm+mzXrbMAM8X9BBfz2BPAfvrtgJC7V57IKPAWuW1i+JS5nmV9G8wsELDab4ziJJK19wu488KUZ4nnb6WruMn8Ofl0WLLwGMhv+0GsAtt6SlDYmbQeNems1xLdGJrF5fHyChYVCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VW3h15gmFz67HQ8;
	Fri,  3 May 2024 16:22:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FB571402CB;
	Fri,  3 May 2024 16:25:15 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 May
 2024 09:25:15 +0100
Date: Fri, 3 May 2024 09:25:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO: 2nd set of new device support, features and cleanup
 for the 6.10 cycle
Message-ID: <20240503092513.00001f88@Huawei.com>
In-Reply-To: <2024050301-thumb-clustered-8b59@gregkh>
References: <20240502201509.14ae8880@jic23-huawei>
	<2024050353-compel-daycare-f7ce@gregkh>
	<2024050321-preshow-unaired-01de@gregkh>
	<2024050358-chooser-egotistic-59e5@gregkh>
	<2024050301-thumb-clustered-8b59@gregkh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 3 May 2024 07:23:31 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, May 03, 2024 at 07:22:10AM +0200, Greg KH wrote:
> > On Fri, May 03, 2024 at 07:21:43AM +0200, Greg KH wrote:  
> > > On Fri, May 03, 2024 at 07:16:02AM +0200, Greg KH wrote:  
> > > > On Thu, May 02, 2024 at 08:15:09PM +0100, Jonathan Cameron wrote:  
> > > > > The following changes since commit 84e79a7f63e8caeac0c1a0817408860875a9b23e:
> > > > > 
> > > > >   Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next (2024-04-23 21:31:45 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10b  
> > > > 
> > > > Pulled and pushed out now, thanks.  
> > > 
> > > Oops, nope, got the following error:
> > > 
> > > Fixes tag: Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
> > > 	Has these problem(s):
> > > 		- Subject has leading but no trailing quotes
> > > 
> > > I'll rewrite this one, but note that you will have to rebase your tree
> > > now, sorry.  
> > 
> > Here's the full error, was cut off one line:
> > Commit: a5918cecaec3 ("iio: invensense: fix timestamp glitches when switching frequency")
> > 	Fixes tag: Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
> > 	Has these problem(s):
> > 		- Subject has leading but no trailing quotes
> >   
> 
> Nope, no fixup on my side, that just messed the whole tree up.  Can you
> fix this on your end and send a new pull request?

Sorry!  I messed up fixing that tag and I guess it didn't get flagged because there
was a very similar issue the day before in next or I didn't leave it long enough
for next checks to find it again.

I obviously need to check why the checking script / workflow I use didn't catch this.

I've fixed up the tree up, but it will be this evening before I have my signing key
available to send a revised pull request.

Thanks and sorry for wasting your time :(

Jonathan



> 
> thanks,
> 
> greg k-h
> 


