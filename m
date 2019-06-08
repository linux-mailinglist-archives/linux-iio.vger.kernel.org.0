Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557A339FBB
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFHMzf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 08:55:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfFHMzf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 Jun 2019 08:55:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9A320693;
        Sat,  8 Jun 2019 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559998534;
        bh=p2NCf0jMssirxVmY432skP1dkZI53iZ0AVyuUW1pQ9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mBmZZH2wSMUJkshP96rmxOVlLesKh2PKZ6cNWzVtGrUxcO4rMHyzuY/5V/sYAnswZ
         PutMmwsi2zGnF1u5pn/yXCla0FyQyjUq032DcCoavOireesd2LYC77CrDSdZgXEHQA
         LsVo/g4TK/RhLx5RafByQpTF3JJPK0iwoszAdMBs=
Date:   Sat, 8 Jun 2019 13:55:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "92siuyang@gmail.com" <92siuyang@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] iio:core: Fix bug in length of event info_mask and
 catch unhandled bits set in masks.
Message-ID: <20190608135529.4d5fb4ef@archlinux>
In-Reply-To: <b422a132f5e4db9d4e4079963e52e1031e2f30e6.camel@analog.com>
References: <1559652000-18333-1-git-send-email-92siuyang@gmail.com>
        <b422a132f5e4db9d4e4079963e52e1031e2f30e6.camel@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Jun 2019 08:59:10 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2019-06-04 at 20:40 +0800, Young Xiao wrote:
> > [External]
> > 
> > 
> > The incorrect limit for the for_each_set_bit loop was noticed whilst fixing
> > this other case.  Note that as we only have 3 possible entries a the moment
> > and the value was set to 4, the bug would not have any effect currently.
> > It will bite fairly soon though, so best fix it now.
> > 
> > See commit ef4b4856593f ("iio:core: Fix bug in length of event info_mask and
> > catch unhandled bits set in masks.") for details.
> > 
> > Signed-off-by: Young Xiao <92siuyang@gmail.com>  
> 
> Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> Thanks for this patch.
> This fix is validated also by the fact that iio_device_add_info_mask_type() has this check on the same iteration.

I don't think it is technically a bug, as the higher bits should never be set.
Still it is a sensible bit of hardening so applied to the togreg branch of iio.git
and pushed out as testing.

Thanks

Jonathan


> 
> 
> > ---
> >  drivers/iio/industrialio-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index f5a4581..dd8873a 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -1107,6 +1107,8 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
> >         char *avail_postfix;
> > 
> >         for_each_set_bit(i, infomask, sizeof(*infomask) * 8) {
> > +               if (i >= ARRAY_SIZE(iio_chan_info_postfix))
> > +                       return -EINVAL;
> >                 avail_postfix = kasprintf(GFP_KERNEL,
> >                                           "%s_available",
> >                                           iio_chan_info_postfix[i]);
> > --
> > 2.7.4
> >   

