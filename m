Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4128D425491
	for <lists+linux-iio@lfdr.de>; Thu,  7 Oct 2021 15:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhJGNsn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Oct 2021 09:48:43 -0400
Received: from smtp1.axis.com ([195.60.68.17]:31237 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241701AbhJGNsm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 7 Oct 2021 09:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1633614408;
  x=1665150408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gTDrTYSFEw/2HMWL3752iCCL6WEOplAt72C4UJ1O8Po=;
  b=Dxc7TiSShE8eFYNR4gnYAogg/Nys0zg5IwUlavOhfGtT0T3qHt86i2de
   /dyvKuGjCzUDKq67WMm781HWusG2dzMdPF6UV9Fc+1srYhdndtNP6XSDh
   Oo3CPirjL8+F8MMZob4DhGSWD9oJqextRgqtyqYz7Z+wL/MQbthyNInnB
   igt7a4pkFyLyVATbrr2KFRogQCAYmiI5bZI4BKyuJ883n4ZItsg908sXV
   HUvkmUNh4r0m4NrsRLHAXrqtxFGii9wWLAAr73akfwxBZuvado4BtVvex
   DbjJ8lqJhyA6Es58pdwqkCHw3zEHFIzBM7TSm5O9CqTTMfZ68dhjY9z7e
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <peda@axentia.se>, <jic23@kernel.org>, <devicetree@vger.kernel.org>
CC:     <kernel@axis.com>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: io-channel-mux: Add property for settle time
Date:   Thu, 7 Oct 2021 15:46:40 +0200
Message-ID: <20211007134641.13417-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211007134641.13417-1-vincent.whitchurch@axis.com>
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hardware may require some time for the muxed analog signals to settle
after the muxing is changed.  Allow this time to be specified in the
devicetree.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
index 870b043406d8..5a7328042c76 100644
--- a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
@@ -39,6 +39,11 @@ properties:
     description:
       List of strings, labeling the mux controller states.
 
+  settle-time-us:
+    default: 0
+    description:
+      Time required for analog signals to settle after muxing.
+
 required:
   - compatible
   - io-channels
-- 
2.28.0

