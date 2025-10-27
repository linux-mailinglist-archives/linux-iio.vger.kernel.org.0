Return-Path: <linux-iio+bounces-25508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60746C0FA3F
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 18:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1D294E95F1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684803161A3;
	Mon, 27 Oct 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b="G8elBviW"
X-Original-To: linux-iio@vger.kernel.org
Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE831691D;
	Mon, 27 Oct 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586172; cv=pass; b=qklibfb9BCHoFwLdD67veQyBwKgd9jBHDZHAdE+qcTCzk2PEIQVqJ6JSfaCwKIy9RRft8UVVH3p8MEeJgcOKLpcjfA5gmPfLDt5t7597qvEwVRCy/hwcmXt4DzUV5X69S4afReZEVCiLlTbd9adWb92+HlYfTmedwnIfn3QgEBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586172; c=relaxed/simple;
	bh=qzz6E00xA9t6vtrmU+9J0q5XJns0DPtLVoRWIlks70s=;
	h=From:Subject:Message-Id:MIME-Version:Content-Type:To:Cc:Date; b=CWP5HO8XNM80fRhuRA3JMDCyM26I5PtlktTL/jvYuvMpJFZChcUp0ipl5E4Lmk7ksUaj8uzUoLklVwBpbguKuGFJpDwK7m2M9WX2GUVDa/46dMOdTxfdiCCR8E+kBqzqLPbU4ehlJM6c9N7dN1yogpJE/gfXw3RrrEUXT7/uWTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com; spf=pass smtp.mailfrom=smankusors.com; dkim=pass (2048-bit key) header.d=smankusors.com header.i=@smankusors.com header.b=G8elBviW; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smankusors.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 16885422604;
	Mon, 27 Oct 2025 17:29:23 +0000 (UTC)
Received: from fr-int-smtpout26.hostinger.io (trex-green-6.trex.outbound.svc.cluster.local [100.120.23.87])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id D1C7A4219A9;
	Mon, 27 Oct 2025 17:29:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1761586159; a=rsa-sha256;
	cv=none;
	b=LQ5oPIxmgWFGQobAemsPSRyvqdWnnl0Y+9d1qhuIYTIcxW7pB4pNb2YnmDtXpjytRbD+hE
	MJggRdcTt92GdCLzXoHXNHL+RzQ2WQE3ODoOkHZwWOKJHl4N8RNqPoufl3c/VO+v1h4t6N
	A8RPsUvatgE62jCs00GDWixtLk9/ftqQSKBot7RMj84lXDqVWlmKsTymUHl4LbQpS9LUt4
	z6uNUMdfCC7/OG+iId5SreB8jVSoZPRuE4e7W8Kvwpm6q8mDLRmRLjfxq/Ckjg83wevRvo
	oWUduHe5bSAaXobp1ncSi4OYuR+Y/A2CuzOocRhH9rM+0Hrhk2BgOdjn+b7UeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1761586159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=p08yqPntUTQZeYlAJsVW8n1xBg5hr1yGkg6u6II7up8=;
	b=mIgEZds/YZCuRz6Br7TcDXwbr6GH/8QmQMZW016bZF/N/HUHi5YITw1ByoU0ijlhzBM+3I
	c8qIf2/atKszJmXx8901icLsjuv3JL8DTalVAGUxOSfTvnp6flGnGVXf2+RhX+COWWydlR
	dlu1L99Fc3iYzkrH58UomgVigDWw8C8GDlKZHyGsIpe8IarUebcWjeppF1eXf/wj1zcXOB
	rQliqPcCL1AxtBuxYKhu4YeLRgElNu5gmGPVqrJmQ9ybq/IGJcZ8mxg44jOXS/Wp5r35L+
	G7x99EZLx91og05yq+GhYI3vg7u27iQI1fgOOsqPCosjQ3xO94LQsJala9liPA==
ARC-Authentication-Results: i=1;
	rspamd-674f557ffc-xtz67;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=linux@smankusors.com
