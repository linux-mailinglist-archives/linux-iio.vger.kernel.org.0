Return-Path: <linux-iio+bounces-27271-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC2CD4165
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 15:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9253008E83
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118682FCC1D;
	Sun, 21 Dec 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8EUpWtX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K1BPYhUs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32327296BD1
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766327188; cv=none; b=YTgkRDuxphv9YJdSEO7HPJ1ouzJ8e0/9MTxdVOFFbkuQCgaGGqm/lIo8QTDQLdsSacbohCc0z9lpRXbYM5OlUjYa4abkorAgg7zTdburQPyq7+DmcCZiPvhgrL03O4a+wCgNxpc/lj34blrKcD24Y+j6GQwiO0BgfU28ti3zTOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766327188; c=relaxed/simple;
	bh=4memX5LYrUSHkpPHO9rC17xhoMrrygUhrVZmB+X+Pes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSj5t44/Ta6w3wTgN4YdnnA0hKjlFLmAJcyHG3yNZ1CCRK2dLhkFoIV9WSApn59r5os0HdVENtgtgKqyd3/rZJzSNT3AfFU0GNK2xVoNywWaJQVnQlHyhzXY9TtS+8pAxYsjcD60o/ZDIKTTske+FFjbWg4eGb/CLIrAz3rv/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8EUpWtX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K1BPYhUs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BL7LZQO2442044
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hgLU28eZkGhuvXnuaKPXbCVu7AuMcgJfWMs
	7HupizkM=; b=m8EUpWtXl3yU9Rj8JAnOwV47nrwluO7hLjeBfomTh99Rg6v1FVH
	7lAbOiiTId8JG875n/CBetzVQxZEHKmAMdJET8z4HgZVPs7bISugR6zXg3fFhal2
	a2UIH3pS28Yv9WxloIjcXIPDcn0gBraDLP0+7emj/amIHKMcjaK9OMFHYI+eau/j
	g3dnQQ+6l7Xi2Qg6Gm6zL2tYxBiP0vzYnwJx0KXBO/kWCqlomOL72jkz03dBO/bA
	m4GRGIlJM0YgE+6i1SPaC097B1CIf1vxFfh5mjzJ4/uXgfMt8rC2QepxY0l8jZjx
	uGgk+5Nia8r/IT/KjxAfK2djdBySTQC9QYA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mraad2f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 14:26:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f1d26abbd8so85016721cf.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 06:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766327185; x=1766931985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgLU28eZkGhuvXnuaKPXbCVu7AuMcgJfWMs7HupizkM=;
        b=K1BPYhUsLkf0mrYPNruHo9EDTcH8ZIBpFaNSjxht8tCE+YOS+fqoewdUqmnQcwd0pl
         zKUP52tiLnigCtMgn8gvxa++76Evnfe75nIgKGrQqrqi/xlmW9L2FLERRoBtg+8Xm2xg
         jAaJxNbRDtEVa/PpuVAKQoQ+qAlq8rCplpsmYkc0ZwBwbFqO1uz0nn6qUlrOqmPvLEcA
         NFcMn0rh27r/DACkXU8l8TyUkaQTxQO7EneBe0E5Cs3tjBm3ySBUJ0o903jTTfKDWqT2
         gKCvFDyRzX+MqCNpAtG2Pp7l9agTiPj98VdbCez9nWIMWzHLocB5DdAbCHsAkwwcNg95
         NEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766327185; x=1766931985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgLU28eZkGhuvXnuaKPXbCVu7AuMcgJfWMs7HupizkM=;
        b=Xx8Sx6quia0DKEZpxVlW2cvlunPZZyvOsI3P3d9hrF6LeR4yXGEw8iJfyx/rK6Ds/T
         PumBVNV3UEtoTa4giG6aaG6msd/uuaBYjoo7GZM/UWOiwCk61gdsQc6PbLkxLQDTxugm
         OIXH5Vd84RJaUR2K6lIcpW9qfVVBNO/XljzAxFZUzg9CSUM3kQfjU80zBIW1TOMPa2MD
         dS5sSoBOwtTaJRwHXLRUf/E2vssSivjx5zCltlWNKL6svwNS+OT2qyf+0Nwmp7x41MGP
         MPob8NPHdLIvGglUOOZNSEOCa+mfsTDzbPLVMjb0P2/u4C2QOnhAAn6WhjjXExHTtLTZ
         VbUg==
