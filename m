Return-Path: <linux-iio+bounces-11320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0DF9B176A
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825FC283C06
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0491D358C;
	Sat, 26 Oct 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf0mbx3T"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AC18B499;
	Sat, 26 Oct 2024 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729942009; cv=none; b=J64Y7n2IFiUXixGXJOtCpgMw//KNnSWly4eLx/d1BgyJggAAWO8FZkPavxtqyQhRksLFeafODIQU9wquwDl1HUvGfWbIvv/wZSBcS7nagoHrVtzhs+ncXx5nia3ZBRPqiQiynv21RR+hb/LqgSItY3g+eVjd7QFC0b0+QJzsS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729942009; c=relaxed/simple;
	bh=zbReDhtnehaRXwseCGPSjK4gHvxDqoLs6mFeCPE29VI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkVcy6+DhLjTZ/jqf6hDCSZmRAzPiqzQI6VIK/Ui7LI7jbOoJ6XIOAjhpquFqOgvvUe4X117z69QzSm0YEwZVuzUDFQfj9kWJ5mbLaONa7iFb4UF3NfVob4B3SHxwv0zFUHZbD8KyY/xsjX2STuzcofmKKd/+xpvtV9Fl06tHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf0mbx3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A221FC4CEC6;
	Sat, 26 Oct 2024 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729942008;
	bh=zbReDhtnehaRXwseCGPSjK4gHvxDqoLs6mFeCPE29VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rf0mbx3TdGh+ZQzzanpbwd0Se91Xnse43+BM/KvXsntetot2pjb7eMSPhm6Dym/0p
	 PfoTZHbDRv+ykX7+h18WPwq2CTP6Jf7E1RBTxdF/AjzkZArIyYbEU0bqUk23f2m2yt
	 Ar1OeMISmdBd81ATQOWC7d0Xykeqp0OtZJ5w6IrlfgyoLOBWUNEm6scFezmxbJBxbr
	 KAJpxthCkRBlElVV0VTs7/pyOIB8DIGANQovr6qNiCtPhrLMcgxsjjcg8i7f3xaBHs
	 v7UfZ4tx/dwe0lfeptcxsNCfED/uk3wM68uGUcoDw688fjcMG+RHxEOiyMsk+AcREF
	 JoVFxwPNn+IXw==
Date: Sat, 26 Oct 2024 12:26:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 11/24] iio: accel: kxcjk-1013: Start using chip_info
 variables instead of enum
Message-ID: <20241026122605.0ea7188c@jic23-huawei>
In-Reply-To: <20241024191200.229894-12-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-12-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:00 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of having a enum and keeping IDs as driver data pointers,
> just have a chip_info struct per supported device.
I'm not keen longer term on acpi_type, as the various bits dependent on that
should probably be done via optional callbacks in the kx_chipset_info
structure, but this is a sensible intermediate step.

I see the chipset one goes away later hence no comment on that.

I did a bit of white space massaging whilst applying this.
Hopefully that won't make me mess up applying the following patches.

>  enum kxcjk1013_mode {
> @@ -425,27 +472,28 @@ static int kiox010a_dsm(struct device *dev, int fn_index)
>  }
>  
>  static const struct acpi_device_id kx_acpi_match[] = {
> -	{"KXCJ1013", KXCJK1013},
> -	{"KXCJ1008", KXCJ91008},
> -	{"KXCJ9000", KXCJ91008},
> -	{"KIOX0008", KXCJ91008},
> -	{"KIOX0009", KXTJ21009},
> -	{"KIOX000A", KXCJ91008},
> -	{"KIOX010A", KXCJ91008}, /* KXCJ91008 in the display of a yoga 2-in-1 */
> -	{"KIOX020A", KXCJ91008}, /* KXCJ91008 in the base of a yoga 2-in-1 */
> -	{"KXTJ1009", KXTJ21009},
> -	{"KXJ2109",  KXTJ21009},
> -	{"SMO8500",  KXCJ91008},
> +	{"KIOX0008", (kernel_ulong_t)&kxcj91008_info },
> +	{"KIOX0009", (kernel_ulong_t)&kxtj21009_info },
> +	{"KIOX000A", (kernel_ulong_t)&kxcj91008_info },
> +	/* KXCJ91008 in the display of a yoga 2-in-1 */
> +	{"KIOX010A", (kernel_ulong_t)&kxcj91008_kiox010a_info },
> +	/* KXCJ91008 in the base of a yoga 2-in-1 */
> +	{"KIOX020A", (kernel_ulong_t)&kxcj91008_kiox020a_info },
> +	{"KXCJ1008", (kernel_ulong_t)&kxcj91008_info },
> +	{"KXCJ1013", (kernel_ulong_t)&kxcjk1013_info },
> +	{"KXCJ9000", (kernel_ulong_t)&kxcj91008_info },
> +	{"KXJ2109",  (kernel_ulong_t)&kxtj21009_info },
> +	{"KXTJ1009", (kernel_ulong_t)&kxtj21009_info },
> +	{"SMO8500",  (kernel_ulong_t)&kxcj91008_smo8500_info },
I'll tweak the spacing on this as well whilst here.
You did one end effectively, might as well do the other.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, kx_acpi_match);

> @@ -1711,22 +1739,21 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
>  };
>  
>  static const struct i2c_device_id kxcjk1013_id[] = {
> -	{"kxcjk1013", KXCJK1013},
> -	{"kxcj91008", KXCJ91008},
> -	{"kxtj21009", KXTJ21009},
> -	{"kxtf9",     KXTF9},
> -	{"kx023-1025", KX0231025},
> +	{"kxcjk1013",  (kernel_ulong_t)&kxcjk1013_info },
> +	{"kxcj91008",  (kernel_ulong_t)&kxcj91008_info },
> +	{"kxtj21009",  (kernel_ulong_t)&kxtj21009_info },
> +	{"kxtf9", (kernel_ulong_t)&kxtf9_info },
> +	{"kx023-1025", (kernel_ulong_t)&kx0231025_info },
>  	{}
I'm going to tweak the spacing of that whilst we are touching it.





