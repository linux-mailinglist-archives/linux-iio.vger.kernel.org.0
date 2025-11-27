Return-Path: <linux-iio+bounces-26510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58442C8E824
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 14:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EEE3B12C8
	for <lists+linux-iio@lfdr.de>; Thu, 27 Nov 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C8327A92D;
	Thu, 27 Nov 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N0rc3Hr/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KitFgx4m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F22773F8
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250787; cv=none; b=sRQU72lG96PvCCQTBI92XohvselJNRKGbqZ54J49YmCPi9UVMehTsaNx5M039E5ldTqIsZdikLEaXf2qGQIzC6jDy835Gy/mbkI8TBiXX47TdHxTrL+Bc3u6bFzBCbVbhyN0z0aCi/QfO2Cwn9iv5NNqIroFm9QdbJbgC5JnPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250787; c=relaxed/simple;
	bh=3fsKZwIynpZ+Wfgvqosng30KquI8zhTTb3X94cci+bg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gv+9Gp/+hgvmtAEnje9B7+nWunFxtYakXyJi1ILKJ+xVQJV3HadrQ38NbFiZvT2ow37YBE1k7w6y7V51b8jto5Jzg1fnolHVfE6G/RHjjkt1GOAculMEMaAdB7Hq4929J5FBNNtz3rOTduiNa09eegIB5yEJHEASqI1Tid6s5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N0rc3Hr/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KitFgx4m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ARA3Z8S848490
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=a746HoBjPpdKHLuXpg4gDDJOSptPTesEpWQ
	WBFRYjEs=; b=N0rc3Hr/KHO3J4/7pLZX4Z+wnxp8ouflDVHO+kHiIKZvm/84w30
	lJFosE4c6y6WNzKUbjMGetPTAhW8qsVtrBbP2Jl8NrFLa/2AYku2gREsYgt8XLrj
	6FNXZiRYDySqZitPi0+vyqgjK2SwTb93pHwRI47AMrbFeGvJstk6IL6s6RpkZJ8t
	wJZlpBqOAZdnFCZTHHzYGV9JQI4PuCQI8D+tj7XQiZFOdPyZINfcx1w8v8gyVxfy
	bHgytrGxL3IkLu5F2i1FhxXkgaS0EmikUwUBsGeQ8RXF/1/UBtRMNAjAecA4y4YX
	vdF9NNjlbaSYxjN5OipCwrI9i97ZagxYfkA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4apmjd8he2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 13:39:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2980ef53fc5so22458025ad.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Nov 2025 05:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764250783; x=1764855583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a746HoBjPpdKHLuXpg4gDDJOSptPTesEpWQWBFRYjEs=;
        b=KitFgx4m4Go79XPREWpiV+WdaUodXauFeeNFRP9ZE4oc0ci3mjENJ1zyGkxQr0Tjae
         tc0I7hCGdmty8zesLgqXXNNvdxlnqO7fCIbUGZBeoFj0PjSkRKTl6Zk4EqBrDgHlE8h9
         a1RKDOLbhBYH+gtSGGw+5HBZlcaY1fiT3I2CCeKgPArXPrHvP2KopGuqaFqiT4O5iXn5
         zgxaQOHRUrRhe3HQ1tBrarykqms0KuDbonzAizlLFSf/K0rLWdrhnz0R70KzSchZCB3H
         HrR3xBa+m+eBBTksg7flXBmsub/DX+FPbZktF8AACdTg21IwhXVEbAQDYkOAlVj9+vSB
         h3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250783; x=1764855583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a746HoBjPpdKHLuXpg4gDDJOSptPTesEpWQWBFRYjEs=;
        b=kv3D8Es3y/8TWGz1zYJ2DGSR7Jw2AJlXTB+8UXVXPYz9dSatiYYLFyuKpxGGqizzVs
         NFO1tOGTycS/NgGxRqAWe8smBmNQFyA/tyac6JNX9CxJ2Re9BsKzvy5RdxxzZQR4nCof
         i6T0TWwfQh8vQ5CRNwPO0tqb+JG35e4pW/+2ptJBYxBUJv3dUIOyHorwvlg132TYYnDS
         5Atw2Y+rmVYfuNkG1qyrh81iylBBWU1wBI5NPEvgasoFswPkbbaqTrCX7XOf9eDrP1F6
         HxgZM7dC45LdSl5jUL1yFbxNlIzbPcHQVYafSOAj0mq7TSTV2PyGBZakx3y9PgzPe2Bf
         iidg==
X-Forwarded-Encrypted: i=1; AJvYcCWv+LgR2SAZ6H2prVG4pNOW9FgtE8bwYuq1EqAEWtd8iiz3SuvzdkXZUMqJBMVi5v3cEt115Gi7LSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqmSvP++io//TINaj1JB2Ry2bw+SYSqLghjJ87sD3ErKE1MVC
	AbNj2Kg2n/w0mT2fmBhJY8twD5pprx53oBftPwgfDeY5XYNUlyxRzDkYEnilryVOv9RcVEZbeDu
	jn47UPGlmirmZPCNTmz43VRVqa4EGKIyAIseSVSc0l/kZHmeDg2aLfaCXZ4jisYWdkVYEvEQ=
