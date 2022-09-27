Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9E5ED072
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiI0WyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI0WyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:09 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F02EB514A
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:06 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1318106fe2cso4055809fac.13
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=S//7OsDe8/p8Y8+IJnuJys9GCABqkrkm6A6/rJIoNuE=;
        b=Y/HA6sMOqJMeRZYltC3FwFZwmECBBepL5E8azRXbMzYjFW4WMQxVZIJ65QST1L3Vsv
         TBkz9sAh6gQFodfAUqqvZxef7n/Jm6Kh0moEQknGhQRRY4tBumE6faz9PVInMl4KLWyu
         4RK3dSF+tjXq7EAf60hFzSEK9x/YcHNQrCNU3VBUG6WiBmAb6LJt3cRACbR9FXLgIpwk
         ffUdGL3+g4tfTYiI7PtH/fzzo8NP3iakSapdBVqAwNDlK2YoSF5D2zt/Z1qdakARZvLM
         fDx5691abuiq0lRTUPcFqsqQPUkzRSY1WfJCVhpyw06oJjoFje8xSikEBUWUhKt9P36v
         +7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=S//7OsDe8/p8Y8+IJnuJys9GCABqkrkm6A6/rJIoNuE=;
        b=HgYfUlRu4J7zVXHmNXgcm2WJ32bBoCl/9PQZ+lqcGEhmCXtNrgm6GBo5q+DlWpKMVn
         Imly9maJZApLTun1Ok1v/pZ2T6ZLwRuwKeelDJw9xmRTvWWDNttbtW17cjMP9jVc42DF
         95eqdm845QIJdLh9BsMju2YM3JyN0IV+PYWqeNkgueEuW1Ppub2sBO70NZTUWVpX9bNF
         ZR9bQ5Z22qin0D6MgHyl/wNWB0sPvsK3OLQ+M8oDQ2/8garZaKA4BHqnTIDcmUf+s87W
         LsRMfXCs50jMUIF6Ot+SXT2Ox4z3/BYJLaYXX2d6iQRcuITd6Vv+FVd2jY1+Rpx8jhs9
         wriA==
X-Gm-Message-State: ACrzQf3G/MXtx4MWqVIY8wuTuZ5/Zh9JuO8faVquG0i8nhZz6Rb5d0mR
        kD8xEFcLyNMXEshZEbyCpdhQk5PepqQsQQ==
X-Google-Smtp-Source: AMsMyM5C1YLA3yFvfnTcK/xgG1PtFBZQO3OFbgnx8EHOp4T7DIFrcGhGXAxDmJnm5416mZxDtwEd1A==
X-Received: by 2002:a05:6871:5c9:b0:12b:b4fc:471c with SMTP id v9-20020a05687105c900b0012bb4fc471cmr3426204oan.104.1664319245547;
        Tue, 27 Sep 2022 15:54:05 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:05 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 00/12] First set of Counter updates for the 6.1 cycle
Date:   Tue, 27 Sep 2022 18:53:34 -0400
Message-Id: <cover.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Counter subsystem git tree is now located on the kernel.org git
server so the MAINTAINERS file is adjusted accordingly. This set of
updates introduces the COUNTER namespace along with two new standard
Counter components: Signal polarity and Count capture. The big change in
this set is the introduction of Counter arrays which represent groupings
of components of the same type. Counter arrays are utilized by a new
Counter driver introduced here for the ECAP hardware on TI AM62x SoC.

Changes
* MAINTAINERS
  - Update Counter subsystem git tree repo link
  - add TI ECAP driver info
* counter
  - Move symbols into COUNTER namespace
  - Introduce the Signal polarity component
  - Introduce the Count capture component
  - Consolidate Counter extension sysfs attribute creation
  - Introduce the COUNTER_COMP_ARRAY component type
* interrupt-cnt
  - Implement watch_validate callback
* 104-quad-8
  - Add Signal polarity component
* ti-ecap-capture
  - capture driver support for ECAP
* dt-bindings,counter
  - add ti,am62-ecap-capture.yaml
* Documentation,ABI,sysfs-bus-counter
  - add frequency & num_overflows items

This is sent as a patch series while the key update for wbg@kernel.org
is pending on the kernel.org pgp repo. Alternatively, a pull request
follows below.

The following changes since commit 88f48f81d496fcdfe3028f0b40379f1489f67bf9:

  counter: Realign counter_comp comment block to 80 characters (2022-09-27 17:42:50 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.1a

for you to fetch changes up to bb980cb69381c570b72701398991100ac91079ec:

  MAINTAINERS: add TI ECAP driver info (2022-09-27 17:43:05 -0400)

Julien Panis (4):
  dt-bindings: counter: add ti,am62-ecap-capture.yaml
  Documentation: ABI: sysfs-bus-counter: add frequency & num_overflows
    items
  counter: ti-ecap-capture: capture driver support for ECAP
  MAINTAINERS: add TI ECAP driver info

William Breathitt Gray (8):
  MAINTAINERS: Update Counter subsystem git tree repo link
  counter: Move symbols into COUNTER namespace
  counter: interrupt-cnt: Implement watch_validate callback
  counter: Introduce the Signal polarity component
  counter: 104-quad-8: Add Signal polarity component
  counter: Introduce the Count capture component
  counter: Consolidate Counter extension sysfs attribute creation
  counter: Introduce the COUNTER_COMP_ARRAY component type

 Documentation/ABI/testing/sysfs-bus-counter   |  35 +
 .../counter/ti,am62-ecap-capture.yaml         |  61 ++
 MAINTAINERS                                   |  11 +-
 drivers/counter/104-quad-8.c                  |  36 +
 drivers/counter/Kconfig                       |  15 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/counter-chrdev.c              | 137 +++-
 drivers/counter/counter-core.c                |  14 +-
 drivers/counter/counter-sysfs.c               | 304 +++++++--
 drivers/counter/ftm-quaddec.c                 |   1 +
 drivers/counter/intel-qep.c                   |   1 +
 drivers/counter/interrupt-cnt.c               |  12 +
 drivers/counter/microchip-tcb-capture.c       |   1 +
 drivers/counter/stm32-lptimer-cnt.c           |   1 +
 drivers/counter/stm32-timer-cnt.c             |   1 +
 drivers/counter/ti-ecap-capture.c             | 614 ++++++++++++++++++
 drivers/counter/ti-eqep.c                     |   1 +
 include/linux/counter.h                       | 147 +++++
 include/uapi/linux/counter.h                  |   8 +
 19 files changed, 1325 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
 create mode 100644 drivers/counter/ti-ecap-capture.c


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
prerequisite-patch-id: d31273eac584c2db4df3acb4cf4d8fb78e91b4bc
-- 
2.37.3

