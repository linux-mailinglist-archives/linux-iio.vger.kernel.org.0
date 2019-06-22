Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7534F4AA
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfFVJXW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfFVJXW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:23:22 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8572206BA;
        Sat, 22 Jun 2019 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561195401;
        bh=8MdsXVlMi4vSBSz+Up33KUEB/PHAE+taEljjGpQ1cvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ssmbRe9ttHQo0BO0o0UJlKAZDtHHdgGh4RQRJ3UeaAli22V7anbUE0Hu2y+O7Fruf
         OqzozYlIa/SB9yPtNZH5vGuKCugOXK4K0O4AXLUF0VjC72QrGY0xMpz9lOkEIM0PT8
         nC9VS9JyFcfqATYAspQpwxBZcB6pqyndFRd4Cagw=
Date:   Sat, 22 Jun 2019 10:23:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>
Subject: Re: [PATCH 3/5] iio: adc: stm32-dfsdm: manage data resolution in
 trigger mode
Message-ID: <20190622102315.2484d6de@archlinux>
In-Reply-To: <1560949431-22948-4-git-send-email-olivier.moysan@st.com>
References: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
        <1560949431-22948-4-git-send-email-olivier.moysan@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jun 2019 15:03:49 +0200
Olivier Moysan <olivier.moysan@st.com> wrote:

> Add output sample resolution management in scan mode.
> Add stm32_dfsdm_process_data() function to share sample
> processing between continuous and trigger modes.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Makes sense, though I would have preferred a little bit more info
on what the user visible effects fo this change are in
the patch description.  I think I know from reading the code,
but not every one will do that ;)

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 41 ++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 6b90a40882f2..5b19a88412a6 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -779,6 +779,30 @@ static unsigned int stm32_dfsdm_adc_dma_residue(struct stm32_dfsdm_adc *adc)
>  	return 0;
>  }
>  
> +static inline void stm32_dfsdm_process_data(struct stm32_dfsdm_adc *adc,
> +					    s32 *buffer)
> +{
> +	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
> +	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
> +	unsigned int i = adc->nconv;
> +	s32 *ptr = buffer;
> +
> +	while (i--) {
> +		/* Mask 8 LSB that contains the channel ID */
> +		*ptr &= 0xFFFFFF00;
> +		/* Convert 2^(n-1) sample to 2^(n-1)-1 to avoid wrap-around */
> +		if (*ptr > flo->max)
> +			*ptr -= 1;
> +		/*
> +		 * Samples from filter are retrieved with 23 bits resolution
> +		 * or less. Shift left to align MSB on 24 bits.
> +		 */
> +		*ptr <<= flo->lshift;
> +
> +		ptr++;
> +	}
> +}
> +
>  static irqreturn_t stm32_dfsdm_adc_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -787,7 +811,9 @@ static irqreturn_t stm32_dfsdm_adc_trigger_handler(int irq, void *p)
>  	int available = stm32_dfsdm_adc_dma_residue(adc);
>  
>  	while (available >= indio_dev->scan_bytes) {
> -		u32 *buffer = (u32 *)&adc->rx_buf[adc->bufi];
> +		s32 *buffer = (s32 *)&adc->rx_buf[adc->bufi];
> +
> +		stm32_dfsdm_process_data(adc, buffer);
>  
>  		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>  						   pf->timestamp);
> @@ -806,8 +832,6 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
>  {
>  	struct iio_dev *indio_dev = data;
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> -	struct stm32_dfsdm_filter *fl = &adc->dfsdm->fl_list[adc->fl_id];
> -	struct stm32_dfsdm_filter_osr *flo = &fl->flo;
>  	int available = stm32_dfsdm_adc_dma_residue(adc);
>  	size_t old_pos;
>  
> @@ -832,16 +856,7 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
>  	while (available >= indio_dev->scan_bytes) {
>  		s32 *buffer = (s32 *)&adc->rx_buf[adc->bufi];
>  
> -		/* Mask 8 LSB that contains the channel ID */
> -		*buffer &= 0xFFFFFF00;
> -		/* Convert 2^(n-1) sample to 2^(n-1)-1 to avoid wrap-around */
> -		if (*buffer > flo->max)
> -			*buffer -= 1;
> -		/*
> -		 * Samples from filter are retrieved with 23 bits resolution
> -		 * or less. Shift left to align MSB on 24 bits.
> -		 */
> -		*buffer <<= flo->lshift;
> +		stm32_dfsdm_process_data(adc, buffer);
>  
>  		available -= indio_dev->scan_bytes;
>  		adc->bufi += indio_dev->scan_bytes;

