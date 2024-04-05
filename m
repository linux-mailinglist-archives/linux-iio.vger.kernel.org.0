Return-Path: <linux-iio+bounces-4086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265AF89A056
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BA6B2341F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C616F84F;
	Fri,  5 Apr 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UxbOQAA6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB816F27C;
	Fri,  5 Apr 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329038; cv=none; b=f/uXxyFzCM/p5dJsdk2ARJ/+Usq2QawQK3bPywYvjtNIGRTO31PbD4XTZv3q/lWEaak+uIrjMvvFoyipX5Fkg/4oITtuPvFdhsg9fLV7jRMvJ/mseuHRQOHFnAjwCLHPtM2491IuO0Wt97cUH4gpCKQmscZDK8D3Z2uPKxt+/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329038; c=relaxed/simple;
	bh=9zYHg1Yh55ibCjfnImR8SDnU9VMfC9QIwwDyxbIAeug=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=MGk4z7j2isPMgGclF2HkIZ46MRVyWqqOV+3Saf8JVQuw44RhFIyF7KoDDbqdXBKlMTaH07ulpPy1hSRQ5hszmc58ABBaUrEAcZsc2NqaEYnIAqPZB31M7bw/dFw3Z8AVupqmVKGppscQxzl52o+fXWcrfY5jm+ZAtUtYiRYgyZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UxbOQAA6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EYRP4000715;
	Fri, 5 Apr 2024 10:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=DKIM; bh=9SmIKpFsSzzC/dx981Z
	v8Ah56nCYVv7KaIxbw9hDDgc=; b=UxbOQAA6D8RfG5VZBwa4mw81ZKEAVS4mY5x
	+5mkLRo+jZSahbYAEnYYccRj7E/8EdaG3GVKn7EFUDKaLnANJZ4xkAPC82q0bGVH
	jbqOCI9reYxD0aGrQrIOr0oGyBIzagtlt1HHzAg9Fcoyp8PTiGtLNR9VavcMrVpa
	Hg4gqDW4Cfvt8uyYSuHQ5/yOnyxftGqslDw09jMhvir7yFbhPrZTe9nZrn2++Tdl
	v8+gS0nwX/OaND+yxamGp1BgC/32ln/D7Zd+akDeA2LaB9tb//Q+pvuHzsq3kuu3
	KyuNiiQSVMjB/EOYZ2rt4oQZFYIgA09gzdFlP5RWWTf0tNhcLtw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9y8vvnna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 435Eul1C064528
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:46 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:45 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSHw019011;
	Fri, 5 Apr 2024 10:56:30 -0400
From: Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 00/11] iio: dac: support IIO backends on the output
 direction
Date: Fri, 5 Apr 2024 16:59:58 +0200
Message-ID: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO4REGYC/x3MQQqAIBBA0avErBsQtaKuEi1GnWoILBQikO6et
 HyL/wtkTsIZpqZA4luynLFCtw34neLGKKEatNJWWdWhyImO/MExID2CgTw6HkczGKdM76CWV+J
 Vnv86L+/7Af79BcplAAAA
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Dragos Bogdan <dragos.bogdan@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        "Paul
 Cercueil" <paul@crapouillou.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=4644;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=9zYHg1Yh55ibCjfnImR8SDnU9VMfC9QIwwDyxbIAeug=;
 b=bZyZSkExRpMcIt1nSzulZpAjRPU4waXjnWczAa/lMJfsbzlQhafW1aZzsm8T5iEu1HcdzU0Yx
 r70+cZXmThSAxnBE/GJYtibK2ZNyGbx8uo35kkvUpuQCGQ5rcKs6pyP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vtXmL4Q1VmCPSI0P59Yn1zJk2TKhc5rw
X-Proofpoint-GUID: vtXmL4Q1VmCPSI0P59Yn1zJk2TKhc5rw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050106

Hi Jonathan,

