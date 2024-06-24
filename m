Return-Path: <linux-iio+bounces-6810-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D2C914E1F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 15:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5461F248D5
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595A113D61B;
	Mon, 24 Jun 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lN5VHWnL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899B13BAFA
	for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234820; cv=none; b=Zuki+FcUQ1uR5dq2e3trAcyCnoIjRBcJYDlCYGhSBHg7Y9x6i53xHkSxFvrTa+E6STSyVhHSv884/u7aXT3I0qTOtBnRj+lVSspheGX13qg9c5xlRo9S9kbJaPP8B3B0LrQRSo2FVNt49j6R6b1/gP8O5Ad2Mv0whiC2J8bGlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234820; c=relaxed/simple;
	bh=F9ODAY76LurChM1QEfEyz+eRLKF7U6e71g/wAvQlJOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPKjCu0TxhcZRmzInA7rE9C7wnpbWw8HBmbcuGNu0cxI/CYv6q/0k2JkstfLAUwZkntSU2KWvE7+303nUYRqP/pbdkW6N5QubFAIhQdp9udrAbi0kcLceJSMdFjLMdTVqFfW+zc+XGTpT2XW5BErCyWUfugnR609AhEzMYhtiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lN5VHWnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427CDC2BBFC;
	Mon, 24 Jun 2024 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719234819;
	bh=F9ODAY76LurChM1QEfEyz+eRLKF7U6e71g/wAvQlJOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lN5VHWnL+0hgWcfuSdZdj/H/N+tEW8V1Jwkg9Ws5aqRZiy19IOPdaGVYrekXOilB0
	 wVi/lZKStVdilumGUBfoGWBRdWN+isqOFC2ggynUNpD+fLqF2Xdik8wUHSCgn2/wrY
	 FNU71iuykvLjXXPpVwhim0vYpEqzrzOtYp3vpNVc=
Date: Mon, 24 Jun 2024 15:13:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 6.10
Message-ID: <2024062429-nanometer-pasty-2956@gregkh>
References: <ZnibVTlTsXiGP2Fi@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnibVTlTsXiGP2Fi@ishi>

On Mon, Jun 24, 2024 at 07:01:57AM +0900, William Breathitt Gray wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.10

Pulled and pushed out, thanks.

greg k-h

