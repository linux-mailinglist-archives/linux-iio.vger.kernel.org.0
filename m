Return-Path: <linux-iio+bounces-3260-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCAF86F1F5
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 19:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EA1F21324
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14473FB3E;
	Sat,  2 Mar 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaT6hfIl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4293FB39
	for <linux-iio@vger.kernel.org>; Sat,  2 Mar 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709405732; cv=none; b=U2+ALGKuOq2Ihiw6aoM/qoVRDxh+5+QpIbQLBO08uhVsSR70t5PksIbCPEfdU8AOI9Vm7NcfadhnkeVBZUbHcBHMX5b8e+Mgwd8A+0s3I1eHHcPsrugD7lUhxklLm2iUiKHVkLjwmiAWwSHX4cduiVsiT9jtTQEX+0boCTbFd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709405732; c=relaxed/simple;
	bh=dm6CEVcqDjmgoxwjyzb2LZxOjwwCYHZ+ZJKYHhxdW6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaMHQlDUA44HkbmHKH7AhJ1pDWZTmUTqTeURUX6S4TVP0/bNF8x+4o86WKF0FjV7jZh/GChHc/sc4QX1SZ5VzTK6Fdxl4MAT3+z3HC14YlyIxfETvOiDFLvKJIo3YuOy8VUnOeFRbPy4cwG6OQzk7O8pbfhT7izTqUfd3x744vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaT6hfIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07C4C433F1;
	Sat,  2 Mar 2024 18:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709405732;
	bh=dm6CEVcqDjmgoxwjyzb2LZxOjwwCYHZ+ZJKYHhxdW6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaT6hfIlIxTi7of/pqfxPoXsqnNh2HH0EyNY5SH7aW7b7BmIcoO8au3k6HEG+PBfC
	 9goPBxP/Vy9DMk4Mhj9slEFwAMjZtQFwH5LKOSeQtdQ5nP2kTAlDRzryz+sjIvq6Aq
	 RzyiDfrM0LvYgXzKy6JyIYcKWY+3eLBtU3mWpXvg=
Date: Sat, 2 Mar 2024 19:55:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO fixes for 6.8 - second set.
Message-ID: <2024030221-darling-riverboat-e62c@gregkh>
References: <20240229200703.52697131@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229200703.52697131@jic23-huawei>

On Thu, Feb 29, 2024 at 08:07:03PM +0000, Jonathan Cameron wrote:
> The following changes since commit e20f378d993b1034eebe3ae78e67f3ed10e75356:
> 
>   nvmem: include bit index in cell sysfs file name (2024-02-14 16:28:16 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.8b

Pulled and pushed out, thanks.

greg k-h

