Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09943E381
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhJ1OYg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 10:24:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhJ1OYf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 10:24:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5F8D61073;
        Thu, 28 Oct 2021 14:22:04 +0000 (UTC)
Date:   Thu, 28 Oct 2021 15:26:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Xu Wang <vulab@iscas.ac.cn>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH v2] iio: adc: stm32-adc: Fix of_node_put() issue in
 stm32-adc
Message-ID: <20211028152631.0aa9c619@jic23-huawei>
In-Reply-To: <20211021121826.6339-1-wanjiabing@vivo.com>
References: <20211021121826.6339-1-wanjiabing@vivo.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Oct 2021 08:18:23 -0400
Wan Jiabing <wanjiabing@vivo.com> wrote:

> Fix following coccicheck warning:
> ./drivers/iio/adc/stm32-adc.c:2014:1-33: WARNING: Function
> for_each_available_child_of_node should have of_node_put() before return.
> 
> Early exits from for_each_available_child_of_node should decrement the
> node reference counter. Repalce return by goto here.

Replace


> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

We could treat this as a fix, but I'm feeling lazy and it's a minor that
should be harmless.  So applied to the togreg branch of iio.git and pushed
out as testing for 0-day to see if it can find anything we missed.

Thanks,

Jonathan


> ---
> Changelog:
> v2:
> - Fix typo and add reviewed-by.
> ---
>  drivers/iio/adc/stm32-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 6245434f8377..7f1fb36c747c 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -2024,7 +2024,8 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  			if (strlen(name) >= STM32_ADC_CH_SZ) {
>  				dev_err(&indio_dev->dev, "Label %s exceeds %d characters\n",
>  					name, STM32_ADC_CH_SZ);
> -				return -EINVAL;
> +				ret = -EINVAL;
> +				goto err;
>  			}
>  			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
>  			ret = stm32_adc_populate_int_ch(indio_dev, name, val);

