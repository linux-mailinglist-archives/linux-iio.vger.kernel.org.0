Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A88E4F4B4
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 11:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfFVJdO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 05:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfFVJdO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 05:33:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF7B2075E;
        Sat, 22 Jun 2019 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561195993;
        bh=I0NwKMdM7grA72wdghATYuLC9S2scyeIRrURUSdnpWc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fjYvZv6SCiSgFIbOvVkdSfPQMb3qP+hXn19RP8kVFsA+lDN0AXzmkMQhD7MlJOTjg
         ZkYP+qzVkxjnbrhWrqB/kjGwGGIn/h/kadTwkoc2V+ouCWMCHhhbEr73mbQ7KKrY1a
         yWlr8ul5/WMbgUn74wcqKyiNNfBqiaCvoi1GYyJc=
Date:   Sat, 22 Jun 2019 10:33:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>
Subject: Re: [PATCH 5/5] iio: adc: stm32-dfsdm: add comment for 16 bits
 record
Message-ID: <20190622103307.50ba052b@archlinux>
In-Reply-To: <1560949431-22948-6-git-send-email-olivier.moysan@st.com>
References: <1560949431-22948-1-git-send-email-olivier.moysan@st.com>
        <1560949431-22948-6-git-send-email-olivier.moysan@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 19 Jun 2019 15:03:51 +0200
Olivier Moysan <olivier.moysan@st.com> wrote:

> Add a comment on DMA configuration for 16 bits record.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index d855a605eab6..ee1e0569d0e1 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -918,6 +918,11 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
>  static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>  {
>  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> +	/*
> +	 * The DFSDM supports half-word transfers. However, for 16 bits record,
> +	 * 4 bytes buswidth is kept, to avoid losing samples LSBs when left
> +	 * shift is required.
> +	 */
>  	struct dma_slave_config config = {
>  		.src_addr = (dma_addr_t)adc->dfsdm->phys_base,
>  		.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,

