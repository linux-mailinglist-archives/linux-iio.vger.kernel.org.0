Return-Path: <linux-iio+bounces-11589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC89B5A7D
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 04:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868661F24B24
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 03:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDDB194A68;
	Wed, 30 Oct 2024 03:49:11 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7B193432;
	Wed, 30 Oct 2024 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730260151; cv=none; b=N6ha/ep3g/35wca6rDFWV8/SfSwRkp1XzbrpSNZkP7fyw++hTBgOSZuRa0bqtzpnUNJoXFYZBMdicTL5AlcM0+lU7UzsMGuY+Gk7rnHWEEQZ/ZyeZeR8WiwapW3gqaEZSNkLMlDswfdO/G50v/WnQiaGnurBL5Ivi2/vIk1eoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730260151; c=relaxed/simple;
	bh=daNOsmMnPEMLDlV+9yo8DUW06AdiYF2RaW/UiAbgUP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ryk3LatOrEW6d+YEKFrnvqRJqTtAIekBEBJPak6kOYJIwnc1Fp0NoqX2osRa3uHK1cm+r+Ggu58iU/GkfFehjsRi38ROv4TAsrk+QXfj0MLP+V7wvwlA3s/7FTbWJ64B3ZaxAP1RPULPawPAltCTQvsV06dxiFbf462a2KfuJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e5d44ad4967111efa216b1d71e6e1362-20241030
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:e20aaaf7-ab13-4583-9308-317b1215a0c6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:e20aaaf7-ab13-4583-9308-317b1215a0c6,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:8ec5002eb373147914e24c8edb80b435,BulkI
	D:241030114902BYADF0TW,BulkQuantity:0,Recheck:0,SF:66|841|17|19|102,TC:nil
	,Content:0,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: e5d44ad4967111efa216b1d71e6e1362-20241030
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 848244465; Wed, 30 Oct 2024 11:49:00 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: liambeguin@gmail.com
Cc: xiaopei01@kylinos.cn,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaopeitux@foxmail.com
Subject: [PATCH] iio: test : check null return of kunit_kmalloc in iio_rescale_test_scale
Date: Wed, 30 Oct 2024 11:48:54 +0800
Message-Id: <ecd56a85e54a96c2f0313c114075a21a76071ea2.1730259869.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kunit_kmalloc may fail, return value might be NULL and will cause
NULL pointer dereference.Add KUNIT_ASSERT_NOT_ERR_OR_NULL fix it.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Fixes: 8e74a48d17d5 ("iio: test: add basic tests for the iio-rescale driver")
---
 drivers/iio/test/iio-test-rescale.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
index 31ee55a6faed..11bfff6636a3 100644
--- a/drivers/iio/test/iio-test-rescale.c
+++ b/drivers/iio/test/iio-test-rescale.c
@@ -652,6 +652,8 @@ static void iio_rescale_test_scale(struct kunit *test)
 	int rel_ppm;
 	int ret;
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff);
+
 	rescale.numerator = t->numerator;
 	rescale.denominator = t->denominator;
 	rescale.offset = t->offset;
@@ -681,6 +683,8 @@ static void iio_rescale_test_offset(struct kunit *test)
 	int values[2];
 	int ret;
 
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff_off);
+
 	rescale.numerator = t->numerator;
 	rescale.denominator = t->denominator;
 	rescale.offset = t->offset;
-- 
2.34.1


