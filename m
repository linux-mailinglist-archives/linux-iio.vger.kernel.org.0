Return-Path: <linux-iio+bounces-14156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6BFA0A84B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4A0161ACB
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936741990DB;
	Sun, 12 Jan 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmpeVEDm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDA3E499;
	Sun, 12 Jan 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678279; cv=none; b=mRktxxHgpwHemTlihluFX1wJqbEg/RN8vl63sZSDmIOCfbiO8ZYN4s0V2g+K9+N4sayV5/Mjdtrj6adrUeVBupNIfMrFw0U17D1LnIO4M7afmUOVZFaFPFyLJDA2wHDj+HrAeeIi49LyKoRneiBFYLaR/LLhkGRp5P03ZQorfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678279; c=relaxed/simple;
	bh=NIAyFugNKftO7T5jXBGLqAO6ViozFDictCRyETqKVTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCHjO5iNbADG5zeNhUAysYOWHI8fPyymwiPoHkttGkF7aGDUNNmqahaKjSfS+5EKhd2EgzsYIWzafgC09Pp5RKRe13SBqWgy5dxp6bGOKRzbsdSX6LJJVTAzK0k2ASyNhfHvIh0cGSp84IQmJv/3aL2D/vvikUMq8gw34wXWyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmpeVEDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C46C4CEDF;
	Sun, 12 Jan 2025 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736678278;
	bh=NIAyFugNKftO7T5jXBGLqAO6ViozFDictCRyETqKVTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DmpeVEDmDlj1dU1FMJsePMbYO7DlrQB4KF34jU/p5x9P7WLAe0o5ayDFfG6PxNJtg
	 ojY+yVpCB5/Nk4nW8f8L11Q4wBv7+6/RsHjxI7WpbpWsizuA6f8POS9U3YD/4a7Nnp
	 u8CymMIfhsuavfYPccsQjySqmTD29qqc2i3D+NrIitA8knXZxzQ4gPNGLdH9QLFil2
	 nbISc8cBUPNIoi5INTDUozQpPeJa/nzH6ldRwiwWG7jlHLHmofxW6DucSAvp982/5B
	 mzc0vlbtbczuPlhzmRnmy1yPqQgKSsjvwoNeBDH240xeHpErfw/5mOdAeDdenrqqhY
	 2cOCPoeks/v1Q==
Date: Sun, 12 Jan 2025 10:37:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Michael Walle
 <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Guillaume
 Ranquet <granquet@baylibre.com>
Subject: Re: [PATCH v3 1/2] iio: adc: ad7173: remove special handling for
 irq number
Message-ID: <20250112103750.55bc754e@jic23-huawei>
In-Reply-To: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-1-41e1c9cdd1a7@baylibre.com>
References: <20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-0-41e1c9cdd1a7@baylibre.com>
	<20250110-iio-adc-ad7313-fix-non-const-info-struct-v3-1-41e1c9cdd1a7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 11:40:06 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Remove the int irq_line field in struct ad_sigma_delta_info and all code
> that referenced it.
> 
> This struct is intended to be used as static const data. Currently, the
> only user that doesn't uses the static const struct directly, namely the
> ad7173 driver is making a copy of this struct to be able to modify the
> irq_line field. However, this field is written and never used due to the
> fact that ad_sd_init() which reads the field is called before
> ad7173_fw_parse_device_config() which writes it.
> 
> The runtime behavior does not change since ad_sd_init() was already
> (unintentionally) being called with irq_line = 0.  But, even though
> this could be considered a bug, the behavior was still correct. The SPI
> subsystem always uses the first interrupt in the interrupts array from
> the devicetree and the devicetree bindings for this family of chips
> specify that the RDY interrupt is always the first interrupt.

Binding does say that kind of, but it shouldn't - we should allow
for possibility of only the err being connected in the binding.
The driver can of course reject that.

  interrupts:
    minItems: 1
    items:
      - description: |
          Ready: multiplexed with SPI data out. While SPI CS is low,
          can be used to indicate the completion of a conversion.

      - description: |
          Error: The three error bits in the status register (ADC_ERROR, CRC_ERROR,
          and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin.
          Therefore, the ERROR pin indicates that an error has occurred.

  interrupt-names:
    minItems: 1
    items:
      - const: rdy
      - const: err

Is the current binding that should be relaxed.

Upshot, I'd specifically check rdy is the first one.
Easy way being to see if it matches spi->irq.

Jonathan



> Therefore,
> we don't actually need the special call to fwnode_irq_get_byname(), so
> it is removed in this patch instead of moving it to the correct place.
> 
> Tested-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v3 changes:
> * Removed spurious change that was causing compiler error.
> * Rebased on iio/testing and resolved some merge conflicts.
> 
> v2 changes:
> * Fixed chip name is subject line
> * Uwe's comment made me realize that the special case was actually never
> being used because of the ordering bug and could safely be removed
> rather than trying to preserve it.
> ---
>  drivers/iio/adc/ad7173.c               | 6 ------
>  drivers/iio/adc/ad_sigma_delta.c       | 5 +----
>  include/linux/iio/adc/ad_sigma_delta.h | 2 --
>  3 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 6c4ed10ae580d66287857252ce9a69cfaa45db0b..b92aca39d117a315d6b55951fba7c3b51787555a 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1515,12 +1515,6 @@ static int ad7173_fw_parse_device_config(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> -	ret = fwnode_irq_get_byname(dev_fwnode(dev), "rdy");
> -	if (ret < 0)
> -		return dev_err_probe(dev, ret, "Interrupt 'rdy' is required\n");
> -
> -	st->sigma_delta_info.irq_line = ret;
> -
>  	return ad7173_fw_parse_channel_config(indio_dev);
>  }
>  
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index d5d81581ab34099cef30ec63944ce1171c80ec14..38a72ced10326656b30fd39d7a72cefe8c4c1aa5 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -801,10 +801,7 @@ int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
>  
>  	spin_lock_init(&sigma_delta->irq_lock);
>  
> -	if (info->irq_line)
> -		sigma_delta->irq_line = info->irq_line;
> -	else
> -		sigma_delta->irq_line = spi->irq;
> +	sigma_delta->irq_line = spi->irq;
>  
>  	sigma_delta->rdy_gpiod = devm_gpiod_get_optional(&spi->dev, "rdy", GPIOD_IN);
>  	if (IS_ERR(sigma_delta->rdy_gpiod))
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 417073c52380f60a1a45a4924f4f556b64832295..521e3dc95db9117b7df12710eaae3f373d1df7bc 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -53,7 +53,6 @@ struct iio_dev;
>   *   be used.
>   * @irq_flags: flags for the interrupt used by the triggered buffer
>   * @num_slots: Number of sequencer slots
> - * @irq_line: IRQ for reading conversions. If 0, spi->irq will be used
>   * @num_resetclks: Number of SPI clk cycles with MOSI=1 to reset the chip.
>   */
>  struct ad_sigma_delta_info {
> @@ -70,7 +69,6 @@ struct ad_sigma_delta_info {
>  	unsigned int data_reg;
>  	unsigned long irq_flags;
>  	unsigned int num_slots;
> -	int irq_line;
>  	unsigned int num_resetclks;
>  };
>  
> 


