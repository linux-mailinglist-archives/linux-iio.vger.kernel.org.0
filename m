Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E5C1A5DE4
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 11:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgDLJtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 05:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgDLJtX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 05:49:23 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DBA20656;
        Sun, 12 Apr 2020 09:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586684963;
        bh=9dZKptuiNTHdZxjCXWjSzuUjbeubIVuHTS3wtQMfUAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P212LBTyLJRuBfpKwsNOmFVZMJUCRWuoSAnNo3xY3w7ymQXdrHNbjy4IatCOWr13K
         KGMehHS4+1hdJLlFhUf3rURcupP6CMFMojrO/6sP60W4vd3v6/+hlF/Q4RNKPPjrXk
         oZmbNaXzumxs0GsADx2cZyPP1LbSNNIehltZSkZI=
Date:   Sun, 12 Apr 2020 10:49:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     yarl-baudig@mailoo.org
Cc:     linux-iio@vger.kernel.org, "Hartmut Knaack" <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        "Denis Ciocca" <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: st_sensors: rely on odr mask to know if odr can be
 set
Message-ID: <20200412104918.36e17c3f@archlinux>
In-Reply-To: <ea-mime-5e91df36-2302-7e2b01aa@www-2.mailo.com>
References: <ea-mime-5e91df36-2302-7e2b01aa@www-2.mailo.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 11 Apr 2020 17:16:06 +0200 (CEST)
yarl-baudig@mailoo.org wrote:

> Indeed, relying on addr being not 0 cannot work because some device have
> their register to set odr at address 0. As a matter of fact, if the odr
> can be set, then there is a mask.
> 
> Sensors with ODR register at address 0 are: lsm303dlh, lsm303dlhc, lsm303dlm
> 
> Fixes: 7d245172675a ("iio: common: st_sensors: check odr address value in st_sensors_set_odr()")
> Signed-off-by: Lary Gibaud <yarl-baudig@mailoo.org>
Applied to the fixes-togreg branch of iio.git and marked for
stable.

Thanks,

Jonathan

> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index a0c2cbd60c6f..cccd4c26dfa4 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -79,7 +79,7 @@ int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
>  	struct st_sensor_odr_avl odr_out = {0, 0};
>  	struct st_sensor_data *sdata = iio_priv(indio_dev);
>  
> -	if (!sdata->sensor_settings->odr.addr)
> +	if (!sdata->sensor_settings->odr.mask)
>  		return 0;
>  
>  	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);

