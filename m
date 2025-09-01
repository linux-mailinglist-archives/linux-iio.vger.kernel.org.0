Return-Path: <linux-iio+bounces-23561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BCCB3DA30
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72233A6FE5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 06:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6224E4A1;
	Mon,  1 Sep 2025 06:46:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760652472AA;
	Mon,  1 Sep 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709195; cv=none; b=dYgjgJ52kUtpEo6bWVkSjWdzl14s+gsZ6H7uyi0vA9apWlqdbJauTrBYnTdjiB4tURh28wl091mPMXtIdTJo3OsNAfa9qNKODjLKWVC7T3VGno6EZNqnovBdRLlEaSy5s9ChjtA9/uxBgWhDtxyfM5yMU0qbidLs5UDAv0A+VuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709195; c=relaxed/simple;
	bh=lPUfn0B6m68xQeVnP22kowPxW+j7Mm9qaVRRE/WoGQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sWc/Nc8jsTK5X1iazgkufCuJalD5QfkQaoGvCtCkQdJ1ka2eBSegesUYS9TtUmvvIyplEOz2YGqlYrGCmgjEwX9gY3Dlyla//I0d56EELuQrfNedBpUVGi0DQuE0BSs4TVZXfeF0ZJ9qFDLnjhLip9LNCbfKxlBdfclFhcp4xGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201608.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202509011445132046;
        Mon, 01 Sep 2025 14:45:13 +0800
Received: from locahost.localdomain.com (10.94.9.245) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 1 Sep 2025 14:45:14 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <marius.cristea@microchip.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] iio: adc: Fix a null pointer dereference in pac1934_acpi_parse_channel_config
Date: Mon, 1 Sep 2025 14:45:11 +0800
Message-ID: <20250901064512.1554-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025901144514a21115e7c8012b04e761447f998e6e63
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Add check for the return value of devm_kmemdup()
to prevent potential null pointer dereference.

Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/iio/adc/pac1934.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 2e442e46f679..95c9d14b5529 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1108,6 +1108,9 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
 			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
 				     (size_t)rez->package.elements[i].string.length + 1,
 				     GFP_KERNEL);
+		if (!info->labels[idx])
+			return -ENOMEM;
+
 		info->labels[idx][rez->package.elements[i].string.length] = '\0';
 		info->shunts[idx] = rez->package.elements[i + 1].integer.value * 1000;
 		info->active_channels[idx] = (info->shunts[idx] != 0);
-- 
2.43.0


