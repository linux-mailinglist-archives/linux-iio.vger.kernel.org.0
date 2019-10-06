Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B2CD220
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfJFNWu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:49 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A44B320867;
        Sun,  6 Oct 2019 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368169;
        bh=du4I8ZEf1/8MRPe0eby4NOeQjZy7ujhUdHMW15Gi6eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cml3DfjKEkjzJQtQwfTr4QyeI9hy+Ft45RFwUCBXgflRgqpTjS1XkGqrtcyWCpJSf
         Gz6l2AW6V5DgtNNlVC46BnVAIm7AwK4V52TEw4nib6kGHQkO7DC1yjK29wI6D3BRD7
         3JP+InAjWrS/+cu+jxsn+iIgNu/B2HVHq3NA4KGg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 12/13] dt-bindings: iio: imu: st_lsm6dsx: document missing wakeup-source property
Date:   Sun,  6 Oct 2019 15:22:06 +0200
Message-Id: <b0521798dfc8a64780349876fe00a2664bc1b926.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
index 6d0c050d89fe..1a07d38c813f 100644
--- a/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
+++ b/Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
@@ -31,6 +31,7 @@ Optional properties:
 - interrupts: interrupt mapping for IRQ. It should be configured with
   flags IRQ_TYPE_LEVEL_HIGH, IRQ_TYPE_EDGE_RISING, IRQ_TYPE_LEVEL_LOW or
   IRQ_TYPE_EDGE_FALLING.
+- wakeup-source: Enables wake up of host system on event.
 
   Refer to interrupt-controller/interrupts.txt for generic interrupt
   client node bindings.
-- 
2.21.0

