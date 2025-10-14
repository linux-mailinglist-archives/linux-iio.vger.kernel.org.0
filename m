Return-Path: <linux-iio+bounces-25046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56464BD85C4
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114E73BD726
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BFF2E6CC3;
	Tue, 14 Oct 2025 09:13:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CD2DAFDD;
	Tue, 14 Oct 2025 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433183; cv=none; b=P3IokeRDFtLLSq0tDjaSmQMgZk9BZYb5BpAcW6U/LkQ/vgeE9N9EmkqTICTqGgk+0Y74NKWZ+gU6kDv4JE5bywZsSK5UrE4exQsutawcAIlCvbCL2Ap9Eg8b9VUswEu/pmOnh12ucmvgiDvAmlMeNsNcqG27lWvwop6pA09LM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433183; c=relaxed/simple;
	bh=z8sn68NAt+PgmEPPSA+MhaLGdC4iQ6NqOu8t5akaAwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TtYsY5vE2c3/4y/+Heg4NUZXWuiWUa1kxjaOWV/dZE9jp/1gUyTF9l5W/735Df+fkFWpRYsXkiZf30S6btpxUF5ieo9PdAcdXjha48NfeItRgU0yApC0CoNXf3IkVMd6rthZ2mrGV6iPNkill7nGfCRrKOxw29snRTClKEpZNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f78ea74aa8dd11f0a38c85956e01ac42-20251014
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:af83a9a0-ebd0-4a87-9321-d4aed1796afd,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:51336594ba71906da8c015481ffb2ede,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f78ea74aa8dd11f0a38c85956e01ac42-20251014
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 720667590; Tue, 14 Oct 2025 17:12:54 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] iio: adc: ti_am335x_adc: Limit step_avg to valid range for gcc complains
Date: Tue, 14 Oct 2025 17:12:50 +0800
Message-Id: <d5e5e8cbbc9354ca1dd4745253df6cde07822325.1760433015.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FIELD_PREP() checks that a value fits into the available bitfield, add a
check for step_avg to fix gcc complains.

which gcc complains about:
  drivers/iio/adc/ti_am335x_adc.c: In function 'tiadc_step_config':
  include/linux/compiler_types.h:572:38: error: call to
'__compiletime_assert_491' declared with attribute error: FIELD_PREP: value
too large for the field include/linux/mfd/ti_am335x_tscadc.h:58:29: note:
in expansion of macro 'FIELD_PREP'
    #define STEPCONFIG_AVG(val) FIELD_PREP(GENMASK(4, 2), (val))
                                ^~~~~~~~~~
drivers/iio/adc/ti_am335x_adc.c:127:17: note: in expansion of macro 'STEPCONFIG_AVG'
	stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510102117.Jqxrw1vF-lkp@intel.com/
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changes in v2: use '<=',adc_dev->step_avg[i]'s max value is STEPCONFIG_AVG_16
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 99f274adc870..a1a28584de93 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -123,7 +123,7 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
 
 		chan = adc_dev->channel_line[i];
 
-		if (adc_dev->step_avg[i])
+		if (adc_dev->step_avg[i] && adc_dev->step_avg[i] <= STEPCONFIG_AVG_16)
 			stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
 				     STEPCONFIG_FIFO1;
 		else
-- 
2.25.1


