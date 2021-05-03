Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355323716D4
	for <lists+linux-iio@lfdr.de>; Mon,  3 May 2021 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhECOov (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 May 2021 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhECOov (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 May 2021 10:44:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853BBC061761
        for <linux-iio@vger.kernel.org>; Mon,  3 May 2021 07:43:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a4so8270487ejk.1
        for <linux-iio@vger.kernel.org>; Mon, 03 May 2021 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+sSoI8mYAtclTc9ch+HKJwJxzZIGx+EMq0xg4jwGJY=;
        b=lcMg1GRQK96CSLu9muYJ/38tJfNVTje46sVXV9uLDLW+WcllEPA0D1aj/1UEnTPqgt
         KGRWoSR4BisAYbjYErXdN2bIuPbIia5aCZd8hjcURs32Nj/WqjA4bu/oZo4PY0n+trn/
         yusgEeJqq3BKieXfp/qHxFoA1MmTiRRo3dij9wudixzpfghDJHhiI7gEkR2aYn4gspLC
         Ho0+eKxdqoUXlpMRQbGR6e8jMUyOsecJWsgeHYLGGaDggzDCiEjT2z4atmpfdJilboJP
         MA9DHMtRfyOnf96sskvuMcdkeBE9LX+YavPYfBVTWQRIs/HpFOH0dj3S06wvS0FMY6Fz
         2yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+sSoI8mYAtclTc9ch+HKJwJxzZIGx+EMq0xg4jwGJY=;
        b=NXiAdMXcxZt1en5L/1E4TeHt3zPwQ8iN/245DkSKMw1kmQeWeod4K3TofWj1EpgtqA
         yIRDvujEhAVE+3X9JkUGL93VXxukptCz9l+VukJPM5ueYKXf0NnedcRTu8lhdYqPPm3O
         IUsfI+wASw0m3TpzjL0J0XnM3K9Jkv3tNGTJw29NYACVYqk98wQQeczw6HJNhnVXzJi6
         eppaDdpKizMB1OU+AOzm6c0u/ENdx59QCYG7qZOka1RAtQ/+tFrA0brXsHn1FhSZyqqZ
         /dex+jFE4QhrMdNCAmORwEM8WzUlcxCkWpkfv+3NpuAVM45a6F7TNA3a2ncFcUWbhYiK
         136g==
X-Gm-Message-State: AOAM533boqPCn8ZyPzfeDB4pSyNX6EmiX+XEzmIlaYdJ9cbjxliH9yN9
        1W9Xj25fcl03vn7UB2qUGNkVrQwO6GaVmA==
X-Google-Smtp-Source: ABdhPJzz8YSG1ci1mdLP9jB4YLfscuJhMz3kr/0Wr1oKGOdWmN24W8jyr6/Hcqis9MIkLZIU6GdSDw==
X-Received: by 2002:a17:906:a10e:: with SMTP id t14mr16892149ejy.103.1620053035841;
        Mon, 03 May 2021 07:43:55 -0700 (PDT)
Received: from neptune.. ([188.27.131.122])
        by smtp.gmail.com with ESMTPSA id e19sm2005867edv.10.2021.05.03.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:43:55 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, lars@metafoo.de,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH] iio: core: return ENODEV if ioctl is unknown
Date:   Mon,  3 May 2021 17:43:50 +0300
Message-Id: <20210503144350.7496-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the ioctl() mechanism was introduced in IIO core to centralize the
registration of all ioctls in one place via commit 8dedcc3eee3ac ("iio:
core: centralize ioctl() calls to the main chardev"), the return code was
changed from ENODEV to EINVAL, when the ioctl code isn't known.

This was done by accident.

This change reverts back to the old behavior, where if the ioctl() code
isn't known, ENODEV is returned (vs EINVAL).

This was brought into perspective by this patch:
  https://lore.kernel.org/linux-iio/20210428150815.136150-1-paul@crapouillou.net/

Fixes: 8dedcc3eee3ac ("iio: core: centralize ioctl() calls to the main chardev")
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/industrialio-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index efb4cf91c9e4..9a3a83211a90 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1803,7 +1803,6 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (!indio_dev->info)
 		goto out_unlock;
 
-	ret = -EINVAL;
 	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
 		ret = h->ioctl(indio_dev, filp, cmd, arg);
 		if (ret != IIO_IOCTL_UNHANDLED)
@@ -1811,7 +1810,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 
 	if (ret == IIO_IOCTL_UNHANDLED)
-		ret = -EINVAL;
+		ret = -ENODEV;
 
 out_unlock:
 	mutex_unlock(&iio_dev_opaque->info_exist_lock);
-- 
2.31.1

