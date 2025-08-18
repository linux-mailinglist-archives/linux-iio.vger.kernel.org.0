Return-Path: <linux-iio+bounces-22911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A4AB29C76
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F1B3AE34D
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052230100D;
	Mon, 18 Aug 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZDc6gCLE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D562777FD;
	Mon, 18 Aug 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506538; cv=none; b=uienQrEFVDZeGhXvgA71VBUJT/VUiGHhJ6Q6N0epatFbOnK1v5iCtSqMH/7QTAgye82fCMztTjhAgppd7KNtG37BwCMlWoNxtn/m59wG5VskRTnuw+isIJoQWB+lMXRJMuUc69WwpCjhqeo05CysMevUUS6lCPjcA8Aa/Mpe3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506538; c=relaxed/simple;
	bh=TJt+LdGCByCQttXRtAZFgWLhLM152iGhi96Z7ZHDV5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUlmr9TLyy/6ZNjXsmbMpETcFyxhzCL8DcbDNUUGs5lhn0gGOsSvQLVllPziutQZ8FISJTV8ldCrMuH6vm6D+xuK29Pg2lbs7WuxefX3O3VwQf7xKwydA2F6jK3XOrOE3Bl+z9hGjhr0K1zErXTvaZGQJ1Abpo3LBqTZryZCpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZDc6gCLE; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1755506530; x=1756111330; i=markus.elfring@web.de;
	bh=TJt+LdGCByCQttXRtAZFgWLhLM152iGhi96Z7ZHDV5Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZDc6gCLEV4axKhnhxr58/WT8w7Mfrw+5SYWZ6EqkigupiXqfa5Ae2MXKzo4Hfu3t
	 q2XYsdPbWIi4/PbpgAnHvE5DQqEMAi8Cv9HBGWsRJECked9efqScEgReXVj+Lb4Ow
	 zyIdTxoAl4s0V8AelwWGlOtFzroWk80G1fpTVaoWYKHappD81irzhLURueu4yctWL
	 XX+mCcPIFlZLGt3AxhdbDvwpMnwjQlHeOO9eATzMnZ4P6wLljDSjjJco5/a3F4llG
	 75/aTPzv4oYxvQvdTpC2ywdsuwZttGuu5Sxa+dO51F8KLFaU7bHw+8qdUfjCCLy2s
	 cTLwjmKlxiUvWJyN0Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.231]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgibW-1uMJOn4AEm-00hZDO; Mon, 18
 Aug 2025 10:42:10 +0200
Message-ID: <89b8b9cc-43af-4f32-81ea-6f84db9c6dc0@web.de>
Date: Mon, 18 Aug 2025 10:42:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: pressure: bmp280: Use
 gpiod_set_value_cansleep()
To: Salah Triki <salah.triki@gmail.com>, linux-iio@vger.kernel.org,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250818082409.543197-1-salah.triki@gmail.com>
 <20250818082409.543197-3-salah.triki@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250818082409.543197-3-salah.triki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DxKAstrM+3YGNsf9jRXQWEZkSeaCtAn/HS13V4vrRQtdOBk89DC
 Y5UDObwI74IZQ9VYS5wF+m6mAAKlVj8qcYt/UF8opNEU951vUXln1LT6lPXSm4kqY3SeHsP
 UGicX+ZNnMfgvTv9SYUeOQBrfKsObvwql0TOMM88FJv4ESchd2dr4Y0/m92OClaMF0RmDfc
 vnV1ZleuagbuTNuknwZbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R29GTTIacIA=;RXKYcBk3c5VWG6PvmDn0pbOtcOk
 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

> Switch to `gpiod_set_value_cansleep()`, which is safe to use in
> sleepable contexts like the driver probe function.
>=20
> The `dev_info()` call has been removed as it was considered noisy and
> is not necessary for normal driver operation.

Should such a change combination be reconsidered once more?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc1#n81

Regards,
Markus

