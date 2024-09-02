Return-Path: <linux-iio+bounces-9005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDD09688C9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE2DB243BA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FFB20FAB0;
	Mon,  2 Sep 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b="lqJVE2gj"
X-Original-To: linux-iio@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020084.outbound.protection.outlook.com [52.101.169.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAE205E3E;
	Mon,  2 Sep 2024 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283512; cv=fail; b=FI7MI90PMvOmZXd/kOeLqLO5jZLoMtI3gn0QWgJqUA+4hstm+dfxvh+t0KhWCVe2/+K8sB4WCZH/zJWx3sU6OQSmqeaESZmq4hafJJwzChh3cVxhvAl9+lisBXmXhQPDaB+QBCwkBfjhx/KnywioBB555OAojV+ih61EcCpLRWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283512; c=relaxed/simple;
	bh=I7wRBtWfvdQYqsR0lBzpu5TgcadNJrs2e8YWkR0A0Pg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iLoKOdEEb5Ys222A1pEFU8vPd+HdzymVyCaG8f3xOGmO9fZVaORicBHZKMbISuSvdHoFszCmbnxSzivkLfkPoEGUl7R8jKefjpJb09CGEKQal0uoAKrJ6+fISsKfY+KTekRXZsi9xMmvhjI458xTbgyOTKI7Gi0yymKJvI07wD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com; spf=pass smtp.mailfrom=Softing.com; dkim=pass (2048-bit key) header.d=softing.com header.i=@softing.com header.b=lqJVE2gj; arc=fail smtp.client-ip=52.101.169.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Softing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Softing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaKXProrrVgZRuuxyHMbakQTkFjxcPMlzNW8WYb6/RklPW5fe8kiy3ZD0x3bdGOBNd3FqMdm3SwJDUXkDhi3d7dIh4CaoDYL9F+sRpyvFzOVGBEbln3Vmx7NTS3TIQffnI8PcB4RahFpMpNfoIIMNoKKXnFmfkqG4/IvRH7/cM485i4vEEl2hCwbE9AJF1B02S0NBcwm5L5Tf5Ov9/Iej6ZHxtdyujKXel9AO230a06L3adZU8yLr9xS9ZXCLMfT8G3y/vujBwD7q3Vq7LzV+4RNO5es223gQeKQISz5SofmOYoPO3yWeRm4Rnzbc1503c0dlUpHUVUbtozMi2QuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcTsExGQexeJnwz7S5QTmBZ9v8T5TwrrwzNhaLRseeU=;
 b=HyUcW7FqQw4LGnT2wzb2cSVHYbJ3cdl/EsbHKJdN9GLXhcMUIfGw+cw27DeiOPeEnOApO91f6RaCvAXFDVufUeZJkBp7Bf4W7NpyKluydeahGWDwyU5JyXRTPrJzaMlLNeuhEO1wq6pYLZuzBpoHXbryA5AxNrcEGOsTGbtAC/Rawf3UXmluYXYioeiXXb5Osi623wo0YSsAPtoXyUvWkvpmphTTYddAZMlGGPqrjAbApdvZUBuiaGNWEQtVjtBRUQjhnRsJmO+2ZnxEXCYN4MWkQYwZxGC9hwOE0TEg3puk9i3/+to8Mqz0aPikIkZPBIHhtO83BbycSEyUVK7Kkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softing.com; dmarc=pass action=none header.from=softing.com;
 dkim=pass header.d=softing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=softing.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcTsExGQexeJnwz7S5QTmBZ9v8T5TwrrwzNhaLRseeU=;
 b=lqJVE2gjR4UWDnyorrgymhUJzFBZqv5zfLLjRPVXq98AdRZfoIvX+Q0R2pykMl0p2vembb1l5ipRDQ3JAE3V0DeqjYTUNKR+GlA0TbIZg8kGMgO81IKKisEATldLHJs8xamLvNieO3Tc8AAUqZtEGRalrkYpN7dx2BpyS0khvHD5UOFfwcMBkmh+wXKKC2kTdUcmGbOT49BR/tekNsxmckTZDq+a5eLbsG0gfFatMVdI6dAumpcCzAW6xRw/vjvv0ttNvMpDfyAcpSB3kU/95dGhKYcWlG9pM7Oi7kpy5enoEcxiXYBjTcIAmnyfEezhn8/zcm0QDD9a+FcNBsOdtA==
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:43::7) by
 BEZP281MB2979.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:76::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.24; Mon, 2 Sep 2024 13:24:59 +0000
