Return-Path: <linux-iio+bounces-26511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBEC8E851
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 14:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D393B181B
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E15D2868A9;
	Thu, 27 Nov 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+78atUn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I2wf8lCN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D12836AF
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250889; cv=none; b=OVNvTiyiwn96vn7tVFKC+LQUPiHjhJEtjPLPNSlPGgFvs3Hvj9BUPxqVjl5rALlwNbq9/56QpdrVXDaaWtkMqnC9Flg5BZ4D0qFC6pQn6Myl1Hs0rZFT1YUH3lQDvacEZu3H4u3aOB4c2vaQk4CQjLQjm3pM0i2a1XJ623IrNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250889; c=relaxed/simple;
	bh=+TpeKaSTeGzn7+mfIr45Gfnhyh/71URKVSCoTFPRx2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UhK3yR7IGRDBbGaJxI/MLgUbDbqkJ7PD8iwdsAv4wQCmT6iK4N7I+tr7GVAtIvYjQIU2d8kD4A+taf84PEAVIKxUBd35Oszy05BEU49JQ9OtyysccZdpkTXHZT/DWK9ZNyuakfo0biyVHxrpsbF/yrBfq8DCSaOxZzC8ba66qiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+78atUn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I2wf8lCN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARA5x7N3840552
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SfgzeAmGUyU6iwQ3W5i7g7dxmwzm18cXhPO
	4IGd3Jhw=; b=g+78atUn9OVX7JFK9drePTIvQY8pObR0PkNHOGaWVwapZWHe5Zk
	kIPBfP+U51vhNzmMCZpFZOv8W7byrj4JjjwwZFxLa5fgLngDR2DciZUgrN8TaEti
	x5chKjNimrHj582qiWqezdrarsgf0L9cpXJmg4veFImXl+4JZAiut7VMYXPI5U8C
	rn/nnSCr62FLCaOn4oBncTFQdYP5LNjXSCLXEWWJJYtAGv9OcEaJ0INtnq6n7vmo
	h7hd+u5PtqQ2NI536lWbizZ6M9/K9lV1Usm0rTXnVXeunLXZdU9gla0m39NTku7t
	MNEV6LJP1/3v9qqQfJem/B96T4D3b5W1CmQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apdj09t4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:41:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295915934bfso11421755ad.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 05:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764250885; x=1764855685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfgzeAmGUyU6iwQ3W5i7g7dxmwzm18cXhPO4IGd3Jhw=;
        b=I2wf8lCNej5qvAmewD1ua9SftIHW3CM3v7Xm5YLzqwhoSE5TPd6ZzpFGFRhNfxVNXq
         ewSgjJl57Y2aMbFh4kIlia5AHocDvYHbOhT19HNmjVPWF3+adu5tm3+BwovV2xnd9per
         QOID+oqvtHKcCiu55mQmca3bvORy623KjC22JbmE4lLxFWd4JxpV27AugS5XA8n0N2Zt
         AJT/oQ9RMrh5X2Maoeap5KKBjwdCVZzdbCCRRULcXBSTs7enElag7Mss0puM/m8pBdb3
         vo4SsK3TUb2ZtJilVlCo9XdMLd1CJatPtZMa4+PdxKuUTtXyftlt0X/Imwr+K3cxaJ6p
         pIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250885; x=1764855685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfgzeAmGUyU6iwQ3W5i7g7dxmwzm18cXhPO4IGd3Jhw=;
        b=aHFczgZWMhpDzyMVROMrHjzYLO0Gc0+qxDey5fSfcUAxEsIfRwe7N5QBa559gDWe+n
         B8dYkV0yv8a5uvdqDYfL4+BULOPNuw8KjFVkNnjFEpGKRdHzcY6DSBohR1ae/Ws3tE7k
         hjlRlUxBszd5AXftaEuLX7M3+YAcpxqinK7LT7nc8EB2JGPTt7/HigAzsWrSN4nscsTP
         G70YorAYXFqMDvwuza6u9NrXWDrMZSJiRsBZA9fJQH42f7eOkEcNHRUBviqIAVwUAMvy
         3EMFc8G4BiJabEao2EaeiXWr//D+NnPAah33LE/sIJZhXrMX55eTdS155PTv6ZRyusGr
         q2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWVnfUnxQn0rrNXv044ij21jXRms4TWWbvDYTQZgdoThCrb9ia+kQ3poKrWU/pD1hG1i5yRQVM9AQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJirJWiAklEyw2nPsD8UVgfyNWvl7rKxwpDxU4D7+hjEcTXkc
	UVyklTKa7oX4X2flAQOxQgXJB/IJy+AYaf4PhB1ueettbJLUiEROj+fD4jVmnDIo62SpOnUO6lR
	7+bPfFuStJXLogfreQfUUiAlPHSc0Uf1BVb/HChlrcvnmVU+ueG2lHSrrGlYGHV4=
