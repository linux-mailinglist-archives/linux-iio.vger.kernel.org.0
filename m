Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACF31DFF6D
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgEXOkQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 10:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgEXOkQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 10:40:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08DD220776;
        Sun, 24 May 2020 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590331215;
        bh=yIEzDF2w5ilFnOwqdE4xr2Y3GrRHLVbBFfvKp7lg9hc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=stuMDjGMEGFTLy9DGuMHqcr02NzpDu1aTYlU9SLaVwST3Z/A3JAlr5gTmXVJEYZzo
         AfZcw4sRJP/5tcGFMwKdads0Bcpizt7VJt6VoT6arnpJz/Us2GCg08hTqmkzW2D3Ki
         TUrKlPFnYJosPF17vrC4zq44gRdvxvM1U6oT+vxU=
Date:   Sun, 24 May 2020 15:40:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: iqs621: remove usage of iio_priv_to_dev()
Message-ID: <20200524154012.057eb118@archlinux>
In-Reply-To: <20200523015635.GB2690@labundy.com>
References: <20200522065442.10203-1-alexandru.ardelean@analog.com>
        <20200523015635.GB2690@labundy.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 20:56:35 -0500
Jeff LaBundy <jeff@labundy.com> wrote:

> Hi Alexandru,
> 
> On Fri, May 22, 2020 at 09:54:42AM +0300, Alexandru Ardelean wrote:
> > We may want to get rid of the iio_priv_to_dev() helper. That's a bit
> > uncertain at this point. The reason is that we will hide some of the
> > members of the iio_dev structure (to prevent drivers from accessing them
> > directly), and that will also mean hiding the implementation of the
> > iio_priv_to_dev() helper inside the IIO core.
> > 
> > Hiding the implementation of iio_priv_to_dev() implies that some fast-paths
> > may not be fast anymore, so a general idea is to try to get rid of the
> > iio_priv_to_dev() altogether.
> > 
> > For this driver, removing iio_priv_to_dev() means keeping a reference
> > on the state struct.
> > 
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/iio/light/iqs621-als.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)  
> 
> As with the iqs624 patch:
> 
> Acked-by: Jeff LaBundy <jeff@labundy.com>

Applied. thanks,

J
> 
> > 
> > diff --git a/drivers/iio/light/iqs621-als.c b/drivers/iio/light/iqs621-als.c
> > index b2988a782bd0..1a056e2446ab 100644
> > --- a/drivers/iio/light/iqs621-als.c
> > +++ b/drivers/iio/light/iqs621-als.c
> > @@ -36,6 +36,7 @@
> >  
> >  struct iqs621_als_private {
> >  	struct iqs62x_core *iqs62x;
> > +	struct iio_dev *indio_dev;
> >  	struct notifier_block notifier;
> >  	struct mutex lock;
> >  	bool light_en;
> > @@ -103,7 +104,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
> >  
> >  	iqs621_als = container_of(notifier, struct iqs621_als_private,
> >  				  notifier);
> > -	indio_dev = iio_priv_to_dev(iqs621_als);
> > +	indio_dev = iqs621_als->indio_dev;
> >  	timestamp = iio_get_time_ns(indio_dev);
> >  
> >  	mutex_lock(&iqs621_als->lock);
> > @@ -191,7 +192,7 @@ static int iqs621_als_notifier(struct notifier_block *notifier,
> >  static void iqs621_als_notifier_unregister(void *context)
> >  {
> >  	struct iqs621_als_private *iqs621_als = context;
> > -	struct iio_dev *indio_dev = iio_priv_to_dev(iqs621_als);
> > +	struct iio_dev *indio_dev = iqs621_als->indio_dev;
> >  	int ret;
> >  
> >  	ret = blocking_notifier_chain_unregister(&iqs621_als->iqs62x->nh,
> > @@ -551,6 +552,7 @@ static int iqs621_als_probe(struct platform_device *pdev)
> >  
> >  	iqs621_als = iio_priv(indio_dev);
> >  	iqs621_als->iqs62x = iqs62x;
> > +	iqs621_als->indio_dev = indio_dev;
> >  
> >  	if (iqs62x->dev_desc->prod_num == IQS622_PROD_NUM) {
> >  		ret = regmap_read(iqs62x->regmap, IQS622_IR_THRESH_TOUCH,
> > -- 
> > 2.25.1
> >   
> 
> Kind regards,
> Jeff LaBundy

