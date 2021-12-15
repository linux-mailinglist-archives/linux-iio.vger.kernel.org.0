Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5447506D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 02:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238890AbhLOBQa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Dec 2021 20:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238939AbhLOBQZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Dec 2021 20:16:25 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775DC06175A
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:16:21 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso23043106otf.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Dec 2021 17:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=n/2wL6qVc/Kd76fB9wC0WHXYN39h0pN0leHXYr/czPo=;
        b=RT39V6ENUGnxi0HDpskj0XMK6lhJQmAH+hEcHNevqHsxHW9odDlLig3ulDiIdPmHVI
         Ob084bzlGdDtuYiUPzK2OTTH7xxaEyWlTedb6N8QFDfuCgU593erLU6OesCc1hLBiMtm
         X6/6Bc5bGamWdFJydgD1N3f411HUtCTQdGGUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=n/2wL6qVc/Kd76fB9wC0WHXYN39h0pN0leHXYr/czPo=;
        b=KDzl+OKdhAuxp+4SL7cRow5EQlMtEZUIsg/NQHj9UBP3ET+gV7CH7g0FijjctalUnS
         itOYseNESWZN4Nu+BEFGPoQPESwGFEiUhunNwn6HtvOmxPRwUM6iWElY4UTDX4tnYQ22
         5MpuMsotn/iLg9NV2tgc0cEOPdK8uj7mPe+V9zQpgHCZgR54xu9nklj9Vmh/tx7q+g9m
         ekXnrmqH4mUnThu3e1KE3xrnV/DQ+raGdNrhhjNmOS7HBQo4VT+Tnu/EdCVpaWnA4AM3
         xDplzEuBezsLKQ5BIi7Z5snsYR6aSYUbjEN3XLKJwMw0pyyCPASCMi4sKVdP4ta9i+PG
         ocDA==
X-Gm-Message-State: AOAM533XcbT1tStjMmO6+DOVgui5xJDxdM0CqZq3wdEPA8BRIz8ardre
        U29mYg213KrBWjlDlBNI0s8wZ8h6pkZDKwnh0XO5EF3mz7w=
X-Google-Smtp-Source: ABdhPJyyDu/Pc3Oi31nVMSzZbaiGH/tHm8moYXdteuH0OrfWsc2KAGhtwfG+dC4LWnjZ1UIqChjNiT0ax6NVQFOrMb4=
X-Received: by 2002:a05:6830:30b7:: with SMTP id g23mr6770622ots.159.1639530981017;
 Tue, 14 Dec 2021 17:16:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Dec 2021 02:16:20 +0100
MIME-Version: 1.0
In-Reply-To: <20211213024057.3824985-5-gwendal@chromium.org>
References: <20211213024057.3824985-1-gwendal@chromium.org> <20211213024057.3824985-5-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 15 Dec 2021 02:16:20 +0100
Message-ID: <CAE-0n50RQ3t6bxeEesw_PpwNfLyyeM+fMaS1HSUs3adr82Ezdw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iio: sx9360: Add dt-binding support
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-12-12 18:40:57)
> Add support to configure sx9360 from dt-binding, to match device
> hardware setup.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
