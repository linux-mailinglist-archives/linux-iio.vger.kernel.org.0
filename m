Return-Path: <linux-iio+bounces-6403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF6890B88F
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335521C21379
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289319049C;
	Mon, 17 Jun 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYAcXONS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F7616CD3D
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646853; cv=none; b=masLkX3NR4ljTOT+6fnqYBRJQ26m/sX+tKamtK1DUZo6fo9X8p3pRLY/TnDuub76Y+FAfpEw6bKDFyqBq4Ze6wtx/NArJ22/IYTIMdtBgswzD+9u15dznbmVK9vNMcwQ0rlrL2fUIBN+melHPOtJaWD8r2cK/xLbJqNXSa49RUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646853; c=relaxed/simple;
	bh=z6RTFT/ZtXDunm43o7SqzIH2eFTvsYtZPn644lxtEdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESuPYNOiZ4BefV+tilz5LVooHtF51Fiq4E2zIUzkm+H65gOyBkaYmCHOoeXjNg87mybkRAVOIagA3zE9gYceWs5RrFyqC3rEJ/NkX9W5fg08/U1Ed+vKZYWksMrwtThBKfpVyuyTZCH2DyzpFcKtP2kEUeIYPsFm2ObIREsJizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYAcXONS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5ADC2BD10;
	Mon, 17 Jun 2024 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718646852;
	bh=z6RTFT/ZtXDunm43o7SqzIH2eFTvsYtZPn644lxtEdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XYAcXONS8axOFM54MWDqhheUtO4/pV3w7n3C9P2EV5L5j6qp9Ry73B4dcN8LcNEiU
	 wmrYApnwzzBXPEQ5MnnLS/LGNxnQ0hq1a48so4GW3y3s3btFGorW3gYY9ZUCwS2SnY
	 w9sd8v/5yT0lVeLMvHl7y4j4sPWKTN0HszE7Uu6SWkX4tWAEb5qUTc09NDu6ON9Nna
	 ixyThNGx4hLo3y+929DJC0IncFtIQCHfbPxwTZ3CoWCyJLpDJbDQHAPfe6UUNm1Byy
	 vdb4JaUFlUIeKeeRPlfsypx9f88Kl1d8PEk7Q98d1NwgSG6i9AVcn++Qu/1Q85PJLB
	 N7phj/fCHEWHA==
Date: Mon, 17 Jun 2024 18:54:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for the 6.10 cycle.
Message-ID: <20240617185405.61939834@jic23-huawei>
In-Reply-To: <2024061646-deviator-maritime-4e35@gregkh>
References: <20240615101121.09118fed@jic23-huawei>
	<2024061646-deviator-maritime-4e35@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Jun 2024 12:04:53 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Jun 15, 2024 at 10:11:21AM +0100, Jonathan Cameron wrote:
> > The following changes since commit 8f40af31971ce012c0a4b13444900aed3f708edf:
> > 
> >   Merge tag 'iio-fixes-for-6.10a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2024-06-07 21:05:39 +0200)  
> 
> Pulled and pushed out, thanks.
> 
> greg k-h
> 

Hi Greg,

This one I'm not seeing (looking in char-misc-linus) but I am seeing the other
pull request so I'm guessing reply to wrong pull request?

Thanks,

Jonathan

