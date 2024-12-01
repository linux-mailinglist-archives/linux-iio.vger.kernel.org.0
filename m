Return-Path: <linux-iio+bounces-12908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB279DF467
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 03:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A72B20F2C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 02:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47857B665;
	Sun,  1 Dec 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ayGo0g6V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CEC79FD;
	Sun,  1 Dec 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733020344; cv=none; b=Ztt9vPTxevzNenhOw8Z/tQbjALcPw3AMkR+h0eKMIlqpEejiS48i3D6NUvm4kn0vwN5Qv6S8c59YbeGy4NwPn9UqWKDA1awUfGZ7+8xL1ujh2baAfV+1tSjHVpC0sQlYFbpFt9aBQ9a5mhvvIBcJro/3ztjc9qDS/2gPF35wigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733020344; c=relaxed/simple;
	bh=RZZtKohC1XvJ5nz0fjXOWMitmwZYdUfMh0yd0+o5EVk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CRIOi9IhNPRXbtlD5vdYwQ3TssLUs8DLWbqoNAXZP/dk70qL3ogZSYENabDaZNwGGvOSTPZlqeq4JA4l1qm9afBUb5lXc6cpbxOyq1qkcIHBVcDvT1wn6MIMpdaLk1+f44C7qSuSXfX5hQJGaPxAoWuWRdgPJL2f9VQGPGiyN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ayGo0g6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4DCC4CECC;
	Sun,  1 Dec 2024 02:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733020343;
	bh=RZZtKohC1XvJ5nz0fjXOWMitmwZYdUfMh0yd0+o5EVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ayGo0g6VejOYBmjKASbQJGUbDjUCNGj3KCcIvRowXikR6X29/sKR46PnfvIz3VmPg
	 Lpy3FKVKswQqpI6qYHcljFZ8kI1lGUePAxWTWVKEiharG9nyV/2BV3QY6HOKrnl2xT
	 SekAyoOewZDlNV5r/jpYVQq1nm33Yx5S7mtsv3PI=
Date: Sat, 30 Nov 2024 18:32:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Jonathan Cameron' <jic23@kernel.org>, 'Jakob Hauser'
 <jahau@rocketmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij
 <linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: magnetometer: yas530: Use signed integer type
 for clamp limits
Message-Id: <20241130183222.ecf271abffcff61b93bbae22@linux-foundation.org>
In-Reply-To: <6f2c9946a9fe4b40ac7dd5a66003c8c4@AcuMS.aculab.com>
References: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<9f5793f03c2440d2aa18630469df06df@AcuMS.aculab.com>
	<20241130143506.53973e40@jic23-huawei>
	<6f2c9946a9fe4b40ac7dd5a66003c8c4@AcuMS.aculab.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 20:59:22 +0000 David Laight <David.Laight@ACULAB.COM> wrote:

> From: Jonathan Cameron
> > Sent: 30 November 2024 14:35
> > 
> > On Sat, 30 Nov 2024 11:40:45 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> > 
> > > From: Jakob Hauser
> > >
> > > Copying Andrew M - he might want to take this through his mm tree.
> > 
> > I'm confused. Why?
> > 
> > Looks like a local bug in an IIO driver.  What am I missing?
> 
> The build test bot picked it up because a change to minmax.h that Andrew
> committed to the mm tree showed up the bug.
> To avoid W=1 builds failing Andrew had applied a temporary 'fix'.
> So he needs to be in the loop at least.
> I don't know the actual procedure :-)

Jakob's minmax changes
(https://lkml.kernel.org/r/c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com)
are queued in mm.git for 6.14-rc1.  They require a yas530 fix to build.

So as I need to carry this yas530 fix in mm.git I'd like to merge it as
a hotfix for 6.13-rcX, sometime in the next week or two.  So please
send acks!

