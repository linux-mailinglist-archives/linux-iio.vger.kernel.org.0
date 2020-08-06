Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315B823E388
	for <lists+linux-iio@lfdr.de>; Thu,  6 Aug 2020 23:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgHFVeQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Aug 2020 17:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFVeP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2020 17:34:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A56DC061574
        for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2020 14:34:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so31615975qtq.8
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2020 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+76LXO14aNsx8i1gnsECIsp+iH10M2aik6HmT5GQNM=;
        b=mWogffXazu8aVcQxrtz2BpdyrkCKOBfTzr9EAQaCeetZCb3M0J/y901nI1OnHvRvzS
         Ban/20sVtB3RPaygay2NwTeW7yzd2JJwp4ETi01vtqE5Z7ZS5pxr/9pe8h+n0g2hqiSQ
         6FVcv1v5O9PkmJizhozW8gSa0sSBZH1cuPWzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+76LXO14aNsx8i1gnsECIsp+iH10M2aik6HmT5GQNM=;
        b=tLT4dPYALJ+/s4Gxz3cr1iaS6uRDeuez2baO1WJjG7VdyfaBoxnbue2XMFXquPlqyc
         zVDEUX9jPsHY7Qv9bLRExeeeRcsJp8fcMN0r4F6JAvhvFa6rFlPdFW4SpLjRohnr1lpI
         LY31Pe9akqyFYo4bE2y0mdyby7XUh47F7kMzSt5Nb/kBswyDpmWv8Q+JVqhpo2b15Fe3
         +BJheamule98n6wLkn6HxlwewbajSptZ3EMynZ1Bwqjm5Gnv8JPFTGfXh5UxlIAtKa7O
         kh7p7XtLrlWVGgkGP+He5lrVJRMDajV2gSmxZhbyohGDS/v9nVcXWDDAl9L54OpuaeZr
         v01A==
X-Gm-Message-State: AOAM532xHAind8wmDEKvuMPMUM5UjdjZAAGLIuCTyYCPtbNrwEjYDoeN
        FoJIwzHeNyUXr2FVCxu8oNrxd/9muKA=
X-Google-Smtp-Source: ABdhPJwiti5uC68Mf07/4q86p9CmfRu5GGkpzCrMDPrG91k1AD1G5k6ib1uYP8KhV6k6OGqxiWL1iw==
X-Received: by 2002:ac8:f73:: with SMTP id l48mr10986071qtk.296.1596749652409;
        Thu, 06 Aug 2020 14:34:12 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id x12sm6291050qta.67.2020.08.06.14.34.11
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 14:34:12 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id h7so46353782qkk.7
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2020 14:34:11 -0700 (PDT)
X-Received: by 2002:a05:620a:1424:: with SMTP id k4mr10651380qkj.2.1596749651000;
 Thu, 06 Aug 2020 14:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200806153308.204605-1-linux@roeck-us.net> <20200806153308.204605-8-linux@roeck-us.net>
In-Reply-To: <20200806153308.204605-8-linux@roeck-us.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 6 Aug 2020 14:33:58 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPkQKfXGzP3kr150VKDE0eGc+2CALEvbU+LGv3zwGyWLQ@mail.gmail.com>
Message-ID: <CA+ASDXPkQKfXGzP3kr150VKDE0eGc+2CALEvbU+LGv3zwGyWLQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] pwm: cros-ec: Simplify EC error handling
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 6, 2020 at 8:33 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With enhanced error reporting from cros_ec_cmd_xfer_status() in place,
> we can fully use it and no longer rely on EC error codes.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Brian Norris <briannorris@chromium.org>
