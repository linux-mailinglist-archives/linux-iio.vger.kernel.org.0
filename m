Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47ED6EC789
	for <lists+linux-iio@lfdr.de>; Mon, 24 Apr 2023 10:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDXIAA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Apr 2023 04:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDXIAA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2023 04:00:00 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BA611B
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 00:59:59 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b8f5121503eso5938053276.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Apr 2023 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682323198; x=1684915198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDlWcthh07+WxrchcJHrYbsio5jYd6Q2J97FllOMDWg=;
        b=hm9HAdwE8dTqPdH06jUZx6FYb+IE9t7ixZdgzoh/QSqJ+ziWtzX6VqU64jtWLkeL7o
         7P5+h17htscjGLM2azM/ldm2TBxXVh9PEkItIBFw1GdfmM6kQO9bOHF1uNAnRKmJWm8T
         wy4Pl7SnzNcxnwc2EOC5d9r1+be6a4lim7GMMtsQvtrZK9Z2B+Iz6zAqxkMkAfrCzB+O
         5xGGrmjIl16gvMwe0l6NWL+7dV/iljuw7rPbtmT+/YXMO9w/tGF2yGVfd7uPBIwT7sIP
         2hx3DjxCF0ehNnu9lbXeW57+e3mQLa0cn95Wr3xwOWcpaTHQ9do0CWREdxrWCdWjoj/N
         RNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682323198; x=1684915198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDlWcthh07+WxrchcJHrYbsio5jYd6Q2J97FllOMDWg=;
        b=eHNWKp2P5Ny1+4EgAaiEJPLclcUGRpzZvWYcp5/0IJpTPRt+Q5Phxz9OsRQDdVUMIR
         m4GMsXo6llJbZaLZuvWnZGvUge6cXu4+ZKganJfH97e/gXEJCnVzAUwPIG2sYlw52DmN
         kFABtu8lS9p2Fxsvz22qSgp+oppZkZ2t6CjXR/xoGWleuQyQNXgQFRb1nyziLk+PWpTV
         ytPmuI/Qx1ar9PluGwLJng2tFCTvmdlBu591HFmETh+2eCsmSvVfdrcgv7kBawYdRcED
         XVv2ry0wOS2VKFdLvge90+ceAK8t6cZ5c70WHMxwmJfTJV+lE1yxHIs/8wdbQAgkU7+4
         1N9g==
X-Gm-Message-State: AAQBX9drkMADg45hG3CibKJzGZFtq3gTJZkfDYZrUxeWsgkjMrlvqjTP
        dSelMZ/GW5LLQUQ3TU2dZLYTtlEPUM/fmN5CW6jhuA==
X-Google-Smtp-Source: AKy350aecuGUuFx2uKB0spyPIYhwqvlFksbW8FKXs3/zzz9MeUOdbKHXIhGtX52tLQE6llcSqJHVAfvZriDV/g8+JGw=
X-Received: by 2002:a05:6902:702:b0:b95:7d4e:c8de with SMTP id
 k2-20020a056902070200b00b957d4ec8demr11032357ybt.12.1682323198281; Mon, 24
 Apr 2023 00:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230416212409.310936-1-hdegoede@redhat.com> <822cff64-f7f8-b998-1b8e-5ada542b86b7@mariushoch.de>
 <20230423114855.1596fe0c@jic23-huawei>
In-Reply-To: <20230423114855.1596fe0c@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 Apr 2023 09:59:47 +0200
Message-ID: <CACRpkdbdt4eNt17gSzObihHwQPaXR+PzrkPKf78aSVZO12Lp=A@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: st_accel: Fix invalid mount_matrix on devices
 without ACPI _ONT method
To:     Jonathan Cameron <jic23@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>
Cc:     Marius Hoch <mail@mariushoch.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Mario Tesi <mario.tesi@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 23, 2023 at 12:33=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:

> Linus, that's one of yours.  Could you also take a glance at this.

Heh it should really be looked after by Denis Ciocca or Mario Tesi I think.
I don't know if ST MEMS has an official Linux contact point, but I would
like to nudge them to get one :)

However it looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
