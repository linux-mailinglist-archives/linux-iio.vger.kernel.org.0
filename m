Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35B7349423
	for <lists+linux-iio@lfdr.de>; Thu, 25 Mar 2021 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhCYOd1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 25 Mar 2021 10:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhCYOcx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 25 Mar 2021 10:32:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15059C06174A
        for <linux-iio@vger.kernel.org>; Thu, 25 Mar 2021 07:32:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id u10so3397208lju.7
        for <linux-iio@vger.kernel.org>; Thu, 25 Mar 2021 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1sVuoMij/7n2UdWPkeJfUHiSUpUf6VAs9pGmr1Tl+/U=;
        b=xdCV7z8ncusxLx6cDtVfboYuB/XSTt67G3jT5LFVblOG08znZ+l51gw9sGpYJsJiY5
         nWsqApApOY0NGMxQ8up3QjyMuITLOh/nf8lEiwM+Ha1gpTmcpj+fYxw37GK+3G5i45aj
         vnUoKnZeJQC2U51e7D+xA72u37i23FlJruduRyuFkoprU6KPXBW5aiJYT6Vl9bdhrMtm
         WuohABnoT/IVeMIZXTIbzv+AK7PyHb9EvBm+luDSCYqf4ew62N5c5CQTdaGLd7ZoZXvm
         hFUwvjHNSIxdg/Ht4+iqb6aeaA2W0ImVZbSvQn72KigbssDUxP+R8CVmeTlv/U/7Nfoq
         /7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sVuoMij/7n2UdWPkeJfUHiSUpUf6VAs9pGmr1Tl+/U=;
        b=UtqOiQexwhhnYC0sqMmABy4VwrIW76MdpO2sjmMEUaUhMrglcWsQXV1Rh1B3xBBVIC
         MkKl8QQP/8oFNxnBmxtqMDHuHC//XLlIyKJbzEFYIdtKX45PPfwl3gELOQ3r/ypvtzMT
         3oNQQnMt+2+Odh5puYDZAwiFIjwhQZ1WVeq/BAxnZt3tnLxhZrG2bCSdC2Ac2YkiWzLS
         4XcMAkfnofYHJI6acAjQhb7irUoW999ndZjQxe7hmBTZ1SP1dFllB8XcMtSz7c9kS3fR
         6Oaxitzpfnc7azYOWWauiukaHhycVaysN5iGzxLL2fhiyXPCqLWEFXUf+9CCqWhAqzPz
         XXug==
X-Gm-Message-State: AOAM530XntSetWyZZ4elzc/6I7Q3RfvjMnd8vCjtevYFMztcpTBmZhWZ
        xdTlHTcqeVh3omzsiXF0aCddvSrf/osaAzKuWsDCgg==
X-Google-Smtp-Source: ABdhPJyz1mDKoyHbkhdlyQo0MBySgQI8OXDDBn9w3eQUi1U0cDDTsKIHX2Kn3jxXSSr6NcvBuW3PzOHdWC4QHjfDVIo=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr5911721ljc.368.1616682770689;
 Thu, 25 Mar 2021 07:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210325131046.13383-1-lars@metafoo.de>
In-Reply-To: <20210325131046.13383-1-lars@metafoo.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 15:32:39 +0100
Message-ID: <CACRpkdazszFo58VFwE8HESjjZX56YykQWN9LbHaDcUhq5g9rWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: inv_mpu6050: Remove superfluous indio_dev->modes assignment
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 25, 2021 at 2:10 PM Lars-Peter Clausen <lars@metafoo.de> wrote:

> The inv_mpu6050 driver manually assigns the indio_dev->modes property. But
> this is not necessary since it will be setup in iio_trigger_buffer_setup().
>
> Remove the manual assignment.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

The word "manual" confuse me as much as usual when it comes
to a computer program and makes me look for the man doing the
manual work, but I guess you mean "imperatively" which is a word
noone uses.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
