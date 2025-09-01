Return-Path: <linux-iio+bounces-23591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B074B3EC68
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89031A87A0D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54222EC097;
	Mon,  1 Sep 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzqleyRw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923262356CE;
	Mon,  1 Sep 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744812; cv=none; b=DP8BfLswRM+UWewDSp9bKd7MggDYLhfHfryQHiMZjWDXBINmxaMP3kczFy7z8dI1V+Tb/YbHLnPEiAcYdWMeoiiROBC51xdSW/sfEjHl+0CKiNWUpT+wKYj54BEc4zcS+du6u4UC5jRugtwnUJ1azzk8vrguYYRiRut1S2oFB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744812; c=relaxed/simple;
	bh=tDb88lFCA9cbKoJXMvuaDvWAEZD/O4+t/o9l90JG9lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFZUaSVRyXCGnm3nMelssy1IyKXWvMDMBtFuJR6oodv/0icpd/Rty10zLMw0qKJRf30wXxXIveARdLTbYRON8nD5cgHMztj+cwMjk5VDei33r1Xo4kbNPXK6sdzJf21PyYtdajEmKGcDtn/bZGiEsjy3fDJwixSyi0MosRYZPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzqleyRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD5FC4CEF0;
	Mon,  1 Sep 2025 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756744812;
	bh=tDb88lFCA9cbKoJXMvuaDvWAEZD/O4+t/o9l90JG9lQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AzqleyRwkS3wNp0SvAlt6HCrlQLpgiFr7gIiNBtDDk8QQOXWAlE7gwzQ44BphC959
	 sCvWWbqPuleCkuHiUZPdH1Sw33Gu8BkTa0SKYOcF0MqulJc1Z6DsD1sB1MI8QETYc8
	 52hRCeVrC8UMUoUh0re0QPEPPJyHC8pWdqStB8f2+fUdX+BS+i9d4EqjZ9PLvmPR2/
	 iZEZCRgRxTgYxOAtBBhhYX5BGY9oB89drdZUL7wAU7B9waXYR8ClIRZGF7uQ0XQPJH
	 SqWiaQ04KZ43W17ZbfGNEwAvGRZs8I6migogvognStf6oXre8Q9Qvs/gVVRRfAdayy
	 tDEsbFAo9mCMw==
Date: Mon, 1 Sep 2025 17:40:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-iio@vger.kernel.org (open
 list:IIO SUBSYSTEM AND DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 0/2] iio: use int type to store negative error codes
Message-ID: <20250901174006.11bf48a8@jic23-huawei>
In-Reply-To: <20250901135726.17601-1-rongqianfeng@vivo.com>
References: <20250901135726.17601-1-rongqianfeng@vivo.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 21:57:24 +0800
Qianfeng Rong <rongqianfeng@vivo.com> wrote:

> Use int instead of unsigned int for 'ret' variable in ad5360_update_ctrl()
> and ad5421_update_ctrl() to store negative error codes or zero returned by
> other functions.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
> v2: Split each driver into a separate patch.
Thanks for doing that.

Applied to the fixes-togreg branch of iio.git and marked for stable inclusion.

Thanks,

Jonathan

> ---
> Qianfeng Rong (2):
>   iio: dac: ad5360: use int type to store negative error codes
>   iio: dac: ad5421: use int type to store negative error codes
> 
>  drivers/iio/dac/ad5360.c | 2 +-
>  drivers/iio/dac/ad5421.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 


