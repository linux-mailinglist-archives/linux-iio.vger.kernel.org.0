Return-Path: <linux-iio+bounces-4910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B338C0F6E
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E52B2139F
	for <lists+linux-iio@lfdr.de>; Thu,  9 May 2024 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2852514AD3A;
	Thu,  9 May 2024 12:15:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E112F5B3;
	Thu,  9 May 2024 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256924; cv=none; b=WC9ak9MUo0smBj8ZNDS4rIa3hHBi2XP6E+JyHg3xvqEpKG6UcE+ObdTi4dxmMpfAJqm+zugaFMdN+FsewIDwGcGxGUf6yFMoHpH5Eq20GOn6MF9WHxB3tDuZ9vvX2EDxuWnAqu/WTIwD/s3smOjSDUwEkxgztH40UIwLy2pnynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256924; c=relaxed/simple;
	bh=zWT3ymlFxwD1jj5/NTWP2UJ28d/C7S3KjCv0sFfGABM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLcZETkR9YwfBgb510umLjLvdIBQ7FeZ4wJHOvYr4KE1tLd37bS6QBE4pAxnri2mAm/SHQuJdwmGIVx1ghQtiGC+bY+8dXPIUEtF/YhFm96SfwAkLE+r82cMopSdZv+EWgD8a3kf1LIm5RDP4hxUdUJfdn003dQjJOkpaiw+CBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZrVR1JScz6JB46;
	Thu,  9 May 2024 20:12:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 79801140B33;
	Thu,  9 May 2024 20:15:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 May
 2024 13:15:17 +0100
Date: Thu, 9 May 2024 13:15:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Matti Vaittinen
	<matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chenyuan Yang
	<chenyuan0y@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix the iio-gts-helpers available times table
 sorting
Message-ID: <20240509131516.000049d4@Huawei.com>
In-Reply-To: <f5215081-c993-4147-8c50-fba1f56279b4@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
	<20240505185027.18809bfd@jic23-huawei>
	<11a16488-7f5f-4d53-a091-9cedcab76dc8@gmail.com>
	<20240506135356.7babe20f@jic23-huawei>
	<f5215081-c993-4147-8c50-fba1f56279b4@gmail.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 7 May 2024 09:14:15 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 5/6/24 15:53, Jonathan Cameron wrote:
> > On Mon, 6 May 2024 08:09:27 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 5/5/24 20:50, Jonathan Cameron wrote:  
> >>> On Tue, 30 Apr 2024 15:44:26 +0300
> >>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>>      
> >>>> Fix the available times table sorting in iio-gts-helpers
> >>>>
> >>>> This series contains a fix and test for the sorting of the available times in
> >>>> IIO-gts helpers. Fix was originally developed and posted by Chenyuan Yang.
> >>>>
> >>>> Revision history:
> >>>> 	v1 => v2:
> >>>> 	  - Fix the sender for patch 1/2 (Sic!)
> >>>> 	  - Fix Co-Developed-by tag (drop this from Chenyuan who
> >>>> 	    is the original author)
> >>>> 	  - Fix the From: tag as instructed in:
> >>>> 	    https://www.kernel.org/doc/html/latest/process/submitting-patches.html  
> >>>
> >>> Am I right in thinking this doesn't matter for existing drivers?  
> >>
> >> I think this is right. Only couple of in-tree drivers are using these
> >> helpers for now, and all of them sorted the tables already in driver.
> >>  
> >>> As such not high priority for back porting?  
> >>
> >> The bug is pretty nasty as it causes invalid memory accesses. Hence I'd
> >> like to see this landing in the longterm kernels. It seems to me the GTS
> >> helpers got merged in 6.4, so getting the fix backported to 6.6 might
> >> make sense.
> >>  
> >>> I'll assume that and queue it up for 6.11. If someone shouts I can pull the fix
> >>> forwards, but then we have the mess of chasing the testing in later.  
> >>
> >> I am sorry Jonathan but I'm not quite sure what you mean by "pulling fix
> >> forward", or what is the "mess of chasing the testing in later" :)  
> > 
> > Hmm. That was an odd choice of words :)  I just meant that I could send
> > the fix in the first set of fixes after 6.10-rc1 rather than waiting for 6.11.  
> 
> Oh, right :)
> 
> > For now I'll leave it queued for 6.11 on the basis there are a lot of ways
> > a driver writer can cause similar out of bounds accesses and they should
> > notice it not working during testing.  So it 'should' not be a problem to
> > not rush this in.
> >   
> 
> I guess this means the 6.10 won't have the fix? I believe this is fine - 
> assuming the 6.10 is not going to be an LTS. Thanks for taking care of 
> this! :)
It may well get backported anyway, but after 6.11 merge window.

J
> 
> Yours,
> 	-- Matti
> 
> 


