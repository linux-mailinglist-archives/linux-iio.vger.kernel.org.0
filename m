Return-Path: <linux-iio+bounces-1166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F481A657
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 18:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62331C24EAF
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0047A46;
	Wed, 20 Dec 2023 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nxtwn1+N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CA47A4C
	for <linux-iio@vger.kernel.org>; Wed, 20 Dec 2023 17:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CABC433C8;
	Wed, 20 Dec 2023 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703093401;
	bh=KWMe8dZc16asY/n+l/Y9Bl5j/40VLDxMqyaW6MKfgnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxtwn1+NzIKnbhC9BRJlZxbGs7ifxQ/ab/SYNSxnkgG1oXbTln1NdqDZOjbHYx3QB
	 EozsM9mYQ+V/L/ia8QcTWRNnWBoDmVi3ffNh4NhCL/F7bIutxto4fOV6Xqcgr/r85X
	 2OmGnveLZ31D6adA+DWg1yXclaBt/Bo3LmCRa4Gw=
Date: Wed, 20 Dec 2023 17:14:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support etc for 6.8
Message-ID: <2023122040-glare-rope-fee1@gregkh>
References: <20231220150007.200d5183@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220150007.200d5183@jic23-huawei>

On Wed, Dec 20, 2023 at 03:00:07PM +0000, Jonathan Cameron wrote:
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.8a

Pulled and pushed out, thanks.

greg k-h

