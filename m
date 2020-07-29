Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFFD232837
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jul 2020 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgG2XhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 19:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgG2XhL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 19:37:11 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E882C0619D2
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 16:37:11 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dd12so6691060qvb.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ag+H1hGpAomnJAeq4yPJoXLabOM0ywnHRdghtWviE98=;
        b=QD2LhtSLWQP2TNjnoS6mqe5UA59jgN6HCy0aixdV7r2I3Q8LEf8OrJM9/XFxaYNCcw
         uY2t0zTQv3j7VlE0kUPrSVjp+11jncgubttjbEX4ea9KW03tLTBubx4v3oNnKVf+itvm
         9hRts8LGnfKWgqhOtqyOgmuWhSeaQP2Z278L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ag+H1hGpAomnJAeq4yPJoXLabOM0ywnHRdghtWviE98=;
        b=CPHlxejAg0LrhFyvx5zV7yG1m+nlzTeTBPW0DOuCwlIQFabDy9+wxwAO4rBasfl4XV
         J64EzPbSnbfs9U+NVlwbX3unfur3E63fv51dqFeqM9UK+01mNUsUenFKw7X6UbcGiJIe
         u76fbxMG18cvlmzcomhJ2HxMdQLtOpsOSlrQyo3QSUkiPGpakowCtB6T3wFUo8l0q8JJ
         DBTrtekJzFeyc9CyHIjzGlOY23E33xi+WsBHgGpc3lBnVjHtDDTO9EOY9sEUhDcTY7MH
         yUgfpcCGdvn3S9SzJR2XnPIk8UqlD7rsXAzpENCE75nmwjmivwJRlVYPEV7is/7o9SuV
         +sdQ==
X-Gm-Message-State: AOAM531gvi2fd5f4uoglRRyxZGydydBb8kka6pFEWVyWqAxfgaP0uSh8
        THW4pwVh1p5eb3qF+BGwQadwMw46ois=
X-Google-Smtp-Source: ABdhPJyx9tN6yrt7nFLWbvQW694/kpkIDmhKYtjaS+lNLJ3WhBHQUIsjJ4yGz6pK7PgbQKLkcyRCbA==
X-Received: by 2002:ad4:54c6:: with SMTP id j6mr373284qvx.126.1596065828967;
        Wed, 29 Jul 2020 16:37:08 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id k2sm2883343qkf.127.2020.07.29.16.37.08
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:37:08 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id w9so19027265qts.6
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 16:37:08 -0700 (PDT)
X-Received: by 2002:a05:620a:5f7:: with SMTP id z23mr20316631qkg.206.1596065368695;
 Wed, 29 Jul 2020 16:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200726220101.29059-1-linux@roeck-us.net> <20200726220101.29059-7-linux@roeck-us.net>
 <20200729222150.GA970863@google.com> <ae5aeae1-4dfc-0fd7-3392-bf1ca3540866@roeck-us.net>
In-Reply-To: <ae5aeae1-4dfc-0fd7-3392-bf1ca3540866@roeck-us.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 29 Jul 2020 16:29:16 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNSiuXEUmKhM8KvySK2OrW62yO1ZhR4Eigtx57CG33i4A@mail.gmail.com>
Message-ID: <CA+ASDXNSiuXEUmKhM8KvySK2OrW62yO1ZhR4Eigtx57CG33i4A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org, linux-pwm <linux-pwm@vger.kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 29, 2020 at 4:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/29/20 3:21 PM, Brian Norris wrote:
> > On Sun, Jul 26, 2020 at 03:01:01PM -0700, Guenter Roeck wrote:
> >> --- a/drivers/platform/chrome/cros_ec_proto.c
> >> +++ b/drivers/platform/chrome/cros_ec_proto.c

> > ^^ Maybe we want to double check 'ret != 0'? Or maybe
> >
> >                       ret = cros_ec_error_map[result];
> >                       if (!ret) {
>
> 'ret' won't ever be 0 here. Above:
>                                                         && cros_ec_error_map[result]
>
> and below:
>
>                 else
>                         ret = -EPROTO;

Ah, I'm reading too quickly. You're correct, sorry.

> >                               ret = -EPROTO;
> >                               dev_err(..., "Unexpected EC result code %d\n", result);
> >                       }
> >
> > ? Could even be WARN_ON(), since this would be an actionable programming
> > error, not exactly an external factor. Or maybe I'm being paranoid, and
> > future programmers are perfect.
> >
> I think, if anything, we might consider adding the message below (result >=
> ARRAY_SIZE(cros_ec_error_map) is just as bad). Not sure myself. I am
> open to adding it if people think it would be useful/desirable.

No, my primary motivation was that I thought the logic left room for
error if there were holes. I was mistaken on that point. Secondarily,
it was also potentially useful to point out when we fell into those
holes. I'm not sure logging the warning is that important. Generally,
we only care about a handful of result codes, and as long as the rest
don't end up as "success", I think we're in OK shape.

Sorry for the noise. Here's my tag (which given my misreading so far,
should probably have a heavy discount on its value):

Reviewed-by: Brian Norris <briannorris@chromium.org>
