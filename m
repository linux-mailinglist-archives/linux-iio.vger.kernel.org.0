Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B264457FF2
	for <lists+linux-iio@lfdr.de>; Sat, 20 Nov 2021 18:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbhKTSBZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Nov 2021 13:01:25 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:38427 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhKTSBZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Nov 2021 13:01:25 -0500
Received: by mail-vk1-f177.google.com with SMTP id s17so7741620vka.5
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 09:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8DN59NiUiiwFEJdza9TW0vp5VVpgMpBq6lfQohhJm0E=;
        b=OJT6FvnOYYIFgOLmyo3EPcPAwIR/zV31WONi0AbkKltd5ENHilcI6uBAeGvDJECyMy
         8LLuoWfkBilZ9dUjSrOaq6N2WKbdAKkrjr6QGKlUyHLW91Shs7b0Tlm4fQ1uwhShtwjv
         5hj7E23xP1TM4fuyuB2Sz1rhTMrp/PkGPdXEzvlQ6dmHX9KehP+xt87fJxJE06EfuMvW
         32XOxPdPAMv+jT8bRbX8nNNRRAZ/D6ayikK+miCULWS3a94z7RbUzX921S5NLn3xgLaB
         TNvowcfRNzIAq6YjMtBBGtZ2ksFtuPzvIflxftEfwcZ7N6gFv12nW6TZuQrUfEy2R6Mh
         poaw==
X-Gm-Message-State: AOAM530HvyiI9GehazKj7zCPAqrdVXlJoYjsNjonp5fXK2KbMl/P8yk3
        u+i1ptjDFqxA6Z9DmMgmTkitHoMjTBWOmA==
X-Google-Smtp-Source: ABdhPJy2MHSs198hYDdqlvCgyEey2V7KSTrTlgFc4mqDWE1EiAI/BWqHBAcvDyjCsZH536Lb49sCxA==
X-Received: by 2002:a05:6122:7c9:: with SMTP id l9mr6993640vkr.7.1637431100486;
        Sat, 20 Nov 2021 09:58:20 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id g187sm1912052vsc.10.2021.11.20.09.58.20
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 09:58:20 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id n6so27935736uak.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Nov 2021 09:58:20 -0800 (PST)
X-Received: by 2002:a67:3093:: with SMTP id w141mr81934093vsw.24.1637431099946;
 Sat, 20 Nov 2021 09:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20211116213746.264378-1-boger@wirenboard.com> <20211120174930.1ec11e77@jic23-huawei>
In-Reply-To: <20211120174930.1ec11e77@jic23-huawei>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sun, 21 Nov 2021 01:58:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v66_+HWrJM7i3HmaeOE7oh6h+MUxOsp7J=GObZPovnfS3g@mail.gmail.com>
Message-ID: <CAGb2v66_+HWrJM7i3HmaeOE7oh6h+MUxOsp7J=GObZPovnfS3g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: axp20x_adc: fix charging current reporting
 on AXP22x
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Evgeny Boger <boger@wirenboard.com>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Sun, Nov 21, 2021 at 1:44 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 17 Nov 2021 00:37:46 +0300
> Evgeny Boger <boger@wirenboard.com> wrote:
>
> > Both the charging and discharging currents on AXP22x are stored as
> > 12-bit integers, in accordance with the datasheet.
> > It's also confirmed by vendor BSP (axp20x_adc.c:axp22_icharge_to_mA).
> >
> > The scale factor of 0.5 is never mentioned in datasheet, nor in the
> > vendor source code. I think it was here to compensate for
> > erroneous addition bit in register width.
> >
> > Tested on custom A40i+AXP221s board with external ammeter as
> > a reference.
> >
> > Signed-off-by: Evgeny Boger <boger@wirenboard.com>
>
> I know Quentin has moved on from Bootlin, so looking for input from Chen-Yu Tsai
> for these as I have no idea :)

The datasheet only lists the registers for reading the value, but nothing
is said about how to interpret the data read. And the datasheet lists 13
bits split between two registers.

Evgeny mentioned that the original code is wrong, and the BSP code is
likely right, and has test results that match. That's good enough for
me. Unfortunately I don't have any way to double check it right now. So

Acked-by: Chen-Yu Tsai <wens@csie.org>
