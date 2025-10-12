Return-Path: <linux-iio+bounces-24977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B5BD067F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56163B9EF2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283E22EC08E;
	Sun, 12 Oct 2025 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rs2PpTpO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738252EB5C6;
	Sun, 12 Oct 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284359; cv=none; b=IfA6/WbBDe36tNqzR17VJxblnwGyrtwazqZsEz0uFPsLm8p5mBprEgXw072QIPwsnwC1ayGZM03r/SBMyDfSxK1vxMF7O9P+GJJfeews/9uOWQVzQxE7tPS8vn+jh+OQJ7Qxf3LDwu5a/sq65Wnw8a2JQo2BkLuy3msGgxD3bSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284359; c=relaxed/simple;
	bh=0OjvtPzr4odnhuW2mbs1eFCcYsdyUH/T3ETnP6gn/3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1hQoglY2mj+bpE1p3jMHHHABC5CB/BeyPSCjvi0L7Y1tzwKzu/rzwJn6UyPYUk6rT1RfjLd1l1AK93w/R0nBaFhYkGweo9e8weHnvjm8n+OlEL3DNWTQ9esIBHpc21udXslpW8sXZY95ewlT4AEcgXMuqSFcyWhH09LZTsnKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rs2PpTpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE0BC4CEE7;
	Sun, 12 Oct 2025 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760284357;
	bh=0OjvtPzr4odnhuW2mbs1eFCcYsdyUH/T3ETnP6gn/3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rs2PpTpOhtqyHkZvUkPYNQm0n5YnSpXb9YyV57E5eYWC+Ehg4nhn41+bYQM0mMiZX
	 mbFK/9W5CAcRmQrT/OitaLpUhCll8xqOyXwyxTOSgmBlwe8tCOKsrA5reqqLwjdIiQ
	 cZhVR/p0lnNzcyU+/zjXdoNNXcdixjozBsJHQ6RhprI5/oiTNvlJ2xUdVbTv15jMqJ
	 jdGunTo9Ka6rVsG2qi25p/+HFzKc0mJi4Dju9d3wqMCmmZmhh7vn4yCkCnKMtaFE8I
	 pj/WHtoX28mRvmyDw1mWfDLoXzHFVS3SW5xow4RHhViwBn5IS+zIS0nfY0dUyOKNGW
	 ySDXbtIkH5/EA==
Date: Sun, 12 Oct 2025 16:52:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iio: accel: bma400: Reorganize and rename
 register and field macros
Message-ID: <20251012165228.4650cdac@jic23-huawei>
In-Reply-To: <20251007055511.108984-2-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
	<20251007055511.108984-2-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Oct 2025 11:25:01 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Reorganize register and field macros to improve consistency with the
> datasheet and naming style:
> 
> - Move field macros next to their corresponding register macros
> - Reorder register macros to follow address order from the datasheet
> - Rename field macros to include the register name in the macro name
> - Add a _REG suffix to register macros where missing
> 
> No functional changes are intended.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> ---
>  drivers/iio/accel/bma400.h      | 110 +++++++++--------
>  drivers/iio/accel/bma400_core.c | 212 ++++++++++++++++----------------
>  2 files changed, 163 insertions(+), 159 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index 932358b45f17..ae3411c090c9 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -16,31 +16,37 @@
>   * Read-Only Registers
>   */
>  
> +/* Chip ID of BMA 400 devices found in the chip ID register. */
> +#define BMA400_ID_REG_VAL           0x90
> +
>  /* Status and ID registers */
>  #define BMA400_CHIP_ID_REG          0x00
>  #define BMA400_ERR_REG              0x02
>  #define BMA400_STATUS_REG           0x03
>  
>  /* Acceleration registers */
> -#define BMA400_X_AXIS_LSB_REG       0x04
> -#define BMA400_X_AXIS_MSB_REG       0x05
> -#define BMA400_Y_AXIS_LSB_REG       0x06
> -#define BMA400_Y_AXIS_MSB_REG       0x07
> -#define BMA400_Z_AXIS_LSB_REG       0x08
> -#define BMA400_Z_AXIS_MSB_REG       0x09
> +#define BMA400_ACC_X_LSB_REG		0x04
> +#define BMA400_ACC_X_MSB_REG		0x05
> +#define BMA400_ACC_Y_LSB_REG		0x06
> +#define BMA400_ACC_Y_MSB_REG		0x07
> +#define BMA400_ACC_Z_LSB_REG		0x08
> +#define BMA400_ACC_Z_MSB_REG		0x09
>  
>  /* Sensor time registers */
> -#define BMA400_SENSOR_TIME0         0x0a
> -#define BMA400_SENSOR_TIME1         0x0b
> -#define BMA400_SENSOR_TIME2         0x0c
> +#define BMA400_SENSOR_TIME0_REG         0x0a
> +#define BMA400_SENSOR_TIME1_REG         0x0b
> +#define BMA400_SENSOR_TIME2_REG         0x0c
>  
>  /* Event and interrupt registers */
>  #define BMA400_EVENT_REG            0x0d
> +
>  #define BMA400_INT_STAT0_REG        0x0e
>  #define BMA400_INT_STAT1_REG        0x0f
>  #define BMA400_INT_STAT2_REG        0x10
> -#define BMA400_INT12_MAP_REG        0x23
> -#define BMA400_INT_ENG_OVRUN_MSK    BIT(4)
> +#define BMA400_ENG_OVRUN_INT_STAT_MASK		BIT(4)
> +#define BMA400_STEP_INT_STAT_MASK		GENMASK(9, 8)
> +#define BMA400_S_TAP_INT_STAT_MASK		BIT(10)
> +#define BMA400_D_TAP_INT_STAT_MASK		BIT(11)

Discussion on naming format and association with registers continues on v3
(busy week so I only just got back to reviewing!)

Also a bit on the weird 2 registers as one thing going on here.

>  
>  /* Temperature register */
>  #define BMA400_TEMP_DATA_REG        0x11
> @@ -55,70 +61,68 @@
>  #define BMA400_STEP_CNT1_REG        0x16
>  #define BMA400_STEP_CNT3_REG        0x17
>  #define BMA400_STEP_STAT_REG        0x18
> -#define BMA400_STEP_INT_MSK         BIT(0)
>  #define BMA400_STEP_RAW_LEN         0x03
> -#define BMA400_STEP_STAT_MASK       GENMASK(9, 8)

Other than those outstanding bits this looks fine (though I'll take one more close
read once we have those questions resolved).

Jonathan


