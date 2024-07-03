Return-Path: <linux-iio+bounces-7253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2EB926234
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FEE1C22173
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F2717B429;
	Wed,  3 Jul 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0w6sWyWt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741017A92E
	for <linux-iio@vger.kernel.org>; Wed,  3 Jul 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014648; cv=none; b=htv5MxkAwlaCTQnc6UlCiFTrBXhVxJCNaSyPdHJkkL/TTtYPTJRUAkJM41lj+29iPMFBAcV4haLbaGYM6hxs5okox5H8W5MIAXtRXjRCoKHWMHNIgZJT8Zn8wNRiGBmNzGh3HU70sRFjjh7KybjGwAua7ycCYAVnKDmoet30mM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014648; c=relaxed/simple;
	bh=ExmB9yMIEdwrOUfLdjtq8EeEHXfgGhLE2+CDqv3scLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8uGdXdiSckLbQVeFFLoEqli+Je9FFOrb/rAmzVuPA2dt6Y/dE4nIlRNLfuCauqY3HrTzfQmJO6idOy8dF4L0EiGoGRwf9n3tNyfluAPuWkkwLGImpT+N5kLr82HWGzHdm1RKOtl9MDBImN9Xo+ALhxeUspsQyRRK0n/pwr65SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0w6sWyWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0F1C2BD10;
	Wed,  3 Jul 2024 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720014648;
	bh=ExmB9yMIEdwrOUfLdjtq8EeEHXfgGhLE2+CDqv3scLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0w6sWyWt60/UbG6Ahi/CHXVXdC95W7uzhoJUDk6EbRajtoJjTseN4/33i5sY+5Ue0
	 Ftbs2Mn97f5qxeHbPQL94wuIaWEq3s6/p/GpXDDTnXO8TxB6jqQSfE87g44wySs+y/
	 HPRCfS4wZ1WO7QPKbfc9Ip1yJPswIi925xSyZL70=
Date: Wed, 3 Jul 2024 15:50:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.11
Message-ID: <2024070313-gangway-stowing-2c52@gregkh>
References: <ZoPGzkmSA_sxY7-_@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoPGzkmSA_sxY7-_@ishi>

On Tue, Jul 02, 2024 at 06:22:22PM +0900, William Breathitt Gray wrote:
> The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:
> 
>   Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.11

Pulled and pushed out, thanks.

greg k-h

