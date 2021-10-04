Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C170042176B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhJDT3M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 Oct 2021 15:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234888AbhJDT3M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Oct 2021 15:29:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D95D61215;
        Mon,  4 Oct 2021 19:27:21 +0000 (UTC)
Date:   Mon, 4 Oct 2021 20:31:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max1027: fix error code in max1027_wait_eoc()
Message-ID: <20211004203120.36e890cf@jic23-huawei>
In-Reply-To: <20211004161711.26e6065e@xps13>
References: <20211004134454.GA11689@kili>
        <20211004161711.26e6065e@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 4 Oct 2021 16:17:11 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hello,
> 
> dan.carpenter@oracle.com wrote on Mon, 4 Oct 2021 16:44:54 +0300:
> 
> > Return -ETIMEDOUT on timeout instead of success.
> > 
> > Fixes: 54f14be01e17 ("iio: adc: max1027: Use the EOC IRQ when populated for single reads")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/iio/adc/max1027.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> > index 45dc8a625fa3..4daf1d576c4e 100644
> > --- a/drivers/iio/adc/max1027.c
> > +++ b/drivers/iio/adc/max1027.c
> > @@ -286,7 +286,7 @@ static int max1027_wait_eoc(struct iio_dev *indio_dev)
> >  						  msecs_to_jiffies(1000));
> >  		reinit_completion(&st->complete);
> >  		if (!ret)
> > -			return ret;
> > +			return -ETIMEDOUT;  
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Applied to the togreg branch of iio.git.

As this is the only patch I've applied today I've just pushed it out directly
for next to pick up rather than going through the normal initial push to testing
for 0-day. 

Thanks,

Jonathan

> 
> >  	} else {
> >  		if (indio_dev->active_scan_mask)
> >  			conversion_time *= hweight32(*indio_dev->active_scan_mask);  
> 
> 
> Thanks,
> Miquèl

