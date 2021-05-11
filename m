Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB637A922
	for <lists+linux-iio@lfdr.de>; Tue, 11 May 2021 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhEKO0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 May 2021 10:26:33 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:20293 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKO01 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2021 10:26:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620743105; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NF+OFQgzrekoHM5xyqMA8gw5NvXgdy6Z77mA1xeQj894YBMZrDyNlYeaCyXT4CRzHk
    xPwlCMgNMVUcw+YyqAdpqK8fOCAui3CTnz1S6/BdiX+ttiFUkjElwYf6NZwnWvVtxQ+n
    kncabCQ4VBjYiO5Q6X75NgP6PivGj3ohT/ry0ND1fin00v5poc+WB62IXgCZEcCknDeu
    ZJM8hVbZMKpL6qAAVqTCg1hMxhF5EN578IVY4U/riZlYtVmKXm8gTgfj+6/lBNMTjqhY
    uMiBB6mZhZxhgTDHKWWOip5heO+G5mWyafuekFmfQdVFXEmbcAr23/4FWM852B/R0DTj
    LWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743105;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r/Ni0FryO9K/vUkVT2nkJsHpNPj8imbEelIDzy5qRhA=;
    b=eFSKZ83WgcILhQS5H46uJEPGztW/adT9fPn6j50DdzFdBoqgXleU54YEwmJg0GMs2b
    +EI6Q7m7dH/N0RdUO8W2onEUf7tgVpiW2kfcuIEPidn/Ftvc0lUX8v6vnyFsHACEu/va
    s14+/QP2Jm4AenUfRytP3wLxxFg8fl32zWNG7w4S/T4zy0Nn9uC7zcW34NeqfygEEf+9
    y2B7rTHevdSrW6zNj0OkvJ0nLHG7xud8OKBshk4B+1s9dnT9HCNvm57IKVE3IPMA+7i8
    rBP311+jgfEDf0jj2PAuYH5AHhjKnOwDBWmjJqiucHrUiiyVyUT350H2uDpjmha8hJat
    H7Og==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620743105;
    s=strato-dkim-0002; d=gerhold.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=r/Ni0FryO9K/vUkVT2nkJsHpNPj8imbEelIDzy5qRhA=;
    b=H3A+0jnl5ggiFXPxic4uGcUmJJV6KGQh2fIEo/DGYONbk2i9CHkP7y6gsjOBVqkel8
    jQFDlNWrNmTeSVy+FiBtX/YS3Rbl4PY8M6p5WK1xwWZGgr2hCb6RIH8709mhquHXX6xb
    vZtJe/rch0mDFlMKGKdnaUX9gHF9sIJDg0/JejqzAl+WHt3bnpsW6X14PWcFTWA1To7m
    L0glbekD3LUIsFBoY5EeAMz7gfOcUeeQ+o1odnpm2EBMsAlkXCDPBDZx73HBTYLItZHP
    GqRvDsx47KizQXjqd11R9YLjeez0RYXVm0Wa4d4RsuH1CPcF0wq1L78uFHpyq/8Ugux+
    Pr3A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONKhX"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.25.7 DYNA|AUTH)
    with ESMTPSA id j06c13x4BEP20bj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 11 May 2021 16:25:02 +0200 (CEST)
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
Subject: [PATCH v2 0/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Date:   Tue, 11 May 2021 16:23:59 +0200
Message-Id: <20210511142402.4457-1-stephan@gerhold.net>
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
---
Changes in v2:
  - Make register structs static (reported by kernel test robot)

Stephan Gerhold (3):
  dt-bindings: iio: kionix,kxcjk1013: Document kionix,kx023-1025
  iio: accel: kxcjk-1013: Refactor configuration registers into struct
  iio: accel: kxcjk-1013: Add support for KX023-1025

 .../bindings/iio/accel/kionix,kxcjk1013.yaml  |   1 +
 drivers/iio/accel/kxcjk-1013.c                | 217 ++++++++++++++----
 2 files changed, 176 insertions(+), 42 deletions(-)

-- 
2.31.1

