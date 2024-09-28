Return-Path: <linux-iio+bounces-9851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF769890AC
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 19:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8BB1F21890
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87D5381A;
	Sat, 28 Sep 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWTMxGPB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DA143879;
	Sat, 28 Sep 2024 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727543550; cv=none; b=fu+Jj3QplyQFrTS3T7kZhGtTU+ECASxtc6e7vBwxcwvOrgWTFH/LqJeP6MkmRtZB5ulMvbFJGg9ecU0mMzhxPDupaoeMA0OVArCrpjMX+9BEpI1is/VeGFHN1fLMW8Z4NBiwj5j4bftrXth6DlpKNcEibATHDgtqPcwZmVrrqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727543550; c=relaxed/simple;
	bh=tR6vs67f1YyWbVZ32D8O+I9kGq8ZSlX1ftZEv+fmAik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTzCwzP43zmCb4BWM3Zt5Tp3hFvcfdqqZbztu+kUOvJy43grJr4psJm8SwDGSHM/Bw6+FgMhsYBvT2EbHeJI0fv/xTqoqZu/DdWog3zPCqllMkgKFNGFTXvlWQtMRkMQ0IgvSPhnn6yKcus0t7xBLkVpTdYiWiecm2kSV7oHpeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWTMxGPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D24C4CEC3;
	Sat, 28 Sep 2024 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727543550;
	bh=tR6vs67f1YyWbVZ32D8O+I9kGq8ZSlX1ftZEv+fmAik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AWTMxGPBXR2jyGjSqLeTNio/0N20bq3ppneMKv5HBgoHhCqH8kUTUItY56QY/QB8z
	 vq7NcHak3CG1ULlteS0CIUDFsoXDIDDnNmNcg4y9w+dvLNgDQf4f5GUqE3qoOFX9G7
	 FT+wj70fobhMCLJoixUDB4msv6hcyYZd+zFEWl3LZsUjo2SeM+nkIyxQ11VBCg2YtI
	 dw1EX3gWlO72VuTT46O8TeWR3PXIKg5EaTqtvPOhZBdMC7YC/8vldhK0PnmGRJNKta
	 EAfpJWRjBW+Wijz2s06y7begFxm2FyDAZNJKfqBJpcHc8Oki+LKcBboRNZ+tlfpJe8
	 qWIq3HyMkuP+w==
Date: Sat, 28 Sep 2024 18:12:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, marex@denx.de,
 conor+dt@kernel.org, kernel@collabora.com
Subject: Re: [PATCH] iio: light: ltrf216a: Document device name for
 compatible
Message-ID: <20240928181223.4023cdec@jic23-huawei>
In-Reply-To: <20240923131527.1408691-1-shreeya.patel@collabora.com>
References: <20240923131527.1408691-1-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Sep 2024 18:45:27 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Compatible 'ltr,ltrf216a' is used by Valve's Steamdeck device
> via the ACPI + PRP0001 mechanism.
> Document this info alongside the compatible.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Applied.
> ---
>  drivers/iio/light/ltrf216a.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index bc8444516689..b1dacb48d610 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -561,6 +561,7 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>  static const struct of_device_id ltrf216a_of_match[] = {
>  	{ .compatible = "liteon,ltr308", .data = &ltr308_chip_info },
>  	{ .compatible = "liteon,ltrf216a", .data = &ltrf216a_chip_info },
> +	/* For Valve's Steamdeck device, an ACPI platform using PRP0001 */
>  	{ .compatible = "ltr,ltrf216a", .data = &ltrf216a_chip_info },
>  	{}
>  };


