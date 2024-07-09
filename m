Return-Path: <linux-iio+bounces-7464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485A92B63C
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AB51C21E0E
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60463158218;
	Tue,  9 Jul 2024 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D9PrflUZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BA157A4F
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523496; cv=none; b=UZ8BtjWJ+rHNO+7coqtd/TgQqOM7QWDvp9Vtcnlwi52dvRWqs1W49wwMx6J8u+j/Ij1k2uA3CjHcKlWv40WLzDnfhvk1KRBMYLBqNxjZR/6oXQn89Sq9c7tkS6H7MNPI915B7jsTOeWx5mJZf2G7QiuhmgNummuGBVAaLzM7rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523496; c=relaxed/simple;
	bh=XPxAnVJjYCjsfPpM969/BHLwentqhjB7ycCEyRs3Kr0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QLlZLNeHEZfTdQwSccodnC8nGUgiRM2V0CfOTFBoR1i+pivC+KWFJDw76j0RXi5SGYqY4HNmJiNrZEFuv8mje6a2z7X/KcV9tlRjADXleo6JphW5zsQhFuWuMwoa4Add0or7BO3U6kx5SJ1n6Wci8dnsF6DxSygy358MRoSrk/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D9PrflUZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469B6392004305;
	Tue, 9 Jul 2024 07:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=iLt9DUbRo9r9ZIwbp70VPabVscF
	OgjdWY2Vk+PM6fbs=; b=D9PrflUZge+1olTx2CspF1wdbR+NI+Pmnn5TlAvC0Pg
	2zZSaoz5ofC7PoRUFp4G87OnJ+asreoPcgW4h9t0peZqsb62cPaAZAF0q3z3mxqH
	F7zm8mZhM2Ce4rSp7YrQmEkB3MOQ9t+1IRz3Hi27UU4rIJxwhRyctqemotJ586fN
	xgOUT+cQCLgJbUU8u5oYgEWtKb4mPtOpYPXKsAdosi0TeM8VTF+f0+QppFmdMUsy
	yA9GgprLG3F1SSJ5mvdlh2PAmMjicwpyXv1u8mKn7cD0AroQqq03HOrku+QRWNDv
	yiLZBD9t2lOBUL+C8B9X51vjG9ooLlrE3bYIWJOYMyg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 408y9291nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 469BB12C055130
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:00 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Jul 2024 07:11:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:00 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgj032387;
	Tue, 9 Jul 2024 07:10:50 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH 0/9] iio: adc: ad9467: add debugFS test mode support
Date: Tue, 9 Jul 2024 13:14:27 +0200
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJMbjWYC/x2MQQqAMAzAviI9W5hTGPoV8TDXToswZUMRxL9bP
 CaEPFA4CxcYqgcyX1JkTwpNXUFYfVoYhZTBGtsZZ3okvlBkx9mHjROhJ1I3n0ssyNEFskY714I
 ejsxR7v8+Tu/7Ab2PMGdtAAAA
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=1669;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XPxAnVJjYCjsfPpM969/BHLwentqhjB7ycCEyRs3Kr0=;
 b=3aaDOQHXSeI96DNYosRS7bOqkobO6S0gT2udVwnrTQnWuTvwTIO2mqkBwXLhnEWipKJyxv7uz
 JAasMFtmsOYBqATLxJoiI6+LTYSXhkOuXtTzixFL34xsmXbXdV7+deS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: NUi6aUjcNK04ab5VQgaI8fcZYe5Xe_TS
X-Proofpoint-ORIG-GUID: NUi6aUjcNK04ab5VQgaI8fcZYe5Xe_TS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=751 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

This series adds support for testing the digital interface on ad9467
using different test patterns/modes. For doing it, debugFS support for
backends is also added. Notably:

* backend direct reg access which is not directly needed for the ad9467
  new interface but it's something useful to have (the same as IIO
  direct_reg_access for "normal" IIO devices) and something that I would
  eventually try to add anyways.
* printing channel status which is useful for more verbose information
  about some possible failure in the test pattern. 

The first couple of patches are unrelated but simple enough that
I placed them in this patchset.

---
Nuno Sa (9):
      iio: backend: remove unused parameter
      iio: backend: print message in case op is not implemented
      iio: backend: add debugFs interface
      iio: backend: add a modified prbs23 support
      iio: adc: adi-axi-adc: support modified prbs23
      iio: adc: adi-axi-adc: split axi_adc_chan_status()
      iio: adc: adi-axi-adc: implement backend debugfs interface
      iio: adc: ad9467: add backend test mode helpers
      iio: adc: ad9467: add digital interface test to debugfs

 drivers/iio/adc/ad9467.c           | 255 +++++++++++++++++++++++++++++++++----
 drivers/iio/adc/adi-axi-adc.c      |  64 +++++++++-
 drivers/iio/dac/ad9739a.c          |   3 +-
 drivers/iio/industrialio-backend.c | 123 +++++++++++++++++-
 include/linux/iio/backend.h        |  21 ++-
 5 files changed, 428 insertions(+), 38 deletions(-)
---
base-commit: 986da024b99a72e64f6bdb3f3f0e52af024b1f50
change-id: 20240709-dev-iio-backend-add-debugfs-ef7cd2007073
--

Thanks!
- Nuno Sá


