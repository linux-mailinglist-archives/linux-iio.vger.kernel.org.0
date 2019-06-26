Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6210D570A4
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFZSel (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 14:34:41 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35684 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfFZSel (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 14:34:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 78A019E73B6;
        Wed, 26 Jun 2019 19:34:39 +0100 (BST)
Date:   Wed, 26 Jun 2019 19:34:38 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] drivers: spi: core: Add optional stall delay
 between cs_change transfers
Message-ID: <20190626193438.7248d0a9@archlinux>
In-Reply-To: <20190625131328.11883-2-alexandru.ardelean@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
        <20190625131328.11883-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 16:13:25 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Some devices like the ADIS16460 IMU require a stall period between
> transfers, i.e. between when the CS is de-asserted and re-asserted. The
> default value of 10us is not enough. This change makes the delay
> configurable for when the next CS change goes active.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

General principle seems fine to me, though naming may need some work.

cs_low_time or something more specific than stall perhaps?

+CC Mark.

> ---
>  drivers/spi/spi.c       | 3 ++-
>  include/linux/spi/spi.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 5e75944ad5d1..739de0118ee1 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1163,7 +1163,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>  				keep_cs = true;
>  			} else {
>  				spi_set_cs(msg->spi, false);
> -				udelay(10);
> +				udelay(xfer->cs_change_stall_delay_us ?
> +				       xfer->cs_change_stall_delay_us : 10);
>  				spi_set_cs(msg->spi, true);
>  			}
>  		}
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 053abd22ad31..d23add3b4790 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -734,6 +734,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
>   *      transfer. If 0 the default (from @spi_device) is used.
>   * @bits_per_word: select a bits_per_word other than the device default
>   *      for this transfer. If 0 the default (from @spi_device) is used.
> + * @cs_change_stall_delay_us: microseconds to delay between cs_change
> + * 	transfers.
>   * @cs_change: affects chipselect after this transfer completes
>   * @delay_usecs: microseconds to delay after this transfer before
>   *	(optionally) changing the chipselect status, then starting
> @@ -823,6 +825,7 @@ struct spi_transfer {
>  #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
>  	u8		bits_per_word;
>  	u8		word_delay_usecs;
> +	u8		cs_change_stall_delay_us;
>  	u16		delay_usecs;
>  	u32		speed_hz;
>  	u16		word_delay;

