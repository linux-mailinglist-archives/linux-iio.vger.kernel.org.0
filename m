Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391F222B9EB
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 01:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGWXDr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 19:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgGWXDr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 19:03:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B037C0619D3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k1so4063291pjt.5
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qw4QtLf9h0dWLD1tLtdlpFNq04wjyH0zPYPXjM/kNIY=;
        b=QR5ItLor0G1ODYiyoFtXeR0oP5/b1Ng0XOrIZ67H5PQ65lNBqm7ziVSp4jeuDAhF1w
         XVwtBEizARYrTc4q1TZXcyo7kM7Jzzr0aenLJ8DQapULqgomEt1uBfaf67sm+PpYCgQd
         eJMPzArtkXGhsiHMAZ6YhrlIjKzrrhrhm+h64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qw4QtLf9h0dWLD1tLtdlpFNq04wjyH0zPYPXjM/kNIY=;
        b=XCyb5cn1qycvPinCWKvSjpwNNL/c9AHLW/wffTmwNcgGD748F625A7NB/dTRkvkD8v
         WuzSTvKRKx+4fCk6US2a3W0T67O29Sz4sAYrdAerjDYf5deYsOp8cxHoOXU2EdYviEMv
         +Cue/hjtTBiEZYNbIvUMEHkWqql7Qy8gd9HTq0FRVlU3Ba8jf8Kdhwnmz4cWwwxD6dn3
         ARNooF7E99e0mcEn2e+D9e5kwxVr3r1eJOsZtRsZMw+kkOD6QON/NJy9rtiiB3V1Cm6O
         XGunrBfp4q7Bpt3lFI4UmWT5pVlpxmtf+eVOhlOt7524UJATvdeXj7ElNn38GkTSZaMW
         FjTg==
X-Gm-Message-State: AOAM530oR/MMtjycsXC2vO92JvrH/8lGZ58zdi7z5BA8YX3elrz0B5Ic
        Aez5xhdnKRF1j14UMsAuPQ761w==
X-Google-Smtp-Source: ABdhPJxnr7q4Kieh9u6L2nh1D98Gdl4HPX9AzDRpPhjGvo8uPCnIV38Eg6hloV6Fm1l2ExDQKMC9qA==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr5631358plp.65.1595545426415;
        Thu, 23 Jul 2020 16:03:46 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k98sm3816070pjb.42.2020.07.23.16.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:03:45 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>
Subject: [PATCH 0/3] Some sx9310 iio driver updates
Date:   Thu, 23 Jul 2020 16:03:41 -0700
Message-Id: <20200723230344.1422750-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These three patches are only related because I'm looking at this driver.
The first one resend the DT binding for the driver that was merged in 
v5.8-rc1 with a small change to update for proper regulators. The second
patch fixes a few printks that are missing newlines and should
be totally non-trivial to apply. The final patch adds support to enable
the svdd supply so that this driver can work on a board I have where the
svdd supply isn't enabled at boot and needs to be turned on before this
driver starts to communicate with the chip.

Daniel Campello (1):
  dt-bindings: iio: Add bindings for sx9310 sensor

Stephen Boyd (2):
  iio: sx9310: Add newlines to printks
  iio: sx9310: Enable regulator for svdd supply

 .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
 drivers/iio/proximity/sx9310.c                | 59 ++++++++++++++----
 2 files changed, 106 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Daniel Campello <campello@chromium.org>

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
Sent by a computer, using git, on the internet

