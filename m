Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0881AF22D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgDRQNx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 12:13:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgDRQNx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 12:13:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CE6921D6C;
        Sat, 18 Apr 2020 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587226432;
        bh=KG5kr+r6xfH+Cc2DIMIM2ITLXapR56Y7u44/dQUvWBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w7W9GqsG82j2wtEFwhnIr+opivKUWBuD407VbUOdQ1dtb6eQudNFlRs+j8yZB459m
         4JgZJdCIy9YEm9Fcl+RMOqq7Q8Ffq/Tv/CE3qfTehUaPjFelSsI2gq4KTCiAJETnMi
         DfI0tPDYRKY3+o/3U8mzmNCF75Ri7K3LLARQ6+oM=
Date:   Sat, 18 Apr 2020 17:13:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@engebretsen.ch" <lars@engebretsen.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: core: remove extra semi-colon from
 devm_iio_device_register() macro
Message-ID: <20200418171348.72f9d032@archlinux>
In-Reply-To: <526f58cee9ef50cfb13af4b25d215735985cce9a.camel@analog.com>
References: <20200415101043.32050-1-lars@engebretsen.ch>
        <526f58cee9ef50cfb13af4b25d215735985cce9a.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Apr 2020 11:41:24 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Wed, 2020-04-15 at 12:10 +0200, Lars Engebretsen wrote:
> > This change removes the semi-colon from the devm_iio_device_register()
> > macro which seems to have been added by accident via commit 63b19547cc3d9
> > ("iio: Use macro magic to avoid manual assign of driver_module").
> >   
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

The above reference to where the bug was introduced should have been
a Fixes: tag as that guides where this is backported to.

I made it so whilst applying.

Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> > Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
> > ---
> > Changelog v1 -> v2:
> > * added commit change description
> > 
> >  include/linux/iio/iio.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index d63884a54939..76ba7c9fd3e0 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -597,7 +597,7 @@ void iio_device_unregister(struct iio_dev *indio_dev);
> >   * 0 on success, negative error number on failure.
> >   */
> >  #define devm_iio_device_register(dev, indio_dev) \
> > -	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
> > +	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
> >  int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> >  			       struct module *this_mod);
> >  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);  

