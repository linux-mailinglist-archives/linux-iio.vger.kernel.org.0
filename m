Return-Path: <linux-iio+bounces-12073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D18F9C2D92
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0152D281593
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0791925A2;
	Sat,  9 Nov 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uSD1n4EH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C5186E2E
	for <linux-iio@vger.kernel.org>; Sat,  9 Nov 2024 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731159644; cv=none; b=XJkDI9RYI93qM9orztVfQemcEgyVfDc4TxagWLugRc4y+eKP3bUbdoRS1KGeONeH/V03L96U1u4CWqAu75dizmvltVAZuwUz2oY/TQa7fPkdKhJPxEpzFMBAeaseY75qDT9wpZ5vNl5BVcIqO33KUBTCV8ODVm9hkPSrR5IAZjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731159644; c=relaxed/simple;
	bh=2C47yE1ZEQJKWTjgQdn/GMBocmMFbnAbHrolZGcU6XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJedcZxbC9tblTs7mS1WfeS95fGOA223LaKyvYy5d8kJO7QTIc7HH4MqMeBo5gsADVbONiZMY5eoc8lpsZIQLJI1EeIfp+fbkOjNI5/QWpWuDfolkq6VQFW/0FqZ9RMJXyUtAbZc8d694Ys8Pq+ukegdV/lUwrSnC4GLJwFB8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uSD1n4EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13860C4CECE;
	Sat,  9 Nov 2024 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731159643;
	bh=2C47yE1ZEQJKWTjgQdn/GMBocmMFbnAbHrolZGcU6XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSD1n4EHF3Qo299JgfYiTUtca/Zo1DwqT3pptWM0xJy+4wois5Qp6YwiFpUzt7jBM
	 e38DtJ7z1EPajRvHzx2o4bQ+4MQHyLtClUI1Cn34lenC0zh3wZ44ZhwIFNB8EYaxkH
	 cEQDb91FgLLQjp9yvDIyKAF4mA13o2Xr2qSLEYWY=
Date: Sat, 9 Nov 2024 14:40:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, features and cleanup
 for 6.13
Message-ID: <2024110931-recall-deviator-a16a@gregkh>
References: <20241109111845.31155f91@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109111845.31155f91@jic23-huawei>

On Sat, Nov 09, 2024 at 11:18:45AM +0000, Jonathan Cameron wrote:
> The following changes since commit 9365f0de4303f82ed4c2db1c39d3de824b249d80:
> 
>   Merge 6.12-rc6 into char-misc-next (2024-11-05 09:36:29 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.13b

Pulled and pushed out, thanks.

greg k-h

