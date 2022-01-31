Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52D94A4096
	for <lists+linux-iio@lfdr.de>; Mon, 31 Jan 2022 11:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiAaK5z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Jan 2022 05:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbiAaK5w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Jan 2022 05:57:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75E7C061714
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 02:57:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id jx6so42151405ejb.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Jan 2022 02:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6BLKQForHMY5t2MCaKeUXYwLUgft3GORVcOYZPl0zM=;
        b=FyBXw1xbKyK2Ko0lP0kOm3gFZjcadBYPhbKyHOfo0fOS3uBEf1Rl8OX7UL/DZLKkas
         1At5CJyE0J2RrZUNA7DLhMw5rkE9p0zBcGd4ky4dkDMW0C4nCIdaBkqgNuU6/m0u/CuR
         4t4MzVuCata52SHFDjN59wCk5r7e7U+L5uoVKf8HTtKxJr6BuVhtdIz8TPbhZB40xJwW
         lLbRztmjaZ8CI6Dwl5Q8OTdy3bbbql7b6CBxhDKJTq2/+4YEOm4kBFakG79NmtkKVpxy
         dFwdOR9zffSXX7skEOOm51RTEliNDlBvQw31dlsnCRz4UckZ6VKtxlHCzA2JGe3Z+xdH
         NZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6BLKQForHMY5t2MCaKeUXYwLUgft3GORVcOYZPl0zM=;
        b=gtlSN9wHgR34XimNetwwh0xHzWef9a43jGH6bBK060C7c8FXR82h+iPdKVNCVAnZk4
         buK0HWbNsSMMM0GRm9UDpeRsVsIMw4ceFZ/fz4TJjxIYXXbNODzbx/rV6/szD8BvJFkA
         IxWxWwfjSmctdnLY8tJm2RN74T6BYQcvxp0Qm3v79QkccLY5Hom1Yej4D9qHs/Ng+2Vp
         0v8zbRra4oIJ/1rLJj9DhQBbQjPJEoVrP0+etUBAQSHJKcpW9IsHDOvyKOQBDPowng4A
         VC0/fKNqt5D/K2T0RsIWbp/FbfawZ5k6lm9IUSRqQkrjH9QCsBG+TKOvi9cgzq76BY1S
         fyCA==
X-Gm-Message-State: AOAM532xzsYkRsJTL+AZaYkfFhDDBv0kxLl3X5SP+HzPnxgrac6N9Tzb
        pH1ttV87dljZImkB5Ny4txaG9qdnbkhGJCS2SJ0=
X-Google-Smtp-Source: ABdhPJzZxn7PURiEf0DfZGFAY6t/yXOnBLPi6ziQmmnL0KpHdY9Tz0Ee8gvraGrwV+xFt6fhQmdnlq0zuoVyKRFFmqE=
X-Received: by 2002:a17:907:a40a:: with SMTP id sg10mr17148779ejc.44.1643626667166;
 Mon, 31 Jan 2022 02:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20220130205701.334592-1-jic23@kernel.org>
In-Reply-To: <20220130205701.334592-1-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Jan 2022 12:56:11 +0200
Message-ID: <CAHp75VeDbrPuQeyraFYR=P_Ft2K7-BMMdMDVi=sGEVznF6iTpQ@mail.gmail.com>
Subject: Re: [PATCH 00/16] 2nd set of IIO export namespaces
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 30, 2022 at 10:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Whilst I'm still looking for additional review on the first set,
> I'll take the quiet as meaning no one objects and send out a second
> set.  Note that I don't have anyone cc'd on some of these because
> I couldn't immediately figure out who was still active and familiar
> with the drivers.  As these should be simple to review, please take
> a look at as many as you have time for!

I created a script [1] for myself with some heuristics which showed to
work quite well for me.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko
