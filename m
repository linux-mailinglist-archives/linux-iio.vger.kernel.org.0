Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5748679CC3
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2019 01:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfG2XYy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 19:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfG2XYx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Jul 2019 19:24:53 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD869216C8;
        Mon, 29 Jul 2019 23:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564442693;
        bh=wfISxyG+4xV3u+yxlqZGIvkRUeNLBrZabreIQWxsSdU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bVE23u721FLzaxngi2MUY4F06qPgLJvv/baqfJ6t0A1bKOG4E2spxg+kxW2ulkWvm
         cDzEfghfNit9mk3GAvhHOdaNayc4Tf81WbmjLunXTR6v8e8aVKqu3wyb64wT336kuF
         2Eggm/9o13I1XnSPwzmNOtz2xP+4B6Pej6IrjsaY=
Received: by mail-qk1-f172.google.com with SMTP id s22so45312671qkj.12;
        Mon, 29 Jul 2019 16:24:52 -0700 (PDT)
X-Gm-Message-State: APjAAAVfNLEnOx3hj9aAXKF/0r4MDuB8KfWG1hFHkAMYRO2oOPgqyFAX
        gJcbDdgkFQScEaHtNVJ9iu/GKO71v6FaVLHv2Q==
X-Google-Smtp-Source: APXvYqzY5ya7QJ0w5KWtcD8heY+Jsyhgj4n66xL29WKjYNOqnCvGQoUberoWQj9zJEk4fySsTU/pGiOPBLYiuMGT7Ak=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr75655382qkl.254.1564442692098;
 Mon, 29 Jul 2019 16:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190723073641.27801-1-alexandru.ardelean@analog.com>
 <20190723073641.27801-4-alexandru.ardelean@analog.com> <20190727195623.42c8b4f3@archlinux>
In-Reply-To: <20190727195623.42c8b4f3@archlinux>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Jul 2019 17:24:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLXTnrtCr4hVVc9HrOkkvwGWk02EibdutfUBm4JDnJO5Q@mail.gmail.com>
Message-ID: <CAL_JsqLXTnrtCr4hVVc9HrOkkvwGWk02EibdutfUBm4JDnJO5Q@mail.gmail.com>
Subject: Re: [PATCH 3/3][V4] dt-bindings: iio: imu: add bindings for ADIS16460
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jul 27, 2019 at 12:56 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 23 Jul 2019 10:36:40 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > This change adds device-tree bindings for the ADIS16460.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Really trivial, but convention (as driven by what git am -s does if nothing
> else, is to add extra tags in chronological order.  So Rob would be after
> you.  I tweaked it which I don't always remember to do.

I'd argue it is in chronological order as the submitter added my tag
and then sent it out. If you applied it and added my tag, then it
would be after (but before yours).

> It's not consistent across the kernel but I'll fight for my little corner
> to be :)

More consistency would be nice then there's less tribal knowledge
about maintainers for submitters to learn.

Rob
