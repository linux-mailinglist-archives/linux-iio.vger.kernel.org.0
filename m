Return-Path: <linux-iio+bounces-7959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953EF93DEBA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 12:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A6D1F21F10
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F684502E;
	Sat, 27 Jul 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHI8Cjc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF540858;
	Sat, 27 Jul 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722076215; cv=none; b=NVJtDL6IrkK8idEZAmYU6t7ge6/yYwTvE++afVHyLw7+oJF1yigki/QyrA/juULTfMgx2IAchO+5nt96+/GBZTAvO37gKwwsVQzoEG1omE/52jkFXwAVl/PDKcw46ZLxV+XSlYBxZjcmNEO8GWVYJxd/REnWa8WUo9oi9SSLHiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722076215; c=relaxed/simple;
	bh=onB9vTuBBP1/5gC3PTtSxHqUY31NTgJfdz8azOziBzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVy1Avshv4/S/W2S0Njs0Evxgmj6LEnv/X6V+UoXZwsRWj9WzcZ7RGQmVuJtmztJBN5qoOBlgT4mPPucBSJk9ruucL7N2H9CXgpHg58D0sK+tyJBAKhzRXSHv6yIG8e/r/uGpRnku/ZbdswsCrhW/RSanjLHTkZxb3+mZI8JEwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHI8Cjc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466DFC32781;
	Sat, 27 Jul 2024 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722076214;
	bh=onB9vTuBBP1/5gC3PTtSxHqUY31NTgJfdz8azOziBzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHI8Cjc5ArE17AEtad1M/fTGqvpJDEyyl5oN6Sa2MI/IhHzYJH8NcKkMX01F46L20
	 TPtIG/UB0J4WCoYRfwUs1waNjNJZhIPxH92pX06+Ojp6uPDmTSiXEk7Rv8EZ2fYoTi
	 N+Kkg7KZxJd4HS2g0zVRXwM+GIZ0o7/XExudrxVQWwqftiszOB3sV8RvLrgBgiDq0/
	 lfbKiPdxJP+q0eUgzHEHZKFnrvcwMD0b4XAqlUOl07ke8MgSvmU4cBiMP3oUnSV8gP
	 YDoAWcbnlt1O763NN9LpLLdBDBPQSgAFOVJnE5k+zhEvDTDaC6EmghcAr5PiE+aJsh
	 Y/PFjFYsqYHSg==
Date: Sat, 27 Jul 2024 11:30:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: backend: spelling: continuous -> continuous
Message-ID: <20240727113007.5fcac093@jic23-huawei>
In-Reply-To: <20240726-iio-backend-spelling-continuous-v1-1-467c6e3f78ff@baylibre.com>
References: <20240726-iio-backend-spelling-continuous-v1-1-467c6e3f78ff@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 15:18:40 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This fixes the spelling in IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied
> ---
>  drivers/iio/dac/ad9739a.c     | 2 +-
>  drivers/iio/dac/adi-axi-dac.c | 2 +-
>  include/linux/iio/backend.h   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
> index 9b1570e788b6..799387f21b9f 100644
> --- a/drivers/iio/dac/ad9739a.c
> +++ b/drivers/iio/dac/ad9739a.c
> @@ -145,7 +145,7 @@ static int ad9739a_buffer_postdisable(struct iio_dev *indio_dev)
>  	struct ad9739a_state *st = iio_priv(indio_dev);
>  
>  	return iio_backend_data_source_set(st->back, 0,
> -					   IIO_BACKEND_INTERNAL_CONTINUOS_WAVE);
> +					   IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE);
>  }
>  
>  static bool ad9739a_reg_accessible(struct device *dev, unsigned int reg)
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index 6d56428e623d..e44463f48bf5 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -452,7 +452,7 @@ static int axi_dac_data_source_set(struct iio_backend *back, unsigned int chan,
>  	struct axi_dac_state *st = iio_backend_get_priv(back);
>  
>  	switch (data) {
> -	case IIO_BACKEND_INTERNAL_CONTINUOS_WAVE:
> +	case IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE:
>  		return regmap_update_bits(st->regmap,
>  					  AXI_DAC_REG_CHAN_CNTRL_7(chan),
>  					  AXI_DAC_DATA_SEL,
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 4e81931703ab..29c4cf0bd761 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -17,7 +17,7 @@ enum iio_backend_data_type {
>  };
>  
>  enum iio_backend_data_source {
> -	IIO_BACKEND_INTERNAL_CONTINUOS_WAVE,
> +	IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE,
>  	IIO_BACKEND_EXTERNAL,
>  	IIO_BACKEND_DATA_SOURCE_MAX
>  };
> 
> ---
> base-commit: 472438c7e0e2261c6737a8321f46ef176eef1c8f
> change-id: 20240726-iio-backend-spelling-continuous-d6801c838fd8


