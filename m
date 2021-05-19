Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86213889C3
	for <lists+linux-iio@lfdr.de>; Wed, 19 May 2021 10:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbhESIxL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 May 2021 04:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245541AbhESIxL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 May 2021 04:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A3B560C3F;
        Wed, 19 May 2021 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621414311;
        bh=Xxq1uGAbMGFgeGY3ywEv0OBhOMcnDBc4Aw7rV293abg=;
        h=From:To:Cc:Subject:Date:From;
        b=HDXmH4kOj1Ffc8/2cPIVagMkwv75xN8kuE4Rn2GW4zUfWOy+/uoxuQky8Dxr9RDVR
         fVbJMLGgIq+XN+7alWCEcvtKmIWWeiFvOiQyJ9+cMJ+eSmjCj1liIls/T2ERP28sI/
         Mx2fxh/6TMjsCdbJkuDfE+YtP5rjlL4GYJEyhOZQoAdSbeHyiSWV4ePGv7ROh0zXu8
         AjzAbT5IYTV7AdlhASpd63KP0Dt2giApS3oj5J8fG1nIer7c4N9j0aGbYuzwaHItI1
         /kiR1YGrJsdKvu92/Jkc0v9EXHz/fFBf6YBUXpnf+fLICsbgPu9SeBtSBORPjhj95H
         lVUyUg6TpgwrA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ljHvh-007gXv-8w; Wed, 19 May 2021 10:51:49 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        kvm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH 00/10] Documentation build warning fixes
Date:   Wed, 19 May 2021 10:51:37 +0200
Message-Id: <cover.1621413933.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jon,

This small series contain a series of fixes for the documentation. it is
against your docs-next branch.

Three of the patches fix duplicated symbols at the ABI documents.
There are still some ABI warnings from IIO, but all but one were
already fixed at linux-next. So, hopefully, after having everything
merged, the ABI warnings will be solved.

Mauro Carvalho Chehab (10):
  docs: update sysfs-platform_profile.rst reference
  docs: vcpu-requests.rst: fix reference for atomic ops
  docs: translations/zh_CN: fix a typo at 8.Conclusion.rst
  docs: sched-bwc.rst: fix a typo on a doc name
  docs: update pin-control.rst references
  docs: virt: api.rst: fix a pointer to SGX documentation
  docs: ABI: iommu: remove duplicated definition for
    sysfs-kernel-iommu_groups
  docs: ABI: sysfs-class-backlight: unify ambient light zone nodes
  docs: ABI: sysfs-class-led-trigger-pattern: remove repeat duplication
  iio: documentation: fix a typo

 Documentation/ABI/testing/sysfs-bus-iio       |   4 +-
 .../ABI/testing/sysfs-class-backlight         | 100 ++++++++++++++++++
 .../ABI/testing/sysfs-class-backlight-adp5520 |  31 ------
 .../ABI/testing/sysfs-class-backlight-adp8860 |  37 -------
 .../sysfs-class-backlight-driver-adp8870      |  32 ------
 .../testing/sysfs-class-led-driver-el15203000 |   9 --
 .../testing/sysfs-class-led-trigger-pattern   |   3 +
 .../ABI/testing/sysfs-kernel-iommu_groups     |  12 +--
 Documentation/scheduler/sched-bwc.rst         |   2 +-
 .../zh_CN/process/8.Conclusion.rst            |   2 +-
 Documentation/virt/kvm/api.rst                |   2 +-
 Documentation/virt/kvm/vcpu-requests.rst      |   2 +-
 include/linux/device.h                        |   2 +-
 include/linux/mfd/madera/pdata.h              |   2 +-
 include/linux/pinctrl/pinconf-generic.h       |   2 +-
 include/linux/platform_profile.h              |   2 +-
 16 files changed, 117 insertions(+), 127 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp5520
 delete mode 100644 Documentation/ABI/testing/sysfs-class-backlight-adp8860
 delete mode 100644 Documentation/ABI/testing/sysfs-class-backlight-driver-adp8870
 delete mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-el15203000

-- 
2.31.1