X-Gm-Gg: ASbGncuh991purb+dcCdUSL/NJmqniEI/Pe+p9OY2xF0TuQsrbt9R+yHOiW9AEMJFbQ
	3ppWkEwQXRlQaZmsAtwCy70AWsWgnar5yt/BMBpSJmjIQE0B7qiE+zgt42XJOgszd1JLsbrutju
	NMSuvpFvV19Bl2Z8C8vess3o5smQDkEzgQuSE+UVPAtx5yjb0LSVv9yc1koEplEP2PVb3BHFXgR
	m09Wkr3CngY5lXVt4eIL8IEJjEzRL7d6zyJEtxGZ0UWD9H92Vu9GChhMZYwzs8Yl0qdVB8/w8tc
	RczdENbhb9oC2kpITr69YFo+BKisL7TIsOqW1gm7/+FomDbOFyTPvStZ6yVhPLaQaUrWz+qvOBQ
	uHCs9RWCnI4tRAtz2mtzh9OtXhVZ8kpGVy/RJMzoQcBi5
X-Received: by 2002:a17:903:17c5:b0:299:db45:c5c4 with SMTP id d9443c01a7336-29b6c6a7ea4mr208009785ad.43.1764250781728;
        Thu, 27 Nov 2025 05:39:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGep6TMcEFltK3WwIM3Tb5RI7Ki1kSk+hCSVe5IBk8zt8RPKIv+3xGltAt2a2SXgAvT42Muew==
X-Received: by 2002:a17:903:17c5:b0:299:db45:c5c4 with SMTP id d9443c01a7336-29b6c6a7ea4mr208009075ad.43.1764250780923;
        Thu, 27 Nov 2025 05:39:40 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb277ebsm18718045ad.56.2025.11.27.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 05:39:40 -0800 (PST)
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
Subject: [PATCH V8] dt-bindings: iio/adc: Move QCOM ADC channel definitions out of bindings folder
Date: Thu, 27 Nov 2025 19:09:03 +0530
Message-Id: <20251127133903.208760-1-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tGFfGEJw7xDc2za5fnOrkySUIbt6HsvD
X-Proofpoint-ORIG-GUID: tGFfGEJw7xDc2za5fnOrkySUIbt6HsvD
X-Authority-Analysis: v=2.4 cv=OPcqHCaB c=1 sm=1 tr=0 ts=6928549f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=6H0WHjuAAAAA:8
 a=bBqXziUQAAAA:8 a=tVI0ZWmoAAAA:8 a=40pjNWuwAAAA:8 a=pGLkceISAAAA:8
 a=6JNkVIPldkqgYOV5HcQA:9 a=AdyW9vzJdLbJGBty:21 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22 a=Soq9LBFxuPC4vsCAQt-j:22 a=BjKv_IHbNJvPKzgot4uq:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=coQwfJANHVg1YNGTr4By:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwMSBTYWx0ZWRfXxPf2Xm00FbSX
 Kmivj6OOVw39rwnvcxAEtjwJy9yJCqALhbDtg61oG1/NZWYtpF0No+B1US6VxADyAOoyifyoAgt
 4r64v8rqDJ0eOVgXtTdWfFf3uCNrD4qUhUsFIv6vgz+HRv10+CN0ORkc6BIl4MW9i+3sWuFdXnX
 wV/pi4SJVKDEOuia3trtp8/z0q6O2t9tclCZaMd2Tgx0HvwfdPlR/0bhHXVv7VmuHcO399BNqtz
 pbKZ2do3WiGxUoC5W+r00pWt2ZYNU2SdYv5HxAUB1wegqWsniL1Gc7R0h4q/0AMWdTheomLpfoE
 iOrT/1frWJYNCeWf77Tq+bWtUMrU/PKG4YjO591+3U7nEYhy2jHZ6E8szlwy8arSjUnydqa1ZwE
 4qorayMRl9UPQ2FNtTepE0w6Sv3R1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270101

There are several header files containing QCOM ADC macros for channel names
right now in the include/dt-bindings/iio folder. Since these are hardware
constants mostly used in devicetree and not exactly bindings, move the
files to the arch/arm(64)/boot/dts/qcom folders.

Correct the header file paths in all affected devicetree files to fix
compilation errors seen with this move. Update documentation files
similarly to fix dtbinding check errors for the same. Make a copy
of the header file with constants used in ADC driver files in the
/include/linux/iio/adc folder and update driver files to use this
path to include it.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v7:
- Based on a discussion with Krzysztof concluded here: 
  https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
  moved ADC macro header files to arch/arm(64)/boot/dts/qcom folders. The file
  include/dt-bindings/iio/qcom,spmi-vadc.h is moved to arch/arm/boot/dts/qcom/
  as it is used in both arm and arm64 SoCs and other per-PMIC adc7 header files
  are moved to arch/arm64/boot/dts/qcom.
- Updated affected devicetree and documentation files based on path changes above.
- Made a copy of qcom,spmi-vadc.h in /include/linux/iio/adc folder
  for inclusion in ADC driver files and updated affected driver files to use it.
- Dropped Acked-by tags from Lee, Rob and Jonathan due to these significant changes
  made in latest patch version.
- Updated some more devicetree files affected by this change.
- Pushing this as a standalone change separate from ADC5 Gen3 series, as that
  series will no longer depend upon this patch for the location of
  qcom,spmi-vadc.h, as ADC5 Gen3 macros will be added in separate new files.
- Link to v7: https://lore.kernel.org/all/20250826083657.4005727-2-jishnu.prakash@oss.qualcomm.com/

Changes since v6:
- Collected Acked-by tag from Jonathan.

