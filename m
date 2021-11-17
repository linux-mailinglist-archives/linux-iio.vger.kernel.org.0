Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2322E4542DC
	for <lists+linux-iio@lfdr.de>; Wed, 17 Nov 2021 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhKQItd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Nov 2021 03:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbhKQItd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Nov 2021 03:49:33 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31526C061570
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 00:46:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id o4so1972103pfp.13
        for <linux-iio@vger.kernel.org>; Wed, 17 Nov 2021 00:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s9PG5DSCz74qfh+pmwnVeSJ9WFAoH17DnygCPk7hgsY=;
        b=giRqTpeIbTf0ZnIEQto7FUbhIxrhkFtc71FD9A31U84Qo4gfrm477XQ02Ri4/3Fuqn
         270wp254m9O+yUUtjPPPW0C6pOb+708+hw4u1mDXFpa3v9jqWRVqA2x/jONlZMg+A9LX
         YJdC+dqgTJyRojIt5LOzHFll0D3hb6xhGol7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s9PG5DSCz74qfh+pmwnVeSJ9WFAoH17DnygCPk7hgsY=;
        b=L5AIK5j17M0wJedwV7tzHjhIH7hQcGZzQoKnyRQBcBVsl201tb93aUXR87c8woBIE0
         43auu5g5WXZ2/nD+wFmLHkoFRF+hwzUGmEgbixm+DfqMPZJCNGmXzMHSfdDZDYz7iL9x
         QCLGoovWdQUUIMawcDOyl4pRjDZsMao99X/fPs2NZ+K9plCf3y4PPfBJ3apwIPhTNNCd
         qBVIYYHn8WYBenY57Ca6i/UR4SQ10UVucBdSTvQlaGcbKejJzqBTPyBiIn4FdVv8I/iF
         8vCLQQtHsHzMOsq6FMiSuZNKbvs8zD5jE/TO6CyDsepCX8SHKn3D5vByAXXnjoyrXdjK
         dL7w==
X-Gm-Message-State: AOAM530B9dlN9l+O8TazoKN9KBlia6XG9pVpM03LBuxp6WWoAeb5J+1g
        3LOp6cMN+FrLgrd8djBbN7olfA==
X-Google-Smtp-Source: ABdhPJzwLslhBz+jslDZcbu4THQETMq8g+FoQeITEEjmHlE6S+K6AF0IO0TN2mrhN/BORVarZsDUiQ==
X-Received: by 2002:a62:b418:0:b0:4a0:3696:dec0 with SMTP id h24-20020a62b418000000b004a03696dec0mr46216648pfn.73.1637138794695;
        Wed, 17 Nov 2021 00:46:34 -0800 (PST)
Received: from localhost ([2620:15c:202:201:327f:7baa:380e:33a3])
        by smtp.gmail.com with UTF8SMTPSA id j1sm5684830pfu.47.2021.11.17.00.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 00:46:34 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 0/5] Expand Semtech SAR Sensors support
Date:   Wed, 17 Nov 2021 00:46:26 -0800
Message-Id: <20211117084631.2820014-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a new Semtech SAR sensor SX9324.
Instead of recopying 1/3 of the sx9310 driver, move common code in a new
file. It will be used again for the next sensor, SX9360.

Major changes in v3:
  Fix some error in binding descriptions and setting
  Fix invalid register constant name.

Major changes in v2:
  Better interface between common code and drivers
  Document SX9324 phase configuration

Gwendal Grignou (5):
  iio: sx9310: Add frequency in read_avail
  iio: sx9310: Extract common Semtech sensor logic
  iio: proximity: Add SX9324 support
  dt-bindings: iio: Add sx9324 binding
  iio: sx9324: Add dt_bidding support

 .../ABI/testing/sysfs-bus-iio-sx9324          |   28 +
 .../iio/proximity/semtech,sx9324.yaml         |  136 ++
 drivers/iio/proximity/Kconfig                 |   18 +
 drivers/iio/proximity/Makefile                |    2 +
 drivers/iio/proximity/sx9310.c                |  706 ++---------
 drivers/iio/proximity/sx9324.c                | 1094 +++++++++++++++++
 drivers/iio/proximity/sx_common.c             |  575 +++++++++
 drivers/iio/proximity/sx_common.h             |  158 +++
 8 files changed, 2114 insertions(+), 603 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sx9324
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9324.yaml
 create mode 100644 drivers/iio/proximity/sx9324.c
 create mode 100644 drivers/iio/proximity/sx_common.c
 create mode 100644 drivers/iio/proximity/sx_common.h

-- 
2.34.0.rc1.387.gb447b232ab-goog

