Return-Path: <linux-iio+bounces-20656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D048AD9D31
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61143AE464
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9872EB5BD;
	Sat, 14 Jun 2025 13:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFhaWhV9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCA2EB5B2;
	Sat, 14 Jun 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908962; cv=none; b=BKp8yIIz4ft0DUC+lQp8J+p+xKfB4TsmUH/4Oty+f2isd5cIwP77x9SKvpQEb3GqaErpEV9zMMykuX3o8FsBgAHpvMahjSBs7wmgzikTzyxEOTEWE2Vc3IK/H+1V4fd1tdpQBj1GrQ4QsXJUAN0zwLOQnmrstEptzdb73E7i1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908962; c=relaxed/simple;
	bh=QPfekBE75xC294i/RyW5l4TYmW18asrVIMdkFSI9oJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpeYkFlAUDjtOmgUhvQqPZB/DGaCX6znT2AREo9fnWKmT0i0Uo9znHwCW1Yni8KQBGhePeU2IcUmM6Gx6Mc2cuvSdhJjfEbP8qJoltTZDE1VZZuWspZ9XX5wUIfvUzXWvDM/LNiHd91bOVu/n8+ft+MXopZEuVUiWJtBXofMgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFhaWhV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF1BC4CEEE;
	Sat, 14 Jun 2025 13:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908961;
	bh=QPfekBE75xC294i/RyW5l4TYmW18asrVIMdkFSI9oJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sFhaWhV9GkGFA2BZZmFYkg+EzlmvYVG/t+gLHPyZk0fIjxumxIz75jtqSsCsmUOFG
	 1LfAF8MES1X4iqYhyvlgYlRXk9LwZPOa4iTclgnSmsgMr0Cn4pygKPs+yoxBUMI7L7
	 HCj3ALf/P6nDL3g6A6cA93ycGnly0WFUcs6SHtfpe8gBQ2PiIMz+WLwO2c7Ces5bsg
	 DUMjGUocC0pHdCCnLtMZ+MTFY6IEvL7NNlEly9GSYmjeOV0IKqPI8xavWloWUVgVJR
	 DBCT92WXUSiY6EVthtS6G83qvRRFT/7IWz66fq6NM3eHBIdHNXCmTJZeeAGjmLBYP4
	 hA8u/rtpoPegQ==
Date: Sat, 14 Jun 2025 14:49:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v9 06/11] iio: accel: adxl345: replace magic numbers by
 unit expressions
Message-ID: <20250614144914.3ad824ef@jic23-huawei>
In-Reply-To: <20250610215933.84795-7-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
	<20250610215933.84795-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 21:59:28 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace absolute numbers by their expressions from units.h to avoid
> using magic numbers. Use uniform expressions to clarify their usage.
> 
> This is a refactoring change and should not impact functionality.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Nice. Applied with a little fuzz due to the earlier patches that I haven't
picked up yet.

Thanks,

J
> ---
>  drivers/iio/accel/adxl345_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index dcfbfe4cac0f..2c4f045c741c 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -706,15 +706,15 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
>  			return IIO_VAL_FRACTIONAL;
>  		case IIO_EV_INFO_TIMEOUT:
>  			*val = st->tap_duration_us;
> -			*val2 = 1000000;
> +			*val2 = MICRO;
>  			return IIO_VAL_FRACTIONAL;
>  		case IIO_EV_INFO_RESET_TIMEOUT:
>  			*val = st->tap_window_us;
> -			*val2 = 1000000;
> +			*val2 = MICRO;
>  			return IIO_VAL_FRACTIONAL;
>  		case IIO_EV_INFO_TAP2_MIN_DELAY:
>  			*val = st->tap_latent_us;
> -			*val2 = 1000000;
> +			*val2 = MICRO;
>  			return IIO_VAL_FRACTIONAL;
>  		default:
>  			return -EINVAL;


