Return-Path: <linux-iio+bounces-27183-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E10CCC6B7
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBA623054F47
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75C734B40A;
	Thu, 18 Dec 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Bw9n/jqo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DA34B1BB;
	Thu, 18 Dec 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070751; cv=none; b=NmIz4wylHoBsqEnL1vp9AajdurAPtGrGTCXV/1+ANw8z1RkvXoFnyHhu0kcEFXXvhitD1xG8LYgqLcUxeANLqEshaA6PORzuK4DLLXR2H2QDblOL/gmjmA0huixOFrvtJdqX7d1AHg/sGp9sK+9k8wCA1LZQBOWUKbCdScOACkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070751; c=relaxed/simple;
	bh=ROprzKBNCh7xNHTUI/fB9TRyI9lDSGpK2AjzOSfEwU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W571WUhIHMAfJmUq43sr9SY0nGvmyF1wVrVzjdu5mQ49RyWq5d3wpFfcD501ifiiSY2X0p9EQOLgsxAsZ67vFR+ZWxVA3MyUqPVq2fr7duQPceRCsWS4uei9vlAI0XISf4NAw1Tw4LS4CJzxZSDk9aLKP3PkJ2vZrej+AFJueOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Bw9n/jqo; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1766070745; x=1766675545; i=fiona.klute@gmx.de;
	bh=ROprzKBNCh7xNHTUI/fB9TRyI9lDSGpK2AjzOSfEwU4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bw9n/jqovOqLea+4NW42KdDo5JDAcDXICLPOM+8loZ2Pxg7aeXCMWQJIF8zeDvnL
	 AtjaB5Su0fmEjNEEPevX4c1p/s2JPunIyJUU4tDDQSVERcW7pT/PdVFvrUZ2wLsvl
	 KvE1uZpF5uZdeJ2QVxNo2d5I5jzMEeSTmI6Gf1tdJuFUr+pIk3OvzYM7MB+1ffsZw
	 +nx+WjrQs+nPVHiCH7dy7DkW7/UpE3VsnYlzqEyZfqPjLEuOFLkYgUeaaXI4ZIMQq
	 aZUbRcMvSUETeVGRBGe0ztNT5iQAfoi2+lq5beRNcCPKGqXaPbIiPnGFizjX4z2dh
	 w7asRFTYfgz8TpIxwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.home.arpa ([85.22.23.127]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQv8x-1vIpn42J0R-00Hf93; Thu, 18
 Dec 2025 16:12:25 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: Roan van Dijk <roan@protonic.nl>,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH] iio: chemical: scd4x: expose timestamp channel
Date: Thu, 18 Dec 2025 16:12:05 +0100
Message-ID: <20251218151205.1301792-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:K8YDiefE3E879jQU9drmvJ4D3Mo83XwHu7bDVzSDy3LZNXOKycW
 zchKjjF6gROk5ECEwUXuQ72af9WzLolfIj4wVmR2JOIXhiSlcfdSWKIk0hc4SWjosVQuySt
 DwTwYjdws5nZcfVCQwLG5EWzGER4q3ymB3YcP3se1SJ4qWDjo9fykIA90jOW6ra6bEsYh3W
 oxc8M8SO9OZk4CSrSdrtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OHODjzonaUM=;igI24g0qnez94o+vPtXzSoGjZUH
 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
 a85IsI5c=

VGltZXN0YW1wcyB3ZXJlIGFscmVhZHkgd3JpdHRlbiB0byB0aGUgYnVmZmVyIGluCnNjZDR4X3Ry
aWdnZXJfaGFuZGxlcigpLCB0aGlzIHBhdGNoIG1ha2VzIHRoZW0gYXZhaWxhYmxlIGFzIGEgY2hh
bm5lbC4KClNpZ25lZC1vZmYtYnk6IEZpb25hIEtsdXRlIDxmaW9uYS5rbHV0ZUBnbXguZGU+Ci0t
LQogZHJpdmVycy9paW8vY2hlbWljYWwvc2NkNHguYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vY2hlbWljYWwvc2NkNHgu
YyBiL2RyaXZlcnMvaWlvL2NoZW1pY2FsL3NjZDR4LmMKaW5kZXggMGZkODM5MTc2ZTI2NC4uMjNh
MzI2ZmI2MmE3ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9paW8vY2hlbWljYWwvc2NkNHguYworKysg
Yi9kcml2ZXJzL2lpby9jaGVtaWNhbC9zY2Q0eC5jCkBAIC01OSw2ICs1OSw4IEBAIGVudW0gc2Nk
NHhfY2hhbm5lbF9pZHggewogCVNDRDRYX0NPMiwKIAlTQ0Q0WF9URU1QLAogCVNDRDRYX0hSLAor
CS8qIGtlcm5lbCB0aW1lc3RhbXAsIGF0IHRoZSBlbmQgb2YgYnVmZmVyICovCisJU0NENFhfVFMs
CiB9OwogCiBzdHJ1Y3Qgc2NkNHhfc3RhdGUgewpAQCAtNjE1LDYgKzYxNyw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaWlvX2NoYW5fc3BlYyBzY2Q0eF9jaGFubmVsc1tdID0gewogCQkJLmVuZGlh
bm5lc3MgPSBJSU9fQ1BVLAogCQl9LAogCX0sCisJSUlPX0NIQU5fU09GVF9USU1FU1RBTVAoU0NE
NFhfVFMpLAogfTsKIAogc3RhdGljIGludCBzY2Q0eF9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRl
dikKLS0gCjIuNTEuMAoK

