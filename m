Return-Path: <linux-iio+bounces-27205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8678CD04C8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E828304A5B2
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C733AD93;
	Fri, 19 Dec 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dx6RAz2M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T8Vfu7Ii"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D9633A6ED
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154965; cv=none; b=Meg+Qw+bPNUkvUNghAVt4A+VNWyLkkP+fE9ZzIw7gKgOm6xjYcFZDqWaal6HEttlHL2BCO/nTRnuITo42lI1hWVLfikYqsxstQhtbOArd+Lx7Qt4Ouxw4f6qgoue7JlD3ElTxQSPsd3BF8vGGR4ex9Y2XA9M1uoVk8cSgIR4Y8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154965; c=relaxed/simple;
	bh=Fmnj6mVvpbfLtwijoNhLAn9j7guM9pp4HVJeADMhGe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=osFRcz6MKTbEJ8nlthXT+KMZ7qji2J4OfL0a8Pr4lYpUk4epu2Bs7N5yHS4+y+jdTK+6UXcj28dAhQQCh8rgkhSwKlmbzICfJSRPR6kqgc57B4/tfjSzxxh+GFEXpMaIWdEwFJS+PHFwlayp4I8+tC30L7cONT+TtrBG+QkmlZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dx6RAz2M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T8Vfu7Ii; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBk6BN3320433
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6KPYVk+CR22m/g5FBCc99SLHEDjfYAU2ih06ixsTGRk=; b=Dx6RAz2MmQbVOKoW
	UDi0K93jkktF0Nszi/pD8lDSsAqYLALDNIz8FwmlIXxBTLlZzeHqx4R7pTt7UhIG
	DWmkliMOf4jN/ZqpamEBz3dOcSS7LwJdW7a23TY7OZqHT94/fYay94YEaGDt2bCg
	eNWxmLyJm3NJOorIOvXcle/4rrXsHtln0vtt5DzVBlYaxJhYfeQsTUSftPurIdlQ
	CziXMC4GXW1tnfR43T+5Uy0uXJn9CEF2E3ohrI8zJzQ4kFYweHWwvMbLzqxPDzC/
	bJhfDsut1yCEbk0zbCdA4ouj3hRi0woR18qT0YgOSfXRgJG7elKeZhYay+WFtIgo
	uEmzCw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2etwhc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee09693109so33641631cf.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154962; x=1766759762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KPYVk+CR22m/g5FBCc99SLHEDjfYAU2ih06ixsTGRk=;
        b=T8Vfu7IiUP3ibsW/qX6/9AGiC5ZfqvdWjAd/zR1hsc0RJ5fKxme0nfpD5PTL6sYMxH
         seCw4S7CnHz0KJvuO3DDLyeUh4s6WPFLB1nVguaTUnG+bPV/LnkrcTXVpi7n3Wk8pN7j
         +J5oK/Ps1VLFdl0QraoehzUbUvScxcwhi/dlIjYLpDG60rrzpu1rH3LECKm9k723tf4V
         jFcmhGZwBviFfex6SXxSZN6biAiNz4BjDFozDKiabnbattVQMlEUahDlWg30WCPmVrQ9
         PpRfOlZkTlfFnypJbP3jnRdbiUzGPapGA8Vwb1kGhhkFFNeujPESiIIRcVhNUASjw1m1
         kgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154962; x=1766759762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6KPYVk+CR22m/g5FBCc99SLHEDjfYAU2ih06ixsTGRk=;
        b=AgMZY9hfJtpDRjnwGlpisZfxc62fjlShqVBdvkmeFHqWpVICoptg3wkM+imbfeOeaS
         f5gz1D52qJqlfZKjCZqniMIiiM/5SgcRCn9okkSGiazBnlbwWID7UFL+FCB/9ryrxwSA
         E9sLPpUsQ68cmcC9sQRVk2taOq9gGLzjiMsCY1VE0GDbgyESXSbxE1PCgmmyT+at99av
         g6zlus9Q9pCabOcLuEql/EDhHSQpHXK6q/q1a6wGXOpmOZjrSeloyR+CzFGk+pcYyjA6
         j1Di11JFm3dwzsitRrvtvtUrxf1GZI+7BgJCbLkC8lpUykWG4PmGfHYlqY1WDRVnNFr8
         mCdA==
X-Gm-Message-State: AOJu0YyrLVkDCrjaztaiNPO75x72Oh25SPpLkKPFI2xweYnFaSnq0hzY
	NO29GHGYMKWAzJdzXg7lcWcCOFzHm9DpHL2w3bc5oGlLESNmiYTmOBr+lWk6tBNUcELRtuTn5j3
	nd6XBJxcJE/cUgE7/RbE1ouikWxATwSgsP4jceEJwCukCgUG8EgM86YAcL/dBSRM=
X-Gm-Gg: AY/fxX4t7AnkpNrKbgxpB+tHGxsQ3qFbDHG6C3wW4HUqeZlFyCYDaGH1T0fLqkhFPTy
	6pjFcL0daxYIAEVxb9SKtK8rzXeT4+8e+YNQ6+bQYsv0BG2B5Y1FKIOviOZSluYAHNmdGAxkbTs
	g4euuXGfkzyHp3neEkZd1zCaJ/z46VimNkRaK9dwR+RhjLanukkc3TivtDWAbqv1U50IOv59eIO
	0u/lPH1ZYmeBQGgl7MANFeLHhahfjatyYOMRNxVLQ3U5uO8wreHqcmGn8p01/coOS3OuGgNFqqo
	zEaGXoAH4B7XjHZzeF6lvdqol/S7gDZgCiDiqQZHShnINMMZxy9Ydc7rfHI0FvIfAPgcFjGzJUv
	bG9onSz0f3P6fRR6i8maLhsTBfNZ43nfptV7EddjpmnErkvHg0wHdCoKtIsdcccrlf4zP
