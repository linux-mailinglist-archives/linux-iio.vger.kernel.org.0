Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7228644C33D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 15:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhKJOpi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 09:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhKJOph (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 09:45:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36DDE61205;
        Wed, 10 Nov 2021 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636555369;
        bh=urV4XvKzK74bA07R59ajpniCQdDC1x2Dep4mfQGfxhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQLLMRHMwdM9sQg/MKc1yXVlo29+SinqgpFTS7uGikBiTpN0IPkcfxVRLneRvbT41
         iDG9b/wUcYHrwlOfNTBEb1t3k19GkrwxWe/fCLbGKu6BZc/qPS58iwTSLTX9Y/8B0j
         LiuxNVauLhbNTEds6rCmKAYmWWKfWlmA5ucX1fKFbr70vfX7qPOff2KdBJqxHjvYYo
         efiP2lnzr+uDpm6yvVIqPMoImlGsDb0lW3FHFOaBOpCM0GocYNw2yZExsEfLEAhyuY
         FKM2CqTrdGnF4weR/FDaLnQIl99nm8s/pxmLvKXE0OAkkqKeQTqLvPAu6+KeVMiyWJ
         BnvDYVc8di5GA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: [PATCH 2/2] Documentation: dt: iio: st_lsm6dsx: add disable-shub property
Date:   Wed, 10 Nov 2021 15:42:33 +0100
Message-Id: <c03385c4f862f04406dc4b5f15379c0be921c98a.1636552075.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636552075.git.lorenzo@kernel.org>
References: <cover.1636552075.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
index d9b3213318fb..502438f14e19 100644
--- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
@@ -61,6 +61,10 @@ properties:
     type: boolean
     description: enable/disable internal i2c controller pullup resistors.
 
+  st,disable-shub:
+    type: boolean
+    description: enable/disable internal i2c controller.
+
   drive-open-drain:
     type: boolean
     description:
-- 
2.31.1

