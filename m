Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B4231147
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbgG1SIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbgG1SId (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:08:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CB2C061794;
        Tue, 28 Jul 2020 11:08:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so10304107pld.12;
        Tue, 28 Jul 2020 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1VrLH/XKbmztffVyI6XvS3PuogwTEvZ0IqEwc2qzu4=;
        b=HcXD+92Ly+397P7PkkQ+WiVwNNimIv2wlYmH6sbcrYO1F2NnbYzOgN+c38aovD2v/J
         Xl0HuZdgTtrzmHqKiN97qMDssDMzVOsgorkfdp85MqDArIyPSllJnNoZmBfdlqpMNQdG
         yTMupbOow5L52AAHRBCz3x2XqAhpgM9PCjiM0mmvg5xalzohd0YdlVAXc1CZ0HnJs1sU
         QY2QJ6lCOdEhElC31Af81TerszKToY2UijFDIjMA1iHkCvmX7zGEHP02r4l7RQ/v4IAj
         V3BDChPYeTgfa/IubF/i+fJMrGset+c7KoGNqDKk1REBR/ENRiO0llozzbtXbBE35yKB
         IIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1VrLH/XKbmztffVyI6XvS3PuogwTEvZ0IqEwc2qzu4=;
        b=fCmido9DASmO97y1wGbxh85snEAULcP3dQyQu46oFOxhHDmwD71PWWl5D639GCQOsX
         h9j7y69i/N9/RqwHz3awMl9Q4qiP3sO7VNW49aTijdieurUnWiEeNm5hEqII9zgoNzUT
         +FXecDawLDR+QLL44g+TT0kuzCh4XKj91tY7vV7Y+skWHRrBoPsY4StCc19EbssrHQag
         S0/7mpKu1tVVnO9THc2NYMEUxivNR2Z02R8piLNyXQrm2lSTYK88PYE9PvVPdDzPPtex
         f+SZqecNE7rpekR3pLCXPIqVJCc4UWwLNEhcfoyz8HtB+wi2Y9JOaAsikGI7S+zGmxWE
         2o3w==
X-Gm-Message-State: AOAM533sU4j6vQa3g9BVCzrfQn8JvXTjBpjaI4sF2mr5OEKonLyjQ+fo
        XaeAY+7lCbZcinAhZ61TluRQdq32b9LaWtMIBPw=
X-Google-Smtp-Source: ABdhPJwbXbd6FriJMYnTwxdHLrnRIBZLqgTGGlMPZal4642T+xlwjqeVpCwPijGfLG0Axf9jK810GOdxlRrVD1HyFmk=
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11mr24285972plv.255.1595959713382;
 Tue, 28 Jul 2020 11:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.3.I2a1314232ace4323af96f9981c1e1a4f31f78049@changeid>
In-Reply-To: <20200728091057.3.I2a1314232ace4323af96f9981c1e1a4f31f78049@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:08:16 +0300
Message-ID: <CAHp75VfOhoJrHEnC_Wh2qnOMX0pT1Jx92B0TFQ5=cfZsTSNSOg@mail.gmail.com>
Subject: Re: [PATCH 03/15] iio: sx9310: Fix irq handling
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
>
> Fixes enable/disable irq handling at various points. The driver needs to
> only enable/disable irqs if there is an actual irq handler installed.

> -       enable_irq(data->client->irq);
> +       if (!ret)
> +               enable_irq(data->client->irq);
>
>         return ret;
>  }

Can it be a usual pattern?

  if (ret)
    return ret;
  ...
  return 0;

-- 
With Best Regards,
Andy Shevchenko
