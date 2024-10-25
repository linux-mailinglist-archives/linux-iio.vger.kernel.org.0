Return-Path: <linux-iio+bounces-11294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A89B0936
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EFA281642
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD0F172BB9;
	Fri, 25 Oct 2024 16:09:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C878816FF44;
	Fri, 25 Oct 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872543; cv=none; b=QUnupwe/ftqBAQuWjyf/C8OY7DrwLelr23CJCxzkTc4Z8zOF0umHHBzUUmcnfhheriSGtKH5u1A20tEbvaFTfINaOo34STX5GXg5yq+nEXj0z07TKnjQzPgDn8FpN/eQIMBPc+Zzu01txIyMrF0i1XZl5Fw2P78w8I+SoaZ5YTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872543; c=relaxed/simple;
	bh=zYjnBwvtGTqIrdDRx9LwMu2z0itwomSygbNeb4iemIk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhO5VTA/7VGqj4hvlcSg2M2ugGXnD4IqCmFv/x/+xbdmn98qaJDVoIv88EUDaSx1386vUreLk2v8h0S+s5xzVqfjSRzcLEMvh08ECO22qLBlBAWuTBeSATTxOmopP/5Vxirj+VZzoJh9Mfp1tAwPqNMeXuPqXqe2pwnKZdpQAX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XZnj31jzhz6K6Fx;
	Sat, 26 Oct 2024 00:06:47 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 32D6414039E;
	Sat, 26 Oct 2024 00:08:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 18:08:56 +0200
Date: Fri, 25 Oct 2024 17:08:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Stephen Rothwell
	<sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>, Arnd Bergmann
	<arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 iio-fixes tree
Message-ID: <20241025170855.00001f0a@Huawei.com>
In-Reply-To: <d5a57cad-7311-4075-8b6e-04f22ed510f7@gmail.com>
References: <20241023141015.0ec5346d@canb.auug.org.au>
	<22f9dbb6-ba5e-4c85-8aa2-6090008e7da4@gmail.com>
	<20241024184108.6eb3bdf0@jic23-huawei>
	<d5a57cad-7311-4075-8b6e-04f22ed510f7@gmail.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 24 Oct 2024 20:39:57 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 24/10/2024 19:41, Jonathan Cameron wrote:
> > On Wed, 23 Oct 2024 20:17:30 +0200
> > Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> >   
> >> On 23/10/2024 05:10, Stephen Rothwell wrote:  
> >>> Hi all,
> >>>
> >>> Today's linux-next merge of the char-misc tree got a conflict in:
> >>>
> >>>   drivers/iio/light/veml6030.c
> >>>
> >>> between commit:
> >>>
> >>>   de9981636774 ("iio: light: veml6030: fix microlux value calculation")
> >>>
> >>> from the iio-fixes tree and commit:
> >>>
> >>>   ed59fc90f38a ("iio: light: veml6030: drop processed info for white channel")
> >>>
> >>> from the char-misc tree.
> >>>
> >>> I fixed it up (the latter removed the line updated by the former) and
> >>> can carry the fix as necessary. This is now fixed as far as linux-next
> >>> is concerned, but any non trivial conflicts should be mentioned to your
> >>> upstream maintainer when your tree is submitted for merging.  You may
> >>> also want to consider cooperating with the maintainer of the conflicting
> >>> tree to minimise any particularly complex conflicts.
> >>>     
> >>
> >>
> >> Hi Stephen,
> >>
> >> I doubled checked the status of the driver in linux-next, and everything
> >> looks as it should: the first commit applied as a single chunk, as its
> >> second chunk affects lines that the second commit removed.
> >>
> >> Thank you for fixing it up.  
> > 
> > Not quite. This was a lucky merge issue as it highlighted something I'd
> > messed up.
> > 
> > A rare case of a fuzzy application of a patch picking the wrong block but still
> > giving a very plausible looking diff that fooled me.
> > 
> > I picked up the fix via a different tree from where you expected.
> > In char-misc-next / iio/togreg there is only one instance of this code block because
> > the larger driver rework removed one of the two that was in the tree that
> > iio-fixes is based on (effectively mainline).
> > 
> > The fix got applied to the one that is going away (which is going away because
> > the scale makes no sense on the intensity channel) not the illuminance / IIO_LIGHT
> > channel that was intended.
> > 
> > I've move it to the right block with the side effect that the merge conflict
> > should go away.  Javier, please check iio.git/fixes-togreg to be 100% sure
> > I haven't messed it up again.
> > 
> > Thanks Stephen for your hard work on linux-next!
> > 
> > Jonathan
> >   
> >>
> >> Best regards,
> >> Javier Carrasco  
> >   
> 
> What I see in iio.git/fixes-togreg is right in the sense that the fix
> fro the processed value (commit 63dd163cd61dd) is only applied to the
> processed value of the IIO_LIGHT channel, and not to IIO_INTENSITY.
> 
> The processed value of the IIO_INTENSITY channel should be then dropped
> at some point with the other patch, as it has already been done in
> linux-next/master.
> 
Yes. We may want to separately chase back dropping the processed
IIO_INTENSITY later given the issues that are left there.
Once the change is upstream, I'd be fine with that as a backported
fix.

Jonathan

> Best regards,
> Javier Carrasco


