Return-Path: <linux-iio+bounces-23030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81CB2D78F
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 11:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15FDB1BA431A
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8242DAFBD;
	Wed, 20 Aug 2025 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vb9uGMa2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15422DAFA9
	for <linux-iio@vger.kernel.org>; Wed, 20 Aug 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680776; cv=none; b=egDPkvjX2OtJtBTO4CCjzWKenT5QmaVVjKBFYq/nUYnbGvDGGzq5q6eHkZb3VwiXKYKgvM7KFTSDbxwMp0SyRpaaY5iDrpAtguRbQmMPWlvitX3XRCrS2Ks8D40gWvGuqkqX9cW9immd55v6MC8cnGfa+T91GADvhncXCFqxSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680776; c=relaxed/simple;
	bh=S4Wqiryw4MwUiHxQzWdjvToMaIq8YmIYYfOErDXTxoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEhU8Lt3nHMQwHOfYJVu7AeakKvQUCYXLH0u5JYHq7kSydQRfR/PPIulM3PCC10ce6A/CdRN2XSt54ojHwj5V1x+IozC0YCiKcGEs6975JzBEIqnYwGu6bSznjFXIUWaCmaRNXctrU7J0VkFODo2UrdqlskKfAvnDX16ZxLlUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vb9uGMa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D058C116B1;
	Wed, 20 Aug 2025 09:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680776;
	bh=S4Wqiryw4MwUiHxQzWdjvToMaIq8YmIYYfOErDXTxoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vb9uGMa2ynFcoAh4jIga4uWMNTgFKeQfRltJozHw+ezOZqS2rWJRHiRCV5lCO9ZoB
	 CYI9IK9zfBYc9FWqO/oNAqDiJLZoOy5b7gdA4LJHXglyQGJlb3z2Si2YJZloksJVsa
	 58/U4oLDHioC/S++eSBYPV2X/80JLuxxsKJfvt9Y=
Date: Wed, 20 Aug 2025 11:05:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for 6.17
Message-ID: <2025082033-roundup-playable-1443@gregkh>
References: <20250819184005.301b9cf5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819184005.301b9cf5@jic23-huawei>

On Tue, Aug 19, 2025 at 06:40:05PM +0100, Jonathan Cameron wrote:
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.17a

Pulled and pushed out, thanks.

greg k-h

