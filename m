Return-Path: <linux-iio+bounces-11967-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD839BFF03
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 08:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DDC1F22185
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 07:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D419596F;
	Thu,  7 Nov 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kZjnUYAY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3407194A64
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964384; cv=none; b=sj/P7M2wL+zW02T8oxgn1K5ooVgT24fSTvCjLHn5NR8KGpuIL+HI0uYZAtV8uQdcFABnL7/LADvJ8ivXqE1Ncs0V50NP/7IS+TenhrlVOIxX+kLClDKmhnv8nq/vFncrAx6Km1vepRaJzvZSWS0QWphNZuM3dK5QkqUjsEq6et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964384; c=relaxed/simple;
	bh=JTcxiGqeztiKa8z4SV8a3BJo3TPHrP39wyN40oKh4YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zfa1gZe7F1svArsyka6xU12c2JXLGowrm1/sDkAUxPkkKVuUcXgi1rSzs7Y3iDBMEP2Pw85sEX8fcr6XwhHS7B/hWPtZDsCwZdplzCn4Ijzz4VWfTgcd/iCdSzcaMjbB+cAp2M786PcBMUHSkrwbQZBBF/54x78r+0FToM7d+eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kZjnUYAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60D7C4CECC;
	Thu,  7 Nov 2024 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730964384;
	bh=JTcxiGqeztiKa8z4SV8a3BJo3TPHrP39wyN40oKh4YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZjnUYAYa4XErF3d/6L1n2oj6tzHA7d86q7Nwm5QVNA9yIxYMjl2NVUZq1uRhqgWP
	 LjgzA4st28+T2ddrUf3/PnHsulkIQzuJKLypsTpIO7lDNBOXD1LZo+0Uk7jMiuIj87
	 t324POeGlBvoAntydbWEYeI4ldQbpUcNKBaKyvi4=
Date: Thu, 7 Nov 2024 08:26:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 6.12
Message-ID: <2024110700-unpaid-pendant-4c77@gregkh>
References: <ZyxmZi-xVcDV4lVL@ishi>
 <2024110757-armband-carmaker-f8f4@gregkh>
 <ZyxqbT7gnZ1Onf3v@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyxqbT7gnZ1Onf3v@ishi>

On Thu, Nov 07, 2024 at 04:21:17PM +0900, William Breathitt Gray wrote:
> On Thu, Nov 07, 2024 at 08:08:50AM +0100, Greg KH wrote:
> > On Thu, Nov 07, 2024 at 04:04:06PM +0900, William Breathitt Gray wrote:
> > > The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> > > 
> > >   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.12
> > > 
> > > for you to fetch changes up to 1437d9f1c56fce9c24e566508bce1d218dd5497a:
> > > 
> > >   counter: ti-ecap-capture: Add check for clk_enable() (2024-11-05 09:20:11 +0900)
> > > 
> > > ----------------------------------------------------------------
> > > Counter fixes for 6.12
> > > 
> > > Fix device_node handling in stm32-timer-cnt by calling required
> > > of_node_put() after device node is no longer needed. Check and handle
> > > clk_enable() failures in stm32-timer-cnt and ti-ecap-capture.
> > > 
> > > Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> > 
> > Can these wait for 6.13-rc1?  I'd like to not have to send another pull
> > request for this tree for 6.12-final if at all possible.  But if these
> > are issues that people are hitting now, I'll be glad to do so.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Sure, these would probably be fine going in for 6.13-rc1 instead. These
> issues are theoretical but I'm not aware of them being active problems
> for people currently.

Thanks, now queued up.

greg k-h

