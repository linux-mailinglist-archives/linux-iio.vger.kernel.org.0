Return-Path: <linux-iio+bounces-27204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 841B8CD053D
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2DB130D3956
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15E633A71F;
	Fri, 19 Dec 2025 14:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hnl+K3EY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YFuoKXkO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788C339877
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766154964; cv=none; b=OLzjCTiTdBoj7aG9PVVM3rOU9lCOb6PJ1oqV8Iw46iIWU7JRfJSdOSoYdrjJqVX31z0s6AysGOg9mDiEfWitPS4qO/VuoGdcx6T14HngbQjU8TI1PM3XdabMgumYmvI5sE5tRc/GaMH4uLmpWknQ0NKBPiNhgaFEGqnMYG2HcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766154964; c=relaxed/simple;
	bh=Wr5/vHqfZ3Gkfva2+k6ouaLP7uADJ4+N3dLFOeSScgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnaT/E73kFcQ9bklUvbvSFQc1pun3klyLPFJNSES8MCzn0rfuyQd9fHy2iWPdYjR709LRkdb4Alvj9338U+gvvGloRUf+kdGJmGi19ikc1ot6AfStuKgcPPX35NJI1S93VucIrq1VIIdy1DX2y3gDa8JzE6PNMPONyzSpDDOw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hnl+K3EY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YFuoKXkO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBW20H091077
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mJ7RnbCsbqZV6SdekFc9SD1k8esD4C11UGzA5IGxZCQ=; b=Hnl+K3EYmUsBTOLP
	WKUR+pd29tzWcTrxfDnWjJym0NAIJMvzCAZo1XoIju72SabnOeH+Si/DSk7wWt9D
	oZMehEmfq4xBDwNtTOglEuyRmwgPGYyHIZ7vthx9Cp3LxdC5KHis5lVk+IbGd1AG
	ElFm+04c/XROzRn2bGmyaScKWTM3gcIW8QQFbwXq0V33Q2hFtJKWFfT23mz07ZNN
	1mJGKMxg3R6Rkdy8l9mIR42LL+sQ8vIvQIlYW7l0INl85Z3iYZgIVtFrNda77bWh
	ZjlQAfFoHLQPLMmUG5GeGzRg4E5HV7BLzPrqmLb5/JTr8N3JPKG6ipoSyi13Pn+m
	3fN/xA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2eay3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 14:36:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f183e4cc7bso32056081cf.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154960; x=1766759760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ7RnbCsbqZV6SdekFc9SD1k8esD4C11UGzA5IGxZCQ=;
        b=YFuoKXkO0l8IMaDvYTKAXj9Xk82lHObjB4z0eprqZylFDfhTqk1UbNmYCQwvm+qMUK
         OMbEwDFp9fcjzjShal1JdJFJv6PSCnZo3qKvmZWeVfAtuXBmpZGj02+AEBrOoY2uSWWL
         VZ7S81oHRl9uY0cCpkk+4neK8N/vAUYZcsWzI4mU7hO7Zh5UZ1BAfpXwyj8LQiPI8M4l
         vJbH7Lb59NqM5GybOBGmeXlRJyhTD5hUQdYsWGBFOb6YZgaSlLkZV3rnQhs+5kxYlBMJ
         kAwz4t+va0o1zg4O/7PmLTs/AgAZweQgq+N7KcW5Ls3D2+CxdSeDNqdBJddUSeQpsc1k
         d1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154960; x=1766759760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJ7RnbCsbqZV6SdekFc9SD1k8esD4C11UGzA5IGxZCQ=;
        b=SMbkXKlk6g8IeOvFeg3PfTdQLnMPGYdZ15V2H48JCnxe3mv6132w4VhkMoKVzsjXyB
         35sku8jDeFcuQN1tVvezOeeVy7yIta9mKZSFuNAzo1EEC3iTJ6GoxBsTpmZ/JurLtVve
         LpwwhD/8FiaHwB5pdU6jIz+K+2fxqCe7xoG7/tXX3wmBghoi3fUZVOagDCdi/5UHGvu3
         x/NRLn49wcn7HWX1Vi7WByHzymqRWOQJA52qhCbk6KD/74MBcvJDJMIrzXgj42YJza+6
         ohUsIDyKnZo1NvachcMl7xQ9zHA9gwsJbmFtPhaD1TAQoxP8j4jULNRD1YrwgUWNmzU4
         SeKA==
