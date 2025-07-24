Return-Path: <linux-iio+bounces-21959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3865EB10931
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817E918956BF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4FB27281A;
	Thu, 24 Jul 2025 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQCkfeLt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31DE2727FB;
	Thu, 24 Jul 2025 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356553; cv=none; b=ZDOCVB9QO8xGgvin0/DPgSHRJDfBswmPTA9y70WKTFZ4vDTUjCrsgUsErEubP+ezQKlK1KxSEzdkn16wPSvHtMhVpOq1XF0WjwSU9GDkQo6gwCemGdSrV431QOXXKX6uxCF2fdMCfQTv0cyonhxepHzaKeWdDqF+RpIcEOswe/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356553; c=relaxed/simple;
	bh=vfRWEHwE1WupHh9d1wNg7F2X3YqFuo1TCz1gE5FR/iY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOEBMO/NB+zf0WKgsefO5/9KtKLuVO7dU3Vi1e8lq4PwWKlMdeOkDO0JArZ/WJCiG2DObisQYMPcF/37Ez1g7gY3yOReu4MhpREzM5D27Ll415IMcyqIV+tn506c106bAnuahlGqMKLKM/GnHGyed6Xr1k1EDwvuvd1dnnV4Iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQCkfeLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12B9C4CEEF;
	Thu, 24 Jul 2025 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753356553;
	bh=vfRWEHwE1WupHh9d1wNg7F2X3YqFuo1TCz1gE5FR/iY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oQCkfeLtEcCkCiFH87k5apZyG4QV6RQbKrhzKi846orAGUavlQrdmcgcUYArGezmW
	 z3red/XQSHH/gJZ6yMg5MI7uRPllZNbZeUQx1dZXTBzmlvbHR1DpkIYLBrSlo2cEKI
	 2YnifCA14Cz30bXCjrMwrUWpRdLnAjoVPICDiwnkJD7HXdXgKXfTvyl8cPGdtsY06U
	 gxG3cE3yt0nZtnULbTqUxqrHfR65H9fwTI7A3pMHjrhQF8KNkLhxQOrZMdPTl1heg4
	 Pn0fbJOKpziP/YY2JeyZopsLoPvWd3xas6uJ7BLFEasWA5u7K7X++/oazXEjQNJwD4
	 YHxR/bL7ZH8hw==
Date: Thu, 24 Jul 2025 12:29:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: magnetometer: Fix spelling mistake
 "Magenetometer" -> "Magnetometer"
Message-ID: <20250724122906.6baceef8@jic23-huawei>
In-Reply-To: <20250724104743.139892-1-colin.i.king@gmail.com>
References: <20250724104743.139892-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 11:47:43 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a spelling mistake in the HID_SENSOR_MAGNETOMETER_3D Kconfig,
> fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Applied. Tah
> ---
>  drivers/iio/magnetometer/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 3debf1320ad1..c7809e5aa3a4 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -123,7 +123,7 @@ config HID_SENSOR_MAGNETOMETER_3D
>  	select IIO_BUFFER
>  	select HID_SENSOR_IIO_COMMON
>  	select HID_SENSOR_IIO_TRIGGER
> -	tristate "HID Magenetometer 3D"
> +	tristate "HID Magnetometer 3D"
>  	help
>  	  Say yes here to build support for the HID SENSOR
>  	  Magnetometer 3D.