X-Forwarded-Encrypted: i=1; AJvYcCWp00rWT0GgZdoJ9JaV5lkJHf4y5t2+H3Hl/aLUKTu3kvMo2nHqwnzJaRBE7l0v0RwMdVrT1bBaB/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd7taOoLxWep2c+A7ss1VDDrOQ5ii481HQPeDSjWta5+L21+N4
	x4PjHdn3LhfJsojtzi/0EDq5wKJleU31916+thubpdwKtOjYjYGuf0BqwndpI5re7HPf5Z1Om2/
	bRbQZTVovYRQHyr5d+mGvkZLd1EavrZXHwC2u9w7iS3/d2eHoEOco1AhXA7SuzrI=
X-Gm-Gg: AY/fxX5wXULXDhh0UkIAoFO42EIyS4YuPg3s2dmzXV/+6KiDyy/Kz4DlsYwQv5XKYgj
	urLGK3v1JyE4s06HdhgsdeujbbRxsGuWP5/6/NzbbgEM3HpIJQX34RbVfU6KFY+gG8+9UcjqjUS
	zjMQK6skuYbPDeWKp4Q6Ct46uueJeEf8rDEXvlRVz+2G7CL3VgLCDQCM24KUlvnvxtlZrnE0ECn
	HLUOvdFXAM3ICzxhNGuOUUiHyYfJHtS8h8zSy9s9CYy6WfRxPE4VOra1L6RDW6QpwYv0aANBaO6
	SFM55YpZA8I4OS3GFnUcsWOoP6076Qb8oMSQ6DB6BvYm4935kSAyOV9WnJhPZBlar1hZN7F6GI0
	wRi1sP4P0GtwhbMLPJ4Lv6tCDNt1aWPEVnr/9/7+7tO4YWI3SSdbNxlCOHmIEgiXvAG4=
X-Received: by 2002:ac8:7c4d:0:b0:4f1:ea37:cc6c with SMTP id d75a77b69052e-4f4abccef5cmr121973751cf.1.1766327185425;
        Sun, 21 Dec 2025 06:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1Ewwu8jx2ZwPNq71Z/1YkKihvuGLTgnEvdj7fUV4p110jAK9fWg0mU4MzcCWC6pVFe4KQUw==
X-Received: by 2002:ac8:7c4d:0:b0:4f1:ea37:cc6c with SMTP id d75a77b69052e-4f4abccef5cmr121973401cf.1.1766327184948;
        Sun, 21 Dec 2025 06:26:24 -0800 (PST)
