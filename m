Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBF24577D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgHPMAV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 08:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgHPL74 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 07:59:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D09EC061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 04:59:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so11664718wmi.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jgq0Z6pXlni31D4ItEMINr7qL6V0bVNcfG6H+Jh9kBo=;
        b=fNbnChqgev9RLJAdISUKWLt/xqBHKZ5rGjA4vDvUM+sL00Kr8xyKPwpj6K8wvkNrVj
         eKdFV/I4tAGApmnMBuc88sNUSlt15q82/Cy+DXguQM1Y2whPMfIq673DFY9ECb+e0Jvz
         tME7oDr45qm21gJS6VMVQLTRkZLkEQbtcXwvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jgq0Z6pXlni31D4ItEMINr7qL6V0bVNcfG6H+Jh9kBo=;
        b=KJgN5hmReEQVvoLoOwuzsVOmMUABuTbiDmwIsUj1OOrP61avCqRR04kv9M7ma5ea9P
         9iVq14IV499aWNgko3g+V8Pi1102NkBfDdNrtBZ99+h3Fd9m56x6TG/wNE4BEgWVoe02
         uxdqWY9gcBWYANafjL3smjCFPLwWcnLYuSzcSa8flThGBJah5mHlDU67PafMzUUmLWNF
         mx1OwbX0pqd+VnthQ4qUmSqCGpxg2ETtAJgXGAHAYXnb+ISmrNaE+5d9+1zcsMOlVFhN
         2n7M3IPOeE6xPBbCgCyFHyru7kbuMwZ2yLJVky/gPqjs/M7ziYkJ7AXPa5CofJeoF3hc
         xR0w==
X-Gm-Message-State: AOAM533qboWmFXmKq4uZ1SYYbnyWnulQYpSwRk3Ifucv8gYy/OyhLbgg
        mVofuJnsp879MX1sJllhhWrO327EYY6nerqRCSlvFQ==
X-Google-Smtp-Source: ABdhPJxqA03wzmb66p7Q48xNLzQOVhftQxNRBj0TSrjWM2XAXVUigh/RZJKfUpkEpySJysOMJ5OergccG3d0wK350X0=
X-Received: by 2002:a1c:5f54:: with SMTP id t81mr10249596wmb.2.1597579193031;
 Sun, 16 Aug 2020 04:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200811134846.3981475-1-daniel@0x0f.com> <20200811134846.3981475-3-daniel@0x0f.com>
 <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
In-Reply-To: <CAHp75VcreDeik-pCQPXV2RQVAEPFNRjGS8Mutvxwog1khVka4g@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 16 Aug 2020 20:59:57 +0900
Message-ID: <CAFr9PXma7_FUVZbGk7kzfc1xgYH8WdMWj6FZuO4wO=kNp=iR-w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and SC7A30E
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On Sun, 16 Aug 2020 at 18:55, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> No SoB tag?! Hint: `git commit -a -s --amend` would fix this if you
> have properly configured Git.
>

Sorry I wasn't aware it was needed for an RFC.

> On top of that, can you add Datasheet: tag with links to the actual
> component datasheets?

I will do that for the v1 of the patch series. All of the datasheets
I've found so far are mostly Chinese
but the register tables are in English. I've collected them together
here: http://linux-chenxing.org/silan/index.html

Cheers,

Daniel
