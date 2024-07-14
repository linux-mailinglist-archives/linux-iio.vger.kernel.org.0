Return-Path: <linux-iio+bounces-7611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BF7930AFA
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803E42810A1
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2024 17:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248513C810;
	Sun, 14 Jul 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ansari.sh header.i=@ansari.sh header.b="SOGvgsH9"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB0C15B;
	Sun, 14 Jul 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720978523; cv=none; b=LuAO3pNBo/FrU/V/8BVPDBHo8Vsk97eOb9bnDx06sgX9iCiOup9VeE/xxH/7bUBD9Xbo7PlRMF2vAvLuCFIKxWA6Nj2upKWee3s8KxqNvWUqsHJv/0HD1J4qoiV9OW5HzUOtbhm1ZMPyv8RjbC4WTjYnKwM4Asj/sMKLmRMkLqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720978523; c=relaxed/simple;
	bh=I/zqBwcxVSu5yg+K1xqT1Pmf9IjAjqyJEuPooErnlYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exMpr3jhzljKRZWh1BmHJ4cyAGzyL6/dwsUmie8DKIK73eWnpKJztZFTmXM0bA9YnwVHkPkf4PIw2Sst1ujd19KvHYIKH8J2CYdAlhPEB2MyAEKp1Khg8QGEyF/Nw1dfnFGIaqEG1AWbmtggj3gvBOHbZmKeFD437JueoATZUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ansari.sh; spf=pass smtp.mailfrom=ansari.sh; dkim=pass (1024-bit key) header.d=ansari.sh header.i=@ansari.sh header.b=SOGvgsH9; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ansari.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ansari.sh
X-Envelope-To: linux-arm-msm@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
	t=1720978518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H28ez38aNdebfEHu3HdpcZQGNIn2Qx6GCD4JHflPKwM=;
	b=SOGvgsH9d11rF+RVn/SYXqGTztTFsrbz3Iags1Cxizj3mYW1EfUsVU7yV7sKUalqQfbSM9
	P0FfqstSftCL0xEMskuWJQZ6WjVaRJF+++sQWGQPSdtJhCuGXZE6/phYU0Z5m2/lnkuZTc
	Z8U0VBAUASbd47Ec1k6wSsyCsTIT4tE=
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-iio@vger.kernel.org
X-Envelope-To: rayyan@ansari.sh
X-Envelope-To: andy.shevchenko@gmail.com
X-Envelope-To: andersson@kernel.org
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: hdegoede@redhat.com
X-Envelope-To: jic23@kernel.org
X-Envelope-To: konrad.dybcio@linaro.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: lars@metafoo.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: decatf@gmail.com
X-Envelope-To: robh@kernel.org
X-Envelope-To: sean@starlabs.systems
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Rayyan Ansari <rayyan@ansari.sh>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-kernel@vger.kernel.org,
	Robert Yang <decatf@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>
Subject: [PATCH 0/3] KX022-1020 accel support + inertial sensors on msm8226-microsoft
Date: Sun, 14 Jul 2024 18:33:02 +0100
Message-ID: <20240714173431.54332-1-rayyan@ansari.sh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,
The following patches:
- Add support for the Kionix KX022-1020 accelerometer
- Add the KX022-1020 accelerometer and AK09911 magnetometer to msm8x26
  Lumia devices

Thanks,
Rayyan

Rayyan Ansari (3):
  dt-bindings: iio: kionix,kxcjk1013: Document KX022-1020
  iio: accel: kxcjk-1013: Add support for KX022-1020
  ARM: dts: qcom: msm8226-microsoft-common: Add inertial sensors

 .../bindings/iio/accel/kionix,kxcjk1013.yaml  |  1 +
 .../qcom/qcom-msm8226-microsoft-common.dtsi   | 26 +++++++++++++++++++
 .../qcom-msm8226-microsoft-moneypenny.dts     |  3 +++
 .../dts/qcom/qcom-msm8926-microsoft-tesla.dts |  3 +++
 drivers/iio/accel/kxcjk-1013.c                |  8 ++++--
 5 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.45.2


