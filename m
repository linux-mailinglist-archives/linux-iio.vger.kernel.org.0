Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8B7E667F
	for <lists+linux-iio@lfdr.de>; Thu,  9 Nov 2023 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjKIJUC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Nov 2023 04:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKIJUB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Nov 2023 04:20:01 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A125A2696
        for <linux-iio@vger.kernel.org>; Thu,  9 Nov 2023 01:19:59 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5afa5dbc378so7686737b3.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Nov 2023 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699521599; x=1700126399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMqzOhl9WJdB/fNzCLgAfODP7qyR0cWrCHRSWDr+Pj0=;
        b=eozzNk7MQrpb00EzZSTP+MyjbgBR58IXVyyVIjuSJ311RdgF0dg/XLO7icXV2sImmZ
         ReEc6cZ5LEW31QXd8fvnkaq1pbc7Ac0i5ccaBCvLKwQZouOflbxwgmcYKb8/wonB8qzv
         5k11Y4hpJdInQp7gORgysFVHxope/jCywS+Xf/IwjUpwNtfU6NlGX5ObSs/Uvk541n9o
         D67NTcZGRtc+ormqXQaJJlZ1w70Oh4V2bNizbEy7C1wZko2iwhkuB3FDgl2yrra0oK7q
         GOnrXy4XirTj72WZIq2I2eUnwdrarhSUJIoKLcg0LOEOpJvnEIkrDMu9nh+5yJv9dYqR
         oq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521599; x=1700126399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMqzOhl9WJdB/fNzCLgAfODP7qyR0cWrCHRSWDr+Pj0=;
        b=tlAuhrTrG4L3a2zSYjqFqpOxig44q+Br03GlZfrmdU3Ne+lFRZgUGe5kFkGU0VnqYn
         RdXLyQSCn95b1BzCHyZBADuF0r9V0jwF4toGQNcu9MMZJTVnkfbATw2fjI288FYK0544
         Qidj4joRzd6m9AyiAOECgFczUhTRnZvVqv7RXNpV/+8rNG+tyZngZYFBl676ePllVytv
         Z8VSwC9af+1hLjk7b/lBJXCfNtpXWEdw+L9ApeH0SKWElgLrkkYDxMpxfDA9P6S2hO1g
         /07HjNo37drBk8vOkKbOX1Wy9AjjzwLMLc7j+MKDCaqmbNum+rKyHe9gOFfsMkkcadTy
         iyaA==
X-Gm-Message-State: AOJu0YxoKXzYbytuchB8/ADwi9oOyh1/LL1grMJ8p0OiHL/CDIAbiqlF
        zA5fUmca7ExsqDQ28BBCBaNuaDFBQEtgOI4yJFGu4w==
X-Google-Smtp-Source: AGHT+IHGslikWjLVflnuZnU/FjwclWe1/pFMwApskuuBpFlo3DBr3i51zm8GUoCtqVS2TkIt+0zIc+bYLe0M7YFt/uM=
X-Received: by 2002:a0d:e894:0:b0:59b:c805:de60 with SMTP id
 r142-20020a0de894000000b0059bc805de60mr4100178ywe.45.1699521598749; Thu, 09
 Nov 2023 01:19:58 -0800 (PST)
MIME-Version: 1.0
References: <20231109090456.814230-1-anshulusr@gmail.com> <20231109090456.814230-2-anshulusr@gmail.com>
In-Reply-To: <20231109090456.814230-2-anshulusr@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Nov 2023 10:19:47 +0100
Message-ID: <CACRpkdYtawfonnkGXzTD65fx4CMbbTaXe359tm7=57saHSNfqA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: driver for Lite-On ltr390
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Anshul,

thanks for your patch!

Overall this looks good to me.

On Thu, Nov 9, 2023 at 10:07=E2=80=AFAM Anshul Dalal <anshulusr@gmail.com> =
wrote:

> Implements driver for the Ambient/UV Light sensor LTR390.
> The driver exposes two ways of getting sensor readings:
>   1. Raw UV Counts directly from the sensor
>   2. The computed UV Index value with a percision of 2 decimal places
>
> NOTE: Ambient light sensing has not been implemented yet.
>
> Datasheet:
>   https://optoelectronics.liteon.com/upload/download/DS86-2015-0004/LTR-3=
90UV_Final_%20DS_V1%201.pdf
>
> Driver tested on RPi Zero 2W
>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
(...)

> +#define LTR390_FRCTIONAL_PERCISION 100

This define is just too hard for me to read, can you rename it?

Does it mean LTR390_FRACTIONAL_PRECISION? It's fine to spell it out like
that instead.

Yours,
Linus Walleij
