Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C2A25966D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Sep 2020 18:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbgIAQCP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Sep 2020 12:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731695AbgIAPnt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Sep 2020 11:43:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC60C061245
        for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2020 08:43:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so997540pfa.10
        for <linux-iio@vger.kernel.org>; Tue, 01 Sep 2020 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=x8Z9wFHU5eJIz7vYKW4wsTnm7g9XBK4yOanCvKB9vjM=;
        b=XjFnaTJZmA5aVtH7IjnlxheI47kFzEJ4agCy9CFsFrJocEXppx1FX7tJFIC+Nsvz5C
         iZskAozotXH0nF+KDwZpSo5ugtemrAbisn6hO6tSABZhue9FEmxd7W++zZ+KWuP5C8V2
         z5x5QUtioFI85El89P/Hqu0++DQotdobhbtGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=x8Z9wFHU5eJIz7vYKW4wsTnm7g9XBK4yOanCvKB9vjM=;
        b=fKo7tmVBtoUGCxC6H+OtVShF+4rCc6zlIleuhjFsWeK+G8FXnI6dJE/0P+wbuFJMSh
         hwa2rmRJbSl52OvNuSFYYtCp7U7oA2RjNYxX6UtKi1vUfQhQ28wploQnORxjnZ0xlRSp
         Her1sC8VcSB4Uh8O2BAkJL/n4/UAJy2IaW4AGoNt/1owz7XtyXK3wjLvyraV5iNokcgg
         iDgxoGegNOmHo42x9Zbbs/9CdE1LvlWqKSgttVDOI3xjdsCNWLXsR8WA1tuqaqvs6opL
         +94Q9JI6CqLzpnliE9jxd9HAlH6dRgRHtkErx3iOqwLcQyX3cxbcR4VHZSgI7WdSWc8a
         r4hw==
X-Gm-Message-State: AOAM532kOabXRkXgFGEE6iKnjoqBsd3hCzP5UYpFAc06rdAXP1tMhBaV
        YZ9IHPjbSTHhoX+KSNMMDA/6bQQ5Bxpq4A==
X-Google-Smtp-Source: ABdhPJyNGI5kBf/qAyktQrVkh0MPvczLzRTDwPGSTM/NCSklPkckoC5nnaCi8Suu2jOejF/FpswMQA==
X-Received: by 2002:aa7:9598:: with SMTP id z24mr2336329pfj.223.1598975028043;
        Tue, 01 Sep 2020 08:43:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id s68sm2421932pfb.91.2020.09.01.08.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 08:43:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
References: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
Subject: Re: [PATCH v2] iio: sx9310: Prefer async probe
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Tue, 01 Sep 2020 08:43:46 -0700
Message-ID: <159897502625.334488.7103007623601336114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Douglas Anderson (2020-09-01 08:19:43)
> On one board I found that:
>   probe of 5-0028 returned 1 after 259547 usecs
>=20
> While some of this time is attributable to the pile of i2c transfers
> that we do at probe time, the lion's share (over 200 ms) is sitting
> waiting in the polling loop in sx9310_init_compensation() waiting for
> the hardware to indicate that it's done.
>=20
> There's no reason to block probe of all other devices on our probe.
> Turn on async probe.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
