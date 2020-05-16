Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BA51D6213
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgEPPf0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgEPPf0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:35:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE4720727;
        Sat, 16 May 2020 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589643326;
        bh=6bIdM83OAz8NTK5LfuYkYjYz/+gMNTHlGbMRn7g3eRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b4273gexRENjUClnSjPWBqppBfsxCPCulwXSSMnKmtQkW2MzB/1hej7sgTuuHA8M4
         CmO7PmyAlU/3gX5mX2zuFSuVCQ6W0S4XZnhrLtaL0TAmHvKPfY8ew93CtkLKczWPRC
         xHYCcily2ddVLnRI0BJ88lzvL1gYXZ9Q3vp1ttjE=
Date:   Sat, 16 May 2020 16:35:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: stm32-dac: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516163521.2812cf86@archlinux>
In-Reply-To: <20200514085018.79948-1-sergiu.cuciurean@analog.com>
References: <20200514085018.79948-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 11:50:12 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> ---
>  drivers/iio/dac/stm32-dac.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index f22c1d9129b2..74b9474c8590 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -26,9 +26,11 @@
>  /**
>   * struct stm32_dac - private data of DAC driver
>   * @common:		reference to DAC common data
> + * @lock: lock to protect the data buffer during regmap ops

In this particular case I'm not sure that's what mlock was being used for.
I think it's about avoiding races around checking if powered down and
actually doing it.


>   */
>  struct stm32_dac {
>  	struct stm32_dac_common *common;
> +	struct mutex		lock;
>  };
>  
>  static int stm32_dac_is_enabled(struct iio_dev *indio_dev, int channel)
> @@ -58,10 +60,10 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  	int ret;
>  
>  	/* already enabled / disabled ? */
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&dac->lock);
>  	ret = stm32_dac_is_enabled(indio_dev, ch);
>  	if (ret < 0 || enable == !!ret) {
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&dac->lock);
>  		return ret < 0 ? ret : 0;
>  	}
>  
> @@ -69,13 +71,13 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
>  		ret = pm_runtime_get_sync(dev);
>  		if (ret < 0) {
>  			pm_runtime_put_noidle(dev);
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&dac->lock);
>  			return ret;
>  		}
>  	}
>  
>  	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, msk, en);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&dac->lock);
>  	if (ret < 0) {
>  		dev_err(&indio_dev->dev, "%s failed\n", en ?
>  			"Enable" : "Disable");
> @@ -328,6 +330,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	indio_dev->info = &stm32_dac_iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	mutex_init(&dac->lock);
> +
>  	ret = stm32_dac_chan_of_init(indio_dev);
>  	if (ret < 0)
>  		return ret;

