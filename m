Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B72398EE9
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhFBPpG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 11:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232091AbhFBPpF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Jun 2021 11:45:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FA5461401;
        Wed,  2 Jun 2021 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622648602;
        bh=jQfc6V+5fIkfWn3ixgZGKTZVxT9URXQOJEGGW29C1m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cW8iZculuT9ve8BWFUusvOE7xAIyan7hKimqg1HaHDpxQ6FPqQDqyttnKnfP92XYT
         tLNuzV1zDBZ9pzLonEiy8WzjqZsKzNdc8X8c51wup5aodAGsZLSEJPwVlVtLgrxlWM
         Tl8qobESCWsbGC/+AsUSHgXB69bA3PdlYyWIKbz6FIy+Dd2/XBga581WJx8jzsVrKW
         m/Ui/joAfznbjaiN0wP2AdKV4K8h1tVrajw5xoCs3WS2+qHLKnfPgGlhFiZi1H0IJ+
         ncqxLGBCpUhHD+pBfCalRu5gO7F3bkDyAXt0RK/z2cNUJob6dTfX6iRUCM4V4gblIb
         kgo0uTLd1UlcQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1loT1b-006Xbv-Fw; Wed, 02 Jun 2021 17:43:19 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] dt-bindings: iio: io-channel-mux.yaml: fix a typo
Date:   Wed,  2 Jun 2021 17:43:12 +0200
Message-Id: <ab0d1f89cf64ff4904155c92e1895763fb0bf173.1622648507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622648507.git.mchehab+huawei@kernel.org>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The file name: Documentation/device-tree/bindings/mux/mux-controller.yaml
should be, instead: Documentation/devicetree/bindings/mux/mux-controller.yaml.

Update its cross-reference accordingly.

Fixes: a66cec598f49 ("dt-bindings: iio: multiplexer: Convert io-channel-mux bindings to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
index 37382b85f2b8..f37586702489 100644
--- a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
@@ -17,7 +17,7 @@ description: |
   created. The number of this io-channel is the same as the index into the list
   of strings in the channels property, and also matches the mux controller
   state. The mux controller state is described in
-  Documentation/device-tree/bindings/mux/mux-controller.yaml
+  Documentation/devicetree/bindings/mux/mux-controller.yaml
 
 properties:
 
-- 
2.31.1

