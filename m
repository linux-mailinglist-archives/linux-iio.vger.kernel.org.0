Return-Path: <linux-iio+bounces-3705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D78879E3
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 19:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1151F2177E
	for <lists+linux-iio@lfdr.de>; Sat, 23 Mar 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE025490C;
	Sat, 23 Mar 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJuYGwu+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F353E2B
	for <linux-iio@vger.kernel.org>; Sat, 23 Mar 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711217623; cv=none; b=e3b5C/Muxj8f9K/9tGRG8J7HCrRqtEc6x3gqVn2Hys2F6zzow2SHkKb1nMtngiIH4G2b92/KTEvBk1m5CZPXiVx+W26p/C0BTYAl0F93BWF/PqwMBIcru7L7HIGjATwMp3sDWkrAm9s7zb9zwDvu0zprI6JlK5cEOb34vxBoNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711217623; c=relaxed/simple;
	bh=fLsjEQtrI8UPeLBd7rjJo4xSTPjzR35jgeP3hgKwvyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg993EAa4KY1X8q/guryPMyrnDmEYejZsWXqq/YH/9TT5hgdpsMMYqFjS81q7Q8PdMIf95GkEbxEwEywRixVB986lyJ8ykdBrQ4uJfjA/KgRjoSHlWpO41QhzL0nFjXNdU8AXOqr5TA4kLDq1GTOVBEhj3XuyW27eDOVU6EHfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJuYGwu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689EFC433C7;
	Sat, 23 Mar 2024 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711217623;
	bh=fLsjEQtrI8UPeLBd7rjJo4xSTPjzR35jgeP3hgKwvyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJuYGwu++bQozHeodBML80CEYUYUoK0BUdQUoXCWIRpeHUg8Fgbl23CpfvHqJ/3gN
	 ow2AfWPDPUEc+LKAwJ/eXfsh0ArcOzkT07k9VKJ/+KHgtbWyez+OTvRmEUMlkfbd5E
	 e70bo6JNd71FcDu/F7dDyDrqLrMCAs+mNWaKF/D4Mwsn2hHixLBvcVpMj8AKdp7FSx
	 5ubtlNCFJSOH9M1Y/SDLNcyYvTxDQGbTFOBwSqXLWWPnTRr8Jq5CZZFOqdwyl6p1da
	 jc2iTAT0fizRy4m/P1lA45wL9Q3DO/Ua1Tizv1W2seVYeGmgWgKiVmty/5Vjiuj+Sw
	 AGWBhq8jX2PTA==
Date: Sat, 23 Mar 2024 18:13:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Chenyuan Yang <chenyuan0y@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <20240323181330.71048402@jic23-huawei>
In-Reply-To: <a9b12f52-c59a-455b-889c-786c0a2158e9@gmail.com>
References: <ZfHM73ZqgnCp6CZv@cy-server>
	<a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com>
	<ZfS0Rhk5WTJbwXU/@cy-server>
	<20240316134035.5eb47a69@jic23-huawei>
	<a9b12f52-c59a-455b-889c-786c0a2158e9@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 09:02:46 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan, all.
> 
> I am resending this as I don't think I found the mail from lore. I wrote 
> this using my phone so maybe it was sent as HTML and stuck to some 
> filters. If you receive this twice - I am sorry...
> 
> la 16. maalisk. 2024 klo 15.40 Jonathan Cameron <jic23@kernel.org 
> <mailto:jic23@kernel.org>> kirjoitti:
> 
>  > On Fri, 15 Mar 2024 15:49:10 -0500
>  > Chenyuan Yang <chenyuan0y@gmail.com <mailto:chenyuan0y@gmail.com>>
>  > wrote:
>  >  
>  > > Hi Matti,
>  > >
>  > > Thanks for your reply!
>  > >  
>  > > > I think the suggested-by tag is a bit of an overkill :) I don't feel
>  > > > like taking the credit - you spotted the problem and fixed it!  
>  > >
>  > > You did help me figure out the real issue here and how to fix it :)
>  > >  
>  > > > Do you think you could fix the removal of the duplicates too?  
>  > >
>  > > Sure, I can help to implement the deduplication logic.
>  > > Here is a potential patch for it based on your help.
>  > > Besides, I changed the stop condition in the inner loop to `j < idx`
>  > > since the current last index should be `idx - 1`.  
>  >
>  > Matti, I didn't follow why duplicates are a problem?  
> 
> The function here builds the tables for available integration times. 
> These are shown to users via sysfs (if I'm not mistaken) - and while the 
> user-space algorithms may tolerate dublicates, they are ugly (in my 
> opinon) when available times are manually listed.
> 
> 
>  > Sure the code is less efficient, but do we end up with a wrong
>  > answer as a result (I've not checked logic, but I'd expect either
>  > first or last of repeating values to be used depending on the alg).  
> 
> If we discuss completely omitting duplicated times from the driver 
> (which was one thing I referred in my previous mail) - then we are 
> likely to face problems as there can be register values, which then 
> can't be translated to times, read from a HW.
> 
> Eg, we need to have everything described in driver tables used for 
> driver's computations - but (in my opinion) we should drop duplicates 
> from these tables which we hand over via sysfs.
> 
All makes sense. Thanks for the explanation.

J
> Yours,
> -- Matti


