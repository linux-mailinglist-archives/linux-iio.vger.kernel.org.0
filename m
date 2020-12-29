Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262F62E72EE
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 19:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgL2SOb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 13:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgL2SOb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2020 13:14:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430DBC061574
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2020 10:13:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id r4so7484130pls.11
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2020 10:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Itp4qxOsoCkyYzM6gWjbctls0jvA7j3xDvLC9u9/Pfg=;
        b=Mlz3tDtT85ZPbZtoudBCVYkfixGIUVRs7vmEbiUcszuNus/uuwij6FVwyFPev1isWd
         gKdMscyTrGbxITNd/8piZjdbZawJa1K1KbNsre8MnXjO3aOgcrsEMc25eUb+lsjEorEK
         NX3p8cQwMDtWj7h+QdVhN1EdGEPgPid54aEQCBBhP2kz8eCR+D6AJrkEWQnUso83Xp6O
         r+EaRTd2tcXJbQ+hfzdOhnXQn3iKySvl3342Y7JeSWqNpp6UPwUCb5AWLplSECeRyzc4
         JO8VITdwNg6NGpiPgG864kKHzBBWgCFYAUmWkRvQyR2B7TWrbOYkSfsju6qyfr769agO
         cKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Itp4qxOsoCkyYzM6gWjbctls0jvA7j3xDvLC9u9/Pfg=;
        b=BeFf8ix/lhun+PDqTEYGfngr+NN9Fb71Uh5Reg9swpCNf1MP/f/dG0YIvqmqPE6Xc1
         XBtSrxjNYXPm84HO3zblmeloARjUki3voOWhXPCIrOrDLfhOTE6fDzJWMejXmaYUBb5g
         zL775VaTQm6d9LQRg2ctIwLSjkZuabp+lGl06E3Q4jDf7am03FBJm2ZlKkxHYR1pZVDh
         cWpudNvPsJkWpzdTcqUV5kQHIQwKSVUZqmXoYk0g3Qc5cCFHqC6iG+1O0A+xu1FFRGel
         1fu9LFN0l/iVexyihucHobt+ZWbC4cHVRzpa9+W8/bYKaZ7Dn2+/j5JJ9ZRftibTzqh1
         3Jag==
X-Gm-Message-State: AOAM531yRKMq6BkQg84VEzvnQ3eZP/j17I5VbrlVDbOYGTXGhicyK1qt
        UnVI3FTG6vOVYU9zLIDmlZfGPLsBg6kJXwn7Fw8=
X-Google-Smtp-Source: ABdhPJww1ncZXJIwXQ90ir19uXPeTvpxaAfSNgWmuTMtCSg888i0isFctarmXuhQvvzzjzQf0P/oMS1A+/mGBlVvKds=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr5116875pjb.129.1609265630569;
 Tue, 29 Dec 2020 10:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20201216214107.774969-1-gwendal@chromium.org> <20201216214107.774969-4-gwendal@chromium.org>
 <CAHp75Vfn=KtzN7zpm+pRES3L6R9k77GhHUFkxjrHcV67Vwx7kA@mail.gmail.com>
 <20201229172439.2a65580f@archlinux> <CAHp75VdQF7truiuWshYbvCAan2Qc0TomTesLwv2dDFhF5qkxqg@mail.gmail.com>
 <20201229175202.76682fcc@archlinux>
In-Reply-To: <20201229175202.76682fcc@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 29 Dec 2020 20:13:34 +0200
Message-ID: <CAHp75VcchW=rK00pQJcYD0-9txYcWVCfqvOs=Q+jNsBgcaNNfQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: acpi_als: Add trigger support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 29, 2020 at 7:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 29 Dec 2020 19:33:39 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> It's not the same. As stated it's the inverse condition.  Could add some brackets
> and a ! or, flip the logic of the whole if condition and not return early.

My bad, you are right.
I think I had something in mind about indentation as well, perhaps a
separate function or so...

-- 
With Best Regards,
Andy Shevchenko
