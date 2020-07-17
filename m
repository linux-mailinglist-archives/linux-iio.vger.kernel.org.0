Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33B62240E6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgGQQ4N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgGQQ4M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C27EC0619D5
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o2so18257237wmh.2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0oUjKd59zMZaiGxgNRXSn/6+OSkd6Llst+aM8IBTWc=;
        b=yNPkHK1zRA5ix6G8yWlcUoKNJIibFKAQ4kphl5pebJ5dbhCkkiDDttAbMDpxtPjbOf
         ANaEw0YL+Z4RRuoY6dGRbsFDJMtrLMEWHjNyhtm72oiR0PLfCa3p/a6awZAV4JepQY8G
         t38WX2mNBcRNYhoMkmNrlEcNUeX5W3rLp0fRirHfA7d9RaK9OdLglhBvRRq5oRKv5ntJ
         SUxrPXSBg7BMtMtwuoy6k0UQRoamSfOSNgW229eFCxWEJqh0qnJ0wf8DWlweGjaS8NqT
         z3MKcL49zcmAVUmHLmpdHY98sz+Vm4GuPO3dlQw7xOMzHSuNAomXLDnptzQSM+jKW3tl
         zgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0oUjKd59zMZaiGxgNRXSn/6+OSkd6Llst+aM8IBTWc=;
        b=rB2YxEoKU+1RdtuaxJDxqqjEaK8+KrZEfF1VRnVX54BzwTjQs8PSncDEjeunAHpNPQ
         dxFndk3Y3W6lFH5kgHvA6k6RqRvJrWBz/QiRXTD5jQ6u2XmrapOhgCdOtxc37uA0FX4F
         0i/oO7IbNiQielGomOMGOrcqefgILvWJWBXPL7DgIp1vY23CX88dlBJKCWHBv+03SnK9
         IAS0rV2I4SEUeh9lmk265/XuHNar8mH/XplMfRkXR3lXLmJJiyujkpr+KINMNnGOg8Lp
         zYOe15kwb4epCigfoPDkvBBcUhJ1YyWM/C7OcZpujBiTazqUXaK0b/j4albOEkQn/C5i
         VU8g==
X-Gm-Message-State: AOAM531nj+IQHrj92laAyJvwZo8TsnQy9O+GkNua6cCUkH/U383mZuYc
        bhH7fzYl5GusHeuCdpR6aQemrQ==
X-Google-Smtp-Source: ABdhPJzGx0h8an30IqO75LbxvOE6R1dZce6G1gw/E5yjUFHsKN1Rz4cLrUZ2G69jijBs0tNvFkzJbg==
X-Received: by 2002:a1c:2602:: with SMTP id m2mr10749472wmm.50.1595004970818;
        Fri, 17 Jul 2020 09:56:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 11/30] iio: adc: ad799x: Demote seemingly unintentional kerneldoc header
Date:   Fri, 17 Jul 2020 17:55:19 +0100
Message-Id: <20200717165538.3275050-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is the only use of function related kerneldoc in the sourcefile
and no descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad799x.c:192: warning: Function parameter or member 'irq' not described in 'ad799x_trigger_handler'
 drivers/iio/adc/ad799x.c:192: warning: Function parameter or member 'p' not described in 'ad799x_trigger_handler'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad799x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index ef013af1aec07..007ec7ad94752 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -182,7 +182,7 @@ static int ad799x_update_config(struct ad799x_state *st, u16 config)
 	return 0;
 }
 
-/**
+/*
  * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
-- 
2.25.1

