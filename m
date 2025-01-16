Return-Path: <linux-iio+bounces-14391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AA2A13A31
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 13:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6077A3A7DAD
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 12:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2778C1DE882;
	Thu, 16 Jan 2025 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OppiXGyw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE671DDA3F
	for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031623; cv=none; b=fNFQRa8EIVVN8/jKwYABjCyBSqBYyTvmD8AjPjs1nnLf2d1HoZo6JFKO97mr8LiU4r/vm8szwnelcCJN7KnZ94zPXBL5nIObZVVW9eHhvwwf1p6ZMt5AB4T3ENG+uEZLcnrpo4OfiMlHKhfujWkauBrcqxb5sBnA7wbyFe8U1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031623; c=relaxed/simple;
	bh=LrXer9w6OjDAAXG3keAeqMFuo5I6bh1iK55yyIYtDIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV36KV9RGJIOTCvx4ff3d08vo1UZiAvRNLELsmrqaW5mhHwRpEVl8gz4z+B9r3zy0EFZWT1ZgPOotK+WDAdkzrj0WPZKSNEuy6AoYeMaCN8Xnjt3JCtReXNu9jkoRUmEMAjQ8mvyu8Zqmas01QeYwInwJOKNLrEzxwxJ29IZ2qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OppiXGyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4086C4CED6;
	Thu, 16 Jan 2025 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737031623;
	bh=LrXer9w6OjDAAXG3keAeqMFuo5I6bh1iK55yyIYtDIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OppiXGywPH2lGmkr8QQuKNP0ULlW3i/v99CRbm2VgN5rGSumpaXBehSpYGx/D44EZ
	 HItD9KjC6inowMFsXt8C2yKUH7RhrCYkT/+4Ng21HjU+URBDG5CJRC45raLAeY930w
	 kLYB3ItQ9pajUp8lVE5CCJKQvvZjkW3omrtmTW18=
Date: Thu, 16 Jan 2025 13:46:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for 6.13 (or 6.14)
Message-ID: <2025011635-voice-vaseline-0acd@gregkh>
References: <20250115192007.7e022805@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115192007.7e022805@jic23-huawei>

On Wed, Jan 15, 2025 at 07:20:07PM +0000, Jonathan Cameron wrote:
> The following changes since commit e16ebd9d839d1252ff15c29d37b0cf303ddd2662:
> 
>   Merge tag 'mhi-fixes-for-v6.13' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mani/mhi into char-misc-linus (2024-12-16 16:30:58 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.13b

Pulled and pushed out for 6.14-rc1

thanks,

greg k-h

