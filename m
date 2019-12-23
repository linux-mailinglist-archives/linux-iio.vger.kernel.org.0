Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50ABF12963D
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLWNHy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 08:07:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34613 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLWNHy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Dec 2019 08:07:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so4409015lfc.1;
        Mon, 23 Dec 2019 05:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5eJH2So2Y3KqY/K1ixMNRpaPpKx0b38bhcNlkypecC0=;
        b=N7FN0ncLXb065P3FN14ZDLucMWMpNKGbWPL84vdRLA17Kc3XtT8pnSKLjbseUPj918
         b9yDdgKBeG55jltDFLk9cDzyCHWPNVXrw4qoKL0NK/RoO24MAp8q04nFdEJcZpgaT5BF
         Q15J2JBVrmMrQx4zFr9FLZw/VeElcbpyV3hIkGOi1aH3of4W5V7Pz5pv99zVfEeU/F0K
         SoqCCo4ejdPWZ5XPiDBHIxGsbm8jsgy1f4YZ0a2rDR8r1ttquMOBRfzWSCRjKNS9W/oB
         PELHjv9r8rJchpunfS3Od1m02nbafGGlA5trUX/4PLKhVRONJM6uv5xUiPD//ox37mFL
         dK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5eJH2So2Y3KqY/K1ixMNRpaPpKx0b38bhcNlkypecC0=;
        b=PWdt69KWzpEnD7AY/7sODWcRHrQjmvZQqUo9v3BCfB6qr7YNZvk+29EOm3Ua821tJ+
         BE+CG8YXe1VVGx4DVPZli06E/rRWBmmnwsaAxsQZ1q5xtOeYGMTKVfQ1tmsa9NQRTy87
         vQuEIQCuS1XP+lSHNQ7L43sgNayRHsqrRkOTgPbeaznDsnfADIDpq45myeI49hpL5F2f
         yjvW73cZ63P8XXcYS/SeFSjXVyIoU363G60MdJ7Yt0EHX0ejCpAjW3cM5tYpHyUhvXsC
         3wah0m5ZeFz/yKZxJ+QknTvg/tCMwJ5qBnPmvwEkElYfYYy5XBaJBZzCW11U4TjLykvl
         FtFA==
X-Gm-Message-State: APjAAAVvB1MMveyg0c/S7qajWwsCOm8QX/dEnxbxul/mgvRJvqaX4ssi
        8/Ov7Gy+lrdjfOVWPfsLNz4FAomiyjRseJKc2Wo=
X-Google-Smtp-Source: APXvYqx35NtG2msl9BoMH2SPDevhyYA9MZsbmqBAxBohTRg/NXhM9CHIaYC1N0ZR9f0Dh28z9OhNSEDQtt4irLWQGH0=
X-Received: by 2002:ac2:4a89:: with SMTP id l9mr16617018lfp.121.1577106471345;
 Mon, 23 Dec 2019 05:07:51 -0800 (PST)
MIME-Version: 1.0
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 23 Dec 2019 22:07:39 +0900
Message-ID: <CAC5umygqpmb0s8zHC+TFEFffQmsU4N1hUs_XWGDLtqkJEccfBw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] add header file for kelvin to/from Celsius
 conversion helpers
To:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kalle Valo <kvalo@codeaurora.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Andrew,

Could you take a look at this series, and consider including into -mm tree?

2019=E5=B9=B412=E6=9C=8815=E6=97=A5(=E6=97=A5) 14:16 Akinobu Mita <akinobu.=
mita@gmail.com>:
>
> There are several helper macros to convert kelvin to/from Celsius in
> <linux/thermal.h> for thermal drivers.  These are useful for any other
> drivers or subsystems, but it's odd to include <linux/thermal.h> just for
> the helpers.
>
> This adds a new <linux/units.h> that provides the equivalent inline
> functions for any drivers or subsystems, and switches all the users of
> conversion helpers in <linux/thermal.h> to use <linux/units.h>
> helpers.
