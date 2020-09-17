Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B126E326
	for <lists+linux-iio@lfdr.de>; Thu, 17 Sep 2020 20:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIQSES (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Sep 2020 14:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgIQSCu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Sep 2020 14:02:50 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F392A20707;
        Thu, 17 Sep 2020 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600365768;
        bh=IlmibjKQkOmSNFpp1XnRSGcMC89RPmFcnnpLMx/wp0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C746T6UP/gIDzLvo4LwVDxv7RS8k9I6Wbxmi6UZ58u7sO1QQy100V9cSNumlRE8BL
         vLNGDUC8Pslt0kl2Dn6C6Wboy32penimsopDGpD5UpmQb4jrg6aNSBcqRkAt4wifpP
         YPYJ5OisuklT9XIBt+rQ7090ct2MDQgJdCDjOqP8=
Date:   Thu, 17 Sep 2020 19:02:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 1/3] iio:imu:adis16400: Sort out missing kernel doc.
Message-ID: <20200917190243.0d7e7feb@archlinux>
In-Reply-To: <CA+U=DsougYec6z-4qmbuKE8XkFzB2PUwwmxPGoUtcN+5cDep4Q@mail.gmail.com>
References: <20200913132115.800131-1-jic23@kernel.org>
        <20200913132115.800131-2-jic23@kernel.org>
        <CA+U=DsougYec6z-4qmbuKE8XkFzB2PUwwmxPGoUtcN+5cDep4Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Sep 2020 08:52:34 +0300
Alexandru Ardelean <ardeleanalex@gmail.com> wrote:

> On Sun, Sep 13, 2020 at 4:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > I'd like to be enable W=1 for all IIO builds as it catches real issues as well
> > as more minor documentation issues such as this (also good to fix though!)
> >
> > drivers/iio/imu/adis16400.c:183: warning: Function parameter or member 'avail_scan_mask' not described in 'adis16400_state'
> >  
> 
> Acked-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git
Thanks,

Jonathan

> > ---
> >  drivers/iio/imu/adis16400.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> > index 1ebe3e50d3e6..140cfc65ee8c 100644
> > --- a/drivers/iio/imu/adis16400.c
> > +++ b/drivers/iio/imu/adis16400.c
> > @@ -173,6 +173,8 @@ struct adis16400_chip_info {
> >   * @variant:   chip variant info
> >   * @filt_int:  integer part of requested filter frequency
> >   * @adis:      adis device
> > + * @avail_scan_mask:   NULL terminated array of bitmaps of channels
> > + *                     that must be enabled together
> >   **/
> >  struct adis16400_state {
> >         struct adis16400_chip_info      *variant;
> > --
> > 2.28.0
> >  

