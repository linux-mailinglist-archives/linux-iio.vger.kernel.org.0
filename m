Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2C259B76
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 19:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgIARCf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbgIARCJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2020 13:02:09 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B254CC061244
        for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2020 10:02:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id nw23so2711738ejb.4
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0W2yxpJArpylRLCAMIxUVDHEOE0Rtc8t8qbdRvvfyJY=;
        b=X24yWagx+1ZBxGqiyugUJ2eJGaAd8LrpJbAszSn32GfXleOf7l+Ypbk3seu9N8m9wr
         6rFo3aOLOdswBzxVz6unSED4HxB+bT3WIHtXET+LhFFSm4HHGO1rkE4I/Yu1Vdk3LYWf
         b7bEDunKc/ozpoOXKv0FSOLA+nXGTcEaKgmJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0W2yxpJArpylRLCAMIxUVDHEOE0Rtc8t8qbdRvvfyJY=;
        b=A9Cogm/u4Y0T/MCwEDJ8ggoToJeZbGeSzwH4JofxYOlUYKy67RvafBQo3FhOBRJwLw
         pydv86Z0ipB8tmCqMwGwiThPQxOpPQg9ZbjkQrBJmmIO1ybQmAVkb5j5IcfVfgMHAexX
         98j1sQ6B31q4OWoVLcjL8ikI0tlsWQPsgm6DbeIVVafsRLFZZ/3reoJwIdUnY88SuOIO
         qsF0r6/pnB1fhIk4FE/HdPlbRgS1hG4nhROYxofkkIPUnGSS3Y7EjIF9Zm8zLnj/s5+q
         GLxqBVsqquH1uE+2fF7uBdWO9iAj/33shAy/wJZGEX4j33xJD2tIpWh6BgNycHDNz8aI
         h7BA==
X-Gm-Message-State: AOAM530dmvD5+MwnV+mHzR9wzlJjoRy1lo2WxNZbgazoD4yF6BdhksVI
        OuUGIbsTWq4Wtz0lHU5Qo5qj2/BmtQAcgg==
X-Google-Smtp-Source: ABdhPJzcuPwmCTsZyaNSIa4WUjN877Dq5ACk3r8Vx0Y+Km/Oocld7TJa8xzOOxq7hMFm2zLyQpchMA==
X-Received: by 2002:a17:906:28c4:: with SMTP id p4mr2351785ejd.345.1598979727082;
        Tue, 01 Sep 2020 10:02:07 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id v17sm1828042ejj.55.2020.09.01.10.02.06
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 10:02:06 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id q9so1865793wmj.2
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 10:02:06 -0700 (PDT)
X-Received: by 2002:a1c:b407:: with SMTP id d7mr2845879wmf.59.1598979726047;
 Tue, 01 Sep 2020 10:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
 <159897502625.334488.7103007623601336114@swboyd.mtv.corp.google.com>
In-Reply-To: <159897502625.334488.7103007623601336114@swboyd.mtv.corp.google.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 1 Sep 2020 11:01:29 -0600
X-Gmail-Original-Message-ID: <CAHcu+VarBz3m_zKfDB0osQsjZ0dMpvUk+q2Qt-yC5DbPjr0bRA@mail.gmail.com>
Message-ID: <CAHcu+VarBz3m_zKfDB0osQsjZ0dMpvUk+q2Qt-yC5DbPjr0bRA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9310: Prefer async probe
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 1, 2020 at 9:43 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-09-01 08:19:43)
> > On one board I found that:
> >   probe of 5-0028 returned 1 after 259547 usecs
> >
> > While some of this time is attributable to the pile of i2c transfers
> > that we do at probe time, the lion's share (over 200 ms) is sitting
> > waiting in the polling loop in sx9310_init_compensation() waiting for
> > the hardware to indicate that it's done.
> >
> > There's no reason to block probe of all other devices on our probe.
> > Turn on async probe.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Campello <campello@chromium.org>
