Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94BA39DF23
	for <lists+linux-iio@lfdr.de>; Mon,  7 Jun 2021 16:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGOuZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Jun 2021 10:50:25 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:37642 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGOuY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Jun 2021 10:50:24 -0400
Received: by mail-qk1-f169.google.com with SMTP id i67so16874498qkc.4;
        Mon, 07 Jun 2021 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7v4978NXelKHLOHpzJWizqDsRLeauX49Rk0ajigt3jA=;
        b=IE3q5YlkLWYhXTA8e0CC0CU20K1q7T1Hbaa39xGmN8/PWletS8rQ2RvN2CRmwiJsbU
         OmTgoTt4jSSZ1qCyhtdEUbOe3DS1Q2GjBoCTzlaXLnumQBaX4VjC2BKDbHo0Wqt1jSDH
         27ofcM3l/qtROtSE2ltTvhV5T860BMAfSaiIzkOaHuwiogrTeREF5mPWGxRRoJR3JQr/
         rTuKpEKpTPDNxN4rloIH9zXMwzSxevF2tpLzV58yhD5mQ7gL8O0QN8d9GJpI7qhnjOj+
         bS60ZzuxSWL5a0HIL6KnoC00+QY3mVUMWqV5ynQBBEmZIKatTelzQqjkviwtfrEu1owL
         gyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7v4978NXelKHLOHpzJWizqDsRLeauX49Rk0ajigt3jA=;
        b=I+6lbaVKv177RcmRQU95Z5P26yslcCEm2N1F++XswmERQDBu6jKfiCGYn9euHoeH2s
         ZHY1AJq0Pou6isWYDM08WAsHdNy/2oYAf1IvptA+xjsxI7eHOKydRT/Oe7DcAW6KKVVj
         +2a+NLH1vWdyaCEQUvP1kByrkwxuovQ3iDrPX7Sq5ffC82QbFDxEPkZE6oYV/oifX8t5
         BZ1nfZhpzuVDCnlAl5/TEaEaRks6jlPlwCVJvTyCfGo68AERaZnnLMlfBlIoIO3tCunc
         WT5ROeQjmHpkbM2xrBInVuokk0pb48jzj2SWjQ/ACOsEm6c4jK9e307uL+cPGAJeA7ln
         TnvA==
X-Gm-Message-State: AOAM531tFzWdvu5wRV7kAyilj13GOdmcP2g1oKbT6Z4dvvsqHpmoBvI1
        /2eoD1PTF+5LQoW76rAxwTE=
X-Google-Smtp-Source: ABdhPJzTQnBmv/Ms1KwliA16vvt9C9QeNZsgjkHO9Anrt/LkoRApNZDYaGBTXA8AX9WZc2kp0TXDeQ==
X-Received: by 2002:ae9:f507:: with SMTP id o7mr16734638qkg.384.1623077253142;
        Mon, 07 Jun 2021 07:47:33 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id s7sm4157855qkp.35.2021.06.07.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:47:32 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 5/8] iio: afe: rescale: add upstream offset support
Date:   Mon,  7 Jun 2021 10:47:15 -0400
Message-Id: <20210607144718.1724413-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210607144718.1724413-1-liambeguin@gmail.com>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Default to using iio_read_channel_processed() if the upstream channel
exposes an offset.

When possible, it's preferable to avoid using
iio_read_channel_processed() to maintain as much precision as possible.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..e34148d39b39 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -148,7 +148,10 @@ static int rescale_configure_channel(struct device *dev,
 	chan->ext_info = rescale->ext_info;
 	chan->type = rescale->cfg->type;
 
-	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
+	if (iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET)) {
+		dev_info(dev, "found upstream offset, using processed value\n");
+		rescale->chan_processed = true;
+	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) ||
 	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
 		dev_info(dev, "using raw+scale source channel\n");
 	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
-- 
2.30.1.489.g328c10930387

