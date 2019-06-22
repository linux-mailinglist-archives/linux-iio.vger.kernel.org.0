Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949444F55C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfFVKuD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 06:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKuD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 06:50:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5840206BA;
        Sat, 22 Jun 2019 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561200602;
        bh=empjxPu8SsPeZWYlamH2w2qbDYzgpb7mlY50YBuii+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XxhLLw+2ySAWCPIbpfBkkc+fAGgM/syE0Cc2z/oQnjD04UL9oPPL8UMpiMzwYA1Zh
         H+qx7+B6zU4O4hEbZ4V1c4tzO3wmFvsqXiNhq+rC1UmyaBuvUaK888tXCXAt/sNpOB
         e961B0XYKfIXzf1kCRF8me6guJlVP+f6SpU9QlfE=
Date:   Sat, 22 Jun 2019 11:49:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis Ciocca <denis.ciocca@st.com>
Cc:     <linux-iio@vger.kernel.org>, <lorenzo@kernel.org>
Subject: Re: [PATCH 7/7] iio:common: make st_sensors_write_data_with_mask()
 inline
Message-ID: <20190622114958.3e09f1ff@archlinux>
In-Reply-To: <20190617234943.10669-8-denis.ciocca@st.com>
References: <20190617234943.10669-1-denis.ciocca@st.com>
        <20190617234943.10669-8-denis.ciocca@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 16:49:43 -0700
Denis Ciocca <denis.ciocca@st.com> wrote:

> Instead of changing all the references in the driver, let's make the
> function inline.
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Hmm. I suspect we'll pay the price for this bit of indirection at
some point.  Perhaps a follow up series to remove this function entirely
in favour of direct call to the regmap equivalent?

Jonathan
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 3ddab3ca0a4b..fe67349309de 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -26,7 +26,7 @@ static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
>  	return (s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8;
>  }
>  
> -int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
> +inline int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
>  				    u8 reg_addr, u8 mask, u8 data)
>  {
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);

