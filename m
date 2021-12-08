Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509A846CDAF
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 07:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbhLHGZD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 01:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbhLHGZC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 01:25:02 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E80C061574
        for <linux-iio@vger.kernel.org>; Tue,  7 Dec 2021 22:21:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x6so4779820edr.5
        for <linux-iio@vger.kernel.org>; Tue, 07 Dec 2021 22:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHN9c5HFmLsmEgxzuMz5MG1hTGc8vwHgtyRefgqtOag=;
        b=RYiMF9oI7mC5wtSKtRdng1P9x8x+2FuElmCaIruWdVZMeJh3JfhwbcPQJfZZ7dd9he
         E4a4oOpAVONjIFImQfzGKKj+iX34gSD4vC1MTP3MCuinBRDBmlg1C8aPPyKMUvgwsAoR
         vOSUQoF0DKGveYLEhku8OXqMzDUShA/UHOnmZy+tgwJzD0Yv9TTNAL+oSPc/LKDLNDou
         flfPLjBw5EZNDTI5yg5hy6is4S0fPZt0+QLCAgHO2P4fugqFC0zpexPxqLxbtlEEb5f0
         BnU/S8aYJkylJdrOg5+PLA2tWrPKGFRHM2KX/3othXay6x8BJtMNDWPyFktV5vVtim2P
         bUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHN9c5HFmLsmEgxzuMz5MG1hTGc8vwHgtyRefgqtOag=;
        b=yHgiz5bs0dXkwTkgULqcfpDHPhhqMtTM1rooduYh5MKCT2MnDrJwSYwIc4/LOOfICM
         oNzmn9GDwnD2yG8v66cHjXqYRkU3zOgoh76HrHf74aQanj/CTsCiIpwgFMiLoL/zo7oq
         5FtIgDZ2NKsE2ZQIVDgD0tI+8oDsMMvmdQotmpT+xULPziXlHQYGz0QXsRBuLXfmZb8U
         1apvsTfsgxjHrUGMjDCs384QG6UnTN7WIqgBZOEl8qCVgAA13GujlV5Q3swRai4rqHNs
         0x/fjmCK1XxBlrLFltZeEf3lvu/w6NbXxsPfGWqOywKHFqzXkJy3vo7DWgjaetKKBfsD
         GTZg==
X-Gm-Message-State: AOAM532CmtvSdqtDa3A8xu5b9PdvPf+Hr1TcONj1DsK6Ailsu4E7EN8a
        IqFev8WUPeHDqCE5xrrxK8KAMgA+tZjse35EuBxy1RsKkKlcIw==
X-Google-Smtp-Source: ABdhPJyKX5ZispRZdIlbkwgYrpzYdqLm7SKpj4OGGeAjbimrOB6wcOfEjWWoJFSPHGu1Auhh0IoROSv725Di1U+jF44=
X-Received: by 2002:a50:c35b:: with SMTP id q27mr16331697edb.154.1638944489836;
 Tue, 07 Dec 2021 22:21:29 -0800 (PST)
MIME-Version: 1.0
References: <9bd04e6d-7418-9d01-6e80-52fd7e84086f@deathstar2.nl> <20211207161338.000012bd@Huawei.com>
In-Reply-To: <20211207161338.000012bd@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Dec 2021 08:20:52 +0200
Message-ID: <CAHp75VdB5vquGKnHSZhkLJDnUTXo68-mvHsRfPg+eqgb8pueTA@mail.gmail.com>
Subject: Re: iio display large numbers
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Henk <yoda@deathstar2.nl>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 8, 2021 at 2:56 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Tue, 7 Dec 2021 13:40:19 +0100
> Henk <yoda@deathstar2.nl> wrote:

...

> Two options for this.  If the thing we are controlling is the raw channel then
> we have the option to provide _scale reflecting the fact that a large value
> e.g. GHz is not normally controlled at a Hz granularity.

But some sensors can be really high-precision ones, although I
couldn't imagine a value that requires more than 32-bit for that in
general engineering. Where one may ask for more is something like very
precise physics experiments in CERN :-)

> Where that doesn't apply or the range is really very big we do have the
> slightly nasty option of IIO_VAL_INT_64
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=6bb835f3d00467c9a5e35f4955afa29df96a404e
>
> This is very new, so not in mainline yet, though it is queued up for the
> next merge window and should be linux-next.



-- 
With Best Regards,
Andy Shevchenko
