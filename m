Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A810D23F73E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 12:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHHKcQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgHHKcQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 06:32:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A310BC061756;
        Sat,  8 Aug 2020 03:32:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z20so2405232plo.6;
        Sat, 08 Aug 2020 03:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXUAdTL9HDNPlh2H66Bb02Jf4nqSFr+pkDYlsXdTyU8=;
        b=BtcLBFKd+oAOhPzFGK/VKLBDjHSW77SKs2/NrnzC0OossO52UtxYjCzjN/kPDee2Z/
         /xU0s61+jrFU12psnY+d319CakdPx/hSdlKkDDREp4ix/F/n4B+IL0sbGaK2Z+n2qMyZ
         c+pflu28qtt0EkM1bMMTOamax4mIaqvPRIwmUE1ryWxNvqxfj+AuUQTOH2q1Wk2N4r2t
         RikuJazkyb8a98FDKxIIYZfaO5uTlsRWebBcy3+mTqDxev+hJzf5PtvD9Ql6QpvaU83t
         qiNeodIxXgUb1Sd7ihJzKZ1MP9w5QzX57ltFatph8FWyqnGiSmm8hIdf21/fjcy7IQmi
         V3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXUAdTL9HDNPlh2H66Bb02Jf4nqSFr+pkDYlsXdTyU8=;
        b=nSYxfJzFlD9TyTIkxlmatT7rNaQ57Pf9UuLhptRMBsDizIv1f/g5gUG/nklGCloRoY
         i7d3DkPQm+6n2ttw77mQnwdajNtG6P/OXybPqs8SERnTEihsi0mMpRuNlyvXKlSyW8MQ
         tjGPyEzLIESmKFVOnfReao5Y6ZgZnGEpN2gkgwVoDXkM5RdnzZDdTN4qFMCTr18rqZpb
         XcKPOjK1ttVINfYQo4erkFj/zXleYjgq2uwSimy1oYvL7XdzZeRGPEjPYHE0vEfxJsnz
         fV++LVl1bUsgzIGn5AdpNJKVwFDqLDc2L17pzZuYUCT+f+jys2ep/wjLwZZpSrv5A/lR
         1zpw==
X-Gm-Message-State: AOAM533KGvnpX+OseI3Farxb1MqisV8GdAsLO76JuIT3GtJNVJBcxXsL
        zmVo2iaT2wI2U3WQtWA0hIQL7S1drx45X71nHXjp/USDH+s=
X-Google-Smtp-Source: ABdhPJw4oljOPV7ea5BcAhevLx4ePfwgTD72Fly7b4r7lGon0ZUghcBsCLTGBX8ZZFeD22mYDJp6bRgpjo0nMb7E7k0=
X-Received: by 2002:a17:902:4b:: with SMTP id 69mr16776110pla.18.1596882734431;
 Sat, 08 Aug 2020 03:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200807232104.1256119-1-cmo@melexis.com> <20200807232104.1256119-2-cmo@melexis.com>
In-Reply-To: <20200807232104.1256119-2-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Aug 2020 13:31:58 +0300
Message-ID: <CAHp75VdvCMaz4d+moE-nNWJ49NYfa-UR85cdp75GscCLPO=bhA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio:temperature:mlx90632: Reduce number of equal calulcations
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 8, 2020 at 2:22 AM Crt Mori <cmo@melexis.com> wrote:
>
> TAdut4 was calculated each iteration although it did not change. In light
> of near future additions of the Extended range DSP calculations, this
> function refactoring will help reduce unrelated changes in that series as
> well as reduce the number of new functions needed.

I see you provided a helper for this calculus, but I think we may
reduce a lot of churn if you do the following:
- introduce helper and convert one/current user (no functional change!)
- do what you did in this patch, but it will move less LOCs
- do what you have done in the next one using the helper

-- 
With Best Regards,
Andy Shevchenko
