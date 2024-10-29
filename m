Return-Path: <linux-iio+bounces-11538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860569B40C6
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 04:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E21F22EBB
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C731F12F0;
	Tue, 29 Oct 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xdd+VVuY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1B9149C4F
	for <linux-iio@vger.kernel.org>; Tue, 29 Oct 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171493; cv=none; b=jiQSqNcU0WUJvnoL2waDGVZk8OD/qkwM9Gs5/6l6ne0X+okc+PXNbNA7SlDdwxFSx4GyZT/It+ePbHSy49LE8mb/iCqO3rQ+sgllMqHWP470mp2/IELXHnm6iGDyduxlPQPmlWQg8CwGzjtzDpGt3pRGbLuGftijFj2WzQ6R9/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171493; c=relaxed/simple;
	bh=SKDgywCLCwQQl7kETgQoWYbTxrkbEZDcwRuhsWoZCAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6JPs89bdVE/9RpAY+iMlgIePeRjnAKOViZRyaxNTcvjFGFDzDVSRClYx05ytJP+BB7YYKEWhoIjPjFEd27EdlDh5iw0kFfUfL3eY05jnTIeQZ9tDOVkIrBtGaJlj6zLWrfKk3+tpuMcSoL850QhpaKK+qEpaWGNUqPQcMO31y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xdd+VVuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4757DC4CECD;
	Tue, 29 Oct 2024 03:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730171493;
	bh=SKDgywCLCwQQl7kETgQoWYbTxrkbEZDcwRuhsWoZCAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xdd+VVuYGW8XolHeUlN4VbqYFIEc2lgWt4D7uZ0Hix7X6ol+a3jmW/0kvj3dnr2pZ
	 wkPijj1062BIMrDEZ0Pjyw+nKtnlYDbNdLA9TJw/r13sRra6cinXMVxBB9dfGuy18O
	 6KPyVy+2dxBAHYU/Lum06vQo6U1m3rDss1v2W0pw=
Date: Tue, 29 Oct 2024 04:10:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: Fixes for 6.12 - set 2
Message-ID: <2024102949-maimed-untamed-8881@gregkh>
References: <20241026113927.333b48c1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026113927.333b48c1@jic23-huawei>

On Sat, Oct 26, 2024 at 11:39:27AM +0100, Jonathan Cameron wrote:
> 
> The following changes since commit 2471787c1f0dae6721f60ab44be37460635d3732:
> 
>   misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for OTP device (2024-10-13 18:17:57 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.12b

Pulled and pushed out, thanks.

greg k-h

