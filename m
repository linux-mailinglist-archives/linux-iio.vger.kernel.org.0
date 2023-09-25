Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33EA7ADD6B
	for <lists+linux-iio@lfdr.de>; Mon, 25 Sep 2023 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjIYQvE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Sep 2023 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjIYQvD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Sep 2023 12:51:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E36CEE
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2023 09:50:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso563970266b.0
        for <linux-iio@vger.kernel.org>; Mon, 25 Sep 2023 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695660654; x=1696265454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK0Wa94mxZD4Pin962qT1kXm8aCjboYY+1emX2oQt8o=;
        b=sTX3oWz7/sQOFw4grHxlbdyTDvsZMHWij1UGf48nQAVRPhQsdHP8nQ4edf9NWjEHoR
         uu0TORJ6fRzVRtZJPdm7CTUYkHrTYERWHrAc1C3zp/fIta3JYzKoV9sywMF0bdGPnZZ6
         2dqtFY8vmDUckTWAY6pW9yc4SDIXFkC0ESQ3vfWEJd0xSpo0wJ6QTVIoODxlv+2dyfOG
         YZm86B900PjKKIk0tCs5PJNBnDsnP2/Mb5DLbvkli2/xLUY/44iP7UexiRN1328RahIx
         DhHJCJc9Aw7prSAKGGZa/KLKBoTvIDMuMFrZlq4Z+AkMi7YWJpO0XLa/8TB1R/tItVjf
         bIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695660654; x=1696265454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZK0Wa94mxZD4Pin962qT1kXm8aCjboYY+1emX2oQt8o=;
        b=V5T+IN7uSMoUlY4D3jwU7Q2eMbRnrijKl3YsPYfdkyJdVyIo3FhAbrRvrPpiACsR4a
         8BrncYcwX3w0tN2qiWCk3HolTl6D4S0FLPEfYo0vOv5BeiOxWIlGdwmvBM8XtlKi9E3J
         pjKHqs3F2juOIdT9DNPQMn5NJMtDL1NyiFNaxWcArxPZNTzHzNGu5LtYFkmemtxu+OPu
         pg5liSjWMTSeTsiOWcWyQ9W/1rPEZONFacvlAB1YwfYcS0f5FrD/E/7KEbCXLUowbWAU
         JvLcLUj3MnzUL1hLMiywxtiw2jzCMyX6OOrmGliZ5Hj9cVJ6ovmvWiyCld/JZICZsCG+
         wFJw==
X-Gm-Message-State: AOJu0YzD4bc8TjicF2V0MFOEQ2IWK61Y3xmGY98QEAZ60JRfjRAB9uRC
        ByYWH9x6B5FWlUfffGUUOA/JsUr8URVFJuOi4yIkqA==
X-Google-Smtp-Source: AGHT+IGsoV4g2+LteE9K/8LeYzh2EooZgBJOexrqD04mHD3rKyBP8T2APAtV0W+DIdvP1cPsq3xQo6gHIvL+/9I2E1o=
X-Received: by 2002:a17:906:51c9:b0:9ae:82b4:e309 with SMTP id
 v9-20020a17090651c900b009ae82b4e309mr6645063ejk.0.1695660653836; Mon, 25 Sep
 2023 09:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230921144400.62380-1-dlechner@baylibre.com> <20230921144400.62380-20-dlechner@baylibre.com>
 <20230924191711.244ec842@jic23-huawei>
In-Reply-To: <20230924191711.244ec842@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 25 Sep 2023 11:50:42 -0500
Message-ID: <CAMknhBFE49iGkZyP4rdqAmJwY5KnJ0X9UAPC54=BdQFfNuA+kg@mail.gmail.com>
Subject: Re: [PATCH v2 19/19] staging: iio: resolver: ad2s1210: add triggered
 buffer support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 24, 2023 at 1:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 21 Sep 2023 09:44:00 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
...
> > +             /* REVIST: we can read 3 bytes here and also get fault fl=
ags */
>
> Given we have fault detection outputs, does it make sense to do so?
> Or should we just rely on those triggering an interrupt?
>
> > +             ret =3D spi_read(st->sdev, st->rx, 2);
>

I'm thinking the former would be better, but I have a pending inquiry with =
ADI
to get more info on this since the fault pins and/or fault registers
don't seem to
be working quite like the datasheet says they should (I am seeing fault bit=
s set
in the register without the fault pins being asserted).
