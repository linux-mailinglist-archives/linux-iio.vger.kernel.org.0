Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B488279ABB
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 18:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgIZQYD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 12:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729747AbgIZQYD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 12:24:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C2821527;
        Sat, 26 Sep 2020 16:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137442;
        bh=x7CD/Cc+BQV5JRqqGgs8yNrYfENI2MsaAgzRJ2ZK81Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I3810f6bKtXPFDDKBFSw2tCLCKjFzaXwardV7+8vmRHEcqEkl9EDK3SVycAR/YI9f
         4PPypdjZsjlg9TzwihylfqlVv5h9+9ALfV/631B8i1HIJA/qvfqLRry81MQK+HRsjh
         SLunJUikCwdBi8kiLoosp9AtTT+xl5M8Wl2iP2a4=
Date:   Sat, 26 Sep 2020 17:23:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tobias Jordan <kernel@cdqe.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: adc: gyroadc: fix leak of device node iterator
Message-ID: <20200926172358.7467e0f3@archlinux>
In-Reply-To: <20200926161946.GA10240@agrajag.zerfleddert.de>
References: <20200926161946.GA10240@agrajag.zerfleddert.de>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Sep 2020 18:19:46 +0200
Tobias Jordan <kernel@cdqe.de> wrote:

> Add missing of_node_put calls when exiting the for_each_child_of_node
> loop in rcar_gyroadc_parse_subdevs early.
> 
> Also add goto-exception handling for the error paths in that loop.
> 
> Fixes: 059c53b32329 ("iio: adc: Add Renesas GyroADC driver")
> Signed-off-by: Tobias Jordan <kernel@cdqe.de>
> ---
> v2:
> - added an of_node_put to the non-error "break" at the end
> - used gotos for the error cases, doesn't look as bad as I thought
Was marginal, so I'll go with it.

Applied to the fixes-togreg branch of iio.git and marked for stable.
> 
>  drivers/iio/adc/rcar-gyroadc.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index dcaefc108ff6..9f38cf3c7dc2 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -357,7 +357,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
>  			break;
>  		default:
> -			return -EINVAL;
> +			goto err_e_inval;
>  		}
>  
>  		/*
> @@ -374,7 +374,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  				dev_err(dev,
>  					"Failed to get child reg property of ADC \"%pOFn\".\n",
>  					child);
> -				return ret;
> +				goto err_of_node_put;
>  			}
>  
>  			/* Channel number is too high. */
> @@ -382,7 +382,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  				dev_err(dev,
>  					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
>  					num_channels, child, reg);
> -				return -EINVAL;
> +				goto err_e_inval;
>  			}
>  		}
>  
> @@ -391,7 +391,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  			dev_err(dev,
>  				"Channel %i uses different ADC mode than the rest.\n",
>  				reg);
> -			return -EINVAL;
> +			goto err_e_inval;
>  		}
>  
>  		/* Channel is valid, grab the regulator. */
> @@ -401,7 +401,8 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  		if (IS_ERR(vref)) {
>  			dev_dbg(dev, "Channel %i 'vref' supply not connected.\n",
>  				reg);
> -			return PTR_ERR(vref);
> +			ret = PTR_ERR(vref);
> +			goto err_of_node_put;
>  		}
>  
>  		priv->vref[reg] = vref;
> @@ -425,8 +426,10 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  		 * attached to the GyroADC at a time, so if we found it,
>  		 * we can stop parsing here.
>  		 */
> -		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A)
> +		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A) {
> +			of_node_put(child);
>  			break;
> +		}
>  	}
>  
>  	if (first) {
> @@ -435,6 +438,12 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
>  	}
>  
>  	return 0;
> +
> +err_e_inval:
> +	ret = -EINVAL;
> +err_of_node_put:
> +	of_node_put(child);
> +	return ret;
>  }
>  
>  static void rcar_gyroadc_deinit_supplies(struct iio_dev *indio_dev)

