Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7096B1A7A9
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 13:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfEKLUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 07:20:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728518AbfEKLUM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 07:20:12 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E27AA2089E;
        Sat, 11 May 2019 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557573611;
        bh=FPw5tH6pTg0ImQQbQf6rPIaakB64renHH0j6wMOqbGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AtPHCbby/tY/IIBUdZN6//Cg90OKong0GwjS9WM9EljhoktdQWz2OY013D8GCyImp
         apOXalI0rEWtQZ4F8y/t4cs9zLG987aAWwiUm3PKHG9Nke3O0VOBsc3+XDEtn0jUF7
         BL2Aje9D00KLntc5frA6ljyABRXfPTB8ep0zZew0=
Date:   Sat, 11 May 2019 12:20:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-linux-external@cisco.com, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: dac: ds4422/ds4424 drop of_node check
Message-ID: <20190511122006.3e78486e@archlinux>
In-Reply-To: <20190505192438.2644-1-ruslan@babayev.com>
References: <20190505192438.2644-1-ruslan@babayev.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  5 May 2019 12:24:36 -0700
Ruslan Babayev <ruslan@babayev.com> wrote:

> The driver doesn't actually rely on any DT properties. Removing this
> check makes it usable on ACPI based platforms.
> 
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> Cc: xe-linux-external@cisco.com
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ds4424.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index 883a47562055..2b3ba1a66fe8 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -236,12 +236,6 @@ static int ds4424_probe(struct i2c_client *client,
>  	indio_dev->dev.of_node = client->dev.of_node;
>  	indio_dev->dev.parent = &client->dev;
>  
> -	if (!client->dev.of_node) {
> -		dev_err(&client->dev,
> -				"Not found DT.\n");
> -		return -ENODEV;
> -	}
> -
>  	data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
>  	if (IS_ERR(data->vcc_reg)) {
>  		dev_err(&client->dev,

