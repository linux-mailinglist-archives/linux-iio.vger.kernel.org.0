Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6137A4EE309
	for <lists+linux-iio@lfdr.de>; Thu, 31 Mar 2022 23:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbiCaVGS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Mar 2022 17:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbiCaVGS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Mar 2022 17:06:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A69480216
        for <linux-iio@vger.kernel.org>; Thu, 31 Mar 2022 14:04:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id i11so727345plr.1
        for <linux-iio@vger.kernel.org>; Thu, 31 Mar 2022 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXtJh38aI7rFhwSkhNj8FWqiXd2HNKnAb8Z05DuJmvg=;
        b=VU+HkxENuiBH0omyCyOgv/F8rvOeDdoiIUYe707WQABTk/xZLcJcetc8hqCQqdZqBf
         dX5MUqN0Z8PmbJEgBLdPTk9Pidg03XZTQdyPGtKLA7epdfp1mS9JhwXc+gB3uyf7n7WJ
         mBQfXZzPOJ05Rp9t13bvxEJYECXHCQit9mJJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXtJh38aI7rFhwSkhNj8FWqiXd2HNKnAb8Z05DuJmvg=;
        b=L0gRbKKkxIZtGg4TjVvaOGwxYUEHTK/t5EfIyyJo2lV5BWUhLV9/GEjt+dnxcAuF9Y
         RtdVdDJc3hrOcJGdgmV5s4/+vc/0eUqxC93HeusomDeF/0a/tF1K74e2mPZTxHyOWEcB
         xki7Kb6qckE4O74PjV+I4nTahxLDLAjiLI5m9N/wvAndH4Z0OEDfR5l0Ffj9tceNisgI
         q6ZT2TbecnIg+pvwQq6pZZkVfa4cFDAGuDQ+/98PIPqtTRmcPlNXHOnn0B5Ly209c4hP
         BRHfRD0ghw6RIw3BJ2Sw5vlUViA0yL71lu4cDU2/FHd0sKP+9lic7GQxxM7KoIMf7sZ8
         MTEQ==
X-Gm-Message-State: AOAM533HlnvVspwwVVF1cJ+Rx4d3dyY6j2zn4fx8pwPTf4uB1j1KT4WH
        h5m5HmQUUnmq99CucGhVk733eJZd6NajpA==
X-Google-Smtp-Source: ABdhPJzGO+ht/Ae+Vv6wSxnABo8FauouW9END+e7QuZYMsr9TxK82jlGU047uC4bDOa7QhQPMGLMBQ==
X-Received: by 2002:a17:90b:314b:b0:1c7:4a4f:6740 with SMTP id ip11-20020a17090b314b00b001c74a4f6740mr8137766pjb.145.1648760667609;
        Thu, 31 Mar 2022 14:04:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:f6f:d194:b010:bb5f])
        by smtp.gmail.com with ESMTPSA id d10-20020a056a0024ca00b004fd90388a86sm381426pfv.173.2022.03.31.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 14:04:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] iio:proximity:sx_common: Fix device property parsing on DT systems
Date:   Thu, 31 Mar 2022 14:04:25 -0700
Message-Id: <20220331210425.3908278-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After commit 7a3605bef878 ("iio: sx9310: Support ACPI property") we
started using the 'indio_dev->dev' to extract device properties for
various register settings in sx9310_get_default_reg(). This broke DT
based systems because dev_fwnode() used in the device_property*() APIs
can't find an 'of_node'. That's because the 'indio_dev->dev.of_node'
pointer isn't set until iio_device_register() is called. Set the pointer
earlier, next to where the ACPI companion is set, so that the device
property APIs work on DT systems.

Cc: Gwendal Grignou <gwendal@chromium.org>
Fixes: 7a3605bef878 ("iio: sx9310: Support ACPI property")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
index a7c07316a0a9..8ad814d96b7e 100644
--- a/drivers/iio/proximity/sx_common.c
+++ b/drivers/iio/proximity/sx_common.c
@@ -521,6 +521,7 @@ int sx_common_probe(struct i2c_client *client,
 		return dev_err_probe(dev, ret, "error reading WHOAMI\n");
 
 	ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(dev));
+	indio_dev->dev.of_node = client->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	indio_dev->channels =  data->chip_info->iio_channels;
-- 
https://chromeos.dev

