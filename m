Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA24456747
	for <lists+linux-iio@lfdr.de>; Fri, 19 Nov 2021 02:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhKSBLp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 20:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhKSBLp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 20:11:45 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C25AC061574
        for <linux-iio@vger.kernel.org>; Thu, 18 Nov 2021 17:08:44 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so14156760otm.10
        for <linux-iio@vger.kernel.org>; Thu, 18 Nov 2021 17:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KPVdckZlM/ClPNOf5UPj8agvFxQs1ZhSV7NeGMvXwQw=;
        b=m4D4Pvlp7ImnA2P7eiAmzSk0idaeXe/huYUlw3cz9b5/XbIQ4ixAQxmMgABy/Fm17H
         YbNzYLsD3EC8NJDIke9jnEsTwGfKbJUTLXX4I0+Ne2RWMWsxDqhDXzYJCQLJPpKA16Q0
         rrRx/dZ9OXjbiLvu/l4EtHAyuMbqU3HOHZHAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KPVdckZlM/ClPNOf5UPj8agvFxQs1ZhSV7NeGMvXwQw=;
        b=0TdAzGuECBGj31ur1IC4+bzctpbd8hS/96jONN9wronxxxhOZnq4gCpcibnof9gSEv
         X3cywpsN9SOwJbB20KtQ42yZOJ3n05SuN+5EopZd7cfe7Mm6aSOx+q/38sL0jl9MJWat
         WstJOoX9WRNBO7BHiCDEEUJKWwXmCePEfsJ8MabVE1LqhKTjzuKs41oaHAXgRZz6nsv+
         9Ic/nmVvsfBlvc5J2McOSC1eYlocoU+UNQB+A+Ce8ovHai1uLHZvyByq7hajmWanrTDt
         rOnTb+hpqVd0nbwMyF4FmC1y3qO5P905CPKpkkosplk2YgrxhX4QdieIB2tAj+H9Qej5
         ICMQ==
X-Gm-Message-State: AOAM5316u6xAxIygfGuz0Q+SJw3LLJh2NhMiYVR2NJ3sscsdOoNAPNl6
        wb+8sASNmjOH8ywPbGFmMq72Gr0goHcBXBcEmv9CTw==
X-Google-Smtp-Source: ABdhPJyyDwIl023Kg2w2movbV70jbLyjO866NIxOZmdFJFUlzhhBzVKiE0UHkgL7hgI04s9Gh56C4gMksKpQwxVKR5s=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr1255270ots.159.1637284123926;
 Thu, 18 Nov 2021 17:08:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Nov 2021 02:08:43 +0100
MIME-Version: 1.0
In-Reply-To: <20211117091653.2829677-4-gwendal@chromium.org>
References: <20211117091653.2829677-1-gwendal@chromium.org> <20211117091653.2829677-4-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 19 Nov 2021 02:08:43 +0100
Message-ID: <CAE-0n527a5qRsdY-TRvSJnLecsXvw6ng5_yob__VYwRRTq5avA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: sx9360: Add dt-binding support
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-11-17 01:16:53)
> Add support to configure sx9360 from dt-binding, to match device
> hardware setup.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Why not squash this into the initial driver?

>  drivers/iio/proximity/sx9360.c | 85 +++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