X-Gm-Message-State: AOJu0YxnS50lvYHyHOxWl8sUMCzFyHSwTKzR//ZNX5CaumhLfSBFd2hv
	Vd5ZttnK7pvrk5/uvHYyaKr9YzRm0Cl3XLeLKF6D48YeV8bTtbt6g4n6spN+awLUzF5Eybrk5xz
	YStA5TPoZ7ZmogUK2jJTMLREnJliJL/H/+aDu1XF688D5i75gLypzIdA5l7Q5qk02HtkTW9w=
X-Gm-Gg: AY/fxX57hhwhMlqJcC3HBPB19T+CfLnA0zZ3HVjxXN4djiLDpUK1iQMyqHkN5h96wxo
	BmxVA0AkoY0NtjORXUvbH+XtCyjcAjkkmfJ4qjFfEMcwDXqzoYZIRgnm/5tmrzsFQ7Y9cH8ZWCW
	Ue0OTScpdYW9xDthBicyQyvqGX8V5H6GyHcU5AcKAgmKifR+tn/Sq5THP16/6ZgHKuMej4ScIw6
	4crKtwm3RYR5ZKhAGPoBszelK8leBjvetr9naOpTUeK1I/O1u1JlEi2GV2zw6djVsgyt6VG95Na
	qwgXB/RKVhF+PBM7kNlYmA1T/87UIKLJ0k5wWiNbdNSxh51ssxGWxFjmOgnxjG1m3ZZt10nFQAS
	ql24XN4IAY3evsBM75dKRwz6HnxmBnfe+cxdWgsmHlEwG9T9A61jMKcMgR352s8bbnbxj
X-Received: by 2002:a05:622a:64b:b0:4ee:4128:bec1 with SMTP id d75a77b69052e-4f4abcd0634mr42477771cf.1.1766154960554;
        Fri, 19 Dec 2025 06:36:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE14Hdyk6PYivkSsJrsYsK8HqoPfU/tUKnkUGbL/VoSc0mjAxe4s8KppQKyl06O0O0KHLdlBw==
X-Received: by 2002:a05:622a:64b:b0:4ee:4128:bec1 with SMTP id d75a77b69052e-4f4abcd0634mr42477181cf.1.1766154960101;
        Fri, 19 Dec 2025 06:36:00 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:35:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 15:31:52 +0100
