Return-Path: <linux-iio+bounces-9319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D469706D3
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 13:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BA71C20C0B
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 11:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF3152176;
	Sun,  8 Sep 2024 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dn2iYkse"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28E36B0D
	for <linux-iio@vger.kernel.org>; Sun,  8 Sep 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794737; cv=none; b=Uq+JLlGuzMd+hhvQySyFTDivfX2ezU7OGbrizH+qAHaKTB24j01CLPqPm9JtU5ydMpZWG7+VsDV6hmKDltWg55mQLon4CaM6+Vhw45sSrwFs6jtHTh1vbJ3APr+Xm5o7WYEZCNWVTSrZ0Y/YhOO2eISWi1CKkVdQP+Ojnn9TqgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794737; c=relaxed/simple;
	bh=TUCZEXpzZa+Az+VV8DqfOssEfw2PiA/mw7eggCLc5/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+NiaGIBE0GAorLIo9Hy007c/eZby6CJPua38/MeMSp6cidsIYXN0BJtVbF2y2QgfHr4maIQ2tiL2PdMUpu1WrWSdn2RFpvPt556anl110AuCKv4/Xke3rCQyl/Al0wUMxXry6aFIMGNkTvIGlVD3eNOAh8UAaVVfWxDjajqtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dn2iYkse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0562FC4CEC3;
	Sun,  8 Sep 2024 11:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725794736;
	bh=TUCZEXpzZa+Az+VV8DqfOssEfw2PiA/mw7eggCLc5/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dn2iYkseOnrK6KtiVptC+CtOZjPxPcGymANx0D/NU0QELKka1ZwbLX7CGazWTc5St
	 ku7hch8Hf4hedwgRdJeGYsSeQmYroElg5BDOreh1L4kkrQzU2blYA2yaNhboK6Q3+I
	 zyxmujUFTWEOw9Y1x9DezwI+XDhYOsf8cnz7uF/c=
Date: Sun, 8 Sep 2024 13:24:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, features and cleanup
 for 6.12.
Message-ID: <2024090843-expand-badass-5d3f@gregkh>
References: <20240908113909.24938c59@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908113909.24938c59@jic23-huawei>

On Sun, Sep 08, 2024 at 11:39:09AM +0100, Jonathan Cameron wrote:
> The following changes since commit aead27d77f3e703f6056e12fb19f48a426df2fd7:
> 
>   Merge tag 'fpga-for-6.12-rc1' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-next (2024-09-03 12:08:18 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.12b
> 

Pulled and pushed out, thanks.

greg k-h

