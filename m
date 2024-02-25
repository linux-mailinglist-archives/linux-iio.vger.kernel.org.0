Return-Path: <linux-iio+bounces-3054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A2862A6B
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 14:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9211F21532
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C1125C1;
	Sun, 25 Feb 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNsxrrea"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE311733
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866740; cv=none; b=oc6p6a/XWhhh7xBpEqeNJy8Ic9kC61CD2Jv7kUueqqjopBsqXaiqg+3WbpzVbfK+vIcJhqv5uAfqKwsyFOfxgDcU6vdmFQmoE+Dnmhs6UhxI3rCMJViHeALLpH3qT7LNMlgoiTlGQvTJHwx/Nv4gF8vXZkgk6kzPYvF7JC1AfBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866740; c=relaxed/simple;
	bh=h0GtIAHWWJpWyfvjvCOMg6wPnFaOU2HaQZ8zP90mxM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9D9KreDkXhUntyxUPoCnnFO5DqFPXSbeqJzNCtar7a/7I94rytunBjOuPjVwJCDqoqpNjECK3tNtIhTn+YySVI4lepk1DqUuZTGS6oBa5vIgVefnu9vgPT0lC0/yjBtXbqi5zP6NDnqgKKvUbXgyEIG1LjqhBcgd6JdaEtON6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNsxrrea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3C9C433F1;
	Sun, 25 Feb 2024 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708866740;
	bh=h0GtIAHWWJpWyfvjvCOMg6wPnFaOU2HaQZ8zP90mxM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNsxrreae54zUj8sfvWKfdxPfdTxhofpxAU8NzsPF37HSEWhOEF5WzW0GzUnjZTpd
	 Wv7e61oAF56leHeRHhayogcsRxRdwRYoxx1saa2WVV3snJtFLX9uCXoRHOJwLCPH9q
	 54H1dDIrs9PCUp4xq8DA5IIxSnM25Hf9LG0dzrds=
Date: Sun, 25 Feb 2024 14:12:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support, features and
 cleanup for 6.9
Message-ID: <2024022505-decathlon-parcel-958e@gregkh>
References: <20240222190623.44f36707@jic23-huawei>
 <20240222191331.75b32286@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222191331.75b32286@jic23-huawei>

On Thu, Feb 22, 2024 at 07:13:31PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Feb 2024 19:06:23 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> > 
> >   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.9a
> > 
> > for you to fetch changes up to 3cc5ebd3a2d6247aeba81873d6b040d5d87f7db1:
> > 
> >   iio: imu: bmi323: Add ACPI Match Table (2024-02-19 19:34:44 +0000)
> > 
> Hi Greg,
> 
> There is a small conflict in here due to racing with a fix that went
> through the dt tree.
> 
> Stephen has been carrying a fix up in linux-next which resolves it as expected.
> 
> https://lore.kernel.org/linux-next/20240219143945.1460f25f@canb.auug.org.au/

Looks good, now pulled and pushed out, thanks!

greg k-h

