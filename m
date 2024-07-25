Return-Path: <linux-iio+bounces-7883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D8A93C25C
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF491F21E45
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDA19AD58;
	Thu, 25 Jul 2024 12:49:00 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D119AA52;
	Thu, 25 Jul 2024 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911740; cv=none; b=GodRePVbdEE7BxMSlboAWtOxLpqZYerfIaA/JcLzd/uP+LW+nXnKPEAFVw8GjUzF3KuocAp5+BVS8kAYAywR8/1n9+wGcV4ltrELG4siMyDfNqwKvQOcgvBbQOS3OfaVVs25AkxFZwWHo0A0wuA49fDsPTAtwo5Rq/aq+IaL6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911740; c=relaxed/simple;
	bh=fcyt51znHViXcRAwfdoP9hM6yaqdUQfl2x3m/fKXDZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEozPWFs7hvbOVvuoSSqvKGhGDWhieKhmPIHSIImpuClQAkVU81lBLoP3EnTv1qrSpbjFqb+bPGTs/0hPD0XoR31JXXjPmg3db+HMGeIug3AErfYB0cKJpGfhz8FPYiDvp3KrnAssiR2TT1ygNdkfK4K/+GW7FgAy1u/IFMGQEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07514232|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.0594848-0.00113714-0.939378;FP=7877110177032922334|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045192045;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.YZYEnRg_1721911727;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YZYEnRg_1721911727)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 20:48:54 +0800
From: wangshuaijie@awinic.com
To: waqar.hameed@axis.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jic23@kernel.org,
	kangjiajun@awinic.com,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liweilei@awinic.com,
	robh@kernel.org,
	wangshuaijie@awinic.com
Subject: Re: [PATCH V3 0/2] Add support for Awinic SAR sensor
Date: Thu, 25 Jul 2024 12:48:47 +0000
Message-ID: <20240725124847.891270-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <pndbk32vnhz.fsf@axis.com>
References: <pndbk32vnhz.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Jul 2024 13:49:28 +0200, waqar.hameed@axis.com wrote:=0D
>On Fri, Jul 12, 2024 at 11:31 +0000 wangshuaijie@awinic.com wrote:=0D
>=0D
>> From: shuaijie wang <wangshuaijie@awinic.com>=0D
>>=0D
>> Add drivers that support Awinic SAR (Specific Absorption Rate)=0D
>> sensors to the Linux kernel.=0D
>>=0D
>> The AW9610X series and AW963XX series are high-sensitivity=0D
>> capacitive proximity detection sensors.=0D
>>=0D
>> This device detects human proximity and assists electronic devices=0D
>> in reducing SAR to pass SAR related certifications.=0D
>>=0D
>> The device reduces RF power and reduces harm when detecting human proxim=
ity.=0D
>> Increase power and improve signal quality when the human body is far awa=
y.=0D
>>=0D
>> This patch implements device initialization, registration,=0D
>> I/O operation handling and interrupt handling, and passed basic testing.=
=0D
>>=0D
>> shuaijie wang (2):=0D
>>   dt-bindings: iio: Add YAML to Awinic proximity sensor=0D
>>   Add support for Awinic proximity sensor=0D
>>=0D
>>  .../iio/proximity/awinic,aw96xxx.yaml         |  127 ++=0D
>>  drivers/iio/proximity/Kconfig                 |   10 +=0D
>>  drivers/iio/proximity/Makefile                |    2 +=0D
>>  drivers/iio/proximity/aw9610x.c               | 1150 ++++++++++=0D
>>  drivers/iio/proximity/aw963xx.c               | 1371 ++++++++++++=0D
>>  drivers/iio/proximity/aw_sar.c                | 1850 +++++++++++++++++=
=0D
>>  drivers/iio/proximity/aw_sar.h                |   23 +=0D
>>  drivers/iio/proximity/aw_sar_comm_interface.c |  550 +++++=0D
>>  drivers/iio/proximity/aw_sar_comm_interface.h |  172 ++=0D
>>  drivers/iio/proximity/aw_sar_type.h           |  371 ++++=0D
>>  10 files changed, 5626 insertions(+)=0D
>>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awin=
ic,aw96xxx.yaml=0D
>>  create mode 100644 drivers/iio/proximity/aw9610x.c=0D
>>  create mode 100644 drivers/iio/proximity/aw963xx.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar.h=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.c=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_comm_interface.h=0D
>>  create mode 100644 drivers/iio/proximity/aw_sar_type.h=0D
>>=0D
>>=0D
>> base-commit: 43db1e03c086ed20cc75808d3f45e780ec4ca26e=0D
>=0D
>This is version 3, but I cannot see a description of the incremental=0D
>changes between the versions (or links) in this cover letter. It will=0D
>therefore make it harder to review...=0D
>=0D
>It also looks like the _actual_ commit messages in the patch series have=0D
>some kind of description of the changes from previous versions. That is=0D
>also not correct. Please read=0D
>https://docs.kernel.org/process/submitting-patches.html#respond-to-review-=
comments=0D
>and=0D
>https://docs.kernel.org/process/submitting-patches.html#the-canonical-patc=
h-format=0D
=0D
Thank you for taking the time to reply to my email. You're right,=0D
I did not do a good job of keeping track of the version update records.=0D
I will include relevant change logs in the next version.=0D
=0D
Kind regards,=0D
Wang Shuaijie=

