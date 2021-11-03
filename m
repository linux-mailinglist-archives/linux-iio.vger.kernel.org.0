Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B85044481A
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 19:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhKCSU6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Nov 2021 14:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhKCSU4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 14:20:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B4C861053;
        Wed,  3 Nov 2021 18:18:18 +0000 (UTC)
Date:   Wed, 3 Nov 2021 18:22:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Martin Fuzzey <mfuzzey@parkeon.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: mma8452: Use correct type for return variable in
 IRQ handler
Message-ID: <20211103182253.663977a4@jic23-huawei>
In-Reply-To: <CAHp75VfiZOhjTLKPt_b3mTP2KsGMuFqPWk2oG0wX_oC5EognCQ@mail.gmail.com>
References: <20211101102734.32291-1-lars@metafoo.de>
        <CAHp75VfiZOhjTLKPt_b3mTP2KsGMuFqPWk2oG0wX_oC5EognCQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 1 Nov 2021 12:37:19 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Nov 1, 2021 at 12:28 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> >
> > The IRQ handler's return type is irqreturn_t. The mma8452 uses a variable
> > to store the return value, but the variable is of type int. Change this to
> > irqreturn_t. This makes it easier to verify that the code is correct.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied. Thanks,
> 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  drivers/iio/accel/mma8452.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index 09c7f10fefb6..64b82b4503ad 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -1053,7 +1053,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
> >  {
> >         struct iio_dev *indio_dev = p;
> >         struct mma8452_data *data = iio_priv(indio_dev);
> > -       int ret = IRQ_NONE;
> > +       irqreturn_t ret = IRQ_NONE;
> >         int src;
> >
> >         src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
> > --
> > 2.20.1
> >  
> 
> 

