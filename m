Return-Path: <linux-iio+bounces-21487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF3EAFEDFF
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FFC1C40F54
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98F2E613F;
	Wed,  9 Jul 2025 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f98S8FjN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5B3398B;
	Wed,  9 Jul 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076060; cv=none; b=TG4+fBC9jc3h961VklHyacrh8zOIoKSVJqhQwozhPz+FLe3HFzcKmZgCuNRgFj+/wZnReAyr5TV3RiXrSstqeGnaMVxP8PrydrDQ9d3KBe7X1PpL4ej1eiScRK79SpCoAeayCMtimzizNm5jVnuPTNiK41iJ5Su3+vZXUcq+SwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076060; c=relaxed/simple;
	bh=GxQO+A5LaGNUuTWx4cQc84EILlf1a57gnRO1KKDBo2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlrKePCAQhuoAUKxlGlcG4tSrtAE8HasjvmOsWTA9Mba5rvCXIuG6Vmvvzw4sTJH1IKJLgxr/QySzEHSFoOS3pVTroZufZgJ5FKeAggcPtW18yZL0xmhz75NXEivw7RxIbsxxsJH4fOY+lWasiBibznVmUj8WumTe2AyTkEYGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f98S8FjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987EBC4CEEF;
	Wed,  9 Jul 2025 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076059;
	bh=GxQO+A5LaGNUuTWx4cQc84EILlf1a57gnRO1KKDBo2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f98S8FjN99dL0RYLKxsfMBvT4ZzYo1g4TrWtyKaAV3Tn1YCBNTuluVkbrhUgc6U/D
	 W7esn6yU/rpNPT+S9zGOYIGxLJgpE76UdHM1DxqHgGTp52YkFhubSlYpclLpnrU561
	 zx14ryx7iAc+TAGf1OCb/gdm78b9MMBaePjQqafTNkqcb/mktF0as7wTEPogqmWX2/
	 pZZvjM8NrRjf5vM5/H+9qUYbpoMnlMfClt5aHWlnUO+kAuCcL5VXnRm+71549vTWDE
	 npItw2vy+aLUj5I7EkO7jbi2bUST0soIuy7SGLyFSubcKyrGFdrm3ojaPus9gz25Vd
	 6B4y35bF8HZPQ==
Date: Wed, 9 Jul 2025 16:47:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Gerald Loacker
 <gerald.loacker@wolfvision.net>, =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?=
 <barnabas.czeman@mainlining.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, Danila Tikhonov <danila@jiaxyga.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Waqar Hameed
 <waqar.hameed@axis.com>, Peter Zijlstra <peterz@infradead.org>, David
 Laight <david.laight@aculab.com>, Jakob Hauser <jahau@rocketmail.com>, Al
 Viro <viro@zeniv.linux.org.uk>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/12] iio: magnetometer: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250709164728.2d01c89d@jic23-huawei>
In-Reply-To: <20250708231152.971801-1-sakari.ailus@linux.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
	<20250708231152.971801-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 02:11:52 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 761daead5ada..7c5fef79ad04 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -260,12 +260,10 @@ static int bmc150_magn_set_power_state(struct bmc150_magn_data *data, bool on)
>  #ifdef CONFIG_PM
This is here just to handle the annoying stub for put_autosuspend which returns
an error code...  To me not checking that is fine and would allow this
function to be squashed inline.

>  	int ret;
>  
> -	if (on) {
> +	if (on)
>  		ret = pm_runtime_resume_and_get(data->dev);
> -	} else {
> -		pm_runtime_mark_last_busy(data->dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(data->dev);
> -	}
>  
>  	if (ret < 0) {
>  		dev_err(data->dev,


