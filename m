Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326B7245668
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgHPHPs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHPHPq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 03:15:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0CC061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 00:15:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f7so11873298wrw.1
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9LRhDUgL9DA+gtJB8/fJMyAJyNZi2W2iPoNB12D6zE=;
        b=QCo9p2QX5NJDwrDSe2Uzp94/cyIqQjVfn70S76kgbsASI7lysd46PX/z9IUIfa3C+R
         Fw5nPXYUyHXV46xBw5fsgw0BdKo+kgiBkCjcBSRGaM1UC6cmjo3MSv0rdEN+gnpfRnKe
         XH1/3kBKoWvQlyygkXZLEPK9S36U3UJ0+Vnuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j9LRhDUgL9DA+gtJB8/fJMyAJyNZi2W2iPoNB12D6zE=;
        b=f4Om4iFvPx14moNIQ0ewMiN3A7AeHY7SCr4KGaYSZWTRlEWZIhA6Zh0MBzXqrgQQ5X
         bhqALZibHU8ragFjL2MNbqtnRylrnfiNsl0eMUtjVliITnRwhbfxXUZpxK24n4mXYFd2
         FfSz0qI8rA6IjyXKcuAFtC6qhUjbi2TaUwm93Za2y95gxKFEx3R0wsCXSI2gduLcTPPZ
         sZWIxiiNhwQdRUhiGAAozLY/ZJBS6R41SNPTZXSkhVQHvzlBoeuYdPGRhrSaudoid+Ym
         PQ8QyoXrus1AKhDNFaVaAy5nH2kzIBt6RgahMYzcjdKQqrG2w3Yp8USJ5+39X2KOurt5
         i6qw==
X-Gm-Message-State: AOAM533wROioBH2KQ6qCU+fzvqXiJE0/bTb6box2qs5hPIgxmlqhAl+c
        LMUJxhuS3H5Pd34VTPrBCWvKEKgZbCfGSw==
X-Google-Smtp-Source: ABdhPJygCTUob6d/MFE97BYcvwRFM47w8XhxDfKnR1+gHO50GEYtmn/5fU9Bkm7LGZ58+VyCQFHTdw==
X-Received: by 2002:adf:df84:: with SMTP id z4mr9619806wrl.314.1597562144649;
        Sun, 16 Aug 2020 00:15:44 -0700 (PDT)
Received: from taos.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id d14sm26189487wre.44.2020.08.16.00.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 00:15:44 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 0/2] iio: chemical: atlas-ezo-sensor: add humidity senso
Date:   Sun, 16 Aug 2020 10:15:38 +0300
Message-Id: <20200816071540.31897-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Initial patchset to add support for Atlas EZO humdity sensor

Matt Ranostay (2):
  dt-bindings: iio: chemical: add Atlas EZO Humidity module
    documentation
  iio: chemical: atlas-ezo-sensor: add humidity sensor support

 .../bindings/iio/chemical/atlas,sensor.yaml   |  2 +
 drivers/iio/chemical/atlas-ezo-sensor.c       | 37 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.27.0

