Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8EB1BA087
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 11:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0J4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726485AbgD0J4K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 05:56:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78748C0610D5;
        Mon, 27 Apr 2020 02:56:10 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r26so19729121wmh.0;
        Mon, 27 Apr 2020 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KabU8RQbYo6zO4Da1RE3r+c7iw+LtTTgVh+CWeRPFdU=;
        b=D11QhMqdOeqN74psXrXyt0k3ad4XP+C8qKz3dj0O/uV/jAk3cyGJIWLyL2TSFWrcnZ
         XrQyAn2YfjVjCtYZ3x3Y7fgpRSUqrri9uK+tF4C+sltasDw4hyaCGcO8MzFOYLiP7B/7
         HqWKneHBzfXPvNoY3aqxhhZxlPJzRO/ZBS1Wi/HKLqekqVLGy9zt6DyOwlguk5Ijt3iw
         +2nN9Xniyqqpy3U6L9VdCnxSD2m88/FPpRqr9ECzNr4cYt7ZvLRu6FVkRqFGIrwtZCI4
         5eu7DdYVMyHixPDFxT6l8GEmsrfWWita3zLzjukFYQsAAzT/75cQ/RCIjy3fpQcHSJaQ
         H6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KabU8RQbYo6zO4Da1RE3r+c7iw+LtTTgVh+CWeRPFdU=;
        b=HjkfBIca0SmWPW4pvw+5F0u/za3kD9i3FOxg0xRlmYXWuKj9RpIJw/4dl4188ldGOr
         HVCMW2v3TgVRjl+kJjhfdBUn8Emdy10X3uPgvjCcmQB1oVL/TAoJb+LIFh21+LmoiDP5
         9l1jabAYGcUI8VUtFXygnE8thQ+oCx95nTB/Q3fJi0yi0vGKesHwhuUaguCyIXk9CGPp
         3qjgQfCf5cSvOd/6OEn72SaT75HarBL6NwZOYhlZ1d00z796nOw5U9OvDT2/wHJh4CzL
         QFXrMtCnEBzH+FA+jFYNXI1v31x+dTnipck9mfB1RmI5qFy4qwjY2iUzXgSCg6QKkr5o
         nrDA==
X-Gm-Message-State: AGi0PuY0bNCiBwwazTP+jWvt11AkLjsSjdG9KFy3MlAK6DKM2HNv3agC
        hdsaJqKyDt+d6BiF4MJjNQI=
X-Google-Smtp-Source: APiQypJ+YuAx21MDQYPsEab2m2G7VUSEmanfhivWgDrGsuNCE9EJ7V6qfEBKjHIiVueU9TGH2XLomg==
X-Received: by 2002:a1c:384:: with SMTP id 126mr25520516wmd.58.1587981369106;
        Mon, 27 Apr 2020 02:56:09 -0700 (PDT)
Received: from meru.fronius.com ([2a01:cb18:832e:5f00:7069:9b5d:ebe2:85b8])
        by smtp.gmail.com with ESMTPSA id y10sm14487606wma.5.2020.04.27.02.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 02:56:08 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v6 1/5] iio: vcnl4000: Fix i2c swapped word reading.
Date:   Mon, 27 Apr 2020 11:55:55 +0200
Message-Id: <20200427095559.16131-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200427095559.16131-1-m.othacehe@gmail.com>
References: <20200427095559.16131-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The bytes returned by the i2c reading need to be swapped
unconditionally. Otherwise, on be16 platforms, an incorrect value will be
returned.
---
 drivers/iio/light/vcnl4000.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 58e97462e803..e5f86bd00fb0 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -219,7 +219,6 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
 	int tries = 20;
-	__be16 buf;
 	int ret;
 
 	mutex_lock(&data->vcnl4000_lock);
@@ -246,13 +245,12 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_i2c_block_data(data->client,
-		data_reg, sizeof(buf), (u8 *) &buf);
+	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
 	if (ret < 0)
 		goto fail;
 
 	mutex_unlock(&data->vcnl4000_lock);
-	*val = be16_to_cpu(buf);
+	*val = ret;
 
 	return 0;
 
-- 
2.26.0

