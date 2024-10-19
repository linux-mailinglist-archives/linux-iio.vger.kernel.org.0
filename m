Return-Path: <linux-iio+bounces-10807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2709A50D6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 22:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B92857C7
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7955B1922DB;
	Sat, 19 Oct 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b="DLcqmVTp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRRXsU+c"
X-Original-To: linux-iio@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011A815C15E;
	Sat, 19 Oct 2024 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729370981; cv=none; b=qd7NNRBb4Mv2zb3ukt6lYwaEe9uYcmvykH/ar9ZGyx4PAGhwPQyLpAAxNYwh6AkTI8qa7GUmAv2/X8djJXVNWtv3EomFY0EFAA/J+ZFcFo5mV3OsotFAadVzLUbfuj+AepMo42AQhEXmgOPSt8Nj7hxTRCCN9tXrlYrssxDwqE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729370981; c=relaxed/simple;
	bh=M5aX9O7+XwA3SzgFspSeyRnxBC3sAVY/dqhk+D0vKBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fk4/G5DZaf+kprnEfXkebP6COXpOyIqgFGtfZue8+wmiNS4RwHxmESwIdqa9o6M8dIFqpG1Fm179kMMTahH4LYUYuaeZeO9PSDJIXq4LzA6XzpTbTOr+NJ2hc0McG858PHEoxuU2E81u7IHoa14AGePMFV/wO9GLymbu5Fut9Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com; spf=pass smtp.mailfrom=justinweiss.com; dkim=pass (2048-bit key) header.d=justinweiss.com header.i=@justinweiss.com header.b=DLcqmVTp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRRXsU+c; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=justinweiss.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justinweiss.com
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1473E13801F2;
	Sat, 19 Oct 2024 16:49:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 19 Oct 2024 16:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justinweiss.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1729370978; x=
	1729457378; bh=cs2DNxtWXLHkyMcVloVgw6XHpgglVXrJ0AkyDaPqICQ=; b=D
	LcqmVTpXdFH7C9JhwqjkhC+3PhtLRxakhUZ/udlQ6VBOJXPRs79ZcgRzePsMiFT2
	Y/mYn81uxMPkN//eqAgrKMpgPZFJsohhUCAPy5NVp9IaMawlaZH5Lr1ogBp7jRhB
	fKJCUn4VWIXnSvNeMk3Gr6ZGu3NBRB8QvUQukTHGsDyURdCriCMNiY2b2zv0Rp2E
	2tgMZ8p8a7JmrzDvelcZ7KWA+DriNc6yRdpONlqeGoFNCqitZRxG+GGZ94t+F/3u
	656aiV+Kozz5gFZEk0fh7Fziefi8UDCArwXt/C3cZD+7tAcAtKDEz0BQUeMpuYRw
	UfalGJXE/9NuBIISaFEJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729370978; x=1729457378; bh=cs2DNxtWXLHkyMcVloVgw6XHpggl
	VXrJ0AkyDaPqICQ=; b=VRRXsU+cFok18lFIJ3PVRitMjFf++H8t1cDxjwxMqpJr
	dXsR5PR8dHRd9+piGreBYDuj/l6+ox2O81JskdbByF9P12DclUiYF6uYw0YzkauN
	viWLA349bprZlh2qAGkgmUbuWd8r0/UnMoBWkFkNDvyj0/ltcPBJobjMx1tvs2xR
	UZVocwkunduTpZsGLuE2ywPJ7tfAgnEz70Vr0aWtsyUjx3x0bHcJxeRy/5UNC6fU
	sGIdhDZ5HwAZJLhgw6Q8ABxHQuTmj2Oks9s9CejhApK3dAcTxYkBGO+JqsHxjmdN
	SKJXFkjiIJxT4BAnqvjCRTrLpIbYfDQQLIiYEPI3rQ==
X-ME-Sender: <xms:YRsUZyDrEzKYrGBV3rTSo92FLfRPAgwI6EQjQRZqbjJSsotV4NesHQ>
    <xme:YRsUZ8j4LwEOSqvqpBZg1cuFu6uQqei9MJmQIWenYCFmd6tUueDZm2phD1ebT-wfO
    9QWQPOI5qwZxV-1ag>
X-ME-Received: <xmr:YRsUZ1n1sFoXtYk2raGglIYKJVHx9VX0eNTqWYB4C8v5Q7JrRvwA2i_WPFjiXEIQfRd9Z0RFN39Dr_iC8juRo3Iq-bzzDjbpSD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhsthhinhcuhggvihhsshcuoehjuhhsthhinhesjhhushhtihhnfi
    gvihhsshdrtghomheqnecuggftrfgrthhtvghrnhepfedukeegledvffefveethfehkefg
    veduveffgfelueeiveelkeevudejfeeuuefgnecuffhomhgrihhnpeguvghvihgtvghtrh
    gvvgdrohhrghdpsghoshgthhdqshgvnhhsohhrthgvtgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhsthhinhesjhhushhtih
    hnfigvihhsshdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehphhhilhhmsehmrghnjhgrrhhordhorhhgpdhrtghpthhtohepug
    gvrhgvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvg
    hvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhiihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorh
    doughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhgrrhhssehmvghtrghfohhordguvg
