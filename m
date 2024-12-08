Return-Path: <linux-iio+bounces-13244-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0699E8731
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377B51884D5F
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03954189BB0;
	Sun,  8 Dec 2024 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP08T/PM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE64690;
	Sun,  8 Dec 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681210; cv=none; b=j/FKzfWGSV85qghQSY1y/CCM/agh4SRETmS1Y/Fr9dtro0ROkyIssMySy1lLu24NRQg2UOtOS3bXcmO3Zh/1r6VFnApQG/ULNjcMoFhLP5HiccAq0gC/GQbOV8lG9bd+rHrmWJVZ51PvBioeV/gyLUMca+PCk21T+jZZMKmJ9LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681210; c=relaxed/simple;
	bh=3gyWN0nYw0ZJ8J+Q0jBubhEOhcx0fnY2sf1SZDVpBoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQi1viYDmACLUW32U2tseadxo9b3OLbFGdJRLHnU2dQMzop4Y4RJRd/MPT6e8humBzZiIUhKQjsTlkj5qtTnBn6LsWfMRf+nC63SHtMQXmN5bTJmGpcR1EEkQfz9sBmrdNJI7pgcISoM0OjrUdfTIk0MRDjm2/++mO8KhuuAJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP08T/PM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16311C4CED2;
	Sun,  8 Dec 2024 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733681210;
	bh=3gyWN0nYw0ZJ8J+Q0jBubhEOhcx0fnY2sf1SZDVpBoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IP08T/PMxV4h4GyktWQEA5v7zBbEXJZK2R4AYSHPpKaevfqv4ZEVStcH8gqYsANur
	 +vB7Fm9ZfEvWsY6mstfDUsVvpPpFcamh3MiD+0YOU8vOMZ6n0lyzG0yyuIEYfim9AT
	 ivScYH1zq4f6+fUGauyPSamJp3US84dcVegCHo5bjR0X+B74l1kyUQfdAVkPlRBufl
	 Bky/CBr16ywQTvyotihVnNP3V27PPuPWiJqAJuN2jqatLJVI6P/BfS1TOS09mpp/6w
	 jsejoPpIRWcVzrFdDIZ2ziczzkBjwtO2avXUNLo0ZsYQ/xkHO4yAdPstkaOkfj6w0d
	 zIIAJJjQnk3jg==
Date: Sun, 8 Dec 2024 18:06:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, ajarizzo@gmail.com,
 ak@it-klinger.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: pressure: bmp280: Use sizeof() for
 denominator
Message-ID: <20241208180640.52f4c41d@jic23-huawei>
In-Reply-To: <20241202181907.21471-3-vassilisamir@gmail.com>
References: <20241202181907.21471-1-vassilisamir@gmail.com>
	<20241202181907.21471-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 19:19:06 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Instead of using magic number 2 as a denominator, make it intuitive by
> using sizeof().
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied this patch.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 2df1175b6b85..a3631bc0e188 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -470,8 +470,8 @@ struct bmp280_data {
>  		/* Sensor data buffer */
>  		u8 buf[BME280_BURST_READ_BYTES];
>  		/* Calibration data buffers */
> -		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> -		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> +		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / sizeof(__le16)];
> +		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / sizeof(__be16)];
>  		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
>  		u8 bmp380_cal_buf[BMP380_CALIB_REG_COUNT];
>  		/* Miscellaneous, endianness-aware data buffers */


