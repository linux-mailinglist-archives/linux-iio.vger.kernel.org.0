Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395C2214785
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGDQqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDQqf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:46:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB7C20724;
        Sat,  4 Jul 2020 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593881195;
        bh=jx6BcDQqoU5gzBE7O7So04LZrR1uSY7zCUAFC7GLsnc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kd7eQUoNpcwZURqEHe3xfxO7zG0rQd1U+UnAneN4giuCjZkKUdgdZwIzsbXouK5AC
         v6zNivIxziVX/pQfqCKsiokJQwEanb+FDvu30haMbfl06wKo4J9ShJ2q2uHAB5qE2G
         3HLee4Bne0wq2XHdSPYkRbQ2xmtJEBvbvy2OSV7Q=
Date:   Sat, 4 Jul 2020 17:46:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: magnetometer: bmc150: Add proper compatible
 for BMM150
Message-ID: <20200704174630.381cc2d3@archlinux>
In-Reply-To: <20200629100537.20365-2-krzk@kernel.org>
References: <20200629100537.20365-1-krzk@kernel.org>
        <20200629100537.20365-2-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jun 2020 12:05:37 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The compatible for BMM150 should not have "_magn" suffix because, unlike
> two other Bosch devices, it is only a magnetometer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Both applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to ignore them.

Thanks for tidying this up.

Jonathan

> 
> ---
> 
> Changes since v2:
> 1. Add compatible only for bmm150.
> 
> Changes since v1:
> 1. New patch.
> ---
>  drivers/iio/magnetometer/bmc150_magn_i2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> index fb45b63c56e4..876e96005e33 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> @@ -58,7 +58,8 @@ MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
>  static const struct of_device_id bmc150_magn_of_match[] = {
>  	{ .compatible = "bosch,bmc150_magn" },
>  	{ .compatible = "bosch,bmc156_magn" },
> -	{ .compatible = "bosch,bmm150_magn" },
> +	{ .compatible = "bosch,bmm150_magn" }, /* deprecated compatible */
> +	{ .compatible = "bosch,bmm150" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, bmc150_magn_of_match);

