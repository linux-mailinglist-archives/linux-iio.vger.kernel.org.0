Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEEF2DC3DF
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 17:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgLPQSK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 11:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgLPQSJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 11:18:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F77AC061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 08:17:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w1so1826385pjc.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fR++yHc9DnNILA0irMur2Oaxn8UEeRZAzGI427OkS8E=;
        b=lHmabxIK6MqbjZ77bJxVRu4HasqgcvjSAClIpq9nGz5zrtS2wggwOZYv6D9ADwW6E6
         I6VN3JbcM6gz+mOkPhBP7Jbzm++nFbPkrK3N8dVAh7U3id8Gvog0+JfITQxrmieAk6C9
         FzqZiP+ifBd9z0AH0Mtn/JnrkeXvAp7JAUcLtAH0Ea57wWaHJKGO66/ZO5nwh3OlXl5F
         OOS0hvzxqvrXJ5bVYb5nzUqY6s6Hk24J1SULkTUutyUEU5bHTOkp+plTIWnVtQqydSF6
         k86DMdkGJ0wWe+lOMMvxSP/2cWWkGdP4e2XN5kK48ChU5qw2PW0ooUBnp5XnqxKaW7gT
         i8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fR++yHc9DnNILA0irMur2Oaxn8UEeRZAzGI427OkS8E=;
        b=cg4GGr3xRRn5N/4/PhyeXPS1lkrW5dCd8PfEC55Up635zvOsfmdHJGECEt1PBgG/Nh
         FvQlf7BM6/XInRl374Ck87gQj6KK+q22BlTi/m4GAWfTc0oelMglxAPpzAODmHoKt5U7
         zKX/0IOb4pLyIuAEJ1Uq67fszLfQ1H1Kc1EqcFyEDlpQ0ggltMDB8Sfiv/QjV56BXsS2
         aK2SGe+cYaJrk5Cx8L9nPTSdKHrurEwGRF/ie9S76pYdwsfYOKjN6qwX9wXb9Rt5n1sH
         LWAMukrXoTbw4BPr2qddm15F9zGP4a25Sxv/oh5NnXJeggmvQCfHn4GMJbqJ1hyQyxFO
         pc8w==
X-Gm-Message-State: AOAM532lImDlE4igLatySnScZO6Ty/aIWxJNHSgHfvbCHipBhekFFUPP
        4ypjPhDvmf+aqNZD42Zt97Fgk/h7zqyyQPqP7GA=
X-Google-Smtp-Source: ABdhPJwWdkaP/NqrZfXPR19s7K9HlFNqlodwr+9NZAk87kvPb8ti+Y/xr22fdyQmDYXZLebAetN2D74g+QijrLN1Xmc=
X-Received: by 2002:a17:902:c244:b029:da:e63c:cede with SMTP id
 4-20020a170902c244b02900dae63ccedemr7140165plg.0.1608135449071; Wed, 16 Dec
 2020 08:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20201216060233.597689-1-gwendal@chromium.org> <20201216060233.597689-2-gwendal@chromium.org>
In-Reply-To: <20201216060233.597689-2-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Dec 2020 18:18:17 +0200
Message-ID: <CAHp75VequjMKSxCaA3OAKxwdWPyp1Lgwp+kotZnipMqAZsO7mg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] iio: acpi_als: Add timestamp channel
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 16, 2020 at 8:02 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Add timestamp channel in list of channel, to allow retrieving timestamps
> when events are produced.

...

>  /*
>   * The event buffer contains timestamp and all the data from
>   * the ACPI0008 block. There are multiple, but so far we only
> - * support _ALI (illuminance). Once someone adds new channels
> - * to acpi_als_channels[], the evt_buffer below will grow
> - * automatically.

> + * support _ALI (illuminance):
> + * One channel, padding and timestamp.

Why on a new line? We have enough space on the previous one, no?

>   */

-- 
With Best Regards,
Andy Shevchenko
