Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD431279A2F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 16:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIZOr4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 10:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZOr4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 10:47:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8860620BED;
        Sat, 26 Sep 2020 14:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601131675;
        bh=Cqdr63Eq+wVYenVsZtUQn/PzWYTxrwYKIvL/ax56lK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZnUVc1pY/DOXxviiOjWmvHX6FXf6dmvD6tX3skZ6P82lnO0tpJ1uAPIoM5QbpAap/
         d2tKWYXsW+2xK9pUiJul6AKGUbq2G4BfFNnvd2Yr9jCrJDlrsUUvJNseXFCNQBG/St
         3DCrTxxWw4RKNP4M0i9gTu9SwvV6kwHlgi7Uz488=
Date:   Sat, 26 Sep 2020 15:47:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tobias Jordan <kernel@cdqe.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: gyroadc: fix leak of device node iterator
Message-ID: <20200926154751.0bfd072f@archlinux>
In-Reply-To: <20200926104515.GA12079@agrajag.zerfleddert.de>
References: <20200926104515.GA12079@agrajag.zerfleddert.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Sep 2020 12:45:15 +0200
Tobias Jordan <kernel@cdqe.de> wrote:

> Add missing of_node_put calls for the error paths of the
> for_each_child_of_node loop in rcar_gyroadc_parse_subdevs.
> 
> Thought about adding an "goto err_of_node_put" instead, but as the error
> paths are quite divergent, I'm not sure if that wouldn't complicate
> things.
> 
> Fixes: 059c53b32329 ("iio: adc: Add Renesas GyroADC driver")
> Signed-off-by: Tobias Jordan <kernel@cdqe.de>
Looks to me like there is one more route out of the
for_each_child_of_node() that this doesn't cover.

		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A)
			break;

If you agree, could you add an of_put_node() to that as well.
It's not an error path, but it does break out early.
Probably also want to modify the description of the patch a tiny
bit to match with that changing being in there as well.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rcar-gyroadc.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index dcaefc108ff6..3746b0276b80 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -357,6 +357,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
>  			break;
>  		default:
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
> @@ -374,6 +375,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  				dev_err(dev,
>  					"Failed to get child reg property of ADC \"%pOFn\".\n",
>  					child);
> +				of_node_put(child);
>  				return ret;
>  			}
>  
> @@ -382,6 +384,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  				dev_err(dev,
>  					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
>  					num_channels, child, reg);
> +				of_node_put(child);
>  				return -EINVAL;
>  			}
>  		}
> @@ -391,6 +394,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			dev_err(dev,
>  				"Channel %i uses different ADC mode than the rest.\n",
>  				reg);
> +			of_node_put(child);
>  			return -EINVAL;
>  		}
>  
> @@ -401,6 +405,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  		if (IS_ERR(vref)) {
>  			dev_dbg(dev, "Channel %i 'vref' supply not connected.\n",
>  				reg);
> +			of_node_put(child);
>  			return PTR_ERR(vref);
>  		}
>  

