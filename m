Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC97147433
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 12:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfFPKUV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 06:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfFPKUV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 06:20:21 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5A32084A;
        Sun, 16 Jun 2019 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560680421;
        bh=iBkYP6OfU54csm2E37SPikvbgfpw7ys0HbRZX4qW+4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XJaNAmw7TcK41st5yYw2e9/EQXxLNabrPusfr6OOr9IirDY08R9Fg3/woo3emkSGk
         XPFAOaaJY42wcMGK4EMopx1wNIq7rHb87fPRNsU0BKzJOHV/lkPjY8bB0rGiu7y+Ee
         qHxOnKLhFqm6JQrtyr+wEC90HaKwFber3V+EsyVE=
Date:   Sun, 16 Jun 2019 11:20:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 3/3] staging: iio: ad7150: clean up of comments
Message-ID: <20190616112014.1010b145@archlinux>
In-Reply-To: <a88f36a998eb3fc91cc70bc8fc76e3614706cdbe.1560529045.git.melissa.srw@gmail.com>
References: <cover.1560529045.git.melissa.srw@gmail.com>
        <a88f36a998eb3fc91cc70bc8fc76e3614706cdbe.1560529045.git.melissa.srw@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Jun 2019 13:33:19 -0300
Melissa Wen <melissa.srw@gmail.com> wrote:

> General cleaning of comments to remove useless information or improve
> description.
> 
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7150.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
> index 7d56f10a19ed..51d6b52bce8b 100644
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -163,7 +163,8 @@ static int ad7150_read_event_config(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -/* lock should be held */
> +/* state_lock should be held to ensure consistent state*/
> +
>  static int ad7150_write_event_params(struct iio_dev *indio_dev,
>  				     unsigned int chan,
>  				     enum iio_event_type type,
> @@ -479,10 +480,6 @@ static const struct iio_chan_spec ad7150_channels[] = {
>  	AD7150_CAPACITANCE_CHAN(1)
>  };
>  
> -/*
> - * threshold events
> - */
> -
>  static irqreturn_t ad7150_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -571,10 +568,6 @@ static const struct iio_info ad7150_info = {
>  	.write_event_value = &ad7150_write_event_value,
>  };
>  
> -/*
> - * device probe and remove
> - */
> -
>  static int ad7150_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {

