Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCAC2704DE
	for <lists+linux-iio@lfdr.de>; Fri, 18 Sep 2020 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRTPe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Sep 2020 15:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgIRTPc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Sep 2020 15:15:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C87C0613CE
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 12:15:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y8so7020182ilm.11
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2020 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVcMjIHy9E4IFHuIDNl53VHuarQUS4EdYjgqbtjGiM0=;
        b=Z18cQBDjCc4gCAcrTrv4fZ1O2xcFYZoOdzr3iudmka41cJYnhjfqjTre9rQllYNwV/
         IXMptpF7ElpxHDurroeh2boPUuUatjRuCoVVWLkZ/1vUchqaGT+v8bIRa9JBZP3w8Nv7
         xOtAc61ZrVtyMYjrnnlCZSNYN9o0wR6MLNvS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVcMjIHy9E4IFHuIDNl53VHuarQUS4EdYjgqbtjGiM0=;
        b=KJa5+nckAiDI9PVIhZnMMUfgP8FILZRmljFDT6rGSywDLqWXpntuq0iWqbUBFRg590
         XMgoCfw0psGua1oZUM4aBQVbTIVZIOaoqz92833l6I32pA8KjlZd6R0i4sNkE6pef1Cc
         J+gMvgSmhEBSdDMqahUIFpJZViBPVZy7MccOm5wRrWWeIaKbT7DAG/3Z3vcg87phRZMT
         H1kvx8+7zUl16BB1H3O2wzaDLLc+3zK6QYCbxS30xuvrLfQE+EubmHKQz25qsO7FILmx
         6KPGvzIaHlkS9Chd8B/SzZH82JNPAC7MhEHJ/5oEpOUGKC1t8MS2VItuok9XQTcTdmLG
         YzRQ==
X-Gm-Message-State: AOAM530Yr2xKHePgJt0WP6J6H4X96gdoNF6GolxwKyweFFv5fY27+UVD
        epRLsOwSV+fgGM3rcZzLEfd+w1NzUwj6bdconx4Q7g==
X-Google-Smtp-Source: ABdhPJylCQ+I81rMxBwRAhgBmMidV+kkc8Cp9hGWJeKABdHPRj/bOl29JnmFnb5iioaQQ0FOotCR3CcQCFqVm7dZ51Q=
X-Received: by 2002:a92:8955:: with SMTP id n82mr23868820ild.25.1600456531428;
 Fri, 18 Sep 2020 12:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200913112546.715624-1-jic23@kernel.org>
In-Reply-To: <20200913112546.715624-1-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Fri, 18 Sep 2020 12:15:20 -0700
Message-ID: <CAJCx=g=wrvEaE-Pwuy0KmtSux8Sgeiu9p3EfHdfwCV4xQGGUKw@mail.gmail.com>
Subject: Re: [PATCH] iio:magn:hmc5843: Fix passing true where iio_shared_by
 enum required.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 13, 2020 at 4:27 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> So it's obvious that the code is wrong in passing true, but I'm assuming
> that will actually evaluate to 1 and hence IIO_SHARED_BY_TYPE.
> The documentation however has this attribute as IIO_SHARED_BY_ALL.
> My current assumption is the documentation is wrong.
> If anyone knows otherwise please shout out!
>

Yeah this is much easier to understand than the odd boolean value.

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 7247645f6865 ("iio: hmc5843: Move hmc5843 out of staging")
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/iio/magnetometer/hmc5843_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index 1474ba63babe..780faea61d82 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -245,7 +245,7 @@ static const struct iio_enum hmc5843_meas_conf_enum = {
>  };
>
>  static const struct iio_chan_spec_ext_info hmc5843_ext_info[] = {
> -       IIO_ENUM("meas_conf", true, &hmc5843_meas_conf_enum),
> +       IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5843_meas_conf_enum),
>         IIO_ENUM_AVAILABLE("meas_conf", &hmc5843_meas_conf_enum),
>         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>         { }
> @@ -259,7 +259,7 @@ static const struct iio_enum hmc5983_meas_conf_enum = {
>  };
>
>  static const struct iio_chan_spec_ext_info hmc5983_ext_info[] = {
> -       IIO_ENUM("meas_conf", true, &hmc5983_meas_conf_enum),
> +       IIO_ENUM("meas_conf", IIO_SHARED_BY_TYPE, &hmc5983_meas_conf_enum),
>         IIO_ENUM_AVAILABLE("meas_conf", &hmc5983_meas_conf_enum),
>         IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, hmc5843_get_mount_matrix),
>         { }
> --
> 2.28.0
>
