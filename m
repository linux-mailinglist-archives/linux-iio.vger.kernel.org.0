Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF12BB350
	for <lists+linux-iio@lfdr.de>; Fri, 20 Nov 2020 19:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgKTScd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Nov 2020 13:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730615AbgKTSbc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Nov 2020 13:31:32 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC2CC0613CF
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 10:31:32 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id h26so3415428uan.10
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7OcGIZK4DIQmCs0MRiTREZT+eK02Kd2oT8srQAYVh0=;
        b=oNrAv97R01ZPBXpaa4/GoGl6M2RtjB6dD90dTdlL/xBkGbRUGLt66iNnIWxbYCoLm3
         SwQ7gh347RrBJipvRcbnk0870OeY5XoftdqJG54iTeegaMKrE6RzFv+cLvm+Tjsb5sQ9
         GXUi93aCVxrpOPQa/PGa6bXKdZX6mx8Dk+6l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7OcGIZK4DIQmCs0MRiTREZT+eK02Kd2oT8srQAYVh0=;
        b=B7T5LgjaS3mXtEahTlUOPlmJq7J8bh5h5FCyBJp6PjHTu9p+b67awh9vGSkqCxZS/X
         kKmtBDx5wX7PHajcuYhBbdTLXUiaSMcOf28CBSa0zzpkuhwn8llZjQZsbcHdthcXo/uk
         m9T6+N0Y2plVizquN2rvG535oYqFDQbVuOhbikUDb3ybWkL/oMdr9ezoVhLeiZDS//kE
         RyoCzLJK6jhRUYmVWs9/eajdNOnmgURzvaqW8I6o+gCWj5e0DeUVLarvoT//cjLM0ZxF
         qXOD2KsyNaqua+sDWpxhJTiuyaPrCSd3XowoG09WbkM4a5pHU/7TeTiiegZ5e41JbDnq
         Qmyw==
X-Gm-Message-State: AOAM533oipDXHkfi5W1kv/imRwPPWitFmtO4tuG/AXYaQ0Hg+jTXt+6q
        DQOPv6LEPYx1TodAa583VXMv308Qo9yeVA==
X-Google-Smtp-Source: ABdhPJzmnZ80qvyvNtPKTurOthm6G6AIYSaFvO6rm9F92yQpdEg1M1J9n4SDpOmI5VPJp130inuUGQ==
X-Received: by 2002:ab0:6dd1:: with SMTP id r17mr13536991uaf.108.1605897091165;
        Fri, 20 Nov 2020 10:31:31 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id f201sm452808vka.44.2020.11.20.10.31.30
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 10:31:30 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id u7so5501268vsq.11
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2020 10:31:30 -0800 (PST)
X-Received: by 2002:a67:4242:: with SMTP id p63mr13488967vsa.34.1605897089926;
 Fri, 20 Nov 2020 10:31:29 -0800 (PST)
MIME-Version: 1.0
References: <20201120182944.543428-1-swboyd@chromium.org>
In-Reply-To: <20201120182944.543428-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Nov 2020 10:31:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W3cBGGTksNTh0m_j7VPJJvo6qwUm6+9-z=RhnN5av0dA@mail.gmail.com>
Message-ID: <CAD=FV=W3cBGGTksNTh0m_j7VPJJvo6qwUm6+9-z=RhnN5av0dA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9310: Fix semtech,avg-pos-strength setting when
 > 16
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Fri, Nov 20, 2020 at 10:29 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This DT property can be 0, 16, and then 64, but not 32. The math here
> doesn't recognize this slight bump in the power of 2 numbers and
> translates a DT property of 64 into the register value '3' when it
> really should be '2'. Fix it by subtracting one more if the number being
> translated is larger than 16.
>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1 (https://lore.kernel.org/r/20201120073842.3232458-1-swboyd@chromium.org):
>  * Changed ternary to consider 17 to 31 as the same as 16
>
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
