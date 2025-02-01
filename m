Return-Path: <linux-iio+bounces-14822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF9A249D0
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5841651FA
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE491C2324;
	Sat,  1 Feb 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omdrj+hi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BA19004A;
	Sat,  1 Feb 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738423646; cv=none; b=jN5vXH2GyE9ZwayYrKgP5cw/xobkBqOvcdEEoPNrnGiMH6BPcvJOwCRKhIn+Ej+mnHwRt/9/qB2k7O9nTorB0a3f57SG/AZMrhg1dmgT62+zEryUzPpJL8lHqKr7E8GFzLGzDOKhGGiKH3KTqZQDy1C5oHuZcxVMlfrDLoOX3T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738423646; c=relaxed/simple;
	bh=mAYmnKj8g/RiOgH0ptBAlOdmMm+uAmURkuHCE5d0P7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knh2uTJYj2SVVbbMxlSrTZi+JPi6H3YO7KxlYBO7Lw23Rqmdd6B2sNBDfKGbA8VnTirS791/NKH1/gIKCrnUHnBCISlCF2KzAHZQFO1SKHFbLFCv0mIcsVXa0r1ukqNraoUgVyt1y85L6C9ACa8gqyQPOOBrUGJRZ9a00/KmUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omdrj+hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7DAC4CED3;
	Sat,  1 Feb 2025 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738423646;
	bh=mAYmnKj8g/RiOgH0ptBAlOdmMm+uAmURkuHCE5d0P7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omdrj+hiFVzpMS5suOTo9tyhXANVHq2kmjVOCuM44Ogi5SwQ9XyK6n3sG5zZWnLZh
	 eabFc8hJIpE+l3dpUxl6QSBJWbgimy6oz93g+Z2ZX/6qfiq/+mfa0nAP7dJWxsIbLg
	 i2X3p5zEBtYNCujE/hqPcbnoEgVK1Y2Yq/edQodFX1x1n+RvUsrG8krYY5giyf2u0S
	 burUw526tU0DnrKkOQ2u2G9eFHHMxWqITDCl98co4/N7tkIf4GRBMBQ6zzhZh7cdd2
	 PhKxWMzCH1Tor3fZKnLJnWoRbabPvRCvQCbhEar1khCn57TWy750mB0Y66N+E+Us6r
	 mIFDxH/QrDJeQ==
Date: Sat, 1 Feb 2025 15:27:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 01/16] iio: adc: ad7768-1: Fix conversion result sign
Message-ID: <20250201152720.137bb3ee@jic23-huawei>
In-Reply-To: <64e32c0ac7357ca7ddea813ba932bf957cbbeca2.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	<64e32c0ac7357ca7ddea813ba932bf957cbbeca2.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 12:11:01 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> The ad7768-1 ADC output code is two's complement, meaning that the voltage
> conversion result is a signed value.. Since the value is a 24 bit one,
> stored in a 32 bit variable, the sign should be extended in order to get
> the correct representation.
> 
> Also the channel description has been updated to signed representation,
> to match the ADC specifications.
> 
> Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
> v2 Changes:
> * Patch moved to the start of the patch series.
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7768-1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 113703fb7245..c3cf04311c40 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  		.channel = 0,
>  		.scan_index = 0,
>  		.scan_type = {
> -			.sign = 'u',
> +			.sign = 's',
>  			.realbits = 24,
>  			.storagebits = 32,
>  			.shift = 8,
> @@ -371,7 +371,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = ad7768_scan_direct(indio_dev);
>  		if (ret >= 0)
> -			*val = ret;
> +			*val = sign_extend32(ret, chan->scan_type.realbits - 1);
>  
>  		iio_device_release_direct_mode(indio_dev);
>  		if (ret < 0)


