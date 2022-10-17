Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CF2600A7B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Oct 2022 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiJQJYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Oct 2022 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiJQJYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2022 05:24:17 -0400
Received: from first.geanix.com (first.geanix.com [116.203.34.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08C614D16
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2022 02:24:01 -0700 (PDT)
Received: from Seans-MBP.hadsten (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id B8A0D5798E;
        Mon, 17 Oct 2022 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1665998637; bh=gogxN2hF8IfurNMPA15otKPgMEVpeXsj/NmNpszQ74s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=EhAWjQLi6FX88cxkmpQiVp4P/xe6dzQMvRKmGBExXVgcnDHWlv9kFqV5uaIZhSHRz
         MbPcesXpdV9TTBRURcLYdUMwKY1g9anwbdOnKSLazm+2QDj9UdyhCpbxP6ALpyDPQ7
         ulm4cVt9mz/EsxTh4Q3yJrMBnN97ln83ZMHUMOfJiAO9k6vj9VJrCvN/o/Uz1cwkfK
         M/EJNqqfGIa6wQ3c7rUb5zK/imEgvA99ac3qLMOrYRu/hNkINC1Fd5QMMc0wF5Xvkk
         yaOeM1EaUTt2Wz+NaxysMvXENfoLZihbhZS2i7A5KymTRvNoBqPDUbvz+JDC8V3YYQ
         gSxMGld6gNkig==
Date:   Mon, 17 Oct 2022 11:23:56 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 03/14] iio: accel: fxls8962af: Use
 devm_regulator_get_enable()
Message-ID: <20221017092356.4h5fmle46slnr62o@Seans-MBP.hadsten>
References: <20221016163409.320197-1-jic23@kernel.org>
 <20221016163409.320197-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221016163409.320197-4-jic23@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 16, 2022 at 05:33:58PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver only turns the power on at probe and off via a custom
> devm_add_action_or_reset() callback. The new devm_regulator_get_enable()
> replaces this boilerplate code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index bf259db281f5..0d672b1469e8 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -159,7 +159,6 @@ struct fxls8962af_chip_info {
>  struct fxls8962af_data {
>  	struct regmap *regmap;
>  	const struct fxls8962af_chip_info *chip_info;
> -	struct regulator *vdd_reg;
>  	struct {
>  		__le16 channels[3];
>  		s64 ts __aligned(8);
> @@ -1051,13 +1050,6 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  	return IRQ_NONE;
>  }
>  
> -static void fxls8962af_regulator_disable(void *data_ptr)
> -{
> -	struct fxls8962af_data *data = data_ptr;
> -
> -	regulator_disable(data->vdd_reg);
> -}
> -
>  static void fxls8962af_pm_disable(void *dev_ptr)
>  {
>  	struct device *dev = dev_ptr;
> @@ -1171,20 +1163,10 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  	if (ret)
>  		return ret;
>  
> -	data->vdd_reg = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(data->vdd_reg))
> -		return dev_err_probe(dev, PTR_ERR(data->vdd_reg),
> -				     "Failed to get vdd regulator\n");
> -
> -	ret = regulator_enable(data->vdd_reg);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable vdd regulator: %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(dev, fxls8962af_regulator_disable, data);
> +	ret = devm_regulator_get_enable(dev, "vdd");
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get vdd regulator\n");
>  
>  	ret = regmap_read(data->regmap, FXLS8962AF_WHO_AM_I, &reg);
>  	if (ret)
> -- 
> 2.37.2
> 

