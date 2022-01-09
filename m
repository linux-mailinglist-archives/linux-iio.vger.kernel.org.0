Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E376488954
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 13:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiAIMUY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 07:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiAIMUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 07:20:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2221C06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 04:20:21 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b7so13126009edj.9
        for <linux-iio@vger.kernel.org>; Sun, 09 Jan 2022 04:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKBTo16De6qv0eh8eLddwg5uN4qLOWYfODyDPcQOj3k=;
        b=p9kTDjr6J6EWFiLYI7eLyWmuH++3GCJyyHN44MnR6aY3QMKa88wxa4PqM9EIWgcM5L
         ZLo+NZzwrDdFTKd8Rlw3c760CdQhLQYM38Dy5vVJjgpVzDgCGfWjyPioz9cNshj/lFiQ
         KELvcDaUATF+RAdCQP8+U+4X36iCI2jrUi2s5NKgk1NQ8ukASCMt50BDOMaCkWn2BNfG
         V+Ib1yA/vTjViNQJae06DZXaNz06rEPg7v5CUIwKLoXlgv8JmH/or8E4r2oL/GiAPaJQ
         6fZ7eY3qoFsJPO0pLpwc84Tuoy8DsHh2K643GKHG60X7XTMk/tLYTnrbZpuQoblT2uIP
         5bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKBTo16De6qv0eh8eLddwg5uN4qLOWYfODyDPcQOj3k=;
        b=6l+t7kLqhL6PRbv0ikZTrPk5fU3oQUQtC8dZs0D26QyoAOgA7oPxjjYVAPd/SVwms4
         zEKX1mCuopTE+4I0mi9WEZ3nvCFrDQdf7lJW8gWRPPtn+UI7GLsnxrCeUKZj8FahmwuX
         61w2NmJKP/rO7eDJYPPCpCNzR2vDxlJp1pfM9XL3O0FizZ39C0oghY5MF3joiQ1BkQhV
         2cTS9H+6roBRz6jGPK2FrwQiQMhsjGNCCSsZjJcxgxOp3kJiahoxTF4OIohxXMU0wiEF
         xjyitBeVvjqQZmfxNlyglxi/dsjQNz5aH2F+SOkUIFFohORVQ+XbktkRnOhsq8cIzttf
         3JCA==
X-Gm-Message-State: AOAM533ph97vYNuhIRejFkpREh6YQa+Vj9EDfYB+JNnVCIqtiujKEtah
        QNMRoxSeoOC71JGXz/d4P6qyHiROFyhMEob0csY=
X-Google-Smtp-Source: ABdhPJzsd/LD1caQtCWeFwQSdLyxXI1acDxI51/riGjI4XvAm56fZu1NbtOrRCg9ismfxOUWbpN1hdH+O6YAUvIyus0=
X-Received: by 2002:a17:907:a0c7:: with SMTP id hw7mr3014619ejc.579.1641730820192;
 Sun, 09 Jan 2022 04:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20220101203817.290512-1-gwendal@chromium.org> <20220101203817.290512-4-gwendal@chromium.org>
In-Reply-To: <20220101203817.290512-4-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 14:19:44 +0200
Message-ID: <CAHp75VdPs6BcA2uka3irNr3mNBY9T-Dtw7J0M=Emm7_RPo+1yw@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] iio: proximity: Add SX9324 support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 2, 2022 at 6:28 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Semtech SAR sensor SX9324 is an evolution of the SX9310:
> It has 4 phases that can be configure to capture and process data
> from any of 3 CS pins and provide independent detection:
> proximity, table proximity or body proximity.
>
> Gather antenna data:
>   echo sx9324-dev3 > trigger/current_trigger
>   echo 1 > scan_elements/in_proximity0_en
>   echo 1 > buffer/enable
>   od -v -An --endian=big -t d2 -w2 /dev/iio\:device3
>   (at 10Hz, the default).
>
> Trigger events:
> Setting:
>   thresh_falling_period: 2 (events)
>   thresh_rising_period: 2 (events)
>   in_proximity0_thresh_either_value: 300
>   in_proximity0_thresh_either_hysteresis: 72
>
> using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
> antenna pad, I see:
> ...
> Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
> thresh, direction: falling
> Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
> thresh, direction: rising
> ...
>
> Datasheet:
> https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf

Jonathan, I noticed you have applied this to testing, can you please
make Datasheet a real tag?
I.o.w. put it to one line and drop the following blank line.

-- 
With Best Regards,
Andy Shevchenko
