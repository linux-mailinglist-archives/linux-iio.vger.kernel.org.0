Return-Path: <linux-iio+bounces-2551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E373B854C9E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A069028884F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4D05C604;
	Wed, 14 Feb 2024 15:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UQjKo0xP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502755C3C
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924377; cv=none; b=uCgBcy6xjVIHBVsmfQAO3uA8xDIOgZ5QNcxqWejCILDS4QB+EsH7LAKAZC7y73w6gd9X0kdbsYy+nUoGBVMY25zn9b8+BUQP3FuU4kN+8i2WgZOLOnq6KojGGzPAnc0TPFY9tq3JtmcT5nis83V64hBMJl4VRLUunAjJAsKOhxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924377; c=relaxed/simple;
	bh=3st6E+/bWDjjSdO/bnC1JURLhMHgNkmUXB5pTv3AA9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVcn6CY0K7KAukQjAAVuuF1RHH62KAZjhZyU/lf2MQfbnML1FUaAR5eODoEICr3EY7uqjraHTu6uv6bK4ZHQiQ/TR2BxpYeSq0kMbCrFRytIA8BRvLPDfI4tT10cOrV64umS77rqMf0TpPxfXTyuMjlnrwKEuYkSWFDuHmovAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UQjKo0xP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4014C433C7;
	Wed, 14 Feb 2024 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924376;
	bh=3st6E+/bWDjjSdO/bnC1JURLhMHgNkmUXB5pTv3AA9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQjKo0xPhXs1S6XsGjL6sgOKveN0cD1nIBw1ij/z9aTnrVi6dGyGTA3eb7tnDe5re
	 H3WquR+MYY9glAQorYrM2qHEdnxAydGpu/OswXRIu8dV6oW/eO6IFupM39fqr8SNC+
	 WzYgzf33LdnkUZXhx6GfYG4QCIGSMFBeg5KWtWtI=
Date: Wed, 14 Feb 2024 16:26:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for the 6.8 cycle.
Message-ID: <2024021457-startup-deuce-d5c0@gregkh>
References: <20240211164905.32fb8438@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211164905.32fb8438@jic23-huawei>

On Sun, Feb 11, 2024 at 04:49:05PM +0000, Jonathan Cameron wrote:
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.8a

Sorry for the delay, now queued up.

greg k-h

