Return-Path: <linux-iio+bounces-19771-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D72AABF3F2
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 14:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D290C16C181
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF22343C9;
	Wed, 21 May 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iX3niEjG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411B21FF58
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829747; cv=none; b=jTHbl/ZcrvgY/NXTEjCKqZ78WGDgrnrDCDFfaTLi0Ih5a9t8qt+Nu+gkeL7/CYgzNhvas3U7VwdeV6M/xqopHv33bamqIGPo0wynRbhKwnusAv+ZaXpnBIw1bVRSr2EIuwugr8sKpqXB95J80C9+PE81vEJw4IF5RzzaHkmBRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829747; c=relaxed/simple;
	bh=qkKLxiOceidPcvyMmpT6nKH+XmBa4uIZeDn/dpJzfO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isk1V1emmQl3uSJfol3ZRsN5JZz0Jyg41W1Q8YRdWNe64O5bJKASEG9M3kteuUDRQA/pwkuElRjyDT7OGBdpgdIUO8IjSK93TY4vkijeWT/Xhy6YgFgh9g8LvRzqzt7EciyHkQTBjccP6i21bds69jFseaFiiEd7zHTdMfRMI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iX3niEjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC765C4CEE4;
	Wed, 21 May 2025 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829747;
	bh=qkKLxiOceidPcvyMmpT6nKH+XmBa4uIZeDn/dpJzfO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iX3niEjGpTWaUyiUEw7DCVX5sEDC+BylEcdUFIYv+UohaPINTVfLucZcqXpSKpqmn
	 APuthGnVD6sEbtAwV8Z+hbqhwUKse39uFFdR1Ye93IziijzbwSQdHhH74TYsTvt0EN
	 K00/l0c2XQb6id1+xcipHuYCJtGdaaQAB/3l/dNo=
Date: Wed, 21 May 2025 14:15:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: Fixes for 6.15 set 2 (or merge window given timing)
Message-ID: <2025052128-enlighten-vicinity-7a1f@gregkh>
References: <20250518185719.0c816d81@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518185719.0c816d81@jic23-huawei>

On Sun, May 18, 2025 at 06:57:19PM +0100, Jonathan Cameron wrote:
> The following changes since commit 65995e97a1caacf0024bebda3332b8d1f0f443c4:
> 
>   Drivers: hv: Make the sysfs node size for the ring buffer dynamic (2025-05-02 13:59:02 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.15b

I've taken these in my char-misc-next branch for now, thanks.

greg k-h

