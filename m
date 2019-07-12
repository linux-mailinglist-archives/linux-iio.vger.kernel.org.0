Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34D667024
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfGLNeR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 09:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfGLNeR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Jul 2019 09:34:17 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778BA206B8;
        Fri, 12 Jul 2019 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562938456;
        bh=7DVIw6J/+3Y+t8Z186PXZUP4BTrAdMiN89HZu0/laIE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JxmZBIP0Tv4Cbd9X/r7+UrAbIpmxLebTvVZWWJpH+Rwa32tYYYMOwT2m5bxOCAksS
         QpMvEonzo1PZwz4QSwOImC/ZXwqqvRjVXn1izwryJq33LRF2h6KQg9u06695s9cvWI
         5fWqC22VuJenwx7SeAxVQsUy65anKCrXNHzrB/bQ=
Received: by mail-qk1-f181.google.com with SMTP id r21so6398998qke.2;
        Fri, 12 Jul 2019 06:34:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVXNZA0q0s/6hxmY2f0zLUW0W0daEgWTPpaMi+o9kN69+UkS8R9
        Eeu2JuN0tlTGPXhiQ6lIBpJ4AxrKcz9hUckHHA==
X-Google-Smtp-Source: APXvYqxoZc5cotlmgm5nkNDcer2rciXaWhu3NOBE539CmmHXCP4PxcjsozaAi4Fo52shXfIkxEK2Kzgw6i94UBHSDKg=
X-Received: by 2002:a37:a010:: with SMTP id j16mr6521466qke.152.1562938455759;
 Fri, 12 Jul 2019 06:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190712094050.17432-1-amergnat@baylibre.com>
In-Reply-To: <20190712094050.17432-1-amergnat@baylibre.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Jul 2019 07:34:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLs-AGjf1A6nky+5VaTTTDyNkBPgmrGCPqyqKa=UvmLYw@mail.gmail.com>
Message-ID: <CAL_JsqLs-AGjf1A6nky+5VaTTTDyNkBPgmrGCPqyqKa=UvmLYw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add PAT9125 optical tracker driver
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        baylibre-upstreaming@groups.io,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 12, 2019 at 3:41 AM Alexandre Mergnat <amergnat@baylibre.com> wrote:
>
> PixArt Imaging PAT9125 is a miniature low power optical navigation chip
> using LASER light source enabling digital surface tracking.

Please resend to the DT list if you want this reviewed.

Rob
