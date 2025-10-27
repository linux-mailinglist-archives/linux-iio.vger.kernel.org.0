Return-Path: <linux-iio+bounces-25509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10AAC0FA45
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 18:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C1E19C6870
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E48B3191C2;
	Mon, 27 Oct 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b="igZcA8O3"
X-Original-To: linux-iio@vger.kernel.org
Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F331814A;
	Mon, 27 Oct 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.253
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586175; cv=pass; b=TkHnVr4BvfCQZxNIAkQX8IMoh9UIPpKAuxkHf3xlupGupkhnEgcEM2TyGxz6Y0x3yRfOEl1wKTgerUHRYFMswraUYrH5v7YB8efnE6QFlklAmKpXbZJdbkf03th9MnnuRt+LMcAJyJ9g1cFN/nF5MSdea1fV2GEVfJnRxCpN9W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586175; c=relaxed/simple;
	bh=GgWVH8NGOYkGn6vEw8dVSaC/+r+0SZEjRo035uSx3pk=;
	h=From:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc:Date; b=IRxkzodxo6nE7itbTQm6AcEv7v6Z+8NT4EbaCLkYggd7Arli1t01czQvJOOrjjZtFOIP1Py8XRZS0xOQRKpzptU4a5/xF4cFm2c+2PqvDug9e+TyiWtmuWLw28/Z5i7asLTUhcBuu1pkzJXgWzj3iB/aCQZheUFD6vHVu6myVxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com; spf=pass smtp.mailfrom=smankusors.com; dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b=igZcA8O3; arc=pass smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 96074421F2E;
	Mon, 27 Oct 2025 17:29:26 +0000 (UTC)
Received: from fr-int-smtpout26.hostinger.io (trex-green-8.trex.outbound.svc.cluster.local [100.123.122.56])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 604DE421A26;
	Mon, 27 Oct 2025 17:29:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761586163; a=rsa-sha256;
	cv=none;
	b=vn8rzg6P/Vkept0JqXnwi86x2Wmw5xhPIsDLtugjmp57uiGHaoQfvRmKSweV7DxrBb3tLL
	WrhxTRvtVhvsHLvDm5qLxQPtWQCqLWJzG2zJfH/iszLJmtBpGA2L2DlUg134xEqF6UBsQf
	/WNxtkEnIu04DumSi+hyF0NR6HWP0X7S3T9bPTLG8u1qNGA+LaUfUM0g7bHuXCSnvN7uLs
	8B3NjHswl7WDMI/Y+1kw5KIEon8NQL6bLibcV2Lpc86P6R9LTsZIPUdBOfkwcGbYS6GyiU
	MeCySCWYC03cyYMFmdmsqnVeXQJgYERKcp4HXCMh1fv9JnOse7QvyObq4YS9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761586163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CxflxuYLZUtFq/y0lEQkBNTrp1mbu2WIcxpYcXjl2Ws=;
	b=u0d4FLLkR1SGwyjC+VbB5PT1xKimvSYXSsytneOj47R/oDy50NV4Q6+wuFOxWq2/R+cqpK
	h0bRNnuUhe6fNrsomgXbysqSVZegyoCPoXfUPTW551RPZaCLMFkWHBQj2ee5CRgKKVeS4e
	JkmVYqDoWvIGDwCtTNO7i8/ZoZZFWu/YrVJzxk8n19ybsshK0CXjKAeM2Pb1Z8Eeka4O87
	l5HwrCRLPqF+2eYhc/RvQD5TuBdI27zSzYSvbT24ZQCjWSrjBaqWcYDRhYwBZkc9irL90Z
	0kihctvOEUpk5vo6PBwxACg6KLMfRa+AoF0/GKZqAVBc87GEmuPdV7xJUbsjIQ==
ARC-Authentication-Results: i=1;
	rspamd-674f557ffc-sktqk;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-Language-Towering: 348265f158d8ebf2_1761586166143_3099727680
