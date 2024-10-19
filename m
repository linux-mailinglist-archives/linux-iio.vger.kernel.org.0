Return-Path: <linux-iio+bounces-10760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3339A4BEB
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 09:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA401C20E6E
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB221D7E31;
	Sat, 19 Oct 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iw0QCUl2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8761EA73
	for <linux-iio@vger.kernel.org>; Sat, 19 Oct 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324630; cv=none; b=mi1b69RouTf4sGFlm86rLS2G5ga6u8vxZz5NBPkQTUgQm0B/WsUWABzkhnJNMV7r1zp2QncFPYu/SkOC3bG+CED5qA8qxY2S6jRkRaZkNUwDCclWM7bW5e3Kbo8dZYXx9vVum6ejFrufxraULIvZBuxcbWYApt0l3gVn6diJtxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324630; c=relaxed/simple;
	bh=RBIwiG+uIrw60AG22pm7SiddwoUGtcEoVYxpzMY+Rlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPE5+IXrnYwh/SykEATAP22RLZR4Ug12/jWEbWHhBNE6j6/0TkFrwlwPQDM8hOnxQI9OkAPkNslGR52UDsnV/tUsJfy2RUcGzx8/1PakM+Y41dMh2cpHpaqcnTLS47f4nffY33ahb4nET06fueJvCq8ubtJcAU71lzYeZyxDg6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iw0QCUl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C8FC4CEC5;
	Sat, 19 Oct 2024 07:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729324630;
	bh=RBIwiG+uIrw60AG22pm7SiddwoUGtcEoVYxpzMY+Rlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iw0QCUl2lwZC4qqGgGy9PfME23foGmB0K2ErA1dszSeL8+sYG/k1xFHMUCUPRL4ro
	 42yvUr/E0AGDxDo2hGfabrChRHzFFNPO5Fc878+IwINZM/peIf7A0Z3A/rQ3Wlrmdm
	 pv/XsEKV5XWz9epBdTx1YrnWDAVAIIz/Am+/ByjM=
Date: Sat, 19 Oct 2024 09:48:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL V2] IIO: New device support, features and cleanup for 6.13
Message-ID: <2024101900-slurp-hertz-d4e9@gregkh>
References: <20241018183020.224219d8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018183020.224219d8@jic23-huawei>

On Fri, Oct 18, 2024 at 06:30:20PM +0100, Jonathan Cameron wrote:
> The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:
> 
>   Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.13a-take2

Pulled and pushed out, thanks.

greg k-h

