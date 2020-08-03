Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855B823AA9C
	for <lists+linux-iio@lfdr.de>; Mon,  3 Aug 2020 18:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHCQh1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQh1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 12:37:27 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D8C06174A
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 09:37:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 189so2742008pfd.9
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJnxaTVIT3BRuXWtvMUIk8cOE9dIAP6EbW+OfGPSRpo=;
        b=OG6XFrleRytXdHnvdVHR3bFagl4hxohqseBPtEN/II+vY+b4xYqXwVjklWPXWxVqVk
         u++hzPVd2vJYHba6YXJIjGVu4RssVgMuybdakIebCWg/nHMsj9TBjtt4Ky5LCD3M4cY7
         mqjuUvN97D82eUPcOtKXWjzX/niNYInDkHEIF1O9rnfUVLP9FfGT0A8dlBqBJSDymu8i
         2C26AfxL56vvd0KW5FUSbF4CDd94BftUd9qusrqAkCam4SBV3RVcKhfLWBYdohnuuYkB
         AhTK4caV7xpvreFA3v+7l+QgtQOqVD1Aeo8PdGt4qTzTr0UyWasakqwhiA8aT+7X9ONs
         xxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJnxaTVIT3BRuXWtvMUIk8cOE9dIAP6EbW+OfGPSRpo=;
        b=QyAJuofG2ykChYgikITPOzv7nfxiaSuCpD88iEI1ZkOKNybtFlArq2wOvlnu3UkOuW
         oJd6FJmflRknPRuirfmjoXk+i7npgB/9CZ/EmqqQcFBMwWyNsqcp5MNEmxDNQ8ImyZf6
         dweQ7VKjU6QsfqXoUHtpz2Ri+WcYPWunrrIyHP4GlXGN9NfwWAejiHeVI8/xu4GEBfzq
         QFvFgdM0tzgdJnDIyA/02CsaiI8y75szh8kJpYq4WbuIb2BBeSjDgya/VvEAQ99XVR7q
         lHEh98hVr91R5VVvb+KtWg7D9LiUeSVnaxy0cQ0MvKJh45Xv9fxgDGpJVOiRdPLcOHex
         xwQQ==
X-Gm-Message-State: AOAM531KPFIYaMytKOo3/fe3GZmudFPilWECgSY7rqqVAU6qhePzO4PZ
        MMi43gyP5KuNL4YW5yIrnGRcViT14B1AqSsEcdA=
X-Google-Smtp-Source: ABdhPJzdASYzRWjivOHM2yy8nzFaony8/xaAYIyXYdHeCbUIeL6athLGwe+3Cf2DvaPyZYfeYdY42pgD9p+c1nvUQ7s=
X-Received: by 2002:a63:924b:: with SMTP id s11mr15127602pgn.74.1596472646489;
 Mon, 03 Aug 2020 09:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <86d053d1re.fsf@norphonic.com> <CAHp75VfgFN9YBHo9T8fgswUCnhdb3L5nGEi3_yONvZp5_vduUw@mail.gmail.com>
 <867dufdc2a.fsf@norphonic.com>
In-Reply-To: <867dufdc2a.fsf@norphonic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Aug 2020 19:37:11 +0300
Message-ID: <CAHp75VfVjGEbGxuG8xoHY56FTpZNkRxLAgAUswEbRgraKd6HQQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] iio: humidity: Add TI HDC20x0 support
To:     Eugene Zaikonnikov <ez@norphonic.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, development@norphonic.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 3, 2020 at 5:44 PM Eugene Zaikonnikov <ez@norphonic.com> wrote:

> Sorry for the attachments, it was an accident.
I hope the next version will be sent properly.

> > On Fri, Jul 10, 2020 at 2:54 PM Eugene Zaikonnikov <ez@norphonic.com> wrote:
>
> [...]
>
> > 8. It's one line
> > ret = i2c_smbus_write_byte_data(client,
> >     HDC2010_REG_MEASUREMENT_CONF, tmp);
> >
> > Ditto:
> > dev_warn(&client->dev, "Unable to restore default AMM\n");
> >
> Must be misunderstanding something, as neither of these fits 80 column
> fill if made into one line. Found also couple other places I need in
> fact to wrap down to 80.

For how many? And since it's a new driver you may use 100.
Besides that there is no limitation for the messages for a long time
(see dev_warn() example above).

-- 
With Best Regards,
Andy Shevchenko
