Return-Path: <linux-iio+bounces-21769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791B4B0AE7A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E45AA708A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 07:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2222FDFF;
	Sat, 19 Jul 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B74lqVlf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE99881E
	for <linux-iio@vger.kernel.org>; Sat, 19 Jul 2025 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911384; cv=none; b=ZQzdB1Unq40jnhw6vgnJ9qHUjLFrP5kKg6dFjuJu9Ddzc2ffCDV2G9/p6BhDBYOXVbKDL2hrVN/WZmnOgcHR9YXor7K1ZykkB0bH0ROUAVHgKgj6fDiCp1wKSun0TMb+5bUQJzt9mvNrTu75wCXNDt9QHSxA3b3ZMgSkyAo6McQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911384; c=relaxed/simple;
	bh=m0iCCOqgdza5YygaUhdoVlexsbA4irx9HQ0d6sFnxMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrtYhwiGd+3Dr/wVCgmEbSevSB4AApUHT0PIaBcpcQPxwV9FF5Am5HVGSwbq3P0Ph0M3uIU0WSiWICc1iyTH1RHV6S1gZF/x4mmouaNJg9DlB9L9sE2y1mB/Arwm+0kSF9dMusNh+L7TUWOxFcS3gzJ+6TX9fU9+kZOqPlGwBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B74lqVlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF1CC4CEE3;
	Sat, 19 Jul 2025 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752911383;
	bh=m0iCCOqgdza5YygaUhdoVlexsbA4irx9HQ0d6sFnxMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B74lqVlfnXlDqSO7ZGBLSkYSgFPZ50YKVDLH/aCl5aT0OWHgRvH4te76DEezE2ytl
	 NDbnWAYgDYbEQnen+ffJtCTiNvMBSlyVAsS+LZau8Ba7mA5zAR3X3WjN8u7EZ6RA8K
	 Jp8KEwGwQ561+htL57qkwesJXVPBqVqRS692OH4s=
Date: Sat, 19 Jul 2025 09:48:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New driver support, features etc for 6.17
Message-ID: <2025071918-depth-delighted-ff0d@gregkh>
References: <20250718075616.5c79192f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718075616.5c79192f@jic23-huawei>

On Fri, Jul 18, 2025 at 07:56:16AM +0100, Jonathan Cameron wrote:
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> 
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.17a

Pulled and pushed out, thanks.

greg k-h

