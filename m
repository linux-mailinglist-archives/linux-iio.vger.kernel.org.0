Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB2A36347B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 11:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhDRJp6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 05:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhDRJp6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 05:45:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4000861029;
        Sun, 18 Apr 2021 09:45:26 +0000 (UTC)
Date:   Sun, 18 Apr 2021 10:45:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>, Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] iio: proximity: pulsedlight: Fix rumtime PM
 imbalance on error
Message-ID: <20210418104556.6cac5f30@jic23-huawei>
In-Reply-To: <CAHp75Vch8zrFmRQNkXE1HopPN_JBsNYfuRDpPN-W0m74OE7fhQ@mail.gmail.com>
References: <20210412053204.4889-1-dinghao.liu@zju.edu.cn>
        <CAHp75Vch8zrFmRQNkXE1HopPN_JBsNYfuRDpPN-W0m74OE7fhQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 12:23:43 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Apr 12, 2021 at 8:32 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> >
> > When lidar_write_control() fails, a pairing PM usage counter
> > decrement is needed to keep the counter balanced.  
> 
> You forgot to collect given tags.
> 
> > Fixes: 4ac4e086fd8c5 ("iio: pulsedlight-lidar-lite: add runtime PM")
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

I gathered up the tags by hand and applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

> > ---
> >
> > Changelog:
> >
> > v2: - Add the fix tag.
> > ---
> >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > index c685f10b5ae4..cc206bfa09c7 100644
> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > @@ -160,6 +160,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
> >         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
> >         if (ret < 0) {
> >                 dev_err(&client->dev, "cannot send start measurement command");
> > +               pm_runtime_put_noidle(&client->dev);
> >                 return ret;
> >         }
> >
> > --
> > 2.17.1
> >  
> 
> 

