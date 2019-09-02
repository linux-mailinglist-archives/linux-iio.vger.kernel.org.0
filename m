Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF38A5D2A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2019 22:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfIBUlC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Sep 2019 16:41:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40364 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfIBUlC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Sep 2019 16:41:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id v38so10720082edm.7;
        Mon, 02 Sep 2019 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/6xZYkgl4ocSqmwrHXLN+0O+x2+BOQMBtBz7Y33HFq8=;
        b=uSLbfQPDAcBsaxTcXTs7bxHorDIpkF8/bQWuFPf8D0/arS6TmVjKnjoXhcg8cRA0f8
         e84ZQSgf/VANlfdOsVBJHjNr8GTYlAwOIlrNoa7Ujj92GY1jO/3FbCw7H6r08lzC39et
         3oyU2ZHjbtg3xZqUU2dqC25754xnGeWSAfBMCXNneHrws0JXyEo91fjTU5flrJj0ufnu
         zCq1RWVtzQni6KAaIuLpxBRIciIEgQ8hfPJkoqP5vjZvZ7wLs07Et5YfVoGz7Gvct34M
         V6m9Z6jSXV0YmavIrtBfN333cT6KY4HAmNDWp70k7Xqg8FwZkY/OSJOeN8HN3QPuohtv
         kzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/6xZYkgl4ocSqmwrHXLN+0O+x2+BOQMBtBz7Y33HFq8=;
        b=tfOc5znxCvCEpWBZzo68Mpp40Hizav3MV3g8x82d/6HeyDUgP4s7XV7uwJJBXF1Ln3
         7g99IjQbcjs4m0ODI0OJ5G/UDeOOydMAfPN26BvNI71CK0k+dHMVNfibmiNo/IRkyKUk
         U/Kco1IxpktlgqDG24HEd6mZbyexJoehRb7DjPUovzACZdwOR2YzLBnI+nsxXCnPiJiJ
         3aCsUv111qtGFSsPVJPB8L4Jf0Ebsfku9keuzXPfoJOrL2JtzgoYWvcKtvRDIS8n1lqe
         cykC3oPrLCoxMh2QPHGWG9sHSEOr20VAXZeGA4spIO1K32wYUag55HMFwPwFs8WU/I4k
         umUg==
X-Gm-Message-State: APjAAAVaFqKf/NL3X2GvvHPg9EL4RAy454lnf4mFQE4kDyrroPNOx1Hn
        1K1CmSDew+jdvEp6LpT2g+xgQo+kgn5KeHCJgbQ=
X-Google-Smtp-Source: APXvYqzkGpl0pu44qDC0uA4IX121wLLKZE0M+hrRSi3CbuBwKmftDNqCzqy4uvMsNkzIcxWoyGa7h9FxzLr5ayiQOhg=
X-Received: by 2002:aa7:dcc3:: with SMTP id w3mr26706924edu.202.1567456860910;
 Mon, 02 Sep 2019 13:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190901105410.23567-1-repk@triplefau.lt> <CAFBinCD96nJBPnyNgWA6CgwE2kZrkXB3-cgbV9aQLB=JtbrN2w@mail.gmail.com>
In-Reply-To: <CAFBinCD96nJBPnyNgWA6CgwE2kZrkXB3-cgbV9aQLB=JtbrN2w@mail.gmail.com>
From:   Elie Roudninski <xademax@gmail.com>
Date:   Mon, 2 Sep 2019 21:40:49 +0100
Message-ID: <CAJJ5kavS6RU1tK-BqgWD-VmJzPuG114y+pNApYay=+xwCtAwQg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson_saradc: Fix memory allocation order
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Remi Pommarel <repk@triplefau.lt>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 1, 2019 at 12:29 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Sun, Sep 1, 2019 at 12:45 PM Remi Pommarel <repk@triplefau.lt> wrote:
> >
> > meson_saradc's irq handler uses priv->regmap so make sure that it is
> > allocated before the irq get enabled.
> >
> > This also fixes crash when CONFIG_DEBUG_SHIRQ is enabled, as device
> > managed resources are freed in the inverted order they had been
> > allocated, priv->regmap was freed before the spurious fake irq that
> > CONFIG_DEBUG_SHIRQ adds called the handler.
> >
>
> Fixes: 3af109131b7eb8 ("iio: adc: meson-saradc: switch from polling to
> interrupt mode")
> > Reported-by: Elie Roudninski <xademax@gmail.com>
> > Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> thank you for fixing this!
The patch fixed the kernel panic I had, i can now successfully boot my
meson-gxl-s905x-libretech-cc boad using patched linux 5.2.11

Tested-by: Elie ROUDNINSKI <xademax@gmail.com>

Elie
>
>
> Martin
