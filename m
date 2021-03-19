Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8EA3426E3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 21:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCSUap (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 16:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhCSUaT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 16:30:19 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860CCC06175F;
        Fri, 19 Mar 2021 13:30:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y5so6694221pfn.1;
        Fri, 19 Mar 2021 13:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuZV268/nVtB3OjLJrE5F7mxwQHJCxzo9Qb+tN9aqg4=;
        b=EJOzD8me34yPyBID9l4WiBKbwLsvi1lfneiWYrTmdnZjhhSjncjfX0qXtV6VNYWYPs
         +t7+OKTaQJ9hlRyyZl8OSkfSEF14JvMykZ1By6dUFeTBmvtkUkiKMkYO271gwt/97bbb
         tTCoZqUQ5GXHfJ/ivkb7Rgq6N5BndaB/Lo1zTS2Knd1rZvkZJHcNTTjp3YcupwBPVa7h
         0tck/b0baYNl55uqgcBwN3BEiJofMUZnSrxlIhZoxU3I1si+0sYtFU16upnFxVxhOb7t
         q99d3DeOJfUqlHtQCkeqlLeYNedPJPryJjZAt22uIlO9RQJOPrDBB0TSNaGehcetVcyX
         RBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vuZV268/nVtB3OjLJrE5F7mxwQHJCxzo9Qb+tN9aqg4=;
        b=JNYVgXd5HreHToaZEoqkhcifP429Iw6xTW3YVXbuSfFhKWDUu3/rytkQfqcDLlBlFi
         G/Ohb5dAcylaoS5UHxaj0ola//kP6BBxjKzcxfdSafg7sQ80900ISoIHLf1N3eFDP66u
         0VAW5PG/OYzDKCbycM2tA2UlLcTY447JZHNiqmwDTOucMHn8y9XZVCx3IU16bmu220aG
         qHspq5f0el5rtkHKj9l0KiZKlpSFVskezb58Sbq+drlDGAm7Q+oz8mwBfm0jqDfFcP4U
         ziKP/pD4bgc24EqGcVfoRdp78tXP/HFra7DkRPjw8qgiiXWny2D76VG52rjbpafrb+K4
         Pt9w==
X-Gm-Message-State: AOAM5302r4t2diJ38EE2/I9rbc2E3C+4EIoCX833AMDrVAO/dPXCaZ0b
        TbFSj6O/KeDTFKNWUL9pSBQ=
X-Google-Smtp-Source: ABdhPJwrrdKepZOzJFiQzpwaL8rEeiWmi1WBjh/NvKH3qokI2DU70jSxdOR1jH0elah3imSKSJ8Sgw==
X-Received: by 2002:a65:4887:: with SMTP id n7mr12915057pgs.14.1616185818926;
        Fri, 19 Mar 2021 13:30:18 -0700 (PDT)
Received: from localhost.localdomain ([27.255.182.86])
        by smtp.googlemail.com with ESMTPSA id m21sm6340406pff.61.2021.03.19.13.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:30:18 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH 0/2] iio: temperature: add support for tmp117
Date:   Sat, 20 Mar 2021 02:00:05 +0530
Message-Id: <20210319203007.287802-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the dt-bindings and the driver for tmp117 sensor.

Puranjay Mohan (2):
  dt-bindings: iio: temperature: Add DT bindings for TMP117
  iio: temperature: add driver support for ti tmp117

 .../bindings/iio/temperature/ti,tmp117.yaml   |  40 ++++
 drivers/iio/temperature/Kconfig               |  11 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/tmp117.c              | 196 ++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
 create mode 100644 drivers/iio/temperature/tmp117.c

-- 
2.30.1