Received: from quoll.home (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80620c4520sm211742666b.28.2025.12.21.06.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 06:26:24 -0800 (PST)
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
Subject: [PATCH 1/3] iio: adc: aspeed: Simplify probe() with local 'dev' and 'np'
Date: Sun, 21 Dec 2025 15:26:03 +0100
Message-ID: <20251221142602.47368-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5796; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=4memX5LYrUSHkpPHO9rC17xhoMrrygUhrVZmB+X+Pes=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpSAN6XXbmliCtMd47o2Ukt4Nzqp5wMfuT7YMpn
 B0bxk6i8+iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUgDegAKCRDBN2bmhouD
 1+QUD/4h6/Z/xjzwuixOi8qQKqxnJhDBq0SFL89uOLzuKcSdkerG6kIqP7Ohf+mL8qJq4iT9ZiK
 VsdrgMQA3s3wVXAXqMBkdCK4e9csD8bF2MAUKIb6+HbFsphWegKqmDsL43IPwZx9/Jnhc8ju4xg
 oxISsYHMxi+Lj+hZLswy7fJuPV/rlT4xRCfpnYaEaHrxzE0DHOdYw9VFuch6FLzt/KI5dJB+0rq
 7bqm2523WSW2EJ4qQhN0AIfkGnn7aQS8WFdQ9JgjvYolDnqxLqRTskV+aTUh77WY2ryH27Z/qSm
 cHHcsvZ4+knptjeLzi7tuaHR6Fm1a4PV9q1Cf6nvm2G8XflIX9mk9xTUCzqz5uFkJx4p/hW2n5R
 6owLdaaAFn3fweGPPh56+M388RM89VLo3lkF1W0ElrbFdySTYlWn00GU1nS90KlKf7MxrsWOoSS
 RaSroRmjHzXefIK6ze3kbvtJE6WWl4yhFfauKQea7oj8F2bPFtXX966l/rAm3hf2dxd1CrYdOCE
 RksgInFqSNWHu3uv+A5FBHnK3AqjapgI4O0rjglPxs4M65UEZ/Y7wJDZtriE0TYjiDNFIxl4lo2
 njHCvzlwf61GZw/aZas9Y1KQrIPiEYJeCBOcCv49+k/V6Q8WWZUJtdkLDLvBbHNzeL+MeN/gb4A JQzD7dXuG8fDQ9A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sbSxmma0xYLuM3-SVlcqOitxqCE-9fg3
X-Proofpoint-GUID: sbSxmma0xYLuM3-SVlcqOitxqCE-9fg3
X-Authority-Analysis: v=2.4 cv=e9wLiKp/ c=1 sm=1 tr=0 ts=69480392 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Nk-rwAvTYNLgZ8AtZ6UA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDEzNSBTYWx0ZWRfX5VPlq2qQR8QI
 kB9eIw9jm/a3HUAom4T15cIgt8KeOBU6Au9bKPiIyhwP+AuoF19msqWn7R1SfVCw68zng64Lijg
 vV/nveg+AdAb4xVBEbvunNVm4yQNwm6P7424A2yZg6Xgger6lGMIE4L/bKSG84E3sZ0imk3hCsC
 rpl0YJKcfQUbwS5waEFjdpRmrBGsmiMwxCOJqxgB+hTaDjBqF//U5t/GdevfK4prjd61Ol5pjx8
 iwebszEWGpmnkY+k3annJydBF8vXT+pFDYem59bqpbasP8bLFNKjY4y3EkGAoLjJvVwI3ozE+J4
 arYEJ9C9XKQru9fF03zvZlxu0BXF3Tkdp1Xq87B2hhLNzTsnQ/bJbarl9LevrsIOHauJn6yJ/P6
 xanwWD8QIX6e/jarGhpTtXEyX3tx6Oo4UrKoxJqDm4W1jiCuyo69b/EaCia0124JruULdQuH4fE
 TX4GYDRwJ0FRpdVDpiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_04,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512210135

Simplify the probe function by using local 'dev' and 'np' variables
instead of full pointer dereferences.  This makes several lines shorter,
which allows to avoid wrapping making code more readable.  While
touching the return line, simplify by avoiding unnecessary 'ret'
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/aspeed_adc.c | 42 ++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 1ae45fe90e6c..4be44c524b4d 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -472,16 +472,18 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	struct aspeed_adc_data *data;
 	int ret;
 	u32 adc_engine_control_reg_val;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
 	unsigned long scaler_flags = 0;
 	char clk_name[32], clk_parent_name[32];
 
-	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
-	data->dev = &pdev->dev;
-	data->model_data = of_device_get_match_data(&pdev->dev);
+	data->dev = dev;
+	data->model_data = of_device_get_match_data(dev);
 	platform_set_drvdata(pdev, indio_dev);
 
 	data->base = devm_platform_ioremap_resource(pdev, 0);
@@ -491,16 +493,15 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	/* Register ADC clock prescaler with source specified by device tree. */
 	spin_lock_init(&data->clk_lock);
 	snprintf(clk_parent_name, ARRAY_SIZE(clk_parent_name), "%s",
-		 of_clk_get_parent_name(pdev->dev.of_node, 0));
+		 of_clk_get_parent_name(np, 0));
 	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-fixed-div",
 		 data->model_data->model_name);
