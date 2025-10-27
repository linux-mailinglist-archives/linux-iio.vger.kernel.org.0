Return-Path: <linux-iio+bounces-25510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C04C0FB14
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 18:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88900428413
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004A63168FC;
	Mon, 27 Oct 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b="h9BnXV5n"
X-Original-To: linux-iio@vger.kernel.org
Received: from caracal.ash.relay.mailchannels.net (caracal.ash.relay.mailchannels.net [23.83.222.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEC311C38;
	Mon, 27 Oct 2025 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586572; cv=pass; b=opMOJmUC+NREuMzpc8rvGSOM3wRkCRf7ESEJ8GL3D/Jumfn3Nd+jCYzpWopsKCcyQIcqI6PKYYCxN1HubX/qW0n1+OOyNL6C9GLXBnw7oM8tTQqijX2Hp9D2WdlAiwkrchVvAFy107m+zf6JncvOWcSAssgTXzZxsPZSKVj4GA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586572; c=relaxed/simple;
	bh=cLgnUhjqtxE3ue8jKNO8wJhYJ2MVAbCV1AutJE6+Kcc=;
	h=From:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc:Date; b=LW63G5jd3ou71I/vKNgfEtax/gA9aep23I0FLyV7rrNm8GZMFY5G3P9n8XrIB5e5ZDpjUmGoIhUVgDlRQN08m+RqvLnBpzswlBF1+UDJuX7otG7kicSJMic6GiKazgV2ACMzrBWIGDvfmT78rRjGuHlXA0JjDUyuzVl4Gq5E8us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com; spf=pass smtp.mailfrom=smankusors.com; dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b=h9BnXV5n; arc=pass smtp.client-ip=23.83.222.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 965F9435BB;
	Mon, 27 Oct 2025 17:29:24 +0000 (UTC)
Received: from fr-int-smtpout26.hostinger.io (trex-green-3.trex.outbound.svc.cluster.local [100.121.22.161])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 33FCE42548;
	Mon, 27 Oct 2025 17:29:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761586161; a=rsa-sha256;
	cv=none;
	b=4ywgjDUys5GOtl10dwTBpb55GXBGsC5fWsj8HaRP+Ql63Pi9PBK+qI9dh+2aE07GZd9hWr
	F9gsO26L4cSubL/9BtncToumo18OjusmVIuPH0c9qNB2dWq3nGVOJaVhS4MpP/IHtXPL66
	548S+AdzeqbIzo3DTu0FwwXW3uCT8FhW07h01xPeyyPDYkUmt2ffMqXA7oAWyVd1JPPsu3
	tsagJVvuQt2b67R3chgymC2hE55Bw/miAjy61H2T6zGGdIoQp/bnT9Fv65BT1ke7zyr252
	B60azHZPjpxDhXJTNYvjewS92nWOql8Dvy57uhSShKNi3IxWthMa+fd2rjwWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761586161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=F2+pEBigQD6/8zIYsLrP/KkObLZsezWI/xcTfxleyR0=;
	b=f5QR8O8Zj4U9Ck+gLSJopSw+F7HptXN+0IYhBbUqDLAhTica5/nxHz1JdDSP69qJJW0FS8
	Q5N12ljRXfhjVI23ybYtRZjfUtsqLkYVAKX1Q86W/jcePEZASihnn3/u/9v0AQkpHDiXig
	i5m5H6DncWrkrjM2arzLNFixgao+c0nEKQvZvZI7YSb/dVeMU3gAKhzjv+HjU6QYzJwdIG
	xhpgHyxazJy6iPmt/OgoKNKQy1UCcdHCXPs6+7yqKNCoz0RfqBPevk7XP/wxRseQyMa6Nj
	ZsNVk5U2hjGX+xr0ymhFxz1/53hdFfLQ4oc7M9V38Au5TWPCkk1S/uCZ2kIrYA==
ARC-Authentication-Results: i=1;
	rspamd-674f557ffc-ggxpt;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-White-Obese: 33e60b38779a72b4_1761586164371_3076747356
X-MC-Loop-Signature: 1761586164371:3950152993
X-MC-Ingress-Time: 1761586164371
Received: from fr-int-smtpout26.hostinger.io (fr-int-smtpout26.hostinger.io
 [148.222.54.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.22.161 (trex/7.1.3);
	Mon, 27 Oct 2025 17:29:24 +0000
Received: from [172.17.0.2] (unknown [36.79.119.172])
	(Authenticated sender: linux@smankusors.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cwL8r4sNCz1yRM;
	Mon, 27 Oct 2025 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
	s=hostingermail-a; t=1761586158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2+pEBigQD6/8zIYsLrP/KkObLZsezWI/xcTfxleyR0=;
	b=h9BnXV5nULUPspx2hlErnjahUp/+GYJs7ybgnr+is7OwlSworBBm7GErnXkA0XaiSeAJ9O
	BxtGfvx7OZDpv/whAd99+AnJzBaPraRkcvodTnCePdptWhzGrEPRmmv5vizinQw54LcYsL
	L9kME3PM4soEVDO2qVV83UAQd2wMwMbJkpW+RxPtITm3PXVUY5Sy/QQIm3NV7TFASisQML
	42csLXr658lGHKkORcOym8hL3/Y6lot3SJHKbZJIc5j936gJNdBHmuZOgz49Ld4GSTiuJK
	wMYsOyngK8aHTJ6f0K6GkQq3TAAv2PX9JKMAoPy2oetTR9El7D/Oy2crTYrwYg==
From: Antony Kurniawan Soemardi <linux@smankusors.com>
Subject: [PATCH 1/2] iio: adc: qcom-pm8xxx-xoadc: add support for reading
 channel labels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-pm8xxx-xoadc-fix-v1-1-b000e1036e41@smankusors.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761586153; l=1001;
 i=linux@smankusors.com; s=20250609; h=from:subject:message-id;
 bh=cLgnUhjqtxE3ue8jKNO8wJhYJ2MVAbCV1AutJE6+Kcc=;
 b=J1PsCFJ5naQrve/LXDo3Zk5sQblR8vddMr5/l7ma3rJJKhMestCoJ/uQroUOL4lCAP8XjoIaw
 h6fWOfa2SFSAgZehYofVgHf0DAaJ/RtQq0Ml40lmLDiRZwHsD2rCIfa
X-Developer-Key: i=linux@smankusors.com; a=ed25519;
 pk=65wTy06fJl2/h/EJwjr704YG+yjHFhZObJBWzzK+N00=
Date: Mon, 27 Oct 2025 17:29:16 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=68ffabee a=pMbO/JROBRbC3Cu+MWauHw==:117 a=pMbO/JROBRbC3Cu+MWauHw==:17 a=IkcTkHD0fZMA:10 a=wxLWbCv9AAAA:8 a=9BUqChrCs0__dafhRrMA:9 a=QEXdDO2ut3YA:10 a=QJY96suAAestDpCc5Gi9:22
X-CM-Envelope: MS4xfPMhP95yGjIFAld3TRf7KDkocukmG/asDfa12NxNEHZP5paIuOsOXNoUAuBETV9vvx8v3ihJRMKemz7wJ4l4SDlNNfy2DYcmKZuW+c4dd5KnfWvBSG5l ryt0fadibaqLtPlw6dWeb4eSzOdkYkKh9sqE23GSkz/lwG9xNP+vUt5uKiwUMjaICuIfnKHGe6FkNPnXK+mp7CT7Jh5NXR/TTBXdD9KvkBfQU1oHBjXZBz0v RMqvGBQ/3Kf6HvnQbRBn8yrUGx/5KLVMP8itc61IqNmguwvGwMxQIDvu4Y3laJ7vfURA+uWWPAQvnK+CbhzPT70uBKr81CHNDl//k3QDTJaW/J4Q80Lg5j3L oIfXf8gMdLFAQG6S84o/DoVq8cwmZtbgA0+iNLCsFkIcuJ+x9g/cHO9sOM0A+ztejz/q7jkF
X-AuthUser: linux@smankusors.com

This allows user-space tools to identify ADC channels by name through
the IIO sysfs interface.

Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 31f88cf7f7f18297132d152648b312c0fb60608e..8555f34036fb13c41ac720dc02c1dc39876e9198 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -725,8 +725,15 @@ static int pm8xxx_fwnode_xlate(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int pm8xxx_read_label(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, char *label)
+{
+	return sysfs_emit(label, "%s\n", chan->datasheet_name);
+}
+
 static const struct iio_info pm8xxx_xoadc_info = {
 	.fwnode_xlate = pm8xxx_fwnode_xlate,
+	.read_label = pm8xxx_read_label,
 	.read_raw = pm8xxx_read_raw,
 };
 

-- 
2.34.1


