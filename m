Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F041C360B
	for <lists+linux-iio@lfdr.de>; Mon,  4 May 2020 11:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEDJsL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 4 May 2020 05:48:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbgEDJsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 May 2020 05:48:11 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 0C38444D34ECEEA8F741;
        Mon,  4 May 2020 10:48:10 +0100 (IST)
Received: from localhost (10.47.88.153) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 4 May 2020
 10:48:09 +0100
Date:   Mon, 4 May 2020 10:47:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: accel: kxsd9: Fix alignment of local buffer.
Message-ID: <20200504104750.000073a4@Huawei.com>
In-Reply-To: <8069360d699a6699eb7768a07681c78e4b94b250.camel@gmail.com>
References: <20200503172235.207632-1-jic23@kernel.org>
        <8069360d699a6699eb7768a07681c78e4b94b250.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.88.153]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 May 2020 20:01:56 +0200
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Sun, 2020-05-03 at 18:22 +0100, jic23@kernel.org wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
> > is not guaranteed by an array of 8 __be16.
> > 
> > Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/accel/kxsd9.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> > index 0b876b2dc5bd..4c42d1200914 100644
> > --- a/drivers/iio/accel/kxsd9.c
> > +++ b/drivers/iio/accel/kxsd9.c
> > @@ -209,14 +209,16 @@ static irqreturn_t kxsd9_trigger_handler(int
> > irq, void *p)
> >  	const struct iio_poll_func *pf = p;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct kxsd9_state *st = iio_priv(indio_dev);
> > +	struct {
> > +		__be16 chan[4];
> > +		u64 ts;
> > +	} hw_values;  
> 
> A nitpick from my side. Maybe a comment woudn't be that noisy. It might
> be not that obvious for some people why this construct is needed and it
> might prevent new driver's from doing the same mistake.

Good point. I'll add something like

/* Ensure correct positioning and alignment of timestamp */

above the struct definition.


> 
> - Nuno Sá
> 
> 


