Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23122E3309
	for <lists+linux-iio@lfdr.de>; Sun, 27 Dec 2020 22:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgL0Vsl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Dec 2020 16:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgL0Vsl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Dec 2020 16:48:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C294C061794
        for <linux-iio@vger.kernel.org>; Sun, 27 Dec 2020 13:48:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b26so20108227lff.9
        for <linux-iio@vger.kernel.org>; Sun, 27 Dec 2020 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9PkhFMIgpRXIJBTOvYbODEkoEN5Ob9+TziSRteI/tQ=;
        b=DSOeUMWVw46cCF9n4TjcKFPiOceG1MDVoubiVvOGyPA5/WwkBWKGdU07onhwKGFBkL
         PRHqF0H6MSqutENzsez94tdkeKqPfQmrdDN87c6laUiu6jA9U0YrSH9EZkbc5Sd+2FM8
         ecxptvMWKm1VD19tWbVNWwVk+ff3SNUDFNb3mjxRHkpkO0p4u+8isylEIJD+FFJiH1X1
         OtLKUVRBE/s7RSx6ZgdLHtPYixm6UdrFX4+c3o9zGQyyt8CdXljuavzOx0u5ZCrKsyf2
         SYAOcmhrvG7BJ5l8+8e+NwJPUxj6PSEQTQo5X68Htdy024lIDLuDv8+w5cEk6eJSl37w
         2VBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9PkhFMIgpRXIJBTOvYbODEkoEN5Ob9+TziSRteI/tQ=;
        b=IJCjMcCic9DmwnMEhVAKLNioGTI0GWBQsOKuNJwN2g96FkLrhNU5mnmTNwmVsgDtdz
         7RgSvg3Xee8b4hNcCKFJ8cdNWVSGxzKYo6Um0MA9AjiywP4p6oF4CUbLmsN+/JGgquez
         DxinpMikKWArNcTJ77pbqDJMfRQ/WApT+4Wi12PuYSBvTMcCyh8yc23WdXp+0WgEruLR
         l+XVVZbUQYmEWE6NPO5H3rPRBifUxlMwRPlQrPMuFSphNKYiuR8ZQwqRUazzkRbSOyVW
         2mWUQMQSQlg+K6+L5ONTNkDFGqfpSIeYc3VPFVrF0E/V0vHuBGKMF3Lasrweeh7ukqVM
         6Lgg==
X-Gm-Message-State: AOAM530ki8Nnnyn73tvGBzDncf7bigmvQcNeF9xmDWkTILt4M9Dow6Yf
        3tIBD2OsinCovZ3C55siqeJAEUVnoAgNM5MuabQwjA==
X-Google-Smtp-Source: ABdhPJxBSyo3e9vkaHN6SEbrcZg//35yWL4LkFB9Zo8nQbB0cL2iglkoXqv984zyLQUq1kmL+bZ1nN7+KnnaTAS1ibA=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr19652870ljl.467.1609105678771;
 Sun, 27 Dec 2020 13:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
 <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com>
 <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdbxzuYrFeU2H2LGaWb3kKqfZ4-SpWu5FiXdFVyz82-zWw@mail.gmail.com> <SN6PR08MB55654976327EF62990D4DD919ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB55654976327EF62990D4DD919ADA0@SN6PR08MB5565.namprd08.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:47:47 +0100
Message-ID: <CACRpkdYVruMggRHtOLWZ01N5yYx8GqAK3OtKC13Z=669eznurA@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Dec 27, 2020 at 7:54 PM Chris Lesiak <chris.lesiak@licor.com> wrote:
> Linus Walleij <linus.walleij@linaro.org> wrote:
> > But do you agree with the general stance that we should
> > give precedence to using iio_read_channel_processed()
> > and multiply the result with 1000? It should work with
> > any driver I think.
>
> In order to preserve resolution of the microVolt value for existing code,

Aha you mean that iio_read_channel_processed() loses
precision when converting raw to scaled?

> I'd prefer a solution similar to the existing implementation of
> iio_read_channel_processed.

That seems like the wrong way to work around a problem in
the core.

If iio_read_channel_processed() loses precision we should
fix iio_read_channel_processed() and not try to work around
the problem in the consumers.

It's fine to fix all the consumers in the kernel.

What about changing the signature of:

int iio_read_channel_processed(struct iio_channel *chan, int *val)

to:

int iio_read_channel_processed(struct iio_channel *chan, int *val,
unsigned int scale)

And just augment all calls to pass 1 except the ntc driver
which then passes 1000 in the last argument?

If Jonathan agrees I can fix a patch to alter all the ~50
call sites like this and include the change to this NTC
driver.

Yours,
Linus Walleij
