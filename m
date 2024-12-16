Return-Path: <linux-iio+bounces-13547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769EC9F3485
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3295D1887D10
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F86A84A5E;
	Mon, 16 Dec 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XneVlmPj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AE17C64
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363042; cv=none; b=BN9kvvJE9AkBF+WwvILwAYBAY9cKW3RGbrsUpgBhNFp45vhoc8vAd79p/a7+2aAH00pbwq+Y8fjtaclP1ftH/0Yig9W8xy1rcxqMRWEjDRa8wSf2a8IFufA3NJAKBVCq3WlKkrqgY0Qey9ebXnD3wFURPV544qJ25ctSFY9p1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363042; c=relaxed/simple;
	bh=/tgbiu51GNNun5ozeL8FvIM88L3MCJYyzDsMel2FN0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyPbj6B1H0GvMpPZU0n+y+77BEcTGcYSijo+7FQSMft/Hoq8uhSfFzv9mXnqNdt0+6IGDfLfz706+BXokUFJbtZGFF7dCnRpcAkYqj01wOfJjeLyROnNvnGo7DhWtovPsIVJMw8fQqsfAH2x8zAJN+2LGiKxWgINEzH1CAk6NFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XneVlmPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8330C4CED0;
	Mon, 16 Dec 2024 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363042;
	bh=/tgbiu51GNNun5ozeL8FvIM88L3MCJYyzDsMel2FN0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XneVlmPjYOxE8bWlNk5uZOi2P2+LMdz5C75yuOy43MsgWr/jLmgdUWaT9Or39Oa+D
	 aynrMkXA06LZmDbzA6Cxtb5s44aIDrusvLtvsE4yMrkNRgF2z3Zjw1lov6kLsukdR3
	 nXzRt8rkgXyxNY0O0KzAdPY6Vb4CQYVxSaN4bCY8=
Date: Mon, 16 Dec 2024 16:30:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 6.13
Message-ID: <2024121629-brownnose-pauper-c14b@gregkh>
References: <20241211212609.6deb07bc@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211212609.6deb07bc@jic23-huawei>

On Wed, Dec 11, 2024 at 09:26:09PM +0000, Jonathan Cameron wrote:
> The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:
> 
>   module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.13a

Pulled and pushed out, thanks.

greg k-h

