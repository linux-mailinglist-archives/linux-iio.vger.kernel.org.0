Return-Path: <linux-iio+bounces-11161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9208C9AEE69
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 19:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56679282A08
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 17:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D91FCF7B;
	Thu, 24 Oct 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBEv5Z7j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF01FC7F7;
	Thu, 24 Oct 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791676; cv=none; b=NDji7Z3wQb40PIKkqkSR8zGFcMBU4LlbCUi7fvOPZZF2Jwr6kSSPj6ymjEis3aTeTIn4oMG7QusKbBnTEZPg5WmZAzhQ8c8rMiDIyhXM1104KniIWl27pnR3UIY6tj63kIz6BDVx/myAvycaWcqXAiRFDXx3RiC7TJ6YRWpvH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791676; c=relaxed/simple;
	bh=VjnOFKGWB+Vsz4mAbhv8vBkTom++FJLCVR2sgrw5c8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWgFArahlqqg/G8v0AatN67zK2UodcYCLsPoosnkZejtJWwF0sqMspdus/nHBUh2uYfFgx9UZu8kVcTQxdBGZZ0vVkjDNhQQpjaQ0S5F7+5bfTuF3FtoGT57hxMdLuVmGRfdFNjbAbvbK8QUGG3zZEs+EbLREj/Owy1EfdA/m4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBEv5Z7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC7EC4CEC7;
	Thu, 24 Oct 2024 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729791675;
	bh=VjnOFKGWB+Vsz4mAbhv8vBkTom++FJLCVR2sgrw5c8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iBEv5Z7jpalzMzU8Cv70eDJWsODtcLv8MJpoM975/moa4CRl0mqa2947WAKyw6bou
	 Dprt7RvYkr0HBN4CirZQqvKfXtL4V9QXaVVdo0q8Izkl6IEtN/O59SOUFm0/1iBcqX
	 fqvzwFCHezHOzqXUv1ic7BpNj6k3Q/KdcJ+V+zG4zObX8WLuEx3Er9Z/aZYdwnCdU0
	 cZkUOS9034URL8EeaqBQKhDBJkQF40gOKqXo5tMBrAtQn7jwZcViPjABM6bhTlN9ZW
	 nm9xu4xKzpJqnBVjI1E3wD6B0XYvIcaJ2ba9d42YR7lueE78RuCwn4jel2qEtLG9jD
	 +mteokZgcJMvA==
Date: Thu, 24 Oct 2024 18:41:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>, Arnd
 Bergmann <arnd@arndb.de>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: linux-next: manual merge of the char-misc tree with the
 iio-fixes tree
Message-ID: <20241024184108.6eb3bdf0@jic23-huawei>
In-Reply-To: <22f9dbb6-ba5e-4c85-8aa2-6090008e7da4@gmail.com>
References: <20241023141015.0ec5346d@canb.auug.org.au>
	<22f9dbb6-ba5e-4c85-8aa2-6090008e7da4@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 20:17:30 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> On 23/10/2024 05:10, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the char-misc tree got a conflict in:
> > 
> >   drivers/iio/light/veml6030.c
> > 
> > between commit:
> > 
> >   de9981636774 ("iio: light: veml6030: fix microlux value calculation")
> > 
> > from the iio-fixes tree and commit:
> > 
> >   ed59fc90f38a ("iio: light: veml6030: drop processed info for white channel")
> > 
> > from the char-misc tree.
> > 
> > I fixed it up (the latter removed the line updated by the former) and
> > can carry the fix as necessary. This is now fixed as far as linux-next
> > is concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
> >   
> 
> 
> Hi Stephen,
> 
> I doubled checked the status of the driver in linux-next, and everything
> looks as it should: the first commit applied as a single chunk, as its
> second chunk affects lines that the second commit removed.
> 
> Thank you for fixing it up.

Not quite. This was a lucky merge issue as it highlighted something I'd
messed up.

A rare case of a fuzzy application of a patch picking the wrong block but still
giving a very plausible looking diff that fooled me.

I picked up the fix via a different tree from where you expected.
In char-misc-next / iio/togreg there is only one instance of this code block because
the larger driver rework removed one of the two that was in the tree that
iio-fixes is based on (effectively mainline).

The fix got applied to the one that is going away (which is going away because
the scale makes no sense on the intensity channel) not the illuminance / IIO_LIGHT
channel that was intended.

I've move it to the right block with the side effect that the merge conflict
should go away.  Javier, please check iio.git/fixes-togreg to be 100% sure
I haven't messed it up again.

Thanks Stephen for your hard work on linux-next!

Jonathan

> 
> Best regards,
> Javier Carrasco


