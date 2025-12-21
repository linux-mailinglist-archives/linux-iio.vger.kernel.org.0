Return-Path: <linux-iio+bounces-27272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF55CD4168
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 15:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1A5B3005AAA
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489FB2FE078;
	Sun, 21 Dec 2025 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESqqQSPk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L7vBAQm1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA132FD7BC
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766327191; cv=none; b=PXAicCkmDg298B32dM9Age0zPuXRutV10aS80tsW1H1+0T8iAvz5AnIfr5c4ypH9RFPRrbe0K5RlmKJuSysTucwJD3nT/RqhBA24HlUFA9pjTae9phbGAN09BIteoG9RxkRdY/ApwvzIhF8SBUehAE7s5eNpjltKeAcAzJDyqTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766327191; c=relaxed/simple;
	bh=K0IQtqWX619jZ9YkzBmDaKMoDdmrpKcT02lv7CF+pGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp2+c0Dvc9qJqo/mMsn5lqAvs4m2hIyITZrpIDEqMjQAqyCnWUsBo/Um0VIu+7Q4+qsoD60ZZR3vtNtg8GkR+WoKJiIGO+xiYJZdinMxYdjPFtb21RuXhiaUEfnSpAQK7Egen5DiOqa7QXyWb2pfomvGWsgcsyqoFnKh7v51uIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESqqQSPk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L7vBAQm1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BL1Gp821886238
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cXrQ0eZNLwv
	aZ+XYDJE/L7mMaZiYna99KUBbaqbUVsU=; b=ESqqQSPkedBLhNq/E4CyZq1vCkD
	mpS6lcHajHlLLq/IzjSJkGONW3Tznz5HDQnY+sJEDU44RT5HXK84eRAg4auDDsZt
	zLLXjBpYr1sqVkGKeMxBfU+iRF0ltmCP7OorhTUfUIrexKTjYOhdgXO1uRnmTTOo
	RYs66G5eVwg5VkaTjWa76ONagbOYxuX7LJ8ZseR6gac0w1VDbJtk+0tn2mZnS/p9
	RtpsflX7YiFYyf4JPZCHTg4e78dvWbgGf9ImF6xO9beP6TCqGEwd8DVsqpquJ/2m
	X42Ay2Vjkaz7PLsknBt5NgF2+BFa5mxDqxmuCUkOgnZuaWs4fT77J2KgHDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mubjdux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:26:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6ceab125so84609561cf.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766327187; x=1766931987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXrQ0eZNLwvaZ+XYDJE/L7mMaZiYna99KUBbaqbUVsU=;
        b=L7vBAQm1aRA9ANrzMohQnDAq5S/NZgE+Bugek/hDnrSUqdxEzHegUFbvBMRtiAOIae
         E5rkR7DvlFjgr3PMiYQBBfZcUQA8hdnf/tLrt4Hli2pHKNausSfwdDlqLyCHifp/xnnc
         +o5bEWNAFcoWSSgB0Ia15Eu2Kkht4np42XGGdeD4LIJg+3u2UUIjMBX/VEB7wFFTucM2
         mhXh0Al50PXKxdHs9Cb8BtVc6P+OKWawwqQ4ks0y4wKtiKqDA3eN8uzvjr3nvg0iPCwh
         dHMIG4o7SySxZQm3XChxcSDXIWQfn8vOFirTxpaH+qkxJrqBZV3qatjH2baY11ISzNpJ
         KwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766327187; x=1766931987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXrQ0eZNLwvaZ+XYDJE/L7mMaZiYna99KUBbaqbUVsU=;
        b=aNO9np8JhBOwvcJv0UvuXBOgTxDKrFKXLdWvFP8ZSYa6jogt1Z6s08ZEv+29+E4P0v
         NtiLTeCVqmcGpVED6zKKfQtvmbNwgMyaWLoxRPbw7weumdGxYiNoKAz6+OzmWdh9tYeK
         3zqVyL9z1lOwjKyLYbsp9ycGQdfoHF3BUdalnkyiP/zc6frF4gns5IZF78ZBO9oYJwmd
         2J9bY8/d3KkuXCuMhklVHNW/KBsQVpEPLC9g27/Vkicoy5GzOL9Y1cPQB2ZXDBMrYB09
         GJsEYCdurquCEuRNAfgXdNAw7JWjX+a58rB60Fl5TuyLjyFcrm4Htpc6ObYmz8DnjJ86
         hppw==
