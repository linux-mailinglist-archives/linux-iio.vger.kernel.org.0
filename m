Return-Path: <linux-iio+bounces-14200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6BCA0A957
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0907D3A1F68
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69201B4128;
	Sun, 12 Jan 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JS5Ni19S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F001B3921
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736686169; cv=none; b=eCseQSJJU+500hQ1irkzVb4yfNoWVXmRCnRmZl6tEg9Cq7SfMP9Yt2DilHT7HtG0jM0aZbNUNRVIHXK1motwW8QbufrRozsXHnoZadSlM2zN95fj2UHitcypSk9VVoHyyYbXLzM3IVI07uOX41/kmp16CYBQMW+VenVfVYjanlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736686169; c=relaxed/simple;
	bh=IbfPb1GknC2EUa0Myj/L7z/bbna1NxKIHeOayIU/vuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoT6lOV8blUSXUuFlpX5nB5wNO5RuoioPBFe8PGq9t7KKXPAm+Qbib4dqGOwojro0yvdip5TH9beXqbZyKB7f/xCG/A1M6i/F9BBu7Dv9QDOmQ6k12ooUNowjlldzh89FlmX9wBySki3fS/TCkQdzCUB6OnzfSk99NG901o49tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JS5Ni19S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C1C4CEDF;
	Sun, 12 Jan 2025 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736686168;
	bh=IbfPb1GknC2EUa0Myj/L7z/bbna1NxKIHeOayIU/vuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JS5Ni19Sx9MPmMLLBeQSVTmAa0OYkabX+R7kj5ve2biKWMG2hi7pFPWzhbJXVFms3
	 gY5MpvpUlPki2kfLe8vNC2qtf3rls3QR58yNBGoxdSqFKjXYzNPPuqFMykE2XgHLcA
	 8O7ZHCwV+nhjIOrNqOwAnx2EHoIxZiTiHV4NT6gg=
Date: Sun, 12 Jan 2025 13:47:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support, features and cleanup
 for 6.14
Message-ID: <2025011208-glider-happening-f481@gregkh>
References: <20250111132110.0b2d4fa2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111132110.0b2d4fa2@jic23-huawei>

On Sat, Jan 11, 2025 at 01:21:10PM +0000, Jonathan Cameron wrote:
> The following changes since commit cdd30ebb1b9f36159d66f088b61aee264e649d7a:
> 
>   module: Convert symbol namespace to string literal (2024-12-02 11:34:44 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.14a

Pulled and pushed out.

> for you to fetch changes up to 577a66e2e634f712384c57a98f504c44ea4b47da:
> 
>   iio: iio-mux: kzalloc instead of devm_kzalloc to ensure page alignment (2025-01-04 14:48:17 +0000)
> 
> ----------------------------------------------------------------
> IIO: 1st set of new device support, features and cleanup for 6.14
> 
> Fairly quiet cycle. Usual mix of new drivers, device support in
> existing drivers, features and more general rework and cleanup.
> There are a few late breaking or long standing but complex fixes
> in here as well.
> 
> There is one expected merge conflict due to an upstream fix touching
> neighboring code in ti-ads1119. The trivial resolution is the right one with
> the result ending up as:
> 
> 	struct {
> 		s16 sample;
> 		aligned_s64 timestamp;
> 	} scan;

I'll save this for later if it comes up, it didn't when I pulled this.

thanks,

greg k-h

