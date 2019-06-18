Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C9149C9E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfFRJHS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 05:07:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60006 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFRJHR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jun 2019 05:07:17 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B0ABF260A33;
        Tue, 18 Jun 2019 10:07:15 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] iio: common: cros_ec_sensors: clean code
Date:   Tue, 18 Jun 2019 11:06:35 +0200
Message-Id: <be333202df5b4d04b7fab63fe4076b6766d3ac58.1560848479.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1560848479.git.fabien.lahoudere@collabora.com>
References: <cover.1560848479.git.fabien.lahoudere@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop redundant initialization previously set in cros_ec_sensors_init

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
---
 drivers/iio/light/cros_ec_light_prox.c | 2 --
 drivers/iio/pressure/cros_ec_baro.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
index 682dc19c2bf3..73f5dcbda0d5 100644
--- a/drivers/iio/light/cros_ec_light_prox.c
+++ b/drivers/iio/light/cros_ec_light_prox.c
@@ -179,8 +179,6 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
 
 	indio_dev = platform_get_drvdata(pdev);
 	state = iio_priv(indio_dev);
-	state->core.type = state->core.resp->info.type;
-	state->core.loc = state->core.resp->info.location;
 	state->core.info.read_raw = &cros_ec_light_prox_read;
 	state->core.info.write_raw = &cros_ec_light_prox_write;
 
diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
index 9d3745bc2fba..f8107a8b8e72 100644
--- a/drivers/iio/pressure/cros_ec_baro.c
+++ b/drivers/iio/pressure/cros_ec_baro.c
@@ -125,8 +125,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
 
 	indio_dev = platform_get_drvdata(pdev);
 	state = iio_priv(indio_dev);
-	state->core.type = state->core.resp->info.type;
-	state->core.loc = state->core.resp->info.location;
 	state->core.info.read_raw = &cros_ec_baro_read;
 	state->core.info.write_raw = &cros_ec_baro_write;
 
-- 
2.20.1

