Return-Path: <linux-iio+bounces-19060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35EAA8867
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B967F189556F
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CD61DDA00;
	Sun,  4 May 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="souD9f6l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B1A32;
	Sun,  4 May 2025 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379198; cv=none; b=gX/2137HVSvtgymQlm6LUcaLvp9K0gP/1jCjt5pRurWB175PurmNRccxLsEvQZ2RVstwrujs3A3B0URn3lZQAHKTqZ3L/W26k05GwjeaOgXcv9XFqZWtEfGvW5O7dYVjVEAu/EALBhLISuBLxNlmYefk2L9+32X4Yk6ZwkyGVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379198; c=relaxed/simple;
	bh=mKnCL3nkz9cAe/1hO2OMMOkEX7QBuY79blrz+JeIxDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vo+ajhxKvqYHwRs/QcnxpeG9+Z1f1LiKAtjSL7qmp650vWnoGR5hsIePGLXAHxmxXOJV4TPD6tZXkxWp27dfyPa44pujnaF+7fkLUvnrZ7z+uZZKYVfdkU0W05ao6KOW1cTM+y4IyXgOmjoBJpCtPn6pKIWL5ena/MdVWA1m7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=souD9f6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAD8C4CEE7;
	Sun,  4 May 2025 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746379196;
	bh=mKnCL3nkz9cAe/1hO2OMMOkEX7QBuY79blrz+JeIxDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=souD9f6lM63BfiHjGDLPXIvli20Vk0PCV8MDmApa4OsTEoJUUZI2LBa8m45CIGmZW
	 /+IUAYwS9hcWCpa8yJjdm/yaUfQDhRgLSIzfeiBbEcYTLfsW/Znwae+BUz6MCLzrRi
	 BcBUDPLazHW4IlY1ax0fOa98vl3FvNEvhvpbTa3cSfWCEBLMnVkWfbcMJTCiADphlV
	 jS+Oy2rS8BEgrOeFKjgjAtbxAYb3ysOmnp9uLsDUwg0MmcWaFQofKuTbA1gxJ2ie/U
	 feAHs94CYKR55RV2lxJA6YZuE+EcJ7ClJvkK7ZNpty23fis2Wqx/tzDFcmMkkEYPl7
	 MUPKnSym1veew==
Date: Sun, 4 May 2025 18:19:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/7] iio: adc: ad4695: use u16 for buffer elements
Message-ID: <20250504181947.17072724@jic23-huawei>
In-Reply-To: <48336225-0e43-46b5-bfc0-34ca8e6a4399@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
	<20250428-iio-introduce-iio_declare_buffer_with_ts-v4-2-6f7f6126f1cb@baylibre.com>
	<48336225-0e43-46b5-bfc0-34ca8e6a4399@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 16:33:21 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> On 2025-04-28 16:23, David Lechner wrote:
> > Change the type of the buffer elements to u16 since we currently only
> > support 16-bit word size. The code was originally written to also allow
> > for 32-bit word size when oversampling is enabled, but so far,
> > oversampling is only implemented when using SPI offload and therefore
> > doesn't use this buffer.
> >
> > AD4695_MAX_CHANNEL_SIZE macro is dropped since it no longer adds any
> > value.
> >
> > AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
> > previously we were overallocating. AD4695_MAX_CHANNELS is the number of
> > of voltage channels and + 1 is for the temperature channel.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
Mostly because there are two many patches for me to keep track of
at the moment I'm going to apply the ones in here that stand on their own
without the macro and your v5 with that size thing can be a smaller series :)

Applied this one.

Thanks,

Jonathan

> > ---
> >   drivers/iio/adc/ad4695.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
> > index 68c6625db0d75f4cade7cb029e94191118dbcaa0..0c633d43e480d5404074e9fa35f1d330b448f0a2 100644
> > --- a/drivers/iio/adc/ad4695.c
> > +++ b/drivers/iio/adc/ad4695.c
> > @@ -106,8 +106,6 @@
> >   
> >   /* Max number of voltage input channels. */
> >   #define AD4695_MAX_CHANNELS		16
> > -/* Max size of 1 raw sample in bytes. */
> > -#define AD4695_MAX_CHANNEL_SIZE		2
> >   
> >   enum ad4695_in_pair {
> >   	AD4695_IN_PAIR_REFGND,
> > @@ -162,8 +160,8 @@ struct ad4695_state {
> >   	struct spi_transfer buf_read_xfer[AD4695_MAX_CHANNELS * 2 + 3];
> >   	struct spi_message buf_read_msg;
> >   	/* Raw conversion data received. */
> > -	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
> > -		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
> > +	u16 buf[ALIGN((AD4695_MAX_CHANNELS + 1) * sizeof(u16),
> > +		      sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
> >   	u16 raw_data;
> >   	/* Commands to send for single conversion. */
> >   	u16 cnv_cmd;
> > @@ -660,9 +658,8 @@ static int ad4695_buffer_preenable(struct iio_dev *indio_dev)
> >   	iio_for_each_active_channel(indio_dev, bit) {
> >   		xfer = &st->buf_read_xfer[num_xfer];
> >   		xfer->bits_per_word = 16;
> > -		xfer->rx_buf = &st->buf[rx_buf_offset];
> > +		xfer->rx_buf = &st->buf[rx_buf_offset++];
> >   		xfer->len = 2;
> > -		rx_buf_offset += xfer->len;
> >   
> >   		if (bit == temp_chan_bit) {
> >   			temp_en = 1;
> >  
> 


