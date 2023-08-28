Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715378B22F
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjH1Noy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjH1Noi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:44:38 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B13D8;
        Mon, 28 Aug 2023 06:44:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C70482D8;
        Mon, 28 Aug 2023 15:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693230191;
        bh=Q421iyHecR8gDgk819+wnsxoOAwEwRcjEy6a+o93vfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5CYFivHdcKjvz6B2E2/fynloy7sko6x+rOhhOPgixU5waMvaNwOwtP7CbgzP5g5r
         hh/UY8AxFg5vus9STIKcNSuYiBkzXtQybtOfGfp7lmmdvxJ33dw/JcgTFS4oMjKjHX
         Td+meB7eVhsl5Rf69REmjKQJ1OK63o/h8ETsL8SE=
Date:   Mon, 28 Aug 2023 16:44:42 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: dac: ti-dac5571: Use i2c_get_match_data()
Message-ID: <20230828134442.GL14596@pendragon.ideasonboard.com>
References: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
 <20230818173907.323640-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818173907.323640-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Biju,

Thank you for the patch.

On Fri, Aug 18, 2023 at 06:39:06PM +0100, Biju Das wrote:
> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data() by converting enum->pointer for data in the
> match table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

The change looks fine, but a commit message that explains why would
be nice, the same way you have done with a similar modification in a DRM
bridge driver.

> ---
> v1->v2:
>  * No change.
> ---
>  drivers/iio/dac/ti-dac5571.c | 48 ++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index bab11b9adc25..2bb3f76569ee 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -313,7 +313,6 @@ static int dac5571_probe(struct i2c_client *client)
>  	const struct dac5571_spec *spec;
>  	struct dac5571_data *data;
>  	struct iio_dev *indio_dev;
> -	enum chip_id chip_id;
>  	int ret, i;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -329,12 +328,7 @@ static int dac5571_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = dac5571_channels;
>  
> -	if (dev_fwnode(dev))
> -		chip_id = (uintptr_t)device_get_match_data(dev);
> -	else
> -		chip_id = id->driver_data;
> -
> -	spec = &dac5571_spec[chip_id];
> +	spec = i2c_get_match_data(client);
>  
>  	indio_dev->num_channels = spec->num_channels;
>  	data->spec = spec;
> @@ -392,31 +386,31 @@ static void dac5571_remove(struct i2c_client *i2c)
>  }
>  
>  static const struct of_device_id dac5571_of_id[] = {
> -	{.compatible = "ti,dac5571", .data = (void *)single_8bit},
> -	{.compatible = "ti,dac6571", .data = (void *)single_10bit},
> -	{.compatible = "ti,dac7571", .data = (void *)single_12bit},
> -	{.compatible = "ti,dac5574", .data = (void *)quad_8bit},
> -	{.compatible = "ti,dac6574", .data = (void *)quad_10bit},
> -	{.compatible = "ti,dac7574", .data = (void *)quad_12bit},
> -	{.compatible = "ti,dac5573", .data = (void *)quad_8bit},
> -	{.compatible = "ti,dac6573", .data = (void *)quad_10bit},
> -	{.compatible = "ti,dac7573", .data = (void *)quad_12bit},
> -	{.compatible = "ti,dac121c081", .data = (void *)single_12bit},
> +	{.compatible = "ti,dac5571", .data = &dac5571_spec[single_8bit] },
> +	{.compatible = "ti,dac6571", .data = &dac5571_spec[single_10bit] },
> +	{.compatible = "ti,dac7571", .data = &dac5571_spec[single_12bit] },
> +	{.compatible = "ti,dac5574", .data = &dac5571_spec[quad_8bit] },
> +	{.compatible = "ti,dac6574", .data = &dac5571_spec[quad_10bit] },
> +	{.compatible = "ti,dac7574", .data = &dac5571_spec[quad_12bit] },
> +	{.compatible = "ti,dac5573", .data = &dac5571_spec[quad_8bit] },
> +	{.compatible = "ti,dac6573", .data = &dac5571_spec[quad_10bit] },
> +	{.compatible = "ti,dac7573", .data = &dac5571_spec[quad_12bit] },
> +	{.compatible = "ti,dac121c081", .data = &dac5571_spec[single_12bit] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dac5571_of_id);
>  
>  static const struct i2c_device_id dac5571_id[] = {
> -	{"dac5571", single_8bit},
> -	{"dac6571", single_10bit},
> -	{"dac7571", single_12bit},
> -	{"dac5574", quad_8bit},
> -	{"dac6574", quad_10bit},
> -	{"dac7574", quad_12bit},
> -	{"dac5573", quad_8bit},
> -	{"dac6573", quad_10bit},
> -	{"dac7573", quad_12bit},
> -	{"dac121c081", single_12bit},
> +	{"dac5571", (kernel_ulong_t)&dac5571_spec[single_8bit] },
> +	{"dac6571", (kernel_ulong_t)&dac5571_spec[single_10bit] },
> +	{"dac7571", (kernel_ulong_t)&dac5571_spec[single_12bit] },
> +	{"dac5574", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
> +	{"dac6574", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
> +	{"dac7574", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
> +	{"dac5573", (kernel_ulong_t)&dac5571_spec[quad_8bit] },
> +	{"dac6573", (kernel_ulong_t)&dac5571_spec[quad_10bit] },
> +	{"dac7573", (kernel_ulong_t)&dac5571_spec[quad_12bit] },
> +	{"dac121c081", (kernel_ulong_t)&dac5571_spec[single_12bit] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, dac5571_id);

-- 
Regards,

Laurent Pinchart
