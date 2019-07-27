Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4777AF9
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbfG0SNy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 14:13:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41928 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0SNy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2019 14:13:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so15897873pgg.8;
        Sat, 27 Jul 2019 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KudokdeWksX2KTcgdc0MeUt0GwdNoB2VgHFoQuVls38=;
        b=nQXwig4zQmD99sf+XxuEWKrlfQJgS8/wh6mMH2+5UUBNS6CXjacRHKfVqylA5w4QW/
         5hgL0TeH5DskP0E/Fh1hm+4HBBbmSJ54zH1ZfPRFEH3ztEqEmTAw9+F+8+RSMNDn7vQY
         CI+77tLwAgyRris7xXvSqe2sla0j/1ZI3oxSeDZOEuDKnhlw1WBdDR4U/pLspA2kBeSk
         BOYSFwIplp4w5DEIcswuiE8iO6cIlRgXaY4bgmA2VK7ZZnRIIC2s5tJRQUF2ErGj2Pr9
         GNrslYJA3Vass1btcwgsOUlHQgZud91qzKm4c5VTNOsbpIoAfIYe2Eszzv3RoQ4PcQAw
         FZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KudokdeWksX2KTcgdc0MeUt0GwdNoB2VgHFoQuVls38=;
        b=SEa1vuUwthJQ8ES68eC0DIOqAH8+XiFScedDmaP+9KCBkminvTl1TR1zAK+su28Px+
         2c+5JzUPmtnivGDpIWaXxePEYPm7eJjqd3RJMh46DvJITgRV88Agoo38f+LFgYUEH89u
         RnvfBafv3/HUww/sa8EvUnRqppRBEBrjI2NED/+eoUqffVi/KnhrAiqjsGg5WfCpp3kR
         GFsa9GrYrnGL3PjgLEl5nRnq03t7+B94dDkfruFv82dYoOYv2gpGUC6NdPR1ocVC+JaP
         yLaM8JAIcPWPkTkLABxjLfK6aNFNSSGKNbUuq9yOhSIbWUJlpipTfOFo2MrSqfJe7jua
         vX+g==
X-Gm-Message-State: APjAAAX/DMnJMXfrDW8n8HW1nRitBkie/C5JFgSxdbUXmfpjfNoZUKBe
        qBOpCESrsEXqxCSVmlWTJJA=
X-Google-Smtp-Source: APXvYqwkBIpp207fOU6iSHRK0JGP62kGoN/F1p5es87bhqdyGLZQVW0zGQm9qC4H0+n6p7Gz+wPb2A==
X-Received: by 2002:a63:20d:: with SMTP id 13mr86219735pgc.253.1564251232713;
        Sat, 27 Jul 2019 11:13:52 -0700 (PDT)
Received: from icarus ([2001:268:c145:e06d:4405:959a:d2f8:aa9a])
        by smtp.gmail.com with ESMTPSA id 195sm96201191pfu.75.2019.07.27.11.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 11:13:51 -0700 (PDT)
Date:   Sun, 28 Jul 2019 03:13:33 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>,
        Chuhong Yuan <hslester96@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] counter/ftm-quaddec: Use device-managed registration
 API
Message-ID: <20190727181333.GA2820@icarus>
References: <20190726022836.7182-1-hslester96@gmail.com>
 <CAKKE0ZG9hKqOnPHCfmW8Mpe2tdcdpdv4Njvx7XNuw6ykJf3P0w@mail.gmail.com>
 <20190727143133.26a36f70@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190727143133.26a36f70@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 27, 2019 at 02:31:33PM +0100, Jonathan Cameron wrote:
