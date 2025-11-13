Return-Path: <linux-iio+bounces-26199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BDEC5A585
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 23:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EFC04F091B
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD212DFA48;
	Thu, 13 Nov 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XE8K2yDE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B020285C84
	for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073315; cv=none; b=OrP0oYs/MrqmYa4UHDx+NVcIRtT6gwVkF/MQP6MK6buCNvBbhvqXKdkG0lumeUlIOLXKymRDd3Sx3Di/nHZTpFDNP//Fybk/Oxvn5/UZq3x0pi06Z8XQex1q5J5uh8Jt7TvQWMZpL7L0aesvaZjPzXVuA33sMqGaBmQhsbDlLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073315; c=relaxed/simple;
	bh=lsYu/knMHZFIPTnIm3/OFJsVRG7Xr5KXTAlvZr8HzO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVJWID4JqKlgkeKHudYseNTPa03VTZfaJUQwkWA35hVFQzy6bUfIA9f+gAIK5gYOQZJc5S2Q2RiV+L4+hEakPbhJJGpEajNAm4SLhC4UKM6tA2WFWTG3weFwC0XQpFiydaR9/GLUJ1CaaR0vz4wIQfaFe9+mqD9NKW+sUBKKEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XE8K2yDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD645C4CEFB;
	Thu, 13 Nov 2025 22:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073315;
	bh=lsYu/knMHZFIPTnIm3/OFJsVRG7Xr5KXTAlvZr8HzO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XE8K2yDE6/6gfLvhxEohFAPRwrJD32xz0I2BUQ4GlxyTROQE9IpO8xkdbmqfV6xEq
	 aI14a4u1SViJ4LjaY/bskitrqhQPFvqpxQ1Ow5vu8NxFJKtc1uITBiVgPBQ3wEfeEU
	 31giQgpwOw4JajHlazd087R5gaNgA/FYI4R2DlGU=
Date: Thu, 13 Nov 2025 17:35:03 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 6.18
Message-ID: <2025111350-ibuprofen-quiver-f7ae@gregkh>
References: <20251111204241.283143b8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111204241.283143b8@jic23-huawei>

On Tue, Nov 11, 2025 at 08:42:41PM +0000, Jonathan Cameron wrote:
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.18a

Pulled and pushed out, thanks.

greg k-h

