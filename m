Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968B91D8773
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgERSqy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 14:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgERSqy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 14:46:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D0CC061A0C;
        Mon, 18 May 2020 11:46:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l17so13088288wrr.4;
        Mon, 18 May 2020 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ajUUjOWwQ0DqJ5ZMnnC6t+z/SimK+2ZbwTZGGdO/CyY=;
        b=K8f12VYSqcYyx6phIY6bXX4cN19vPs+9Uv3zg4VH/KQLBDMIpN/gXJkbIqO62vycJm
         j4tySzxQ4pTnKNepWLErP8Tg/BIQKvFoZsnMB4EHYWT/4D+7NzzHWZ61w3HHKNVMdJjW
         +96ktIxV7En7owWoDOkgYD9KtTHxtF5aOHj2e86DgYnDR0siDem+KecZ3irdnVPD0OGc
         MLLznwbf5tGlHLDCcEyp71fOZk8VWrgXXyDCminnWSMaeAYjo2TQ9ze+86Ue+uKewDQo
         0LWewLgJQjScPAEXskYZTdLxg7jnfjxXgeaJlcM8yNd4uojxe4nj27etFHAGgYFZ4hRj
         ZXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ajUUjOWwQ0DqJ5ZMnnC6t+z/SimK+2ZbwTZGGdO/CyY=;
        b=VJmBMnQmhPmcK+KvDMsfMPsDBRiTmZdNdxOFceDn+dmJMKcs4gEUCdUntFw67dioqp
         mU0PSOGhdGkKldTrCfAmOEzsdISjQTNQdJYlQ0c/oYq849GSSo8OsIFWnNI7nODVogCg
         dW59kclh/trILf1Cvrr7k76B6udUmPWCAsl42gdIEvPK7xhCFsHnS3OwrHP3ByxCLWep
         LbnyMhjkRsLwD6Sl5xtXqh7Gp9ctWY9tScyiJq/in+/mAJHX0QrlmfkFEwK+6oUcQ59J
         cLPSipZp28dhIqKeeqQz46H+G42ym6YDU0+htzQs5gWS2ebpEF2HnfY1TrLOuSespPpk
         O9tQ==
X-Gm-Message-State: AOAM530eFpBYrMvxWp9OmVK2KGbQ3PMiVTc4ZOAawRY0FouWI1iv8o+P
        QunPAxkRtjHpfO+Ht/UTeJQ=
X-Google-Smtp-Source: ABdhPJyVxBQA1CZQZ8/AbVOfq9TLfBCWGWupFjnKvhmwIohuaUM1Sh1TfEZUavn0bjGxZmtn19VJJQ==
X-Received: by 2002:a5d:6a01:: with SMTP id m1mr22282524wru.64.1589827612345;
        Mon, 18 May 2020 11:46:52 -0700 (PDT)
Received: from jonathan-N53SV ([151.81.99.112])
        by smtp.gmail.com with ESMTPSA id l11sm595119wmf.28.2020.05.18.11.46.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 11:46:50 -0700 (PDT)
Date:   Mon, 18 May 2020 20:46:47 +0200
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200518184647.GB6392@jonathan-N53SV>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
 <20200518133645.19127-4-jonathan.albrieux@gmail.com>
 <CAHp75VdFJUNOtRyCNEGnvoOCZYoPvyhjC15_iC72JD-1sOavwA@mail.gmail.com>
 <20200518160120.GA21361@ict14-OptiPlex-980>
 <20200518164317.GL1634618@smile.fi.intel.com>
 <20200518174335.GA6392@jonathan-N53SV>
 <CAHp75VcJ+LU_T4jRVNDBed50xaALDLNC_8brxszv5FpUGHF7+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcJ+LU_T4jRVNDBed50xaALDLNC_8brxszv5FpUGHF7+A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 08:51:29PM +0300, Andy Shevchenko wrote:
> On Mon, May 18, 2020 at 8:43 PM Jonathan Albrieux
> <jonathan.albrieux@gmail.com> wrote:
> >
> > On Mon, May 18, 2020 at 07:43:17PM +0300, Andy Shevchenko wrote:
> > > On Mon, May 18, 2020 at 06:01:20PM +0200, Jonathan Albrieux wrote:
> > > > On Mon, May 18, 2020 at 05:55:51PM +0300, Andy Shevchenko wrote:
> > > > > On Mon, May 18, 2020 at 4:38 PM Jonathan Albrieux
> > > > > <jonathan.albrieux@gmail.com> wrote:
> > > > >
> > > > > > +       gpiod_set_value_cansleep(data->reset_gpiod, 1);
> > > > >
> > > > > (1)
> > > > >
> > > > > ...
> > > > >
> > > > > > +       /*
> > > > > > +        * If reset pin is provided then will be set to high on power on
> > > > > > +        * and to low on power off according to AK09911 datasheet
> > > > > > +        */
> > > > >
> > > > > Wording is confusing, perhaps you have to use 'asserted / deasserted'.
> > > >
> > > > Thank you for the suggestion, I'll be working on rewording as soon as
> > > > possible.
> > > >
> > > > > Btw, in (1) it's also "high" (asserted). I barely understand how it's
> > > > > supposed to work in all cases?
> > > > >
> > > > > > +       reset_gpiod = devm_gpiod_get_optional(&client->dev,
> > > > > > +                                             "reset", GPIOD_OUT_HIGH);
> > > > > > +       if (IS_ERR(reset_gpiod))
> > > > > > +               return PTR_ERR(reset_gpiod);
> > > > >
> > > >
> > > > I'm sorry but I'm not sure about what you mean by saying all cases.
> > > > Currently  I'm testing this driver on a msm8916 device having AK09911
> > > > magnetometer. At the current stage the driver is failing on probe
> > > > because reset pin is not connected to VID (as datasheet requires in case
> > > > of pin not being used). In case of reset pin not asserted, register's
> > > > reset is triggered resulting in empty registers, leading to probe fail.
> > > > For this reason pin is asserted during power on in order to have
> > > > informations in registers and deasserted before power off triggering
> > > > a reset.
> > > >
> > > > A workaround that gets AK09911 working on device is by setting the
> > > > reset pin always high on device tree. This way registers gets reset by
> > > > a Power On Reset circuit autonomously and reset pin never triggers the
> > > > reset.
> > >
> > > You need to distinguish electrical level from logical (GPIO flag defines
> > > logical). So, I'm talking about active-high vs. active-low case.
> > >
> > > Now I re-read above, and see that here you assert the reset signal. But where
> > > is desertion?
> >
> > Oh I see, I'll try explaining by points the proposed approach:
> > - reset pin is active low
> > - during power on gpio is set to 0 so the reset pin is high, thus no reset
> 
> deasserted
> 
> > - during power off gpio is set to 1 so the reset pin becomes low, thus resetting
> 
> asserted
> 
> > this is a possible solution but maybe there are other ways to achieve that,
> > do you have suggestions on how to get a better approach for solving this issue?
> 
> I see now, that at requesting reset you wanted to chip be in reset
> state (asserted) till driver calls power_on().
> 
> Seems everything you done is correct. Just correct terminology, please.

Will surely do, thank you!
 
> -- 
> With Best Regards,
> Andy Shevchenko

Best regards,
Jonathan Albrieux
