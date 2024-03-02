Return-Path: <linux-iio+bounces-3261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD8586F1F6
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 19:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816B01C2116D
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E033FB39;
	Sat,  2 Mar 2024 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZnCiMAv5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0961E50B
	for <linux-iio@vger.kernel.org>; Sat,  2 Mar 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709405822; cv=none; b=Lo4GAIUTUb6vC1mn8ddg9LglnsUvw2hKI0LEQ34DeK9mr4WRcj5VM8PEViLB9jOrh85brbWQTy9sfLQZeStdsGWSAF3OC3ZF82ldbAcPEw2U2oyuUR3opoMeB6In2xz5J9fYU2u6ruzvIweUi7HjdYtXFyP4nPV6feg/cZf0p1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709405822; c=relaxed/simple;
	bh=C96gi/IeFPEgey2IRLeLFFoG3J0nARTU61o42ew4tyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQbwZ3o2gUxUKJ9Ew0os16c+4yUMFAsEW26azpCUWzuzjw1g0/dHJvXYFR13/V7qwnltOZRvifxBeeCuTvNghWRKYPJ0ZwDr/CpfS79H7/6R+98EGpDXCCFyHMYWZrrNaJ9JzZltteSGv9ioelZIMmVq+BMXdIL6IQeapHaJ0DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZnCiMAv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C091C43390;
	Sat,  2 Mar 2024 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709405821;
	bh=C96gi/IeFPEgey2IRLeLFFoG3J0nARTU61o42ew4tyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnCiMAv5QAoeWmS87AF/hUsSv9BsUJukDxchWinTE05dmSeojSDJtuqu0rrdwum2B
	 w3NewgPgEKkrJrOkdyU5wELRLWB5A6+f67zt3N9svBRYTWHrcVHKlfP6v1lN67X702
	 V8tAFPKb4J0t9uJDsz8wKqDDbaLZyYlE2HsGOnio=
Date: Sat, 2 Mar 2024 19:56:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes for 6.8 - second set.
Message-ID: <2024030251-moonlight-slacked-4ad3@gregkh>
References: <20240229200703.52697131@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229200703.52697131@jic23-huawei>

On Thu, Feb 29, 2024 at 08:07:03PM +0000, Jonathan Cameron wrote:
> The following changes since commit e20f378d993b1034eebe3ae78e67f3ed10e75356:
> 
>   nvmem: include bit index in cell sysfs file name (2024-02-14 16:28:16 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.8b

Pulled and pushed out, thanks.,

greg k-h

