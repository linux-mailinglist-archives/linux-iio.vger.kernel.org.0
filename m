Return-Path: <linux-iio+bounces-4768-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C708BA694
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 07:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB3B1F22422
	for <lists+linux-iio@lfdr.de>; Fri,  3 May 2024 05:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C813958D;
	Fri,  3 May 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JW0Eak4x"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89B12C181
	for <linux-iio@vger.kernel.org>; Fri,  3 May 2024 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713733; cv=none; b=Qd2QKmIbl4NVCLrMCCEfQSo4d0fOFhv6Yh+gfhSg0TZ4BcNYb0yFm4n3hrvAh/SFbJcqz3XsFpzOSAPn4ApEKR47fnCjn3b55ZusmXlIA3JaO2gR0SAV+LfcnXlv8EZlqPuZ1fHbHORzCd0luiYfPQeEuqjZvU86Bg6n33QO0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713733; c=relaxed/simple;
	bh=jw/TGyGvj1prLPZWURAlc8iyF9kKSaeAx9hW0m0DjcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAkyrKe7x6asgPivYvY3BuiWArhI4bqxD6PRQABvqYbSodhxa9famVyGKtXdHhtOMOf0sSZwTLfKnp2mgXfo3N5L/xWtBo7RuNcGF1jF8tA+HpRpGyg7KsrIzNTPtSF0PdAZFbxqr9cLNMFVOzg3/k0OciW4Y+IhNQ5f+ZcNVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JW0Eak4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9E6C116B1;
	Fri,  3 May 2024 05:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714713733;
	bh=jw/TGyGvj1prLPZWURAlc8iyF9kKSaeAx9hW0m0DjcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JW0Eak4xLRLIkrl4KtnATAN4Whg5f9nNzId15zfhoVMInKpJrjo8Xidn8dymex0/B
	 LcsoGJti2Z7fja8cnCradQDRZFUJBLincJRC1dr8XEdRTdMaOG65gDkaOiJUt3xS0X
	 HgNOcH90MScb3dvF2YhaBHFvMLpwsBP0yh0Wj7G4=
Date: Fri, 3 May 2024 07:22:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, features and cleanup
 for the 6.10 cycle
Message-ID: <2024050358-chooser-egotistic-59e5@gregkh>
References: <20240502201509.14ae8880@jic23-huawei>
 <2024050353-compel-daycare-f7ce@gregkh>
 <2024050321-preshow-unaired-01de@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024050321-preshow-unaired-01de@gregkh>

On Fri, May 03, 2024 at 07:21:43AM +0200, Greg KH wrote:
> On Fri, May 03, 2024 at 07:16:02AM +0200, Greg KH wrote:
> > On Thu, May 02, 2024 at 08:15:09PM +0100, Jonathan Cameron wrote:
> > > The following changes since commit 84e79a7f63e8caeac0c1a0817408860875a9b23e:
> > > 
> > >   Merge tag 'peci-next-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux into char-misc-next (2024-04-23 21:31:45 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.10b
> > 
> > Pulled and pushed out now, thanks.
> 
> Oops, nope, got the following error:
> 
> Fixes tag: Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
> 	Has these problem(s):
> 		- Subject has leading but no trailing quotes
> 
> I'll rewrite this one, but note that you will have to rebase your tree
> now, sorry.

Here's the full error, was cut off one line:
Commit: a5918cecaec3 ("iio: invensense: fix timestamp glitches when switching frequency")
	Fixes tag: Fixes: 0ecc363ccea7 ("iio: make invensense timestamp module generic)
	Has these problem(s):
		- Subject has leading but no trailing quotes


