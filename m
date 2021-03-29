Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5734C22A
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 05:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC2DNE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 23:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhC2DMe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 23:12:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A00EC061574
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 20:12:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d8so3729910plh.11
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 20:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=+9+4oo05hDGvnI5hJt7kWUj73df8yaEhUznP7X+ojcQ=;
        b=ih9q1FUKcYI/z8r+kyWhEeTE6Olz6Vbm3k0JCbJnoXAF7OQWA3BWbZdinAy07b2eT2
         cNHGm6shWdKCNU7NCao69bV7rfrpXAApBXTYBrIED0Y6+xyEM6CwrrlQcUeLMa+URsK7
         A5FZoOcEWmYkW1bYbWmbllGe1YGwpNdZR4208=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=+9+4oo05hDGvnI5hJt7kWUj73df8yaEhUznP7X+ojcQ=;
        b=OQWuLOdO0qk8txJp/uGSAL0qzrnq6o01dDkxEFDUWf/lAZ/pn7t6W92MHYQrcuqp8F
         Hc2gzpdufBEcQwEHJ76ep28AUO/eLjXGrAlAwJ1845dllAUYC4TVTX2vW5vm/5ovyX0x
         6wrXmTwClzDtCyIgNwO4L+/K3iI00oHxNUUNRIsWm90yueslqxe8No0fnWACjcqAKMy/
         XIBKtPWIYCyqdt9IPFPdFSC33gxnZVPX1gVl0L7Ao0WZRzxb5eFKWQVCp+AglBgY/EB5
         2z6t3Q9w0XI7lqTQ+QvjtxqvY1akNvI2lOHj6kHVK2hH6MreLVxqur3db/alY43M/fJR
         RgMw==
X-Gm-Message-State: AOAM533u7udjsYxTduMjzJ67dGnZFF2ZDM33HgYdS/834SXVheSKAunV
        3g6KgX4p2tINfaVcuOzGc2oZIfy1lQjXbg==
X-Google-Smtp-Source: ABdhPJx/yHEDBVu1TGineOAvCaXWx8ugHX7Muo0TVkRrl5SvBFQ2f/cxnIs/07J0SjXbC6H+3vNSnQ==
X-Received: by 2002:a17:902:c408:b029:e7:3242:5690 with SMTP id k8-20020a170902c408b02900e732425690mr14609655plk.85.1616987553694;
        Sun, 28 Mar 2021 20:12:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:d06e:3541:6cd6:ab0e])
        by smtp.gmail.com with ESMTPSA id i10sm24048465pjm.1.2021.03.28.20.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 20:12:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210328033639.1021599-1-gwendal@chromium.org>
References: <20210328033639.1021599-1-gwendal@chromium.org>
Subject: Re: [PATCH 0/2] iio: sx9310: Add debouncer-depth parameters
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
To:     Gwendal Grignou <gwendal@chromium.org>, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com, campello@chromium.org, jic23@kernel.org,
        lars@metafoo.de
Date:   Sun, 28 Mar 2021 20:12:31 -0700
Message-ID: <161698755179.3012082.10332557476670862687@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-03-27 20:36:37)
> Semtech SX9310 SAR sensor has a debouncer filter: only when N
> measurements are above/below the far/close threshold an event is
> sent to the host.
> By default the debouncer is set to 2 events for the close to far
> transition and 1 event (no debounce) for far to close.
> It is a balance speed of detection and false positive avoidance.
>=20
> On some chromebooks, the debouncer is set to a larger number.
>=20
> This patch applies on top of commit 103d6ec82676 ("iio: sx9310: Support A=
CPI properties")

The near/far debounce settings are already supported via sysfs. Can you
use those instead of putting this into DT/ACPI? See
sx9310_read_far_debounce() and associated code.
