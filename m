Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB23046BD
	for <lists+linux-iio@lfdr.de>; Tue, 26 Jan 2021 19:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389957AbhAZRVE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Jan 2021 12:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389272AbhAZJCN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2021 04:02:13 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD562C061573
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 01:01:32 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e22so32157783iog.6
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2021 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nhR9mD9H0TFK/7Q4sbvxs/mH562z5NDQ2cjdGw63X2M=;
        b=OJ1iRa3GrGj8tFADRzommDS/ci+cHk3WKhJTIcd9lVxfjvlEsCwa5CiyKt1DKj2Mrq
         jGjyAAauphbuG0R3w0zVZk7CllhNp+gbAWWQ2huMhQzM7OAolWDK7ZehdKwhRhLP1Kqt
         DOIhhTNCiDVLPw+dYVdNJezLghme9t+9LVOt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nhR9mD9H0TFK/7Q4sbvxs/mH562z5NDQ2cjdGw63X2M=;
        b=l491F/61+ZSoWbXPDYXGJqxOpmk4FDOdaoD7u4VFJ1thTN5GgqnfO1Xgms31DSGFuc
         bd9QM/xwhg2nKljma/csKjBF8UEfJKfHDK8qL5fQAIdcut2/BgbjooacmZPBDO1WjH2n
         YX+7qQL8YH3rEJBxJ3mKc/OHkjC22cjzaCdqSSAjCCuSxM4DnMKiWDB9a7F8EJ17wgrZ
         d08C53BUIiVrI3rcWKExzQb8d/R/bk97iZYox0H1ywxn+q6wP3pBUxqnvJd2bM91Hpie
         l0pWxKHnIu4/qj5+wvD7oYkv1VZx0nMZK1JjuB3lClIc3hMNr1M9eC5h4K42gczgUMPj
         0tOg==
X-Gm-Message-State: AOAM531YaJ1cpPrk1ZZ1PIj8KhzmqlZ/1DKo35f6K0rq48mrbCC4YoWE
        4mwV3O+dai7lfQjb5TDrrfrDLEEL2Ury5XGQ2naMHg==
X-Google-Smtp-Source: ABdhPJzug/7kGlHPxJ5M650QDhTVVipv/eJ8OkxWLLW45E//wAdAzqYvFHYbc+fP90x9uC2Fytdj0PT4/Lx9wdB/940=
X-Received: by 2002:a05:6e02:2189:: with SMTP id j9mr3773074ila.98.1611651692123;
 Tue, 26 Jan 2021 01:01:32 -0800 (PST)
MIME-Version: 1.0
References: <20210125195654.580465-1-pmeerw@pmeerw.net>
In-Reply-To: <20210125195654.580465-1-pmeerw@pmeerw.net>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 26 Jan 2021 01:01:20 -0800
Message-ID: <CAJCx=gmC1TcnbiBXqEZX0X=V3unHJdGmvD6jtMsJjxntk7bgVw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: iio: move Peter Meerwald-Stadler to CREDITS
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 25, 2021 at 12:07 PM Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
>
> Haven't had much time lately and moved on to different things.
> Thanks Jonathan for the gentle introduction to Linux land.
>

Sorry to see you go. Cheers on future endeavors!

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>


> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> ---
>  CREDITS     | 8 ++++++++
>  MAINTAINERS | 1 -
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/CREDITS b/CREDITS
> index 090ed4b004a5..9b4f2fc469e4 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -2524,6 +2524,14 @@ D: Linux/PARISC hacker
>  D: AD1889 sound driver
>  S: Ottawa, Canada
>
> +N: Peter Meerwald-Stadler
> +E: pmeerw@pmeerw.net
> +W: https://pmeerw.net
> +D: IIO reviewing, drivers
> +S: Schie=C3=9Fstandstr. 3a
> +S: A-5061 Elsbethen
> +S: Austria
> +
>  N: Dirk Melchers
>  E: dirk@merlin.nbg.sub.org
>  D: 8 bit XT hard disk driver for OMTI5520
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 546aa66428c9..c29bd9b90ac2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8664,7 +8664,6 @@ F:        drivers/iio/multiplexer/iio-mux.c
>  IIO SUBSYSTEM AND DRIVERS
>  M:     Jonathan Cameron <jic23@kernel.org>
>  R:     Lars-Peter Clausen <lars@metafoo.de>
> -R:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>  L:     linux-iio@vger.kernel.org
>  S:     Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> --
> 2.30.0
>
