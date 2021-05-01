Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43DB37072F
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhEAMc6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhEAMc6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 08:32:58 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C78C06174A;
        Sat,  1 May 2021 05:32:08 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u7so381723qvv.12;
        Sat, 01 May 2021 05:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=treFpCv/v2Up3Fln8SQMygcym9zynmOgjODNUoZBh7Y=;
        b=EnUZ7riT4JWee6GBFwnxL60Eg3YS8vImImJbcAKTJZZOyX+J3q898X54RhMpQnvvER
         K9xEdHR+IoP+kcgIpn+1W5pxfnTheXNn43XvvnGlTmMd1mdWQwD7QtuFdpbjAlarzz58
         5KhJ3dCNpLpwRuP5hfVmEOIKZqGTVet0IHIoz+7JsgfSUHvSDNzcdzp0SRtS75nwGt3i
         4+neWC84viSooU5sznw/kqs1YOjDLvm63TMXzWi08H6chn+MLh2Dawl6OAwhoaOk04dk
         xJ+oN8+CNtGBCZ2F3pKj9YqvUQmGyFycaVGumsHBhGBE9I4pOrFtUt1RSUcJ0SEjZIRv
         Lsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=treFpCv/v2Up3Fln8SQMygcym9zynmOgjODNUoZBh7Y=;
        b=YTVCHKuq1NjAGuBhMdKzjzsAzN9Qs3tmlwVlnqg28bE/YWY1Uyn7+GNcQV3h37BGaZ
         KtvMXrV9oBGQU3rOq8cZl6TV9eJcUcj9XV9QLqqAj64d+gaCtJQ2BoDtyv4SzgD5MVOx
         2rNtgs0imlh+iiWzq2A4JzPvBx5DWGCXKzmo+l6S/kzpXwK/NmaE67QJYMASnOK3YuvL
         voJGx5Fu/xSYLM2274tlTijtjguccaqPVuMkNblPgT13TEw2mN/v1yj+UPWhPlnbMTyP
         s1s1LeIzy0KdXOxG0S+E3HolClGJZJ74U/FUfOQnjbP++eyqZ88qwJ+SO8BZKsAnd7fj
         7RJA==
X-Gm-Message-State: AOAM530O1UiTUoLS+Ey+H/RdMbKGXkbtgqUXdvZ+/qYePe5+ScaCT6er
        0ZzqE3bH7LACv8OrBdZnG88=
X-Google-Smtp-Source: ABdhPJzQGOi9neP1JQlUMpp5sFSrdNJjuKLCUypWdg2BTyr6Fd8L4ZOlmoq984GrtzjuuxmcIXcahA==
X-Received: by 2002:ad4:4109:: with SMTP id i9mr10536417qvp.30.1619872327611;
        Sat, 01 May 2021 05:32:07 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1001])
        by smtp.gmail.com with ESMTPSA id g185sm3898165qkf.62.2021.05.01.05.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 05:32:07 -0700 (PDT)
Date:   Sat, 1 May 2021 09:32:03 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] staging: iio: cdc: ad7746: add dt properties for
 capacitive channel setup
Message-ID: <cover.1619841953.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series aims to replace the platform_struct for the ad7746 driver
in favor of device tree bindings, creating the dt-binding documentation in
the process.

Since the header file was only used to define the struct and the excitation
level values, it was possible to remove the file entirely.

Changelog v2 -> v3:
- Add application reference note for the inverted EXCX dt bindings
- Replace macro with lookup table for setting the capacitive channel
  excitation voltage

Lucas Stankus (2):
  dt-bindings: staging: iio: cdc: ad7746: add binding documentation for
    AD7746
  staging: iio: cdc: ad7746: use dt for capacitive channel setup.

 .../bindings/iio/cdc/adi,ad7746.yaml          | 77 +++++++++++++++++++
 drivers/staging/iio/cdc/ad7746.c              | 54 ++++++++-----
 drivers/staging/iio/cdc/ad7746.h              | 28 -------
 3 files changed, 110 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h

-- 
2.31.1

