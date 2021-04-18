Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D946363845
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 00:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhDRWuI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 18:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhDRWuH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Apr 2021 18:50:07 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E8C06174A;
        Sun, 18 Apr 2021 15:49:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u8so24801453qtq.12;
        Sun, 18 Apr 2021 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8f8tA/n6xbmYlHiIyZ3SQubIwB89gaMFiVbKEmjFM88=;
        b=sBL5s/mzvSlS+7z5vmbFtQUGRmmVH/nmWOflKpp3Vbzp2CxBGHsgm2RFnuClq2dZTU
         LZPyLOzPbmhRtn6370n0HG0eoGMsdXTVTtFipOWw+M19sEP2pyys9Ws9AQ1TnjQhug6t
         CJQv9GZQmujb85an5Zem+BtztpSLBEKP1r8QGTUGJu2AgArHDuRulMkhWvjZzB/P3uOh
         bg0GjevkjPQAbQNdeFzZFnnkq6PkSppbtCk4IRLPJXASg0RmytGMckpKQkIJcUK5fOqE
         cK27YuriCP8UmMgxFKQNTEqK7X5NwmH0bbS8vHPrQ4Rq1TKlX9gA7h3fEYX5l/ObDAf0
         Cu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8f8tA/n6xbmYlHiIyZ3SQubIwB89gaMFiVbKEmjFM88=;
        b=TIwDmrZlUjGXyFzZyxE6DEf79KjClL1JtRbAuSR2Ce77I7U2l7OIaZDl/6FqlNA+Pa
         m6D2lpvSo1JTF8ze16eXAevh2GgPgZnfvRhoSI7dJJeI7J7uYwVUv9ZAViorkns9eDNZ
         xiP36dlv8/nacoaJK1jo1uAj85Zy3iW5tluNs1tSb8Coi2/0QphXW7FyrHEQUacKoAVS
         PbkqgkS10I17oQLOoMYG1YwB5t3EoNOMPaP+PhjhrmVcgfyN+b/Re+pQx9VtVirzxIee
         ikISrTdC4ePLIoF16S0bXm7uKVp5qTP8AUYnL9JSp0mLp7OiVWRxmBIXgEBNxAFovfZF
         QlyA==
X-Gm-Message-State: AOAM532lJ0pqwfhmeQR2//5kb5alaAkwtDTReBVNPZFi8hl9UuTsknIf
        71J10u4EYpwWD4ZFbBS1rVWo7kPR355ZDg34
X-Google-Smtp-Source: ABdhPJwaK9jHA8GKdt3RJS12O4sPh2p6fWcn2DGjvdkYOLKGk5QjFrb5ITZQ1Uxu8KSaNE3mpm+xFA==
X-Received: by 2002:ac8:714c:: with SMTP id h12mr4131027qtp.221.1618786177904;
        Sun, 18 Apr 2021 15:49:37 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1003])
        by smtp.gmail.com with ESMTPSA id h23sm7936257qtr.21.2021.04.18.15.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 15:49:37 -0700 (PDT)
Date:   Sun, 18 Apr 2021 19:49:33 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] staging: iio: cdc: ad7746: add dt properties for
 capacitive channel setup
Message-ID: <cover.1618785336.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch series aims to replace the platform_struct for the ad7746 driver
in favor of device tree bindings, creating the dt-bindings documentation in
the process.

Since the header file was only used to define the struct and the excitation
level values, it was possible to remove the file entirely.

Changelog v1 -> v2:
- Correctly set I2C device address on the device tree documentation.
- Change EXCA and EXCB dt properties from u32 enum to boolean.
- Update capacitive excitation dt property to enumerate possible per mille
  values instead of using indexed voltage levels.
- Merge last two patches to avoid special handling of remaining
  platform_data properties.

Lucas Stankus (2):
  dt-bindings: staging: iio: cdc: ad7746: add binding documentation for
    AD7746
  staging: iio: cdc: ad7746: use dt for capacitive channel setup.

 .../bindings/iio/cdc/adi,ad7746.yaml          | 73 +++++++++++++++++++
 drivers/staging/iio/cdc/ad7746.c              | 42 +++++------
 drivers/staging/iio/cdc/ad7746.h              | 28 -------
 3 files changed, 92 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/cdc/adi,ad7746.yaml
 delete mode 100644 drivers/staging/iio/cdc/ad7746.h

-- 
2.31.1

