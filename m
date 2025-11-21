Return-Path: <linux-iio+bounces-26364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62372C7A32A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 15:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 27FBD2DEE8
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0E33554D;
	Fri, 21 Nov 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3vWtoVi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C1350D47
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735504; cv=none; b=IBnTHA+owxkVsgSSQgM5wfFLdcznyQFsiefIQWyCAz5PkEunkZnYR6egEKwp6O3x/dyQieOMNpc/WertbUGONBM7ZlmHSGVkxh65FtqQEyUvruPUZfi8W/ooltuD05aq6yZb8+Cwz6ZpBG1XVgIkQ2S20xii/YvNftLg5qtitDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735504; c=relaxed/simple;
	bh=xKIO4CAVyXVQL8aGwxXQT9qHVgfqIX2DVVhWkORWgF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djkLljaj0rTLv/oVRXrIz6JPG05NUXAKFn8r1Go2knsqlYWJfXXjxR5I3838KQtEfOPui75df6gOpN3NbhmoM5r6y5PALiIoJ4j0uUfoCjH3dLSQmh9wgps26ARgar7ks1WcHv5DKXSbZHzp3piL0RqMuQfWNC5iS5GLt0cew4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3vWtoVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA0EC4CEF1;
	Fri, 21 Nov 2025 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763735504;
	bh=xKIO4CAVyXVQL8aGwxXQT9qHVgfqIX2DVVhWkORWgF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3vWtoViuSA6Twpum88ti/bLbvMd1jjnP0x3gkaP8Ilc95fmKvx8nKpmmcT78oxR/
	 M9frW9S0dsmn9qLaMyh8H1Lb9c4+HnJlp/uajV5zbxsdErRtTMyor0lAV2VXSSFK7j
	 pJQJNE5uQih7P5UkwwIL1pqNv/nNKHu/qVNolZ64=
Date: Fri, 21 Nov 2025 15:26:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.19
Message-ID: <2025112123-cabbage-straggler-3373@gregkh>
References: <20251118181020.4df5e18c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118181020.4df5e18c@jic23-huawei>

On Tue, Nov 18, 2025 at 06:10:20PM +0000, Jonathan Cameron wrote:
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.19a

Pulled and pushed out, thanks.

greg k-h

