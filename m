Return-Path: <linux-iio+bounces-27201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AFECD04A4
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F8E43005F04
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21228339879;
	Fri, 19 Dec 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H8MbEeMc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYVcs1k5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CE32D1916
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154958; cv=none; b=sIp8upelSAEU4hMwyrrUtS5mPaN2WzCmmX+VeJB7lVq2ARYPBXm911N9O9b3FstIfUeRSuP6mDhNfMrwTd6M5WRPudqJ30Y+Rh0pKS8o4s1VxI3ShOYktEo8hemCNS48Xxq1ftt3LNpE4z8+rCyTSnA6v5GUatUHX4tURpf6a2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154958; c=relaxed/simple;
	bh=yDoEuSqPknkwVP0vazPsHzAq74kjVOByu3+rGhvA4Fg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bThHxEEJgG2IJAJ4F0k3qHBALd71SlaRIxy6CFw2CaDvIqXDnHkEUap0NIAB9Cf5PV+EkJ3E2Rlw4n0dsqVSfPPUMjJd1vHzMWLvkhnj78MpJZqmtXUsEaADf7lTwUW/Neu21xrfHM4b9+TrDk+Lei+9yHRaSrZ3zgD0hY4wRzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H8MbEeMc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OYVcs1k5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJCCcNx3319255
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bdVHcop5XYNpYgY2yr+3Fk
	dwW8jh3IpYWt3xSgH8iKA=; b=H8MbEeMcDR3OAyNCv7ZbaT2jGgjxnspKFvfma+
	vScLZ9gcIKUB6mzGCGSe+SxrLuEEDnIbhO1DoJYyP7+dNsiltp4LXZv/n9omciUp
	pypqg41B//O4+bkm7RqZbiq86vn0gkxpau8mlREVwrUfL9IDtwx2A4oFyE7L43Im
	JlMVs3ZcmKnE8+hCLCoWOBwuMHZ0MQWhQ37xONF7dIS6FmijR3ekq0KhWEB3zyoi
	UIe94lKxvqPbtGJDSj8vKtJBOSVbxN6fow7n9s1gDjJt2X4sul/5TfpErnoUeCwP
	tJrAxrFfXlH1yNXXRiCjiyRZcIQB/eWgFOKuxJHxPpCZ8NnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2etwgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:35:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6ceab125so42594471cf.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 06:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154956; x=1766759756; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdVHcop5XYNpYgY2yr+3FkdwW8jh3IpYWt3xSgH8iKA=;
        b=OYVcs1k52QbPnKMA4MwxX09Y6FJusRTJhXewXZ4Jp1PPLa7iEGX7RCzb9wnn9zh4E+
         /qscc2iTyhfb49Q8Dbml0yBgMPmwEMZi2Jn/rFMsCa6JnEvM7AdIpYPS9gd9Kwwik7Rk
         kqd9NWzQL3URIJ2XEwp8w2TnaaUC3aB45EC/gGbWb6JpsHHbHd4242PiirirNRfnUJYW
         lVAViYGLePlbyu+ygwXw239u6XD3mSl2oifUVLpzXz0mDqwaKwtFHWbSgFTPjXd237Ns
         1YCT9MoBF6KSVvuc8xt+MQb1WufCz6maQyDyPWoYLyGoliIfoVOYxSA/wf8AsbP/wupW
         WZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154956; x=1766759756;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdVHcop5XYNpYgY2yr+3FkdwW8jh3IpYWt3xSgH8iKA=;
        b=DXjnJ73j7P+AOiVI1JB3EfrzCH/3z0MLH5lFRfokDgYPYpVpE1qv/OLV1WbnGApcAs
         hR1nRm7FsVNayER/PKhVej/fwcd3qLsLFa3Vr10j/WdHAgU7h9K4f3OOs4dA8aIU2Fan
         8txGtYePr8dFxB269/NRmia3SMzLMRw6uGQPBflQJLJezkQaT2pUU7u6hLhSXk67gjjb
         oN7i/xRhcpCz8ZgxsOCYyb8qRgzsE65Zdx2lKh5X3XYROI+PlqK+sfGHrWrgJfkxddQG
         xzTUvL3CnMWLhbDUszNQEQKrMkZTRMU9cVhd6xP54KlX/5ifQAJKkKZ3UMnT+5aFP4hq
         vOKg==
X-Gm-Message-State: AOJu0YxhHsKFCVXiy4a9yL6sylO+UWvjx82IbGROXGMISUDQDWH6JmM9
	ndA7ZhcVSK1h5PIV3FVM59DJ8YzhhNjlcfbejW4JWKbHt/0y7yejy9UVd/jyd2CuDIWe3XMAjUM
	e7+S3ju5sZus+LHeYGzUA3kKWui8dXKFKW9rX0NdHwGztUxOlFkyVYc27V45QMng=
X-Gm-Gg: AY/fxX5Rh56F4UvPly02qusl9Ny0F2VWNQyQaidtdHCTObYfT53Bo+AHbPeqPHa/doD
	q1eQt/8jhfBDK6apK3A4B/A6aO8NdMhVpO5KGQoj33q7QZGFXSQy/pu1mTEpi/DsgXLFa/oxTO2
	OpDrtYBU54fXro0ka5E+gRwDspnYbBY4C0SuT/M2CvEI21QeL/xC88oqls1wtHq717EFQhArPvB
	NdXk5n3DzozAcGCsyotqOKHkTzOtxiyOE6Cy1hG6T/l3EQo76WN/N1nw7qS6VLjol7HeomRHczX
	MVOZVrHtYD7Lfo4c+3fAfKonSqtFEBbONsmdNThjYWG+PYIMJbYQgJDH1iBH93HAj2l3I+XQ2Re
	hK9z167krVhgwyLYpartLV010hbhwv0jSV76BWOa8Tkx4GAda35ieOr/8wSRvXD+PeDa1
