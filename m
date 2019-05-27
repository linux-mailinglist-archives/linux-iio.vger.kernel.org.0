Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138CD2B9BA
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2019 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfE0SDa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 May 2019 14:03:30 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39606 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfE0SDa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2019 14:03:30 -0400
Received: by mail-ot1-f68.google.com with SMTP id r7so15483275otn.6;
        Mon, 27 May 2019 11:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxUTt+IRMZU1MO/DCtvdYdxlj2EVWldyBya3jO1SugY=;
        b=pMFwoJ6IBL+RP91sU+epPWRQ4aLOO/Vtg6FGd193V/XeSyyGB9SvxrKqXP+pjIIc5G
         wFKbdMjqP2ASrMk/C70sC2ydjtvxY3L1Ld6Nlg5WPR6y/bRS/PzFDSeet7VX1QbWH35Q
         XEbOArS7wTSwE9CRFy4xBTejVgvAYG0EjjdbzufUaXOhMjjIBL8PByT2O6vNaVxACvor
         GBdXL51iMBLtpPUGh8rjq525SGle6cYkznGvOuLzVeTJww5L+FG0AKjWAyYfeWUj6xr3
         UaR0/VVQnNkN4UM9N7chRoeH0TDvYsGfcp9isLXd6ezQmNMLAgEtkvvaLBMihNtRRsvz
         GzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxUTt+IRMZU1MO/DCtvdYdxlj2EVWldyBya3jO1SugY=;
        b=NeAaxFO2Eg634RvteUYZwLOwcHRIhE2b876BhYr5OJ8XiAIizec8y/skmuqgvsj+zn
         vPVckn9gsGkYjA6QDfLVgKqo3k36P948BtXAZNP6C8xGi7cTjhDTreL4HHH95pXCn4Mj
         yFPO48AobzUbDmIy64SLb7tsy2ArxIojcDAl2//FxM7scd3VFcj3J5wn0bm+I2/7fPoB
         rgSds8NweEFXQ717cBoVdHhb/bkGzvmBw1C3bq1Kl1r21HeF5bJnuGvpnyg0E12lb7Bj
         8/A+BHr9XsiQB7gxSRNjNtakF9u/kDoKbGKqUAauZeSo22eGGtb9W3vOLGC+GIuWCVsq
         KHAA==
X-Gm-Message-State: APjAAAXQsnqUteXZVeRd1dYQBoihZCPZalySl662yKyDHiar0tPpkYqt
        p7DQoha1wsdMbUEJQ6RjSuYuk9pM1sE24BQmvQb6YxtUH/M=
X-Google-Smtp-Source: APXvYqytlNhOwJViv1/F5Pd4ZD+cwFDl4VueS054FLzGIPWGNcCpLHNZuYjzZg5F2AptZ6rL7Pb8f7FNysxRDv5/FpA=
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr2106178otn.98.1558980209280;
 Mon, 27 May 2019 11:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190527134314.4340-1-narmstrong@baylibre.com>
In-Reply-To: <20190527134314.4340-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 May 2019 20:03:18 +0200
Message-ID: <CAFBinCDETXBGm=_TCJUU4dpkvevbVfh5mAeYD6-O94sRHJnFbQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: meson_saradc: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 27, 2019 at 3:43 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
