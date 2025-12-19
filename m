Return-Path: <linux-iio+bounces-27206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9FCD04BF
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB80B303E9E9
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316E2D8367;
	Fri, 19 Dec 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WAIpjOpQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lfhfrg04"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFB33ADA3
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154968; cv=none; b=AHrjSNfxv7eTpn9g/gybDWoy51zq+UN/6jJ8B7QvmfKUrnpeYT4Q35kF98obx8el4SlcKoRpjePvrCsVsXyU4Jn3wUPb9dDevZDsCk0kkcgvr/8IDr8ffcE9BG1byKjwxcsv4bUJZ5CqWsWoMJDwrM4S1dgxPJak5cvzAJwvt6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154968; c=relaxed/simple;
	bh=FwErtDRj45YR9+G3sGWpElTdT9H2524MS3PEIg8X+gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IkFRe1NlKQqUHZYkc+tq9QL5mzXq60h55pw8lq9YUrCk+vOrcTLHm99HxtGnvoVgDHtIedYZmRjXdPKsnZ6cnyt4+ukIN7JhD98ItgC7X8JkDNOcIC4c39BtsbAhoBmVv4+0YdxEilWRQ8eR8P6tkeH1giy9hQWQ6i9pj7Nf/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WAIpjOpQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lfhfrg04; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBunfB3976825
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QO7v3mInpyxqmqngfzK6cMArjVhYiK5JPVpSUzcyyGQ=; b=WAIpjOpQ+PoNwSKf
	y6JtoIF7TqlCyNrzHYGE+yWtSdWoOyxksM5aRSYFA8xjuacFCIiBdanU0xMirIwc
	HvvXytN5sQL9MThx09ocL96j496Kwdh1HT/ShkbLg+avvHcZOQyP0aQcLTJjdjNS
	plwyUlhPM5DGO7yfqsRg7kNjM3mghrWuzrUg4NZSiwgykJ0l3J1XJiVeohj5EvBg
	ZwM7Hk4vg/6y/A39PL5MEv/AFz7koX2K9SDHVI/Su1KtYGcY+uEGI6Nx5NjVhRjX
	TOpKAI0d9aANoZ5kav6OUUVD8dNycvwl6xva9HaolBGgAafQsUkpDV4jOb5etk2Q
	ME8/Dw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2fjw3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f4a92bf359so28597721cf.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 06:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154964; x=1766759764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QO7v3mInpyxqmqngfzK6cMArjVhYiK5JPVpSUzcyyGQ=;
        b=Lfhfrg04yTkKQWJUbLB5Lk8/hjlK40psqjW3P94WAx85x0mCXkSdB4QifIK5tXdGdv
         nvVZA3s3T+STjMetgUsTj55G8dWTZqzbOx3f+ZZu6Ez2AMnzckMMTjrPxpnAl2QJWP6Y
         LqfTepK0R6FRSjVHQhWKoM4DccCSIHWgLvHKE9OLBnmDFVFJupvxHivG49vxOWfmqjUA
         XU4KB+ePdITvukkMoyYK8WPp642WGXk8VmT4d3A6TIPJWOLfsJy4VQLhZeGjVWpLM8Eg
         vuxiLgprpKRsQ82L9lkQLnilR3eFT+xJZgSLHg0mbmNWVgSZ5jerWjI2UAgRuqPS6+jX
         3yEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154964; x=1766759764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QO7v3mInpyxqmqngfzK6cMArjVhYiK5JPVpSUzcyyGQ=;
        b=Wwkd1T/ohQSHuer26QVCAxX2NMoH0Fvt/9V6XzU/JOWaHGPfmtxy3N/PgltlKmXduS
         896EuuNclkzJOBCmlLvHRwS5P/W82CXuIWINHZun8AYDqLCUOv/6UYqiJ/FUvZDW8U9p
         fd9bMm6zui4gYUo6IsrsgFFPDF+Dw+8I/bG+BmvlWGZqyL3bv6piKVc4JKzMCy5IXRo6
         oQK6LxoZfpiQzY45jIIZPkQ3RfX0EoGKGQkN7VZ/CKADtXrWoVjfisk4dB1YpXfeYpAk
         575QpN0fBX7OZOMEkqxDMut9T9uhpV6fmq4wOzuKzXR313i7uR3d1RIL8e/ujvobTMv5
         MV/A==
