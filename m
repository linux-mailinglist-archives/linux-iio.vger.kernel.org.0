Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0156430B3E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 19:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbhJQRfD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 13:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344366AbhJQRfC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 13:35:02 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98E460FDC;
        Sun, 17 Oct 2021 17:32:51 +0000 (UTC)
Date:   Sun, 17 Oct 2021 18:37:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] iio: accel: sca3000: Use sign_extend32() instead of
 opencoding sign extension.
Message-ID: <20211017183705.472210ba@jic23-huawei>
In-Reply-To: <2c475dda-829f-3d7d-da0f-91a4aee1bee8@metafoo.de>
References: <20211017160303.72441-1-jic23@kernel.org>
        <2c475dda-829f-3d7d-da0f-91a4aee1bee8@metafoo.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Oct 2021 19:17:26 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/17/21 6:03 PM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst nice to get rid of this non obvious code, this also clears a
> > static checker warning:
> >
> > drivers/iio/accel/sca3000.c:734 sca3000_read_raw()
> > warn: no-op. '((*val) << 19) >> 19'
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de

Added missing > to your tag and applied.  Thanks

Jonathan

> 
> > ---
> > v2:
> > Use the right sign bit (thanks Lars!)
> > Should be bit 12 for a 13 bit value.
> >
> >   drivers/iio/accel/sca3000.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> > index cb753a43533c..c6b75308148a 100644
> > --- a/drivers/iio/accel/sca3000.c
> > +++ b/drivers/iio/accel/sca3000.c
> > @@ -731,8 +731,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
> >   				return ret;
> >   			}
> >   			*val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> > -			*val = ((*val) << (sizeof(*val) * 8 - 13)) >>
> > -				(sizeof(*val) * 8 - 13);
> > +			*val = sign_extend32(*val, 12);
> >   		} else {
> >   			/* get the temperature when available */
> >   			ret = sca3000_read_data_short(st,  
> 
> 