-	data->fixed_div_clk = clk_hw_register_fixed_factor(
-		&pdev->dev, clk_name, clk_parent_name, 0, 1, 2);
+	data->fixed_div_clk = clk_hw_register_fixed_factor(dev, clk_name,
+							   clk_parent_name, 0, 1, 2);
 	if (IS_ERR(data->fixed_div_clk))
 		return PTR_ERR(data->fixed_div_clk);
 
-	ret = devm_add_action_or_reset(data->dev,
-				       aspeed_adc_unregister_fixed_divider,
+	ret = devm_add_action_or_reset(dev, aspeed_adc_unregister_fixed_divider,
 				       data->fixed_div_clk);
 	if (ret)
 		return ret;
@@ -510,7 +511,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-prescaler",
 			 data->model_data->model_name);
 		data->clk_prescaler = devm_clk_hw_register_divider(
-			&pdev->dev, clk_name, clk_parent_name, 0,
+			dev, clk_name, clk_parent_name, 0,
 			data->base + ASPEED_REG_CLOCK_CONTROL, 17, 15, 0,
 			&data->clk_lock);
 		if (IS_ERR(data->clk_prescaler))
@@ -526,7 +527,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	snprintf(clk_name, ARRAY_SIZE(clk_name), "%s-scaler",
 		 data->model_data->model_name);
 	data->clk_scaler = devm_clk_hw_register_divider(
-		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
+		dev, clk_name, clk_parent_name, scaler_flags,
 		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
 		data->model_data->scaler_bit_width,
 		data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
@@ -534,15 +535,14 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk_scaler))
 		return PTR_ERR(data->clk_scaler);
 
-	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
+	data->rst = devm_reset_control_get_shared(dev, NULL);
 	if (IS_ERR(data->rst))
-		return dev_err_probe(&pdev->dev, PTR_ERR(data->rst),
+		return dev_err_probe(dev, PTR_ERR(data->rst),
 				     "invalid or missing reset controller device tree entry");
 
 	reset_control_deassert(data->rst);
 
-	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
-				       data->rst);
+	ret = devm_add_action_or_reset(dev, aspeed_adc_reset_assert, data->rst);
 	if (ret)
 		return ret;
 
@@ -554,7 +554,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_property_present(data->dev->of_node, "aspeed,battery-sensing")) {
+	if (of_property_present(np, "aspeed,battery-sensing")) {
 		if (data->model_data->bat_sense_sup) {
 			data->battery_sensing = 1;
 			if (readl(data->base + ASPEED_REG_ENGINE_CONTROL) &
@@ -566,15 +566,13 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 				data->battery_mode_gain.div = 2;
 			}
 		} else
-			dev_warn(&pdev->dev,
-				 "Failed to enable battery-sensing mode\n");
+			dev_warn(dev, "Failed to enable battery-sensing mode\n");
 	}
 
 	ret = clk_prepare_enable(data->clk_scaler->clk);
 	if (ret)
 		return ret;
-	ret = devm_add_action_or_reset(data->dev,
-				       aspeed_adc_clk_disable_unprepare,
+	ret = devm_add_action_or_reset(dev, aspeed_adc_clk_disable_unprepare,
 				       data->clk_scaler->clk);
 	if (ret)
 		return ret;
@@ -592,8 +590,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	writel(adc_engine_control_reg_val,
 	       data->base + ASPEED_REG_ENGINE_CONTROL);
 
-	ret = devm_add_action_or_reset(data->dev, aspeed_adc_power_down,
-					data);
+	ret = devm_add_action_or_reset(dev, aspeed_adc_power_down, data);
 	if (ret)
 		return ret;
 
@@ -625,8 +622,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 					    aspeed_adc_iio_channels;
 	indio_dev->num_channels = data->model_data->num_channels;
 
-	ret = devm_iio_device_register(data->dev, indio_dev);
-	return ret;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct aspeed_adc_trim_locate ast2500_adc_trim = {
-- 
2.51.0