X-Gm-Message-State: AOJu0YyTFhQoX0fS9OgLbdgVUI6eDiynwLjwkSdy/VivPIqXMfYGFw1H
	EgX3Uec4bARDVxQSwAukcbedZxcrP1pjr25igEX2m7PY7WwW3G17PfVFh2FI78Ts402N4OsggT+
	8ChXjPezO1j1qbbzILSmcm2U9H2SWjNFwIiryDCBF841cnpGLbe5RpOSI37BUN04puKyeZ+Y=
X-Gm-Gg: AY/fxX4smyAFkpgryZq2RoLRSUzbBt100dOybFnRMMIULVRAJJM5k+ltXBky8WZISZ4
	kaIkNshVdGOsxpeYj+cMlwqt0ukOSZ5DeV4d89kcXXwcaV2gbzgVwqgi0Ylwq0ufgz9JuvljG+Z
	YgnVXFMz6CGvE0V7KXwsjW3I8JnjzIq5dorzNcO+Ztcn+E7FFkxXG8obVXz1PWb9sM1SzQB9Htx
	ZI46A1TnSlSmK4v0fKTHsZMzAdSPncud+5YYTtq6S5lGgxJ4/xQApQRR8PCHAht9gh7u1emFyIU
	fP0c+eJv4QDUi0vBnCN7DGJ04EXZG4eGFMSK2dNZLG1AsUUXSdrHQWpRsUFBB6MOULd/E7FPt4d
	eJWt4u9j+FD0i/DQp1o9aHrmupssJvL2C9noHJpEZwpyOZnbNJEEAyNSG2bD0QyF8rbrP
X-Received: by 2002:a05:622a:11cb:b0:4ed:a6b0:5c39 with SMTP id d75a77b69052e-4f4abdc6a4dmr43263611cf.63.1766154964151;
        Fri, 19 Dec 2025 06:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYupEl3gYLzDt53suprXOO0WmjuzlD6rknnropJD9KMCWfnffglHqPJoWvFjr/nYkg2I6ZFg==
X-Received: by 2002:a05:622a:11cb:b0:4ed:a6b0:5c39 with SMTP id d75a77b69052e-4f4abdc6a4dmr43262891cf.63.1766154963604;
        Fri, 19 Dec 2025 06:36:03 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:36:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:54 +0100
Subject: [PATCH 5/5] iio: adc: sc27xx: Simplify with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-iio-dev-err-probe-v1-5-bd0fbc83c8a0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3222;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=FwErtDRj45YR9+G3sGWpElTdT9H2524MS3PEIg8X+gs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLIBxhyFmOssOsCYuSdWCS+KQ38MQOZRW/DR
 UUjiKlsTFiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUViyAAKCRDBN2bmhouD
 14EwD/9O5g0sKxohmlPbWRb5GCF+Zyv/zhIM4UOKtjqVRmXpwhQlQ5PPhdnKhun24YiM5mVrrTJ
 jazVQ0q7AS3Pd2nhNF4aEli4cGK6v+5tsbY+W+Z0S4brTp60yR3kHRWKRCH1obXF5k//KG88vDI
 utRrA3kUsFGOuVY7/mGT6u70Y3vLUHvpOIePcaw7yO9ZGQDh1fhrk3V3xE726Y05GFCMAGboP75
 e5VMg8CddWKpb7pPw6KRXj6vMp3stkIQKd2FwIKY+ZVmeuk/WbgJCkyb7JgtONVtYQ7HhS5kv5V
 quVBHJXrbe7XoEpzecJg2KoIlIGSd1hkMo3M3rO6eKwxyyDiwo+IbO+1tAiGJ6z94+0rB3TWS0z
 JCwZsFz7fcLYl/27TiOCXPxoBnkGkpvwMCilqcQ0wuG8Na42nRitMIu5+E2veKtiSHsZkYBaOyR
 qHojscW3lXvVSO1PfjMjpFwqaB3byNdUl96aEpaSezOibzXovGjyYtcrkVErlwWYnUUgSm7JDfd
 SuH2bGvlkFDQDgaR7/uudIXSCccjtRXp+GjB0rZJLAgTtoPW+LIukSddD2zmR6Pz+gV0UFqZSMK
 mAbcTZA4Xd+e1kCf+Aey0jp6AP4Fkt9KxCEvNYvSGtubZ60ve7d5mAoLFT1jAeudBulbCHSu47V
 dnwL6XXYday0k5w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=NODYOk6g c=1 sm=1 tr=0 ts=694562d5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cWTT0jPcX04evTyD5nUA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: STKxuEeqGMoM6tlKJ4Y86NemL8-Qnssy
