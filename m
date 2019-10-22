Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9930E0334
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfJVLlu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 07:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbfJVLlu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 22 Oct 2019 07:41:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A64E3207FC;
        Tue, 22 Oct 2019 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571744509;
        bh=XHVq6IxuiT8pWTrmGBnGNAyevVR++yH0jKbzxaPazmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tcOp/mhwTQB0OwGM54t1qrtd2BnR3pwF4jB7QiWDUjgA/+byIqQdhO1q1vDA30vuH
         ouxP8kZt0tRFgBlxmGjpRCa5DNO47gC+/hWx+yv1DOnU+aH7h1O18xOs8jF1p3c9Va
         4iaHzeA2gWciOm/zBkdHwvpu1DFFAo43jmmVC5G0=
Date:   Tue, 22 Oct 2019 12:41:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Brauchli <a.brauchli@elementarea.net>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: chemical: sgp30: drop excess semicolon
Message-ID: <20191022124145.333998a0@archlinux>
In-Reply-To: <f7b5a222c49f82f0555eed514a95a0720f01caf1.camel@elementarea.net>
References: <20191013165412.2090798-1-jic23@kernel.org>
        <f7b5a222c49f82f0555eed514a95a0720f01caf1.camel@elementarea.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Oct 2019 10:51:35 +0200
Andreas Brauchli <a.brauchli@elementarea.net> wrote:

> ACK, lgtm. Thanks for forwarding.
> 
> 
> On Sun, 2019-10-13 at 17:54 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Suggested by coccinelle / coccicheck.
> > 
> > CHECK   drivers/iio/chemical/sgp30.c
> > drivers/iio/chemical/sgp30.c:486:2-3: Unneeded semicolon
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Andreas Brauchli <a.brauchli@elementarea.net>  
> 
> Signed-off-by: Andreas Brauchli <a.brauchli@elementarea.net>
Applied.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/chemical/sgp30.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/chemical/sgp30.c
> > b/drivers/iio/chemical/sgp30.c
> > index 8cc8fe5e356d..403e8803471a 100644
> > --- a/drivers/iio/chemical/sgp30.c
> > +++ b/drivers/iio/chemical/sgp30.c
> > @@ -483,7 +483,7 @@ static void sgp_init(struct sgp_data *data)
> >  		data->iaq_defval_skip_jiffies =
> >  			43 * data->measure_interval_jiffies;
> >  		break;
> > -	};
> > +	}
> >  }
> >  
> >  static const struct iio_info sgp_info = {  
> 

