Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D403A19EB0A
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDEL5H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 07:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgDEL5H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 07:57:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF94206C3;
        Sun,  5 Apr 2020 11:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586087826;
        bh=2HOY5Wb+r91rJ6WjRl7tk1TFhokciJiNPDrq55j3rNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1YYopDom8pa3UVHQzdIoBheja5EiPHsP+lC6ffPXs5NiH7lIyCDs921xmB5p1Rjmy
         pZ5RqAK4YQsOublgCo29j86MfTSH+cRgmBL8GvCxWl28uMCPCuNfljcrnkP8sW6aF3
         JpQbkrjPepKh3OEtoqF/ap4crdJes1tXX93RwJUA=
Date:   Sun, 5 Apr 2020 12:57:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     yarl-baudig@mailoo.org
Cc:     linux-iio@vger.kernel.org, "Hartmut Knaack" <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        "Denis Ciocca" <denis.ciocca@st.com>
Subject: Re: [PATCH] iio: st_sensors: rely on odr mask to know if odr can be
 set
Message-ID: <20200405125702.2e72981c@archlinux>
In-Reply-To: <ea-mime-5e85eb6b-6be-7ee474a6@www-2.mailo.com>
References: <ea-mime-5e85eb6b-6be-7ee474a6@www-2.mailo.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Apr 2020 15:40:59 +0200 (CEST)
yarl-baudig@mailoo.org wrote:

> Indeed, relying on addr being not 0 cannot work because some device have
> their register to set odr at address 0. As a matter of fact, if the odr
> can be set, then there is a mask.

Hi Lary,

Which sensor has ODR in the register at address 0?

I see it's a few of the magnetometers from a quick grep, but please state
it in the cover letter.  Also please add a suitable Fixes tag
as we will want this backported if appropriate.

Thanks,

Jonathan

> 
> Signed-off-by: Lary Gibaud <yarl-baudig@mailoo.org>
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

