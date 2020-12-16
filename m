Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1F42DC3DD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 17:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgLPQRF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 11:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgLPQRF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 11:17:05 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3687C061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 08:16:24 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j13so1895362pjz.3
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzmLKyj18bddwzKxMCS0D6SM5elZtcyMI5kSlrHeAn0=;
        b=TZrwV56TBzTY9WbhM/HWeg/LYaQgmqLewJNLI9mGm8FL/SyZ97uO5H0oMnRlFq7Hgb
         CxEWTQo+3yW/fqJOSZD/2vNaoT8yfTkv8s+Jhvr6QBXLTG4oQK8qrP6dENk/r7/uYxsR
         gKmxlN5QbFZOJGCC0y/2klLNrp1EZFbAy8zEKD96cfX26nofvcNHaKkSB52vFdxGirPu
         mmKBf5M5sXOGzv/i8patGDysg4jFbkHlXHLioOJbykYDh15YV4ubqeg5l6IrjlvGdFAl
         GlPj0xP2wu/SO1t9RyUFEbFkW/rbAvk1hxDr/VSO58k5FFdLc0U4n7kQk7IvWoTOf9i2
         tcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzmLKyj18bddwzKxMCS0D6SM5elZtcyMI5kSlrHeAn0=;
        b=Z+OyoQRHggxJQaeH3BnwVbpR3+wr17e53T+1NeE7n0aAxUtiKr1txgVEyftwPz64a7
         iPBHC5JkQ/rNxNLUgqKBhF3nJDdUbHDf01xGmzDzvcubCImA7ElDKBxF78MhnT2aAymy
         wea2B908mEcWyz7uGGB6INK6I5vrYCtZGoFkrEM0Hwdw/KfjznAjcta/Ll6rKAOkKq2o
         dK1TrP4xngITZiDYBIvXEPqWHrFmdJP8mbID8+FtAWyhHINiBC/mqKU5nudQ6kzUwZgk
         8z9z/hJSy7EUNzd5NE8gZlCGjfSSebWuntFC2D4+K9829rMg3EV0uVAWRF+JELiSiBPi
         8CJg==
X-Gm-Message-State: AOAM532XBMEI4AJrcMHYAwtD4VwwwtgVIiyAtzP7UDz7RPsySR+2RfVl
        /1c2IZLpxx7uyQlhX8G/Ex8LRTiV//2nK0zC7iY=
X-Google-Smtp-Source: ABdhPJwlpFoW1To6NCjzfLOhg8PbnTYQLLi+yaPzRXh5bZ8aEvJl9WVMWdJQ0dfBi2lQMctHYy4oLo9+Sew5Xc7Au3Y=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr3752319pjb.129.1608135384531;
 Wed, 16 Dec 2020 08:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20201216060233.597689-1-gwendal@chromium.org> <20201216060233.597689-3-gwendal@chromium.org>
In-Reply-To: <20201216060233.597689-3-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 16 Dec 2020 18:17:13 +0200
Message-ID: <CAHp75VdR5qEGUgCrsnZYw=CNc7cyFPUceZZBrBzG9duveqB71g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: acpi_als: Add local variable dev in probe
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 16, 2020 at 8:02 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Use dev = &device->dev in probe routine for clarity.
> Remove setting parent of iio device, already done in iio_device_alloc().

...

>         struct acpi_als *als;
>         struct iio_dev *indio_dev;
>         struct iio_buffer *buffer;
> +       struct device *dev = &device->dev;

Try to keep reversed xmas tree order.

-- 
With Best Regards,
Andy Shevchenko