Subject: [PATCH 3/5] iio: adc: qcom-spmi-rradc: Simplify with dev_err_probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-iio-dev-err-probe-v1-3-bd0fbc83c8a0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Wr5/vHqfZ3Gkfva2+k6ouaLP7uADJ4+N3dLFOeSScgE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLGmaXpsHKPVC+KP0GNHBF5FoyjkihTiGxVO
 0Wee7mEOLWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUVixgAKCRDBN2bmhouD
 1+tgEACJ9D5sTugYsbqYRRJ6CCQ3oNlqtf0R6GLUE4ytsf+XShS+0sC96+5R0EPmCZpzonwX3st
 rWjZ69pIrqkt8vi4/NGrDPo+3Adjwd+2aLuHyS3q5Zw2Mc1d6E+ZTr5VZuBvmK2h0A/+cLZOPaO
 LGen8z3hLH9M++ar0raTYwYjDOcIXvy/glGwyDie9kEZ0JFaLnCnQHv90k5gUAKx3G3V0zNHs4t
 jVLznzV0/bHuDILNvP3IC7IJIWbHSuj9uucQ452vB0a62/l9JI1Q/1UwDWU4oqSH8b7Nl+J+/j0
 ZmpCOAxvxAAttvndseS8PXRQcwhYfFublNu/KXHm8PcaDvkoPbtSP/9i/dOu1iUvznZfTwSdC9s
 5Smcy3zfm3Bkh4XKngX0bmVZN+5u2QFQAR6x4FrvtIMUKsn39QYc5nz9Iu8GE5RSIHZdPyK8NuP
 yWhRFxNJ6oX2Q1dPpYJO8vcm5MGfYVZC7+N2rCgl5u9M1NPv/8qmnFo+3/rdI5V/h2f4wXQcqII
 kkH49dB7Alz57gNeRKF27a5Gf/kY0/Fev/xjxyf77JZ+p+OUIDtgPgXX7/Oo9vWSkmWez62IGUM
 DRPR+FwkGYwPEUhasoSN5DCf5E0a+8HWt2Gm+zAX0hsAOUYNptE4rAXqrrr5Xxe1umf1ksteQNc
 q+XIrxE906tgOgg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfXyh5iidJndflq
 SqJH2OXSjbQGMEs2DfnfUernEZXfQh7cLAnfCU38b+cnDSWqDD+P4qK/eKz426/WEhqXENzMLGy
 1txXJL6F7MGrRfdPGLkNz6R9ro1LJVTMlbgKe766oJm13Dqf2zzaYuBMnAP0jIxOiMM1mVTnipn
 eQGg0NAzm/Ebg6nHcyrbfze85ZM9ajKukXxhxi9bodiqhvMNznXZM1Uj9O1Uhw/a7KWMqTM45Y/
 A2IzRcUcRIdlmqUY107h/JYQwCyNOYVuLUae6g/XyWz5isViLPcCQUZnEUmjvhrRMnXeIUYXRPp
 9O72z6UqdZXtlLIcq3tW9QNKudHh4k6K0SmhEpNMGJEiEO7E/nvCQ00Hl81fC/uFo8qzjD7eb9/
 bgdFG9WWlCp0x/7rpii582+xReqfY6222LzDdrON8KQCHNYasSjoYUHUIrzpqkrs07U6BlrFW+o
 AunI4bh2mYHHTsHq1bg==
X-Authority-Analysis: v=2.4 cv=W+c1lBWk c=1 sm=1 tr=0 ts=694562d1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=AYNcBwFTG3nuAf8aWDwA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: IZHOCqzou--oNW5ubUGCI7WsPDDv7_X5
X-Proofpoint-GUID: IZHOCqzou--oNW5ubUGCI7WsPDDv7_X5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-rradc.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-rradc.c b/drivers/iio/adc/qcom-spmi-rradc.c
index b245416bae12..8e75665204d1 100644
--- a/drivers/iio/adc/qcom-spmi-rradc.c
+++ b/drivers/iio/adc/qcom-spmi-rradc.c
@@ -934,20 +934,15 @@ static int rradc_probe(struct platform_device *pdev)
 
 	chip = iio_priv(indio_dev);
 	chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!chip->regmap) {
-		dev_err(dev, "Couldn't get parent's regmap\n");
-		return -EINVAL;
-	}
+	if (!chip->regmap)
+		return dev_err_probe(dev, -EINVAL, "Couldn't get parent's regmap\n");
 
 	chip->dev = dev;
 	mutex_init(&chip->conversion_lock);
 
 	ret = device_property_read_u32(dev, "reg", &chip->base);
-	if (ret < 0) {
-		dev_err(chip->dev, "Couldn't find reg address, ret = %d\n",
-			ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Couldn't find reg address\n");
 
 	batt_id_delay = -1;
 	ret = device_property_read_u32(dev, "qcom,batt-id-delay-ms",
@@ -975,10 +970,9 @@ static int rradc_probe(struct platform_device *pdev)
 
 	/* Get the PMIC revision, we need it to handle some varying coefficients */
 	chip->pmic = qcom_pmic_get(chip->dev);
-	if (IS_ERR(chip->pmic)) {
-		dev_err(chip->dev, "Unable to get reference to PMIC device\n");
-		return PTR_ERR(chip->pmic);
-	}
+	if (IS_ERR(chip->pmic))
+		return dev_err_probe(dev, PTR_ERR(chip->pmic),
+				     "Unable to get reference to PMIC device\n");
 
 	switch (chip->pmic->subtype) {
 	case PMI8998_SUBTYPE:

-- 
2.51.0


