Return-Path: <linux-iio+bounces-22008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44401B11719
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 05:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570C01CC487A
	for <lists+linux-iio@lfdr.de>; Fri, 25 Jul 2025 03:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49B0237704;
	Fri, 25 Jul 2025 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MWzhwZ6E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF62E3718;
	Fri, 25 Jul 2025 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414473; cv=none; b=GQseHXUJH6qDmoF0HGqhEbvJ8GdVJSGUi80xugUfnGAr97aATOf86ewEhXg5L2TCxFsjxsrf8mfhuwkJPbWIUM5yvwVgGdLKB20VRDd79AovAx2Lz/J/mF7bLdy4YUty3FG3TLUqk+AhciZOld3lT6dZrWlhM3+DdGBXok/h3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414473; c=relaxed/simple;
	bh=rjaBonRK6Ih+sgUNcDnD2a3SzoSU5QGqCQo2yp9Xrj0=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Yggn/vBqxtx4UNEZH2Wmpgfd+Ht/MqPZFPTk5TO/CaI+eVmrEGVoYsy0D6JjMrtrQ+Ke5JlXkZz6DyIRqllutGrfhgonwgFy9AibK6ggLl4NaimBXwtAcrfzvabkZfGO4ZCG8Uf7sByWFLp/R/GeuhDXZXg8QQXw+z2+IG4AZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MWzhwZ6E; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250725033428epoutp01f5a9020b90b2b1b9ffdf75ac46ecb3e7~VYStN8OPu2866228662epoutp01D;
	Fri, 25 Jul 2025 03:34:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250725033428epoutp01f5a9020b90b2b1b9ffdf75ac46ecb3e7~VYStN8OPu2866228662epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753414468;
	bh=rjaBonRK6Ih+sgUNcDnD2a3SzoSU5QGqCQo2yp9Xrj0=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=MWzhwZ6ELFQPsTjfNPkkR5pUNXZo6ltsc8MjE2vSJbeVybkoY8UELsMNA6rADQbxq
	 cSNYqs4dUqrY8UtVgZDeSetcaBXZ7vWKqMH7SowHxaeKMQzP3hWEJmVPDYUytg6Xsi
	 wDEHlZzOWWoxQAfVbbBl6Gqd2b0MAoIm2erAesRY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250725033428epcas5p3746cdb5adc08933bd2ba40c7f43007b5~VYSs16Lcb1523915239epcas5p3z;
	Fri, 25 Jul 2025 03:34:28 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bpD4z0wMTz3hhT3; Fri, 25 Jul
	2025 03:34:27 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250725033426epcas5p1b632007c5ce46e14274551d309048e1b~VYSrYf8xw2307423074epcas5p1x;
	Fri, 25 Jul 2025 03:34:26 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250725033421epsmtip2eb2ae98e3dc6373dd26fea50a8e8d8cc~VYSm6U5AJ0743307433epsmtip2r;
	Fri, 25 Jul 2025 03:34:21 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Lars-Peter
 Clausen'" <lars@metafoo.de>, "'Michael Hennerich'"
	<Michael.Hennerich@analog.com>, "'Jonathan Cameron'" <jic23@kernel.org>,
	"'David	Lechner'" <dlechner@baylibre.com>, =?UTF-8?Q?'Nuno_S=C3=A1'?=
	<nuno.sa@analog.com>, "'Andy Shevchenko'" <andy@kernel.org>, "'Rob Herring'"
	<robh@kernel.org>, "'Krzysztof Kozlowski'" <krzk+dt@kernel.org>, "'Conor
 Dooley'" <conor+dt@kernel.org>, "'Lucas Stankus'"
	<lucas.p.stankus@gmail.com>, "'Puranjay	Mohan'" <puranjay@kernel.org>, "'Dan
 Robertson'" <dan@dlrobertson.com>, "'Marcelo	Schmitt'"
	<marcelo.schmitt@analog.com>, "'Dragos Bogdan'" <dragos.bogdan@analog.com>,
	"'Jean-Baptiste Maneyrol'" <jean-baptiste.maneyrol@tdk.com>,
	=?UTF-8?Q?'Ond=C5=99ej_Jirman'?= <megi@xff.cz>, "'Alexandru Tachici'"
	<alexandru.tachici@analog.com>, "'Stefan Popa'" <stefan.popa@analog.com>,
	"'Linus Walleij'" <linus.walleij@linaro.org>, "'Stephan	Gerhold'"
	<stephan@gerhold.net>, "'Ceclan Dumitru'" <dumitru.ceclan@analog.com>,
	"'Alexandru Lazar'" <alazar@startmail.com>, "'Andy Gross'"
	<agross@kernel.org>, "'Bjorn Andersson'" <andersson@kernel.org>, "'Matti
 Vaittinen'" <mazziesaccount@gmail.com>, "'Angelo Compagnucci'"
	<angelo.compagnucci@gmail.com>, "'Mike Looijmans'"
	<mike.looijmans@topic.nl>, "'David Heidelberg'" <david@ixit.cz>,
	"'Manivannan Sadhasivam'" <mani@kernel.org>, "'Peter Meerwald-Stadler'"
	<pmeerw@pmeerw.net>, "'Andreas Klinger'" <ak@it-klinger.de>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20250724111345.47889-7-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 3/4] dt-bindings: iio: adc: samsung,exynos-adc: Use
 correct IRQ level in example
Date: Fri, 25 Jul 2025 09:04:20 +0530
Message-ID: <2d2801dbfd15$055db750$101925f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQF9KPnnDP5MNVIiuJxjrYc+La4GeQFz+E82AjEsD8604q6K4A==
X-CMS-MailID: 20250725033426epcas5p1b632007c5ce46e14274551d309048e1b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250724111407epcas5p32d1ac49e0e12bdec1b07d2eb2a03ac14
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
	<CGME20250724111407epcas5p32d1ac49e0e12bdec1b07d2eb2a03ac14@epcas5p3.samsung.com>
	<20250724111345.47889-7-krzysztof.kozlowski@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Thursday, July 24, 2025 4:44 PM
> To: Lars-Peter Clausen <lars=40metafoo.de>; Michael Hennerich
> <Michael.Hennerich=40analog.com>; Jonathan Cameron <jic23=40kernel.org>;
> David Lechner <dlechner=40baylibre.com>; Nuno S=C3=A1=20<nuno.sa=40analog=
.com>;=0D=0A>=20Andy=20Shevchenko=20<andy=40kernel.org>;=20Rob=20Herring=20=
<robh=40kernel.org>;=0D=0A.=0D=0A.=0D=0A.=0D=0A>=20Cc:=20Krzysztof=20Kozlow=
ski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20Subject:=20=5BPATCH=203/4=
=5D=20dt-bindings:=20iio:=20adc:=20samsung,exynos-adc:=20Use=20correct=0D=
=0A>=20IRQ=20level=20in=20example=0D=0A>=20=0D=0A>=20The=20interrupt=20line=
=20to=20GIC=20is=20IRQ_TYPE_LEVEL_HIGH,=20so=20use=20that=20instead=20of=0D=
=0A>=20=22none=22.=20=20Also=20replace=20the=20hard-coded=20GIC_SPI=20flag.=
=0D=0A>=20=0D=0A>=20Signed-off-by:=20Krzysztof=20Kozlowski=20<krzysztof.koz=
lowski=40linaro.org>=0D=0A>=20---=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim=
.akhtar=40samsung.com>=0D=0A=0D=0A

