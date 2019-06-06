Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB56B372C3
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 13:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfFFLZx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 07:25:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45185 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfFFLZx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2019 07:25:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so2087590qtr.12;
        Thu, 06 Jun 2019 04:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5dNsy9b7wSo0PojyEFmG8hPYvRxvl4pE0j/UUGtnkT4=;
        b=PfJA17hV5DxfAedjpGZ9hI2xgFiAXw5rZ2cDbI2LVufOOBGUWNCzM9PTOgW38P91bX
         Hhd+Z1cV3gDc61Vn0HObvmU5cRH13KhcUe+YRqDR3SVM2MQWSfiKxZYRy/uhJEvdabg2
         FPbzUW8FX8oKwH86dsxSySwjPkeDO08FFqXPNIDdceu7+Mzzxkp5gvMRebpB9fVHPUYB
         Gt4Ur2wu4pxXwF3qTEGZh2VRlsOWpQtwFzWQiQsOmfvWlwMoC4X59eBPca9s69or1aNs
         1wkM3xuSIZizUSxijaHtZgxJCcpqBm/Ec+EJzJFQPaWIhxqR8a13wrwkZrjTy74DXFaK
         cT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5dNsy9b7wSo0PojyEFmG8hPYvRxvl4pE0j/UUGtnkT4=;
        b=IHQIU82yHMGm9OiELgWnemarEn1P1quLtC1lF0ciFphZFmpXchzqo6WhivlGztBO4A
         Wo3MogH2gs696ziMxO7XEdRwogGwRtqDcYtbJPlGs/cKW+C7E7jdERjk91fTSW6JtZ+X
         okMLs+w4uxZ785O1Mw1zUCfuuc7ZjX3pjp44gUS2cFx3SSK9dcL/zMG26z5CGX4n7GT/
         uhgud0noVnULKH43pOyYR3/ymkko6Ox2k3m7b6D8H9n5ElduNnxufYeE+c/wz5IiTce1
         LmycAE+YrzEyWp1Qa8Tjj1ttMoyhQNANlNEXvjNufdU9d7SJHDiK9RUEfKOvaDQZ8pF5
         x5CA==
X-Gm-Message-State: APjAAAXJPq3ZRZFrZR5a37SbzfYqlHqTwhIMHnm3SLkw67qnlvb/Sbc4
        WVaNC3sqmwuEQbO+4FE/V4pvKhgCRdkwHxtGCu4=
X-Google-Smtp-Source: APXvYqxI4DVrPMjWmEMhMewy/0MU4rt1SR7d41hBlwI1sK4buOiQ0PwUYfkjIRaPn7qU9VQJcA8j/66jTPavg7CNUJs=
X-Received: by 2002:a0c:d163:: with SMTP id c32mr39262393qvh.139.1559820352349;
 Thu, 06 Jun 2019 04:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190603183401.151408-1-gwendal@chromium.org> <20190604055908.GA4797@dell>
In-Reply-To: <20190604055908.GA4797@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 6 Jun 2019 13:25:40 +0200
Message-ID: <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com>
Subject: Re: [alsa-devel] [RESEND PATCH v3 00/30] Update cros_ec_commands.h
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
        fabien.lahoudere@collabora.com, Takashi Iwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

Missatge de Lee Jones <lee.jones@linaro.org> del dia dt., 4 de juny
2019 a les 8:00:
>
> On Mon, 03 Jun 2019, Gwendal Grignou wrote:
>
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> >
> > The source of thruth is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/inclu=
de/ec_commands.h
> >
> > That include file is converted to remove ACPI and Embedded only code.
> >
> > From now on, cros_ec_commands.h will be automatically generated from
> > the file above, do not modify directly.
> >
> > Fell free to squash the commits below.
> >
> > v3 resent: Add Fabien's ack.
>
> Thanks for doing that.
>
> In future, please ensure *-bys tags are in chronological order with
> the first one either being a Suggested-by or your SoB.  Reviews, tests
> etc usually come *after* first submission.
>
> I've changed this for you this time, yes in all 30 patches!  :)
>
> Anyway, all applied, thanks.
>

Could you do an immutable branch with those? I've few patches that
depends on those changes and probably I'll have more. Otherwise, I'll
wait for those to land.

Thanks,
 Enric

> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