X-Proofpoint-GUID: STKxuEeqGMoM6tlKJ4Y86NemL8-Qnssy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfX5hP8rDAtZblx
 WG/BFxl4wawklK10G9FdEf+ZwYLUPIOgka5g0P3fz6KB7pufcUybsqvSigwfP1dmS6+fQtOkHIE
 6Ip2oIBUg5TtMGVMZI08f+MQeuOmQ0o5Gw5v2XNTPuQtOoREGauxDrhdHAfc/IuTg47tWedNz2m
 cK7HCAfwDVsQ+YWs9YJbtsYfl+tufsiUxZ0qPuGLiZRks/sFXLXGbz6+T2SX8sD6dh28YFMyXjw
 OCQ2cnttDftIK+fsXe8M8yrlngB+Aw68bZVYrlX6TTVjIgxWlKV4bnvGHnGz3r5sGsX1g3WLIEt
 YZX4y1U5HEUb6f/508NQV/DfkbfpJvosMC/KNjnHGfGKpfNallg1cOxZlcScBN/IN1FVlGZLWuL
 VuoL4NdOIcP9flVn3E2RglnYfCDEPp+C09p1wEQE3szOVDtv3TC8silGCR03OJiEotRQEZ1Y8xz
 K1BBJoZzfv6C8W4HB+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/sc27xx_adc.c | 49 +++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 2535c2c3e60b..6209499c5c37 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -867,10 +867,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	int ret;
 
 	pdata = of_device_get_match_data(dev);
-	if (!pdata) {
-		dev_err(dev, "No matching driver data found\n");
-		return -EINVAL;
-	}
+	if (!pdata)
+		return dev_err_probe(dev, -EINVAL, "No matching driver data found\n");
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
 	if (!indio_dev)
@@ -879,56 +877,43 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	sc27xx_data = iio_priv(indio_dev);
 
 	sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
-	if (!sc27xx_data->regmap) {
-		dev_err(dev, "failed to get ADC regmap\n");
-		return -ENODEV;
-	}
+	if (!sc27xx_data->regmap)
+		return dev_err_probe(dev, -ENODEV, "failed to get ADC regmap\n");
 
 	ret = of_property_read_u32(np, "reg", &sc27xx_data->base);
-	if (ret) {
-		dev_err(dev, "failed to get ADC base address\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get ADC base address\n");
 
 	sc27xx_data->irq = platform_get_irq(pdev, 0);
 	if (sc27xx_data->irq < 0)
 		return sc27xx_data->irq;
 
 	ret = of_hwspin_lock_get_id(np, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get hwspinlock id\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get hwspinlock id\n");
 
 	sc27xx_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
-	if (!sc27xx_data->hwlock) {
-		dev_err(dev, "failed to request hwspinlock\n");
-		return -ENXIO;
-	}
+	if (!sc27xx_data->hwlock)
+		return dev_err_probe(dev, -ENXIO, "failed to request hwspinlock\n");
 
 	sc27xx_data->dev = dev;
 	if (pdata->set_volref) {
 		sc27xx_data->volref = devm_regulator_get(dev, "vref");
-		if (IS_ERR(sc27xx_data->volref)) {
-			ret = PTR_ERR(sc27xx_data->volref);
-			return dev_err_probe(dev, ret, "failed to get ADC volref\n");
-		}
+		if (IS_ERR(sc27xx_data->volref))
+			return dev_err_probe(dev, PTR_ERR(sc27xx_data->volref),
+					     "failed to get ADC volref\n");
 	}
 
 	sc27xx_data->var_data = pdata;
 	sc27xx_data->var_data->init_scale(sc27xx_data);
 
 	ret = sc27xx_adc_enable(sc27xx_data);
-	if (ret) {
-		dev_err(dev, "failed to enable ADC module\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable ADC module\n");
 
 	ret = devm_add_action_or_reset(dev, sc27xx_adc_disable, sc27xx_data);
-	if (ret) {
-		dev_err(dev, "failed to add ADC disable action\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add ADC disable action\n");
 
 	indio_dev->name = dev_name(dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;

-- 
2.51.0


