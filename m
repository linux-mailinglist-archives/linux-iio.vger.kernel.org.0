Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA12225815
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jul 2020 09:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgGTHDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jul 2020 03:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgGTHDl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jul 2020 03:03:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95895C0619D2
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ls15so9737395pjb.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2020 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZoWTQVkgnpP7gasu4wtrIk5xapwZJTLKPseEPRLNvs=;
        b=UtVnqD31pt/ZtgJEhdMU6TGM4RSQPtcTkNCIgJ0FRMnMEptf9BGl01UtQPC/f7+56u
         OJhgXfdlS8cIhd5GCdERbkXjEKroPcovVVpK1TGA7Ri3gXPtdjgbFN4zYa1I1v8snJaN
         Zf8a0l60GyePC8irM7dQPnCUoBTCEhH7ltNzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GZoWTQVkgnpP7gasu4wtrIk5xapwZJTLKPseEPRLNvs=;
        b=OFgzZ6QEa+auoEvWUROkoZqGqdyg/X3jeCGi+gz1XR6Qo4jK4lS8XUDGFBuWQ1xkQS
         9YrGUFwvAdD0A0U855ztf9qLas1/K7vRR/bPSkXlROAbrIsVZaYd3bjQ+85c2LpGg3gc
         DWC5i5DsaXD1flk6/QxxSVRXwILDgRW/MVDXpSDOVVWaPeLYzec2U4QlYU2dLYs6T16p
         H5DP+ih4ncF0DLGtrvas7wTw2+qhRB3Va8d68CzyAzfp5PyO9QVs1xwL8/H9oaj5Wp1r
         Uv3rZdh9MmYNGPKmriy2JUWWQ7RHRxYS20HEcQKNo81RMrYmbfsgTMgajlvyzMtPpELD
         YV5w==
X-Gm-Message-State: AOAM532L9PJu+rhb/aiAGcEXF01M6fwwi6/s4Y09HW2vo+wYlfIoCNzw
        CsIsGAqlYkp1ngZHLqjc2YsnWjcLgTSuzA==
X-Google-Smtp-Source: ABdhPJx2PnQtfSni5fegrOgXEH580CDhShARD2qvbyUkFr/wt5qImirWuBuQUgIBbyNW2LinJIdgcA==
X-Received: by 2002:a17:902:be17:: with SMTP id r23mr16793228pls.284.1595228620871;
        Mon, 20 Jul 2020 00:03:40 -0700 (PDT)
Received: from ubuntu.Home (anon-62-111.vpn.ipredator.se. [46.246.62.111])
        by smtp.gmail.com with ESMTPSA id gn5sm10613862pjb.23.2020.07.20.00.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 00:03:40 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 0/3] iio: chemical: atlas-ezo-sensor: add support for O2 sensor
Date:   Mon, 20 Jul 2020 00:03:27 -0700
Message-Id: <20200720070330.259954-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Alas EZO O2 sensor, rework driver to allow this to be done, and
added IIO_MOD_O2 modifier.

Changes from v1:
* rebased on modifier changes for IIO_MOD_H2/ETHANOL string identifiers

Matt Ranostay (3):
  iio: add IIO_MOD_O2 modifier
  dt-bindings: iio: chemical: add O2 EZO module documentation
  iio: chemical: atlas-ezo-sensor: add support for O2 sensor

 Documentation/ABI/testing/sysfs-bus-iio       |  2 +
 .../bindings/iio/chemical/atlas,sensor.yaml   |  2 +
 drivers/iio/chemical/atlas-ezo-sensor.c       | 74 ++++++++++++++-----
 drivers/iio/industrialio-core.c               |  1 +
 include/uapi/linux/iio/types.h                |  1 +
 tools/iio/iio_event_monitor.c                 |  2 +
 6 files changed, 63 insertions(+), 19 deletions(-)

-- 
2.27.0

