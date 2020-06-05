Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA52E1EEF95
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jun 2020 04:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFECo5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Jun 2020 22:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFECo5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Jun 2020 22:44:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E9BC08C5C0;
        Thu,  4 Jun 2020 19:44:55 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so8660107iog.13;
        Thu, 04 Jun 2020 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=759ya9bQ8VIyberTjfnME4EptSzc7CbtQcpdhw2zHK0=;
        b=DtCstYTt0Rbx5Q1hA1Sy30EkWrpJf+2WRxNUcm+X9GKceqCla3X7pW3CacF7EnVjNy
         4urYPJzTEwqSRPCgJQk2VE6ETye3GFNHUKRe9oRtM50fQhnA9upL+N6JVOz+65GPqEnz
         982QrMtVQ+CNLWdj6h7S23Mogg2/Bi+YQ8ReiWSzOEGxUrN+F1/8EYmxlP8S9cxAokuB
         1MbVL031DNw5aq4pvMaP8FCBdnmlj6g7Gri8oyyTxnzXVhqWvBfokxF+socTOsQ/ftAY
         EeUD0sq4xQU16y+fIAUoyYwlOA8wr8ceQulQV4vIlpmc3hv+5WsERhsp+sL2ajGjtMQ3
         2KnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=759ya9bQ8VIyberTjfnME4EptSzc7CbtQcpdhw2zHK0=;
        b=LfWZUP12L3lrU6WQk51ZbvJ86/pnuKE71YnM1Qm7LEuaSwy0iLdNni96AeO0VShVSx
         38HrduQFZy+BklZplLC1ufI5qyCjmtlrdt1ynu4GdOdeqW5tSZ8BUdP/wpbxuesoTWMn
         i22qK+k19BtmydZ32ZEdPn8yfr2/IV2jSVhmL3fHrMevvPymnJM3oGZnn63R+nVL4ix+
         iqUIQnH628oxwozMUoKxkQ8Sfm8LQf9bAvk1Hdn7SHgA+FlwCYERwfx7IhXN9cfG/Ao4
         Ks8h7vDMjHc7wME6BJArrkMg4M2hkbhhRUghl+IvsP04owIsn0cvl2D9DL3mQgog76ZO
         h7Qg==
X-Gm-Message-State: AOAM531/yvTvgPvb4io29nPsVj9rLREnh6k3HhMhFPiITBzh4MTvq+LF
        kMXYz2n3qAmQIDGwLBeo0sY=
X-Google-Smtp-Source: ABdhPJywEoU+XdFGxW15L62B8JzbOte+/emG+kENhRuKZYogZ0liWBlPQP/n/6irwcqm+z4sB7chfQ==
X-Received: by 2002:a5d:8516:: with SMTP id q22mr6610256ion.122.1591325095125;
        Thu, 04 Jun 2020 19:44:55 -0700 (PDT)
Received: from cs-u-kase.dtc.umn.edu (cs-u-kase.cs.umn.edu. [160.94.64.2])
        by smtp.googlemail.com with ESMTPSA id 184sm739928iov.31.2020.06.04.19.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 19:44:54 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, wu000273@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: [PATCH] io: pressure: zpa2326: handle pm_runtime_get_sync failure
Date:   Thu,  4 Jun 2020 21:44:44 -0500
Message-Id: <20200605024445.35672-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/iio/pressure/zpa2326.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index 99dfe33ee402..245f2e2d412b 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -664,8 +664,10 @@ static int zpa2326_resume(const struct iio_dev *indio_dev)
 	int err;
 
 	err = pm_runtime_get_sync(indio_dev->dev.parent);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put(indio_dev->dev.parent);
 		return err;
+	}
 
 	if (err > 0) {
 		/*
-- 
2.17.1