X-Received: by 2002:ac8:5d08:0:b0:4ed:ba76:a008 with SMTP id d75a77b69052e-4f4abdb4c88mr38662881cf.73.1766154955439;
        Fri, 19 Dec 2025 06:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEffbFxw8X7dSObyQoz5slOTM2CgBwKcXa5e7U5F4RvPeNF54VvXGRIgsWbtWtrOWj00iptUQ==
X-Received: by 2002:ac8:5d08:0:b0:4ed:ba76:a008 with SMTP id d75a77b69052e-4f4abdb4c88mr38662351cf.73.1766154954913;
        Fri, 19 Dec 2025 06:35:54 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:35:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/5] iio: adc: Simplify with dev_err_probe
Date: Fri, 19 Dec 2025 15:31:49 +0100
Message-Id: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVhRWkC/x3MQQqAIBBA0avErBtQU6iuEi0yp5pNyggShHdPW
 r7F/y9kEqYMc/eCUOHM8W7QfQf7td0nIYdmMMo4bfSEzBEDFSQRTBI9oZv8oJXdx2A9tC4JHfz
 8z2Wt9QO2tb1AYwAAAA==
X-Change-ID: 20251219-iio-dev-err-probe-59b3104c8d4b
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yDoEuSqPknkwVP0vazPsHzAq74kjVOByu3+rGhvA4Fg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLDVzK3BklVItpqweq/1miLacOG2Cpj1HQRt
 qYMIHAS116JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUViwwAKCRDBN2bmhouD
 1472EACOzRsssmSeIC4dDsW9cdUyuX/1DfAEF31eNrw1wC0pyBMfIWJNnL2LSlQaWhLMVwkDaRx
 Q6qs5PZ+m5HSWN0c9B1IYnCaBdkg9i1tYfZx91zD3cFo8C3sFJ4cHai7H7f0h5OmhvOyZ8FxR0l
 al06ryQgbWCkyk9k/tWLHL+q2IAlhtfGuCtZ0+fD5kpkZLoVtbbKrTKNwlVTaY+cXWQF4BIIyDV
 AMV/sIPce94hEHphyKJlCqioXya+WMGdqumincCRkLKMIeFBE/peXUw5dYNkajIMJM6xU8axA9R
 lR5qS6Vd9zzuiKbtXRwkUBxu6Iv1eQsH449ypPIU4urZxHPbWefEF8x+KFqIL8jM9LWWev1CAwJ
 uVo9yYZ46EPZiYJe+xWkunZymrftSRkCkihcfalicTpVtRcgFWH13sIFqP9XK+0nlXJ4AXngRjp
 4hS92gmbRS6+yzCsyH9TqRxujuDbowBSxua62u0DdBeX3T47ruoQmDUCcaEPA/SKd3HLoYtpSCU
 SGunXOmPp04MuDM//S4PdHiyTXk7EzNoF6JXSrC7AjaZoEuWbadPnfJGv0EEIJLHvzKkLDByrgB
 RtS/oL0QhQ6zURKrKaZrsnxmBVjr09C/uqHNhnmkj7XmZNMFWZ7b1G8b5QH0AjIGARciWoIiza4
 zNl2KZibzhmH4ZA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: cfhbald7T3uVD1OAoVRu1bA9crW3dGu7
X-Proofpoint-ORIG-GUID: cfhbald7T3uVD1OAoVRu1bA9crW3dGu7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfX8IyInmygxRLW
 H/1NyuIbccohWVfeDkF3kfMgWilPOjJsiLP9yIhWJqYc7smlJH1mnGaqUpFeTCq6a/Ecj+g1GpJ
 y4yS7pkLkrrb0otWM8hMpP0geWJrEx7IQwk9XZJ9X9ejF7SpIapeLDPTkQooFJeRnnIl3KA1x22
 nYa9jFgkvXdEeXfsArXEjY0bF2OX0JuJ6hYLAj2LQ4RqtN2VxpHIKw8u2VWKrM+qKLtaQpMKrSW
 3MWlCSSsDMKTeAWIM/GdG1hGVByLceRiUWr/QVYgjHiHzuA/fufVYlQr2NfL2vjPMd8m697jGu8
 QNy5YPabo+roz62A6UBqJxiRenMBf8QOdIzq6evrt/wxAeU1OOP4SyN0nOKfy+sZQtntXC3irWe
 zzsvznIN1jUJMPp9bih07AL1xtj4p9sbXxOroguUXzP0gX5AJYXJg2C2EU2qJAw8E6rv+3UqGzR
 NORxojg3j2e4uUKc81Q==
X-Authority-Analysis: v=2.4 cv=Tp7rRTXh c=1 sm=1 tr=0 ts=694562cc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGHnGGPHKRB7WeD4iHgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      iio: adc: aspeed: Simplify with dev_err_probe
      iio: adc: exynos: Simplify with dev_err_probe
      iio: adc: qcom-spmi-rradc: Simplify with dev_err_probe
      iio: adc: rockchip: Simplify with dev_err_probe
      iio: adc: sc27xx: Simplify with dev_err_probe

 drivers/iio/adc/aspeed_adc.c      |  9 ++++---
 drivers/iio/adc/exynos_adc.c      | 29 ++++++++---------------
 drivers/iio/adc/qcom-spmi-rradc.c | 20 ++++++----------
 drivers/iio/adc/rockchip_saradc.c | 13 ++++-------
 drivers/iio/adc/sc27xx_adc.c      | 49 ++++++++++++++-------------------------
 5 files changed, 43 insertions(+), 77 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251219-iio-dev-err-probe-59b3104c8d4b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