Received: from BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a]) by BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
 ([fe80::8de2:b2ba:4092:939a%4]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 13:24:59 +0000
From: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
To: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: AW: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Topic: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Thread-Index: Adr60bwOPjoiJD3QTreu2+tBMAOlGgADMoEAADB2j4AAZhkzIA==
Date: Mon, 2 Sep 2024 13:24:59 +0000
Message-ID:
 <BE1P281MB2420D75334A568E60823BE48EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References:
 <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<20240830-chaos-unrivaled-04c5c4c6add9@spud>
 <20240831132159.2073994f@jic23-huawei>
In-Reply-To: <20240831132159.2073994f@jic23-huawei>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Softing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2420:EE_|BEZP281MB2979:EE_
x-ms-office365-filtering-correlation-id: d68dec3b-6a01-4121-92f5-08dccb52a519
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xB1TqG1zYhSW6rypHqzo2OlyIqtvQ4VZ4YvM4akpd9mGJHID3Qjy9RP4AO/3?=
 =?us-ascii?Q?owjHoI6p0oWQl0SSJb0g1vbTDC64SzNzGUpz16CVl83a++bNz5+3j0nRTEHf?=
 =?us-ascii?Q?2PQg5vNMLdWOHcamSpyA1gRA6XLxd1Tp4bjR3UcbLNtya0O/9xWpCZjS0RZA?=
 =?us-ascii?Q?8Wk6CPE2a7kQqOEtf209qrx4gawEAXsQh93gCV1dWBVjbxh0zaMvZ+PK7Jf8?=
 =?us-ascii?Q?inPKnaRaLGattuYJXmCZ91sHGWUJjEkG7+QU8xITLVXtbODM3F8+v7d6xGVt?=
 =?us-ascii?Q?YP0IoHRnJ3ygD8Bueklw0ZvfJI8NqIYdtwFupmDKysZXHsluUCIMiS07egm+?=
 =?us-ascii?Q?g4AvItB2ysFR9f4bP0Pp6sK+YYPBOaeUuMpOWBSDtllWDvJ5Atv89Oux1/Yg?=
 =?us-ascii?Q?of9UndD+vaK6/2BizdRVBTO1+5o9fAeKJluby83ypmWbGXSpxt+Jr9H2dU6W?=
 =?us-ascii?Q?uU+21Jg/v8FpR18oUJnlnS+YSTYiZC0/Jilt3mevAKGBbVWY6xYXeRMxK3Eo?=
 =?us-ascii?Q?KTBQAXzqw6H6Kx9CZZSyzQ3ShBpCcUMk0RA7T8dTOhsnkcfy82wX5036j0ip?=
 =?us-ascii?Q?FzBjHx13oTkG/cYGJmY6kqnGvGfB5vwxEy2FMMv5NbsixoizgPDUhKn23fXh?=
 =?us-ascii?Q?7KN7j2vXXySAFLZ0H9L2ywBmkW62N0y1H4w6vbmMCARxpEmkqY4XWZzCMoJW?=
 =?us-ascii?Q?MjCsn5nCvX/SG/Txlqq3ljgIs1bDPNWPhLMhBqrXrSBjICfxygLX8w1cYcOj?=
 =?us-ascii?Q?rPY8IDCNW01oJY0uYYp75V4Xc5lylL2NOw44d2NDgzdMirfVSDSyuilsDdJa?=
 =?us-ascii?Q?bp0Yro4/mvFLR1nlORCR6TM9YtDepfOrAqYHcjkaWNARJ7deIzvH1agIq9wv?=
 =?us-ascii?Q?3FI/rKUQ6la9VRNk4A6XKivALKyH6sYUFf1hKv/Zka1bRE+qQvmShBzN9uth?=
 =?us-ascii?Q?TawT2QHD9ETYXz6aTidHfs4nwf9Z/Mgp0LKiyVikl52bfNhgnS+vi38TqIXK?=
 =?us-ascii?Q?qcpbblgVYYE0vrjBdFcHrIJbfCPmDAbe/V17W3PXUI+lPTTUwt4CzYAyTWF+?=
 =?us-ascii?Q?E4K3n8xpImUo3i6yDKYyGxaQgjRTNgUutUh6MZHxxyfHEfTM2yNh2waq6WYT?=
 =?us-ascii?Q?q7V8o39k9zo7QyaCW9LYYmao96UdhQYg3mzr8DpC9pqrP0rYYG3vSg9ARBb7?=
 =?us-ascii?Q?6kPoRXC2Ww3F2bL/AlguhpuAT8UHKyvRydOI3L7ZlqtVDrjAn+fK0ZCXSl8R?=
 =?us-ascii?Q?pix5JHvcdxraxIrFjDaaaAhbKqC1gmKdbbw6XcwUDok92qjcdvNoh3HwKjxZ?=
 =?us-ascii?Q?nfIJCw6ewmNSB3vYGRu3j3uYPSmGE30vmAO/ryw30Gnw5N92iFasE2BnDM8R?=
 =?us-ascii?Q?7vCbwE52/khumjUzRYOWNtxC/RUOP6Wx1jL608/yNEeblkueRQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7cVj++Wvgk0Iw0SQdqJdmFMWMcL9gz2c4XUD5xEEOP+oZKygprSpJLJDJ7jw?=
 =?us-ascii?Q?UqB8TaiWNCAXiNZ0HL5Y4URsO16s/iug3oxqnhWoIOaZtqJOOGiSpYff1tgz?=
 =?us-ascii?Q?ndOfOJIjr3+T/EoduGLTOKQ96SB4qmq7SkjlMNlbLTvanKCfSRrxAqD4kRfi?=
 =?us-ascii?Q?cfpTzPAaVBKydBRR95TMQ9fcTG+FS6FaTEohQ8i7LEKxtbJ+3xky9UvCjAVL?=
 =?us-ascii?Q?TnLWjhLi8XJFqNuCeU10BlRL2GfvuoSbZTbhlC4jIT8CV3/rCynUVofRdW5w?=
 =?us-ascii?Q?YrdW48/fBWWp71ITaLdMj26KT6hBudvuugjb01Vhb2lSvcuk06f7UlHIfw1G?=
 =?us-ascii?Q?0rYv5wPiM3E6f/9CHL+osOL8L2Qx3QePbqYuY9QFGJw5YiW6MblgraOWDt10?=
 =?us-ascii?Q?hbr1oa58YpWVS98uLs8OM7ad6uJcQ6Anxm/QPDdtuu7o+9+X3tfTI4YHh5CR?=
 =?us-ascii?Q?SvCo+1RXLzQEhkJyIwykX3pa1I/nfI8jCYSeDox0LHW/tjQ2OAmmr8WiNehp?=
 =?us-ascii?Q?q6DibyiG8OZmIyRL/Isc8FIz9cnuG+Xn5zPV7QIKWcFXpLy94lEb8+S9S4mP?=
 =?us-ascii?Q?yj84ypfThRBxuHZRIXQQ0hheWfawK2RK+hyjUZxyVCMTOZOY0Al2FP95YFBs?=
 =?us-ascii?Q?jGWyo1xDHNC8AlPZaiqCRxy+p8AuwMJpQBfNdfPCdBkU4s72v1i0SGOyEdLA?=
 =?us-ascii?Q?qX//ksm4VQNWf2FJFKM9IdZ1/7rlxfwgDAmroYphoFGFF5XbEjQ+1or2RRBw?=
 =?us-ascii?Q?iy4mukbI8jaDyiujikb3J58UTzsmUJwLVXwduHQYqcCxYpVBR6ZQnkSRLHUp?=
 =?us-ascii?Q?rNuT7P+kY6Y5VuBsBqueHBYlw9m/W9DsDhET+wXiXyy7zD1KnJF25BRvzONz?=
 =?us-ascii?Q?njudwqxSqDzxfCsB/h3xW+GVozteXih0EpaAHH+wnhi//eYVE76I66RQhl5W?=
 =?us-ascii?Q?3jMz7or/QJJSzZLZhErIiX6FbrCV+PmutfIHJPOTN9LIylafN/yDuRkC35ir?=
 =?us-ascii?Q?nE+Cl+O0Xyv3oMdN7A3PSDO+sBMsaLLTS7vL+fjs0mguvfRRhKlDm7VuwBW0?=
 =?us-ascii?Q?jvKMk8CAuAnkKlES67VKtph2K3AskwhHdbF1ND00NdIvkvR4nu+mvGo6g7sI?=
 =?us-ascii?Q?nB9f3fmfxze76FPehRwLz5X6TIYHMbJTqvAwAzio9U+ujdHlZvGqLgEjlOaZ?=
 =?us-ascii?Q?V4h6TRG7XMzODqWJNmbij3YJrTgvHtNl7lBSgUatQYdPvizjz8gJgVL+Csyc?=
 =?us-ascii?Q?6bNCFey7fNQ4YoEmlt3XUJGEuxVZgvli5pTGu4ou454J1SyN3ov30LPvJbNg?=
 =?us-ascii?Q?zwM1Qs/NMGP4zu6eUXtmfd5kQtbTitxr04q6KtLeI98Y8OCVOz4jKmC18+R4?=
 =?us-ascii?Q?mJ7nudVksEZqkN/04PudUZBeEhVwC/aQ0dJ/+6U78HX0K4F3awv2dqH5zU5A?=
 =?us-ascii?Q?clj9JyIDHkAaZmJ3UW9m/wtqA4ooNQVx7oqgQeXbZz8p+BNZ0hETZEJB/E1l?=
 =?us-ascii?Q?32dJyVHKRnP5niJ8BlUzn2WsvW3qSR8GvotIOtypKYQYmVolN/kIjMnxe/gg?=
 =?us-ascii?Q?tUbLN1eu5glvk+ud3sE9dt7xm9Ke/vyOS32cqta6Ha40p8jrmqqKQO4p7Oii?=
 =?us-ascii?Q?gBwAjZ+o1o2wYICXFEgmLlPmlV6ruEXoyjN5cyv3flMMSbF9Sg7zaNeLwkoK?=
 =?us-ascii?Q?2/LTRg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: softing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d68dec3b-6a01-4121-92f5-08dccb52a519
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 13:24:59.6890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe3606fa-d397-4238-9997-68dcd7851f64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbxGs/8kPG5dMums1iXmFXas2sfigEaxBI759n/PoBiAnZnlvfcPE2ESZlRJtTwhH6YQ2+CYb5BC7/DgNje/aeoaE0xZozh0tlnKI7fiKrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2979

> > > +  ti,mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > +    description: |
> > > +      Operation mode
> > > +      Mode 0 - Manual mode. A channel is only sampled when the accor=
ding
> input
> > > +        in the sysfs is read.
> > > +      Mode 1 - Auto mode. All channels are automatically sampled
> sequentially.
> > > +        Reading an input returns the last valid sample. In this mode=
 further
> > > +        features like statistics and interrupts are available.
> > > +    default: 0
> >
> > I don't think this ti,mode property is suitable for bindings. sysfs is =
a
> > linux implementation detail, when to do sampling is an implementation
> > detail of your driver. Bindings are only supposed to describe propertie=
s
> > of the hardware, not set software policy.
>=20
> Agreed. With an IIO driver this will become a switch based on what usespa=
ce
> interfaces are enabled.
> So if events are on or buffered data capture, enable automode.
> If just sysfs reads, then manual mode is fine.

Not quite sure if I understood you correctly. With the mode I intended to g=
ive
control about the sampling behavior.
In manual mode channels are only sampled if they are accessed/read.
In auto mode they are sampled all the time sequentially. This also offers t=
o use
some extended features, like triggering an interrupt if a measurement cross=
es a
defined limit.
So the mode mainly affects the hardware behavior and just offers the possib=
ility
to catch that in userspace, if configured accordingly, but that's not a mus=
t-have.

Anyway, did I understood it correctly, that you suggest to configure the mo=
de
according some symbols in the kconfig and check that with #ifdef? Do you ha=
ve
the specific symbol names for me or a driver as example, so I can have a lo=
ok?

Thanks and regards
Tobias

