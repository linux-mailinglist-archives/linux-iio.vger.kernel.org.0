Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7D2E713D
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 14:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL2N7M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 08:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgL2N7L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 08:59:11 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E13C9207B6;
        Tue, 29 Dec 2020 13:58:29 +0000 (UTC)
Date:   Tue, 29 Dec 2020 13:58:27 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: vl6180: Use DIV_ROUND_CLOSEST() instead of
 open-coding it
Message-ID: <20201229135827.0632a2db@archlinux>
In-Reply-To: <20201228055830.GA9634@thinkpad>
References: <20201227171126.28216-1-lars@metafoo.de>
        <20201228055830.GA9634@thinkpad>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Dec 2020 11:28:30 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Sun, Dec 27, 2020 at 06:11:24PM +0100, Lars-Peter Clausen wrote:
> > Use DIV_ROUND_CLOSEST() instead of open-coding it. This documents intent
> > and makes it more clear what is going on for the casual reviewer.
> > 
> > Generated using the following the Coccinelle semantic patch.
> > 
> > // <smpl>
> > @r1@
> > expression x;
> > constant C1;
> > constant C2;
> > @@
> >  ((x) + C1) / C2
> > 
> > @script:python@
> > C1 << r1.C1;
> > C2 << r1.C2;
> > @@
> > try:
> > 	if int(C1) * 2 != int(C2):
> > 		cocci.include_match(False)
> > except:
> > 	cocci.include_match(False)
> > 
> > @@
> > expression r1.x;
> > constant r1.C1;
> > constant r1.C2;
> > @@
> > -(((x) + C1) / C2)
> > +DIV_ROUND_CLOSEST(x, C2)
> > // </smpl>
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
Series applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to work their magic.

Thanks,

Jonathan

> Thanks,
> Mani
> 
> > ---
> >  drivers/iio/light/vl6180.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> > index 4775bd785e50..d47a4f6f4e87 100644
> > --- a/drivers/iio/light/vl6180.c
> > +++ b/drivers/iio/light/vl6180.c
> > @@ -392,7 +392,7 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
> >  {
> >  	int ret, it_ms;
> >  
> > -	it_ms = (val2 + 500) / 1000; /* round to ms */
> > +	it_ms = DIV_ROUND_CLOSEST(val2, 1000); /* round to ms */
> >  	if (val != 0 || it_ms < 1 || it_ms > 512)
> >  		return -EINVAL;
> >  
> > -- 
> > 2.20.1
> >   

