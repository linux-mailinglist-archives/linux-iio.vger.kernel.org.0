Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0E391DB6
	for <lists+linux-iio@lfdr.de>; Wed, 26 May 2021 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhEZRTk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 May 2021 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhEZRTk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 May 2021 13:19:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A0C061574
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 10:18:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3938321pjx.1
        for <linux-iio@vger.kernel.org>; Wed, 26 May 2021 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbcrJw7LhCjT8ZJfIarIciX31puzGnFpaq5Mb7bge08=;
        b=NNI1hmZ0lqWTvQ4DQqslAgOuVG4VScAToqSmKyjSSIdkecZ3fCYrjinD/dsg7xqrnm
         FaFyH+uIM9nZ2AFVi5OsgsYRxM/AfcmBWkDJsKcsVvt7KEjKA4S+yOAC0oOFIkr3eG4Z
         /WhRyd3cMlLBCET5RodDuhXo5AVvgEme/IBwwA/RlZ9Ufbqce+fzYQlMinkWZEMTvidB
         tJCaUfUmp2tiTuHI0wxJUjp47FTRP0UH+gDKLRHKA+58gYaDF/S9lvalOs+7RxdXF8mG
         /i/OVq7WgGYCkNr2Ot9DWG0tU5sg2Tmy7fPYQr6URJckdivEieq91UZPxJAHKaW8h5I6
         DdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbcrJw7LhCjT8ZJfIarIciX31puzGnFpaq5Mb7bge08=;
        b=Nsn55u0VXvuj5I+zWXR/AiYt9rEQvdEsnQqcLpYCqSFSwfJJoXvAjTI0Is3z2DHyGk
         ExxzuZhHM1UPYIgeecehxjDf4+LVKT8Py/ymoVCtgcRZSXGqU66fiv6SWVlPcbzFot5/
         U4dYwN1b5lyuXUT6bPfBUzPPyxiG97q0wDiXGDe8je4ljSkQNWIiSdBfgORANl09eGWt
         KMQDhtvQIwd0qSLKqbXptxV3viInQdoqycJM3kfCB80d1ew18rQz1TFCDsGt/q6DPyAH
         oCYU1uoUax22x/VdCih2bpOj3CuyzNpbUy5Q+cBPZOOg0Cw04YY2FsgEV6nZwNdWKprz
         InPQ==
X-Gm-Message-State: AOAM533RkOvrvS9r11eq6qTwWWsO3OyROV+FtL7WStjHowd/OXd2/ix5
        3vVWjGZNmccZ1VYC+R4AIBQCRu/d62yCX/1ugydcAmAavwA=
X-Google-Smtp-Source: ABdhPJwfamKkhM9Lx/KGaz0Mjfj4jjS6vacGSogJ1SRbmk5B21qWNyXC9wlue+XnzIKNsnB62xnkyHMm/UKbzzTfByY=
X-Received: by 2002:a17:902:a3cb:b029:f0:6ebe:3530 with SMTP id
 q11-20020a170902a3cbb02900f06ebe3530mr37185648plb.21.1622049487841; Wed, 26
 May 2021 10:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210501171352.512953-1-jic23@kernel.org> <20210513185832.515046f9@jic23-huawei>
 <20210526180916.5e253ef3@jic23-huawei>
In-Reply-To: <20210526180916.5e253ef3@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 May 2021 20:17:51 +0300
Message-ID: <CAHp75VfPUxksWU8jyr6eFitFacBgkzTuEpADO4GEV4trgw8mog@mail.gmail.com>
Subject: Re: [PATCH 00/11] IIO: Alignment fixes part 3 - __aligned(8) used to
 ensure alignment
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 26, 2021 at 8:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Thu, 13 May 2021 18:58:32 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
> > On Sat,  1 May 2021 18:13:41 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Thanks to those who have already provided reviews on this set.
> > If anyone has time to do a quick sanity check of the remaining patches
> > it would be much appreciated.  I'll pick up the ones which have been reviewed
> > in a few mins.
> >
> > +Cc Andy who was kind enough to look at the other 'parts' of this mega series.
>
> Anyone bored?  Still looking for a sanity check of the rest of this
> series before I apply it.

Sorry, I have some high priority tasks, and this one is not in the list :-(

-- 
With Best Regards,
Andy Shevchenko
