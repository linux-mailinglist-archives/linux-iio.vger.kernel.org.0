Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A939BE3E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jun 2021 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFDROk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Jun 2021 13:14:40 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:34362 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbhFDROj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Jun 2021 13:14:39 -0400
Received: by mail-pj1-f46.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso5453844pjx.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Jun 2021 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w95F0TCzLeYUyJx3fu+VSCdsjxDSdgbGCbx8wXZTDEI=;
        b=VIA2rHpv6cRmQcM/egQjIxPZXzRu0rQqtvtf29M5D7IN8+/HKmi17GDnFtHDg66rV2
         nzeC7Jsw7Z+oojwuSNuvGaER/BJ8U96Vckx52yQy9rj8a0Qi2CcYrCviYB8WCk8hr9ri
         T8pQg4zscXsgnQtv3n/Ej8TQhZ0l1WE9lrSYlP8ARlTFajefOWag+jrn49iiRNSkp2v4
         vU3KrtYn7QSRSLd8UvczPksE2SMpsmMo6lRq0HgIwQL1x3Mlp5ovioGBqq+HQYgu02fR
         l6RnHd0uwSmboAcSVxB/mFTsqU/MqAqh+IwWh0zyZEVQmBQ/V8ip6LCcu42g9slARS5i
         d/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w95F0TCzLeYUyJx3fu+VSCdsjxDSdgbGCbx8wXZTDEI=;
        b=reweycWelDucjynUlkcXmpU7bKmOvePkpMyBL693su0c5nptviHwjM8BdI2pvll8uQ
         9mSJPaBFwhvZ/pAzKNuqIjKrMwsfTCzQvBU7TuVPZJQ1dKSHrb3FZZstNlepguxXs06b
         KOGpeUXIuA8jrNOzborpeaOYl7k7Ttyg7+ZDNN12xGkKH2xoHJz4kks5W8DqYF37my7T
         S4iIANhcQTMgSdOqMokQbWqVIKpRuA3bLFttCYxQo/he7onpUho1hs28l/L4cSTRKBp8
         hBxWkiPnmVqwou5J70Oa59QrlhwHWGl8AGZWToodddiErUwqAP25GymSuc+koHsONzb8
         Ko/A==
X-Gm-Message-State: AOAM531tHHmi++XyUoxKVbMD+CvbnNkTuIAFB0hU2Q1ZdkxV2yo9cZKq
        F+SyIzKwIL303FEbW9G33y0whs5yeK4DvGR6vtQ=
X-Google-Smtp-Source: ABdhPJxOuZAOYPtMCADejI1WZ9Gktdda5aA7z+qVJjL2RWlSeweHmZFjjdEphk6fXtZkCTd72TGelJvnmfmvvjRhQ14=
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr18122832pjw.129.1622826701448;
 Fri, 04 Jun 2021 10:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <YLDbdN688C0xBgMn@mwanda> <20210603173842.5d2b1004@jic23-huawei>
In-Reply-To: <20210603173842.5d2b1004@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Jun 2021 20:11:25 +0300
Message-ID: <CAHp75VfdEBm4H17KcNB0zwOEVnTiLbGpDG=bPzo1HWbKmrg4Uw@mail.gmail.com>
Subject: Re: [bug report] staging:iio:sca3000 extract old event handling and
 move to poll for events from buffer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, jic23@cam.ac.uk,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 3, 2021 at 7:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 28 May 2021 15:00:52 +0300
> Dan Carpenter <dan.carpenter@oracle.com> wrote:

...

> >    733                          *val = (be16_to_cpup((__be16 *)st->rx) >> 3) & 0x1FFF;
> >    734                          *val = ((*val) << (sizeof(*val) * 8 - 13)) >>
> >                                                   ^^^^^^^^^^^^^^^^^^^^^^^
> >    735                                  (sizeof(*val) * 8 - 13);
> >                                         ^^^^^^^^^^^^^^^^^^^^^^^
> >
> > This code works, but it relies on undefined behavior of left shift
> > overflow and it's very unsatisfying.  Pretty sure there is a UBSan
> > warning for this at runtime.
>
> Thanks Dan.  Looks like a slightly odd variant on open coded sign_extend32()
> Should be fine to replace with
>
> *val = sign_extend32(*val, 13);

Oh, indeed.

-- 
With Best Regards,
Andy Shevchenko
