Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F80A7B3923
	for <lists+linux-iio@lfdr.de>; Fri, 29 Sep 2023 19:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjI2Rt6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Sep 2023 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjI2Rt5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Sep 2023 13:49:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC994195
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:49:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso11295572a12.3
        for <linux-iio@vger.kernel.org>; Fri, 29 Sep 2023 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696009793; x=1696614593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVb8bc5h6cYCDb4wln/HVuuicIeKALI/2rEiAT/rv2E=;
        b=N3HunwXEULDIWeSDpg2dovjPhxxXVkwKQrZIb5WHl7nNtU40aC1xbj9rmgW+rFHDwk
         JnxSLwB3TRR66HENPjh79s+7UIga1UV54ab7P7gX8aNxy043BBV4vn9m3iDyKkyKtDar
         8XsVsJJUbKwgYRim+jMm194c5VQ5s+N7l9/jfo+T3gau2BksbRC3/Dpdw9hkKdfbFvMC
         e0qXhPk5Ck9m76bCnOMDzpbf8W+4GP4lS6dAa8qy4BT+DyOS8ktBNziJjNnqO03R0Bz0
         w9n6LsnbRqUjyx7shjkL4O/iBRDxJhz3C25gKELqWP8XBKswMZTgDwtiu4hOTI4q2dmB
         9amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009793; x=1696614593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVb8bc5h6cYCDb4wln/HVuuicIeKALI/2rEiAT/rv2E=;
        b=C7CcHRwBrK+VO81BtPRhCicvjBpOpvNbMsxBrceZdTiK+24leyp0r6IFswEvCNABNP
         woQWQPY4EZHDxCIetdXFIHFOLkwAkPXMFi/cVFKWP8lifOId7BHf1IvHYs4K5vSq5wb3
         eNx1r+mhcUtgUoU4T+D1DyZui5Fo+UY6jWuMmk5oRirdcxCxY9Ik3wXyg0idajwVgdt6
         1mh16q5H0f5xmn1IsCGuIDTnH9M5i6OlY8n9M7QiFQwCyNmN1s+H+/aTPSWrLpzNAb1/
         s3Vd1TXswnKwhc0TBXNKPAMiiiKkUkFi93vzeC2kWUiQZ8xgKYQXJZSjPVNS2DKzwbI2
         +sHw==
X-Gm-Message-State: AOJu0YyENDliopvhSHSi1hHKDoQiilLygarqvcAlBDZROgxA1QA5z4Ot
        lRpL9V75EfsP6gJSJyA5UiM3e3ACc1JYe1rpji+3gRxuVAZsHrXvGWfMZA==
X-Google-Smtp-Source: AGHT+IFrazPWKmZQvejWAgHITohOjWY7XIYytqxFwOWTgz5mw+hIEm2IUh28jJx/1qJjE+rTURLQuJJ8e+d0I3x9+LY=
X-Received: by 2002:aa7:c549:0:b0:523:4acb:7f41 with SMTP id
 s9-20020aa7c549000000b005234acb7f41mr4282447edr.14.1696009793077; Fri, 29 Sep
 2023 10:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
In-Reply-To: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Fri, 29 Sep 2023 12:49:42 -0500
Message-ID: <CAMknhBHLwWuuCDSCBZV1bB1MuqDa5ur4GEY+Yqofvn9MPGRcVg@mail.gmail.com>
Subject: Re: [PATCH v3 00/27] iio: resolver: move ad2s1210 out of staging
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
        linux-kernel@vger.kernel.org,
        Apelete Seketeli <aseketeli@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 29, 2023 at 12:25=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> From: David Lechner <david@lechnology.com>
>

Ugh, an automated tool picked up my personal email on this for some
reason. This extra From: line can be dropped from any patches that get
picked up on this round. I will make sure to double-check next time.
