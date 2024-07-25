Return-Path: <linux-iio+bounces-7881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81D93C250
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E84F1C20B8D
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031219A2A7;
	Thu, 25 Jul 2024 12:48:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out198-15.us.a.mail.aliyun.com (out198-15.us.a.mail.aliyun.com [47.90.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A90199EBE;
	Thu, 25 Jul 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911702; cv=none; b=Bi1wwvZr9Da6GFMHgtaoGeI/M+Flx1+vf8TvhvMaA2bjp70stVgt6JPANTDnLrTX0AHtGpS1iMEgIL4Jtz6ucM0YgKZojrVhhDvr6iF3SlszLC5ECN6URUL96HEGqv98p9imH3jWxYBVdh724W18JkZQ4HaCK7ACOa7ffOOBegg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911702; c=relaxed/simple;
	bh=62qxyfn3t9sgrn0fBZondR+a/bfHnkP1Ba3AM+n7bzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdLSbackeua0sTVpbMtNnXyJSc3L6x7ITF8eRBXaf47YOCiDXUnDHYag8uOjbomnjdG8DZxekMRp59py0YVOxMOQQFFbIFsrrq80UnkJnmOkIT1YvtIrKEeJtSWUVAYiLB5mo1yyRa7PmjaEY6ao8tp377D7R9C1Woa0sTMQNyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; arc=none smtp.client-ip=47.90.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743626|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0112408-0.00343471-0.985324;FP=7449125017648764282|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023108233;MF=wangshuaijie@awinic.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.YZY94Oz_1721911673;
Received: from awinic..(mailfrom:wangshuaijie@awinic.com fp:SMTPD_---.YZY94Oz_1721911673)
          by smtp.aliyun-inc.com;
          Thu, 25 Jul 2024 20:47:59 +0800
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
Subject: Re: [PATCH V3 1/2] dt-bindings: iio: Add YAML to Awinic proximity sensor
Date: Thu, 25 Jul 2024 12:47:53 +0000
Message-ID: <20240725124753.890589-1-wangshuaijie@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <c466de06-cbc3-4ce7-90fe-4decc6e0fb89@kernel.org>
References: <c466de06-cbc3-4ce7-90fe-4decc6e0fb89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,=0D
=0D
On Fri, 12 Jul 2024 13:55:09 +0200, krzk@kernel.org wrote:=0D
>On 12/07/2024 13:31, wangshuaijie@awinic.com wrote:=0D
>> From: shuaijie wang <wangshuaijie@awinic.com>=0D
>> =0D
>> Add the awinic,aw96xxx.yaml file to adapt to the awinic proximity sensor=
 driver.=0D
>> Addressing the issues raised in the previous version.=0D
>> 1. Add a description about the hardware device.=0D
>> 2. Remove inappropriate configuration items.=0D
>> 3. Modify the formatting issues.=0D
>=0D
>That's commit msg or changelog? Don't mix both. Read submitting patches.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> =0D
>> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>=0D
>> ---=0D
>>  .../iio/proximity/awinic,aw96xxx.yaml         | 127 ++++++++++++++++++=
=0D
>>  1 file changed, 127 insertions(+)=0D
>>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awin=
ic,aw96xxx.yaml=0D
>> =0D
>> diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw96=
xxx.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.y=
aml=0D
>> new file mode 100644=0D
>> index 000000000000..459cb1644d3c=0D
>> --- /dev/null=0D
>> +++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96xxx.yam=
l=0D
>> @@ -0,0 +1,127 @@=0D
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0D
>> +%YAML 1.2=0D
>> +---=0D
>> +$id: http://devicetree.org/schemas/input/awinic,aw96xxx.yaml#=0D
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#=0D
>> +=0D
>> +title: Awinic's AW96XXX capacitive proximity sensor=0D
>> +=0D
>> +maintainers:=0D
>> +  - Shuaijie Wang <wangshuaijie@awinic.com>=0D
>> +=0D
>> +description: |=0D
>> +  Awinic's AW96XXX proximity sensor.=0D
>> +  The specific absorption rate (SAR) is a metric that measures=0D
>> +  the degree of absorption of electromagnetic radiation emitted by wire=
less=0D
>> +  devices, such as mobile phones and tablets, by human tissue.=0D
>> +  In mobile phone applications, the proximity sensor is primarily used =
to detect=0D
>> +  the proximity of the human body to the phone. When the phone approach=
es the human body,=0D
>> +  it will actively reduce the transmit power of the antenna to keep the=
 SAR within a safe=0D
>> +  range. Therefore, we also refer to the proximity sensor as a SAR sens=
or.=0D
>=0D
>Wrap at 80 (see Coding style).=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +=0D
>> +properties:=0D
>> +  compatible:=0D
>> +    enum:=0D
>> +      - awinic,aw96103=0D
>> +      - awinic,aw96105=0D
>> +      - awinic,aw96303=0D
>> +      - awinic,aw96305=0D
>> +      - awinic,aw96308=0D
>> +=0D
>> +  reg:=0D
>> +    maxItems: 1=0D
>> +=0D
>> +  interrupts:=0D
>> +    description:=0D
>> +      Generated by the device to announce that a close/far=0D
>> +      proximity event has happened.=0D
>> +    maxItems: 1=0D
>> +=0D
>> +  awinic,sar-num:=0D
>=0D
>Drop the property. I already asked.=0D
>=0D
=0D
The patch for v4 will remove this property.=0D
=0D
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0D
>> +    description:=0D
>> +      Set the number of the SAR(Specific Absorption Rate) sensor.=0D
>> +      It is set to 0 if one awinic sar chip is used.=0D
>> +      If two awinic sar chips are used, awinic,sar-label in the first=0D
>> +      awinic-sar should be set to 0 and awinic,sar-label in the second=
=0D
>> +      awinic-sar should be set to 1.=0D
>> +      In an application where a device utilizes multiple proximity sens=
ors,=0D
>> +      it is used to retrieve the names of the register configuration fi=
les=0D
>> +      that the drivers need to load. For example: aw963xx_reg_0.bin/aw9=
63xx_reg_1.bin=0D
>> +=0D
>> +  awinic,regulator-power-supply:=0D
>=0D
>It does not look like you tested the bindings, at least after quick=0D
>look. Please run `make dt_binding_check` (see=0D
>Documentation/devicetree/bindings/writing-schema.rst for instructions).=0D
>Maybe you need to update your dtschema and yamllint.=0D
>=0D
=0D
The patch for v4 will fix these issues.=0D
=0D
>> +    description:=0D
>> +      Choose if you want to use a regulator to power the chip. Then the=
=0D
>> +      vccX-supply has to be set.=0D
>> +=0D
>> +  vcc0-supply:=0D
>> +    description:=0D
>> +      Optional regulator for chip, 1.7V-3.6V.=0D
>> +      If two awinic sar chips are used, the first regulator=0D
>> +      should set the ID to vcc0-supply and the second regulator=0D
>> +      should set the ID to vcc1-supply.=0D
>> +=0D
>> +  awinic,channel-use-mask:=0D
>=0D
>Aren't there existing IIO properties like this?=0D
=0D
The patch for v4 will remove this property.=0D
=0D
>=0D
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0D
>> +    description:=0D
>> +      The mask of channels used.=0D
>> +      Configure according to the specific chip channel used.=0D
>> +      Bit[31:0] Each bit represents a channel.=0D
>> +      If the customer uses ch0 and ch2, then channel_use_mask=3D<0x05>=
=0D
>> +      For a 3-channel chip, the maximum value is 0x07;=0D
>> +      For a 5-channel chip, the maximum value is 0x1F;=0D
>> +      For a 8-channel chip, the maximum value is 0xFF;=0D
>> +=0D
>> +  awinic,monitor-esd:=0D
>> +    type: boolean=0D
>> +    description:=0D
>> +      Choose if you want to monitor ESD.=0D
>=0D
>Why this is a choice? How does this describe hardware.=0D
>=0D
=0D
The patch for v4 will remove this property.=0D
=0D
>> +=0D
>> +  awinic,pin-set-inter-pull-up:=0D
>> +    type: boolean=0D
>> +    description:=0D
>> +      Choose if you want to set the interrupt pin to internal pull-up.=
=0D
>> +=0D
>> +  awinic,using-pm-ops:=0D
>=0D
>NAK, drop all such OS policies.=0D
>=0D
=0D
The patch for v4 will remove this property.=0D
=0D
>> +    type: boolean=0D
>> +    description:=0D
>> +      Choose if you want to change the chip mode on suppend and resume.=
=0D
>> +=0D
>> +  awinic,use-plug-cail:> +    type: boolean=0D
>> +    description:=0D
>> +      Choose If you want to perform calibration when plugging and unplu=
gging the charger.=0D
>=0D
>And why this is board dependent?=0D
>=0D
=0D
The patch for v4 will remove this property.=0D
=0D
>> +=0D
>> +  awinic,irq-mux:=0D
>> +    $ref: /schemas/types.yaml#/definitions/uint32=0D
>> +    enum: [2, 5]=0D
>> +    description:=0D
>> +      You only need to set this configuration item if you are using AW9=
6308 adn AW96305BFOR.=0D
>> +      If CS2 is used as the interrupt pin, this item should be set to 2=
.=0D
>> +      If CS5 is used as the interrupt pin, this item should be set to 5=
.=0D
>> +=0D
>=0D
>=0D
>Best regards,=0D
>Krzysztof=0D
=0D
Thank you very much for your valuable advice. I will address these=0D
issues in the next version of the patch.=0D
=0D
Kind regards,=0D
Wang Shuaijie=

