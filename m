Return-Path: <linux-iio+bounces-1239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C9D81D414
	for <lists+linux-iio@lfdr.de>; Sat, 23 Dec 2023 13:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB09A1C20BBA
	for <lists+linux-iio@lfdr.de>; Sat, 23 Dec 2023 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D90D28B;
	Sat, 23 Dec 2023 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n0kTLyt8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABB0D2E3
	for <linux-iio@vger.kernel.org>; Sat, 23 Dec 2023 12:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B00FC433C7;
	Sat, 23 Dec 2023 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703335885;
	bh=/lbiPYiuTKtJ5/H2kM3aGjiS4oW243QjxEzQI53sA1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0kTLyt8Ir2Ub3LjJ/BLfbpLnXQzsO3llIoCqZ6PMx6rS7yMH5f2FHxMGS5c+C7QO
	 ovYhFVPcTkkdYXJ68v9m+BqsFz4vUh4evIbe/WKeT+r8fc5BOViLevcPILSCaOBhee
	 uqCxfN98rwnuTdECNpdp6NrOdKlaSXKwtj5voYnY=
Date: Sat, 23 Dec 2023 13:51:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <william.gray@linaro.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] First set of Counter updates for 6.8
Message-ID: <2023122307-cassette-headscarf-529f@gregkh>
References: <ZYWUDpW6nKfY5_Vs@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYWUDpW6nKfY5_Vs@ishi>

On Fri, Dec 22, 2023 at 08:50:06AM -0500, William Breathitt Gray wrote:
> The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:
> 
>   Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.8a

Pulled and pushed out, thanks.

greg k-h

