Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4956322D326
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jul 2020 02:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGYAOr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 20:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgGYAOq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 20:14:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F29CC0619D3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:14:46 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g7so3342273ejw.12
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+Vu9pSlrXeJ0YA5vWHf53k6LVNR1H6tyHZmx21hYRQ=;
        b=SjdFktkRZL5d9npLMGNf69oDrZeerMTNoyzDanecRnbmMLkkCIovy5VZzvZI9H6ZrE
         wf7ggS1ZDWHplJE+/Rr6YYYW2Z/GmcKEAOxxbY8kHCtfA1cZZuMsSF4unXlrp05YmoKp
         BzaKkLMhAS/juljjaUHYbMbZIBZuyPfCEsagQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+Vu9pSlrXeJ0YA5vWHf53k6LVNR1H6tyHZmx21hYRQ=;
        b=Y44yEmHuW7dWG4MUe/0fZOF+T7ysdbFqF3jDr/Sm1BpfWvdOaB44rsymhLWfmmBQjq
         Mn3Tx05aPtksyI75EBzOSSlYvYvrj7Al0d0bWbqua3VFnuhdx5/+0wG+acRdHyTa5x2v
         arwi/ys2pQvf3rzQjI9geceb864jAkdgp08vK5x5xZwofEKrdFwjupKoj1XKHa5twm4E
         OgBi7QVOCmuI+0rwUOEUbJrXungQstFe/yO+whk/gsaomCQXdwY1PJPnElwiiGKT+gFl
         3kd9o8m/sPHy5WSWscvMl6G7iEmzNkk9off0E+ZZRt+49jW91U00ifb+hPcrjoCzXkUR
         eaLw==
X-Gm-Message-State: AOAM530uFAbGMH3XLcnWvkxBNWcXpIrlhzcaiMMTaDoZLzKruDMYO0K3
        cXuRlsAkw2tafEUvaWJYyiXy/cSdIkw=
X-Google-Smtp-Source: ABdhPJyuHEsZdrXQEWWsTkTDrrRzQXBFvfC5eSn5rPUBazHPvkMp97HnktMlge71Er9B8+KFriu0tg==
X-Received: by 2002:a17:906:2f17:: with SMTP id v23mr11193237eji.343.1595636084972;
        Fri, 24 Jul 2020 17:14:44 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id bz14sm1630319ejc.88.2020.07.24.17.14.44
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 17:14:44 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id f7so9729530wrw.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:14:44 -0700 (PDT)
X-Received: by 2002:a5d:6744:: with SMTP id l4mr8918727wrw.105.1595636083918;
 Fri, 24 Jul 2020 17:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-4-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-4-swboyd@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 24 Jul 2020 18:14:07 -0600
X-Gmail-Original-Message-ID: <CAHcu+Va3wWW_5eONbdD_VL2H3p-u3-jv_MxBR7G5hFwCr6w+tA@mail.gmail.com>
Message-ID: <CAHcu+Va3wWW_5eONbdD_VL2H3p-u3-jv_MxBR7G5hFwCr6w+tA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] iio: sx9310: whoami is unsigned
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 24, 2020 at 3:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This is an unsigned value, actually it's a u8 but regmap doesn't handle
> that easily. Let's make it unsigned throughout so that we don't need to
> worry about signed vs. unsigned comparison behavior.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Campello <campello@chromium.org>
