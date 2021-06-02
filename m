Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF0A398AFA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 15:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBNsV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 09:48:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37882 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFBNsU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 09:48:20 -0400
Received: by mail-ed1-f50.google.com with SMTP id b11so3003254edy.4
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBFoud2hj48x46Wgh3PP584CpEIrCCIgTBZ0c8Yhflc=;
        b=e+qnh7kRVW3JpAHnzSDg+fX42SIhgrOc6XwQxmRlFMVB8mjukcHgk9apvA/bWRc2e0
         GiQBvmllQFRTMO0tuW9R/XudvJ1yFxpNs0KNgOzf1yII5xLT6YnpIflDiYdFCHxVTDkx
         yoIXDru3+QROGrIk5H3rRaesVRYAgEylENXOnMp3RS5+XuoquqO6Pt9bbe6AcoVx3WBj
         9Pqvx8R5a67NJW/PdzbjZlnr2q+LYKOjg5drrFIHH8JsrTNDzqjVeDPj5I9ICc7PrM+w
         4SLRjE1FgPtp9Xa7PZTumOrscp3SKJcyqox3Qm0nc31oQoAZOTrd8ZBhbbILB31fwV72
         NkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EBFoud2hj48x46Wgh3PP584CpEIrCCIgTBZ0c8Yhflc=;
        b=PPyJFmQX4njzgZSlhZ6f8MlJRlixlpvAicnkOPe4HIYemfPbdpcyWEeiMlybe8owgu
         t4lJaV1pgEAdthBareyUhmeeYPpfQ9ziY4+/2PAc/pl1FU4TdIUnnskBrYJenZKS55BP
         IXUw/xbEfjMOxTmUsDUvp4MdzmksQ0D6K+9jWGohJIfjXjcyEEbl0JLOA/W99VsLxAqz
         lPWNUUfaNSs06lBeTVu3AFFN5KK+GSoRlQ+B8+hu4oOHuqzErpxEWRpNxw2E2nSLI9jb
         uTE2fmeo2CWOlC1wKW8yhav5d+/AyPPJKqqG87MSBmqsYM9L+/CLER+Xm0TlYQ1Vs0DX
         VVOQ==
X-Gm-Message-State: AOAM532riZL7EgtGjGiA0jRSb+ynzP1AsYuL2w1iI1nHpTPBA02Y+2QK
        XZboO9D1iHUZFY2ujuEzyqs=
X-Google-Smtp-Source: ABdhPJyajoyK1HJkbDvFw7h+q5xdM3f/18ht6/42G0jkMGfmRH9KiYVMDmDvaJPLTxFC2gGwlZ6w0Q==
X-Received: by 2002:a05:6402:1c11:: with SMTP id ck17mr1593907edb.102.1622641524157;
        Wed, 02 Jun 2021 06:45:24 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8070:b9d:f200:bee0:f4e2:68f9:3d11])
        by smtp.googlemail.com with ESMTPSA id n2sm1372305edi.32.2021.06.02.06.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:45:23 -0700 (PDT)
From:   Christoph Fritz <chf.fritz@googlemail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH 0/2] Support for isl76683 ambient light sensor
Date:   Wed,  2 Jun 2021 15:45:10 +0200
Message-Id: <20210602134512.193186-1-chf.fritz@googlemail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchstack adds initial support for isl76683 light sensor.

Christoph Fritz (2):
  iio: light: Add support for Intersil isl76683 sensor
  dt-bindings: iio: light: add isl76683 light bindings

 .../bindings/iio/light/isil,isl76683.yaml     |  48 ++
 drivers/iio/light/Kconfig                     |  12 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/isl76683.c                  | 604 ++++++++++++++++++
 4 files changed, 665 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/isil,isl76683.yaml
 create mode 100644 drivers/iio/light/isl76683.c

-- 
2.29.2

