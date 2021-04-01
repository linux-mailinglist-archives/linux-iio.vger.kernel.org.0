Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD1351D44
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhDAS1s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 14:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239645AbhDASQo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5ECB8611B0;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=qxHHEh59lbTrqV1rllKZyjun9PIy/W9Y5I+tZUgQdYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAm5A824vgRGUpuimG3L+FHaGUew6xSrToUOXbQUI+uHNqLg5A6Mc8xe1ifYOhpAi
         9f2nsfuXW9Ij6HKfHDApns5QHEpef0WxiB6LaOHsLKrbTdJTJT4bj2DBvuWw8zHjIJ
         eCjFKqLzMBUXZH+p5tcZ5TEg2XAZ3eopSalLZ0PGOBogKFd+jOiCSEZcvQekt9+Q8p
         R13sh7T7FXwnJhVTDMiJb/8MAG/hrcgJXNWmZ1LsFypGbLdGW5ZmOlXhOUgEMnhTsq
         IWqe3rx8nzgDFtFataKsfg+WBB75svi7F0WcFfxA/OMIkT9NnvfQ4W737x9Gl65QOe
         LEZEfzcFiSt3g==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3T-EW; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/32] dt-bindings:iio:dac: update microchip,mcp4725.yaml reference
Date:   Thu,  1 Apr 2021 14:17:45 +0200
Message-Id: <82fb54974e8a22be15e64343260a6de39a18edda.1617279356.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Changeset 6ced946a4bba ("dt-bindings:iio:dac:microchip,mcp4725 yaml conversion")
renamed: Documentation/devicetree/bindings/iio/dac/mcp4725.txt
to: Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml.

Update its cross-reference accordingly.

Fixes: 6ced946a4bba ("dt-bindings:iio:dac:microchip,mcp4725 yaml conversion")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/iio/dac/mcp4725.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/dac/mcp4725.h b/include/linux/iio/dac/mcp4725.h
index e9801c8d49c0..1f7e53c506b6 100644
--- a/include/linux/iio/dac/mcp4725.h
+++ b/include/linux/iio/dac/mcp4725.h
@@ -15,7 +15,7 @@
  * @vref_buffered: Controls buffering of the external reference voltage.
  *
  * Vref related settings are available only on MCP4756. See
- * Documentation/devicetree/bindings/iio/dac/mcp4725.txt for more information.
+ * Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml for more information.
  */
 struct mcp4725_platform_data {
 	bool use_vref;
-- 
2.30.2

