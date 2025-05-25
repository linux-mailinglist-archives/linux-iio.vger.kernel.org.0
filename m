Return-Path: <linux-iio+bounces-19882-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D390AC34BE
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF673B2C92
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40313596A;
	Sun, 25 May 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVUb7y/n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9511CA0;
	Sun, 25 May 2025 13:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748178240; cv=none; b=kkXFFR9V3V5+h0MoewwTEFEQ6Z6MINWLguHXyjEVgblC8AUG+v/R0zPIY5TlwMr6IemmQkQPXqJ1Eq226trMjIrhrRPonF8K7K8SiiMC033VoVnFFg/UiRuc+Q014Aw5m5B3nxcNi1r8bdQ/GGEgitKHdzd11uVk3Dj26AYz7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748178240; c=relaxed/simple;
	bh=ULQHBTgmZGkCzCRerqe1zJrgSlQC/Ovwjkz9nHEjq94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ak18QjZ3rcK2wIXl7vvuSa1ej/RNvTFPJCbzDve2tl6PoAbkHxXA1+cK3SgEThyAkCumofVNK4tMK9J5sPz3db1SZHCA4jq1rAjPUTE9QX/uJHoAU6XNlMKD3b3m0xaBc3psl3eBKNCXB4oj7WCuxluM2CE2hhoiIC2sKRiO5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVUb7y/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11674C4CEEA;
	Sun, 25 May 2025 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748178240;
	bh=ULQHBTgmZGkCzCRerqe1zJrgSlQC/Ovwjkz9nHEjq94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OVUb7y/nCh/WwRacDb4w7fN++wGii+DmOUfZN1ZQ3Rex/OQ1U4FjKoLUwiSKzGnOS
	 XzlDwk1vJPzx6Et9YCoqU4QQ3JwV1b2S+vgPg5nBm0dy2Q4ui4OKvyYpat8azkufUB
	 WyphrRoEn9nXd9hFrjUMjYbPhT8R7FrvhL5RnW/3JAb7tW8YtrbS5L1PUBSeBFvWka
	 e2X0f3bnJYVhEM1Opdm8aBkkgfTWP5iztVDCYhnnx8lQKORC4N+uMXgTekeIwajNeG
	 s3z1N+aWdI5DFN5x31y1bjNiIOMTaIn4qUFP/glVJKQwEIyMc0XBHYe/jZaIYxveFQ
	 Pl4xL2U9faAAg==
Date: Sun, 25 May 2025 14:03:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/12] iio: accel: adxl313: add activity sensing
Message-ID: <20250525140351.559be514@jic23-huawei>
In-Reply-To: <20250523223523.35218-10-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:20 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add possibilities to set a threshold for activity sensing. Extend the
> interrupt handler to process activity interrupts. Provide functions to set
> the activity threshold and to enable/disable activity sensing. Further add
> a fake channel for having x, y and z axis anded on the iio channel.
> 
> This is a preparatory patch. Some of the definitions and functions are
> supposed to be extended for inactivity later on.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
One comment I found confusing.

I see this hardware is similar to our friend the axl345 so some of the outcomes
of final reviews on that series may apply here as well.

> ---
>  drivers/iio/accel/adxl313_core.c | 229 ++++++++++++++++++++++++++++++-
>  1 file changed, 227 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 80991cd9bd79..74bb7cfe8a55 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c

>  static const unsigned long adxl313_scan_masks[] = {
> @@ -300,6 +334,60 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> +				   enum adxl313_activity_type type)
> +{
> +	unsigned int axis_ctrl;
> +	unsigned int regval;
> +	int axis_en, int_en, ret;
> +
> +	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	/* Check if axis for activity are enabled */

If all 3 axis perhaps?  Or If any axis?  I'm not sure what intent is here.


> +	if (type != ADXL313_ACTIVITY)
> +		return 0;
> +
> +	axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
> +
> +	/* The axis are enabled, now check if specific interrupt is enabled */
> +	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	int_en = adxl313_act_int_reg[type] & regval;
> +
> +	return axis_en && int_en;
> +}


