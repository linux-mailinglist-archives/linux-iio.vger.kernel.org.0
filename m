Return-Path: <linux-iio+bounces-13837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A479FDAE8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 15:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ED33A1377
	for <lists+linux-iio@lfdr.de>; Sat, 28 Dec 2024 14:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB118A922;
	Sat, 28 Dec 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9EJb8S7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B181791F4;
	Sat, 28 Dec 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735396156; cv=none; b=PXY+XIen5WrAos9hYzvWWxXLIxhwZFGNrDCvuWu7mscuqK+HCVEcBvl3cMCGBVZLESIw0O/WZEHMZYqOFW60qSb2m3M6lcsi9SIHYKHUaSPlKyGLiqhTZvREbXOcdyVkqjAr6ymFupY+W27L+7s6447G5aPLyzf+H5qwc+/fIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735396156; c=relaxed/simple;
	bh=/E60l4xvUnJa++FV5HS62z4aZ6Fm1PtAg5KEME4Z5LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRcJ4EhcedurKH/8hz8SDb1vJIMYYv38iV4qpYtDFK0Uc6Udi2kbfJiNChpkC5svG/6Y/g5KANYIh+5CbWeQaqxUwx/Yv2Mp+yNB43qwPUHLGLiEBJXwdFjxPRPrhOPE6cH/aUaznk9u15EJ05SuVN0zmvslhpQagB59UfmHJGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9EJb8S7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C0DC4CECD;
	Sat, 28 Dec 2024 14:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735396156;
	bh=/E60l4xvUnJa++FV5HS62z4aZ6Fm1PtAg5KEME4Z5LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b9EJb8S7hDp/R7/HaUAsfTkBaxmZEeOBoXDppFOuoh7rBNxkY/Ccqlq43IOnEvxJr
	 c5hCD02j3GLPNQ2vmaiKmi3Lt03dHBZSfquuAn2R1lDObGyLud/WgiFUviQi/rbQ7U
	 RwJSRrPtllHuJCjL/EXXVt8Klongl7kR4JAWFf5t6+kwqFYpn4gz3TQzNRllTr0F/7
	 1AhU6pp8ords2oN2tCWp8bKL3MKi8GbSKS6TLPgkpZMusIDy2evZvsr4rzcxyoKRa9
	 xplOjbBOBXR/33L0U5vVLXrnnYFwuVERW9Llg+GB+b810eonpAOCNGJRepy80EY7xx
	 ZT7rmSjQ3TACw==
Date: Sat, 28 Dec 2024 14:29:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v8 1/7] iio: accel: adxl345: add function to switch
 measuring mode
Message-ID: <20241228142907.20f94de8@jic23-huawei>
In-Reply-To: <20241225181338.69672-2-l.rubusch@gmail.com>
References: <20241225181338.69672-1-l.rubusch@gmail.com>
	<20241225181338.69672-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Dec 2024 18:13:32 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace the powerup / powerdown functions by a generic function to put
> the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> several features of the accelerometer, it is recommended to put
> measuring in STANDBY mode.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> Please squash with a3fb9f5202c3de0ca84848a475f59a0e0584d9fc
Even when just sending something you'd like squashed please give
meaningful title etc because it might not get squashed and so may need
to stand on it's own.

Anyhow, I have squashed it so no problem this time.

Jonathan

> 
> Just introduces a cosmetic simplification to the already applied
> commit, under the same title.
> 
>  drivers/iio/accel/adxl345_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index b48bc838c..27d70a1f0 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -153,9 +153,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>   */
>  static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
>  {
> -	unsigned int val = 0;
> +	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
>  
> -	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
>  	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
>  }
>  


