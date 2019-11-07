Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D64F2EA7
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 14:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbfKGNAQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 08:00:16 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:34209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGNAQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 08:00:16 -0500
Received: from localhost ([46.78.193.225]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MVdYY-1iItlD1uIm-00RbhR; Thu, 07 Nov 2019 13:59:43 +0100
Date:   Thu, 7 Nov 2019 13:59:38 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com
Cc:     mripard@kernel.org, shawnguo@kernel.org, heiko@sntech.de,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, christophe.jaillet@wanadoo.fr,
        tglx@linutronix.de, mchehab+samsung@kernel.org,
        davem@davemloft.net, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] iio: add driver for ping))) and laserping sensors
Message-ID: <20191107125936.ylsfkerxi5tfiaoc@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:dQQZLcFHM0gjAQfgLrHIW/FPizZ3tzk9WpK/cOCGEdlA5djD9RE
 GDegTPWzUrbwQvF44FOeQmrQW5001GzXlwlc6b2yIwO9qAIO9NPaax++0rPXyJUxg9bvT6S
 c2Zzow360wsYlKH0/tgq9gm7TcIZejzZORtVbThmduyzRoTeH7Kc5AgrCn7EVUaP3W2KFsC
 XQvNySdzd3GOPEuOwaBmQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2MhI4ECH7Y4=:bh88XNQu7ElxS5Lc71VJ0c
 rvppYyzIUqrLSgyIaFy4cYTKqaGlXBMUmAwrxn4VmmhvQwpWq6tQCy376dfNFRxiBOnySFdYS
 U+IU8INrboXrCNw7uSd1xpiru3BhIXWsEbQI3ueyWaBF5nVU7ur8VvRxwWGFc17CH7tfua9zD
 4jdknih01C6ughY8Q6XovO0PjEeL1G9LDQ3allL7hUsmBnG8ypFOxo2v8EcAc2rPRVtBwgmo7
 vD8C1OZHRt/1GtPMP5ZSYMPi8jGvbsLokfBA/FFGYCfKalPg7WQIDuWjQV3NetTAcMmGjhNim
 OpZBaS2C0OCqGBucaM3IVZPHVfqbYgWniwS5zLGb7aNpa5Dd2FxaJHl6xeJYnEnMQKYT2uxSR
 8saU4+nFdG7bREnTPQ65UVb3EMgI+NWrtXwzWE/IsGxLtqcKEaB8sWBhScP8QV7h3ICfpf/km
 fwDHPq5TzcaVLJMTXNc2XWHxYTpcp4D1QUMC6Pvmjb03+vHQKbiJkP2plVGQnsES/FtpgrixJ
 uMRQiYb9QcsRgui3asBsFir2FcOsKlHgxTpSaPwkepNFUelfuA5EWhhlXeeCVNZt+sxH/+FgK
 0ShVff2oxuCKWClphHk9pK9LKBCODO1BACPPytDR1q0QV34Jj8L0Dx53Dohxa5tfW8JxIsbKl
 +ybbdbCeTn4CSiB0yQUHqtPSzWsowqNUiQm6TIH6MpaFhH55g84nfV60PwGkaoqrHypRFHJ8Q
 m0KdKeDnZfrcmwCAeNA2STcovuXBjEAOYFxmz+r5ry+LGXCmZiJ2joGLkKj3TegGPEJt0rNEV
 /hq5PQDMzJUO35b35fq2Ty7mLMGmVhKo5Afutlq3VO18p2OtZNs+pUO8jVRF+UeUCucKpxL1m
 CoOpogdFZsek/SESDDmg==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchset adds support for parallax PING))) and LaserPING sensors as
iio driver. The driver is derived from srf04 but the device is using only
one GPIO for both triggering and the echo.

Andreas Klinger (5):
  dt-bindings: add vendor prefix parallax
  dt-bindings: add parallax ping sensors
  iio: ping: add parallax ping sensors
  iio: add ping sensors to kernel configuration
  MAINTAINERS: add maintainer for ping iio sensors

 .../bindings/iio/proximity/parallax-ping.yaml      |  51 ++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   7 +
 drivers/iio/proximity/Kconfig                      |  15 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/ping.c                       | 336 +++++++++++++++++++++
 6 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
 create mode 100644 drivers/iio/proximity/ping.c

-- 
2.11.0