X-Gm-Gg: ASbGncvNENBPe72ACDJrQR3AhhhZ4L+T5/GydE6gH1Q3BqwYEPbkIBNjTUBnK4jQErs
	FAXzbGXQ+fx2F2mNx2VHASEXQsI/lOBU0Ynaog1W/eA85obtzSySFcRr0tYs4UqrBAvSe/NGPoO
	SKHrJclEdTsLZ0oZcNuvIeOhfB28c7VD4KxcYaYpXVj7wWZj/MwZ2enQecF95WRaHDnUe2HeXeP
	ib1fkBxHIivAl/XqOFRyWTraJXirMrxFohBg74ApeG2H07Ly+XfqHTmpc9tcFIv6a+tSJycZYM3
	o4W9A8uQbktDHyPb7pqx6D4U82O/ifjKQb7bL3TVeX2CBzIgg7PuLnDESTHz+q4V9/UA1X3zdsR
	49r6NOATr6PFFevt4yKZERI4OexBrHI1KYN7gHr3MY1e5
X-Received: by 2002:a17:903:28d:b0:258:f033:3ff9 with SMTP id d9443c01a7336-29b6c6c2871mr246299465ad.48.1764250885091;
        Thu, 27 Nov 2025 05:41:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1LwdVWfJBrvvql1VAb/OKMYrtS2l1SLZXRl9vijHwi5g5nMFKTG/A0FWUcXE0sQPbLanSmw==
X-Received: by 2002:a17:903:28d:b0:258:f033:3ff9 with SMTP id d9443c01a7336-29b6c6c2871mr246298975ad.48.1764250884485;
        Thu, 27 Nov 2025 05:41:24 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce441600sm18934875ad.29.2025.11.27.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:41:24 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
Subject: [PATCH V8 0/4] Add support for QCOM SPMI PMIC5 Gen3 ADC
Date: Thu, 27 Nov 2025 19:10:32 +0530
Message-Id: <20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwMSBTYWx0ZWRfXy1/oDse+SLHD
 2G3ZgiHsZpqqbzmhWUhtvBUabkaGMD7obCE+YkIqHRrIpISdclwgOHsLgnUUDhQp0ZUiKCJRjs+
 m6a0f7nt/t6bSd12SXdPvqp9jZ+dQ6/UftEei7anQ76CcbB95bkQFZa6THUXOd9LsuPceKMvjCn
 pkQJzr+IUX6ORdKTMfw2kdvV+cm7s5N02Eh02T8o/5homhHKYqGCP1qnAV+5ofNnnicGDBSjnSR
 ehYc0/vprtKTnYt7BAWJlp2z8V211SrdOhBtZnMMuTSm59sgSmz+ZEkjNZ7WMTnX5NX3gdNep7l
 fgIMMEIq4yQBTR6fv3i4mv05wHn+AsbMGkum2r6JwsKibedwC9bKSa/oHOtAbrBcd970TktTLeu
 aLbY2bIyTPw8c2K5K3fWEHwJc2UmXw==
