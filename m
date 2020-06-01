Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF21EB0D7
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jun 2020 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgFAVTz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Jun 2020 17:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgFAVTz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2020 17:19:55 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA11C061A0E
        for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2020 14:19:55 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y5so8490467iob.12
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2020 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLJA34osZojtXwJVfuFDiRuCU0UG0pNat9rZBvD4N6o=;
        b=KjPVpgMjUaVFvgf4lgpJvrbVuOKbMptA5Zxy3BS2pdbAq2Sc20x1VHqV48I0BDhyMk
         /mrklzQVCb7IUZDXvkfXp+1IK3JctDfbAL8onndlwkV1ruHwLYhrt6eAef3fzrZO1qfo
         rQUrRjigths73TlnoTAjFoP2MTRFmXw9pwaFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLJA34osZojtXwJVfuFDiRuCU0UG0pNat9rZBvD4N6o=;
        b=Q4peSvYg1sjXzwH1sXimO5IXPYJ6pUP2OlWUFmsaLyw5wy3nzbDk8aifoc80SrUMoK
         ry5bxn/se0ECYN3/vIJUxJemT4hFgxS8soDUxmgOxvcVn//9Hk0YezCUlCW1VUrwlFox
         1YftQC0R/6PNILM+A2KovxL+Th64BmKIXFOgsdxa6PvNt7dFEe+V9US26G8Bs+A9s8DT
         3zep6Zt3bZW4LVCcQwre9F9rD+T3+GdhrzKPEeaKPZ7n6oKZxlsu5g7UiOuOq4hzJaj7
         L0xFSqhZPuusk5X1wEzecK+rfAnP9smH7+bYD9/4Cs4OmfY8VjEico9jabdqOn0K5IbO
         dfbg==
X-Gm-Message-State: AOAM533LwtH6jn0kRN173PT7+mkWuyo5NO+EAfx7cXQfO9EPJRM9haSB
        iMofFzPfp4xKNWrMrVSwnvG987DRCWWUMGoiYlVz0A==
X-Google-Smtp-Source: ABdhPJzY3vtLDPH5lTq64moY0j94dlfRggTPJJcd1GjX1SJ4uolHEvJL8325ez0To/WT0clunDM76QvDOR7RGZFVXq4=
X-Received: by 2002:a6b:f812:: with SMTP id o18mr19976556ioh.87.1591046394929;
 Mon, 01 Jun 2020 14:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200601161552.34579-1-tomasz.duszynski@octakon.com>
In-Reply-To: <20200601161552.34579-1-tomasz.duszynski@octakon.com>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Mon, 1 Jun 2020 14:19:43 -0700
Message-ID: <CAJCx=gkXrNV1pHHBYFcKUttkN=Vc9i_1fOh4stCG3f_GWVJfYA@mail.gmail.com>
Subject: Re: [PATCH] iio: improve IIO_CONCENTRATION channel type description
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matt Ranostay <mranostay@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 1, 2020 at 9:18 AM Tomasz Duszynski
<tomasz.duszynski@octakon.com> wrote:
>
> IIO_CONCENTRATION together with INFO_RAW specifier is used for reporting
> raw concentrations of pollutants. Raw value should be meaningless
> before being properly scaled. Because of that description shouldn't
> mention raw value unit whatsoever.
>
> Fix this by rephrasing existing description so it follows conventions
> used throughout IIO ABI docs.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

>
> Fixes: 8ff6b3bc94930 ("iio: chemical: Add IIO_CONCENTRATION channel type")
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d3e53a6d8331..5c62bfb0f3f5 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1569,7 +1569,8 @@ What:             /sys/bus/iio/devices/iio:deviceX/in_concentrationX_voc_raw
>  KernelVersion: 4.3
>  Contact:       linux-iio@vger.kernel.org
>  Description:
> -               Raw (unscaled no offset etc.) percentage reading of a substance.
> +               Raw (unscaled no offset etc.) reading of a substance. Units
> +               after application of scale and offset are percents.
>
>  What:          /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
>  What:          /sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
> --
> 2.26.2
>
