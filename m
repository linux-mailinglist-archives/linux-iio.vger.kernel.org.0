Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BE02CA75B
	for <lists+linux-iio@lfdr.de>; Tue,  1 Dec 2020 16:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbgLAPoW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Dec 2020 10:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388237AbgLAPoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Dec 2020 10:44:22 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFBC0613CF
        for <linux-iio@vger.kernel.org>; Tue,  1 Dec 2020 07:43:41 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id w71so1130314vsw.9
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 07:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ublsz4UjgUbpORn7U8gi9gf1r205x1Lev92pLKzC+V4=;
        b=Xk6hhXSm+W9hpw1fjMz5TIaHAZ4a3owISlzNaCn3o4SXxNcE7DOPms41QRA+DoWxiZ
         /au3JLy6qsQUT9OYtQGIFDvqSUgzNm6Fmp9C+S4MQRxnc5FjOJXQ7ibMFMBcn8wYknpy
         qlG9VoJpHOjHpthKqCDQcyIx4tR4sd3Ieaapk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ublsz4UjgUbpORn7U8gi9gf1r205x1Lev92pLKzC+V4=;
        b=gG8HY1DHvg0dj8WxRxnLlSId6t0HQ2zZIn65oHt8UydXwtyi7ZaSz4EqaRpLJg92US
         D6Xg9GuaAGIKqrmXfRPi1pcknDV2Jx7HQfY8FbSU1VAh3Db6aEyHJdbzehEH2afOiq0h
         /T+RLhnCqpMxgy8mERVKg3y16vQ0wR/I+kbXoCQuDrEvFZNwg5FGcZM4KOMNCTge4gq2
         AH+ynSxdmPJ4nK89hcZ/LaAlEWN7szMEg3W1dwGP4ENtMV1ZPWzYtCZ5wtZ4T4lSpXgr
         lHbxmTroUbFXrt504O+U++OUJ93Gwdaa4FBPfPRIVgTP2znBCOXXQvF+SB5ob9GGtejG
         3Pow==
X-Gm-Message-State: AOAM5320mWylaqx1OEkE7GlLmEjuv45VUYAncSO+rHc/96DAm3srBkKR
        u82lixOkIZU/vwTFF7nQigkgoi6ZwKPkkg==
X-Google-Smtp-Source: ABdhPJwSol2sJX6Vsca2VEP8ngOgambnv9BS6d8gAcLMHpoCHrbd2NvM/0VPw3WgE/v650/H9UI5ow==
X-Received: by 2002:a67:cfc9:: with SMTP id h9mr2953062vsm.23.1606837420828;
        Tue, 01 Dec 2020 07:43:40 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id u16sm81604vsc.23.2020.12.01.07.43.39
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 07:43:40 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id y26so712283uan.5
        for <linux-iio@vger.kernel.org>; Tue, 01 Dec 2020 07:43:39 -0800 (PST)
X-Received: by 2002:ab0:6285:: with SMTP id z5mr2961275uao.0.1606837419257;
 Tue, 01 Dec 2020 07:43:39 -0800 (PST)
MIME-Version: 1.0
References: <X8XqwK0z//8sSWJR@mwanda>
In-Reply-To: <X8XqwK0z//8sSWJR@mwanda>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Dec 2020 07:43:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WVqTX1Ct4wNMghp2+kmz+J5D18r_g9FHF7dQtHUREaoQ@mail.gmail.com>
Message-ID: <CAD=FV=WVqTX1Ct4wNMghp2+kmz+J5D18r_g9FHF7dQtHUREaoQ@mail.gmail.com>
Subject: Re: [PATCH] iio: sx9310: Off by one in sx9310_read_thresh()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Mon, Nov 30, 2020 at 11:03 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This > should be >= to prevent reading one element beyond the end of
> the sx9310_pthresh_codes[] array.
>
> Fixes: ad2b473e2ba3 ("iio: sx9310: Support setting proximity thresholds")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/proximity/sx9310.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
