Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6D3072BC
	for <lists+linux-iio@lfdr.de>; Thu, 28 Jan 2021 10:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhA1JaD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Jan 2021 04:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhA1JYM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jan 2021 04:24:12 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA98C06174A;
        Thu, 28 Jan 2021 01:23:31 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id h14so4550975otr.4;
        Thu, 28 Jan 2021 01:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fzG9aEwYmapgCOH2KyG9igHfhrZ1QTXlCJukfCUrBMo=;
        b=o9jlNTCB+ccFOcp6th2nO+cPn3gKqqVyVNG78CieHLJugHqsTVQEplmiGXYuADxoEL
         44xm3lN2DoIIazdqTjOU2CVEyd2EYLbJqFZGROciLpqoyiujpZ+W9w5p6YRqe+hztgQ9
         llQbT+b75lYzyoCxFfrjjsnDrS9ik3NV44ki0xYVvu9IMxSc8NwsDBDFbx3cCHSk+0rn
         we9LMscgrQb7ufg6gYz8X3TIjDs1uOykDO0KB7KiOX0h7Q+U7eDTsS0PNvdlAqyX+gae
         O6GKMKPKbEZZJEPgV+AVrylpmiowMOzUaGle+2k859+MrEKc67cMt45VqMzj3+yTWGbD
         NoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzG9aEwYmapgCOH2KyG9igHfhrZ1QTXlCJukfCUrBMo=;
        b=gLc8MCfgKzf1d9OMENvNFVLxFSeUXy//Dp8usLrt7R90a+B0m0lAZw5yoPlw6kgeKo
         ob/IWLf+O4uTJqg7kcIJZ7AfrIDqbpY2wZqRQgLldfJXkhi6liEhtgMiAwrD8yj/Sx81
         rxstCWSp3rh9hpOZCGOOurCYwMmNOrKMtlpP24Fy1lY+PTdk9+6zNocZuG+KmG0aD+7M
         InXt/JT2Qi+AkwiHxEAm70OkO/w2qDDkZGTRLqn8ZPu4fXwibcOXSSHpaBnGMr1WJpJq
         5GsowAEfhdoAHP5me1g8co2FNostwILZZFsotvdKnHqD+Ys38+wjZswDBgW9LEuwqL/l
         ehVw==
X-Gm-Message-State: AOAM532S3mjQhQH06eb+Io/9XuOW1mHkJw6xOK7E/Svat8t2nc+dw51y
        64xW6tUAq/C6TeHGld3OFMvoK1x69h6ylhsK/QA=
X-Google-Smtp-Source: ABdhPJzVCtYst8XioWO1oHO3P4jPB6/6QRUwZSDaP/Q9uIK+BdFPXUXk8IMy0RG/FM2Xs87InVFUSv/q4/pQ0qxx+Ls=
X-Received: by 2002:a05:6830:230b:: with SMTP id u11mr10979450ote.184.1611825810833;
 Thu, 28 Jan 2021 01:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20210128084011.3270281-1-swboyd@chromium.org> <20210128084011.3270281-2-swboyd@chromium.org>
In-Reply-To: <20210128084011.3270281-2-swboyd@chromium.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 28 Jan 2021 10:23:19 +0100
Message-ID: <CAFqH_535nAFVev5PYMmk5BgEeUfByiHQPoiW5P1AOe+UVxpikg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] platform/chrome: cros_ec: Add SW_FRONT_PROXIMITY
 MKBP define
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Stephen,

Thank you for your patch. Please cc'me for the patches related to the
chrome/platform subsystem.

Missatge de Stephen Boyd <swboyd@chromium.org> del dia dj., 28 de gen.
2021 a les 9:48:
>
> Some cros ECs support a front proximity MKBP event via
> 'EC_MKBP_FRONT_PROXIMITY'. Add this define so it can be used in a
> future patch.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
>  include/linux/platform_data/cros_ec_commands.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 86376779ab31..776e0b2be0e9 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -3457,6 +3457,7 @@ struct ec_response_get_next_event_v1 {
>  #define EC_MKBP_LID_OPEN       0
>  #define EC_MKBP_TABLET_MODE    1
>  #define EC_MKBP_BASE_ATTACHED  2
> +#define EC_MKBP_FRONT_PROXIMITY        3
>
>  /* Run keyboard factory test scanning */
>  #define EC_CMD_KEYBOARD_FACTORY_TEST 0x0068
> --
> https://chromeos.dev
>
