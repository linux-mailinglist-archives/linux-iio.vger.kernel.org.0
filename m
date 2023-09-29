Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19487B3932
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjI2RxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjI2RxQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:53:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2CE19F
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:53:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-532c81b9adbso18821948a12.1
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696009992; x=1696614792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MalbAsDSrxzjZfhI3UpJdjmgfxP084DXecPXrcCn5EI=;
        b=ytkW1ZftXsCVOwhQHwA/yU4GSpeEqQIA4OpmVS3z84cstv6t5+zl+OPYhaOmwID/6i
         B1TFzLZAUQsxWU91Gg2rfQQRQsn1JtZIjnwyvwOIEkmQCbD6d5BsQru5oU+gYVM/nP6N
         AAheuLIhrxaFnEfgZ+coBwTy3Y/fgoSd5ZWnr5FBx5/+CeK0cJBsesByqSi0M34m+bce
         NoNRvkze28I/2uC/mf+XrJvdOnzGbpmQCnf1jzDk2iJgiitFw8XDNnT90EJLJUAKCyVY
         awU4Dv+VPlN6z0hUW+IEGQ3nXbJndR74ZmgiudDSxRQWR0E3hRQfdg2a1iwQBMSDiemh
         x6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009992; x=1696614792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MalbAsDSrxzjZfhI3UpJdjmgfxP084DXecPXrcCn5EI=;
        b=PWYYaywwidsh+/rEhHXB1h2qUrNglecKqRCxSJAmxLmgPynxQiCMmq1hYl/iaVg0kl
         eXCTvd9T9evJEHoTW2SpnEiVGhF0Bkb/VlAy9NrhIrDxpq2ql63hwI4xPO8yHe/Swgi3
         ml1Swah1Rag5mXF8Ko1I4biuIdAIU/Gfv87/up6y1uFMX4GvZzrnAovqlCfujpm9/JEu
         bGETfK2rlcWuIbnySldFdTPLK9de7Fwb75Wr7h9fLd6iNFCvMat3Eu2y2AlEMzbiMmnF
         ZHrc9qEOMm4dxHB4g7S9+3LlgE20GCWJa/e0oOcTCxzsA+VUDSg3O+rXgxvRZcc7KyaI
         QdYg==
X-Gm-Message-State: AOJu0YwuWNjGoZBXudtVeMuH55dfIthxybzB+8cXiZuXNL1aaxy6rMMa
        grKbsklq6+ROuQg4FErfPMJbpjUB0XIT6aJJDcwfRDzgXNlCZ19B+EI=
X-Google-Smtp-Source: AGHT+IEwVthYBKcUdzG5goS3Tz+AFoCkOi/JKiHPwq7Emnrwxe4IPK/TuAsuGn3/e6k3o6iloUXzLX5MXhaxLm3Wfko=
X-Received: by 2002:aa7:d607:0:b0:531:28fd:ad10 with SMTP id
 c7-20020aa7d607000000b0053128fdad10mr4564655edr.38.1696009991734; Fri, 29 Sep
 2023 10:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com> <20230929-ad2s1210-mainline-v3-14-fa4364281745@baylibre.com>
In-Reply-To: <20230929-ad2s1210-mainline-v3-14-fa4364281745@baylibre.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 29 Sep 2023 12:53:00 -0500
Message-ID: <CAMknhBGFBwQQouhsPMgCuMn6+eQfDCcSzJvF-DwJAnoEPvMLAA@mail.gmail.com>
Subject: Re: [PATCH v3 14/27] staging: iio: resolver: ad2s1210: implement
 hysteresis as channel attr
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 29, 2023 at 12:25=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> The AD2S1210 resolver has a hysteresis feature that can be used to
> prevent flicker in the LSB of the position register. This can be either
> enabled or disabled. Disabling hysteresis is useful for increasing
> precision by oversampling.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

...

> +static int ad2s1210_read_avail(struct iio_dev *indio_dev,
> +                              struct iio_chan_spec const *chan,
> +                              const int **vals, int *type,
> +                              int *length, long mask)
> +{
> +       static const int hysteresis_available[] =3D { 0, 1 };

This is basically an enable/disable. Should the 1 value be changed to the
appropriate radians value since this is hysteresis on the position
(angle) channel?

> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_HYSTERESIS:
> +               switch (chan->type) {
> +               case IIO_ANGL:
> +                       *vals =3D hysteresis_available;
> +                       *type =3D IIO_VAL_INT;
> +                       *length =3D ARRAY_SIZE(hysteresis_available);
> +                       return IIO_AVAIL_LIST;
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +}
>
