Return-Path: <linux-iio+bounces-18942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CF2AA60EB
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 17:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA391BC439D
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD25720AF87;
	Thu,  1 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YHDoj0HN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF001BF37
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114601; cv=none; b=umJZf1TeFqHwMChKhQ4IxoiKdmiA58lhScLaDdmaiA8SX0kHMSsXPPga3IXTU1DYfIW58qghrIBDjuP+nvvQk9PNQ1Jcbv3RHlcWBV8EtOHNR3PaBtv2/3nJQ//oLQiyvmMRc85IKA5lDn5EmEhO8zCGT+lF+FV8kby2KFUqT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114601; c=relaxed/simple;
	bh=PG4a5/Ouklp/Yyr8uDA4pKLMwBN035jv5nylRrrtFrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+IfB4imCUXjKQnzSAuRov59Dr9MfTfVNt78rly2tFZpzRtHKMEMlIE7VnfZkLcGmt9DCwuSB9dtiBbxIn0QtoI074v+gH1nbaNt9+Fya+OvxSZWx5JKJHbOuC//+MzOaOWv08usAfAqOaNjYofpVH66kGNggDTbuVtr7RHh9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YHDoj0HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02662C4CEEE;
	Thu,  1 May 2025 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114601;
	bh=PG4a5/Ouklp/Yyr8uDA4pKLMwBN035jv5nylRrrtFrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHDoj0HNsTaKa/8HRh2hcK2x2opdSaz20rjBRfMladhtNtp0U0PsdT0jbBGhzO/rx
	 m88ygeS4zZ5pM4D+ncpX+e0+hpJzAtgIb4QSHFJTZv6k7dmZEdRR/zS3RMbrDhcrHg
	 m+z8X4F/WDZ1iljapr3gh8tZYLYYfq+zM+vV0NuM=
Date: Thu, 1 May 2025 17:49:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for the 6.15 cycle
Message-ID: <2025050150-praising-silenced-fea0@gregkh>
References: <20250425090316.0c0bde91@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425090316.0c0bde91@jic23-huawei>

On Fri, Apr 25, 2025 at 09:03:16AM +0100, Jonathan Cameron wrote:
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> 
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.15a

Sorry for the delay, now pulled and pushed out.

greg k-h