X-ME-Proxy: <xmx:YRsUZwzZtTrliAjQmyov9ajVc9zK37LCyB_u3xajAMPtLndAZoqejA>
    <xmx:YRsUZ3T2wRvCNTWTo_4l0bFFo0LKF4kEib-sor-cxPBv7tX8zlwdWg>
    <xmx:YRsUZ7bD2GCJBhW-XRThNe5Lle4VDzVG8sTJWxhs2wN8O7cGXzoidw>
    <xmx:YRsUZwRqhq7WneJKeXwZb29mxM7WlHfL-9LdcXe6TNJXh-IaIP1f3A>
    <xmx:YhsUZ_Yvn3U2wuS2qyvzM7-802TAI_S7gH079SgyYEF7oH3ZGeYhhzPl>
Feedback-ID: icf614246:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:49:36 -0400 (EDT)
From: Justin Weiss <justin@justinweiss.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Derek J . Clark"
 <derekjohn.clark@gmail.com>,  Philip =?utf-8?Q?M=C3=BCller?=
 <philm@manjaro.org>
Subject: Re: [PATCH v2 3/6] dt-bindings: iio: imu: Add Bosch BMI260
In-Reply-To: <20241019123623.210ac09d@jic23-huawei> (Jonathan Cameron's
	message of "Sat, 19 Oct 2024 12:36:23 +0100")
References: <20241018233723.28757-1-justin@justinweiss.com>
	<20241018233723.28757-4-justin@justinweiss.com>
	<20241019123623.210ac09d@jic23-huawei>
Date: Sat, 19 Oct 2024 13:49:35 -0700
Message-ID: <87zfmzakdc.fsf@justinweiss.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 18 Oct 2024 16:36:09 -0700
> Justin Weiss <justin@justinweiss.com> wrote:
>
>> Add devicetree description document for Bosch BMI260, a 6-Axis IMU.
>> 
>> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> Looks like this would be much better as an additional compatible id
> in the existing bosch,bmi270.yaml binding doc.
>
> From a quick comparison they look nearly identical.
> Even if there are small differences the dt binding schema allows
> those to be expressed in a single file.
>
> Jonathan

Sounds good, will update in v3.

Justin

>> ---
>>  .../bindings/iio/imu/bosch,bmi260.yaml        | 77 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 78 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
>> b/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
>> new file mode 100644
>> index 000000000000..6786b5e4d0fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/imu/bosch,bmi260.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bosch BMI260 6-Axis IMU
>> +
>> +maintainers:
>> +  - Justin Weiss <justin@justinweiss.com>
>> +
>> +description: |
>> +  BMI260 is a 6-axis inertial measurement unit that can measure acceleration and
>> +  angular velocity. The sensor also supports configurable interrupt events such
>> +  as motion detection and step counting. The sensor can communicate over
>> +  I2C or SPI.
>> +  https://www.bosch-sensortec.com/products/motion-sensors/imus/bmi260/
>> +
>> +properties:
>> +  compatible:
>> +    const: bosch,bmi260
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vdd-supply: true
>> +  vddio-supply: true
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  interrupt-names:
>> +    minItems: 1
>> +    maxItems: 2
>> +    items:
>> +      enum:
>> +        - INT1
>> +        - INT2
>> +
>> +  drive-open-drain:
>> +    description:
>> +      set if the specified interrupt pins should be configured as
>> +      open drain. If not set, defaults to push-pull.
>> +
>> +  mount-matrix:
>> +    description:
>> +      an optional 3x3 mounting rotation matrix.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vdd-supply
>> +  - vddio-supply
>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        imu@68 {
>> +            compatible = "bosch,bmi260";
>> +            reg = <0x68>;
>> +            vdd-supply = <&vdd>;
>> +            vddio-supply = <&vddio>;
>> +            interrupt-parent = <&gpio1>;
>> +            interrupts = <16 IRQ_TYPE_EDGE_RISING>;
>> +            interrupt-names = "INT1";
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6011af70c12e..73b6b7721dd8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4047,6 +4047,7 @@ BOSCH SENSORTEC BMI270 IMU IIO DRIVER
>>  M:	Alex Lanzano <lanzano.alex@gmail.com>
>>  L:	linux-iio@vger.kernel.org
>>  S:	Maintained
>> +F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi260.yaml
>>  F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
>>  F:	drivers/iio/imu/bmi270/
>>  

