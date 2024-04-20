Return-Path: <linux-iio+bounces-4398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5928ABC07
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4181C20848
	for <lists+linux-iio@lfdr.de>; Sat, 20 Apr 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B8320DCC;
	Sat, 20 Apr 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE4iz8Q7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BA1426E;
	Sat, 20 Apr 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713624139; cv=none; b=erUu5XwNa9rCAdPLg59NpLdw55Za3Z4GG+vX4tugRLpqK3XfvL38obtv6Q5PluYltsCmH3765KiSf7hlGjAJPN66DfNw1wwkUsQO03+jX79rvGkWgFk+QZDW5mo2zBuxrOmMIjbZmxMqYrlhgI4v2/8m42WH2GubSpe5bu39GTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713624139; c=relaxed/simple;
	bh=9ZmNBfADxB/3+rhuBVJ5fs5C5Xpl3V2OBWQAR5t6PwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5yiYPofoVc54fS6NjsE+1Stz1VGXi/IhUcqB3Vtu9ALGb/xUtGIInKz+r3NqpQbmF3K/co1VXyHmq1W31cuT7x09JZ0S4b9hHEoOx1pv1V41fyqpvxlWQNvg2QC6zD877WD7eOdB/6pQ0UNrrHrJxrHld9CyoTm0Puh7qNJbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE4iz8Q7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB3FC072AA;
	Sat, 20 Apr 2024 14:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713624138;
	bh=9ZmNBfADxB/3+rhuBVJ5fs5C5Xpl3V2OBWQAR5t6PwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OE4iz8Q7FfDKiZlEa39kvZ9+Lf9aA6DxFmpmIlk1K13m6rMqeeZGCuM3l9HhLWS1w
	 z/NA34KFEjCz2veHvq6rapSUaOX+lkmhE8uvhMCQot3CpIjZZ3DoxVHb0BINREM066
	 y9A3d5KChI9GctkOhjbv8Q3qkiopo7d8yo4eyO00YlESu2sX7df4h5njB4P2C8l8tJ
	 zlu5HF2ovV0a6VqWccb1PGeIjTw5cdLd4Ps/GJQJtRt+XsAHM3KyKcUYgcPUINsQl0
	 YqfDKJRtcM/4kbO5mQlwllde7M7FPl5U0w/lWcf9MCjAMjKRU0kyRKNvj8Yquidci8
	 AeQH17lvry1oA==
Date: Sat, 20 Apr 2024 15:42:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Paul
 Cercueil <paul@crapouillou.net>, Alexandru Ardelean
 <ardeleanalex@gmail.com>
Subject: Re: [PATCH v4 04/10] iio: buffer-dmaengine: Support specifying
 buffer direction
Message-ID: <20240420154205.2ee50324@jic23-huawei>
In-Reply-To: <20240419-iio-backend-axi-dac-v4-4-5ca45b4de294@analog.com>
References: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
	<20240419-iio-backend-axi-dac-v4-4-5ca45b4de294@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> @@ -268,20 +282,21 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
>   * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
>   * IIO device.
>   */
> -int devm_iio_dmaengine_buffer_setup(struct device *dev,
> -				    struct iio_dev *indio_dev,
> -				    const char *channel)
> +int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
> +					struct iio_dev *indio_dev,
> +					const char *channel,
> +					enum iio_buffer_direction dir)
Missing updates to the docs immediately above. I fixed that up.

>  {
>  	struct iio_buffer *buffer;
>  
> -	buffer = iio_dmaengine_buffer_setup(dev, indio_dev, channel);
> +	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, dir);
>  	if (IS_ERR(buffer))
>  		return PTR_ERR(buffer);
>  
>  	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
>  					buffer);
>  }
> -EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);


