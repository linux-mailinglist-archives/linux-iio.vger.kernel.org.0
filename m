Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549435734B
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 23:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfFZVFS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 17:05:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33464 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZVFR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 17:05:17 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so7838604iop.0
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2019 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRBmhGMcbQ4hALpmq1oAoDfVUyAe/BHGvMizr8MXf+c=;
        b=cOXL9rj7l3pbqbCoFjpGe9MIbEROS5HHtDQRmVmQEPdEXzTsUP2BvSROCfT2EMhBhR
         RgMATFCrT0RzmwXTd6xDBVKkO9juHSGFZ/NekvzXzdsrhyDEtAof1EVtHzUweX1v+ttI
         Y/+2lhob+k9r2UYiUECT1+fBwYeJPYq8BgTgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRBmhGMcbQ4hALpmq1oAoDfVUyAe/BHGvMizr8MXf+c=;
        b=l7G4Gi8EjkGkQj24XQ3wEAAPzDg4k4SH6/os7pSG1ecivvDxEqauruoKtYSVUshALo
         MchsuUOA7GjQCuWrmN3FmJ1qJy5cdO0I6y8sUZF66ElV4gaeje1ap4LRkN/vZs4zYppt
         JKLR28QduwoEkmg47oFGnDJesyEO0U2uCkSTGnp/vIuhMHIflR7T/0Bbj0j9iEpDQBk5
         QHXBXGors+y/y0bMwezcO7rIdJW1G0MoqC44IeP36S6HuW0rnWciCtoMNxOkWOWeLm+b
         0lTPj3Q2vFHGLaO1tvLqMY+rcPJL1XgaZV/9CGcCnjZDb/2stW6orbWNfSHfVjwgruKu
         u4Wg==
X-Gm-Message-State: APjAAAUnl4Lvt+YCL4LxKVGpNntSuHA81Rfi3bkT2VOtxQmhSm22DeA9
        BpA9Sq0MIbDzj9f2J8VriPDg2hWf5m4=
X-Google-Smtp-Source: APXvYqyAKSnRIIPY7ee65lGq9HKPbrQwq47XOg/xRgI7ZwBcsR8Og+glahbpRh4wE9DGaFg5YK7tpQ==
X-Received: by 2002:a6b:7a42:: with SMTP id k2mr274160iop.214.1561583116804;
        Wed, 26 Jun 2019 14:05:16 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id f17sm228863ioc.2.2019.06.26.14.05.15
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 14:05:15 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id i10so6438504iol.13
        for <linux-iio@vger.kernel.org>; Wed, 26 Jun 2019 14:05:15 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr228073iol.269.1561583114838;
 Wed, 26 Jun 2019 14:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190624225312.131745-1-gwendal@chromium.org> <20190624225312.131745-3-gwendal@chromium.org>
In-Reply-To: <20190624225312.131745-3-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Jun 2019 14:05:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WYg8d8ZHqcH7LWsSXx5-9kNP+nC+eS84=XNdaZi_7_-w@mail.gmail.com>
Message-ID: <CAD=FV=WYg8d8ZHqcH7LWsSXx5-9kNP+nC+eS84=XNdaZi_7_-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: cros_ec: Extend legacy support to ARM device
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Mon, Jun 24, 2019 at 3:53 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> -static int read_ec_accel_data(struct cros_ec_accel_legacy_state *st,
> -                             unsigned long scan_mask, s16 *data)
> +int cros_ec_accel_legacy_read_cmd(struct iio_dev *indio_dev,
> +                                 unsigned long scan_mask, s16 *data)

As found by 0day (see https://crrev.com/c/1678822), the
cros_ec_accel_legacy_read_cmd() should have been static.

I presume this will cause less confusion if a maintainer just fixes
this up when landing the patch so Gwendal shouldn't send out a new
version to fix it.  ...but if this is not the case then yell!  :-)

-Doug
