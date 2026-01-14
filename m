Return-Path: <linux-iio+bounces-27767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156AD1E63A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 405AD304E152
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3821393DF9;
	Wed, 14 Jan 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lv2ocGbq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EE3803C9
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389986; cv=none; b=bUhD+FB+E+5ZyJk5a8sAQde/+rXIL7hZ4WB1sStxjiWShHoUeFqgAm5En6cD8Vffe2ZQGuzKU68spWFc9Hz0UWt2yJ104eO4n49PoUW20pV89Edm49u83r5JtOTv1MPj8lCZ8JHH6/eo7LYFYfZU1T00A1dzAqq19KRe//QMkxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389986; c=relaxed/simple;
	bh=fjuL3kP1ndeIJHDQe3Y1vvIfJefTX7luIsxi49RGwuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c49ULCl3hqRcdxv8dWwdDPsJl7/rOtJ9wQGH/mcQwLMTl10ReuD5VV2HKrBUzUhIqW0Hu+3EzSfXAj61XuD6RpPPJzIzOSictxpYuhY3OnsXSHiwlyUldBbgr6R+AzFrPXehdZlzIae4K6IvYA0Ant50yL01zXjpg3xVSz0i6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lv2ocGbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AC6C4CEF7;
	Wed, 14 Jan 2026 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768389986;
	bh=fjuL3kP1ndeIJHDQe3Y1vvIfJefTX7luIsxi49RGwuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lv2ocGbqurrYLwd4bTmUnkACvlnW4uNz0CUYPyhedFwsvdc05SgS5F0Tkw8BiV1lt
	 H2NSzZJKJy2GiUd9tMVJQwLnXR6J4ZhbyJZc9Hc4p4us+KaJvtwXJNbfgB86xm2VW6
	 HLe0WcxwmsYQOEhVLQIAPWB4B3dEQKdwFxY/Yooo=
Date: Wed, 14 Jan 2026 12:26:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.20
Message-ID: <2026011406-coasting-swinging-36e9@gregkh>
References: <aWd0BhyFMqR_ltOT@merlin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWd0BhyFMqR_ltOT@merlin>

On Wed, Jan 14, 2026 at 07:46:30PM +0900, William Breathitt Gray wrote:
> The following changes since commit 9448598b22c50c8a5bb77a9103e2d49f134c9578:
> 
>   Linux 6.19-rc2 (2025-12-21 15:52:04 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.20

Pulled and pushed out, thanks.

greg k-h