X-Sender-Id: hostingeremail|x-authuser|linux@smankusors.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|linux@smankusors.com
X-MailChannels-Auth-Id: hostingeremail
X-Bitter-Rock: 0adf0069516c7703_1761586161631_1007378045
X-MC-Loop-Signature: 1761586161631:500873360
X-MC-Ingress-Time: 1761586161630
Received: from fr-int-smtpout26.hostinger.io (fr-int-smtpout26.hostinger.io
 [148.222.54.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.23.87 (trex/7.1.3);
	Mon, 27 Oct 2025 17:29:21 +0000
Received: from [172.17.0.2] (unknown [36.79.119.172])
	(Authenticated sender: linux@smankusors.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cwL8p2FlVz1yQm;
	Mon, 27 Oct 2025 17:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smankusors.com;
	s=hostingermail-a; t=1761586156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p08yqPntUTQZeYlAJsVW8n1xBg5hr1yGkg6u6II7up8=;
	b=G8elBviWZHUj6U3fqJkmVAkcxopsBHl1ucPK5ghOwXrrwfm/Wdyuju7HwWGKRIIF5mI5Wa
	HP6ePcZWzpm7fA0b1D9BImvT83gVXTY3dMhFUZOkVN6ttVjKZVe6O7TGrGgbwc9bXnw6xK
	KI3IUO496TIXtnp8J1ro0msITZpGhr4EwkChwPSGwEK3PFbTFaV+GshG7xNPur51Z7bmjd
	2VwaEcXA8NK78c1Vl7VHSAcYBlgb43A+C+dpVmUgQXfohtc7I/uoXOdzrTmk+hOAjC1IAC
	fgriiH97p4ZiyLdR8UyqMOcUXauwCJHWVEL4IJa2sYMZs0swbOUy87pdfd48Jg==
From: Antony Kurniawan Soemardi <linux@smankusors.com>
Subject: [PATCH 0/2] iio: adc: qcom-pm8xxx-xoadc improvements
Message-Id: <20251028-pm8xxx-xoadc-fix-v1-0-b000e1036e41@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANKr/2gC/x2MSQqAMAwAvyI5G2gLYvUr4sEl0Rys0oIESv9u8
 TgDMxkSRaEEY5Mh0itJ7lDBtg1s5xIOQtkrgzOus8Z6fC6vqqj3sm/IorgOnj2zM9z1ULMnUtX
 /cppL+QCFFhimYgAAAA==
X-Change-ID: 20251018-pm8xxx-xoadc-fix-b98f8ff20f57
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Antony Kurniawan Soemardi <linux@smankusors.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761586153; l=1212;
 i=linux@smankusors.com; s=20250609; h=from:subject:message-id;
 bh=qzz6E00xA9t6vtrmU+9J0q5XJns0DPtLVoRWIlks70s=;
 b=8XkCkP8sfyg2R6J363NWiQZpLy+zCldhNLnA2F6TwHfiH0/VEIwtSgl/VcjpLFa/1ap6oRqaR
 9lXu3K7nw8lDtJB+b3xxMREiwDEsNjJXQ/qfKtqkxVqleRhRmGGNmsz
X-Developer-Key: i=linux@smankusors.com; a=ed25519;
 pk=65wTy06fJl2/h/EJwjr704YG+yjHFhZObJBWzzK+N00=
Date: Mon, 27 Oct 2025 17:29:14 +0000 (UTC)
X-CM-Envelope: MS4xfO4+DKraA2NJlhHLwY5JqFHKZg7K2JytXIutdnPBTirCCMJoMmkAVTlVCNy/yzYUqhIiNz7puZz4z/h+ZaMHNiXIY2u0sqsYqal7FvP/EgWJv9mzDjHo x28/gvvySnyJEoXgDD6JmMCNHLiv5e6Hv9WKhbUgA77vyKfEsEfBuHPytPcxUQJUfuKfM9tUtvJ26hPoGtKpSjSz2yuQE8lODeKdNEuljyUd8B+RrCFWt8xT u6Duczjx9Ont+dmKy8PFyNVCti2mqVXn9Ll9ZXv++y27v8Ut7Hl+R0P2kZ4wfcrt5fyX3rQu+fpC5VSG/b4UkKS5pz+dFSZeZ35vPDCJBtEBtnnRn+mVAAmW NeKpGdhOTOiHRiE/vyM1SHGp++v92GC7C2rB7SgU+qvi1Qe4fdQONY00tcfC5OFeRlZD26eb
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=68ffabec a=pMbO/JROBRbC3Cu+MWauHw==:117 a=pMbO/JROBRbC3Cu+MWauHw==:17 a=IkcTkHD0fZMA:10 a=wxLWbCv9AAAA:8 a=w0N0mD1D1C72E1BuyOwA:9 a=QEXdDO2ut3YA:10 a=QJY96suAAestDpCc5Gi9:22
X-AuthUser: linux@smankusors.com

This small series improves the Qualcomm PM8xxx XOADC driver in two ways:

1. Adds support for reading channel labels through sysfs.
   This helps user-space tools identify ADC channels by name.

2. Fixes incorrect calibration values used on msm8960-based devices.
   Previously, the driver failed to apply the proper ratiometric scaling
   and incorrectly set certain bits in the ADC_ARB_USRP_DIG_PARAM
   register. This resulted in inaccurate voltage readings from the IIO
   interface. With the fix, calibration values now match downstream
   implementations, and readings for channels like USB_VBUS and 125V
   are correct.

Tested on Sony Xperia SP.

Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
---
Antony Kurniawan Soemardi (2):
      iio: adc: qcom-pm8xxx-xoadc: add support for reading channel labels
      iio: adc: qcom-pm8xxx-xoadc: fix incorrect calibration values

 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251018-pm8xxx-xoadc-fix-b98f8ff20f57

Best regards,
--
Antony Kurniawan Soemardi <linux@smankusors.com>