X-Received: by 2002:a05:622a:5909:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4f4abd0cafbmr40586001cf.30.1766154962203;
        Fri, 19 Dec 2025 06:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf/8P/7gffTggqaLL7XA+UX+u7FNuz6BrjE8UubcGAq9Jn0DzHD2i139MD/SRvhbhO2DTJMw==
X-Received: by 2002:a05:622a:5909:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4f4abd0cafbmr40585381cf.30.1766154961735;
        Fri, 19 Dec 2025 06:36:01 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:36:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:53 +0100
Subject: [PATCH 4/5] iio: adc: rockchip: Simplify with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-iio-dev-err-probe-v1-4-bd0fbc83c8a0@oss.qualcomm.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
In-Reply-To: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1502;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Fmnj6mVvpbfLtwijoNhLAn9j7guM9pp4HVJeADMhGe0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLH1EFl2sCBthzt79pkShZZiMmOVlFkKcQCW
 mlR1bgxXBeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVixwAKCRDBN2bmhouD
 1yneEACQf/jyEI6/m6DrHaosqP0fY91Xp3YLGPZnm/1USifaPKrakFkvixtn0eSGYllX4PXMDgd
 duf5nq+PPq67Mbt2J6GvQ80K55z+C99pMr/xL1KxwOqk7vbu18uyryGnjYDo/O3ra1OFDJUCBL1
 xbEmsfWqd15AUJcY74qMPZW30zYCuLScdNNvhWpQvsURFVXzruPmXAUEA1LZDkD13KfhiF+4hd6
 0+cey9A7YbrHXZuLIjkq+EKDRu5c1HY7nFEXeRjZG/VdRpNHnnrZOYLeoSg89UD3d9zHAoAIlC6
 k2HwnIcyCIoM1VTZcC0v71LYPm9FtsIMbZ94VyqS7JIzAkn9JWACeavbmC8utEloLZ1sdxRA5fw
 j+nj7Ugdy0niu9678mY+/hCHp0pGpfxC4S5L2uAkyze9Be1VsT/nJ8+rY7+yrfcULh0awxpWvCY
 yq3qH+6xgGymoG7C/DWWg1p2Tc2UT5VXyB1wlUZ3Dy7rs1t6MPOoW0m6Y8GpIoqbxKl95Ot07Ql
 yxXnHOIsTgub0fbyrI3uwQNMn2b2HkGofj5xJHACHWk+TZRseG+oRZoNhk6gO/t5QSrT80IQCqV
 dapzjsOgJWWyp4u5wm7f/aXgCFoj+c/zRYy4LBpWkRFxP+7dqmmB8UObF1SIb2AyV0JQKEvlVEB
 VKH7vTQ/hvVYXJA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: 2VSO9wszp4BVBZNAic2oOEuKM_shxCxb
X-Proofpoint-ORIG-GUID: 2VSO9wszp4BVBZNAic2oOEuKM_shxCxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfXyhpiRBRjEUBn
 GqXSgW9Sacsx3KETSu26Mx+in0iK2O61TXvKU61+gvKTRgk6hUesvFJulvVumS4iqYOuymFVVFl
 dWWFcNpZGx390KhPMiPjisTYPzUIdgj7CeEKf7UO0UkjucFfhSkGI6kEjRa4PHigEH7hIj4OrXd
 2pQF3z/QPXmJFCF+RXLxCZqFByniXQr1X3KRwipjoMst5Z3CGouHel8tiDi3QakJXdBEFF0MFEl
 EDZsN5sotXqs7pgo330AiSDRF7vcowUliorftUsWkXLTAWW1ElL8leHehssnFwTtaypVyxvyo8k
 pCe1y1m49POyz/B+JzOD/JxCL0/37HD08F/Kt2TaVcSr+Kd5XeeTTORGfk9qumfMLYaeXgsXmSU
 /ahpW4Zo40UWRdew9ilLnVRfLZMtguRQam8MIyxUDIkI6IJitLJYajMMuhp8RC5sXSx25V8RWRu
 f/4hYxGSmHAQPYyGZjQ==
X-Authority-Analysis: v=2.4 cv=Tp7rRTXh c=1 sm=1 tr=0 ts=694562d3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UodCGf9HWxkVo1034I8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/rockchip_saradc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 6721da0ed7bb..263d80c5fc50 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -492,10 +492,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	 */
 	info->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								"saradc-apb");
-	if (IS_ERR(info->reset)) {
-		ret = PTR_ERR(info->reset);
-		return dev_err_probe(&pdev->dev, ret, "failed to get saradc-apb\n");
-	}
+	if (IS_ERR(info->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->reset),
+				     "failed to get saradc-apb\n");
 
 	init_completion(&info->completion);
 
@@ -505,10 +504,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
 			       0, dev_name(&pdev->dev), info);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq %d\n", irq);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed requesting irq %d\n", irq);
 
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(info->vref))

-- 
2.51.0