X-Forwarded-Encrypted: i=1; AJvYcCXCNr2b5GFp+koXF60h0qjYG7WUnFxCakrKGvza3wkWlMttqyhNkWkzf7RpCAfClle708MRrOIS+0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+pqtRh6Ugs1Myc4uMe0cAep3MDDs+2hqoe+RIkATiYd718rR
	Ow+7TAhNzs+i8NHlifgNX5h/8cP5y8plGaQNWr88J0UKGBNeg8zYe62gL4rZW1oVUuXEcxOaxoU
	qph61XBASmAMkemAegjYj589kbKaYDJoREj/OsCW85D1ooUFnob7tYyHXIunnEy9q9sAGdfU=
X-Gm-Gg: AY/fxX6S7uJF/MpQIurHE66hyodP0azzoIU/OiV+9G9pjIP/ejPiv54uXaLnWZQbrot
	Iu/rVfEMZeQOme6Xm5I5ZzzfAvXOHhfOh0Vm493JU2tUI7EhlA7j0udA0mRFM/9je1HRArOG5CO
	SwvoY2eRIxyLJL4peYXqj1h0ivucyjAobDQwCut7mhMl6YcAfNfFty6GuUEUFm8NdRM5sEg733Q
	xd8M2+U6pZlpfDmv7bgNs1+fiE/FkIHqo6tvkzZruOq7TBYIzTT+zuHUTf+V6fwwREsuboL8yVo
	JVMkgisaaC0vsxKVg14A4WHybSWguIil+/94E7WHVqrjZgYK4j9/muIR7hFYAWfYMqchm7Oyxiw
	g6iz+VMOHetw3GmGV5ZH2Qjf0f7dtk78ZwVsdVZHNRrS9YJ2oIUoFALWXDBof7BHDwLU=
X-Received: by 2002:ac8:6f07:0:b0:4f1:83e3:bb1a with SMTP id d75a77b69052e-4f4abcf86abmr121194931cf.31.1766327187401;
        Sun, 21 Dec 2025 06:26:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4X1T9bdZZS/qvpRUsFhD2vRTGIBwr1akucMiS/SqlqEtSXJi9+JqEGzxWGbwmBgDxvbN0gQ==
X-Received: by 2002:ac8:6f07:0:b0:4f1:83e3:bb1a with SMTP id d75a77b69052e-4f4abcf86abmr121194621cf.31.1766327186904;
        Sun, 21 Dec 2025 06:26:26 -0800 (PST)
Received: from quoll.home (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80620c4520sm211742666b.28.2025.12.21.06.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 06:26:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/3] iio: adc: exynos: Simplify probe() with local 'dev' and 'np'
Date: Sun, 21 Dec 2025 15:26:04 +0100
Message-ID: <20251221142602.47368-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4355; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=K0IQtqWX619jZ9YkzBmDaKMoDdmrpKcT02lv7CF+pGE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpSAN7uXaCJu7ZGPqhfs4R9Ef5h9276gYJLaLUY
 YKtXtzQRLGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUgDewAKCRDBN2bmhouD
 1zfqD/wIktSEHD3nlDu4v1bjhJA+iTTRm5qqTc01Jd3T7PEFYcGXDQQwVYANojieNLNhQux9H/p
 NFLX3aSMRGGDEtulqa8DTrHo70IujJZnb2VvTTwdsT1tLHm2e3cIJu2tEdsuSICwS/NYNbpJahV
 BwjaeUk3isJfSeqXAP6Csj3zU4RfoaB92oRmTYaBj3eORohYq6iX/4Aau7uY4KTPR/L2Q979/L2
 oK46pTx6bcGRSMxerNyqWfkY7wFEnldgowWv+xTWy8+zUeEttz+1RTfu/TZN3KMTkwPJo6EQNHU
 cYv/XezRWPAZdmSeVmsNQARSPCZoXtMw8kY5rq3m6NdJaGe/epLes9YKEEVao3TqboDYEtFGpws
 +N1kQjjwOjdRLTBufFRlH7Srs3LK7s7fliDsvr4QC+Ds6HVcj9VQ629ELMv7HOVj5z1L6xtGB4/
 2uHJWxzoPAY0CvX1tuyVHtvXrc9W4i4hAe/dNXmPpkgY4sndzLGcjsLtfZNNSHzRozcPVo3LRmQ
 QEsDz+N1VL2jw2fvLPTeV4GlwIFvlwXk9g+Tp7XFsQroqX6D4OTzxudmqlMPnjJcrcF0tvZMlol
 mMO9nAe9r45SZ0mNUNB+DdalACiMKdZxySYOp6/HwvPbxNagKQxBEAAnkQS2cnW/OIZdKLBHhdD StOStPPzq1Gm0FA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDEzNSBTYWx0ZWRfX1BI05C5TVzxD
 CLhTVyT4U9ccMY/4QzKzi99lCJkf+L+KELQimpesp0k2+WrUYzaNwe2EGL/gcJDqfy2UGG+GksM
 8VOTYmMTnpG7OaI228E+1uABO2Ctquqg89OSkZjDiguhnqQsKFLq2ySnxcHkVRaz7hZhVTfzLUd
 EGfRt2qiqsL9Nia7yFILsZ54PWZ0Kl2ivhfu/KBsxheY21H16Nx+Nu3q01U/QWPGHUYNo3eQO1i
 5CbYlRGOD4sXvkREYTGjnMo8uTOMbNJu3D59Ed610vwkU+ylcbYX5T6Wrvra1mVMr/fDeQ65Nij
 /IOZRIq23eT4hDnqX3wlTHpo4xyZFvj0KsWfht8+9A/27j0qKqLoHlIdnPEIWO++lwq+MBB9hXa
 8LLPTX+XEEl/eY1agCz15Yl2J031fAPqiaAof3iL5VXceUc4Aah5iIpIaejl8RHOpGkVPlgxiDc
 UmTLeGiM0ANDqeY2p3Q==
