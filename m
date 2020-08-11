Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B02241BBE
	for <lists+linux-iio@lfdr.de>; Tue, 11 Aug 2020 15:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgHKNtg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Aug 2020 09:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgHKNtX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2020 09:49:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60445C06174A
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 06:49:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so7641145pfw.9
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2020 06:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIodzngtBRPfScb7rNUpypHu68kREIOj0kig+r0H2Pc=;
        b=R8xxjdMSdDDazxPQ4Lor4vTjPEVcj3cNeFYcaBdcJdqSLpK7PQmNo0nft7sW733tNT
         KMwYbKHbMtvKcABVWYNLqvyUv1kfLO9zPDr/EolP4934hG6DNmjQFwcQ/CMmMxXWyWFc
         aN9IHo1i8BUj8e/oxqZxbB0ncuevPFDcEOjyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mIodzngtBRPfScb7rNUpypHu68kREIOj0kig+r0H2Pc=;
        b=hbJdQTtJ/vWw8uoHWt196fr9AHFRZ0QdMlL5CyiagLEct3ybY+vL0OhF2/C8jgbn03
         ISwAKC/9p230WdZjPfo12B815qG90/c+pIXtXmO6AKCj3OsD8DmlS3S2XnjcPCEj2ITC
         4WoRI/iHZUEjinlb1b8W0pJZjEWM3hLVIagnUWnj4wKMHtb2tawvgIGd7EWd47inLVoH
         go8c+8Nt0lyLhahP4AHyP0TlfSvVWZz0EqnMNhh7NUhSn35UjEpWjKFY7ISyOlIWnHvW
         uFd2mSqfy0tqaKe4Ao4yyidviCgpenyHX5gLI7nJdPdfCtdKXXTRsKfDwRpX0P+ZsPsj
         tABw==
X-Gm-Message-State: AOAM53249cxO/JLLqDowpQ0TSNrKa+6TccsowagTlANZuB374qloMY/m
        DYno/Gp7JsGuxIqphl4bXaik0ztttkE=
X-Google-Smtp-Source: ABdhPJwDCT3o2tQ1W5/6CMUYk5AnAlld9ufK9Q90elZRK+MHEyBAci2KFLyQkadDvDnOwSbOJoKwRA==
X-Received: by 2002:a63:5866:: with SMTP id i38mr902952pgm.223.1597153753358;
        Tue, 11 Aug 2020 06:49:13 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id w23sm20884447pgj.5.2020.08.11.06.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:49:12 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-iio@vger.kernel.org
Cc:     daniel@0x0f.com
Subject: [RFC PATCH 0/2] iio: st-accel: Add support for Silan clones
Date:   Tue, 11 Aug 2020 22:48:44 +0900
Message-Id: <20200811134846.3981475-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This small series adds support for the Silan SC7A20 and SC7A30E
accelerometers that seem to be clones or at least based on the
LIS2DH from ST.

These chips seem to be widely used in car dash recorders and the
midrived08 dash recorder that I'm trying to mainline support for
has a SC7A20.

This is RFC because I'm not sure if adding clone chips into this
driver is going to cause anyone trouble and I'm thinking there has
to be a better way of supporting both of the chips that are basically
the same but have different WAI register values than copy/pasting the
block and changing the WAI value.

Daniel Palmer (2):
  dt-bindings: vendor-prefixes: Add vendor prefix for Silan
  iio: st-accel: Add support for Silan SC7A20 and SC7A30E

 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/accel/st_accel.h                  |   4 +
 drivers/iio/accel/st_accel_core.c             | 159 +++++++++++++++++-
 drivers/iio/accel/st_accel_i2c.c              |  10 ++
 4 files changed, 174 insertions(+), 1 deletion(-)

-- 
2.27.0

