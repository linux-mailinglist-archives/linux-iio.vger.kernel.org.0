Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE66F2524BC
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHZA3v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Aug 2020 20:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHZA3u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Aug 2020 20:29:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE11C061574
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2020 17:29:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 31so142820pgy.13
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2020 17:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXnMV3ki6cVZAInoE78tW6W//ERUFQlwfAUCR3nx8A8=;
        b=ExP+3E1d497LweIIPfFKXTjSxdDOLZxW+0zqHhkivSUG1MvDP9d64YTsDLoPYbnB8L
         tCzohP7KhWu+EC/F9UxeRnmedKop6+fUBboJx7FgNR9d7WVvpeWKDpH9sWC5v3LE6Jkk
         KIC/zehRrKUVz51D/yvslb90poEfcGOa2ie7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wXnMV3ki6cVZAInoE78tW6W//ERUFQlwfAUCR3nx8A8=;
        b=IUaKEsW567+AktC+AwHvTPK8Pzwx/Qf0a/N7jIDXMaySeIAcgfQmD5vxcCtomqCZ9j
         fBej/A6FR5Kx1/QmBxP58kfi+vIT7CzoduzARjLJwAkTSfQ0AyejXiumo3sZ95En60XU
         RRhi53/B2kIBNNBNpSEhbtorSSSu50mg/dUYLREP4OH8nd81Zh88bRyUeBDtu2skBlRi
         zbCWgCiw2vfKghtmGGAXfISFkHKdZacSY9qnKszkkX98qAytsbhzPmLTyYugKGHtdjse
         JjxQiDVgymq87L9+bIDOJK8rekRoFOoUkZPnQPRKF5LllCD3mZfEmeLm+3pGAsSv+nRX
         Iodg==
X-Gm-Message-State: AOAM530eEjopxqrchf1jHHc/gYUeOsaGpskTiypRnPkNKjyjV1Hp+O7z
        KjaWfi3MFkECte6+P4wNOsxpqA==
X-Google-Smtp-Source: ABdhPJw+YpNt6ZqSm2rjHFllhju1yV5uAj2tEZyUdUc9BWECswavGH/26M9k4XTjc59pKLGUwbul0A==
X-Received: by 2002:aa7:84d3:: with SMTP id x19mr9813307pfn.49.1598401790117;
        Tue, 25 Aug 2020 17:29:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id w3sm456938pff.56.2020.08.25.17.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 17:29:48 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] platform: cros_ec: Reduce ligthbar get version command
Date:   Tue, 25 Aug 2020 17:29:45 -0700
Message-Id: <20200826002945.394562-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By default, the lightbar commands are set to the
biggest lightbar command and response. That length is greater than 128
bytes and may not work on all machines.
But all EC are probed for lightbar by sending a get version request.
Set that request size precisely.

Before the command would be:
cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
Afer:
cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1:
- Remove BUG and TEST fields.

 drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index b59180bff5a3e..ef61298c30bdd 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
 
 	param = (struct ec_params_lightbar *)msg->data;
 	param->cmd = LIGHTBAR_CMD_VERSION;
+	msg->outsize = sizeof(param->cmd);
+	msg->result = sizeof(resp->version);
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
 		ret = 0;
-- 
2.28.0.297.g1956fa8f8d-goog

