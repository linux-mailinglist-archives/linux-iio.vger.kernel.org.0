Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B266C17CDF1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 13:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCGMCp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 07:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgCGMCp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 07:02:45 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4049C2075A;
        Sat,  7 Mar 2020 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583582564;
        bh=h4LZiNlY3M3sfJcyIUQooDL+8Nx54UuhSZVLawI2IaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I6UAesuHdH6qF8zX7LQ0XU5iEMsIHKT9nMdjZGlwPHWOG2EfHZTgIAOcA6ku2QDOP
         IbKT75AAckhh6mPgGlCBkb3baDr+9x2CtSx3Esey7qWu/mWMHQ32rNBdwCl0leH5SL
         tOMLAvaMLI/oSxgvhxF14mlNkBlnx1Dk6KV5BiKc=
Date:   Sat, 7 Mar 2020 12:02:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] iio: accel: adxl372: Add support for FIFO peak
 mode
Message-ID: <20200307120241.7bee0dc8@archlinux>
In-Reply-To: <20200225120909.12629-2-alexandru.tachici@analog.com>
References: <20200225120909.12629-1-alexandru.tachici@analog.com>
        <20200225120909.12629-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 14:09:04 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> By default, if all three channels (x, y, z) are enabled, sample sets of
> concurrent 3-axis data is stored in the FIFO. This patch adds the option
> to configure the FIFO to store peak acceleration (x, y and z) of every
> over-threshold event. Since we cannot store 1 or 2 axis peak acceleration
> data in the FIFO, then all three axis need to be enabled in order for this
> mode to work.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

First apologies this was one of the sets that I didn't get to last week.

This is a bit of an odd one, but I suppose the general approach is fine.

A few questions on specifics inline.

> ---
>  drivers/iio/accel/adxl372.c | 46 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 67b8817995c0..ed93534f8dba 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -264,6 +264,7 @@ struct adxl372_state {
>  	u8				int2_bitmask;
>  	u16				watermark;
>  	__be16				fifo_buf[ADXL372_FIFO_SIZE];
> +	bool				peak_fifo_mode_en;
>  };
>  
>  static const unsigned long adxl372_channel_masks[] = {
> @@ -722,6 +723,40 @@ static int adxl372_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static ssize_t adxl372_peak_fifo_en_get(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct adxl372_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%d\n", st->peak_fifo_mode_en);
> +}
> +
> +static ssize_t adxl372_peak_fifo_en_set(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +	bool val;
> +	int ret;
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;

Prefer if you use the iio_claim_direct_mode to ensure we are in
non buffered mode until we reach a consistent state.  Then set
the variable and release direct mode.

Otherwise you might have a race between a write
to this and enabling the buffered mode.

> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	st->peak_fifo_mode_en = val;
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(buffer_peak_mode_enable, 0644,
> +		       adxl372_peak_fifo_en_get,
> +		       adxl372_peak_fifo_en_set, 0);
> +
>  static ssize_t adxl372_show_filter_freq_avail(struct device *dev,
>  					      struct device_attribute *attr,
>  					      char *buf)
> @@ -817,11 +852,21 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
>  	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
>  					  indio_dev->masklength);
> +
> +	/* Configure the FIFO to store sets of impact event peak. */
> +	if (st->peak_fifo_mode_en) {
> +		st->fifo_format = ADXL372_XYZ_PEAK_FIFO;
> +		if (st->fifo_set_size != 3)
> +			dev_warn(&indio_dev->dev,
> +				 "All axis must be enabled in peak mode.");

What happens otherwise?  Real question is should this just be an error and
result in us dropping out of buffered mode again?  How would a userspace
program that had hit this know there was an issue?

> +	}
> +
>  	/*
>  	 * The 512 FIFO samples can be allotted in several ways, such as:
>  	 * 170 sample sets of concurrent 3-axis data
>  	 * 256 sample sets of concurrent 2-axis data (user selectable)
>  	 * 512 sample sets of single-axis data
> +	 * 170 sets of impact event peak (x, y, z)
>  	 */
>  	if ((st->watermark * st->fifo_set_size) > ADXL372_FIFO_SIZE)
>  		st->watermark = (ADXL372_FIFO_SIZE  / st->fifo_set_size);
> @@ -894,6 +939,7 @@ static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
>  static struct attribute *adxl372_attributes[] = {
>  	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_buffer_peak_mode_enable.dev_attr.attr,
>  	NULL,
>  };
>  

