Return-Path: <linux-iio+bounces-590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F578038A8
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C3CB20BC0
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D412C1B9;
	Mon,  4 Dec 2023 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDBKfr+3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42A2C1AA;
	Mon,  4 Dec 2023 15:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC14C433C7;
	Mon,  4 Dec 2023 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701703390;
	bh=v9HHvcP+5Qmgs8vOwwtctHKS8YafaG9blaZ4o+1KOkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDBKfr+3DhZ3aeR9N1JjGZsaFWKv9q1J/2v3sVT4Pm6kkyE7apm0zJGFeENTzDoUl
	 AGjP4IATo+ytQW9WW3M6zndzZr31v3rrsWjpmL2wzWWL9hSEGIgs8Zq1FSH0FKZY0X
	 mAdZTg0vRjvLLzCRoHCBrBAYRRWtNRyLMKjA5SbKxR4ZapV5Pqu4XOyQydB0MRNYPt
	 341gpuGi6c/is6XEo+RBDslYzXfGmX3FGsKPZSOV9aZ7uckOKB0LpHDiTVsR9V/6MW
	 9R392iaMgdn7bd/Eyl1zvuhhRlQyyqMMpXV6YRJu9oIpSirTXhuPHKR6hTGwNPBkR0
	 elNCR0o1y2cHQ==
Date: Mon, 4 Dec 2023 15:23:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Olivier MOYSAN
 <olivier.moysan@foss.st.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct
 ad9467_state
Message-ID: <20231204152301.6c212539@jic23-huawei>
In-Reply-To: <20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:20:19 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> are done which means we need to properly protect the whole operation so
> we are sure we will be in a sane state if two concurrent calls occur.
> 
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 04474dbfa631..91821dee03b7 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright 2012-2020 Analog Devices Inc.
>   */
> -
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
> @@ -122,6 +122,8 @@ struct ad9467_state {
>  	unsigned int			output_mode;
>  
>  	struct gpio_desc		*pwrdown_gpio;
> +	/* protect against concurrent accesses to the device */
Not very specific.  Concurrent access usually fine at granularity of
individual read/write as the bus locks protect it.  What state
is actually being protected?  A shared buffer or some state that we
need to ensure remains consistent between driver and device?

> +	struct mutex			lock;
>  };
>  
>  static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
> @@ -162,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
>  	int ret;
>  
>  	if (!readval) {
> +		guard(mutex)(&st->lock);
>  		ret = ad9467_spi_write(spi, reg, writeval);
>  		if (ret)
>  			return ret;
> @@ -310,6 +313,7 @@ static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
>  		if (scale_val[0] != val || scale_val[1] != val2)
>  			continue;
>  
> +		guard(mutex)(&st->lock);
>  		ret = ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
>  				       info->scale_table[i][1]);
>  		if (ret < 0)
> 


