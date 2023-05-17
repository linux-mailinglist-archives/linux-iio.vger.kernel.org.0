Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B43706877
	for <lists+linux-iio@lfdr.de>; Wed, 17 May 2023 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjEQMoJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 May 2023 08:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEQMoI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 May 2023 08:44:08 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BDA26A3
        for <linux-iio@vger.kernel.org>; Wed, 17 May 2023 05:44:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba82d82bd39so923576276.2
        for <linux-iio@vger.kernel.org>; Wed, 17 May 2023 05:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684327446; x=1686919446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNevE736BEsxBU0FmwLJIhGqBiG7yoAC/t6/uUIBMdY=;
        b=FMlLS0aECYmfOvG19PTRQ4JzQVOPvgp3keEl4q4lBIcarONNex1FSS2aSSOrdLjxfE
         OYiPfSd3p8dfD1QItx7D8wl2cvYk/x1+YjFMYiLcupDwHagK7bMFjrihVjrw89h1isK/
         BL8m4dOesp9dOvFJIsPhRXwRJJZw0WXMjrRaZLCGs1aGyZghu3sRXCSFqAbHEbi4bEe9
         sb34beQApq2PcsJ82bacmFQQUt6j72BaQNjANrnbsGmWxQJeZKXoqvssjMl8KTkBxSm2
         hNmUL8hfNmz56/sTiGz6zGIXfLgQdcu9zLtf9Q3wfq58AlUNYHc4mTp5/+V36z6r3Z0n
         03CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684327446; x=1686919446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNevE736BEsxBU0FmwLJIhGqBiG7yoAC/t6/uUIBMdY=;
        b=Qf42gYJN4ykaScBIGGtAV5S4kLMm5mXAyR3Zw6Dl8+r92wW0SGVtUuHt0GyZfi2bah
         Ub0RM7t1GR9PCMjo+mmGm9dYKrAY1RvhABbY1bvZPx0MnEOIvfCBUQUiPWpcXM2hINMt
         ecAYi7jSbMjG1vgwyannMpLcVXubLyTbzhr9Swc0JDR1KLAwJGgZ1u+Xlb4tzVD3YWwg
         HnTgj/tANEHvJJ6USuR+Qsgt8Nk2+p2untkfJ9fCPYDZyRoSR04DS0J8GoQV9uzfIzRa
         W5F33rZn7c5O6OWsbyjQRJJW7moNskshJPx0Hz0pOrg6JUkqlIC9msC3zquKLO8z9f58
         LObA==
X-Gm-Message-State: AC+VfDyAs27o7Z/yZJnB+rUPUB2FRGcl98to03+/tULTJZhRcNsqQ54F
        WvDy9oj/Rxenznem97N7sJWkUZ8kW1jlZRqKKNvXqg==
X-Google-Smtp-Source: ACHHUZ4prpZ1ZwoDxxoHkrbtIQ9L4j9bzrbZd//ns/O1W/Gj5TZTAbzyimVq3qT7URmcD+Feztnv9pZGkl2jlaxwl+I=
X-Received: by 2002:a25:1504:0:b0:ba7:382f:6380 with SMTP id
 4-20020a251504000000b00ba7382f6380mr12543280ybv.24.1684327445737; Wed, 17 May
 2023 05:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1684220962.git.mazziesaccount@gmail.com>
In-Reply-To: <cover.1684220962.git.mazziesaccount@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 14:43:54 +0200
Message-ID: <CACRpkdYPZWNTOW6c0q1+q64JRvxUXswQqm6j5N5KaAWO=sSUaQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] fix fwnode_irq_get[_byname()] returnvalue
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        netdev@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 16, 2023 at 9:12=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The fwnode_irq_get() and the fwnode_irq_get_byname() may have returned
> zero if mapping the IRQ fails. This contradicts the
> fwnode_irq_get_byname() documentation. Furthermore, returning zero or
> errno on error is unepected and can easily lead to problems
> like:

Also, zero is not really a valid IRQ, it means NO_IRQ:
https://lwn.net/Articles/470820/

I'll apply the pinctrl patches.

Yours,
Linus Walleij
