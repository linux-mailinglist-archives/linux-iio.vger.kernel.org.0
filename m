Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B27B2352DF
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHAPBh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 11:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgHAPBg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 11:01:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718E92071E;
        Sat,  1 Aug 2020 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596294096;
        bh=EPYZ0iW9XYWW4u3IIeCtf7nBGEINcN0i9JroAJkPJqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=14NtLxV6Pf8Po3/PrklE7N44vxtfIJ94zmervvOVoND6+AwX56TUWfviMfys3Cagu
         XihOmaNlbOMikdptk6CRSEgjIcBo4w0MBu7t+XUoSckjW5RV/tZfAZ1zsUykvtaqBb
         xywHgV57Dsdi27WJBSbHXhXvg74JL5ZDqvuWWhvo=
Date:   Sat, 1 Aug 2020 16:01:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 15/15] iio: sx9310: Use irq trigger flags from
 firmware
Message-ID: <20200801160131.0ed25e71@archlinux>
In-Reply-To: <CAHp75Vcyv_sbgEWEzFeSnmoMzQqrS+obogKJhjPajX1FDutF4w@mail.gmail.com>
References: <20200731164853.3020946-1-campello@chromium.org>
        <20200731104555.v3.15.I4c344a6793007001bbb3c1c08e96d3acf893b36b@changeid>
        <CAHp75Vcyv_sbgEWEzFeSnmoMzQqrS+obogKJhjPajX1FDutF4w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 31 Jul 2020 22:46:55 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jul 31, 2020 at 7:49 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > From: Stephen Boyd <swboyd@chromium.org>
> >
> > We shouldn't need to set default irq trigger flags here as the firmware
> > should have properly indicated the trigger type, i.e. level low, in the
> > DT or ACPI tables.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Other than the two patches I replied to the rest look good to me.

Thanks,

Jonathan
 
> 
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Daniel Campello <campello@chromium.org>
> > ---
> >
> > Changes in v3:
> >  - Added irq trigger flags commit to the series.
> >
> > Changes in v2: None
> >
> >  drivers/iio/proximity/sx9310.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index a20cd6a4dad729..c41fa7f6558e3f 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -951,7 +951,7 @@ static int sx9310_probe(struct i2c_client *client)
> >                 ret = devm_request_threaded_irq(dev, client->irq,
> >                                                 sx9310_irq_handler,
> >                                                 sx9310_irq_thread_handler,
> > -                                               IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +                                               IRQF_ONESHOT,
> >                                                 "sx9310_event", indio_dev);
> >                 if (ret)
> >                         return ret;
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >  
> 
> 

