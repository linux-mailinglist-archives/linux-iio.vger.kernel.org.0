Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3835198B
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 20:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhDARyE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 13:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236467AbhDARpC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Apr 2021 13:45:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 760C061369;
        Thu,  1 Apr 2021 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617298998;
        bh=CMa/KbEmOuK4qKikXAWIG/TGer29caM46pGWKN9rWO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tj0UD5/hbO1I8u4q+WSs4XUY33eAKSL9sij1MpoLUK8RFI8qIt5/uC1qmwFnUNBYB
         Vsfu1UGniXYDj5Wg4/aFfME+kCmq+8fUoSFFaK8YsbqvwdZYslo6R18G9XkNd+hZlQ
         crxmW6vg0l+yHayurw4yBDzHvqhMJq/7Olqw4YlH4jGksKw2AZrpR6jyFCu0qh57Vi
         rLnNEiBsi8aKjFmui4D5oqqHsT2q6wHWXLwMwtTsH4XYXIvW3WZwS0qkTJd9vB8YTX
         QmML+6V6lxSuz/ViNbFSzei9FyMzwo2/opgZq6ICJcfxv47wvU+0td1XryGNtLAk9c
         jODH9z40Jajfg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/6] dt-bindings:trivial-devices: Add sensortek,stk8312 and sensortek,s8ba50
Date:   Thu,  1 Apr 2021 18:41:11 +0100
Message-Id: <20210401174112.320497-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210401174112.320497-1-jic23@kernel.org>
References: <20210401174112.320497-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Two simple devices. The stk8ba50 datasheet could be found via
google, but I only have the driver for the 8312.

Given they both seem to be 3 axis devices with a single interrupt
line, add them to trivial-devices.yaml

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index c7d49a720afa..92ea6b960e16 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -258,6 +258,10 @@ properties:
           - sensirion,sgpc3
             # Sensirion multi-pixel gas sensor with I2C interface
           - sensirion,sgp30
+            # Sensortek 3 axis accelerometer
+          - sensortek,stk8312
+            # Sensortek 3 axis accelerometer
+          - sensortek,stk8ba50
             # SGX Sensortech VZ89X Sensors
           - sgx,vz89x
             # Relative Humidity and Temperature Sensors
-- 
2.31.1

