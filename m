Return-Path: <linux-iio+bounces-850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BD80E684
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 09:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB611C2137D
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 08:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC620219E7;
	Tue, 12 Dec 2023 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBOkaF9G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E139199D1
	for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2023 08:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14785C433C7;
	Tue, 12 Dec 2023 08:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370678;
	bh=ZSGzB3yLmBT61WNXTF3gPGqv66VvNKdQGYPScsB9ESI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBOkaF9G9Ah/eSW3xU4zCEVlqqSlKlxCUEJySn4MdyPHkqdKD7vViSNUn/NkNh8rX
	 U+zWo4P7SEs3MT0sr/xIho+HDmOsJe6RKPY38yDO6wqYjbOEZa/qfsBw2K5uDCLwIY
	 sqNWJgT7cEPHcTyQD34Ngm8pf4UtJnT5RHd66aKo=
Date: Tue, 12 Dec 2023 09:43:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 6.7
Message-ID: <2023121246-thread-colony-39aa@gregkh>
References: <20231211193516.2a884b3f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211193516.2a884b3f@jic23-huawei>

On Mon, Dec 11, 2023 at 07:35:16PM +0000, Jonathan Cameron wrote:
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.7a

Pulled and pushed out, thanks.

greg k-h

