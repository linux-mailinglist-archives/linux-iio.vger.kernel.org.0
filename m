Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8222D187
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 23:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGXV5O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 17:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXV5O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 17:57:14 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE8FC0619E4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:57:13 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j186so5657879vsd.10
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e5ZO7ecIplgVGZE3pSmrS86woNFYgLHmLoVoYXhNGQw=;
        b=oQ1M6w5QAzqeJzt+SFRvwn2pwYb0joq4H65Na9q8NLD9b/ClfWMJwURqLssOZMsuZA
         H7DdRRFsellUUWvcItY1KH+MXc6vVT4LJZICuSNnw240Eh6J/+he4MpimjBqh0IrRM3U
         puqrZHkYW7V/AcEhCyeL/VoD2Jy8CmLexYrz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e5ZO7ecIplgVGZE3pSmrS86woNFYgLHmLoVoYXhNGQw=;
        b=lgRSaGawXj2OtK7GxiwUM2rXkNh3tO60ClKD7wWd8C75XJCK0BcOOqnUnSbSISiOwf
         VgjoN4csHccsZ2Sv09ymaZizVjHmjUNsfRFrAl55Ega6g8809/zw20lSQ0rBx4zOuQTA
         YvPbzaydMMLzTxxsMB9NMgCSQlXD+xeEfEaAlpcTSDbeXpr9InXWlo7vo3rRuJYyB3Lw
         teKtSa5TwG3zdhYmY5DtWfX9dFdmODw24AqbipSgHzC4rzZmvMxoQjyp0e7JWMUSivJH
         EU8DQERRwBNkIZZHKNyB2n45S73UXF49uQO3+SLW3H42u83gUJ8NvmKQ8IfqIXbi3hOH
         iPiw==
X-Gm-Message-State: AOAM531qYSRRIcRlXAUA1D3+STmXpjaYYZZWZYTpjvpwVuiat27LT1Aj
        1HfGMGrFYITw3QsCFvoCi7bAudBNNkE=
X-Google-Smtp-Source: ABdhPJw4vxgJEY/8b/sMqZtzDhff22lzgiBhSons7vAGuW0q2j2kYGLo1j2Hi5+8yo9klgiG0YpSMg==
X-Received: by 2002:a67:2c89:: with SMTP id s131mr9094427vss.26.1595627833006;
        Fri, 24 Jul 2020 14:57:13 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id k187sm277793vkk.26.2020.07.24.14.57.12
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 14:57:12 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id b26so1116794vsa.13
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:57:12 -0700 (PDT)
X-Received: by 2002:a05:6102:20a:: with SMTP id z10mr9532703vsp.213.1595627831736;
 Fri, 24 Jul 2020 14:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-5-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-5-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 14:57:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WL2wb+bj99KgDg4bTV15hU3k6O8UVz8WMNJXLeWNc--Q@mail.gmail.com>
Message-ID: <CAD=FV=WL2wb+bj99KgDg4bTV15hU3k6O8UVz8WMNJXLeWNc--Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: sx9310: Drop channel_users[]
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 2:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This struct member isn't used. Drop it.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/iio/proximity/sx9310.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
