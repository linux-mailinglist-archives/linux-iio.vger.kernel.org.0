Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55A270DD7
	for <lists+linux-iio@lfdr.de>; Sat, 19 Sep 2020 14:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgISMKy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Sep 2020 08:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgISMKy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 19 Sep 2020 08:10:54 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83C2206A2;
        Sat, 19 Sep 2020 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600517453;
        bh=AWmjGFPcM825VcLESspjkYndAPbrod8sAERkSkEfCo8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fp1nph95GYGzhDsBA4qggSc+WbbEqxwinec4+MDcIbT3zIhMbp6lYX6XoG6irnCVu
         Ql8cuEaTFbFBdX9XP+lOczDSLaOAonfcuQHki+RrDPiQVMRJx7JYlHusKfmrDMp6z7
         0Ok31yMDSA9ZpwTlrvOpHCCSk2m8PLKSkpxPBdjY=
Date:   Sat, 19 Sep 2020 13:10:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by
 enum required.
Message-ID: <20200919131049.24dfaa15@archlinux>
In-Reply-To: <CAJCx=g=wrvEaE-Pwuy0KmtSux8Sgeiu9p3EfHdfwCV4xQGGUKw@mail.gmail.com>
References: <20200913112546.715624-1-jic23@kernel.org>
        <CAJCx=g=wrvEaE-Pwuy0KmtSux8Sgeiu9p3EfHdfwCV4xQGGUKw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Sep 2020 12:15:20 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Sep 13, 2020 at 4:27 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > So it's obvious that the code is wrong in passing true, but I'm assuming
> > that will actually evaluate to 1 and hence IIO_SHARED_BY_TYPE.
> > The documentation however has this attribute as IIO_SHARED_BY_ALL.
> > My current assumption is the documentation is wrong.
> > If anyone knows otherwise please shout out!
> >  
> 
> Yeah this is much easier to understand than the odd boolean value.
> 
> Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>
> 
Thanks all.

Applied to the togreg branch of iio.git. I've not marked it for
stable as it has no functional affect.

Jonathan

> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Fixes: 7247645f6865 ("iio: hmc5843: Move hmc5843 out of staging")
> > Cc: H. Nikolaus Schaller <hns@goldelico.com>
> > ---
> >  drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> > index 1474ba63babe..780faea61d82 100644
> > --- a/drivers/iio/magnetometer/hmc5843_core.c
> > +++ b/drivers/iio/magnetometer/hmc5843_core.c
> > @@ -245,7 +245,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
> >  };
> >
> >  static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
> > -       IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
> > +       IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
> >         IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
> >         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> >         { }
> > @@ -259,7 +259,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
> >  };
> >
> >  static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
> > -       IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
> > +       IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
> >         IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
> >         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
> >         { }
> > --
> > 2.28.0
> >  

