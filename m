Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C543447E2B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 11:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbhKHKnf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 05:43:35 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:43917 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhKHKnf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 05:43:35 -0500
Received: by mail-ua1-f52.google.com with SMTP id v3so30452909uam.10;
        Mon, 08 Nov 2021 02:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wNov6GAlcKvQXnG0Wu/LU+lWR950kMLXxUaSyHwxmw=;
        b=5yMb3PpxZibxEXcBGTPOZVzwGpgfspuKsnPCD445adeRGuXJKt0KQ/QTL1jiLg706F
         8Q7gqieb7WZEnSRGKAi1w7kuiCrz5OT13adDFcqtiT5nH8aU3/MQfpNFTnf3U9Ukmcee
         rNCMs2iuLJo1ChYqhcpFOjQIBwj9B0us4PTLxnukkU8kvRo1xFSu0exi+rpCxfxVW1p9
         JrYk5w0QhI37HGaLWvDjKD4XS6PNqhXdmiqWmf5uKvf5Yi6ZcBFDekvmULCFEY6tBHN7
         TxIePv9hek1IbOW440pPj5v+OivHwdfhGCSUFweiJhteB/RpBInS9VsikwUKAhC4Gubz
         5QpQ==
X-Gm-Message-State: AOAM530e/xFydqcGmjHPq8bxk7pCNatvEEJwIWHhc9XALoLtbZzZR/p3
        1PYYuPcZ1oPhPnzuwdpHXZlYXH4K9hzCTg==
X-Google-Smtp-Source: ABdhPJwdO5POiwjigQsDzY3OEKdI/AGPhBr0BnO9v9ZlAzniGH6Mp5SsDNmg9RSpIVfp9x4tjfmVCw==
X-Received: by 2002:a05:6102:11ed:: with SMTP id e13mr76159500vsg.57.1636368050533;
        Mon, 08 Nov 2021 02:40:50 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id p69sm2773896uap.1.2021.11.08.02.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 02:40:50 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id b17so30610858uas.0;
        Mon, 08 Nov 2021 02:40:49 -0800 (PST)
X-Received: by 2002:a67:c38f:: with SMTP id s15mr39316001vsj.50.1636368049727;
 Mon, 08 Nov 2021 02:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20211105015504.39226-1-vulab@iscas.ac.cn>
In-Reply-To: <20211105015504.39226-1-vulab@iscas.ac.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Nov 2021 11:40:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX7CmiTW9y0pOytWaH8yoE8Aa=eOe7DRYAm97USZcMBNQ@mail.gmail.com>
Message-ID: <CAMuHMdX7CmiTW9y0pOytWaH8yoE8Aa=eOe7DRYAm97USZcMBNQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Nov 5, 2021 at 3:02 AM Xu Wang <vulab@iscas.ac.cn> wrote:
> The print function dev_err() is redundant because
> platform_get_irq() already prints an error.
>
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
