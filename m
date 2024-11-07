Return-Path: <linux-iio+bounces-11962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F09BFEBD
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 08:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201131C20D60
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 07:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC519412E;
	Thu,  7 Nov 2024 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVqFnvkJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7DE194AEE
	for <linux-iio@vger.kernel.org>; Thu,  7 Nov 2024 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962932; cv=none; b=XHnZVpI1VCLbMXBpWMeJiIMNPoPxJWI5QkGkK2TX16eofqsCDkZmr2r3SywsCNfawNyJc0er34IbEQeKjSRmYx6zZ7bRE89RE5rH3fvHuNw+QgTGzpU9KW9lGD+sDy4Nv8KJJlZsLW+ub/Em2V94+c8kEGykZ2l7aA0zpT72mHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962932; c=relaxed/simple;
	bh=09RXmVK/vnDxPperz8AaphO7vIG1t5oftQsOYUeWlzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmByLNOnoOGyxKSK+K0CrjmiYncbbjuBrWSKDenguEMRdRdlJGbuNY3VAS8kri/sqxVHXo7O2MXa4W3yF36Psftkb0BnnWVCCBpv5HdqByQ1QiXuFKH0OFchlMLvVzXFo7ZnejFDQt36hJ7V3gYVfs0+YM0iuYGGoBThFitJ668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVqFnvkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B93AC4CECC;
	Thu,  7 Nov 2024 07:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730962932;
	bh=09RXmVK/vnDxPperz8AaphO7vIG1t5oftQsOYUeWlzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DVqFnvkJD4PKK1O6/2WGnU1IdLNuAgy/+UZPrs3VQkl9e+muBkFC5i3dT/4ty9A1x
	 uZOZvi/IYvjDbR0C/QxXHcUWySvwrbEY6RxUJouzoKAEwWDXK/pDZb20c4M48VQ7Qq
	 jDgdS2wERCi/RLWCa+dvUZ1p0qUFt7bIwIX3ZEyA=
Date: Thu, 7 Nov 2024 08:01:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.13
Message-ID: <2024110737-dreamlike-moaner-2330@gregkh>
References: <ZyxjoC3zM3CgWrve@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyxjoC3zM3CgWrve@ishi>

On Thu, Nov 07, 2024 at 03:52:16PM +0900, William Breathitt Gray wrote:
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.13
> 
> for you to fetch changes up to 522ae89b78580c62765e160aed3479297baa75be:

Pulled and pushed out, thanks.

greg k-h

