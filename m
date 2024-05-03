Return-Path: <linux-iio+bounces-4769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD898BA695
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 07:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2AC283096
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 05:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7F713958F;
	Fri,  3 May 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fdIAFtXQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1AB2C181
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713814; cv=none; b=WKrgKI84BcEuk07TO6wr2RrsbXOKiG9Gn2/TBIXwDyZzYdN83F37t7KjLT8a7SztBaR8Bu++eXZAn3rCq/mAYzYWAdzF+roTBA+1wVRMN4ph4ii+lE45dM8DeN1v1HTqfteVRVDksqEC8xqrcjoJ8PeQzBu1SiMVOWPamd7weoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713814; c=relaxed/simple;
	bh=d86FHP7UKHWwuLitmVkGcc26N0dHmEbOz9MKiG03eTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd+MmFP10XmijIKJIXe8rF4zqAJVjg18yswU5mw/SnBMnpfyLji2puSs6p+ZkJZyOZkkL7Yn2cJvnHCZ6R51B9ABkwYybHyvUgT4OyhcHUJjbgyej2UoyYxtCkbAvx/YYpcpGQzhgB3vq+sLR2uoySfyW3iNeNzsZBD/woUZwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fdIAFtXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC058C116B1;
	Fri,  3 May 2024 05:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714713814;
	bh=d86FHP7UKHWwuLitmVkGcc26N0dHmEbOz9MKiG03eTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdIAFtXQxamSNvfIug7AXSf2EE7gWiGOsaclq/wrF9IgNwxbEw0Yz0r7lm7WUzp0U
	 aDLU07aiC53/3uF4dU2MPrYV1LLLR7bO+Bfg8YLPjf3FI6A/4QEx0PUWBM96YXK8K0
	 RjL/kI61wk86gNIZ2Irig5Yax16pMmyVTJCEBO5A=
Date: Fri, 3 May 2024 07:23:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, features and cleanup
 for the 6.10 cycle
Message-ID: <2024050301-thumb-clustered-8b59@gregkh>
References: <20240502201509.14ae8880@jic23-huawei>
 <2024050353-compel-daycare-f7ce@gregkh>
 <2024050321-preshow-unaired-01de@gregkh>
 <2024050358-chooser-egotistic-59e5@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024050358-chooser-egotistic-59e5@gregkh>

On Fri, May 03, 2024 at 07:22:10AM +0200, Greg KH wrote:
> On Fri, May 03, 2024 at 07:21:43AM +0200, Greg KH wrote:
> > On Fri, May 03, 2024 at 07:16:02AM +0200, Greg KH wrote:
> > > On Thu, May 02, 2024 at 08:15:09PM +0100, Jonathan Cameron wrote:
> > > > The following changes since commit 84e79a7f63e8caeac0c1a0817408860875a9b23e:
> > > > 
> > > >   Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next (2024-04-23 21:31:45 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10b
> > > 
> > > Pulled and pushed out now, thanks.
> > 
> > Oops, nope, got the following error:
> > 
> > Fixes tag: Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
> > 	Has these problem(s):
> > 		- Subject has leading but no trailing quotes
> > 
> > I'll rewrite this one, but note that you will have to rebase your tree
> > now, sorry.
> 
> Here's the full error, was cut off one line:
> Commit: a5918cecaec3 ("iio: invensense: fix timestamp glitches when switching frequency")
> 	Fixes tag: Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
> 	Has these problem(s):
> 		- Subject has leading but no trailing quotes
> 

Nope, no fixup on my side, that just messed the whole tree up.  Can you
fix this on your end and send a new pull request?

thanks,

greg k-h

