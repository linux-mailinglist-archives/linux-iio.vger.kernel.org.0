Return-Path: <linux-iio+bounces-24137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC1B590B1
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B25C32112C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296FD281368;
	Tue, 16 Sep 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIsdOQJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E8285CA1
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011489; cv=none; b=X6gQb31w21EJaXQnSJAMPBUKrHu1sMYUkHgwnEZWHaPolDl+Q1eBeEc19TI5S4+EBwSqMzY9YhJMYWVRfrHtVH5YT7rksR94HH7AwWEhfM7k/RdhDiU2Ydqsozy5Gi7xueUFeREOZlQJ/RUXlqJXmwQMlspU28c0NuX6HPwNsfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011489; c=relaxed/simple;
	bh=QaAf9y4dXqF4u8a4YwpbNHw+MShu62gaDwoF6e+/oN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2iHR/Tl7X94NpiJg67OdSiqWi3hJ104sbwfei44O/Ujd36X5BYOkonGLleSk9zrM2vobVEaACcmC9TmGMlUjvpQOgJqzlkUeIrWRKC9RkR13CTkC1/KTThw7/DSj8kz2UAwbWbikcQuiFl2v9sKoV4XJA86tuPygqERP5dGM9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIsdOQJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD7DC4CEEB;
	Tue, 16 Sep 2025 08:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011489;
	bh=QaAf9y4dXqF4u8a4YwpbNHw+MShu62gaDwoF6e+/oN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIsdOQJicqnqoaaJpZY2d78JOhDM3r154alckQxFkjZc7HWsUIg2s8w/aCmyyBKuk
	 l/o0CMlQBy1eiXErLn30obaue2cFG2bvxTiDAc1IBpuyyNqbObapgq32WbY2zR/YZM
	 E8vpYbK2XZz4S2rt5eKsS8is6XagDKcS8/quzimM=
Date: Tue, 16 Sep 2025 10:31:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for 6.17 (or 6.18 merge window
 given timing)
Message-ID: <2025091614-bauble-shaky-09e0@gregkh>
References: <20250916090413.48a78014@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916090413.48a78014@jic23-huawei>

On Tue, Sep 16, 2025 at 09:04:13AM +0100, Jonathan Cameron wrote:
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:
> 
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.17b

I'll take this for 6.18-rc1 for now, thanks!

greg k-h

