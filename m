Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070041E30D8
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 23:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbgEZVCt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 17:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389124AbgEZVCr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 17:02:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E345C061A0F;
        Tue, 26 May 2020 14:02:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x22so13172974lfd.4;
        Tue, 26 May 2020 14:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GEbzgI+bztUbMO5Sm0NmMZg/3FD1KT72eplUCOCNgI=;
        b=o6pf/C+eDKKeKyR5Hu7iEdzMJa+zJM/GmLlz7R/4UWkjQ6puv+fWQmAhoV8NxD+E80
         VfmtvosT+TiWUYYhrkm+NyC2OgvaqHXVpftBFVnkaexqg6XKzp0ryrEHfY/Cu97bUIyl
         +EcHnb2vTO+zjoEf6lx5iTfO/xFoCRAj3m1EcNRnD2DT0EQyTKTU0abnjpZWS/3Yzsmc
         KTEAiWQ161F0KBE/04PPQ6Z8HdHdVwEWRqcjPkUCV9hjsh5rilzyvwwkLpSsecL3y1G2
         wbvakXDL008LgfU86HieSHRCulVqLuLMd8fYolAnkhezxtZLkKW4hyooGX+UPTCznXBT
         sQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GEbzgI+bztUbMO5Sm0NmMZg/3FD1KT72eplUCOCNgI=;
        b=NYOXjpbW+rvWfcewrEaOpkrsQjt7Q/6/jS+Ujvrdp47l0mSuVHbksAMV2jjOvd425w
         jzHLW5PR9KRF8DIb+ZjMK5FEYmf5ZmWCfyrOsxo+1GPfqSlpq5TCFOABs4hUd69uVfb6
         Xap/XvajxcI+g7euM7N4ZJSkLSbskerWYlvprc0ZJUwNzK5uT26wNr7W2IANvGelODVY
         xTjdLCzDKRQn/A15pV8d6wSu4xmfgPC+ecVCwbF0U/tOPRqM/7PJHVJk3VfwcL/Wa9iO
         EeIIOfN2Md2iFM9Sy+57iB2Y9dovrH6I+Sfh2MAH8fe8zVJPU1Nr45KwtlzaSUWwTMfl
         A/Fw==
X-Gm-Message-State: AOAM530fIxItY2vTHRXx0Az2dQxANzqHTA6Enhis/htkP+uSEh0l5oCq
        LVPgvfAqoB3/bkooLQmtr94=
X-Google-Smtp-Source: ABdhPJzyKtT85+/yHaFXfp7D5et++o5RZQ+pqHHb1QFxcI7thOIhmBLCC1FpkN96W1fiha4eqoLFMg==
X-Received: by 2002:ac2:5cac:: with SMTP id e12mr1401821lfq.92.1590526965952;
        Tue, 26 May 2020 14:02:45 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id z133sm240443lfa.41.2020.05.26.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:02:44 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-pm@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 0/6] drivers/iio: Constify structs
Date:   Tue, 26 May 2020 23:02:17 +0200
Message-Id: <20200526210223.1672-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Constify a number of static structs to allow the compiler to put them in
read-only memory. The patches are independent.

Rikard Falkeborn (6):
  iio: adc: max11100: Constify struct iio_chan_spec
  iio: dac: ad5380: Constify struct iio_chan_spec_ext_info
  iio: dac: ad5592r-base: Constify struct iio_chan_spec_ext_info
  iio: dac: ad5686: Constify static struct iio_chan_spec
  iio: light: stk3310: Constify regmap_config
  iio: magnetometer: mmc35240: Constify struct reg_default

 drivers/iio/adc/max11100.c          | 2 +-
 drivers/iio/dac/ad5380.c            | 2 +-
 drivers/iio/dac/ad5592r-base.c      | 2 +-
 drivers/iio/dac/ad5686.c            | 8 ++++----
 drivers/iio/dac/ad5686.h            | 2 +-
 drivers/iio/light/stk3310.c         | 2 +-
 drivers/iio/magnetometer/mmc35240.c | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.26.2

