Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA881C2DEA
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgECQZd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 12:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgECQZd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 12:25:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF13C061A0E;
        Sun,  3 May 2020 09:25:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z1so4346920pfn.3;
        Sun, 03 May 2020 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3PY0NJ7YL1BNARD0oetT7jynu4pCokp1u8ZAvx5dx4=;
        b=uHgi4jckBb1RaPiRnyys/tkc39VdwZl7c3o+IQlNjugZL8FZYQn75n77dVAU+bCjLs
         9eq7vhb99S00JA58zhzo13ohJMlwEbJdqDhuTNmc5DU689eE2JcVK+RF0JiWICCLhu0A
         GBe6DRYG28uXIsb1t/ZrAvcbvJl3sIECsWP8CQl+yhrMfPsWqemHwMPB5zCnyQ0nwK/C
         WCifDlVGNcjT5mugw7i1kzvwXWF7hVJt5rkIiplYpFSCYtMKxC+qxXUUgbioH3kuJz7D
         M6yqH+t3dFiLUWQjFrbF/2/464jS+nZBjqD+pa0QWNy2bomD6btiMSyLt0X6kuEkYcrV
         Sx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3PY0NJ7YL1BNARD0oetT7jynu4pCokp1u8ZAvx5dx4=;
        b=Zxqoe0thq5IvgKsDln3YVt1hmDG+YmqsiMUgKXQy5dW89gn9VjT5Q3wZPInZw44oRC
         Sy7onZBaSXu0FF1F1HKtUoT3ygOuRuUS99vxEl6eiIAQbUk2CLst0rPgd2JhMQA2lRyV
         Ry9W472ySzCqqThCcgbDa/uncVSpLNJC7XgjnMOlDYA7v3chRByZWQh+5jelSAbqqQMT
         E4PqTpaXsQcyrOW+Id9nQFUnSljPEswPC13SRfqWTN3yfE6++U/YcPilCJYD5gZdqR7a
         2vWjtBYsUC+CDQu44KDn/d3/2S0qg2lfRpAGY2yYSoTP5/U77q2XYvG/SdE+YYSFdb+v
         DOYA==
X-Gm-Message-State: AGi0PuYDHjnM98xf4V8rrBJ1FJ6nCh3EzHf3OIxb4T2bpvf3fi/go+Ln
        Mn+pglBtX/yoJRNfqE0kCvTb5bpg4Pj+DSYo+3I=
X-Google-Smtp-Source: APiQypIdkxCKDQcOl5esMtYineYHmnfKgOTXof+YtrxX0N/0Q0zcOtHVkEZH2obVS8ilArA2woICWcXUSh4qFjhVf9I=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr13829522pgb.203.1588523132175;
 Sun, 03 May 2020 09:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200428172923.567806-1-hdegoede@redhat.com> <20200428172923.567806-10-hdegoede@redhat.com>
 <20200503122237.4af34181@archlinux>
In-Reply-To: <20200503122237.4af34181@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 May 2020 19:25:20 +0300
Message-ID: <CAHp75Vdt+shL3yXHfct17DUHdRBBrCzC4vBjQL8YHbimFefV7A@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] iio: light: cm32181: Add support for parsing
 CPM0 and CPM1 ACPI tables
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 3, 2020 at 2:22 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 28 Apr 2020 19:29:22 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:

...

> > This was tested on the following models: Acer Switch 10 SW5-012 (CM32181)
> > Asus T100TA (CM3218), Asus T100CHI (CM3218) and HP X2 10-n000nd (CM32181).
>
> I assume it's far too much to hope this CPM0 / CPM1 stuff is actually defined
> in a spec anywhere?
>
> There are standard way of adding vendor specific data blobs to ACPI and this
> isn't one of them (unless I'm missing something).  People need to beat
> up vendors earlier about this stuff.
>
> Grumble over...
>
> Code looks fine to me, but I'd like an ACPI review ideally.

ACPI didn't cover embedded world and has the following issues
a) where it should be strict (like how many I2CSerialBus() resources
can be given and for what type of devices, etc), it doesn't
b) they need to provides better validation tools, but they didn't
c) it's still windows oriented :-(

Above is custom extension on how to add device properties (and note,
we have now _DSD() and still we have some M$ way of thinking how to
use them).

Since the above approach is in the wild, I'm afraid we have not many
possibilities here (each of them with own problems):
1/ shout at vendors to use ACPI properly and simple don't by broken
hardware (rather firmware)
2/ try to support custom changes (may lead to several approaches for
the same thing)
3/ create a lot of board files (something in between 1/ and 2/)

As a result:
1/ is obviously a best one, but I think it's an utopia.
2/ in practice we don't have many deviations (luckily OEMs are quite
lazy to modify reference BIOSes and often reuse existing approaches)
3/ may not work, because on cheap laptops the means of distinguishing
them (like DMI strings) may also been broken.

-- 
With Best Regards,
Andy Shevchenko
