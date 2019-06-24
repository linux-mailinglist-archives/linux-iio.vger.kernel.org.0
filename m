Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA07C51A3C
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 20:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfFXSFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 14:05:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40307 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732729AbfFXSFe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 14:05:34 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so4149244ioc.7
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2019 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pg0U6unXfUxIT46wtst7onDuWrGrEtcBrNhAIvmz9K8=;
        b=TcoArsBAEXyEelQ9h6o1qMMz4D2AfWUgDduRJkZA/2pqgzvwg/gNkwAc9y4kpYMfxp
         WQ9ok0iDaU5tf2XSvUjpR/1CDaWF/yHHgK8oPQh/WcezgLXF1+C9Kru7aIGm5VjMSQxd
         pfChf1/c01HkBJdtJPdTFvR0ZfXyWuAzumbxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pg0U6unXfUxIT46wtst7onDuWrGrEtcBrNhAIvmz9K8=;
        b=ihgy9P9WCEFPJFzCa4U1UkCmMyT9d7WGRJAo5rk16MHDfZUrbliAKPd0g3oS+dyf/i
         37dhd6ljJ9N2pB1RMIaFz/SNDgE3SKGQX4gjiz5krDPTOZsArhkJJ9Wyzn2pCf6IL1Th
         TLayCDYgoUxB0pWNYvsiDfS0TR6LJbCfuL8QX/3GQtK+NFD85WP+M9qhist+Fq5dY7R+
         5OiSvdz4Xs22RQQRk0jX/rrxCO/oJOM+Lor/f2CIXMYamOH1Sl+MommaU1GLwAgq+kEY
         atX0L24kID9e88uJ7dSD6Hpc954k14t6UtGbM+8ilnSePVOymPmXmaIs0I5m+g0Lw0OF
         5U3g==
X-Gm-Message-State: APjAAAVIEiGXHfEIMP/LoOuxxMecQm9Ca8xLJ6qGdFU9/gMcbJg74hyU
        Tsng2cn/BxKL8NM5GIlpEBG/Ycdt+0Q=
X-Google-Smtp-Source: APXvYqxhTDHfMu3YU7LQx4kRCwiwKqV0lq1jcd4gLMvTZt7efeFUxnk9FEUhLedwJkXiVz/8+gnz8A==
X-Received: by 2002:a02:aa0d:: with SMTP id r13mr25833918jam.129.1561399532757;
        Mon, 24 Jun 2019 11:05:32 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id v26sm9291599iom.88.2019.06.24.11.05.31
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 11:05:31 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id r185so2819570iod.6
        for <linux-iio@vger.kernel.org>; Mon, 24 Jun 2019 11:05:31 -0700 (PDT)
X-Received: by 2002:a5d:96d8:: with SMTP id r24mr1703630iol.269.1561399531202;
 Mon, 24 Jun 2019 11:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190621024106.158589-1-gwendal@chromium.org> <20190621024106.158589-2-gwendal@chromium.org>
In-Reply-To: <20190621024106.158589-2-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jun 2019 11:05:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VoW7Yc8jET4AAu2jD2K1wm6W25KSKn8UbhZKxFLQsiHg@mail.gmail.com>
Message-ID: <CAD=FV=VoW7Yc8jET4AAu2jD2K1wm6W25KSKn8UbhZKxFLQsiHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: cros_ec: Add sign vector in core for backward compatibility
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

On Thu, Jun 20, 2019 at 7:41 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> To allow cros_ec iio core library to be used with legacy device, add a
> vector to rotate sensor data if necessary: legacy devices are not
> reporting data in HTML5/Android sensor referential.
>
> On veyron minnie, check chrome detect tablet mode and rotate
> screen in tablet mode.

The above sentence is still a little strange.  You just took the
"TEST=" out but still left the testing instructions?  They sound odd
like this.  You could just drop it, or perhaps instead change to:

This change is part of a set of changes needed to let Chrome detect
tablet mode and screen rotation on rk3288-veyron-minnie.


> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 4 ++++
>  include/linux/iio/common/cros_ec_sensors_core.h           | 1 +
>  2 files changed, 5 insertions(+)

I'm decidedly a non-expert here, but since I had nitpicks on patch #1
and my nitpicks have been addressed, feel free to add:

Douglas Anderson <dianders@chromium.org>
