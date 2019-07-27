Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEF77C0D
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 23:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfG0V1S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 17:27:18 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:45714 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfG0V1S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2019 17:27:18 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id D957B9E73DD;
        Sat, 27 Jul 2019 22:27:16 +0100 (BST)
Date:   Sat, 27 Jul 2019 22:27:15 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration
 API
Message-ID: <20190727222702.736d91f7@archlinux>
In-Reply-To: <20190726133916.26186-1-hslester96@gmail.com>
References: <20190726133916.26186-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 21:39:16 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Make use of devm_counter_register.
> Then we can remove redundant unregistration API
> usage to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Use devm_add_action_or_reset to keep
>     resource release order.
>   - remove() function is redundant now,
>     delete it.
> 
>  drivers/counter/ftm-quaddec.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 68a9b7393457..4046aa9f9234 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -100,16 +100,18 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
>  	ftm_set_write_protection(ftm);
>  }
>  
> -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> +static void ftm_quaddec_disable(void *ftm)
>  {
> -	ftm_clear_write_protection(ftm);
> -	ftm_write(ftm, FTM_MODE, 0);
> -	ftm_write(ftm, FTM_QDCTRL, 0);
> +	struct ftm_quaddec *ftm_qua = ftm;
> +
> +	ftm_clear_write_protection(ftm_qua);
> +	ftm_write(ftm_qua, FTM_MODE, 0);
> +	ftm_write(ftm_qua, FTM_QDCTRL, 0);
>  	/*
>  	 * This is enough to disable the counter. No clock has been
>  	 * selected by writing to FTM_SC in init()
>  	 */
> -	ftm_set_write_protection(ftm);
> +	ftm_set_write_protection(ftm_qua);
>  }
>  
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> @@ -317,20 +319,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>  
>  	ftm_quaddec_init(ftm);
>  
> -	ret = counter_register(&ftm->counter);
> +	ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
>  	if (ret)
> -		ftm_quaddec_disable(ftm);
> -
> -	return ret;
> -}
> +		return ret;
>  
> -static int ftm_quaddec_remove(struct platform_device *pdev)
> -{
> -	struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> -
> -	counter_unregister(&ftm->counter);
> -
> -	ftm_quaddec_disable(ftm);
> +	ret = devm_counter_register(&pdev->dev, &ftm->counter);
> +	if (ret)
> +		return ret;
>  
>  	return 0;
>  }
> @@ -346,7 +341,6 @@ static struct platform_driver ftm_quaddec_driver = {
>  		.of_match_table = ftm_quaddec_match,
>  	},
>  	.probe = ftm_quaddec_probe,
> -	.remove = ftm_quaddec_remove,
>  };
>  
>  module_platform_driver(ftm_quaddec_driver);

