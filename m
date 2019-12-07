Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F57115BE0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 11:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLGKje (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 05:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfLGKje (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 05:39:34 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D5824670;
        Sat,  7 Dec 2019 10:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575715173;
        bh=DvqoNKlE9swUANJmhSr+roCLfnLLHpQupzn5vAnePzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S5CGnEtf04Z8I0wXO52SzkezsNnF73QJtTzii2vpB9g7taFTe0lQNXl6KlmCQOP1/
         3dmXjL1cbTBMat6tmcjxeVtjlSgt3FZgGPRe6lX4ldRiInHsVz+YoNzTTcRZSKUpfX
         g5z+HAVoz5oarR8f1ADW763qRsD3ZHPhoi5NIcD8=
Date:   Sat, 7 Dec 2019 10:39:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: move register definitions to
 sensor structs
Message-ID: <20191207103927.035eda2a@archlinux>
In-Reply-To: <0e49f52be057a14f0885dfaf496e8274c8107f60.1575282133.git.lorenzo@kernel.org>
References: <0e49f52be057a14f0885dfaf496e8274c8107f60.1575282133.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Dec 2019 12:23:28 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> Move some register definitions to hts221_avg_list, hts221_avg_list and
> hts221_channels since they are used only there and simplify driver code
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
You could potentially switch this to GENMASK for the masks, but that can
be a follow up patch if you want to do so.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hts221_core.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> index 4922444771c6..9003671f14fb 100644
> --- a/drivers/iio/humidity/hts221_core.c
> +++ b/drivers/iio/humidity/hts221_core.c
> @@ -24,13 +24,6 @@
>  #define HTS221_REG_CNTRL1_ADDR		0x20
>  #define HTS221_REG_CNTRL2_ADDR		0x21
>  
> -#define HTS221_REG_AVG_ADDR		0x10
> -#define HTS221_REG_H_OUT_L		0x28
> -#define HTS221_REG_T_OUT_L		0x2a
> -
> -#define HTS221_HUMIDITY_AVG_MASK	0x07
> -#define HTS221_TEMP_AVG_MASK		0x38
> -
>  #define HTS221_ODR_MASK			0x03
>  #define HTS221_BDU_MASK			BIT(2)
>  #define HTS221_ENABLE_MASK		BIT(7)
> @@ -66,8 +59,8 @@ static const struct hts221_odr hts221_odr_table[] = {
>  
>  static const struct hts221_avg hts221_avg_list[] = {
>  	{
> -		.addr = HTS221_REG_AVG_ADDR,
> -		.mask = HTS221_HUMIDITY_AVG_MASK,
> +		.addr = 0x10,
> +		.mask = 0x07,
>  		.avg_avl = {
>  			4, /* 0.4 %RH */
>  			8, /* 0.3 %RH */
> @@ -80,8 +73,8 @@ static const struct hts221_avg hts221_avg_list[] = {
>  		},
>  	},
>  	{
> -		.addr = HTS221_REG_AVG_ADDR,
> -		.mask = HTS221_TEMP_AVG_MASK,
> +		.addr = 0x10,
> +		.mask = 0x38,
>  		.avg_avl = {
>  			2, /* 0.08 degC */
>  			4, /* 0.05 degC */
> @@ -98,7 +91,7 @@ static const struct hts221_avg hts221_avg_list[] = {
>  static const struct iio_chan_spec hts221_channels[] = {
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
> -		.address = HTS221_REG_H_OUT_L,
> +		.address = 0x28,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_OFFSET) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
> @@ -114,7 +107,7 @@ static const struct iio_chan_spec hts221_channels[] = {
>  	},
>  	{
>  		.type = IIO_TEMP,
> -		.address = HTS221_REG_T_OUT_L,
> +		.address = 0x2a,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_OFFSET) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |

