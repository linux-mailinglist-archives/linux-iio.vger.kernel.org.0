Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA2843E5A5
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJ1QCF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 12:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230046AbhJ1QCE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 12:02:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD6F460FC4;
        Thu, 28 Oct 2021 15:59:33 +0000 (UTC)
Date:   Thu, 28 Oct 2021 17:04:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Xu Wang <vulab@iscas.ac.cn>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiabing.wan@qq.com
Subject: Re: [PATCH v3] iio: adc: stm32-adc: Fix of_node_put() issue in
 stm32-adc
Message-ID: <20211028170400.1d922d5c@jic23-huawei>
In-Reply-To: <20211028154204.1263861-1-wanjiabing@vivo.com>
References: <20211028154204.1263861-1-wanjiabing@vivo.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 23:42:02 +0800
Wan Jiabing <wanjiabing@vivo.com> wrote:

> Fix following coccicheck warning:
> ./drivers/iio/adc/stm32-adc.c:2014:1-33: WARNING: Function
> for_each_available_child_of_node should have of_node_put() before return.
> 
> Early exits from for_each_available_child_of_node should decrement the
> node reference counter. Replace return by goto here.
> 
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
I applied v2.  So no need to resend.  I fix minor typos etc whilst
applying patches as it saves everyone time!

Thanks,

Jonathan

> ---
> Changelog:
> v2:
> - Fix typo and add reviewed-by.
> v3:
> - Fix typo.
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

