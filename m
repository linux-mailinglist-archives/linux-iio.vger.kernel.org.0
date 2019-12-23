Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE58129850
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 16:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLWPfC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 10:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfLWPfC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 10:35:02 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E5C20709;
        Mon, 23 Dec 2019 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577115301;
        bh=KIKztsRKJ8+aAb7aYAXZt35d+6eBHAR0m3tck32QDe8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iRbypylPNeDGwPZAH8QcQG/Tfp1JFzb3JOGn7O/qrT4YKDDe/24+B3bh/4ImoqQ1v
         KVdXOvxbfJzRkSZQEHQJpoxonzj2KosUrvACvCPMjn9v/9G78Y/Y7nDLv9hUhC70sh
         RoNaMiFgQ/msF3JyjQnt/xMocNjyUdaT1Yg0TsJY=
Date:   Mon, 23 Dec 2019 15:34:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "djunho@gmail.com" <djunho@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] iio: adc: ad7923: Remove the unused defines
Message-ID: <20191223153456.084b6f10@archlinux>
In-Reply-To: <ce7183bb25c987687a130cb7541a2552cebbf213.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
        <20191217111158.30888-2-djunho@gmail.com>
        <ce7183bb25c987687a130cb7541a2552cebbf213.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 11:29:57 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-12-17 at 08:11 -0300, Daniel Junho wrote:
> > Removes the unused define AD7923_CHANNEL_x from the code.
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> 
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> > ---
> >  drivers/iio/adc/ad7923.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 3212eb4c0f25..969c06b7d2b7 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -29,10 +29,6 @@
> >  #define AD7923_PM_MODE_AS	(1)		/* auto shutdown */
> >  #define AD7923_PM_MODE_FS	(2)		/* full shutdown */
> >  #define AD7923_PM_MODE_OPS	(3)		/* normal operation */
> > -#define AD7923_CHANNEL_0	(0)		/* analog input 0 */
> > -#define AD7923_CHANNEL_1	(1)		/* analog input 1 */
> > -#define AD7923_CHANNEL_2	(2)		/* analog input 2 */
> > -#define AD7923_CHANNEL_3	(3)		/* analog input 3 */
> >  #define AD7923_SEQUENCE_OFF	(0)		/* no sequence fonction
> > */
> >  #define AD7923_SEQUENCE_PROTECT	(2)		/* no interrupt
> > write cycle */
> >  #define AD7923_SEQUENCE_ON	(3)		/* continuous sequence */  

