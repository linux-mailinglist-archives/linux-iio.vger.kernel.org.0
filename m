Return-Path: <linux-iio+bounces-356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD67F8C82
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D382F1C20B4B
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E412836C;
	Sat, 25 Nov 2023 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+65TYoK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698C1C01;
	Sat, 25 Nov 2023 16:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B31C433C7;
	Sat, 25 Nov 2023 16:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700930653;
	bh=x3bZImpG/T/VeEsQdG09Wf8mRYw2KVFi2C7qJH6OKWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+65TYoKqSuMmz8AsGRk/m6ZCRj2WTInxxXK4ztcZ+IhxSCXJQ9zatgP5WJ0EBvoO
	 dbArQ18IyA7pzwIBnswZYZpnAURGC5wbdSFHzzRyS81sfzlQCxB17X7jsGDDShNyaY
	 fEWSLwAi223pSz6E8eeBi/8Cx/PgxtE70Q2D7nw/IimUBC54183cL/c72ZQCuhHJnc
	 gpPDwFEL9JfClCTQ0OaegJaN0xdCUq6Ydd5fxIPtVxAZtYB+IikUppEZcnyvxu9eKt
	 myvnhUNtlHOcTzxxxhI/d4UPjJJm8IrotI13IbPywsjWZSvD7+4D2A7s1GlqF0HOjG
	 0NgkY3Lfkwq2Q==
Date: Sat, 25 Nov 2023 16:44:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
 <lars@metafoo.de>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: adc: ad7091r-base: Add debugfs reg access
Message-ID: <20231125164404.64072ffb@jic23-huawei>
In-Reply-To: <271203e245d324f94678d212e4daf13386bee463.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
	<271203e245d324f94678d212e4daf13386bee463.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 13:43:06 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add direct register access support for AD7091R-2/-4/-5/-8 ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

regmap provides it's own version of this, so I'm not sure I'd bother adding
the IIO one. See regmap-debugfs.c


> ---
>  drivers/iio/adc/ad7091r-base.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> index dbc60ea1bafc..4d5051316428 100644
> --- a/drivers/iio/adc/ad7091r-base.c
> +++ b/drivers/iio/adc/ad7091r-base.c
> @@ -177,8 +177,20 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
>  	return ret;
>  }
>  
> +static int ad7091r_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			      unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad7091r_state *st  = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->map, reg, readval);
> +
> +	return regmap_write(st->map, reg, writeval);
> +}
> +
>  static const struct iio_info ad7091r_info = {
>  	.read_raw = ad7091r_read_raw,
> +	.debugfs_reg_access = &ad7091r_reg_access,
>  };
>  
>  static irqreturn_t ad7091r_event_handler(int irq, void *private)


