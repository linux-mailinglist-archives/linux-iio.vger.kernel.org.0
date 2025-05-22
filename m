Return-Path: <linux-iio+bounces-19789-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07188AC0A5B
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41D15A253E4
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26679289E29;
	Thu, 22 May 2025 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B8KeTy1q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE73289812
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912367; cv=none; b=HzAqusirdKlbcFaGKkuJQ9H4U+pcj643MIfHHmyqqnsTOXCnSnYCPyfpAsK/qrt9CNoQkpL91VNivPICMbwp/Rf0iuSqAgz4ilnOoO1h13tHDG5OBcwA58hAcNoIVFOm7S9PLzt6Wv6KqlivUh3cF9/B773WKgKRvJWBj0vve2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912367; c=relaxed/simple;
	bh=kaopbf0czLN0VFoYWvP5A7rN82aI1cUXROKAOpUZXpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLsW4Do8lhQRyo1Z2TEykWul/IdBeHAqMxyE7T68F9sAZ/5jwXxdKkKPBumoqfL5jXPUSWtwMoFtXAK2WY5TDz3JSSVqM8vJ5w5Q3njpXw/3+/pU5iwuryFi88UNQy/5wkUoMheKqijCepA599g3qfoJgTEniMwzwxbNsymEn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B8KeTy1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B771C4CEED;
	Thu, 22 May 2025 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747912367;
	bh=kaopbf0czLN0VFoYWvP5A7rN82aI1cUXROKAOpUZXpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B8KeTy1q/H+AjLLnY/PMY1EaYA9Xkc/yfmBKL1kluLR7BjqlQOqD5+QWr160KyQah
	 iyZze3x887bHU7hbcR9wbf/aP6F/7BAhpixxDRj2X8ffsUxbziN0kS956KWmLVmb1P
	 NWzzL4uWdioH1iiuavs0SQCyv7uHm2XwX9JN5AYg=
Date: Thu, 22 May 2025 13:12:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter fixes for 6.15
Message-ID: <2025052211-dealmaker-unblended-c2a3@gregkh>
References: <2025052145-culprit-underdone-c69b@gregkh>
 <20250522101325.779686-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522101325.779686-1-wbg@kernel.org>

On Thu, May 22, 2025 at 07:13:22PM +0900, William Breathitt Gray wrote:
> On Wed, May 21, 2025 at 02:07:29PM +0200, Greg KH wrote:
> > On Sun, May 11, 2025 at 03:43:29PM +0900, William Breathitt Gray wrote:
> > > The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:
> > >
> > >   Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.15
> > >
> > > for you to fetch changes up to 7351312632e831e51383f48957d47712fae791ef:
> > >
> > >   counter: interrupt-cnt: Protect enable/disable OPs with mutex (2025-05-03 08:45:11 +0900)
> > >
> > > ----------------------------------------------------------------
> > > Counter fixes for 6.15
> > >
> > > A fix to prevent a race condition when accessing the Count enable
> > > component in interrupt-cnt.
> > 
> > I took this into my -next branch BUT for some reason you have this
> > commit with a Fixes: tag but NO Cc: stable tag.  Which means it will not
> > get pulled into the stable trees automatically.  Are you sure you wanted
> > to do that?
> 
> Sorry, the missing Cc: stable tag was an oversight; this fix should be
> pulled into the stable trees as well. What would be the best way for me
> to resolve this, should I RESEND the patch with the appropriate tag and
> Cc stable@vger.kernel.org?

It's already in my trees, so it can't be changed.  Just remember when it
hits Linus's tree to send the git id to the stable list to ensure that
it gets included there.

thanks,

greg k-h

