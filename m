Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49722DEFB
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 14:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGZMaI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 08:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGZMaI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 08:30:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D1D3206D8;
        Sun, 26 Jul 2020 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595766608;
        bh=s4J6EOGEFA69R9t8lF7e6EZ5gSOJtEn0B6k80Px8dH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jyE5RME0fADgdc4yS8tRY3IywkvcpbELB3NEzhIbRHVro5oBFuaaz4wbcojPz/A1C
         JpSKmAOFm0xeYtqVc0oC889MBV7KE6P0O2NE2gpIsTQ/2Gty07NgDXfo/BRVE70ZEy
         hn4Vt6KbtX7inaFQDa1e5g7CkNlgHHf3qicHAZHM=
Date:   Sun, 26 Jul 2020 13:30:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adxl372_spi: change indentation for of_table
Message-ID: <20200726133004.7336d99c@archlinux>
In-Reply-To: <20200722072546.65742-1-alexandru.ardelean@analog.com>
References: <20200720134839.71124-1-alexandru.ardelean@analog.com>
        <20200722072546.65742-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jul 2020 10:25:46 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The change is mostly stylistic. The table should be indented with tabs
> instead of spaces.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied

> ---
> 
> Changelog v1 -> v2:
> * remove trailing comma at null terminator
> 
>  drivers/iio/accel/adxl372_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
> index 3ef7e3a4804e..1f1352fee99a 100644
> --- a/drivers/iio/accel/adxl372_spi.c
> +++ b/drivers/iio/accel/adxl372_spi.c
> @@ -40,8 +40,8 @@ static const struct spi_device_id adxl372_spi_id[] = {
>  MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
>  
>  static const struct of_device_id adxl372_of_match[] = {
> -        { .compatible = "adi,adxl372" },
> -        { },
> +	{ .compatible = "adi,adxl372" },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adxl372_of_match);
>  

