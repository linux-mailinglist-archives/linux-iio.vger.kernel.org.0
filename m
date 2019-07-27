Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2019C778F1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfG0Nbh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 09:31:37 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:42860 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbfG0Nbh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2019 09:31:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 941819E6A6F;
        Sat, 27 Jul 2019 14:31:34 +0100 (BST)
Date:   Sat, 27 Jul 2019 14:31:33 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration
 API
Message-ID: <20190727143133.26a36f70@archlinux>
In-Reply-To: <CAKKE0ZG9hKqOnPHCfmW8Mpe2tdcdpdv4Njvx7XNuw6ykJf3P0w@mail.gmail.com>
References: <20190726022836.7182-1-hslester96@gmail.com>
        <CAKKE0ZG9hKqOnPHCfmW8Mpe2tdcdpdv4Njvx7XNuw6ykJf3P0w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Jul 2019 14:51:30 +0200
Patrick Havelange <patrick.havelange@essensium.com> wrote:

> Hello,
> 
> On Fri, Jul 26, 2019 at 4:28 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > Make use of devm_counter_register.
> > Then we can remove redundant unregistration API
> > usage to make code simpler.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> > Changes in v2:
> >   - Use devm_add_action_or_reset to keep
> >     resource release order.  
> 
> This is better now indeed.
> 
> However it seems there is an issue with the mail/patch format, I'm
> unable to apply it with git am, and if you look at
> https://lore.kernel.org/patchwork/patch/1105782/ the diff section is
> missing the beginning of the patch. I don't know why, but I think it
> should be looked into.
> 
> Otherwise, it's fine by me.
Hi Patrick,

A formal, Acked-by or Reviewed-by definitely preferred if you are happy
to give one.

This looks fine to me as well. William, if you are happy with the resend
of this, then let me know if you want me to queue it up.

Thanks,

Jonathan

> 
> Regards,
> 
> Patrick Havelange
> 
> 
> >   - _remove() function is redundant now,
> >     delete it.
> >
> >  drivers/counter/ftm-quaddec.c | 31 +++++++++++--------------------
> >  1 file changed, 11 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> > index 68a9b7393457..76c70a6c3593 100644
> > --- a/drivers/counter/ftm-quaddec.c
> > +++ b/drivers/counter/ftm-quaddec.c
> > @@ -100,16 +100,17 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
> >         ftm_set_write_protection(ftm);
> >  }
> >
> > -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> > +static void ftm_quaddec_disable(void *ftm)
> >  {
> > -       ftm_clear_write_protection(ftm);
> > -       ftm_write(ftm, FTM_MODE, 0);
> > -       ftm_write(ftm, FTM_QDCTRL, 0);
> > +       struct ftm_quaddec *ftm_qua = ftm;
> >
> > +       ftm_clear_write_protection(ftm_qua);
> > +       ftm_write(ftm_qua, FTM_MODE, 0);
> > +       ftm_write(ftm_qua, FTM_QDCTRL, 0);
> >         /*
> >          * This is enough to disable the counter. No clock has been
> >          * selected by writing to FTM_SC in init()
> >          */
> > -       ftm_set_write_protection(ftm);
> > +       ftm_set_write_protection(ftm_qua);
> >  }
> >
> >  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> > @@ -316,22 +317,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
> >         mutex_init(&ftm->ftm_quaddec_mutex);
> >
> >         ftm_quaddec_init(ftm);
> > -
> > -       ret = counter_register(&ftm->counter);
> > +       ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
> >         if (ret)
> > -               ftm_quaddec_disable(ftm);
> > -
> > -       return ret;
> > -}
> > -
> > -static int ftm_quaddec_remove(struct platform_device *pdev)
> > -{
> > -       struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> > -
> > -       counter_unregister(&ftm->counter);
> > -
> > -       ftm_quaddec_disable(ftm);
> > +               return ret;
> >
> > +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
> > +       if (ret)
> > +               return ret;
> >         return 0;
> >  }
> >
> > @@ -346,7 +338,6 @@ static struct platform_driver ftm_quaddec_driver = {
> >                 .of_match_table = ftm_quaddec_match,
> >         },
> >         .probe = ftm_quaddec_probe,
> > -       .remove = ftm_quaddec_remove,
> >  };
> >
> >  module_platform_driver(ftm_quaddec_driver);
> > --
> > 2.20.1
> >  

