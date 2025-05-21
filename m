Return-Path: <linux-iio+bounces-19774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D0DABF45A
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 14:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A614E15C7
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0623E1F30A2;
	Wed, 21 May 2025 12:31:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE526AD9
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830706; cv=none; b=GBiyse0cnAa3Attd01qZt3YMtFxm+EE/RxG8flfHSpc8NwFuRXZnqBTlaKDwXbYgCdkZLgzoKRKrFE7270LX0YR//22p3Z25ioqbcDoU7evNvt9aPxpIJEzoy9xwF5wotUUUI0oe1M5LmoS1i/etGo+lX+DF6wz3rIFKX99Xais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830706; c=relaxed/simple;
	bh=qFZLeRAdIIgAavz91PLiZ3gGiZ+jEBbb+NCykG3o9UA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFBDwz+NQGIjYd2GQRYJ3fACz4JZeknHk1ap3X1WyZTWCFR3ZBBZxuZgK4GqKdkD4R054JD+B/p2HYufgWsk72EKCAWq75lxosla0w9AlqjZLofZJtXcyGs3IFU4FgqIRB8ry4RkxeaqUlM0QBjTM9KEq2b/A/YYDMoK2VHYjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2W3p4sQqz6GD5L;
	Wed, 21 May 2025 20:30:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B3952140519;
	Wed, 21 May 2025 20:31:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 14:31:39 +0200
Date: Wed, 21 May 2025 13:31:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.16
Message-ID: <20250521133137.00005572@huawei.com>
In-Reply-To: <2025052113-reproach-zebra-005b@gregkh>
References: <20250517202341.095163d6@jic23-huawei>
	<20250518190933.4dab9eea@jic23-huawei>
	<2025052102-vanilla-acorn-606f@gregkh>
	<2025052113-reproach-zebra-005b@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 21 May 2025 14:21:35 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, May 21, 2025 at 02:20:34PM +0200, Greg KH wrote:
> > On Sun, May 18, 2025 at 07:09:33PM +0100, Jonathan Cameron wrote:  
> > > On Sat, 17 May 2025 20:23:41 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >   
> > > > The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> > > > 
> > > >   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.16a
> > > > 
> > > > for you to fetch changes up to 1b8833364795fb4562b867623f62b401b72238e2:
> > > > 
> > > >   dt-bindings: iio: adc: Add ROHM BD79100G (2025-05-17 20:18:30 +0100)
> > > >   
> > > Hi Greg,
> > > 
> > > I didn't call it out in here because I'd forgotten about it when writing this
> > > pull request up whilst travelling.  There is a trivial conflict with the
> > > fixes pull request I just sent that modifies an adjacent line in the 
> > > ad7606 driver.
> > > 
> > > https://lore.kernel.org/all/20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com/
> > > called that out under the ---
> > > 
> > > I haven't resolved it locally because I meant to send that fix
> > > a while back and as mentioned I forgot about it.  Hope you don't mind
> > > doing the resolution during the merge.
> > > 
> > > Stephen's resolution was:
> > > https://lore.kernel.org/linux-next/20250506155728.65605bae@canb.auug.org.au/  
> > 
> > I've used his resolution here as well, thanks!  
> 
> Ick, I get the following errors when trying to merge this:
> 
> Commit: 59e1bb0b7f4e ("iio: adc: ad4000: Avoid potential double data word read")
> 	Fixes tag: Fixes: d0dba3df842f ("iio: adc: ad4000: Add support for SPI offload")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> Commit: 6f9b765075be ("iio: dac: ad5592r: Delete stray unlock in ad5592r_write_raw()")
> 	Fixes tag: Fixes: f8fedb167ba4 ("iio: dac: ad5592r: use lock guards")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> Commit: 959fd4301e1a ("docs: iio: ad3552r: fix malformed table")
> 	Fixes tag: Fixes: 9a259b51e3ea ("docs: iio: add documentation for ad3552r driver")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> 
> So I can't take it, sorry :(
Huh didn't see those locally for some reason.  I'll fix up and send a new version. 
I probably missed a script run after rebasing to take a out that spurious
non IIO patch.

Will be an hour or so.

J
> 
> greg k-h
> 