X-MC-Loop-Signature: 1761586166143:1005675760
X-MC-Ingress-Time: 1761586166142
Received: from fr-int-smtpout26.hostinger.io (fr-int-smtpout26.hostinger.io
 [148.222.54.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.122.56 (trex/7.1.3);
	Mon, 27 Oct 2025 17:29:26 +0000
Received: from [172.17.0.2] (unknown [36.79.119.172])
	(Authenticated sender: linux@smankusors.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cwL8t6t06z1yRT;
	Mon, 27 Oct 2025 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
	s=hostingermail-a; t=1761586160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxflxuYLZUtFq/y0lEQkBNTrp1mbu2WIcxpYcXjl2Ws=;
	b=igZcA8O3fAdj5O+x6N4MOLlb4kyG6IC7fpxld13ef6cFKql/qVrgAwMshbzDCce9tzQOgz
	Q5G5Tkhz7Itq6zzoHrj4if0vQVeo35f/Qk4nr+ilGuoOOVjDhH6pVfC4RhYstvYVdPeS24
	7JPFr/MN2v15+L6iYLGKHOuHc7zPX9eca3rQ5DN7b8DPw0Gw0SvQRpO9OxxjHk9I+Sv8E+
	WiFT6LF6I0s12yuplcjWh7tGy+j5L8clSq/rnJRVejLfrXFl1CDMnxrLcMu4jYncmSRBTD
	G4n1QQobmqOLShpHoVTm1oRTt/YoAIMBV2BNY5CkJ0qpJKDt/5Uw9OJ5pXXMgg==
From: Antony Kurniawan Soemardi <linux@smankusors.com>
Subject: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: fix incorrect calibration
 values
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pm8xxx-xoadc-fix-v1-2-b000e1036e41@smankusors.com>
References: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
In-Reply-To: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Antony Kurniawan Soemardi <linux@smankusors.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761586153; l=2514;
 i=linux@smankusors.com; s=20250609; h=from:subject:message-id;
 bh=GgWVH8NGOYkGn6vEw8dVSaC/+r+0SZEjRo035uSx3pk=;
 b=bwLG1GMA8+vdcizG70YbUcF9vuSTbX29w260Agdhl43efS21o4WHOLUrd2NdAgAQY9hwBdTIc
 d47HxC/G9BBDCAUu1UCAw0+918nRmJnr6vaB5X0DqX6ZK6b9P/AmBzg
X-Developer-Key: i=linux@smankusors.com; a=ed25519;
 pk=65wTy06fJl2/h/EJwjr704YG+yjHFhZObJBWzzK+N00=
Date: Mon, 27 Oct 2025 17:29:18 +0000 (UTC)
X-CM-Envelope: MS4xfFBzBe3D92rsrMlmPfFPT+SNEqLIcW6Z50gkI5ZV+HEYFxzf0H/nGNIkV3IfWCyIMCmORh5K7JEdCodCsVnWTFf4QcnttdzSEpoy3jYFJ7PIeL+UjuXN pZSRRZi9RqYyxLndyIllTUZkWMKr/tL9TsIkrtUiu0FoIiCFr3EnsIAypcLGnU/TqzAH6haDyNOiITuAGXudCLncFVbM+NceAGz/ekSoIYcSEXWurBm3VxwM vBaQUcJQFYZ3cYLlLYz7Nn8ukxus0mfROzzG/8EZ5vRdmbueYDn2H5aMz8oqnpLmV4BMVX9letpfLg8qjg1dH4zcAVXB1ccwC2OZR5dElXY6VAy3TfrfPavp nQg8Oh91IgOicsRTM+bBYaHZboUMZxOiU67fRtvL1H00pevtE0/XARQ0cQclB9qNDjDjNMv2
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=68ffabf0 a=pMbO/JROBRbC3Cu+MWauHw==:117 a=pMbO/JROBRbC3Cu+MWauHw==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8 a=_rrzIsRTLJWE4oTtuQAA:9 a=QEXdDO2ut3YA:10 a=QJY96suAAestDpCc5Gi9:22
X-AuthUser: linux@smankusors.com

On msm8960 phones, the XOADC driver was using incorrect calibration
values:
absolute calibration dx = 625000 uV, dy = 4 units
ratiometric calibration dx = 1800, dy = -29041 units

As a result, reading from the IIO bus returned unexpected results:
in_voltage_7 (USB_VBUS): 0
in_voltage_10 (125V): 0

The issue was caused by not setting the ratiometric scale (amux_ip_rsv)
from the predefined channels. Additionally, the downstream code always
set the ADC_ARB_USRP_DIG_PARAM register to PM8XXX_ADC_ARB_ANA_DIG [1].
That value does not include the SEL_SHIFT0 and SEL_SHIFT1 bits. Enabling
those bits caused calibration errors too, so they were removed.

With these fixes, calibration now uses the correct values:
absolute calibration dx = 625000 uV, dy = 6307 units
ratiometric calibration dx = 1800, dy = 18249 units

Reading from the IIO bus now returns expected results:
in_voltage_7 (USB_VBUS): 4973836
in_voltage_10 (125V): 1249405

[1] https://github.com/LineageOS/android_kernel_sony_msm8960t/blob/93319b1e5aa343ec1c1aabcb028c5e88c7df7c01/drivers/hwmon/pm8xxx-adc.c#L407-L408

Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 8555f34036fb13c41ac720dc02c1dc39876e9198..a53d361456ec36b66d258041877bd96ab37838c4 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -503,10 +503,11 @@ static int pm8xxx_read_channel_rsv(struct pm8xxx_xoadc *adc,
 		goto unlock;
 
 	/* Decimation factor */
-	ret = regmap_write(adc->map, ADC_ARB_USRP_DIG_PARAM,
-			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT0 |
-			   ADC_ARB_USRP_DIG_PARAM_SEL_SHIFT1 |
-			   ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
+	ret = regmap_update_bits(adc->map,
+				 ADC_ARB_USRP_DIG_PARAM,
+				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE0 |
+				 ADC_ARB_USRP_DIG_PARAM_DEC_RATE1,
+				 ch->decimation << ADC_DIG_PARAM_DEC_SHIFT);
 	if (ret)
 		goto unlock;
 
@@ -783,6 +784,7 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
 	ch->calibration = VADC_CALIB_ABSOLUTE;
 	/* Everyone seems to use default ("type 2") decimation */
 	ch->decimation = VADC_DEF_DECIMATION;
+	ch->amux_ip_rsv = hwchan->amux_ip_rsv;
 
 	if (!fwnode_property_read_u32(fwnode, "qcom,ratiometric", &rsv)) {
 		ch->calibration = VADC_CALIB_RATIOMETRIC;

-- 
2.34.1


