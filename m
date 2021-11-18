Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4D4554E3
	for <lists+linux-iio@lfdr.de>; Thu, 18 Nov 2021 07:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbhKRGwX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Nov 2021 01:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242323AbhKRGwW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Nov 2021 01:52:22 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71FC061570
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 22:49:22 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso9237079otf.12
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 22:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=toCwT6GoOzYwa6FJM0P0fxHYrimq7fJiOH5vlvAVs5Q=;
        b=JLFX9PPoNCel2Td9QeqODZWv5fROUE+aCyv/uJxfZTEZd2m83cDK7v6VRiYZ6pmvug
         n6gyTJoZPKBpPHmW57hQnnlm+3Wv2gD1jTwkbqd4Lj+PWAUWU30UtMuYdJJZrL1+49GJ
         fd/r2uBvMljndSPQ7UyB6YF115cm45TwOmjpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=toCwT6GoOzYwa6FJM0P0fxHYrimq7fJiOH5vlvAVs5Q=;
        b=Z+5EQpMzjrAuhw1yqGHdUu7FMs5nL1ZtmJqXf5tAOnQEaIZOQMs5tVYnzgth/TflKT
         piD+p+fDNfimK3O1PM8kipXmby0CXR/cTN5ZG0CnS2hJYi7MRbt4O4wQZFW0dwVHvd+t
         4tuiXUUgOynY13xwelW9hPLz/M78sezSqm71FLO2gHMvjgruC5jfCRQ0WOB75Jz9vFAr
         EGHO+An5eeVGqK9wgcQapeZRCwERcxgajIoedukPw/1iGFMFwBmNp9+/BplbQXycIZJN
         UlVww6RW/s4j76pfXBZz/eBLfX1V06XsPapfdzns2xYiildJTm/kuUKhgF491UgiX+ui
         nvmg==
X-Gm-Message-State: AOAM531ij7e2wQh+iu/nmkWk2wUFfwnOgW9nb7aoEooqpbivLiq4lYGY
        vxXc010gC2TJi8t6gK/IHTo1ew/Q5gAO4YWq4qyOE8LCqZE=
X-Google-Smtp-Source: ABdhPJzPoRm0+6gN2ULZy8FnAQKGcTJfzVMatCc9QczLi9CBBDRYXbIhw4Tx1XU9Z8JNTaMN3CJaIV2CQmrQezMzDwk=
X-Received: by 2002:a9d:2243:: with SMTP id o61mr7189754ota.126.1637218161863;
 Wed, 17 Nov 2021 22:49:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 22:49:21 -0800
MIME-Version: 1.0
In-Reply-To: <20211117084631.2820014-6-gwendal@chromium.org>
References: <20211117084631.2820014-1-gwendal@chromium.org> <20211117084631.2820014-6-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 22:49:21 -0800
Message-ID: <CAE-0n51iE2bYLUmkXxuwPcdQ7GkBW+bkeJEbNOWjbV5o1qjCvQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] iio: sx9324: Add dt_bidding support
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        lars@metafoo.de
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Subject has a typo, maybe should be "dt binding support"

Quoting Gwendal Grignou (2021-11-17 00:46:31)
> Based on bindings/iio/proximity/semtech,sx9324.yaml, implement
> retrieving sensor hardware property and alter default values.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