> On Fri, 26 Jul 2019 14:51:30 +0200
> Patrick Havelange <patrick.havelange@essensium.com> wrote:
> 
> > Hello,
> > 
> > On Fri, Jul 26, 2019 at 4:28 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> > >
> > > Make use of devm_counter_register.
> > > Then we can remove redundant unregistration API
> > > usage to make code simpler.
> > >
> > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > ---
> > > Changes in v2:
> > >   - Use devm_add_action_or_reset to keep
> > >     resource release order.  
> > 
> > This is better now indeed.
> > 
> > However it seems there is an issue with the mail/patch format, I'm
> > unable to apply it with git am, and if you look at
> > https://lore.kernel.org/patchwork/patch/1105782/ the diff section is
> > missing the beginning of the patch. I don't know why, but I think it
> > should be looked into.
> > 
> > Otherwise, it's fine by me.
> Hi Patrick,
> 
> A formal, Acked-by or Reviewed-by definitely preferred if you are happy
> to give one.
> 
> This looks fine to me as well. William, if you are happy with the resend
> of this, then let me know if you want me to queue it up.
> 
> Thanks,
> 
> Jonathan

I'm all right with these changes too. Feel free to queue up the resend
version in your tree when you are ready.

William Breathitt Gray

> 
> > 
> > Regards,
> > 
> > Patrick Havelange
> > 
> > 
> > >   - _remove() function is redundant now,
> > >     delete it.
> > >
> > >  drivers/counter/ftm-quaddec.c | 31 +++++++++++--------------------
> > >  1 file changed, 11 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> > > index 68a9b7393457..76c70a6c3593 100644
> > > --- a/drivers/counter/ftm-quaddec.c
> > > +++ b/drivers/counter/ftm-quaddec.c
> > > @@ -100,16 +100,17 @@ static void ftm_quaddec_init(struct ftm_quaddec *ftm)
> > >         ftm_set_write_protection(ftm);
> > >  }
> > >
> > > -static void ftm_quaddec_disable(struct ftm_quaddec *ftm)
> > > +static void ftm_quaddec_disable(void *ftm)
> > >  {
> > > -       ftm_clear_write_protection(ftm);
> > > -       ftm_write(ftm, FTM_MODE, 0);
> > > -       ftm_write(ftm, FTM_QDCTRL, 0);
> > > +       struct ftm_quaddec *ftm_qua = ftm;
> > >
> > > +       ftm_clear_write_protection(ftm_qua);
> > > +       ftm_write(ftm_qua, FTM_MODE, 0);
> > > +       ftm_write(ftm_qua, FTM_QDCTRL, 0);
> > >         /*
> > >          * This is enough to disable the counter. No clock has been
> > >          * selected by writing to FTM_SC in init()
> > >          */
> > > -       ftm_set_write_protection(ftm);
> > > +       ftm_set_write_protection(ftm_qua);
> > >  }
> > >
> > >  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> > > @@ -316,22 +317,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
> > >         mutex_init(&ftm->ftm_quaddec_mutex);
> > >
> > >         ftm_quaddec_init(ftm);
> > > -
> > > -       ret = counter_register(&ftm->counter);
> > > +       ret = devm_add_action_or_reset(&pdev->dev, ftm_quaddec_disable, ftm);
> > >         if (ret)
> > > -               ftm_quaddec_disable(ftm);
> > > -
> > > -       return ret;
> > > -}
> > > -
> > > -static int ftm_quaddec_remove(struct platform_device *pdev)
> > > -{
> > > -       struct ftm_quaddec *ftm = platform_get_drvdata(pdev);
> > > -
> > > -       counter_unregister(&ftm->counter);
> > > -
> > > -       ftm_quaddec_disable(ftm);
> > > +               return ret;
> > >
> > > +       ret = devm_counter_register(&pdev->dev, &ftm->counter);
> > > +       if (ret)
> > > +               return ret;
> > >         return 0;
> > >  }
> > >
> > > @@ -346,7 +338,6 @@ static struct platform_driver ftm_quaddec_driver = {
> > >                 .of_match_table = ftm_quaddec_match,
> > >         },
> > >         .probe = ftm_quaddec_probe,
> > > -       .remove = ftm_quaddec_remove,
> > >  };
> > >
> > >  module_platform_driver(ftm_quaddec_driver);
> > > --
> > > 2.20.1
> > >  
> 
