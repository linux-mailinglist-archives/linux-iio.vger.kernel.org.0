Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA43359F27
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 14:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhDIMsS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 08:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233712AbhDIMsP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Apr 2021 08:48:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DEB26113A;
        Fri,  9 Apr 2021 12:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617972481;
        bh=KVB99uveFfZEtOFS+rw6+GuSTG0eUAu7eT5aXgN+A2I=;
        h=From:To:Cc:Subject:Date:From;
        b=HVeqO0LTdb6P34NPuz+kcIo3Rf749nd/WbbdJGxFgX+jaSQh3ut1YKoPYl1MgyRxh
         Q7kRjml+eMUN9cb6xXsqyy1LpRy94RSYcfiRD58M7/eXFD0KYEG5fV6LbU9gb6NNhs
         OKJrR0HItZx9dkSG0Rw4RaD0KWq57c5q3+CPTWH2cN7XJpYHQhm2OdH9T1q1mdIFOS
         qamXogV+8qqqQnkylXpoWSIOs+K54//txxScI0SkPXbR+BMNCVw9UukyZhMQi81Ybh
         U+G/5ZiQeDykJPDsU7gNFXuoH2Hs/Mon3ZPlABh5XFVA3MUkHq3gld+lw+RHLfRuKm
         yWvyZlhUcvMnA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lUqYE-001SLe-2j; Fri, 09 Apr 2021 14:47:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Alex Shi <alexs@kernel.org>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kir Kolyshkin <kolyshkin@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Wu XiangCheng <bobwxc@email.cn>, devicetree@vger.kernel.org,
        kvm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v3 0/8] Fix broken documentation file references
Date:   Fri,  9 Apr 2021 14:47:44 +0200
Message-Id: <cover.1617972339.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jon,

As files keep being moved around and DT bindings are 
converted and renamed to yaml, their doc references get 
outdated, pointing to an invalid places.

This series address those. It is based on the top of docs-next tree,
and most patches here are independent from the other ones.

v3:
  - Dropped patches already applied at next-20210409 and
    changes that would cause conflicts there;
  - Added received acks.

v2:
  - Dropped patches that were already applied, Most of those
    will be following via Jonathan Cameron's iio tree;
  - Dropped patches that don't apply on the top of docs next.
  - Added some new patches fixing other breakages.

Mauro Carvalho Chehab (8):
  dt-bindings: don't use ../dir for doc references
  dt-bindings: fix references for iio-bindings.txt
  dt-bindings:iio:adc: update motorola,cpcap-adc.yaml reference
  docs: update sysfs-platform_profile.rst reference
  docs: vcpu-requests.rst: fix reference for atomic ops
  docs: replace transation references for reporting-bugs.rst
  docs: translations/zh_CN: fix a typo at 8.Conclusion.rst
  docs: sched-bwc.rst: fix a typo on a doc name

 .../devicetree/bindings/hwmon/ntc_thermistor.txt |  2 +-
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml |  5 +++--
 .../devicetree/bindings/input/adc-joystick.yaml  |  4 +++-
 .../input/touchscreen/resistive-adc-touch.txt    |  5 ++++-
 Documentation/devicetree/bindings/mfd/ab8500.txt |  4 +++-
 .../devicetree/bindings/mfd/motorola-cpcap.txt   | 16 ++++++++--------
 Documentation/scheduler/sched-bwc.rst            |  2 +-
 .../translations/it_IT/process/howto.rst         |  2 +-
 Documentation/translations/ja_JP/howto.rst       |  2 +-
 Documentation/translations/zh_CN/SecurityBugs    |  2 +-
 .../zh_CN/admin-guide/reporting-issues.rst       |  4 ++--
 .../translations/zh_CN/process/8.Conclusion.rst  |  2 +-
 .../translations/zh_CN/process/howto.rst         |  2 +-
 Documentation/virt/kvm/vcpu-requests.rst         |  2 +-
 include/linux/platform_profile.h                 |  2 +-
 15 files changed, 32 insertions(+), 24 deletions(-)

-- 
2.30.2


