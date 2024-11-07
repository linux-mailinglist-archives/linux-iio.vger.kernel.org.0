Return-Path: <linux-iio+bounces-11964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD99BFEC8
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 08:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7D041F22827
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B51940B3;
	Thu,  7 Nov 2024 07:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2IZF2GFB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C9802
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730963348; cv=none; b=P+eXDV+h9TK3zVfeUDW9VwHwBVrrCdjLzN7SOfJBRQX1fdMmtibBbnRP00bgEvV4ccwuxnodivXg5wJMAZua8WubnvKc4Tkk4VOtMknxGVW9a8E98lgtKrsJ1ysNiqQhFzkhPXyYhxSZQQeCEWJ33H6OAGngHByADTve5Np4StQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730963348; c=relaxed/simple;
	bh=mpLMITcc+fZKTMeVcwLri/RZ7RqrcSicjsUWIDUQBuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDgHWOQKb+qsCAAAnAroD7ZcJSSTTl1qd8ZUmKLncz6qabO/hOT2eSiRq3ztspl52NjhE8HNtRo0GJXlPR08JquU/MIjNcqxabRXgw13jSotg/2Iy2AI+YkPp412IhnGm/TrA3Ve5rZlAQgu2Ep0BHeVbGKYQpqnfGcca3OOrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2IZF2GFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF17C4CECC;
	Thu,  7 Nov 2024 07:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730963348;
	bh=mpLMITcc+fZKTMeVcwLri/RZ7RqrcSicjsUWIDUQBuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2IZF2GFBf4Ql2GNEw5LFQTLlcZEXg3C4AqOMpyxZdQbUJIzQLLKMBsDzgEJWm8M1b
	 1IEwXUjbl6SSdXu8x4KrHP6XhqMzAnwtutGtuTcB1jsIN5sOlRqOnLWv8A76IXOWYt
	 fmEVg+LaEh5/1FYL6T+m+SasdcymuKOUkBmbmVYA=
Date: Thu, 7 Nov 2024 08:08:50 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 6.12
Message-ID: <2024110757-armband-carmaker-f8f4@gregkh>
References: <ZyxmZi-xVcDV4lVL@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyxmZi-xVcDV4lVL@ishi>

On Thu, Nov 07, 2024 at 04:04:06PM +0900, William Breathitt Gray wrote:
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.12
> 
> for you to fetch changes up to 1437d9f1c56fce9c24e566508bce1d218dd5497a:
> 
>   counter: ti-ecap-capture: Add check for clk_enable() (2024-11-05 09:20:11 +0900)
> 
> ----------------------------------------------------------------
> Counter fixes for 6.12
> 
> Fix device_node handling in stm32-timer-cnt by calling required
> of_node_put() after device node is no longer needed. Check and handle
> clk_enable() failures in stm32-timer-cnt and ti-ecap-capture.
> 
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>

Can these wait for 6.13-rc1?  I'd like to not have to send another pull
request for this tree for 6.12-final if at all possible.  But if these
are issues that people are hitting now, I'll be glad to do so.

thanks,

greg k-h