Here it goes version 2 of the output backend series. The main points in
here:
 - The refactoring the DMA BUF api for setup. I pretty much like how it
   turned out. Note that Paul's patch ("iio: buffer-dmaengine: Support
   specifying buffer direction") had to be updated accordingly.
 - Introduction of the struct iio_info callback for getting the backend.
   I'm not sure about this one as we have no user for it and we may not
   have one for sometime. I like how the "default" implementation for
   getting the backend turned out and it should cover 99% of the cases. It
   will only fail if the iio parent device is not the same device where we
   bound the backend.
 - As mentioned above, we now get the backend from the iio device
   matching the IIO parent device with the device used when getting the
   backend. This should cover almost all the cases I think. Should be very
   unlikely to use a different device in devm_iio_backend_get() and
   devm_iio_device_alloc().

For the bindings, I still did not addressed Rob's point about dma-names.
I did reply [1] but still no feedback.

Anyways, full log:

v1:
 * https://lore.kernel.org/all/20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com/

v2:
 * Patch 1:
  - New patch.

 * Patch 4:
  - Make things consistent with the triggered buffer case.

 * Patch 6:
  - Fixed description as it's an output device;
  - Avoid duplicating the "bindings" word in the commit title.
 
 * Patch 7:
  - Renamed vdd_3_3-supply -> vdd-3p3-supply;
  - Added IRQ and vref properties;
  - Avoid duplicating the "bindings" word in the commit title.

 * Patch 8:
  - New patch.

 * Patch 9:
  - Fixed some typos in kerneldocs;
  - Add iio_backend_from_indio_dev_parent(). Default way of getting backends
    from IIO devices;
  - Explicitly differentiate frontends and backends ext_info in
    iio_backend_extend_chan_spec().
  - Spell out CW as CONTINUOUS_WAVE;
  - Add _hz suffix in set_sample_rate().

 * Patch 10:
  - Rephrase comment in axi_dac_set_sample_rate() when DDS is disabled;
  - Use the new iio_dmaengine_buffer_setup_ext() API;
  - Passed tone as 0,1 value being 1 second tone.

 * Patch 11:
  - Fixed mixed spaces with tabs in ABI file and dac -> DAC;
  - Add COMPILE_TEST to kconfig;
  - Dropped operating mode enum. Use defines;
  - Add comments for IIO enum operating mode and the value we need to
    set on the device;
  - Add spaces around {} in the reg_sequence;
  - Always use Mu instead of mixture of Mu and MU;
  - Don't error out if we do not recognize the part id;
  - Make sure to deal with other errors than TIMEOUT in ad9739a_init().

[1]: https://lore.kernel.org/linux-iio/04e2a0569953792673319f7fcab3fe03e6670c03.camel@gmail.com/

---
Nuno Sa (7):
      iio: buffer-dma: add iio_dmaengine_buffer_setup()
      dt-bindings: iio: dac: add docs for AXI DAC IP
      dt-bindings: iio: dac: add docs for AD9739A
      iio: core: add get_iio_backend() callback
      iio: backend: add new functionality
      iio: dac: add support for AXI DAC IP core
      iio: dac: support the ad9739a RF DAC

Paul Cercueil (4):
      iio: buffer-dma: Rename iio_dma_buffer_data_available()
      iio: buffer-dma: Enable buffer write support
      iio: buffer-dmaengine: Support specifying buffer direction
      iio: buffer-dmaengine: Enable write support

 Documentation/ABI/testing/sysfs-bus-iio-ad9739a    |  19 +
 .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   |  94 +++
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  62 ++
 MAINTAINERS                                        |  17 +
 drivers/iio/adc/adi-axi-adc.c                      |  16 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       | 100 +++-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  83 +--
 drivers/iio/dac/Kconfig                            |  37 ++
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/ad9739a.c                          | 454 +++++++++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 635 +++++++++++++++++++++
 drivers/iio/industrialio-backend.c                 | 179 ++++++
 include/linux/iio/backend.h                        |  49 ++
 include/linux/iio/buffer-dma.h                     |   4 +-
 include/linux/iio/buffer-dmaengine.h               |  24 +-
 include/linux/iio/iio.h                            |   2 +
 16 files changed, 1698 insertions(+), 79 deletions(-)
---
base-commit: 6020ca4de8e5404b20f15a6d9873cd6eb5f6d8d6
change-id: 20240405-iio-backend-axi-dac-be99373b036b
--

Thanks!
- Nuno Sá


