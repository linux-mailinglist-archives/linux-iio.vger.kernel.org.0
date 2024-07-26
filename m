Return-Path: <linux-iio+bounces-7904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C493CE00
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F05D1C2114F
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 06:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1B1741D2;
	Fri, 26 Jul 2024 06:13:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06515666F;
	Fri, 26 Jul 2024 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974390; cv=none; b=r84T3hiz+qm+ixh8JJQ85Lfjqyae2bBGMLY7RtwuS+YBLFjn+f/tkFz3Vu41fNcr9gTEthx5LJ84xy3F7wQRBE2Yaucs1KsOIjnQ6zJAbVBZmoAspxa7X5Qa95FvubQbQcsYjvBNnYpp5TO1pvBtyYGUlsr7fFjgHBnXT8m+ApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974390; c=relaxed/simple;
	bh=oht5wu8auXZvkzrBwGhUiAVrI5TPXLIHnZkD3aaRoz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFLA4uy2LR7R90f05HC2er6vsICzAAdGyDtBThwsRBEEv75uswG20I1j2YJgBrrJU3DEz1fc4tbznr10Hq9bfX5Fl16hbSf8528kDUYrtsxacjVptCSq0F84a+PfwlaPKD5TGT2rjgk8gputLZe1z8Y3ivMXa7yyhRVgfUmEmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07492529|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0178663-0.00163005-0.980504;FP=7877272725547918842|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033070021176;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.Ya96w9E_1721974363;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.Ya96w9E_1721974363)
          by smtp.aliyun-inc.com;
          Fri, 26 Jul 2024 14:12:50 +0800
From: wangshuaijie@awinic.com
To: krzk@kernel.org
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
	wangshuaijie@awinic.com,
	waqar.hameed@axis.com
Subject: Re: [PATCH V4 1/2] dt-bindings: iio: aw9610x: Add bindings for aw9610x sensor
Date: Fri, 26 Jul 2024 06:12:43 +0000
Message-ID: <20240726061243.1371100-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <d9e0e87c-0332-48b3-879d-258ca0fe58ee@kernel.org>
References: <d9e0e87c-0332-48b3-879d-258ca0fe58ee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jul 2024 15:54:10 +0200, krzk@kernel.org wrote:=0D
>On 25/07/2024 15:17, Rob Herring (Arm) wrote:=0D
>> =0D
>> On Thu, 25 Jul 2024 12:12:51 +0000, wangshuaijie@awinic.com wrote:=0D
>>> From: shuaijie wang <wangshuaijie@awinic.com>=0D
>>>=0D
>>> Add device tree bindings for aw9610x proximity sensor.=0D
>>>=0D
>>> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>=0D
>>> ---=0D
>>>  .../iio/proximity/awinic,aw9610x.yaml         | 61 +++++++++++++++++++=
=0D
>>>  1 file changed, 61 insertions(+)=0D
>>>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awi=
nic,aw9610x.yaml=0D
>>>=0D
>> =0D
>> My bot found errors running 'make dt_binding_check' on your patch:=0D
>> =0D
>> yamllint warnings/errors:=0D
>> =0D
>> dtschema/dtc warnings/errors:=0D
>> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/=
iio/proximity/awinic,aw9610x.yaml: $id: Cannot determine base path from $id=
, relative path/filename doesn't match actual path or filename=0D
>>  	 $id: http://devicetree.org/schemas/input/awinic,aw9610x.yaml=0D
>>  	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/b=
indings/iio/proximity/awinic,aw9610x.yaml=0D
>=0D
>Look, still not tested.=0D
>=0D
>You got comment on v3 that you must it prior to sending. The comment=0D
>also explained how to perform the testing.=0D
>=0D
>You responded that you will implement testing but as easily we can see=0D
>here, you still did not test it.=0D
>=0D
>Please, stop wasting our time. TEST your patches BEFORE sending.=0D
>=0D
>Best regards,=0D
>Krzysztof=0D
=0D
Hi Krzysztof,=0D
=0D
I'm extremely sorry for wasting your time, and I feel incredibly guilty=0D
about it. I did see the information before, but for some reason, I didn't=0D
submit the correct patch. I apologize again for the inconvenience. I will=0D
fix this issue in the next version.=0D
=0D
Kind regards,=0D
Wang Shuaijie=

