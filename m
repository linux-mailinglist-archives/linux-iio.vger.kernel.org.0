Return-Path: <linux-iio+bounces-12702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D729D9D83
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 19:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05BA160572
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999161DDC35;
	Tue, 26 Nov 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="run2MfeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38F7E782;
	Tue, 26 Nov 2024 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646488; cv=none; b=BkwIN4KQTB/shcghzNIjaBxqgE0jXgP9iMn7yALPifPcF/YP5h8BuJtA9N5U5yt4iM6+Y75JSloxPeOTCj3r66KLXUoRY/H+S+P/27/q1KrlEqL/KXvscvkzu+c2+0oIyrjm4wBquwk8KZMdRXeLPF9M+czvu/clsarX3nabGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646488; c=relaxed/simple;
	bh=WxKYbcUBEtuDMOOengvcQ/a+pXMS/JzKIDg5qGfXrLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBllXzBtV3sX5Slj+dJVy0OgWj9bWYTOdmT0vBeHQisCJaKfNm+9QuNPusQbcVCC/2vqfIDAFpWzNi35CUGFzzWwT/XEJThDo9cjYD4XwN1fYqvHoc5Dmeih9BgyQ+FUPVA8Pqo+SzkHc98WZovlEoWAaViHV/6M9Ub1XY1xnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=run2MfeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5666C4CECF;
	Tue, 26 Nov 2024 18:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732646487;
	bh=WxKYbcUBEtuDMOOengvcQ/a+pXMS/JzKIDg5qGfXrLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=run2MfeVfqKxRN9z1qyrHar96wEwHFz18l5GvRTxzILSUps+zIZNZ+Tm7FQ1619rn
	 WXKo0buVDRpPt2j5ApS3GbxVzfnEHCHMJEBvM0Fvj0ZidAXxsXkIrrvBDImSquVyW1
	 eWJ+++SI23TJlQp/Ar9IsvfCXy1RtfwAxmLU/hRfiUvNX/T2bRfU+TmHl/aXgRHfZJ
	 GvTrZB3va4iIPYRMtn4lTbgvIV5KX1lHyCmnM5bFPnCmUEcn1FAJ42RTLKR29RSTJN
	 L8nccRo1za3Qk4UmOiJ814pl6Lg/PYzgMYxL+6WZgulyLSOxHrFqDxqyWINmGdEiBZ
	 a6Kf2HO2tVtrQ==
Date: Tue, 26 Nov 2024 18:41:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com,
 aardelean@baylibre.com, adureghello@baylibre.com
Subject: Re: [PATCH 5/9] iio: adc: adi-axi-adc: Add platform children
 support
Message-ID: <20241126184117.41030153@jic23-huawei>
In-Reply-To: <20241121-ad7606_add_iio_backend_software_mode-v1-5-8a693a5e3fa9@baylibre.com>
References: <20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com>
	<20241121-ad7606_add_iio_backend_software_mode-v1-5-8a693a5e3fa9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

>  
> -/* Match table for of_platform binding */

No longer true? 

>  static const struct of_device_id adi_axi_adc_of_match[] = {
> -	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
> -	{ /* end of list */ }
Leave this terminator as it was.  

It's not important to have, but no need to add churn here given the comment does no harm.

> +	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
> +	{  }
>  };
>  MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
>  
> 


