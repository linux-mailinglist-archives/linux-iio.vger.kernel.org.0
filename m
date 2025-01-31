Return-Path: <linux-iio+bounces-14766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A3FA242AA
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 19:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BD6163AFF
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35551F1512;
	Fri, 31 Jan 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NiBwzQZO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDD1AC892
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348384; cv=none; b=mA9OgEeVyYZYwGlgqgrU3SJhGu01ZcCIuKsQ8CZKoilFibRNmv9IlZerbztDaOWYTB3/E2ptg/ugsu5bGLQj30HFDnHOxwLcTCTMxrtLOJ2uFtTulecJXJwJALcinamO/y4v0DsI/1njn3LgSqyxi89QfpOM0ojeKFsWnYatbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348384; c=relaxed/simple;
	bh=mCPNNfQ+mXH4SaFBhVI8w7CNWsoJtut/rmZTlH9X238=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNisNW/on26sBi7pUSvgTdKYHQ9EXLsUger1/oft1fC+EERaYmjy/f5Y9OuIH+hOHsEXcAEBkwPW4fZe8fqIqTayDKMmq4UjPM1JoY5d112LCuSvjBhi7iU2ShFzchXQoMYO+K9Vmmjlwwo2CztWhBbX/eZ5eMredFYtDtfIiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NiBwzQZO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VC5Akb009068
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 18:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VLRbXMmwZCBDiegFB6xNj0wrH8d23vZFWhr
	pgC8eiB8=; b=NiBwzQZOaKzarPHRFYiw83z8Jktn0eKZl26dv/VeGJjWkOXM99U
	9cXjmOXLUh0meVzbfqijX24RdKvAae6gJJYCKf2/yO31ETCHgwdkQ7yOxifsNIga
	AitLcHYte1W8XFAIdCcGrFyDIh6DAjwH2ZCPl7qcXhSfIZfUCreHPXtlYFc1Dimj
	qWk5ndqRGca+60aZeMiw++/mpw/jb9doLTAfitS1YN4bqIYMjpC1CjqolO+L4kvR
	j85Ykn4Qt+zWIY29ZWjKWOIzlQ78iSIrCKvWLyUbCQKu4uGwVIamVZTmie4S6FZz
	2vFLmfbIM7uqQaJC/+PB5B/SjCcuQfjSS/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gx76rvv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 18:33:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef9dbeb848so4361812a91.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Jan 2025 10:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738348381; x=1738953181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLRbXMmwZCBDiegFB6xNj0wrH8d23vZFWhrpgC8eiB8=;
        b=bzH9Q9uLXmPv/X+F9ymGZtnj93KXwKU7pWscwxvYDJtf0YKZl+oSsUmH8f6fscBeGp
         FCdibmnjS+Wl9hl4oNrD3+HMGjMH6wlFm9hz+rkAPdIrbF8yUgLh8jI+X7aUqxkGGhlB
         6+s1NMGxacBhiZ3PMOc7MyAZ/ugEscG2wbbPIiQGO2miljNGa/gTOIBqKxce6NtYREhb
         U4HWELfzjYjhcFcHxXhvZjTyBcrDi9xSqfBRaAO4s0zHhL2CjFW6V7Avvd3411iFMrl3
         VIabVdG0rNUx+bwwZB7SpkrzhgbI+k9QpC+tGLHxb7BoPerm2lPBma2qtbEhNz3J7QCZ
         qb0g==
X-Forwarded-Encrypted: i=1; AJvYcCVrTrP8bb0ib0EpxuFG214MeG9CqtO2LTZ/QyRCvJtrd6A3JQR+PBgu12Lk+ma+g38oCXm5sSVtxUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiD/5DrkdDQSuOKtWOAUJec7nEd7ezq+m4Juq9gHegXFxvPHt
	t7IaXUA1LUO8lh0+7wa3aLJm/e17ShSZBdy3QbyDUT4qfYOU29pCXpqtN2tZ2HpZTwHNNhwg074
	XmwNNJl4+j3zVyNor/CmjqAbc5I+gT/m7tIVPcYJfzT+Irm00jUtzIO19uZ4=
X-Gm-Gg: ASbGncvZ9tyopm8iXgZNJsixnPxT+LmxgR2TmM9g/5kqZEtKg4etrTNFHqXkwSwk91C
	5JT/5KAIZr/BIS9PXW1p+vpMLLeHAibMVtBxExtT5ivTFNYVHNIm2yivFXDezpEIfLdbk50DBJQ
	L75t3b4ExzXUvnnAAZ4rX7ZmL0ButNC+vEdsRDZBJ8jKoTUfhah0Di4SVhi48x7lyITesrQVGy2
	U7cTCokKqJNW4j6Fs5NnAyfFnATmm6KI9k8FXSm8DvffZaHedO5H+YcqWg21DqyAGeXwh8wAOQt
	lqNeThqJFK0JiAIloCphprG66TIx6pyuGveOrWr8
X-Received: by 2002:a05:6a00:2149:b0:72f:d50a:9096 with SMTP id d2e1a72fcca58-72fd50a921dmr14048181b3a.8.1738348380795;
        Fri, 31 Jan 2025 10:33:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVIFdjy9mcPPQqVGEnO1Ke3flUWcfPUyVjjSHEovFnSVxSnSZS93jsbtVJXGdphqMKz/skZQ==
