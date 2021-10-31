Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42520440D7C
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 09:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhJaIHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 04:07:22 -0400
Received: from www381.your-server.de ([78.46.137.84]:36272 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJaIHV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Oct 2021 04:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=NU48q+2AolWlwTa3aibdFC+eFYx/S6pcGRTc8QfCmV8=; b=mWGdSK7etoZXIXpsSEOtmHhMb5
        qwGvBxFEk4XVYvog9ILulO6b3w4VYgj4oG2vUmKyy4xFz0QGomQuETln+mG5EHgSxByQ2HLbzVw3+
        WIoxZufCBNafhJhN7Z0n9C+ndDE7ReJQmoxIcWj62fqtkUqOeddJo+5VvzwtAw9/JIxNIGFpWoaYY
        0VyU9kc6SV86PPi7S1j+BfdY/XMyPmrQ7AAY8q8SoQ6lRES0zCDq/SpHMb6fCAMcuNz3+ixJwDgQR
        fI263sF9u2fPHj6NiA8EKYfOg7we0sgw8kZTruRSByCmzRx9otkcCURlhbCNTb465agyLFXUe7IjT
        bB/kD/1A==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mh5ph-0003dU-TH; Sun, 31 Oct 2021 09:04:49 +0100
Received: from [82.135.83.71] (helo=lars-desktop.fritz.box)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mh5ph-000NK2-PW; Sun, 31 Oct 2021 09:04:49 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio: Mark iio_device_type as const
Date:   Sun, 31 Oct 2021 09:04:21 +0100
Message-Id: <20211031080421.2086-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26338/Sat Oct 30 10:21:41 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_device_type struct is never modified, mark it as const. This allows
it to be placed in a read-only memory section, which will protect against
accidental or deliberate modification.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/iio_core.h          | 2 +-
 drivers/iio/industrialio-core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
index 61e318431de9..501e286702ef 100644
--- a/drivers/iio/iio_core.h
+++ b/drivers/iio/iio_core.h
@@ -16,7 +16,7 @@ struct iio_buffer;
 struct iio_chan_spec;
 struct iio_dev;
 
-extern struct device_type iio_device_type;
+extern const struct device_type iio_device_type;
 
 struct iio_dev_buffer_pair {
 	struct iio_dev		*indio_dev;
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 463a63d5bf56..737518efa38f 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1619,7 +1619,7 @@ static void iio_dev_release(struct device *device)
 	kfree(iio_dev_opaque);
 }
 
-struct device_type iio_device_type = {
+const struct device_type iio_device_type = {
 	.name = "iio_device",
 	.release = iio_dev_release,
 };
-- 
2.20.1

