Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895453C8000
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jul 2021 10:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbhGNI3q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Jul 2021 04:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhGNI3n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Jul 2021 04:29:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78785C06175F
        for <linux-iio@vger.kernel.org>; Wed, 14 Jul 2021 01:26:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 141so2212582ljj.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Jul 2021 01:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zfNM5YqJ9ia0d7b1JxsHsYsljSn9Qi6joq52XtjhSc=;
        b=EeRP5cYeC6+cRM+wF/8DpZgWNdBfy9oJSwyZ8rIhnn03+sBLW1qWs1zHamDZ3mTDuo
         +xyI+1NpIYnI3pRulS51eok/Tk2aSBs7dcYsRKJx5CTTcxhE+SCPiNpVl7iixUa2L42A
         dfqcujcDs8Ofst4Trj0vMw6uiRs5HVtarpJcK+8QZdZ5sUpWbJ81V8XlMrYBKg1G3zyi
         wCyAaQL2mTn1hnBMsXocBb+ofVC24EKbM0iL0YsW3ZBCytYA9oGhv5aaYH+o6j2HDbwT
         t2fG1VtW1X4DrG9BJhUHOh7ENRxGqMrhZw8lrGFv8AO5hnPDGzF6/5mKeAAao8TleGjl
         UBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zfNM5YqJ9ia0d7b1JxsHsYsljSn9Qi6joq52XtjhSc=;
        b=UqPVYnZCtC3y2tRwINCESio9nB8AKqu+fV3r9NFvp3vGuwdcAqvcZ7cr7wJIJyD2In
         MLNKbzCjiBvZxnXOHIUDEp8mbzCELgXL6PXhhRA8PVZnU3NC4e+5utBR0lMABFaj7qiV
         BadltxGvTIpYw6D9o6j7GQLSDr75zk1Ueja5AyZLf/Fq2ZApE16WKAfUC+oErGJUeApe
         9kmL+zGMf59ijsP69PyLICxPtR2rHNlIr79keE6i+M9rtmnerBeqvxi59Qb/VoWScSo6
         ADrUZYVs36D55kq2mYpDi0eAN3dRlcFADUTGJtji6azg0OEWtjAgbOsggBZBQXU+8Thk
         d2uw==
X-Gm-Message-State: AOAM532xyKRO+pfmbAQzyFi+zTaqDSqfPGMRcbuwguvpRuj2Dob0KUrT
        I9npG+PZCNxEp2Gdp+HFq17inm//9LGISa0CU5Zx0g==
X-Google-Smtp-Source: ABdhPJyrH3MVRoc/cKZlUL7NFDICRxRUvv+gmLgI6eAsl9jEWbS+zVKI/MD0QtSkYNVI9ntVf9RL77birvDsRMfycVQ=
X-Received: by 2002:a2e:9b45:: with SMTP id o5mr8171451ljj.273.1626251210869;
 Wed, 14 Jul 2021 01:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210412122331.1631643-1-linus.walleij@linaro.org>
 <20210712130444.bois24oukqmxpg27@gilmour> <20210712145639.00004604@Huawei.com>
 <20210712141613.66hw4glnkqlw3n4d@gilmour>
In-Reply-To: <20210712141613.66hw4glnkqlw3n4d@gilmour>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jul 2021 10:26:39 +0200
Message-ID: <CACRpkdZqth9kYEaCr=C88=EbhEy+r5V1vPXOPKNky5HeP7QxPg@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: Update ST Sensor bindings
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 12, 2021 at 4:16 PM Maxime Ripard <maxime@cerno.tech> wrote:

> > maxItems is set, but not minItems.
>
> Yeah, and if one is missing the other is added with the value of the
> other.
>
> What the schema enforces currently is that (for the common part) the
> interrupt list can be between 1 and 2 and then for a specific set of
> compatibles (including the LIS3MDL) it has to be exactly 2.

maxItems is not an intuitive naming to what it does so it creates
bugs like this :/

Can you fix so it works with your PinePhone DTS and send a patch?
Perhaps also add as an example so it doesn't happen again?

> Even the common part looks weird though, it says that it can handle up
> to three interrupts but has maxItems: 2?

Maybe just drop maxItems for now?

Yours,
Linus Walleij
