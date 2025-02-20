Return-Path: <linux-iio+bounces-15845-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1139A3D957
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8730177B9C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402F1F4604;
	Thu, 20 Feb 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HncoimCz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA21EE01B;
	Thu, 20 Feb 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052745; cv=none; b=GUwvH+JSSyhfdSa2cd4mLSUf/xcRzCNbMCMCM4DxwdD07BAXK3anSeoleRsR8dW6BHJKvYtC7NIIMl9K0KkW4iWENlLEdRVIrttz6MMuWG3/jYZqxoj7UxOrq/dyTympRCpBMwkDp7zw6VvUKSgQ0psORZAtg1LV6i6dDkoStjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052745; c=relaxed/simple;
	bh=u5NMKxhWnD/Z/8UewhmeT1rkRCBSaZTnMl4Wu8+zXuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C50C4sEb6GndeCpEIj3W8TFdLeWDurIvl3ydG61+Y/rp6tHVHgBkFOdiNr/+jIBYgtUuDMlE3zisaq9/PWvHsczM/Jccfx8immpRSqXHb4WXplZWo/FVjIyjatYn+JC0PuYOAiWN5eAHQe4vIuvy4DqaXCSxiWjzbXAsj8sAZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HncoimCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6DAC4CED1;
	Thu, 20 Feb 2025 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740052744;
	bh=u5NMKxhWnD/Z/8UewhmeT1rkRCBSaZTnMl4Wu8+zXuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HncoimCzjpPgiY69pow9cn2yJ35BmIAxe4A4s9l8THAR16vcGz0k2msc+2k13CaTB
	 O3dGPemm1LjE8XIXkmsybBKNsIo8NfIptc/5ILtiDVlnDJPnCA0VZEwzt4wFamMrh5
	 2wA3YY21LcFubIwv8X8c5VNygUjtAMkuBxdnLRBc=
Date: Thu, 20 Feb 2025 12:59:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
	dmitry.torokhov@gmail.com, jic23@kernel.org,
	przemyslaw.kitszel@intel.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 02/12] driver core: Split devres APIs to
 device/devres.h
Message-ID: <2025022052-profound-barmaid-dfe0@gregkh>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <20250212062513.2254767-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212062513.2254767-3-raag.jadav@intel.com>

On Wed, Feb 12, 2025 at 11:55:03AM +0530, Raag Jadav wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> device.h is a huge header which is hard to follow and easy to miss
> something. Improve that by splitting devres APIs to device/devres.h.
> 
> In particular this helps to speedup the build of the code that includes
> device.h solely for a devres APIs.
> 
> While at it, cast the error pointers to __iomem using IOMEM_ERR_PTR()
> and fix sparse warnings.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

