Return-Path: <linux-iio+bounces-9059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769A96936E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 08:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2394AB227DB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 06:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119A1CEAC1;
	Tue,  3 Sep 2024 06:08:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3428A15575F;
	Tue,  3 Sep 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725343726; cv=none; b=ljITEyOfba7/a/oMiiuKBUGYH/IyTRd18dXW3kCGS8NDbpDCrNtRoncLb3/ANnR0D8Af5IXjhWKhMgJKT1u4uU+0+Dsu0Oiiad5DTOpnctTE2Z5+V2pXs0q6b01W8OyaExL6xgFWFTIeUKExDXRmmmgOthaUsuPc6DxqlBJ+gOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725343726; c=relaxed/simple;
	bh=e8wcEXurxfiJAMMrN1NhfnJxzWiWb3tiYI04c1qXU/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXNkKJi643p1k0VWOz7oV0x5vk7xyyntCZTtJ0h3KwITeWDkUyuIZsAVEGZlJHcfeWRKlY7BG42GSpdJ2xuJ32B342mc5sryctiidO2FeFZYOU5RN235bKAntJTyVhh76Mvm+dPERpAx6rQmyz0ecjMs9jr4PSqqN4jJC2tBQYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.Z9L6.2j_1725343383)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 14:03:10 +0800
From: wangshuaijie@awinic.com
To: jic23@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	gustavoars@kernel.org,
	kangjiajun@awinic.com,
	kees@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-hardening@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	robh@kernel.org,
	wangshuaijie@awinic.com
Subject: Re: [PATCH V9 0/2] Add support for aw96103/aw96105 proximity sensor
Date: Tue,  3 Sep 2024 06:03:04 +0000
Message-ID: <20240903060304.910863-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240831150724.201e7d73@jic23-huawei>
References: <20240831150724.201e7d73@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 31 Aug 2024 15:07:24 +0100, jic23@kernel.org wrote:=0D
>On Tue, 27 Aug 2024 08:02:27 +0000=0D
>wangshuaijie@awinic.com wrote:=0D
>=0D
>> From: shuaijie wang <wangshuaijie@awinic.com>=0D
>> =0D
>> Add drivers that support Awinic aw96103/aw96105 proximity sensors.=0D
>> =0D
>> The aw9610x series are high-sensitivity capacitive proximity detection=0D
>> sensors. This device detects human proximity and assists electronic devi=
ces=0D
>> in reducing specific absorption rate (SAR) to pass SAR related certifica=
tions.=0D
>> The device reduces RF power and reduces harm when detecting human proxim=
ity. =0D
>> Increase power and improve signal quality when the human body is far awa=
y.=0D
>> =0D
>> The specific absorption rate (SAR) is a metric that measures the degree =
of=0D
>> absorption of electromagnetic radiation emitted by wireless devices,=0D
>> such as mobile phones and tablets, by human tissue.=0D
>> =0D
>> This patch implements device initialization, registration,=0D
>> I/O operation handling and interrupt handling, and passed basic testing.=
=0D
>I made one trivial tweak to add static to the iio_info declaration and=0D
>applied to the togreg branch of iio.git, initially pushed out as testing=0D
>for 0-day to see if it can find any issues we missed.=0D
>=0D
>Thanks,=0D
>=0D
>Jonathan=0D
=0D
Hi Jonathan,=0D
=0D
Thank you very much for your help and suggestions, which have been very=0D
beneficial to me. May I ask if I need to continue modifying my patch?=0D
If not, please inform me of the approximate time for review and merging.=0D
=0D
I look forward to your reply so that I can better plan my subsequent work.=
=0D
=0D
Kind regards,=0D
Wang Shuaijie=

