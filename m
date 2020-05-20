Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADB1DBE44
	for <lists+linux-iio@lfdr.de>; Wed, 20 May 2020 21:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgETTru (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 May 2020 15:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgETTru (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2020 15:47:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62885C061A0E;
        Wed, 20 May 2020 12:47:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 190so4936288qki.1;
        Wed, 20 May 2020 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Blqel+Lg0GrdrDqgqLEGtoLCDwubGnilFw19mOoFR08=;
        b=Pkm/czaZIxyzsuqyh6KRPS3aAcX27+37sr99gu3eCe9+bPJgSbqT+RKWwB9wayZyfm
         ZnDFq8r0PEP0HYqFyvQXMsauw6lkd75JyGVoIpYifjZ9/jSuRjfH4cU+FPz8skb155Ok
         fqqteqzeZchI7WHm9K1Wd6yc7vSDjejXUT63CB8OTu72Jz90v3GkSz3ukXR8BlcDPIsL
         Q0ijDlhHAgiVY1VkyyGF5y1x7XXQV3ZiCzBohBT3M3xCAW4Y00KkY73OBoDj+CrVWhCQ
         0NEidUy0KrhH4QvKcVox52pLmaUgc4mgbqn9ZOTRb2KzU8APiWqTdV2vqbuUGn7Grogp
         c3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Blqel+Lg0GrdrDqgqLEGtoLCDwubGnilFw19mOoFR08=;
        b=kwRvskFZ2Db0krhwXBXq7ArDLckBNaQxEmhSIHJQgBqKsu2pW2/Ho0pBXxSjRXni0r
         1y9NFM94TRrRwh2/Z5x0tDw/P0yrpycxzfUg6pFh9yOPrlxYFz1dgULI5N/LLeIUxAii
         KKms3EqGDvoPogkOER6Yx4gSkiJRAtvDW5iiU//hLE57dI4hlYhTp99BFmTogJyjgGM8
         7HLNM++fFooglp2JbLnYMjmTTeFxGTvi4zbAlDPpQvFX13ttHzlBc3POfCr3YIasYDdB
         3dqtM0we6HJQGZNhJ2z134Lm8DL5a4bhVC/zes9KSxzEpFuZLsDBK8ECc8/6h0+jkztp
         fz4Q==
X-Gm-Message-State: AOAM530eo47jztuHiQxHs7/q7AYc868K0TuMAr+jXveroumlqBdCdOGZ
        PfB8cCeuxsg78h0XwcQKzgkckipAW6V/5Q==
X-Google-Smtp-Source: ABdhPJxFuEIQvqhbtAxM6G3VGgaF3HBXvuGCe7e62zvUpN2KTqWGDjawLtBgklie0Mt0zRi1XjuraQ==
X-Received: by 2002:a37:7347:: with SMTP id o68mr5960625qkc.343.1590004069150;
        Wed, 20 May 2020 12:47:49 -0700 (PDT)
Received: from ict14-OptiPlex-980.kataweb.it ([178.23.248.46])
        by smtp.googlemail.com with ESMTPSA id m33sm3158419qte.17.2020.05.20.12.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 12:47:47 -0700 (PDT)
From:   Jonathan Albrieux <jonathan.albrieux@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, daniel.baluta@nxp.com,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 0/5] iio: imu: bmi160: added regulator and mount-matrix support
Date:   Wed, 20 May 2020 21:46:39 +0200
Message-Id: <20200520194656.16218-1-jonathan.albrieux@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

v3: 
 - separate typo fix into another patch
 - clean up of documentation
 - clean up of patch messages

v2: 
 - fixed missing description for iio: imu: bmi160: added regulator
   support
https://lore.kernel.org/linux-iio/20200519075111.6356-1-jonathan.albrieux@gmail.com/

v1:
 - initial patch submission
https://lore.kernel.org/linux-iio/20200518133358.18978-1-jonathan.albrieux@gmail.com/

Convert txt format documentation to yaml.
Add documentation about vdd-supply, vddio-supply and mount-matrix.

Add vdd-supply and vddio-supply support.

Add mount-matrix binding support. As chip could have different
orientations a mount matrix support is needed to correctly translate
these differences.

Jonathan Albrieux (5):
  dt-bindings: iio: imu: bmi160: convert txt format to yaml
  dt-bindings: iio: imu: bmi160: add regulators and mount-matrix
  iio: imu: bmi160: fix typo
  iio: imu: bmi160: added regulator support
  iio: imu: bmi160: added mount-matrix support

 .../devicetree/bindings/iio/imu/bmi160.txt    | 37 --------
 .../bindings/iio/imu/bosch,bmi160.yaml        | 92 +++++++++++++++++++
 drivers/iio/imu/bmi160/bmi160.h               |  3 +
 drivers/iio/imu/bmi160/bmi160_core.c          | 46 +++++++++-
 4 files changed, 140 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml

-- 
2.17.1

