Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE19327A5D
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 10:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbhCAJFZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 04:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhCAJCS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Mar 2021 04:02:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6DC06178C
        for <linux-iio@vger.kernel.org>; Mon,  1 Mar 2021 01:00:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id q25so3986081lfc.8
        for <linux-iio@vger.kernel.org>; Mon, 01 Mar 2021 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uE9borHEMrgJCyjxz/gfKybHkysn1/lLyQwFQLLHbe8=;
        b=gLH1D7j96qeX/iG1elrzyIyLXIAeAGbmTVJlphU2J0zhEnizlGrGgVSsIQhnkAOlOI
         ks+emsczsFq4yIhBJwrGuNg1RVE1IIkWTA8FjT1YV5NeS1fcYzRRdxbazJ93k3stpWhs
         36iEtlJwGR0cs8Bg1SpZN94rehP8f/oxAKndE4ZnVnAxqr7jolJ8ZOpL4nV58hJ/jdH4
         PpBQvEyDIQ/3GYcA8Vzdz55UuFZdBiNpboRX0VgRZJlufrxkjNsc0FYOvviXtwqttZNM
         oZYZ9EnTqRrYfgEUcXfOqRP26TT80wn7RSExLspOEf6xr6+9hx1oJosaglLPUtO04tq2
         yToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uE9borHEMrgJCyjxz/gfKybHkysn1/lLyQwFQLLHbe8=;
        b=qsGiFkl3v7PHfSC36M8qfffVFERPG2zDDHjc4DubABee9TgYoN283Z9a60EyP1M1r2
         9idAxqHKUwHEGZqM5Oik7cEuBiZ8PvJ8stwSeIrSi0OU2uWTCl5Zr8+wyaQ7Z+Nkkmg/
         GfhnRkYRFMEijW/iQHUbjAByCUoPZX/7YuVwgxKARA7JBgqtzbWd9FwCtzzjXjTZeBvZ
         e3QhWjACZKWy4343WI54TMKtk1uF93Me/q7z20goJuxC53Tj+Yjcp4c5BK3nexJ53plY
         qoVl5r6LxZt+w3CI7yhzO1cWjZa7doxiyVFneAmZwmF0zZrnv7NLEx7eRSFdjBq7ub7J
         1EKQ==
X-Gm-Message-State: AOAM533DA+zUQNQCo9oDdoHx/Y8dOMktHgpABHC/J0K+NsncunEGBdmi
        zsWyqK4QdsEiUOsMpTQ7m3Rk699Na+fNxG9r0tRHfQ==
X-Google-Smtp-Source: ABdhPJxPhUuUvUn2jjwJ7deZwi3S/u6UODvUFceSW2ZXsfXoWlAMQh/BaKQMZYjWOCvrDgupDkU3KTHR52W9qCVpOEU=
X-Received: by 2002:a19:548:: with SMTP id 69mr6653750lff.465.1614589246540;
 Mon, 01 Mar 2021 01:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20210215153023.47899-1-linus.walleij@linaro.org> <20210221154511.75b3d8a6@archlinux>
In-Reply-To: <20210221154511.75b3d8a6@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 1 Mar 2021 10:00:35 +0100
Message-ID: <CACRpkdbk80cK34vDNjfLkpeso4dC8ZXOe5WGgi2PP8KHSLxuxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: magnetometer: yas530: Fix return value on errorpath
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 21, 2021 at 4:45 PM Jonathan Cameron <jic23@kernel.org> wrote:

> A bit of bad timing on these.  I'm running behind on pull requests for
> my fixes-togreg branch so it doesn't yet have the driver.
>
> Hence I'll pick these up in a couple of weeks once that's rebased after
> I send Greg a pull request.
>
> Give me a poke if I seem to have forgotten them.

No problem, the fixes are not critical in any way.
I'll track them!

Yours,
Linus Walleij
