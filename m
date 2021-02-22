Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165B23222D5
	for <lists+linux-iio@lfdr.de>; Tue, 23 Feb 2021 00:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBVX5m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Feb 2021 18:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhBVX5m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Feb 2021 18:57:42 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F2C061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Feb 2021 15:57:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v5so8456778lft.13
        for <linux-iio@vger.kernel.org>; Mon, 22 Feb 2021 15:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o8XmHJuqm6GAV6sy5fGrRX2i8hInLVNmSeVAA8voUfg=;
        b=Uzw7upNZN+BpJQNDmmZzOnUKnDgEe4xc7wVlr0LtTa8xk2i7gk+05vXSmAoHrGk1mv
         8XalADmL/1RNX9Xwa0sDZZn/ZH6B9sdQsbPOCnm07Q1de3UbuuBeioMX0a3P5CWLZbgy
         hT7i8HuGM2LyOtIk8707rDLSkEcVOAliXjlpniepqxMdbZ2qPcFUqkJCxa4CwBq83X5S
         MPXAsERJ6XdU7SeGNNea8S+1qT0LD+DXRv1OUP1Hv4FXZRHOaT/zUj96UBEYyvTQShXp
         ykGyLxz4MbCtYxI3k9DU8eb0BkSKvkDBczi6jod6+kPqWlQTWvJdXWQWDIo8oZdD10TX
         4gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o8XmHJuqm6GAV6sy5fGrRX2i8hInLVNmSeVAA8voUfg=;
        b=Aie+QX4ybgfkUGk+hNATdkkiW4L8jnRRSAGn2Bgcf0OCzWF7Jdi39VS/LU1xM4bJf+
         5LSP6KGS/a7Bqj5ujYjUvaE+ZD4gQYkOB6FHWE6rMh9CHYop9pYWRDXzDjgvrZDQKTVF
         jEadZ1ofS47AfJE1nipHZ0wC2td2O2H/2vpfECZ6f8GJebukEQwVJtERaeI9+KGEVMpm
         ouMvP8cK3sGWNyLJfgMOMAOLzmuIq5r6IiXWmTnD5MIyBvnDfSvljMk0EOaPBo1EGCHi
         +n3tw2My5FbRFyrXKoYRZ4CZFxA1jNl9xW4U5WDpz4HUtrr9z+YYJJpWrxwhEpx+270g
         a4+A==
X-Gm-Message-State: AOAM533UuP3DHJi0DCDJfFqRsqwEJHCTe1IWPLZFy5xMRZICiM3mt40W
        ZBWTP6WcMIuxG3xMAaYianti7RMr1iuaFf10uTMyaQ==
X-Google-Smtp-Source: ABdhPJwHZgSXOLoV890kcnE4t5AaOd59afNXytrz7BeSEFotFpTE+yH/0SMRPGldtr/Rip5yblXwpJYSnVfdBxvZ8Cs=
X-Received: by 2002:a19:70e:: with SMTP id 14mr14444457lfh.157.1614038220290;
 Mon, 22 Feb 2021 15:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20201224011700.1059659-1-linus.walleij@linaro.org> <20210221161801.42532e87@archlinux>
In-Reply-To: <20210221161801.42532e87@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Feb 2021 00:56:49 +0100
Message-ID: <CACRpkdYyUWpxm3SbSL13gD5jtxabvV4UAo5fGk_BzvObRfviGw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ab8500-gpadc: Fix off by 10 to 3
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 21, 2021 at 5:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu, 24 Dec 2020 02:17:00 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:

> No idea why I didn't pick this up before now.  I guess I forgot it
> over xmas.
>
> Anyhow, now applied to the fixes-togreg branch of iio.git.

Such things happen, was just gonna poke you about it,
thanks a lot!

Yours,
Linus Walleij