X-Received: by 2002:a05:6a00:2149:b0:72f:d50a:9096 with SMTP id d2e1a72fcca58-72fd50a921dmr14048138b3a.8.1738348380282;
        Fri, 31 Jan 2025 10:33:00 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ce9f4sm3714919b3a.146.2025.01.31.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 10:32:59 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, dmitry.baryshkov@linaro.org,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        jishnu.prakash@oss.qualcomm.com, quic_skakitap@quicinc.com,
        neil.armstrong@linaro.org
Subject: [PATCH V5 0/5] Add support for QCOM SPMI PMIC5 Gen3 ADC
Date: Sat,  1 Feb 2025 00:02:37 +0530
Message-Id: <20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jQSA00O0xhix2NXA4Jfmp4fx_49WQ7LU
X-Proofpoint-ORIG-GUID: jQSA00O0xhix2NXA4Jfmp4fx_49WQ7LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501310140

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same driver.

Patch 1 is a cleanup, to move the QCOM ADC dt-bindings files from
dt-bindings/iio to dt-bindings/iio/adc folder, as they are
specifically for ADC devices. It also fixes all compilation errors
with this change in driver and devicetree files and similar errors
in documentation for dtbinding check.

Patch 2 splits out the common ADC channel properties used on older
VADC devices, which would also be reused on ADC5 Gen3.

Patch 3 adds bindings for ADC5 Gen3 peripheral.

Patch 4 adds the main driver for ADC5 Gen3.

Patch 5 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Changes since v4:
- Split common ADC channel properties out into a separate file to use as 
  ref for ADC5 Gen3 and moved ADC5 Gen3 documentation into a separate
  file as suggested by reviewers.
- Addressed few reviewer comments in driver patches.
- Link to v4: https://lore.kernel.org/all/20241030185854.4015348-1-quic_jprakash@quicinc.com/

Changes since v3:
- Updated files affected by adc file path change in /arch/arm folder,
  which were missed earlier.
- Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
  instead of adding separate file and addressed reviewer comments for all bindings.
- Addressed review comments in driver patch. Split out TM functionality into
  auxiliary driver in separate patch and added required changes in main driver.
- Link to v3: https://lore.kernel.org/all/20231231171237.3322376-1-quic_jprakash@quicinc.com/

Changes since v2:
- Reordered patches to keep cleanup change for ADC files first.
- Moved ADC5 Gen3 documentation into a separate file

Changes since v1:
- Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
- Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
- Combined patches 8-11 into a single patch as requested by reviewers to make
  the change clearer and made all fixes required in same patch.

Jishnu Prakash (5):
  dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
  dt-bindings: iio: adc: Split out QCOM VADC channel properties
  dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 157 ++++
 .../iio/adc/qcom,spmi-vadc-common.yaml        |  87 +++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  81 +-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   2 +-
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |   2 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-
 arch/arm/boot/dts/qcom/pm8226.dtsi            |   2 +-
 arch/arm/boot/dts/qcom/pm8941.dtsi            |   2 +-
 arch/arm/boot/dts/qcom/pma8084.dtsi           |   2 +-
 arch/arm/boot/dts/qcom/pmx55.dtsi             |   2 +-
 arch/arm64/boot/dts/qcom/pm4125.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm6125.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi           |   2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8937.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |   2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi          |   2 +-
 .../boot/dts/qcom/qcm6490-fairphone-fp5.dts   |   4 +-
 .../boot/dts/qcom/qcm6490-shift-otter.dts     |   4 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dts       |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi      |   2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |   4 +-
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi   |   2 +-
 .../boot/dts/qcom/sc8280xp-huawei-gaokun3.dts |   2 +-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |   2 +-
 .../dts/qcom/sc8280xp-microsoft-blackrock.dts |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |   6 +-
 .../boot/dts/qcom/sm7225-fairphone-fp4.dts    |   2 +-
 .../boot/dts/qcom/sm7325-nothing-spacewar.dts |   6 +-
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   8 +-
 drivers/iio/adc/Kconfig                       |  30 +
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/qcom-adc5-gen3-common.c       |  99 +++
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 724 ++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c              |   2 +-
 drivers/iio/adc/qcom-spmi-vadc.c              |   2 +-
 drivers/thermal/qcom/Kconfig                  |  10 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 489 ++++++++++++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550.h      |  46 ++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550b.h     |  85 ++
 .../iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h    |  22 +
 .../iio/adc/qcom,spmi-adc5-gen3-pmk8550.h     |  52 ++
 .../iio/{ => adc}/qcom,spmi-adc7-pm7325.h     |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350.h     |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-adc7-smb139x.h    |   2 +-
 .../iio/{ => adc}/qcom,spmi-vadc.h            |  81 ++
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 164 ++++
 66 files changed, 2117 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
 create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550b.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pm8550vx.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,spmi-adc5-gen3-pmk8550.h
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (77%)
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h


base-commit: 5ffa57f6eecefababb8cbe327222ef171943b183
-- 
2.25.1


