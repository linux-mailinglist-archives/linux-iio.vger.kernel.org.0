Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE47273177
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgIUSGb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 14:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgIUSGb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 14:06:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37186206FB;
        Mon, 21 Sep 2020 18:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600711590;
        bh=beRQspo4pEm2yDYU/CJTnj6WANeVzFLoFcVOy7uOyIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=htqhNwYbfBJSG6nzayGs4O2BNvCjuim8K+QSep+HUS5AFfXQfmU4i1LpUimI+TKu+
         njtqTPjaW8bp3qFKYbo00J+ckraSPwPA649XjA9svD5A0rKpazLl0nfrOt+ZxCqMqm
         OEqFOn+flk3DstojMEq++4u3/WGea8oK0I0zzlp8=
Date:   Mon, 21 Sep 2020 19:06:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by
 enum required.
Message-ID: <20200921190627.68b83b6e@archlinux>
In-Reply-To: <D0CE59F2-8E2A-494C-B6A1-C8B4AA011AC0@goldelico.com>
References: <20200913112546.715624-1-jic23@kernel.org>
        <D0CE59F2-8E2A-494C-B6A1-C8B4AA011AC0@goldelico.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Sep 2020 19:12:47 +0200
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> > Am 13.09.2020 um 13:25 schrieb Jonathan Cameron <jic23@kernel.org>:
> > 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > So it's obvious that the code is wrong in passing true, but I'm assuming
> > that will actually evaluate to 1 and hence IIO_SHARED_BY_TYPE.
> > The documentation however has this attribute as IIO_SHARED_BY_ALL.
> > My current assumption is the documentation is wrong.
> > If anyone knows otherwise please shout out!
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Fixes: 7247645f6865 ("iio: hmc5843: Move hmc5843 out of staging")
> > Cc: H. Nikolaus Schaller <hns@goldelico.com>  
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> 
> on GTA04 (omap3-gta04.dtsi).
Thanks, that's great.  Added the tag and re-pushed as testing for the
autobuilders to work their magic.

Thanks,

Jonathan

> 
> > ---
> > drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> > index 1474ba63babe..780faea61d82 100644
> > --- a/drivers/iio/magnetometer/hmc5843_core.c
> > +++ b/drivers/iio/magnetometer/hmc5843_core.c
> > @@ -245,7 +245,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
> > };
> > 
> > static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
> > -	IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
> > +	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
> > 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
> > 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> > 	{ }
> > @@ -259,7 +259,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
> > };
> > 
> > static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
> > -	IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
> > +	IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
> > 	IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
> > 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> > 	{ }
> > -- 
> > 2.28.0
> >   
> 