X-Proofpoint-GUID: uS6k-k8HYNvrTjJf3KBjFOG34krxr6b5
X-Proofpoint-ORIG-GUID: uS6k-k8HYNvrTjJf3KBjFOG34krxr6b5
X-Authority-Analysis: v=2.4 cv=KYbfcAYD c=1 sm=1 tr=0 ts=69480394 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XA6BSOE7zRTYN9-09qgA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_04,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512210135

Simplify the probe function by using local 'dev' and 'np' variables
instead of full pointer dereferences.  This makes several lines shorter,
which allows to avoid wrapping making code more readable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/exynos_adc.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 491e8dcfd91e..aa287132a369 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -552,12 +552,13 @@ static int exynos_adc_remove_devices(struct device *dev, void *c)
 static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
+	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
 	struct iio_dev *indio_dev = NULL;
 	int ret;
 	int irq;
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct exynos_adc));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -565,7 +566,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	info->data = exynos_adc_get_data(pdev);
 	if (!info->data)
-		return dev_err_probe(&pdev->dev, -EINVAL, "failed getting exynos_adc_data\n");
+		return dev_err_probe(dev, -EINVAL, "failed getting exynos_adc_data\n");
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
@@ -573,11 +574,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 
 	if (info->data->needs_adc_phy) {
-		info->pmu_map = syscon_regmap_lookup_by_phandle(
-					pdev->dev.of_node,
-					"samsung,syscon-phandle");
+		info->pmu_map = syscon_regmap_lookup_by_phandle(np, "samsung,syscon-phandle");
 		if (IS_ERR(info->pmu_map))
-			return dev_err_probe(&pdev->dev, PTR_ERR(info->pmu_map),
+			return dev_err_probe(dev, PTR_ERR(info->pmu_map),
 					     "syscon regmap lookup failed.\n");
 	}
 
@@ -585,25 +584,24 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 	info->irq = irq;
-	info->dev = &pdev->dev;
+	info->dev = dev;
 
 	init_completion(&info->completion);
 
-	info->clk = devm_clk_get(&pdev->dev, "adc");
+	info->clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(info->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk), "failed getting clock\n");
+		return dev_err_probe(dev, PTR_ERR(info->clk), "failed getting clock\n");
 
 	if (info->data->needs_sclk) {
-		info->sclk = devm_clk_get(&pdev->dev, "sclk");
+		info->sclk = devm_clk_get(dev, "sclk");
 		if (IS_ERR(info->sclk))
-			return dev_err_probe(&pdev->dev, PTR_ERR(info->sclk),
+			return dev_err_probe(dev, PTR_ERR(info->sclk),
 					     "failed getting sclk clock\n");
 	}
 
-	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
+	info->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(info->vdd))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->vdd),
-				     "failed getting regulator");
+		return dev_err_probe(dev, PTR_ERR(info->vdd), "failed getting regulator");
 
 	ret = regulator_enable(info->vdd);
 	if (ret)
@@ -619,7 +617,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, indio_dev);
 
-	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->name = dev_name(dev);
 	indio_dev->info = &exynos_adc_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = exynos_adc_iio_channels;
@@ -627,11 +625,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 
-	ret = request_irq(info->irq, exynos_adc_isr,
-					0, dev_name(&pdev->dev), info);
+	ret = request_irq(info->irq, exynos_adc_isr, 0, dev_name(dev), info);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
-							info->irq);
+		dev_err(dev, "failed requesting irq, irq = %d\n", info->irq);
 		goto err_disable_clk;
 	}
 
@@ -644,7 +640,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed adding child nodes\n");
+		dev_err(dev, "failed adding child nodes\n");
 		goto err_of_populate;
 	}
 
-- 
2.51.0


