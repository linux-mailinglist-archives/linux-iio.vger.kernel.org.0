Return-Path: <linux-iio+bounces-24368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B03B95D6D
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 14:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2CB1893D0F
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 12:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC8322DC3;
	Tue, 23 Sep 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AdbFnEh6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40042EE5FC
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630299; cv=none; b=C+dScaXXAnxV6Q9bjh0U0O01HSLuGKrKIopSOuBlFHLl3+XN9MZ9TGHNAaHYT1IShNmgXwP7Ym2KD/wowcKpQCmcbx1mz386WaarAU/eDqkjujNOSxLwW37iyrDxS4flU6IWgQToyVx/ZPYXeEa+ClMeAV5jaV/tCvQdHQyTkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630299; c=relaxed/simple;
	bh=JcnGx4NDMazqR/539QhIjEshJukbvKG40lUjFVUgRXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA9HinKqdtDPhdQQ37YQ9TwGVF9fOVa0WgrXzObibIsMSmKC1dgrgoryuYbtg8rHQcZ3MuLwvSDohpqaLqR3ITt67aQYWL1Yik2QEAY+QUVTAwDUWny36T7Bz58/Fks6YPruhKRGQV+/h4XYjf1wkOs3jLA1KQuYQWX6y4NZhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AdbFnEh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F255C4CEF5;
	Tue, 23 Sep 2025 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758630298;
	bh=JcnGx4NDMazqR/539QhIjEshJukbvKG40lUjFVUgRXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AdbFnEh6WIYmxC1tVf/d/ANDtSOKdBsg4XzaMZfqEf9ozYoBMZN/NAxdfOySMJtgA
	 p6WpenV+7wXT38I+J/AKvinNTLFxmKG+iZ7CuopM14PxFNEATa0cEFeKM342AwRnJY
	 vBu/GiCh1z8E7Q/woulSbM8Y3+PjfIhoTswfq6Ww=
Date: Tue, 23 Sep 2025 14:17:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.18
Message-ID: <2025092308-overexert-casualty-18f8@gregkh>
References: <20250919155117.4ebe23e3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919155117.4ebe23e3@jic23-huawei>

On Fri, Sep 19, 2025 at 03:51:17PM +0100, Jonathan Cameron wrote:
> The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:
> 
>   Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.18a

Pulled and pushed out, thanks.

greg k-h

