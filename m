Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1923138A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 22:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgG1UHl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 16:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgG1UHk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 16:07:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57456C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:07:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g19so8108299ejc.9
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnz0jOHGhQ7071N749Two4h1HroTIuj/RiP18x35OOI=;
        b=Fw2kRNbpJHyRS+1no8N05uMus3XPhZET++7DGlfe6jJSIZSAzilD13sbJKzlBvIKZU
         VZxNwziJ0lu/iYgED5pnjaYig4DCwmb0+QuLlzBik3D/tlKW9LuxoTkPxVRciQOOKID1
         A3x28H2/8Eksk7/cKrMVrDL+p/piLtAk8Szms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnz0jOHGhQ7071N749Two4h1HroTIuj/RiP18x35OOI=;
        b=EtWXm5x07pBqi2xOpxTxgvOzGpjQarVuiBEkm14X/vrqq0zlX0f5c7dhrLSUiqyXTF
         mHbbRZiD4d7hJc5vbO2kAKOfYMtpfoSQK7OwF0BVVMg5DkqtDbBFf0r/o2BwAKgYhXSL
         cBZRDswRJdfhH7wRZeyfu7+HB0nZyU1OnkNPtVpC9CAbAdT66xdk8Ziz5hHlOc3a2I5B
         oS3aideMvXSd+iOzoAnyg2PajXnaVDaYzy0j03nRd9d2NkBSuDn2xCx6Sptil+nb/QPQ
         KeWvCxtbBQ5D4XHLnH5honQltt6idIxe9ny49ZhaCJC585grqcvCSIoviLHS7Sya2Bf8
         uJqw==
X-Gm-Message-State: AOAM532czswTMweCFsxFlLfDiAFNQAF2U4s1OI9agv8LFIENCVo2dxKU
        TgO/WdAXGsWWp/PSif3xU1JrzHK9qKU=
X-Google-Smtp-Source: ABdhPJzitlR/2G0jX+G6tQ+ZCHCwWzX/yvv/V4URpBqNE5ORT9uAedWygemZVI3K6xsJ06KVkOM3UQ==
X-Received: by 2002:a17:906:248b:: with SMTP id e11mr25753747ejb.280.1595966858661;
        Tue, 28 Jul 2020 13:07:38 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id p21sm52980eds.11.2020.07.28.13.07.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 13:07:37 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id f18so708912wmc.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 13:07:37 -0700 (PDT)
X-Received: by 2002:a7b:c953:: with SMTP id i19mr5308631wml.103.1595966856934;
 Tue, 28 Jul 2020 13:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.3.I2a1314232ace4323af96f9981c1e1a4f31f78049@changeid>
 <CAHp75VfOhoJrHEnC_Wh2qnOMX0pT1Jx92B0TFQ5=cfZsTSNSOg@mail.gmail.com>
In-Reply-To: <CAHp75VfOhoJrHEnC_Wh2qnOMX0pT1Jx92B0TFQ5=cfZsTSNSOg@mail.gmail.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:07:00 -0600
X-Gmail-Original-Message-ID: <CAHcu+VaDBj87stJ9JJkuerJkr8=-g68FhUUnKvfpN8uYaMBUhQ@mail.gmail.com>
Message-ID: <CAHcu+VaDBj87stJ9JJkuerJkr8=-g68FhUUnKvfpN8uYaMBUhQ@mail.gmail.com>
Subject: Re: [PATCH 03/15] iio: sx9310: Fix irq handling
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Tue, Jul 28, 2020 at 12:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Fixes enable/disable irq handling at various points. The driver needs to
> > only enable/disable irqs if there is an actual irq handler installed.
>
> > -       enable_irq(data->client->irq);
> > +       if (!ret)
> > +               enable_irq(data->client->irq);
> >
> >         return ret;
> >  }
>
> Can it be a usual pattern?
>
>   if (ret)
>     return ret;
>   ...
>   return 0;

I think this way is more readable. The alternative would have to be
something like this:

....
if (ret)
  goto out;
mutex_unlock(&data->mutex);
enable_irq(data->client->irq);
return 0;

out:
mutex_unlock(&data->mutex);
return ret;

>
> --
> With Best Regards,
> Andy Shevchenko

Regards,
Daniel Campello
