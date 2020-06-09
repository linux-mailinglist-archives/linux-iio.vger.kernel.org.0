Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD4D1F4748
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jun 2020 21:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgFITl4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Jun 2020 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbgFITlj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jun 2020 15:41:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241AC05BD1E
        for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2020 12:41:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v24so8435497plo.6
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2020 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvq/R8f1NdYzUeF7gsKT5BGvFFRsN2ALrzrwy6TNLA=;
        b=tnrfjyExeRJKwgbXzRWxQsBTe7NqmerlvIPu8NxEx3TBCW88CzJZ3BAuXpLjTiQkc8
         TiA1RqcARlbBAr/jFJ6IftcTJvg98rpwNctYgkltGa9ybH0b5TuC8KWDt/nriB3Eg5Md
         txl1jSAGr31wcRH2RPHvfHPLhoruIHJitp99A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nnvq/R8f1NdYzUeF7gsKT5BGvFFRsN2ALrzrwy6TNLA=;
        b=j6ZzXKbH/Vhv18jEE+4Gr3NT3JQFFGEp5zhF1Oxb+f5og7HAkAUqdVa8uTHupo2WE3
         B9r2PGENagNtSOcWXTm2FMP1dMpn0KlMWyywItIo5UlmPBlvdeHrc30bkMgk4ZWlVpaK
         XgvkSn2PNeOODuHGB0kkgiEiwvTOZqHLgscfkD7RizAGFPxu6Ceqtwp8yNCJtNepe6bY
         0sDinjBe87Tpfj3h96j15h5rudjBFXb73oWzjUh2wKetQZmSqPLYTsiGwfE3B8eb7L8N
         HqbRZZRMRzdmMw2iTjhKjXwVOLTyvmaBuVOdCyY0jZPF9FADg6oEcNLVxFeZIXKfSyez
         KAIw==
X-Gm-Message-State: AOAM533Z4CaBRk7vkIEmKIvcj+GpEAPK6qasLsdOBmN4GeDGV9DBKyuR
        kzqUa6J2VAI33rifEgKPftIalOoRizbJjQ==
X-Google-Smtp-Source: ABdhPJyvvEbHxHgrGWPc4t/FzKzSB+OnW43B7MFhP6omAfhvuJNSKTp5inyAuLw8V9KXLD1Et02a/Q==
X-Received: by 2002:a17:90a:240c:: with SMTP id h12mr6570919pje.42.1591731697908;
        Tue, 09 Jun 2020 12:41:37 -0700 (PDT)
Received: from ubuntu.Home (anon-42-81.vpn.ipredator.se. [46.246.42.81])
        by smtp.gmail.com with ESMTPSA id z85sm10563627pfc.66.2020.06.09.12.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:41:37 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 0/3] iio: chemical: atlas-ezo-sensor: add support for O2 sensor
Date:   Tue,  9 Jun 2020 12:41:14 -0700
Message-Id: <20200609194117.5837-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Alas EZO O2 sensor, rework driver to allow this to be done, and
added IIO_MOD_O2 modifier.

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
2.25.1