Changes since v5:
- Updated one more devicetree file requiring this change.
  Ran full dt_binding_check and dtbs_check and verified that no
  errors were reported related to this patch.

  Mentioning this explicitly as there was an invalid error reported on
  this patch in the last two patch series, from upstream kernel
  automation:

  fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory

  The error is invalid as this file does get added in this patch, in
  previous patch series too.

  Links to discussion for same in v5:
  https://lore.kernel.org/all/cc328ade-a05e-4b1d-a8f0-55b18b4a0873@oss.qualcomm.com/
  https://lore.kernel.org/all/9f24e85d-f762-4c29-a58f-ed7652f50919@oss.qualcomm.com/

  Links to discussion for same in v4:
  https://lore.kernel.org/all/16aaae04-4fe8-4227-9374-0919960a4ca2@quicinc.com/

Changes since v4:
- Updated some more devicetree files requiring this change.

Changes since v3:
- Updated files affected by adc file path change in /arch/arm, which
  were missed earlier. Updated some more new devicetree files requiring
  this change in /arch/arm64.

Changes since v2:
- Updated some more new devicetree files requiring this change.
- Collected Acked-by tags from Rob and Lee.

 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   4 +-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   2 +-
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml |   2 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |   6 +-
 arch/arm/boot/dts/qcom/pm8226.dtsi            |   2 +-
 arch/arm/boot/dts/qcom/pm8941.dtsi            |   3 +-
 arch/arm/boot/dts/qcom/pma8084.dtsi           |   2 +-
 arch/arm/boot/dts/qcom/pmx55.dtsi             |   2 +-
 .../arm/boot/dts/qcom}/qcom,spmi-vadc.h       |   0
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
 .../dts/qcom/qcm6490-particle-tachyon.dts     |   4 +-
 .../boot/dts/qcom/qcm6490-shift-otter.dts     |   4 +-
 .../boot/dts/qcom}/qcom,spmi-adc7-pm7325.h    |   2 +-
 .../boot/dts/qcom}/qcom,spmi-adc7-pm8350.h    |   2 +-
 .../boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h   |   2 +-
 .../boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h   |   2 +-
 .../boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h   |   2 +-
 .../boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h   |   2 +-
 .../boot/dts/qcom}/qcom,spmi-adc7-smb139x.h   |   2 +-
 .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     |   4 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  |   4 +-
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
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts       |   9 +-
 drivers/iio/adc/qcom-spmi-adc5.c              |   3 +-
 drivers/iio/adc/qcom-spmi-vadc.c              |   3 +-
 include/linux/iio/adc/qcom,spmi-vadc.h        | 303 ++++++++++++++++++
 56 files changed, 374 insertions(+), 73 deletions(-)
 rename {include/dt-bindings/iio => arch/arm/boot/dts/qcom}/qcom,spmi-vadc.h (100%)
 rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm7325.h (98%)
 rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350.h (98%)
 rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pm8350b.h (99%)
 rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmk8350.h (98%)
 rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735a.h (96%)
 rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-pmr735b.h (96%)
 rename {include/dt-bindings/iio => arch/arm64/boot/dts/qcom}/qcom,spmi-adc7-smb139x.h (93%)
 create mode 100644 include/linux/iio/adc/qcom,spmi-vadc.h

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index b9dc04b0d307..0860243819f6 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -276,8 +276,8 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <arm64/qcom/qcom,spmi-adc7-pmk8350.h>
+    #include <arm64/qcom/qcom,spmi-adc7-pm8350.h>
 
     pmic {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 65c80e3b4500..13aad037aed0 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -278,8 +278,8 @@ examples:
     #include <dt-bindings/input/input.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
     #include <dt-bindings/spmi/spmi.h>
+    #include <arm/qcom/qcom,spmi-vadc.h>
 
     pmic@0 {
         compatible = "qcom,pm6150", "qcom,spmi-pmic";
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
index bfad8130a042..a0bc535a815a 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
@@ -110,8 +110,8 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <arm/qcom/qcom,spmi-vadc.h>
 
     pmic {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 4470a5942fb2..9e8577f9cd18 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -163,8 +163,8 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <arm/qcom/qcom,spmi-vadc.h>
 
     pmic {
         #address-cells = <1>;
@@ -204,9 +204,9 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <arm64/qcom/qcom,spmi-adc7-pmk8350.h>
+    #include <arm64/qcom/qcom,spmi-adc7-pm8350.h>
 
     pmic {
         #address-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom/pm8226.dtsi b/arch/arm/boot/dts/qcom/pm8226.dtsi
index 2fd4f135ed84..b46d29ba152a 100644
--- a/arch/arm/boot/dts/qcom/pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8226.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: BSD-3-Clause
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include "qcom,spmi-vadc.h"
 
 / {
 	thermal-zones {
diff --git a/arch/arm/boot/dts/qcom/pm8941.dtsi b/arch/arm/boot/dts/qcom/pm8941.dtsi
index aca0052a02b7..a10aa9c815a5 100644
--- a/arch/arm/boot/dts/qcom/pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8941.dtsi
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-
+#include "qcom,spmi-vadc.h"
 
 / {
 	thermal-zones {
diff --git a/arch/arm/boot/dts/qcom/pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
index 309f5256754b..469e15e203a9 100644
--- a/arch/arm/boot/dts/qcom/pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom/pma8084.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include "qcom,spmi-vadc.h"
 
 &spmi_bus {
 
diff --git a/arch/arm/boot/dts/qcom/pmx55.dtsi b/arch/arm/boot/dts/qcom/pmx55.dtsi
index da0851173c69..00204d1d40da 100644
--- a/arch/arm/boot/dts/qcom/pmx55.dtsi
+++ b/arch/arm/boot/dts/qcom/pmx55.dtsi
@@ -5,9 +5,9 @@
  * Copyright (c) 2020, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include "qcom,spmi-vadc.h"
 
 &spmi_bus {
 	pmic@8 {
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/arch/arm/boot/dts/qcom/qcom,spmi-vadc.h
similarity index 100%
rename from include/dt-bindings/iio/qcom,spmi-vadc.h
rename to arch/arm/boot/dts/qcom/qcom,spmi-vadc.h
diff --git a/arch/arm64/boot/dts/qcom/pm4125.dtsi b/arch/arm64/boot/dts/qcom/pm4125.dtsi
index cf8c822e80ce..dfe0e003d3bb 100644
--- a/arch/arm64/boot/dts/qcom/pm4125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm4125.dtsi
@@ -3,10 +3,10 @@
  * Copyright (c) 2023, Linaro Ltd
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pmic@0 {
diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index d0db28336fa9..cb0e7672e497 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 59524609fb1e..a4aae35f97f3 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -3,11 +3,11 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 334f976f1154..d343f5c8604e 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -3,9 +3,9 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 156b2ddff0dc..541544191d01 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -3,11 +3,11 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 3f8b9eafe164..136848e44ab5 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -3,11 +3,11 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 0761e6b5fd8d..48e4971b375d 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -3,9 +3,9 @@
  * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index d2568686a098..c75925abae52 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -7,7 +7,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 3f7b0b6a1d10..8c08c9acd5e0 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -4,9 +4,9 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 3911d6d0d2e2..bbe2f275c421 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -4,9 +4,9 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index f8e4829ff7f7..9f730b4621d2 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8937.dtsi b/arch/arm64/boot/dts/qcom/pm8937.dtsi
index 77809c3534a7..7e11fed735f6 100644
--- a/arch/arm64/boot/dts/qcom/pm8937.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8937.dtsi
@@ -3,9 +3,9 @@
  * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index ed72c6101813..1475873cee7a 100644
--- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -5,11 +5,11 @@
  * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pmic@0 {
diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index 64258505f9ba..1d7ee6de6168 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 353e4a6bd088..f531e59c3a3c 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 3ecb330590e5..52272250ef9e 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright 2018 Google LLC. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index 8c899d148e46..dc4e7f7d4713 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -3,9 +3,9 @@
  * Copyright (C) 2023 Luca Weiss <luca@z3ntu.xyz>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 5bd91a5cd124..e364ab2d5529 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pmic@2 {
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index 5084de66fc46..f2c0d1d7c8cc 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -6,7 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
index 0d0a846ac8d9..43cbc3a8e49f 100644
--- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pmic@0 {
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 3f9100c7eff4..1e5b89137682 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -5,8 +5,8 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/input/linux-event-codes.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 455e5c9bb072..df4e4aa19260 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -9,8 +9,6 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -21,6 +19,8 @@
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi" /* PM7350C */
 #include "pmk8350.dtsi" /* PMK7325 */
+#include "qcom,spmi-adc7-pm7325.h"
+#include "qcom,spmi-adc7-pmk8350.h"
 
 /delete-node/ &rmtfs_mem;
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts b/arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts
index bf18c4852081..ee461aec98e8 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts
@@ -6,14 +6,14 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "kodiak.dtsi"
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
+#include "qcom,spmi-adc7-pmk8350.h"
+#include "qcom,spmi-adc7-pm7325.h"
 
 /delete-node/ &ipa_fw_mem;
 /delete-node/ &rmtfs_mem;
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index 797f37596bf1..2d938cfa3f65 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -9,8 +9,6 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -19,6 +17,8 @@
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi" /* PM7350C */
 #include "pmk8350.dtsi" /* PMK7325 */
+#include "qcom,spmi-adc7-pm7325.h"
+#include "qcom,spmi-adc7-pmk8350.h"
 
 /delete-node/ &rmtfs_mem;
 
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm7325.h
similarity index 98%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
rename to arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm7325.h
index 96908014e09e..3b7fff3171db 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
+++ b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm7325.h
@@ -10,7 +10,7 @@
 #define PM7325_SID					1
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 /* ADC channels for PM7325_ADC for PMIC7 */
 #define PM7325_ADC7_REF_GND			(PM7325_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm8350.h
similarity index 98%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
rename to arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm8350.h
index 5d98f7d48a1e..6d5bf734a1bd 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
+++ b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm8350.h
@@ -6,7 +6,7 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8350_ADC for PMIC7 */
 #define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm8350b.h
similarity index 99%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
rename to arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm8350b.h
index 57c7977666d3..8cbb5204b9eb 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
+++ b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pm8350b.h
@@ -10,7 +10,7 @@
 #define PM8350B_SID					3
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8350B_ADC for PMIC7 */
 #define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmk8350.h
similarity index 98%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
rename to arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmk8350.h
index 3d1a41a22cef..b49a013349f2 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
+++ b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmk8350.h
@@ -10,7 +10,7 @@
 #define PMK8350_SID					0
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 /* ADC channels for PMK8350_ADC for PMIC7 */
 #define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmr735a.h
similarity index 96%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
rename to arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmr735a.h
index c5adfa82b20d..b483e2198aee 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
+++ b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmr735a.h
@@ -10,7 +10,7 @@
 #define PMR735A_SID					4
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 /* ADC channels for PMR735A_ADC for PMIC7 */
 #define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmr735b.h
similarity index 96%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
rename to arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmr735b.h
index fdb8dd9ae541..f793e1ebc28e 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
+++ b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-pmr735b.h
@@ -10,7 +10,7 @@
 #define PMR735B_SID					5
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 /* ADC channels for PMR735B_ADC for PMIC7 */
 #define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-smb139x.h
similarity index 93%
rename from include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
rename to arch/arm64/boot/dts/qcom/qcom,spmi-adc7-smb139x.h
index c0680d1285cf..db901d1405dd 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
+++ b/arch/arm64/boot/dts/qcom/qcom,spmi-adc7-smb139x.h
@@ -6,7 +6,7 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 #define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
 #define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index bb5a42b038f1..bfe538086beb 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -9,8 +9,6 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -20,6 +18,8 @@
 #include "pm8350c.dtsi" /* PM7350C */
 #include "pmk8350.dtsi" /* PMK7325 */
 #include "qcs6490-audioreach.dtsi"
+#include "qcom,spmi-adc7-pmk8350.h"
+#include "qcom,spmi-adc7-pm7325.h"
 
 /delete-node/ &adsp_mem;
 /delete-node/ &cdsp_mem;
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index f29a352b0288..ae3c5c5158a7 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -9,8 +9,6 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -19,6 +17,8 @@
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
+#include "qcom,spmi-adc7-pmk8350.h"
+#include "qcom,spmi-adc7-pm7325.h"
 #include "qcs6490-audioreach.dtsi"
 
 /delete-node/ &ipa_fw_mem;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 3103f94cd685..957c20a7a1fa 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include "qcom,spmi-adc7-pmr735a.h"
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 8cac4ce9c851..62dc9edef018 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -5,12 +5,12 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include "kodiak.dtsi"
 #include "pm7325.dtsi"
 #include "pm8350c.dtsi"
 #include "pmk8350.dtsi"
+#include "qcom,spmi-adc7-pmk8350.h"
 
 #include "sc7280-chrome-common.dtsi"
 #include "sc7280-herobrine-lte-sku.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 469a5d103e3d..cfc38ec8fe1b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -11,12 +11,12 @@
  * Copyright 2022 Google LLC.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "kodiak.dtsi"
+#include "qcom,spmi-adc7-pmk8350.h"
+#include "qcom,spmi-adc7-pmr735a.h"
 
 /* PMICs depend on spmi_bus label and so must come after SoC */
 #include "pm7325.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
index 451c9b984f1f..57547a2487c0 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
@@ -7,7 +7,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <arm/qcom/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 9819454abe13..a29ce1f8553b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
@@ -11,12 +11,12 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/phy/phy.h>
+#include "qcom,spmi-adc7-pm8350.h"
 
 #include "sc8280xp.dtsi"
 #include "sc8280xp-pmics.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index d84ca010ab9d..e3268abbb401 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -6,12 +6,12 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "qcom,spmi-adc7-pm8350.h"
 
 #include "sc8280xp.dtsi"
 #include "sc8280xp-pmics.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index 00bbeeef6f14..f7e4f6100c78 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -8,11 +8,11 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "qcom,spmi-adc7-pm8350.h"
 
 #include "sc8280xp.dtsi"
 #include "sc8280xp-pmics.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 307df1d3dcd2..0a39146d7235 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -3,12 +3,12 @@
  * Copyright (c) 2022, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
+#include "qcom,spmi-adc7-pm8350.h"
+#include "qcom,spmi-adc7-pmk8350.h"
+#include "qcom,spmi-adc7-pmr735a.h"
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 4afbab570ca1..b8d50a7bbbd9 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -14,13 +14,13 @@
 
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/usb/pd.h>
+#include "qcom,spmi-adc7-pmk8350.h"
 #include "sm7225.dtsi"
 #include "pm6150l.dtsi"
 #include "pm6350.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
index cb59c122f6f6..851770ebfc24 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
@@ -8,14 +8,14 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
+#include "qcom,spmi-adc7-pm7325.h"
+#include "qcom,spmi-adc7-pm8350b.h"
+#include "qcom,spmi-adc7-pmk8350.h"
 
 #include "sm7325.dtsi"
 #include "pm7325.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 268ae0cd642a..36e367b2e7cf 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -6,11 +6,12 @@
 /dts-v1/;
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include "qcom,spmi-adc7-pm8350.h"
+#include "qcom,spmi-adc7-pm8350b.h"
+#include "qcom,spmi-adc7-pmk8350.h"
+#include "qcom,spmi-adc7-pmr735a.h"
+
 #include "sm8450.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350b.dtsi"
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index af3c2f659f5e..36b8860aa5bc 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom,spmi-vadc.h>
 #include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -20,8 +21,6 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
-
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
 #define ADC5_USR_STATUS1_CONV_FAULT		BIT(7)
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 00a7f0982025..3b24f63d7dee 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -7,6 +7,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/iio/adc/qcom,spmi-vadc.h>
 #include <linux/iio/adc/qcom-vadc-common.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -20,8 +21,6 @@
 #include <linux/slab.h>
 #include <linux/log2.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
-
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
 #define VADC_REVISION2_SUPPORTED_VADC		1
diff --git a/include/linux/iio/adc/qcom,spmi-vadc.h b/include/linux/iio/adc/qcom,spmi-vadc.h
new file mode 100644
index 000000000000..c69b4fea65b0
--- /dev/null
+++ b/include/linux/iio/adc/qcom,spmi-vadc.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_SPMI_VADC_H
+#define QCOM_SPMI_VADC_H
+
+/* Voltage ADC channels */
+#define VADC_USBIN				0x00
+#define VADC_DCIN				0x01
+#define VADC_VCHG_SNS				0x02
+#define VADC_SPARE1_03				0x03
+#define VADC_USB_ID_MV				0x04
+#define VADC_VCOIN				0x05
+#define VADC_VBAT_SNS				0x06
+#define VADC_VSYS				0x07
+#define VADC_DIE_TEMP				0x08
+#define VADC_REF_625MV				0x09
+#define VADC_REF_1250MV				0x0a
+#define VADC_CHG_TEMP				0x0b
+#define VADC_SPARE1				0x0c
+#define VADC_SPARE2				0x0d
+#define VADC_GND_REF				0x0e
+#define VADC_VDD_VADC				0x0f
+
+#define VADC_P_MUX1_1_1				0x10
+#define VADC_P_MUX2_1_1				0x11
+#define VADC_P_MUX3_1_1				0x12
+#define VADC_P_MUX4_1_1				0x13
+#define VADC_P_MUX5_1_1				0x14
+#define VADC_P_MUX6_1_1				0x15
+#define VADC_P_MUX7_1_1				0x16
+#define VADC_P_MUX8_1_1				0x17
+#define VADC_P_MUX9_1_1				0x18
+#define VADC_P_MUX10_1_1			0x19
+#define VADC_P_MUX11_1_1			0x1a
+#define VADC_P_MUX12_1_1			0x1b
+#define VADC_P_MUX13_1_1			0x1c
+#define VADC_P_MUX14_1_1			0x1d
+#define VADC_P_MUX15_1_1			0x1e
+#define VADC_P_MUX16_1_1			0x1f
+
+#define VADC_P_MUX1_1_3				0x20
+#define VADC_P_MUX2_1_3				0x21
+#define VADC_P_MUX3_1_3				0x22
+#define VADC_P_MUX4_1_3				0x23
+#define VADC_P_MUX5_1_3				0x24
+#define VADC_P_MUX6_1_3				0x25
+#define VADC_P_MUX7_1_3				0x26
+#define VADC_P_MUX8_1_3				0x27
+#define VADC_P_MUX9_1_3				0x28
+#define VADC_P_MUX10_1_3			0x29
+#define VADC_P_MUX11_1_3			0x2a
+#define VADC_P_MUX12_1_3			0x2b
+#define VADC_P_MUX13_1_3			0x2c
+#define VADC_P_MUX14_1_3			0x2d
+#define VADC_P_MUX15_1_3			0x2e
+#define VADC_P_MUX16_1_3			0x2f
+
+#define VADC_LR_MUX1_BAT_THERM			0x30
+#define VADC_LR_MUX2_BAT_ID			0x31
+#define VADC_LR_MUX3_XO_THERM			0x32
+#define VADC_LR_MUX4_AMUX_THM1			0x33
+#define VADC_LR_MUX5_AMUX_THM2			0x34
+#define VADC_LR_MUX6_AMUX_THM3			0x35
+#define VADC_LR_MUX7_HW_ID			0x36
+#define VADC_LR_MUX8_AMUX_THM4			0x37
+#define VADC_LR_MUX9_AMUX_THM5			0x38
+#define VADC_LR_MUX10_USB_ID			0x39
+#define VADC_AMUX_PU1				0x3a
+#define VADC_AMUX_PU2				0x3b
+#define VADC_LR_MUX3_BUF_XO_THERM		0x3c
+
+#define VADC_LR_MUX1_PU1_BAT_THERM		0x70
+#define VADC_LR_MUX2_PU1_BAT_ID			0x71
+#define VADC_LR_MUX3_PU1_XO_THERM		0x72
+#define VADC_LR_MUX4_PU1_AMUX_THM1		0x73
+#define VADC_LR_MUX5_PU1_AMUX_THM2		0x74
+#define VADC_LR_MUX6_PU1_AMUX_THM3		0x75
+#define VADC_LR_MUX7_PU1_AMUX_HW_ID		0x76
+#define VADC_LR_MUX8_PU1_AMUX_THM4		0x77
+#define VADC_LR_MUX9_PU1_AMUX_THM5		0x78
+#define VADC_LR_MUX10_PU1_AMUX_USB_ID		0x79
+#define VADC_LR_MUX3_BUF_PU1_XO_THERM		0x7c
+
+#define VADC_LR_MUX1_PU2_BAT_THERM		0xb0
+#define VADC_LR_MUX2_PU2_BAT_ID			0xb1
+#define VADC_LR_MUX3_PU2_XO_THERM		0xb2
+#define VADC_LR_MUX4_PU2_AMUX_THM1		0xb3
+#define VADC_LR_MUX5_PU2_AMUX_THM2		0xb4
+#define VADC_LR_MUX6_PU2_AMUX_THM3		0xb5
+#define VADC_LR_MUX7_PU2_AMUX_HW_ID		0xb6
+#define VADC_LR_MUX8_PU2_AMUX_THM4		0xb7
+#define VADC_LR_MUX9_PU2_AMUX_THM5		0xb8
+#define VADC_LR_MUX10_PU2_AMUX_USB_ID		0xb9
+#define VADC_LR_MUX3_BUF_PU2_XO_THERM		0xbc
+
+#define VADC_LR_MUX1_PU1_PU2_BAT_THERM		0xf0
+#define VADC_LR_MUX2_PU1_PU2_BAT_ID		0xf1
+#define VADC_LR_MUX3_PU1_PU2_XO_THERM		0xf2
+#define VADC_LR_MUX4_PU1_PU2_AMUX_THM1		0xf3
+#define VADC_LR_MUX5_PU1_PU2_AMUX_THM2		0xf4
+#define VADC_LR_MUX6_PU1_PU2_AMUX_THM3		0xf5
+#define VADC_LR_MUX7_PU1_PU2_AMUX_HW_ID		0xf6
+#define VADC_LR_MUX8_PU1_PU2_AMUX_THM4		0xf7
+#define VADC_LR_MUX9_PU1_PU2_AMUX_THM5		0xf8
+#define VADC_LR_MUX10_PU1_PU2_AMUX_USB_ID	0xf9
+#define VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM	0xfc
+
+/* ADC channels for SPMI PMIC5 */
+
+#define ADC5_REF_GND				0x00
+#define ADC5_1P25VREF				0x01
+#define ADC5_VREF_VADC				0x02
+#define ADC5_VREF_VADC5_DIV_3			0x82
+#define ADC5_VPH_PWR				0x83
+#define ADC5_VBAT_SNS				0x84
+#define ADC5_VCOIN				0x85
+#define ADC5_DIE_TEMP				0x06
+#define ADC5_USB_IN_I				0x07
+#define ADC5_USB_IN_V_16			0x08
+#define ADC5_CHG_TEMP				0x09
+#define ADC5_BAT_THERM				0x0a
+#define ADC5_BAT_ID				0x0b
+#define ADC5_XO_THERM				0x0c
+#define ADC5_AMUX_THM1				0x0d
+#define ADC5_AMUX_THM2				0x0e
+#define ADC5_AMUX_THM3				0x0f
+#define ADC5_AMUX_THM4				0x10
+#define ADC5_AMUX_THM5				0x11
+#define ADC5_GPIO1				0x12
+#define ADC5_GPIO2				0x13
+#define ADC5_GPIO3				0x14
+#define ADC5_GPIO4				0x15
+#define ADC5_GPIO5				0x16
+#define ADC5_GPIO6				0x17
+#define ADC5_GPIO7				0x18
+#define ADC5_SBUx				0x99
+#define ADC5_MID_CHG_DIV6			0x1e
+#define ADC5_OFF				0xff
+
+/* 30k pull-up1 */
+#define ADC5_BAT_THERM_30K_PU			0x2a
+#define ADC5_BAT_ID_30K_PU			0x2b
+#define ADC5_XO_THERM_30K_PU			0x2c
+#define ADC5_AMUX_THM1_30K_PU			0x2d
+#define ADC5_AMUX_THM2_30K_PU			0x2e
+#define ADC5_AMUX_THM3_30K_PU			0x2f
+#define ADC5_AMUX_THM4_30K_PU			0x30
+#define ADC5_AMUX_THM5_30K_PU			0x31
+#define ADC5_GPIO1_30K_PU			0x32
+#define ADC5_GPIO2_30K_PU			0x33
+#define ADC5_GPIO3_30K_PU			0x34
+#define ADC5_GPIO4_30K_PU			0x35
+#define ADC5_GPIO5_30K_PU			0x36
+#define ADC5_GPIO6_30K_PU			0x37
+#define ADC5_GPIO7_30K_PU			0x38
+#define ADC5_SBUx_30K_PU			0x39
+
+/* 100k pull-up2 */
+#define ADC5_BAT_THERM_100K_PU			0x4a
+#define ADC5_BAT_ID_100K_PU			0x4b
+#define ADC5_XO_THERM_100K_PU			0x4c
+#define ADC5_AMUX_THM1_100K_PU			0x4d
+#define ADC5_AMUX_THM2_100K_PU			0x4e
+#define ADC5_AMUX_THM3_100K_PU			0x4f
+#define ADC5_AMUX_THM4_100K_PU			0x50
+#define ADC5_AMUX_THM5_100K_PU			0x51
+#define ADC5_GPIO1_100K_PU			0x52
+#define ADC5_GPIO2_100K_PU			0x53
+#define ADC5_GPIO3_100K_PU			0x54
+#define ADC5_GPIO4_100K_PU			0x55
+#define ADC5_GPIO5_100K_PU			0x56
+#define ADC5_GPIO6_100K_PU			0x57
+#define ADC5_GPIO7_100K_PU			0x58
+#define ADC5_SBUx_100K_PU			0x59
+
+/* 400k pull-up3 */
+#define ADC5_BAT_THERM_400K_PU			0x6a
+#define ADC5_BAT_ID_400K_PU			0x6b
+#define ADC5_XO_THERM_400K_PU			0x6c
+#define ADC5_AMUX_THM1_400K_PU			0x6d
+#define ADC5_AMUX_THM2_400K_PU			0x6e
+#define ADC5_AMUX_THM3_400K_PU			0x6f
+#define ADC5_AMUX_THM4_400K_PU			0x70
+#define ADC5_AMUX_THM5_400K_PU			0x71
+#define ADC5_GPIO1_400K_PU			0x72
+#define ADC5_GPIO2_400K_PU			0x73
+#define ADC5_GPIO3_400K_PU			0x74
+#define ADC5_GPIO4_400K_PU			0x75
+#define ADC5_GPIO5_400K_PU			0x76
+#define ADC5_GPIO6_400K_PU			0x77
+#define ADC5_GPIO7_400K_PU			0x78
+#define ADC5_SBUx_400K_PU			0x79
+
+/* 1/3 Divider */
+#define ADC5_GPIO1_DIV3				0x92
+#define ADC5_GPIO2_DIV3				0x93
+#define ADC5_GPIO3_DIV3				0x94
+#define ADC5_GPIO4_DIV3				0x95
+#define ADC5_GPIO5_DIV3				0x96
+#define ADC5_GPIO6_DIV3				0x97
+#define ADC5_GPIO7_DIV3				0x98
+#define ADC5_SBUx_DIV3				0x99
+
+/* Current and combined current/voltage channels */
+#define ADC5_INT_EXT_ISENSE			0xa1
+#define ADC5_PARALLEL_ISENSE			0xa5
+#define ADC5_CUR_REPLICA_VDS			0xa7
+#define ADC5_CUR_SENS_BATFET_VDS_OFFSET		0xa9
+#define ADC5_CUR_SENS_REPLICA_VDS_OFFSET	0xab
+#define ADC5_EXT_SENS_OFFSET			0xad
+
+#define ADC5_INT_EXT_ISENSE_VBAT_VDATA		0xb0
+#define ADC5_INT_EXT_ISENSE_VBAT_IDATA		0xb1
+#define ADC5_EXT_ISENSE_VBAT_VDATA		0xb2
+#define ADC5_EXT_ISENSE_VBAT_IDATA		0xb3
+#define ADC5_PARALLEL_ISENSE_VBAT_VDATA		0xb4
+#define ADC5_PARALLEL_ISENSE_VBAT_IDATA		0xb5
+
+#define ADC5_MAX_CHANNEL			0xc0
+
+/* ADC channels for ADC for PMIC7 */
+
+#define ADC7_REF_GND				0x00
+#define ADC7_1P25VREF				0x01
+#define ADC7_VREF_VADC				0x02
+#define ADC7_DIE_TEMP				0x03
+
+#define ADC7_AMUX_THM1				0x04
+#define ADC7_AMUX_THM2				0x05
+#define ADC7_AMUX_THM3				0x06
+#define ADC7_AMUX_THM4				0x07
+#define ADC7_AMUX_THM5				0x08
+#define ADC7_AMUX_THM6				0x09
+#define ADC7_GPIO1				0x0a
+#define ADC7_GPIO2				0x0b
+#define ADC7_GPIO3				0x0c
+#define ADC7_GPIO4				0x0d
+
+#define ADC7_SMB_TEMP				0x06
+#define ADC7_CHG_TEMP				0x10
+#define ADC7_USB_IN_V_16			0x11
+#define ADC7_VDC_16				0x12
+#define ADC7_CC1_ID				0x13
+#define ADC7_VREF_BAT_THERM			0x15
+#define ADC7_IIN_FB				0x17
+#define ADC7_ICHG_SMB				0x18
+#define ADC7_IIN_SMB				0x19
+
+/* 30k pull-up1 */
+#define ADC7_AMUX_THM1_30K_PU			0x24
+#define ADC7_AMUX_THM2_30K_PU			0x25
+#define ADC7_AMUX_THM3_30K_PU			0x26
+#define ADC7_AMUX_THM4_30K_PU			0x27
+#define ADC7_AMUX_THM5_30K_PU			0x28
+#define ADC7_AMUX_THM6_30K_PU			0x29
+#define ADC7_GPIO1_30K_PU			0x2a
+#define ADC7_GPIO2_30K_PU			0x2b
+#define ADC7_GPIO3_30K_PU			0x2c
+#define ADC7_GPIO4_30K_PU			0x2d
+#define ADC7_CC1_ID_30K_PU			0x33
+
+/* 100k pull-up2 */
+#define ADC7_AMUX_THM1_100K_PU			0x44
+#define ADC7_AMUX_THM2_100K_PU			0x45
+#define ADC7_AMUX_THM3_100K_PU			0x46
+#define ADC7_AMUX_THM4_100K_PU			0x47
+#define ADC7_AMUX_THM5_100K_PU			0x48
+#define ADC7_AMUX_THM6_100K_PU			0x49
+#define ADC7_GPIO1_100K_PU			0x4a
+#define ADC7_GPIO2_100K_PU			0x4b
+#define ADC7_GPIO3_100K_PU			0x4c
+#define ADC7_GPIO4_100K_PU			0x4d
+#define ADC7_CC1_ID_100K_PU			0x53
+
+/* 400k pull-up3 */
+#define ADC7_AMUX_THM1_400K_PU			0x64
+#define ADC7_AMUX_THM2_400K_PU			0x65
+#define ADC7_AMUX_THM3_400K_PU			0x66
+#define ADC7_AMUX_THM4_400K_PU			0x67
+#define ADC7_AMUX_THM5_400K_PU			0x68
+#define ADC7_AMUX_THM6_400K_PU			0x69
+#define ADC7_GPIO1_400K_PU			0x6a
+#define ADC7_GPIO2_400K_PU			0x6b
+#define ADC7_GPIO3_400K_PU			0x6c
+#define ADC7_GPIO4_400K_PU			0x6d
+#define ADC7_CC1_ID_400K_PU			0x73
+
+/* 1/3 Divider */
+#define ADC7_GPIO1_DIV3				0x8a
+#define ADC7_GPIO2_DIV3				0x8b
+#define ADC7_GPIO3_DIV3				0x8c
+#define ADC7_GPIO4_DIV3				0x8d
+
+#define ADC7_VPH_PWR				0x8e
+#define ADC7_VBAT_SNS				0x8f
+
+#define ADC7_SBUx				0x94
+#define ADC7_VBAT_2S_MID			0x96
+
+#endif /* QCOM_SPMI_VADC_H */

base-commit: ef68bf704646690aba5e81c2f7be8d6ef13d7ad8
-- 
2.25.1


