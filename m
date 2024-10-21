Return-Path: <linux-iio+bounces-10907-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE989A90CB
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 22:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013F9284E0A
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144D41FDF85;
	Mon, 21 Oct 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ath19mW8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9D192D66;
	Mon, 21 Oct 2024 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541677; cv=none; b=ObY2wF22bv2ay2HEQwXcX/j3mE25dOtLmmwt2E7t7Uuve8hNNuEit9P2LBjWDjEfRKapiRU6w//PlhLIYU57x+fQq3R00xyPMPKkoxW17VYS9BSten2zR1Ge3MRHYTBB7LqpH8xwL9dL4hGFnWN79F8gwFfykAuwRUlN4PpWFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541677; c=relaxed/simple;
	bh=j/BrK8B0TGkZ9ZwNciUqLWo+wzl27hLDJOIpsB2sOLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXm07kXzOnwbFiuMRkww/9o8glPKQgKpW4mEn+Ptn27IL1oKQnl8hKhn4ZVAro1pVlU/lPZyDuml0k8cjSDEzFS66QjMkmLFyInd1AjCLtj/YdBx2ts3+9ZD0rwnHDfoCiDPlExSnrNq+n+IptrFsxyda2RkvOuurtv9DeD7fDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ath19mW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CDDC4CEC3;
	Mon, 21 Oct 2024 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729541677;
	bh=j/BrK8B0TGkZ9ZwNciUqLWo+wzl27hLDJOIpsB2sOLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ath19mW8aXXkH6uv9k4DdfEi8j+WQftCAu0vTLib1HY+oSD1lAV+LSLabNrpzVg28
	 LYGpTBaQKuyBXg9mLs0UcTroswf/x1+FY9cDaInTuDxQLeLdYaDvJHz96yD9M9O0Rj
	 bdxTXBQ0Rc1v7NGivSBjjwK4DlG11n1vP4qVesj0=
Date: Mon, 21 Oct 2024 22:13:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stable@vger.kernel.org
Subject: Re: [PATCH v2 01/13] iio: chemical: bme680: Fix missing header
Message-ID: <2024102100-sulfide-paving-17fb@gregkh>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
 <20241021195316.58911-2-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021195316.58911-2-vassilisamir@gmail.com>

On Mon, Oct 21, 2024 at 09:53:04PM +0200, Vasileios Amoiridis wrote:
> Add the linux/regmap.h header since the struct regmap_config is used
> in this file.
> 
> Cc: <Stable@vger.kernel.org>
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/chemical/bme680.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
> index b2c547ac8d34..dc9ff477da34 100644
> --- a/drivers/iio/chemical/bme680.h
> +++ b/drivers/iio/chemical/bme680.h
> @@ -2,6 +2,8 @@
>  #ifndef BME680_H_
>  #define BME680_H_
>  
> +#include <linux/regmap.h>
> +
>  #define BME680_REG_CHIP_ID			0xD0
>  #define   BME680_CHIP_ID_VAL			0x61
>  #define BME680_REG_SOFT_RESET			0xE0

Why is this needed in a stable release?  Does it fix a bug?


