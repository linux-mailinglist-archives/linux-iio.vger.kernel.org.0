Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA54537A418
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhEKJ5u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 05:57:50 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:29450 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhEKJ5u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 05:57:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620726992; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WlxFcwav1MRFO+0Mc9pYpdY/uxHjQmHSFj577EMCswyKD+tv60DbSfm3U1So6QIZsC
    tN0l9DMG9BruswJ/zvQZM7THejQWHuk2eZYrECvlp0nAnNhK2rOlXfFjW2LJFrJeu7yM
    eHz8VW2AI9TSjxWbHoNaWy+2kSagurPXEwVl/f3y/rkrmiqIChzX7jSGGLDYpnZydzZ9
    clzPdutDY4P0hXrJyd2Dd7udaYJcydK9rbmO+EIyWsairaNuuhmeYSvD3dn6uvlQK4Kz
    go2RNvyDdVW/Cmkhp0zktTKToiCml9RxyDlO7Mdz2ZoT2AancJfR0MHwdkUgW/vBUGYm
    a5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726992;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=jcNXvz5f9tnYTEscLTSeAx+kTE7Xm9iCh0rpRW6mXpQ=;
    b=a/W0VuS2exEu8EuL9MwalbZ92Zpt8IACx+Wz/H32RH+scBr6ltMlzwW70M5CeR7kmn
    Eq1EoUp/+MVklO0NG3F9i2sPvZlQn15Pag7eUgUWMR3WK8fDDgILpB53CvLxDpn7lJK+
    F8t8++MfPLSsDw/GZuIeq0xeJxMxvcyiuYKP6QkhkYg/wpxR5/qUIsIvHjMS/PZYBHuF
    brsHcb6xwTlD81Z5BTNqdExiM+PGGR4+ByncrjQXJ0bMz4OGJJr2SLNoTqYYhC5qR6h7
    Rofb54ONdrSUkCnp/qFXcFORFZQFxXuhhj1Z2CUUJVFCecjk2Dyt0TqutnPinnA2zikC
    k3gg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620726992;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=jcNXvz5f9tnYTEscLTSeAx+kTE7Xm9iCh0rpRW6mXpQ=;
    b=VKGdWXuOGoOHzEwY7+0LEo5EI/4raXChYpG0CCTolVlBRIU/I7Js65ze6S/4Vd+iR4
    /GXiqr6XT9ovBKfccYLCq4TphEpiL5CIHj/+GJr4/PUwIfY4t+/w75j/XeTY3GMcSZM9
    LVha8z7b7zWP8mtAVBjLW0vxlYYuvWQDv5lY1WUAfj13h2T7OCGkGltmtNk8JVG8fQ/k
    /dHpb19Es2lOSzM1Bo3jEybF5PFwiI2bywPljKSCHa3qYJ9wdGWXuNSSbBA9XOX13Kd8
    uM3fSll7XnJ5BJDvbgheUfoMnCmTgFrtc+WyzUEZcu7sJN9wm+1MlGg1urVWP5JoMsxt
    Iy5A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONKhX"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id R01591x4B9uT06D
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 11:56:29 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Date:   Tue, 11 May 2021 11:54:06 +0200
Message-Id: <20210511095409.9290-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

KX023-1025 [1] is another accelerometer from Kionix that has lots
of additional functionality compared to KXCJK-1013. It combines the
motion interrupt functionality from KXCJK with the tap detection
from KXTF9, plus a lot more other functionality.

This patch set does not add support for any of the extra functionality,
but makes basic functionality work with the existing kxcjk-1013 driver.

At first, the register map for the KX023-1025 seems quite different
from the other accelerometers supported by the kxcjk-1013.
However, it turns out that at least most of the register bits
still mean the same for KX023-1025.

This patch set refactors the kxcjk-1013 driver a little bit
to get the register addresses from a chip-specific struct.
The register bits can be re-used for all the different chips.

The KX023-1025 is used in several smartphones from Huawei.
I tested these changes on a Huawei Ascend G7, someone else reported
they also work fine on the Huawei Honor 5X (codename "kiwi").

[1]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf

Stephan Gerhold (3):
  dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
  iio: accel: kxcjk-1013: Refactor configuration registers into struct
  iio: accel: kxcjk-1013: Add support for KX023-1025

 .../bindings/iio/accel/kionix,kxcjk1013.yaml  |   1 +
 drivers/iio/accel/kxcjk-1013.c                | 217 ++++++++++++++----
 2 files changed, 176 insertions(+), 42 deletions(-)

-- 
2.31.1

