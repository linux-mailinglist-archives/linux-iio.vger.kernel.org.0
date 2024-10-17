Return-Path: <linux-iio+bounces-10692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0ED9A2BDE
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 20:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6C41F21B1C
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF01E04BE;
	Thu, 17 Oct 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVIQQW1r"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3441E04B0
	for <linux-iio@vger.kernel.org>; Thu, 17 Oct 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188879; cv=none; b=Z6/GNshaVCFmrIG4/Gg1QlkfZ3odnrUK+OH3UK1bDIAmNZHOaYgmtSjGfzQpn/1XteciutGaMFzgFrWfSa7iM2KcbIXlSK7olGWZif9FlGCAsfdVar4PlCaGGEAfwJ1EJVGpbVnAelMbTLaud9Nt9+uphh1bU1n0rDEpOWQiNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188879; c=relaxed/simple;
	bh=6Ez6JV4ebmltcTD4mQKvZP1PeNFYTzYajrKzht0bUy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYmRS2FGLsR0sdb1CIy6ztaLE6hH4FkTHQPuxdhAFTG8ly/OrkQW2VC/hp2g0hbUA0KDh2rB0OtjsxKBtf+Iw09M8JM1ZNCKqAfTzCw9nB7U4FJoGiEglypzn7d8hbFskGmbTi0ZBq/72xz0mPNLTU3dZew7iB0OhVoaxr6KDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVIQQW1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFED6C4CECE;
	Thu, 17 Oct 2024 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729188879;
	bh=6Ez6JV4ebmltcTD4mQKvZP1PeNFYTzYajrKzht0bUy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVIQQW1r8r9PsDnhq0Ff332XWEv5AfO1Anz6n4DKSJI4X80W3y1AB4FliMz0TXblz
	 FbedBh7NSXrD0vSdPDrbIvcDOYgEn+kefA6vXmpH8D93QxpORCeHGVvIrk+I5Tzzav
	 sP6D4AxGe9LAwWySugiYB1eQeWL9Jxyc2S9hgjuc=
Date: Thu, 17 Oct 2024 20:14:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.13
Message-ID: <2024101724-sandblast-petty-049d@gregkh>
References: <20241017183303.5e9b9890@jic23-huawei>
 <20241017183906.104ce8c1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017183906.104ce8c1@jic23-huawei>

On Thu, Oct 17, 2024 at 06:39:06PM +0100, Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 18:33:03 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:
> > 
> >   Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.13a
> > 
> > for you to fetch changes up to f548c11a85ff08e3c6ac7fdf995cb98bf95c9acf:
> > 
> >   iio: light: rpr0521: Use generic iio_pollfunc_store_time() (2024-10-15 18:59:51 +0100)
> 
> Hi Greg,
> 
> Please ignore this. There is is a spurious empty file.
> 
> However, given I've sent it.
> 
> I wasn't 100% sure on how to generate a pull request when I had a merge
> of Linus' tree in the middle of it.
> Doing git request-pull v6.12-rc2 ....
> seemed to include all the right patches and makes sense to me, but if
> there is a better way do let me know.

As the tree I will be pulling into (char-misc-next), already has -rc2,
this should be just fine, right?  The request-pull lines seem to show
that this is fine, so all should be good.  I'll watch out for it when
you send the fixed-up pull-request.

thanks,

greg k-h

