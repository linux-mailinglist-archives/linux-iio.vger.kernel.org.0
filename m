Return-Path: <linux-iio+bounces-19772-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A78ABF436
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8B27B2DA5
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99B2638A3;
	Wed, 21 May 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0d7S0Et"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F025F7B5
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830036; cv=none; b=D8u54zybEW1nxkVzIUWDNaC1heF8y1ByzpAOKQgtYmRH6V8pAzU6Lt56cSFB9yMaL1fEbbpRJ/bKJqHvL/cgMOQj8InMaU+LW/rmEErP56LI91AcAuxdLDFNpZzsMyl8qi/jNRLb1WGdZVXfz/8OhZZye+nH605GpA/yTeZUiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830036; c=relaxed/simple;
	bh=G2mb8yz+qjYwTbbOm2ThZzE0gZrN3HSUmypi2Wep+l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZhBxPOUzSurzjler8ltqzJxOH+DVKouulasrXaGPRaFIjxDpu7TUnGmhNbFtv4KVAIXZ+RZ7NhDCoTmwTc4jpbSDBsi47A2cF+ASsTIs/2+g3lkVbcIyaDsgc8QQnoMXsk+BxTZQetPCmBopG4lLqP9bdnpKAzvDnybpbCgx5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0d7S0Et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE00C4CEE4;
	Wed, 21 May 2025 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747830036;
	bh=G2mb8yz+qjYwTbbOm2ThZzE0gZrN3HSUmypi2Wep+l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0d7S0Etnxh1ALvqCaayTdVCA7AwMju3MtQ2In5FdTOFrljwTtMoVposwrrdsF7To
	 AjUVe/r8thDENQ1Plao01ceog1fjm8z9H3g13mjWQUTebtTs8x2SflJu8+9vdjp6U4
	 EViV+t0TifI9nN5cgYYKzWR9T5/zQGTnAGR+PC1s=
Date: Wed, 21 May 2025 14:20:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.16
Message-ID: <2025052102-vanilla-acorn-606f@gregkh>
References: <20250517202341.095163d6@jic23-huawei>
 <20250518190933.4dab9eea@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518190933.4dab9eea@jic23-huawei>

On Sun, May 18, 2025 at 07:09:33PM +0100, Jonathan Cameron wrote:
> On Sat, 17 May 2025 20:23:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> > 
> >   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.16a
> > 
> > for you to fetch changes up to 1b8833364795fb4562b867623f62b401b72238e2:
> > 
> >   dt-bindings: iio: adc: Add ROHM BD79100G (2025-05-17 20:18:30 +0100)
> > 
> Hi Greg,
> 
> I didn't call it out in here because I'd forgotten about it when writing this
> pull request up whilst travelling.  There is a trivial conflict with the
> fixes pull request I just sent that modifies an adjacent line in the 
> ad7606 driver.
> 
> https://lore.kernel.org/all/20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com/
> called that out under the ---
> 
> I haven't resolved it locally because I meant to send that fix
> a while back and as mentioned I forgot about it.  Hope you don't mind
> doing the resolution during the merge.
> 
> Stephen's resolution was:
> https://lore.kernel.org/linux-next/20250506155728.65605bae@canb.auug.org.au/

I've used his resolution here as well, thanks!

greg k-h

