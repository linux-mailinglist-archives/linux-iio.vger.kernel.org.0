Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EDD47505E
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 02:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhLOBO5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 20:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhLOBO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 20:14:57 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA92C06173E
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:14:56 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso22995702otj.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=rvS5Q7EKe3K7SH+q/7TxnRZ4mk0oTjNYj4sraDpnvVQ=;
        b=CZT3IbRiD2MvCjx0qHT4sTFKxwsdrGCCCpkAXj0IeJItopkMNKPboAQvR1EQQcqZ5j
         q31acvqoKbiz8GrnFtbfxuvYrVuM9+ICcoBMwTEeXwF/pydYvqxDIggpRuKyRd1m+WML
         x0F1YEeVVnwQdWO0wWm9zBFc+Re6m0nRqrsas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=rvS5Q7EKe3K7SH+q/7TxnRZ4mk0oTjNYj4sraDpnvVQ=;
        b=FLC/CmD5tjaVc7sy8lEaiP7PsrGVFcaq/YDXJ0Holu5s7rVZmzAk3dy9l3/fF4AhV7
         ncNVGbpZ5Xfhc9lweY3MzJpqAMkQWMxFqLOLkOtCUPk3+mhvvIeV4OTgYFZkquPI0mo4
         n1KrMU7f5BlUmAb4VGImNEnczoK8p0xmeujy4ReLRRRbhMAUmsfpWCI69DKsxj5uvON+
         Zj8wEg+0fxG84/M3QJ+m5zAiPNbdjrUORb/8+XTSnb800jaG2KFr2k8VaW+3y8Yrdazh
         cdX+7CtQXKfYO2CK/qXl2WahQL9mp90Kh07sI5hVIlplIeFKfryCUQ5m+vvNKjl7o2If
         ZBpA==
X-Gm-Message-State: AOAM533H8eUdCJSo43ybscaE+Qf8X4jMyV82YEECrEh3nxvBUPDTKbWl
        JWNWjDeK7cSfcF0W4ACZLB1bERkRAwiL8E13ZwnAkA==
X-Google-Smtp-Source: ABdhPJx7028jYOaNEpoZd0AS4FVdT4oIZk9aqcqUNRaJv/zvWQG/ilJjZkmBI+4nrhRf7mZashH1c5tb3sRIANYvwDQ=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr6767021ots.159.1639530896121;
 Tue, 14 Dec 2021 17:14:56 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 02:14:55 +0100
MIME-Version: 1.0
In-Reply-To: <20211213024057.3824985-3-gwendal@chromium.org>
References: <20211213024057.3824985-1-gwendal@chromium.org> <20211213024057.3824985-3-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 02:14:55 +0100
Message-ID: <CAE-0n52s8wH7NmfBSBkN_90cAH_=VyUmMg5jN6XGKEbUj_167Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: proximity: Add sx9360 support
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-12-12 18:40:55)
> A simplified version of SX9324, it only have one pin and
> 2 phases (aka channels).
> Only one event is presented.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
