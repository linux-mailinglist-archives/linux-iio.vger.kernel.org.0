Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3572206C
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 00:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfEQWs7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 May 2019 18:48:59 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51341 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfEQWs7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 May 2019 18:48:59 -0400
Received: by mail-it1-f194.google.com with SMTP id m3so10663098itl.1
        for <linux-iio@vger.kernel.org>; Fri, 17 May 2019 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWLIDy2co5Vn50CtpXbdQSItadAnwXRU6oL36I+LMbU=;
        b=j1fMEwmFBzpq5dKJ/MaU3D+drIuI0ARLCKClUL2DUep1n6kX4Fj3FE+3y2BpqzVZcg
         cEeqDwknBjsY/k8bhbZb9ooIqb2AicXfoG+WcGFLfDGOXOwGm39gXALlBPzi1fE7dZkl
         Gy0hqJ4vSeb3tcYqh9HvuEQUYmtA/7AZnr2/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWLIDy2co5Vn50CtpXbdQSItadAnwXRU6oL36I+LMbU=;
        b=EohEuxLCF7shiYJMMQcTWKMRLb8RNHQKpHjfzo9LqtI5d9ESMbasJ33hzicPk4IsNL
         EYOvGYj2rLeZ6F31An9pwW9gZUgt/xmQuvCfgqF9rCoeNYXjj13HxhalIg6akjXiRLf3
         W1DWpZ1v+sflFJ24tPSU2hHuO0g/mYsUaF7dpcQ9SPyziE+uGYje5qF3vnsFrcmKguY0
         qp/XeT6z4AQFFLXAetd4YnEbF46ZoskROXtXzQdwyMVQn3Gmph9LWjL4ZWRqFMpHu4hH
         bQDfh4d+rPxS/K0rDEymSUrwClVdl3c/nB2b6w7w9tVABUpFohwxPm8MRXHMFW6r2vf6
         6QIA==
X-Gm-Message-State: APjAAAUlFXUYpsFdkkmfLtPOyGa6mvhKJtBOmUHcjD0yCD7FVHU1ej2y
        scUZWhvsioVuGVojvB3kA0sWcyA4EaTjF5x3hrPNCQ==
X-Google-Smtp-Source: APXvYqyYg5NJJ7Eb1Cf1sch9W6PqiIZNmQkePH7xL+iwmKaY8JvrKHQXzNzcY6+FGrg1OB6xJE1HilF2iy1ns9vW/Ag=
X-Received: by 2002:a02:1142:: with SMTP id 63mr37714962jaf.19.1558133338638;
 Fri, 17 May 2019 15:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190509211353.213194-1-gwendal@chromium.org>
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Fri, 17 May 2019 15:48:47 -0700
Message-ID: <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Lee,

I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
used on chromebook using a squashed version of these patches.
(crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
respectively)
Please let me know if you have any questions.

Thanks,

Gwendal.

On Thu, May 9, 2019 at 2:14 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> The interface between CrosEC embedded controller and the host,
> described by cros_ec_commands.h, as diverged from what the embedded
> controller really support.
>
> The source of thruth is at
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
>
> That include file is converted to remove ACPI and Embedded only code.
>
> From now on, cros_ec_commands.h will be automatically generated from
> the file above, do not modify directly.
>
> Fell free to squash the commits below.
>
> Changes in v3:
> - Rebase after commit 81888d8ab1532 ("mfd: cros_ec: Update the EC feature codes")
> - Add Acked-by: Benson Leung <bleung@chromium.org>
>
> Changes in v2:
> - Move I2S changes at the end of the patchset, squashed with change in
>   sound/soc/codecs/cros_ec_codec.c to match new interface.
> - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Gwendal Grignou (30):
>   mfd: cros_ec: Update license term
>   mfd: cros_ec: Zero BUILD_ macro
>   mfd: cros_ec: set comments properly
>   mfd: cros_ec: add ec_align macros
>   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
>   mfd: cros_ec: use BIT macro
>   mfd: cros_ec: Update ACPI interface definition
>   mfd: cros_ec: move HDMI CEC API definition
>   mfd: cros_ec: Remove zero-size structs
>   mfd: cros_ec: Add Flash V2 commands API
>   mfd: cros_ec: Add PWM_SET_DUTY API
>   mfd: cros_ec: Add lightbar v2 API
>   mfd: cros_ec: Expand hash API
>   mfd: cros_ec: Add EC transport protocol v4
>   mfd: cros_ec: Complete MEMS sensor API
>   mfd: cros_ec: Fix event processing API
>   mfd: cros_ec: Add fingerprint API
>   mfd: cros_ec: Fix temperature API
>   mfd: cros_ec: Complete Power and USB PD API
>   mfd: cros_ec: Add API for keyboard testing
>   mfd: cros_ec: Add Hibernate API
>   mfd: cros_ec: Add Smart Battery Firmware update API
>   mfd: cros_ec: Add I2C passthru protection API
>   mfd: cros_ec: Add API for EC-EC communication
>   mfd: cros_ec: Add API for Touchpad support
>   mfd: cros_ec: Add API for Fingerprint support
>   mfd: cros_ec: Add API for rwsig
>   mfd: cros_ec: Add SKU ID and Secure storage API
>   mfd: cros_ec: Add Management API entry points
>   mfd: cros_ec: Update I2S API
>
>  include/linux/mfd/cros_ec_commands.h | 3658 ++++++++++++++++++++------
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2915 insertions(+), 751 deletions(-)
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>
