Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD50C57086
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfFZS0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 14:26:36 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35586 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZS0g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 14:26:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 1D7DB9E73B6;
        Wed, 26 Jun 2019 19:26:33 +0100 (BST)
Date:   Wed, 26 Jun 2019 19:26:31 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adis162xx: fix low-power docs & reports
Message-ID: <20190626192631.7ffa8043@archlinux>
In-Reply-To: <20190625124840.24542-1-alexandru.ardelean@analog.com>
References: <20190625124840.24542-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 15:48:40 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> All current ADIS162XX drivers have incorrect values defined via comments.
> Also, when an error is reported the printed value is incorrect.
> 
> The functionality itself isn't affected, so it's not a critical issue.
> 
> And since the change is trivial, it was included in a single patch that
> fixes these in one go. All values were correlated with the ones specified
> in the data-sheets.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for usual reasons.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adis16201.c         | 4 ++--
>  drivers/iio/accel/adis16209.c         | 4 ++--
>  drivers/staging/iio/accel/adis16203.c | 4 ++--
>  drivers/staging/iio/accel/adis16240.c | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index 4c1d482ea73a..3257d4d27015 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -71,7 +71,7 @@
>  #define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT		2
>  /* Power supply above 3.625 V */
>  #define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT		1
> -/* Power supply below 3.15 V */
> +/* Power supply below 2.975 V */
>  #define  ADIS16201_DIAG_STAT_POWER_LOW_BIT		0
>  
>  /* System Command Register Definition */
> @@ -231,7 +231,7 @@ static const char * const adis16201_status_error_msgs[] = {
>  	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
>  	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
>  	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
>  };
>  
>  static const struct adis_data adis16201_data = {
> diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
> index f2dc3a5f0463..01dd02f7e1d6 100644
> --- a/drivers/iio/accel/adis16209.c
> +++ b/drivers/iio/accel/adis16209.c
> @@ -73,7 +73,7 @@
>  #define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>  /* Power supply above 3.625 V */
>  #define  ADIS16209_STAT_POWER_HIGH_BIT		1
> -/* Power supply below 3.15 V */
> +/* Power supply below 2.975 V */
>  #define  ADIS16209_STAT_POWER_LOW_BIT		0
>  
>  #define ADIS16209_CMD_REG			0x3E
> @@ -241,7 +241,7 @@ static const char * const adis16209_status_error_msgs[] = {
>  	[ADIS16209_STAT_SPI_FAIL_BIT] = "SPI failure",
>  	[ADIS16209_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
>  	[ADIS16209_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +	[ADIS16209_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
>  };
>  
>  static const struct adis_data adis16209_data = {
> diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
> index a5d974ac2e3b..39687139a7d3 100644
> --- a/drivers/staging/iio/accel/adis16203.c
> +++ b/drivers/staging/iio/accel/adis16203.c
> @@ -122,7 +122,7 @@
>  /* Power supply above 3.625 V */
>  #define ADIS16203_DIAG_STAT_POWER_HIGH_BIT    1
>  
> -/* Power supply below 3.15 V */
> +/* Power supply below 2.975 V */
>  #define ADIS16203_DIAG_STAT_POWER_LOW_BIT     0
>  
>  /* GLOB_CMD */
> @@ -234,7 +234,7 @@ static const char * const adis16203_status_error_msgs[] = {
>  	[ADIS16203_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
>  	[ADIS16203_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
>  	[ADIS16203_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
> -	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
> +	[ADIS16203_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 2.975V",
>  };
>  
>  static const struct adis_data adis16203_data = {
> diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
> index b80c8529784b..62f4b3b1b457 100644
> --- a/drivers/staging/iio/accel/adis16240.c
> +++ b/drivers/staging/iio/accel/adis16240.c
> @@ -175,7 +175,7 @@
>  /* Power supply above 3.625 V */
>  #define ADIS16240_DIAG_STAT_POWER_HIGH_BIT	1
>  
> - /* Power supply below 3.15 V */
> + /* Power supply below 2.225 V */
>  #define ADIS16240_DIAG_STAT_POWER_LOW_BIT	0
>  
>  /* GLOB_CMD */

