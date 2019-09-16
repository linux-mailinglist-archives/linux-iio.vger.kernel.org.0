Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF46B35AC
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfIPHew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:34:52 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51020 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfIPHew (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:34:52 -0400
Received: by mail-wm1-f42.google.com with SMTP id 5so3008167wmg.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Sep 2019 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lHktDqWbDz7Ugjktd0ZEXu1AgKUzM+BIT6jmfOHzGyU=;
        b=eT5gXoyUqLs0ST9a1TvF8A2zMyri6B52IgkBouG3RrAtnrZfLE3w06VjMnzbJM4Win
         dT8y0kKFaUTn94tepfBQJ5h+UrOLw7TSXB0Wr3Ze6jjyXLw/tW7RT7oUmudP+MsKx9kL
         lxH1ZXfszMCChMOGx5GYnM51XRPgOqHtrEIbpnuLrkTPNJhiJXF4nKmK2jIv2lPBRSp/
         06w9FHtqnem0zgfSmaFmavCoh30ZGqzFHwJ1wltez+utYdOFO+e+IJDNi0COdNLqLEfF
         5LuwxkAe9e9QjHOiR2CQ49fYDj7XyMHrLYcypJSMA4dULTbZxmrolxghC13nbsd4YvIW
         ucDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lHktDqWbDz7Ugjktd0ZEXu1AgKUzM+BIT6jmfOHzGyU=;
        b=KldnzFBL6j6+PgLlugYI8ugowKf2842bmy3Nlnmi6UJ0SNTa+VTB/xUvZxS9zaCCy9
         Z9V9959UN4cduMML+SmV0nm/jKso22bvDdLdU5aQKj9PXrUEwPOZ6E/Ie1wv7tZ63gij
         Js9G4m1LYVd9FhahkI1rUuGa7skFKs/VOu6ZuBdrZhK1cz16Ada7ThS08P1YK16EWRGC
         MQ2kJ9kqUxu1jp0vXCWEr+b5SzvUH34Z6N2+lawemLKZKBGC1dXzJMSeVji7SIxbyoCm
         rDLR2Bj0C1Jtls3P+wVhpprwX30j0u0hb/LAnAK/1aKSo8tYO2oGH3zjGgyPcQIBYY1z
         JCcg==
X-Gm-Message-State: APjAAAXi3/wlDd0W6eLYQCOSSQ1ntGY4TxATJV9vT24FOWAViplsXHM1
        awtIrq+Cmmv5hzFg3TGBqZtTDnGjiwgJ2NE1wcM=
X-Google-Smtp-Source: APXvYqxfXZf2kC0eNyiF8ME05BNAtuNhZ5PxQ95pW5vGWYDMjmGt3gFvTkab6vp97PvNC51xwjTOrUzydkDUxE1cFpk=
X-Received: by 2002:a1c:a617:: with SMTP id p23mr12868182wme.166.1568619290030;
 Mon, 16 Sep 2019 00:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <1f13820761bbdb4db685a90e9bcf35a388b246cf.camel@analog.com> <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com>
In-Reply-To: <2b7ab6c3-6ff6-69b5-bbd4-f8a1966b6b57@essensium.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 16 Sep 2019 09:34:38 +0200
Message-ID: <CAN8YU5PtmC9QQCmSb1uDXMK+WVQ6Lfihijs1c0zRkr568GrdXg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fixes for ad7949
To:     Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno ven 13 set 2019 alle ore 16:00 Couret Charles-Antoine
<charles-antoine.couret@essensium.com> ha scritto:

>
> For patch 3, I didn't use delay_usecs fiels due to the timings
> definition in the datasheet in "READ/WRITE SPANNING CONVERSION WITHOUT A
> BUSY INDICATOR" mode. During the delay, the chip select line must be
> released which is not the case when we use delay_usecs field. So I add
> the delay instruction after the write step to be compliant with these
> timings.

Ok, you are right, thank you for pointing this out..

It looks like that, for my original intent of being strict about
acquisition time and conversion time (as per my original
interpretation), both delays (before and after) CS change would be
needed.. But since Alexandru pointed out that the single 2uS delay, as
per current implementation, should be OK for the A/D chip, then I'd
drop patch 3/4.

> For patch 4, I explained a bit in the other thread. Maybe we have a
> difference of behaviour due to the choice of the timings "modes"?

I don't know.. is it "RAC" the intended working mode? If you want I
can take some snapshot of scope images and share them..

>
> BTW, from my point of view the datasheet is not totally clear about the
> timings and what is mandatory or not in the expected behaviour.

I agree with you that datasheet is not so clear about timings..
However I think it makes it pretty clear that we need the extra
transfer in order to make sure that the read data is correct (except
if the CFG doesn't change).

IMO that's could be evinced by both diagrams (all modes I think) and
by the following sentence in "READING/WRITING AFTER CONVERSION, ANY
SPEED HOSTS" paragraph: "When reading/writing after conversion, or
during acquisition(n), conversion results are for the previous (n =E2=88=92=
 1)
conversion, and writing is for the (n + 1) acquisition".

I interpret this as follows:
- You write a new CFG in cycle n, you get (and discard) data for cycle
n-1, and the new CFG will be used for next _acquisition_.
- Once you release the CS (you finished to write) the conversion for
the _currently_ acquired data (old cfg) starts. Once the A/D finishes
the conversion, the acquisition starts with the new CFG
- You read data, and the A/D returns results from the last
_conversion_ that has been done, which is still related to the old
configuration. Once you release the CS (finish to read) the conversion
for the currently acquired data - which is now the one with the new
CFG - is started.
- Finally you read the result of the above conversion

So IMO we really need three cycles to read from a random channel


> Regards,
>
> Charles-Antoine Couret
>
