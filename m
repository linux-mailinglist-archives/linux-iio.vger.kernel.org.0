Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1068A1BBAFA
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD1KQ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 06:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbgD1KQ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 06:16:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0958C03C1A9;
        Tue, 28 Apr 2020 03:16:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s18so7425190pgl.12;
        Tue, 28 Apr 2020 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMjnBAmGgu6XoLQhl6ptyrFCAoyMr8FVl1mKQC6PPaE=;
        b=RncoTczbOdcqMr1ZHkJfFjjB0TySFxQ4a/8qT19W8hFxRJqFCwcm9AzyxUbwKDoXT7
         xYWMguhbPD77QZQ312Y126fgdFaMoOQEYDBcdZPBuzN1mwNHgSWij6w5ig1H8QZKiqKu
         EzQVPOJn2px/+ozTqudMXpPUnJeZQDVPcSdDOsP1KclaC5P7lKI2/HgeiF5zkm/ibKl6
         DpilYpsf4DH9GgRl7Boq1vyTOz/EAgrOXhsGHXy1ztGWKjfggVEHNTipZuoE2xwESXjq
         1706dZ9KMUtqdzKy0UnnO3IGZtmrYRigiXwqV8HNsO0XLnB89VoN1X3TrJqhS+Zy+PYj
         dL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMjnBAmGgu6XoLQhl6ptyrFCAoyMr8FVl1mKQC6PPaE=;
        b=e0qFp2/aT3QfnGBJPjYr3KdPjkc5yNXCvX4naCiJVBSL0xfn9UfI2GvT9SQPEqZKHL
         a4rqvaWgMAkxDTw1kYOmuIKqUxBf4JAyR9TFdwQbwd+NHq6oCvW9lazFugCJ1SYodlqX
         7tx4Ax4KKBZytbzxKjuGyrMyzRqpG/yacV2v6lTmAl0OBbhLw1qc7RJo5yiwSJ3PMMBL
         I/oqDw5aprHZzrwBU9stAT85peUcw1qxjHjlS7rR5Fj61Bq8cwwne4Kyqgp5RKzJf7W7
         MoJq65qleP/q8bho0YHl7KDYqLk5sm5mlQW5n2gCcLgKqKgTI5mBrlW/o7PNKOCv31Dj
         buYQ==
X-Gm-Message-State: AGi0PuYsZfCh8CRGIGLU5FH6H60tgba+6kpE34vxpAN0MyT7LS9B0TU/
        88HEepFzlzR4ZR2iJTiXZlN5+HoL4ySSBU80aBs=
X-Google-Smtp-Source: APiQypLjwqT3Evw7cs2eSptlYQM/hGNM8/iUGajRjMjhIp6HGHqaheczoeJmTSjtV9L+Y2DRDj5i3DuQvRUZCDBD4wU=
X-Received: by 2002:a62:f908:: with SMTP id o8mr28487450pfh.170.1588069018490;
 Tue, 28 Apr 2020 03:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-2-tomasz.duszynski@octakon.com> <CAHp75VcbaGYj76qkDJnTnuG5SM215qVmFo7FLR6YzHA37PgF_g@mail.gmail.com>
 <20200424190413.GA2731@arch> <CAHp75Vdajf7Ci3ytxP7Qs9=fFaxvVBQoL5uh+HUDwxHS5r9MUg@mail.gmail.com>
 <20200425184130.GA37271@arch> <CAHp75Vez8wSaYHbXmvfXUS5N+vScQqHGg055DNKrEnCunP7awA@mail.gmail.com>
 <20200428075606.GB6908@arch>
In-Reply-To: <20200428075606.GB6908@arch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Apr 2020 13:16:47 +0300
Message-ID: <CAHp75VdKqVvJg7T=42w1SzKSDbfWjYKMomgQBshiMAW=_e0y_w@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: chemical: scd30: add core driver
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 28, 2020 at 10:57 AM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> On Sat, Apr 25, 2020 at 09:52:25PM +0300, Andy Shevchenko wrote:
> > On Sat, Apr 25, 2020 at 9:42 PM Tomasz Duszynski
> > <tomasz.duszynski@octakon.com> wrote:
> > > On Sat, Apr 25, 2020 at 02:43:35PM +0300, Andy Shevchenko wrote:
> > > > On Fri, Apr 24, 2020 at 10:05 PM Tomasz Duszynski
> > > > <tomasz.duszynski@octakon.com> wrote:
> > > > > On Wed, Apr 22, 2020 at 10:49:44PM +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Apr 22, 2020 at 5:22 PM Tomasz Duszynski
> > > > > > <tomasz.duszynski@octakon.com> wrote:
> >
> > ...
> >
> > > > > As for ABI that's in
> > > > > a separate patch.
> > > >
> > > > It's not good from bisectability point of view. If by some reason this
> > > > patch or documentation patch gets reverted, the other one will be
> > > > dangling.
> > > > Please, unify them.
> > > >
> > >
> > > Huh? Reverting core and leaving leftovers would be wrong and pointless.
> >
> > Exactly my point why it should be one patch. To secure impossibility
> > to do pointless reverts.
> >
>
> But the same applies to other driver parts like i2c or serial
> interfaces. I don't buy it.

They won't compile without core driver, right? Absence of the
documentation OTOH doesn't prevent build.


-- 
With Best Regards,
Andy Shevchenko