X-Proofpoint-GUID: cxEONFN5Geol2ZHp4jhTAslea421gK_H
X-Proofpoint-ORIG-GUID: cxEONFN5Geol2ZHp4jhTAslea421gK_H
X-Authority-Analysis: v=2.4 cv=PJoCOPqC c=1 sm=1 tr=0 ts=69285506 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=viWIYd79sBYWX3CrQfEA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270101

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same module.

Patch 1 splits out the common ADC channel properties used on older
VADC devices, which would also be reused on ADC5 Gen3, into a common 
binding file, to be referenced in Gen3 and other ADC binding files.

Patch 2 adds bindings for ADC5 Gen3 peripheral.

Patch 3 adds the main driver for ADC5 Gen3.

Patch 4 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Changes since v7:
- Based on a discussion with Krzysztof concluded here: 
  https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
  patch 1 in the previous series is updated to move ADC header files from binding to
  devicetree folders, as they contain HW constants, not exactly bindings.
  Earlier in series v7, patches 3 (Gen3 binding) and 4 (driver) were dependent on
  patch 1, as it updated the location of include/dt-bindings/iio/qcom,spmi-vadc.h,
  which was used in patches 3 and 4 for Gen3 channel macros. In v8, these macros
  will be added in other new files, so the former patch 1 will now be a standalone
  change separate from this series, as the other patches here are no longer
  dependent on it.
- Patches 2/3/4/5 of v7 are now patches 1/2/3/4 in v8. Below comments refer to
  v7 patch numbers.
- Updated description of `reg` property in patch 2 to completely drop mentions of binding
  file paths, to simplify it and avoid any dependencies with patch 1.
- Dropped all ADC channel macro definitions from patch 3, updated binding example
  correspondingly and fixed formatting inconsistancies in property names, to address
  Krzysztof's comments.
- Addressed all comments from Jonathan in driver patches 4 and 5, for fixing formatting
  and refactoring some code.
- In patch 4, added ADC5 Gen3 channel macros in qcom-adc5-gen3-common.h, for use in main
  driver file. Also added a check to fail probe in case ADC channel value obtained
  from devicetree is not among list of supported channels.
- More details about all changes are present in per-patch change logs.
- Link to v7: https://lore.kernel.org/all/20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com/

Changes since v6:
- Collected Acked-by tags from Jonathan on patches 1, 2 and 3.
- Addressed Neil's comment in patch 3.
- Updated copyright to yearless one in newly added files, following new internal guidelines.
- Addressed all comments from Jonathan on patches 4 and 5 (most importantly for updating
  auxiliary device cleanup handling to fix memory freeing issues).
- More details about all changes are present in per-patch change logs.
- Link to v6: https://lore.kernel.org/all/20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com/

Changes since v5:
- Collected Reviewed-by tag from Krzysztof on patch 2.
- Addressed all comments from Krzysztof and Jonathan on patch 3.
- Addressed all comments from Jonathan on patches 4 and 5.
- More details about all changes are present in per-patch change logs.
- Link to v5: https://lore.kernel.org/all/20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com/

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
  auxiliary driver in separate patch and added required changes in main driver, as
  suggested by Dmitry.
- Link to v3: https://lore.kernel.org/all/20231231171237.3322376-1-quic_jprakash@quicinc.com/

Changes since v2:
- Reordered patches to keep cleanup change for ADC files first.
- Moved ADC5 Gen3 documentation into a separate file

Changes since v1:
- Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
- Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
- Combined patches 8-11 into a single patch as requested by reviewers to make
  the change clearer and made all fixes required in same patch.

Jishnu Prakash (4):
  dt-bindings: iio: adc: Split out QCOM VADC channel properties
  dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 151 ++++
 .../iio/adc/qcom,spmi-vadc-common.yaml        |  84 ++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  78 +-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
 drivers/iio/adc/Kconfig                       |  30 +
 drivers/iio/adc/Makefile                      |   2 +
 drivers/iio/adc/qcom-adc5-gen3-common.c       | 107 +++
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 767 ++++++++++++++++++
 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 530 ++++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 216 +++++
 12 files changed, 1902 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
 create mode 100644 drivers/iio/adc/qcom-adc5-gen3-common.c
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h


base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.25.1


