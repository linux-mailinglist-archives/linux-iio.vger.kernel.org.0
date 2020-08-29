Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A2125689A
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgH2PVJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgH2PVH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:21:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 506EB20707;
        Sat, 29 Aug 2020 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598714466;
        bh=Z+6WVm3iWWKzzimzw8K/1fY+Z4iQualX393QfUsiaX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ucUiDJgGaWWuD5e1XLp8kulN6RRUEKTS0148111yjBDYjkvspscfnMYf0MN6AIzWt
         zwqZZmLn+Onpg3bSSQMtaxu2R6SHfyfgtkvTH8sldOoWCMZiDFbd765ySRaguNmNh8
         aLyshI/mdU53oWGD8h7mHKpffFDREtSwkltEMbOE=
Date:   Sat, 29 Aug 2020 16:21:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: mag3110: Simplify with
 dev_err_probe()
Message-ID: <20200829162102.602a3424@archlinux>
In-Reply-To: <20200826161539.20788-1-krzk@kernel.org>
References: <20200826161539.20788-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 18:15:38 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
I'm a lazy person, so if you have a series like this where you decide
to post a new version without anyone having commented on it, please
send a quick reply to say you have done that.  Avoids me
applying wrong versions of things!

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/mag3110.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index 4d305a21c379..838b13c8bb3d 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -476,22 +476,14 @@ static int mag3110_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  
>  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> -	if (IS_ERR(data->vdd_reg)) {
> -		if (PTR_ERR(data->vdd_reg) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		dev_err(&client->dev, "failed to get VDD regulator!\n");
> -		return PTR_ERR(data->vdd_reg);
> -	}
> +	if (IS_ERR(data->vdd_reg))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
> +				     "failed to get VDD regulator!\n");
>  
>  	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
> -	if (IS_ERR(data->vddio_reg)) {
> -		if (PTR_ERR(data->vddio_reg) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		dev_err(&client->dev, "failed to get VDDIO regulator!\n");
> -		return PTR_ERR(data->vddio_reg);
> -	}
> +	if (IS_ERR(data->vddio_reg))
> +		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
> +				     "failed to get VDDIO regulator!\n");
>  
>  	ret = regulator_enable(data->vdd_reg);
>  	if (ret) {

