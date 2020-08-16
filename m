Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CBD2456D6
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgHPIyR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 04:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgHPIyQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Aug 2020 04:54:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D57DB2065C;
        Sun, 16 Aug 2020 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597568055;
        bh=jjy0HV8P8cPtylgj4rPo79m0ha6nxzQodJS69nr3LBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qpjQWtyBhuM4nL8cAf3L16AnpXRxJZ7ut9Gg4ozYyCD6nSASmLZ8n5LeW7pWc42lc
         N5nMHSjUVEdu672pKDt6Jp1PkRotcDWxjeZahQaJbhgQdOMEDN+vwv7N61rKhbd2jy
         qo18UznfbvMO1IlqMCrvA3oWlM+wgOH4uHQd5Ik4=
Date:   Sun, 16 Aug 2020 09:54:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com, hslester96@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] iio: accel: mma8452: Use dev_err_probe() to
 simplify error handling
Message-ID: <20200816095411.4b0d943d@archlinux>
In-Reply-To: <1597117396-2894-1-git-send-email-Anson.Huang@nxp.com>
References: <1597117396-2894-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Aug 2020 11:43:14 +0800
Anson Huang <Anson.Huang@nxp.com> wrote:

> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Hi Anson,

All look good, but will have to wait for dev_err_probe to be in my
upstream tree which hasn't quite happened yet.  Give me a poke if 
I seem to have lost these once that is true!

Thanks,

Jonathan

> ---
>  drivers/iio/accel/mma8452.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index ba27f86..9b5f23b 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1538,22 +1538,14 @@ static int mma8452_probe(struct i2c_client *client,
>  	data->chip_info = match->data;
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

