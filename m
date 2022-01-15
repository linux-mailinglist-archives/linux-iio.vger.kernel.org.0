Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9046E48F7A5
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 16:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiAOPwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 10:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiAOPwf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 10:52:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10315C061574
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 07:52:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B700DB808D4
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 15:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF55C36AE3;
        Sat, 15 Jan 2022 15:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642261952;
        bh=RInEhyvUWsSBlNL8bodzEU4K5Ft0bvkscybSG2u5/LI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O9sshLAw0hQvoGZDcXuuWtGE4IP5kaUIyr7WnrqK0aGSLnzJUPScu/S8mtVej65iH
         RowbOAypRVHdkkwOlNb8l9SqT3y2KZRrYgjPFEkoj2L0JxR/w1t03WuZemPjRrsSyG
         MFrt2ASG+Bq2vM2H8XCb/DjL/75NhW7YLFJFLue3a2VinagOP44eTERG3MUWSIh5hP
         mOojpsRvs12UwlnqzIGdxdhWJvWoMdxaM9rBqWfi8JI/08EI0I6XrmbwlGGjq4WVXn
         sbivZHYNr5Bn3NXSdAkQXTnoLVm4GxdcEqKNs2B495VzEa1Oy2GUwNpDP2ZRGZnfml
         9OekWqz/3x0SA==
Date:   Sat, 15 Jan 2022 15:58:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH 03/10] iio: magnetometer: rm3100: Stop abusing the
 ->currentmode
Message-ID: <20220115155832.1f431e65@jic23-huawei>
In-Reply-To: <20211215151344.163036-4-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Dec 2021 16:13:37 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> This is an internal variable for the core, here it is set to a "default"
> value by the driver in order to later be able to perform checks against
> it. None of this is needed because this check actually cares about the
> buffers being enabled or not. So it is an unproper side-channel access
> to the information "are the buffers enabled?", returned officially by
> the iio_buffer_enabled() helper. Use this helper instead.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Hi Miquel,

Make sure to +cc driver authors on v2.

Whilst I think this is safe we should definitely give them visibility.

Obviously some IIO drivers probably have authors who have long moved on
but this one is only 2018 vintage so Song Qiang might still have
access to hardware or be willing to do a review!

Jonathan


> ---
>  drivers/iio/magnetometer/rm3100-core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
> index 13914273c999..be0057f82218 100644
> --- a/drivers/iio/magnetometer/rm3100-core.c
> +++ b/drivers/iio/magnetometer/rm3100-core.c
> @@ -141,18 +141,10 @@ static irqreturn_t rm3100_irq_handler(int irq, void *d)
>  	struct iio_dev *indio_dev = d;
>  	struct rm3100_data *data = iio_priv(indio_dev);
>  
> -	switch (indio_dev->currentmode) {
> -	case INDIO_DIRECT_MODE:
> +	if (!iio_buffer_enabled(indio_dev))
>  		complete(&data->measuring_done);
> -		break;
> -	case INDIO_BUFFER_TRIGGERED:
> +	else
>  		iio_trigger_poll(data->drdy_trig);
> -		break;
> -	default:
> -		dev_err(indio_dev->dev.parent,
> -			"device mode out of control, current mode: %d",
> -			indio_dev->currentmode);
> -	}
>  
>  	return IRQ_WAKE_THREAD;
>  }
> @@ -377,7 +369,7 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
>  			goto unlock_return;
>  	}
>  
> -	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
> +	if (iio_buffer_enabled(indio_dev)) {
>  		/* Writing TMRC registers requires CMM reset. */
>  		ret = regmap_write(regmap, RM3100_REG_CMM, 0);
>  		if (ret < 0)
> @@ -553,7 +545,6 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  	indio_dev->channels = rm3100_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
>  	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> -	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  
>  	if (!irq)
>  		data->use_interrupt = false;

