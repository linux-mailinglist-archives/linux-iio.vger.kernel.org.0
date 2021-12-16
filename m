Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1DB47719A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Dec 2021 13:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhLPMYt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Dec 2021 07:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhLPMYt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Dec 2021 07:24:49 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F329C061574
        for <linux-iio@vger.kernel.org>; Thu, 16 Dec 2021 04:24:49 -0800 (PST)
Received: from [81.101.6.87] (port=52568 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxpoS-0004Ep-Ep; Thu, 16 Dec 2021 12:24:45 +0000
Date:   Thu, 16 Dec 2021 12:30:07 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     "Tanislav, Cosmin" <Cosmin.Tanislav@analog.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: addac: ad74413r: fix off by one in
 ad74413r_parse_channel_config()
Message-ID: <20211216122956.69da41f3@jic23-huawei>
In-Reply-To: <45dd874f40e54872b4c94e00eae814c4@analog.com>
References: <20211215115053.GE14552@kili>
        <45dd874f40e54872b4c94e00eae814c4@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 10:50:41 +0000
"Tanislav, Cosmin" <Cosmin.Tanislav@analog.com> wrote:

> Reviewed-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Applied, thanks,

Jonathan

> 
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> > Sent: Wednesday, December 15, 2021 1:51 PM
> > To: Tanislav, Cosmin <Cosmin.Tanislav@analog.com>
> > Cc: Hennerich, Michael <Michael.Hennerich@analog.com>; Jonathan
> > Cameron <jic23@kernel.org>; Linus Walleij <linus.walleij@linaro.org>; linux-
> > iio@vger.kernel.org; kernel-janitors@vger.kernel.org
> > Subject: [PATCH] iio: addac: ad74413r: fix off by one in
> > ad74413r_parse_channel_config()
> > 
> > [External]
> > 
> > The > needs to be >= to prevent accessing one element beyond the end of
> > the st->channel_configs[] array.
> > 
> > Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Obligatory grumble:  When you merge a new driver please use a patch
> > prefix based on what the driver will use.
> > 
> >  Bad: [SUBJECT] subsystem: add new driver for XYZ123
> > Good: [SUBJECT] subsystem/xyz123: add new driver for XYZ123
> > 
> > Same rule for adding subdirectories.  That way no one (me) has to guess.
> > 
> >  drivers/iio/addac/ad74413r.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> > index cbd9aa9b399a..289d254943e1 100644
> > --- a/drivers/iio/addac/ad74413r.c
> > +++ b/drivers/iio/addac/ad74413r.c
> > @@ -1150,7 +1150,7 @@ static int ad74413r_parse_channel_config(struct
> > iio_dev *indio_dev,
> >  		return ret;
> >  	}
> > 
> > -	if (index > AD74413R_CHANNEL_MAX) {
> > +	if (index >= AD74413R_CHANNEL_MAX) {
> >  		dev_err(st->dev, "Channel index %u is too large\n", index);
> >  		return -EINVAL;
> >  	}
> > --
> > 2.20.1  
> 

