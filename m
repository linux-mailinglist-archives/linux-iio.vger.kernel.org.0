Return-Path: <linux-iio+bounces-4222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A198A3C45
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 12:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C250F281F8F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11CA1E516;
	Sat, 13 Apr 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FqBdultP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627741D688
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004925; cv=none; b=VtFfwC93HHAU+Jl9CXCtGJoZtzy4ljvRFVUmJionpJxV5NqHLCxnT/3hyXWMqQ6AtDNogAFhYnxKKOWonVP5cuaHVXAac3oWfQN8c/W04Pl2sB2Y6lZ9SYbbYZfUaslaWnSWaxvyjkm5tvxtGebqpa5hSFFNq6isSU9WKGkiNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004925; c=relaxed/simple;
	bh=6iHeiJQNif8+Db+O9RT8MKCdtvcGntrKfWF7DyD5gUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thgV6X2A7qXfzugZV6/LmjFAZD6xzlUg/BIFt6RWwmr/gZw59H5IgDBG4I9l6LXpemLOcE8aYevUuHDBy4llEVn841sSmev/arZ6r1D6gAN+O6fyy0VBpe4RS5RjQCW77kdSZcKNS/5dGVgwyVSTalgfe6BW6+2OLa13mRPa7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FqBdultP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C441C2BBFC;
	Sat, 13 Apr 2024 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713004924;
	bh=6iHeiJQNif8+Db+O9RT8MKCdtvcGntrKfWF7DyD5gUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqBdultPe6dk9sUYhGMsInBKkcHD1Jhn1pu+FpdNpXt0DIDhex5VwvULJBhjLq+Ck
	 d3qqtNIlHhZR33VrYVeCHHOOzeQnty3JoSXzcqrpdIdNsv0V7kq0LGzEsMIJ8FCaJc
	 Xu6dSz6+KNyjp+vjl+ZmvFK20+DWB3IXNBGX2Jzg=
Date: Sat, 13 Apr 2024 12:40:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.10
Message-ID: <2024041338-anchor-tipping-a57a@gregkh>
References: <Zho9QUfTfT-uHptA@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zho9QUfTfT-uHptA@ishi>

On Sat, Apr 13, 2024 at 04:07:29AM -0400, William Breathitt Gray wrote:
> The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:
> 
>   Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.10

Pulled and pushed out, thanks.

greg k-h

