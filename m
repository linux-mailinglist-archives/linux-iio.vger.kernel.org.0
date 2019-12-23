Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC7129852
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 16:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfLWPfZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 10:35:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWPfZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Dec 2019 10:35:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A210B20709;
        Mon, 23 Dec 2019 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577115324;
        bh=2Jh0dISSDe2QoB33eSLMydJsq/0U3Z7o/AyumMVclwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ExXdx2Q2nHPZ9ULQTDREGE/IL/rEDmTqfR8h6zTDeGdq5ofho36I7ccTx/HmhQAXZ
         S1zE/BgjsB4DxMEF++Dk04WFQyuysExjf7Wzk3H4lUDN/M9dsT47k0lW/20FeWQUDW
         KgRDTJ0SBc7bw9Y3fwH2pxlDbyKLnAQcLgedq/w0=
Date:   Mon, 23 Dec 2019 15:35:18 +0000
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
Subject: Re: [PATCH v3 2/4] iio: adc: ad7923: Fix checkpatch warning
Message-ID: <20191223153518.5ae7cb6e@archlinux>
In-Reply-To: <d2d3c5ce9015d00c5b3c82bfffd3f3e03b4246b7.camel@analog.com>
References: <20191217111158.30888-1-djunho@gmail.com>
        <20191217111158.30888-3-djunho@gmail.com>
        <d2d3c5ce9015d00c5b3c82bfffd3f3e03b4246b7.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 17 Dec 2019 11:30:09 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-12-17 at 08:11 -0300, Daniel Junho wrote:
> > Fix checkpatch warning:
> > WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> > +static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied,

Thanks,

Jonathan

> 
> > Signed-off-by: Daniel Junho <djunho@gmail.com>
> > ---
> >  drivers/iio/adc/ad7923.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 969c06b7d2b7..e535cec9fc02 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -184,7 +184,7 @@ static irqreturn_t ad7923_trigger_handler(int irq,
> > void *p)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)
> > +static int ad7923_scan_direct(struct ad7923_state *st, unsigned int ch)
> >  {
> >  	int ret, cmd;
> >    

