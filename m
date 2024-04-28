Return-Path: <linux-iio+bounces-4595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FD8B4CF1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC855281652
	for <lists+linux-iio@lfdr.de>; Sun, 28 Apr 2024 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEE871B48;
	Sun, 28 Apr 2024 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyLgsgw9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA771B40
	for <linux-iio@vger.kernel.org>; Sun, 28 Apr 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323465; cv=none; b=KXgbrXvTukB5JftZ2L9+yXFWjrBDE/9gRMy7eQgJ2yTOASyXe//eX4ZJPZuoNCC4naafWvD/uySm2LQtqkhpGOWcjqtoA6+k+3ceYo4/vq3PbpRuFk1oWXxcrLdceB7szvSxKHwQVTXXBltCCg+wTy3T+QxQMbNAvNWhp3/2/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323465; c=relaxed/simple;
	bh=MHGVRkzc8HMkDUwtgC11atxOGvKLlNdrOYBNZ9VUcmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzK7IKCvHppHzfgOQjGEqAKT26AbxzZ+gphvQW8VAM/blrtdWDWNvnO+msbygGOm29fTt0+fio2p1ghAyz4p6h7YoGLVp/W3BGW9M880sj/UF7RMwZ3A0cbu1deZ/iqTmOe2H3Labk0BQNIXclHn/Udbn6Mi8z1Lwv3zC4VO4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyLgsgw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC2AC113CC;
	Sun, 28 Apr 2024 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714323464;
	bh=MHGVRkzc8HMkDUwtgC11atxOGvKLlNdrOYBNZ9VUcmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oyLgsgw9AG6CykG1VmxtgTsqYdvP9pqAOcN7PXPwMsYYa9IyNf/71Mb3Z0S/mh35N
	 G8QyyicJAoc+lhBHBTw908xdXZhT6fFG6dT5tEu99CMNf7XyvCaTnt8UwU8U7LyYb1
	 vxgD88VbpRXQj0H6ZTQ7bpq1aiCcVKLFvbmlbpXZMd0dY6uf7PMrB6Jh5OZbCjdRF+
	 rUaxE4e0CH0y2tCCYeeysoG3JO1GIkAFlcJXDkBNCHcdZyDtjDMXLjeDy4PlolEaCd
	 pEDNbSxeQCilo955j4vFiRS/I+ekysTKMSXDqcRst1LuM/p4ACg2QZpZGy9l+HJ87S
	 S/6FtS7oSTHbg==
Date: Sun, 28 Apr 2024 17:57:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <20240428175735.667b3101@jic23-huawei>
In-Reply-To: <CANhJrGPsdY+ReiOrVsXCCvTCoVEV0vqcyFyEMB8AS+ae5JBBOQ@mail.gmail.com>
References: <ZfHM73ZqgnCp6CZv@cy-server>
	<a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com>
	<ZfS0Rhk5WTJbwXU/@cy-server>
	<20240316134035.5eb47a69@jic23-huawei>
	<a9b12f52-c59a-455b-889c-786c0a2158e9@gmail.com>
	<20240323181330.71048402@jic23-huawei>
	<b7b28fff-ffd5-41d7-be56-b480dd28329a@gmail.com>
	<CANhJrGPsdY+ReiOrVsXCCvTCoVEV0vqcyFyEMB8AS+ae5JBBOQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 08:52:54 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan, Chenyuan,
> 
> to 11. huhtik. 2024 klo 15.20 Matti Vaittinen
> (mazziesaccount@gmail.com) kirjoitti:
> >
> > On 3/23/24 20:13, Jonathan Cameron wrote:  
> > > On Wed, 20 Mar 2024 09:02:46 +0200
> > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > >  
> > >> Hi Jonathan, all.
> > >>
> > >> I am resending this as I don't think I found the mail from lore. I wrote
> > >> this using my phone so maybe it was sent as HTML and stuck to some
> > >> filters. If you receive this twice - I am sorry...
> > >>
> > >> la 16. maalisk. 2024 klo 15.40 Jonathan Cameron <jic23@kernel.org
> > >> <mailto:jic23@kernel.org>> kirjoitti:
> > >>  
> > >>   > On Fri, 15 Mar 2024 15:49:10 -0500
> > >>   > Chenyuan Yang <chenyuan0y@gmail.com <mailto:chenyuan0y@gmail.com>>
> > >>   > wrote:
> > >>   >  
> > >>   > > Hi Matti,
> > >>   > >
> > >>   > > Thanks for your reply!
> > >>   > >  
> > >>   > > > I think the suggested-by tag is a bit of an overkill :) I don't feel
> > >>   > > > like taking the credit - you spotted the problem and fixed it!  
> > >>   > >
> > >>   > > You did help me figure out the real issue here and how to fix it :)
> > >>   > >  
> > >>   > > > Do you think you could fix the removal of the duplicates too?  
> > >>   > >
> > >>   > > Sure, I can help to implement the deduplication logic.
> > >>   > > Here is a potential patch for it based on your help.
> > >>   > > Besides, I changed the stop condition in the inner loop to `j < idx`
> > >>   > > since the current last index should be `idx - 1`.  
> > >>   >
> > >>   > Matti, I didn't follow why duplicates are a problem?  
> > >>
> > >> The function here builds the tables for available integration times.
> > >> These are shown to users via sysfs (if I'm not mistaken) - and while the
> > >> user-space algorithms may tolerate dublicates, they are ugly (in my
> > >> opinon) when available times are manually listed.
> > >>
> > >>  
> > >>   > Sure the code is less efficient, but do we end up with a wrong
> > >>   > answer as a result (I've not checked logic, but I'd expect either
> > >>   > first or last of repeating values to be used depending on the alg).  
> > >>
> > >> If we discuss completely omitting duplicated times from the driver
> > >> (which was one thing I referred in my previous mail) - then we are
> > >> likely to face problems as there can be register values, which then
> > >> can't be translated to times, read from a HW.
> > >>
> > >> Eg, we need to have everything described in driver tables used for
> > >> driver's computations - but (in my opinion) we should drop duplicates
> > >> from these tables which we hand over via sysfs.
> > >>  
> > > All makes sense. Thanks for the explanation.  
> >
> > Hi Chenyuan
> >
> > I don't think I have seen a patch fixing this merged? Do you know if I
> > have just missed it? If not, do you still plan to send a fix to this or
> > should I do it?  
> 
> Jonathan, seems like Chenyuan has gone offline. I'd like to get this
> fixed as it'll bite us sooner or later if left like this. What's the
> right way to proceed? Should I craft a patch and add signed-off or
> suggested-by from Chenyuan as he has done most of this already?

If it's closely related to Chenyuan's original patch, keep the authorship
the same and add a Co-developed-by + sign off for yourself.

If you end more or less writing a fresh patch, then a Suggested-by is fine.

Jonathan

> 
> Yours,
>    -- Matti
> 
> > --
> > Matti Vaittinen
> > Linux kernel developer at ROHM Semiconductors
> > Oulu Finland
> >
> > ~~ When things go utterly wrong vim users can always type :help! ~~
> >  
> 
> 


