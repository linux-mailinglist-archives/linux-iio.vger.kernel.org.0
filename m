Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4B2F4970
	for <lists+linux-iio@lfdr.de>; Wed, 13 Jan 2021 12:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbhAMLBw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 Jan 2021 06:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbhAMLBd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E5D3235F8;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=9tvX+bdF7vZzRjfdf3aTmCuShY92K6sxOhnK8P3hfg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PelSfOIloBflwGZOzbGZJw7GytSQMejH3SDd848JDzPvc5lJk5ZGELvfUJOeEhP4h
         R7bNJjp7XbWHPU8tpLf4nQFVfC2rPCUKYxovs4JB/oU3wyxOjzNwt0kTh3HiEoqZM7
         P9ttfCIZ8sLxksdULp8GK8PecYzf1U8TwByBXOSQeW8T4eExGDO6VcCUMYzfVNNojr
         YPJdXpQe31lpvI9DhgK6WwM2DAgw/7SXLfI+PoPrL3YoPj0u3tSjZ/KM6qBApgPw6w
         whUruFW+xs/oaJegXdTVfzizr3ECB76gtv1k0IuwWe+1ZrYP0Ry86tF2Hd3QUhlYRm
         mBSR8oOmImwqg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGf-NZ; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/24] include/linux/iio/dac/mcp4725.h: update a microchip,mcp4725.yaml ref
Date:   Wed, 13 Jan 2021 11:59:19 +0100
Message-Id: <ae1bc39a6c064bbce186a720a84a4f325bc2438c.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
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
2.29.2

