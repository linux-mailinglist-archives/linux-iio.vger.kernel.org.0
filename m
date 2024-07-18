Return-Path: <linux-iio+bounces-7678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6B934DD3
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D77222827AE
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232113C8F0;
	Thu, 18 Jul 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="Ik/G3JQv"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2057.outbound.protection.outlook.com [40.107.103.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E00224CF;
	Thu, 18 Jul 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308238; cv=fail; b=Wao9mRGcTflOaCmc6xfCTt4VAN0ee1Mqb3MBNeBye0b6gbx2DCB5jvHoJFOVOvI3qbb2Z1jzWcQjU00zLw442sQTIKy/yRDZIJGW3m+y5IA+kwb3wqZunZi2YLO3asBxRBt5cd8ys1dCe28oAb4h/BwblKQwOknFYDEqHhig+UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308238; c=relaxed/simple;
	bh=Ca21phELjLEbiurlhWl3mECziJxSJ1nGWaj4fPra8GY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VeDeLniAXNaU1LOaAUuIkKA096M/LfjS8BtUa6qG4ryaeWs3JkUGh+mLUB/sCSXgupnd2QNe/v5cqd9qZAtYMWJmMbeQ7EOqxNAWhHOPiaDHMRqoTm1h+yu2ZIeHHzZTzyTlR9gZAL5qKmMGhYHEDn+CH9wgRO8ld6Lgtbl5cec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=Ik/G3JQv; arc=fail smtp.client-ip=40.107.103.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4qrvmeWqUxCRbPsKSg3bBs7uzJDj31Fjck//6wPsWycGKpJDImO2nvliQZFIMfCcIVQzhZ6fYIbE2Uumq7NW2Al3MS/hxzeF6AJeyodpGArmlhdlkUI0JPEsH8kfWuSvEP3kZs2toSSZFkHwDhNuDnrHeDweAOqm5mRg5rPucFJiBGghyBDZOqM8og7652+A2OtNRllXiAIdSBir9Lt0yuVRvM7cRCs4jOiUhPpZCBsHXNhZ3oDjsTPeR1HquZyw9BfQ+Ht0J30QwNapXdGsuKzb6i4Nph3c8pNBGo7ZKmVRluQLx7cb2ZftJ2tegIXYPgKiydnDYe2u4q5VCzyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYzX5qY4PDjEJKYbifF2Gf9XqvYl3zTWqQ1xZOsZpvE=;
 b=GekKs6oaAhbuXWSuTS/eadGO5Z3HBFHpzLGG52brywiI5AoPw+SamDFGacaD981TaXhvpLFYiqZoQsu1VrPn9x4gQ1vDiAPHxMydfL1H9y7b6DKIqYNgDw5iOi1WaFko/bj84R2TUZ8gK/Ey8VSEu+U18Wu1DcSmeuCQmly7Vh+u+rIZ2zDHeqqZPwP1ZJmqCdFPQ6hHcpCvOWlh2lDgf7ZwSEuf287Ah72PTDtZALgSUUr7P8DHw0pcAuf3/nrp9P0DLQymvyy8pwUNhwuPS1pUs900Sb85M/X3dnEQCS4ZATSkUrfha8cOsuBKaRNM0GFhsakkK+9LU5HutR5XKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYzX5qY4PDjEJKYbifF2Gf9XqvYl3zTWqQ1xZOsZpvE=;
 b=Ik/G3JQvE/+5nevXCpIEhwF4mAvMb9NMj15kZ+IpRFoOMlcr2M9JrzD6qzNgn1207ivbN4x6IZyrjDv6uyjoBS88guiao1sAA01ahegXHzMLVIWfHYEc0UU2GodCs1tlPf3oW+QOyDE4rxTQyALEG//cmv2tU/DJ/nLwRndvSFimVAznblxpURs5RUROMSASPdhNfdjtPvyz0cvIUobobMNlY78nbvrhwiNjsaAAVLzdLGduf0952m4CwqQM3knFDDqaJu3gSAoClJxAB1bf7z7HxPNP78X8tAO3WZrO9M9Yg7S+XDoeKXO/P2YdxdYtB+hF2rnN5S+58DFsR3C5Zg==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DUZPR10MB8292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4af::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 13:10:31 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 13:10:31 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
	<dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH] drivers: Bosch SMI240 IMU Driver
Thread-Topic: [PATCH] drivers: Bosch SMI240 IMU Driver
Thread-Index: AQHa2Q2TbBqQYS6A20K/zlBvlG3w9bH8by6AgAAF7KA=
Date: Thu, 18 Jul 2024 13:10:31 +0000
Message-ID:
 <AM8PR10MB4721849BB056482F6A27D633CDAC2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240718122449.7607-1-Jianping.Shen@de.bosch.com>
 <5aec49af-0a24-464b-b24c-cb23c7b1ae95@kernel.org>
In-Reply-To: <5aec49af-0a24-464b-b24c-cb23c7b1ae95@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DUZPR10MB8292:EE_
x-ms-office365-filtering-correlation-id: 02cf1a03-5daa-4042-ef86-08dca72b005d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jzJEKPETjMaSouL7wAezO0Pa4Vd78DFh5BkrMzaPI/MEHeTauz/MsIZxT3?=
 =?iso-8859-1?Q?Onng6b7QG7qaJ6PzMLu1r7QgpSA0dA+mHt7vZnc5odPKTazFlSxcN7SEt5?=
 =?iso-8859-1?Q?lgzlk1VD2/4GDhphWrLoLgVekVCDuz3ARrT8iD0sLL70HpuRSYBTj6jYO/?=
 =?iso-8859-1?Q?Elj/ZUnG6HfkWPOkXPKLs8xEVGCtFId/jXu8bHv9TaTr6N+7H74ofghaEH?=
 =?iso-8859-1?Q?pF0Drp0DwgHZKPMD651LGOc6YFX+HTj6xkoHsb7VXjrOI9IDwUSmvcTRRY?=
 =?iso-8859-1?Q?97BzOVC+gPWNBeJywlb91LmB/korvf4T8OfPjh/Vaf1T/F1+rWF7EoVqvW?=
 =?iso-8859-1?Q?w2jA90457ZNQErzc8ArP+PaelpKsBgXXeWRaakE4+Egfzu2q9VmGNhs8O0?=
 =?iso-8859-1?Q?KKnCqAa6EHgqdo/qvyYZXIaDLGFs2SgfefBsWecjmiCHCV0dpVF5mI3p9V?=
 =?iso-8859-1?Q?XhzVOEKmK/kjWqLYJY3zuHiTKpqzbO94Xv0YcWHpliByfO7QSvGmcEzKvY?=
 =?iso-8859-1?Q?Lh4B7NWKwCZT2RNfCvC9W1u6m0b7Ut32i+q4NJwaT9vjrdZ5QS2rjFFrcV?=
 =?iso-8859-1?Q?uFpO5feIXVu2WWPdBKwfYlWIEl2EwyLMo1OTTISF1P4nNjcwNUvkYAIzeq?=
 =?iso-8859-1?Q?STJKXnc27b/XxqN5VbgRiHxFLTxUKHxJguaSfl1MlDCGtFku0HrY8uthVR?=
 =?iso-8859-1?Q?wsXocwSV4BdjstfMzEB6CGYmICVgg9/gP5qQPE2hpN3udkBtJJP5u1FXEe?=
 =?iso-8859-1?Q?OZLfMDus43NJ/K0UkFGob0musLqD82j/lp6YVFOJJBNSo2xYmPqAQM1g6O?=
 =?iso-8859-1?Q?dlQbnufrUrtlN+eFa9TuqS/vEa3J9cr4vWcN6lx8Wkj0YhzMgir3iOsNpL?=
 =?iso-8859-1?Q?aW63pJtmhteQHvLU5UozBTjyjjZBaOAQWtvk8ZPru/CwMjg6bqs3zoc4+f?=
 =?iso-8859-1?Q?LDNr7Dy3JL8yNYrSjpoJXm6zuuBqh9CmkbrZGZxPbPauLN6bDB1031hQp/?=
 =?iso-8859-1?Q?mZCIBpGgM9YixC0Djf5pke0EhIsIufB4WR2yngaeemtGZ0IguTayFLIIxs?=
 =?iso-8859-1?Q?Im6mv1Cq3UjoKLgh3qd4NqrWXcWjxzGyg0EzUYk1v5CPXcZfeA4mk7d/9F?=
 =?iso-8859-1?Q?Y8ybMIXrOJgAHyyOwSRC6EBR9VAxtHs0ufJmtetDN/tJNS2wboa8Nc408v?=
 =?iso-8859-1?Q?0knCESMLCMEsGq0Z+U9Q9okrk6kYvnXfw17FCkWE8Uc6ZQ/j6d//l275yf?=
 =?iso-8859-1?Q?hp7TABrvKCXmFrlmqN18X4PXLy96e7aGeoGBHRf/ma3+61jVJTZVaWEymM?=
 =?iso-8859-1?Q?f8I3/sF80O+np4uNL3lHWx5Pr7VWC/sk80A6CBY9dC177bfFHZ/ePGIwP7?=
 =?iso-8859-1?Q?43LnIw8ANjz7txYVc+WztGY4NrxpPP0rSPXctTxR1Jo+HO11QWrQI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?GwbQhIm4KUXSoyuMTNkLNrgXRA9E+8M80kDHSSbIM+IWD7N6A2MfIFjuE2?=
 =?iso-8859-1?Q?dkwIWc3iXeKwgnGDy0BZeBNVc3dazD695/pM0fthUaO7xWQN7pv1mYHrgy?=
 =?iso-8859-1?Q?oshoWPz3MDefBHZYCQQfC/raz4y5iQjmXgThvMv2trVdNjTkNhDS3EUbsK?=
 =?iso-8859-1?Q?WjD/COQTHrHAvM829xw3Riv+b1N2v3Bse+KVefE5YaHCrJ44lIrmR4u1Qt?=
 =?iso-8859-1?Q?5qlNw1RdYZ/pUBs52D5pxX82X2UxQDxj54xHytEWM4as/f4CiCdELFNiHt?=
 =?iso-8859-1?Q?BswcI198Z9L+rQx3T+VvNMv9pGp7fhLIST+jpIhFFGPoGRMF+ZdKWvhRwQ?=
 =?iso-8859-1?Q?5ikKHaZ9CEuacb8oGrG2IjrOOcWNleFemJKmbz9FNErl6pPnYsgMszRt4Z?=
 =?iso-8859-1?Q?fSYJJbLY+QPDtwiPynSgGxZHJtTUXcPZ8p6VTfPDQCOpmQw+EwN/7kfluu?=
 =?iso-8859-1?Q?O2KHpP/Zc6AM5UPhUflOsQyfkVZ7YrkuQAus3DtL8v0K9CgnGRji1VeVP3?=
 =?iso-8859-1?Q?MCu4V+9JAeZSegmkN6MVD0gcDPO1i8ng1bFAtVRYbzzF0ZbrYC4F3dRyQ9?=
 =?iso-8859-1?Q?5v5qALuI8SMxhP7GhP0z7hgXyu4FH6qKN1rn+rRlj7ZhlO8TaF6aFSduHe?=
 =?iso-8859-1?Q?7MO1q8CuFiqPDeWxSn0B4JIAWv7iDQDPX/w0DWbMqv5JAjgCcI6L5YTMQS?=
 =?iso-8859-1?Q?3hZqPhtTXr1zv8N7etRSyFXODedsweXmzdTKcwYrTIS206avrrIrWtTyxO?=
 =?iso-8859-1?Q?4GOSEp/SZxzlQsJy6Imued5RlKl8VJaj378NHmrToppjxDbAJ45qkbVVKZ?=
 =?iso-8859-1?Q?sh30skpPWaG4E+nEdsTsC2QGFZ6I6jQI87IbQ+nMzuURUkn1/MBcg4bmxd?=
 =?iso-8859-1?Q?LkcnghnkhiqNpxebhdlsQrG33VJmNxvwKguRJLgBGzvYRyKMh9fGnVQW7a?=
 =?iso-8859-1?Q?OdnKkkGoCMwz0wgdYPefMXq0FvYTFpW2ydR+ZproB5R4GHuWL4WUXivwuS?=
 =?iso-8859-1?Q?6CQQefR0HCZI7a0AGt/zopSPIG2CXkmlhRO1w7dHTgfSx6BJRxSYqBwIgY?=
 =?iso-8859-1?Q?7+/5rCaBz2f7VGwLBPyYBWBWiFF6Sqkcnxqf/IXEO5Q4xN1ILf6wJtlBa+?=
 =?iso-8859-1?Q?cY3JZKsB8B0FBwp1M2fn+l/aKj45CnCZQzL5fn6uZ6pjU1Cj1b2ohpwHyO?=
 =?iso-8859-1?Q?9QoNTq+WS6X3Qo6xL6R6djPJjVuv80ybTeCcY1AYzxlQRZOUz3mcZdDsJZ?=
 =?iso-8859-1?Q?D31WoxsSK3ErLafMGeMJ6/hqKVmbrQgyZCIILsL+bEY0ezR8TKxz7eCaqN?=
 =?iso-8859-1?Q?suPWX9NxAD+wHAY/JT1KAJxuUNHLKr/jJkVJFLz/+DUqxZoG6RK3LSqe/v?=
 =?iso-8859-1?Q?9nH1NbwNsYIipwVqjqauNsa6yBimKqf8Z+d7EFawH4RVnWpIaHYeKezF54?=
 =?iso-8859-1?Q?lty5crVJ1lspifzuffHLtYAh+u2O5Hj9iPlYcpUFohU6NEbM9L7sx7uxDf?=
 =?iso-8859-1?Q?F7F/8bEKzEavcMFZ3cqKgRK2Yr88jGmlkmR/hZYOSQjNQDXDajya4664tO?=
 =?iso-8859-1?Q?/St8sytLfIEX633za0PaaLJmrrhiGoZUwBCAUtgRmn3ia/kAJkd9UI0drA?=
 =?iso-8859-1?Q?Nu/iaInFhGukY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cf1a03-5daa-4042-ef86-08dca72b005d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 13:10:31.0796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5AJxwVetzuJ0ldlOUPWn09j/BNXM/rX2xrMKZE5uAYcSl6IblMyq6v9YHqRPS7Eg3CYvyIAWwwod2jPfzoFxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8292

Thank you for the fast feedback. We will rework on the findings and send yo=
u the new version soon.

Mit freundlichen Gr=FC=DFen / Best regards

Jianping Shen

Mobility Electronics - Sensors, Engineering Advanced Development - MEMS Sol=
utions Software (ME-SE/EAD2)
Robert Bosch GmbH | Postfach 13 42 | 72703 Reutlingen | GERMANY | www.bosch=
.com
Tel. +49 7121 35-37749 | Telefax +49 711 811-509378 | Jianping.Shen@de.bosc=
h.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart, HRB 14000;
Aufsichtsratsvorsitzender: Prof. Dr. Stefan Asenkerschbaumer;=20
Gesch=E4ftsf=FChrung: Dr. Stefan Hartung, Dr. Christian Fischer, Dr. Markus=
 Forschner,=20
Stefan Grosch, Dr. Markus Heyn, Dr. Frank Meyer, Dr. Tanja R=FCckert

-----Original Message-----
From: Krzysztof Kozlowski <krzk@kernel.org>=20
Sent: Thursday, July 18, 2024 2:47 PM
To: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>; jic23@kernel.o=
rg; lars@metafoo.de; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg; dima.fedrau@gmail.com; marcelo.schmitt1@gmail.com; linux-iio@vger.kerne=
l.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lorenz Chr=
istian (ME-SE/EAD2) <Christian.Lorenz3@de.bosch.com>; Frauendorf Ulrike (ME=
/PJ-SW3) <Ulrike.Frauendorf@de.bosch.com>; Dolde Kai (ME-SE/PAE-A3) <Kai.Do=
lde@de.bosch.com>
Subject: Re: [PATCH] drivers: Bosch SMI240 IMU Driver

On 18/07/2024 14:24, Jianping.Shen@de.bosch.com wrote:
> From: "Shen Jianping (ME-SE/EAD2)"=20
> <she2rt@LR-C-0008DVM.rt.de.bosch.com>
>=20
> Add Bosch SMI240 IMU IIO Driver to iio-for-6.10b

What is "iio-for-6.10b"? How is it relevant to git history? This is suppose=
d to say something about the driver and hardware.

>=20
> Signed-off-by: Shen Jianping (ME-SE/EAD2)=20
> <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> ---
>  .../bindings/iio/imu/bosch,smi240.yaml        |  45 +
>  drivers/iio/imu/Kconfig                       |   2 +
>  drivers/iio/imu/Makefile                      |   1 +
>  drivers/iio/imu/smi240/Kconfig                |  30 +
>  drivers/iio/imu/smi240/Makefile               |   8 +
>  drivers/iio/imu/smi240/smi240.h               |  31 +
>  drivers/iio/imu/smi240/smi240_core.c          | 814 ++++++++++++++++++
>  drivers/iio/imu/smi240/smi240_spi.c           | 153 ++++
>  8 files changed, 1084 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
>  create mode 100644 drivers/iio/imu/smi240/Kconfig  create mode 100644=20
> drivers/iio/imu/smi240/Makefile  create mode 100644=20
> drivers/iio/imu/smi240/smi240.h  create mode 100644=20
> drivers/iio/imu/smi240/smi240_core.c
>  create mode 100644 drivers/iio/imu/smi240/smi240_spi.c
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml=20
> b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> new file mode 100644
> index 00000000000..972819cacff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> +---
> +$id:=20
> +https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> +cetree.org%2Fschemas%2Fiio%2Fimu%2Fbosch%2Csmi240.yaml%23&data=3D05%7C0
> +2%7CJianping.Shen%40de.bosch.com%7C666fcf2fcad249cc892908dca727cdda%7
> +C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638569036597203543%7CUnkn
> +own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> +iLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DijO6JQTkrWJw5XLJMk%2FKey6Wq%2BvEk%
> +2B0FmIAwLiNaSxM%3D&reserved=3D0
> +$schema:=20
> +https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=3D05%7C02%7CJianping.Shen
> +%40de.bosch.com%7C666fcf2fcad249cc892908dca727cdda%7C0ae51e1907c84e4b
> +bb6d648ee58410f4%7C0%7C0%7C638569036597212752%7CUnknown%7CTWFpbGZsb3d
> +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> +C0%7C%7C%7C&sdata=3DmbYZyVVoFzmBDNT0YELRFQmV6Ag3AJNJ%2BjGJKN%2BTv2k%3D&
> +reserved=3D0
> +
> +title: BOSCH SMI240

Also: BOSCH or Bosch?

> +
> +maintainers:
> +  - unknown
> +
> +description: |
> +  Inertial Measurement Unit with Accelerometer, Gyroscope
> + =20
> +https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> +.bosch-semiconductors.com%2Fmems-sensors%2Fhighly-automated-driving%2
> +Fsmi240%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7C666fcf2fcad2
> +49cc892908dca727cdda%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638
> +569036597218023%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> +2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D1OK2dyvXLmN0
> +STEslacOHryAVJ%2F0%2BQcILMtirBmQDwc%3D&reserved=3D0
> +
> +properties:
> +  compatible:
> +    const: BOSCH,SMI240
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - spi-max-frequency
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        smi240@0 {
> +            compatible =3D "BOSCH,SMI240";
> +            spi-max-frequency =3D <10000000>;
> +            reg =3D <0>;
> +        };
> +    };
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig index=20
> 52a155ff325..2c348ad686a 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -96,6 +96,8 @@ config KMX61
> =20
>  source "drivers/iio/imu/inv_icm42600/Kconfig"
>  source "drivers/iio/imu/inv_mpu6050/Kconfig"
> +source "/home/she2rt/dev/smi240-linux-driver-iio/drivers/iio/imu/smi240/=
Kconfig"

Yeah... this won't work, obviously.

> +source "drivers/iio/imu/smi240/Kconfig"
>  source "drivers/iio/imu/st_lsm6dsx/Kconfig"
>  source "drivers/iio/imu/st_lsm9ds0/Kconfig"
> =20
> diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile index=20
> 7e2d7d5c3b7..b6f162ae4ed 100644
> --- a/drivers/iio/imu/Makefile
> +++ b/drivers/iio/imu/Makefile
> @@ -27,5 +27,6 @@ obj-y +=3D inv_mpu6050/
> =20
>  obj-$(CONFIG_KMX61) +=3D kmx61.o
> =20
> +obj-y +=3D smi240/
>  obj-y +=3D st_lsm6dsx/
>  obj-y +=3D st_lsm9ds0/
> diff --git a/drivers/iio/imu/smi240/Kconfig=20
> b/drivers/iio/imu/smi240/Kconfig new file mode 100644 index=20
> 00000000000..7114c941cc3
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/Kconfig
> @@ -0,0 +1,30 @@

Missing SPDX

> +config SMI240
> +	tristate "Bosch Sensor SMI240 Inertial Measurement Unit"
> +	depends on SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Build driver
> +	  for Bosch
> +	  SMI240 6-axis IMU
> +	  sensor.

Ooh my... what's this style?

Read coding style for Kconfig.


> +
> +config SMI240_MAX_BUFFER_LEN

Drop, dead code.

> +	depends on SMI240
> +	int "configue read buffer size"
> +	default "1024"
> +	help
> +	  1024 bytes are big
> +	  enough for most cases.
> +	  Do not change this value
> +	  if not sure.
> +
> +config SMI240_UNIT_TEST

Drop, dead code.

> +	tristate "Unit Test for SMI240"
> +	depends on KUNIT=3Dy
> +	help
> +	  Build Unit Test
> +	  for Bosch
> +	  SMI240 6-axis
> +	  IMU sensor.
> +
> diff --git a/drivers/iio/imu/smi240/Makefile=20
> b/drivers/iio/imu/smi240/Makefile new file mode 100644 index=20
> 00000000000..394eaecf5f3
> --- /dev/null
> +++ b/drivers/iio/imu/smi240/Makefile
> @@ -0,0 +1,8 @@
> +#
> +# Makefile for Bosch SMI240

Drop. It cannot be anything else. Do not say that "x" is a "x".

You miss SPDX on the other hand.

> +#
> +
> +obj-$(CONFIG_SMI240) +=3D smi240.o
> +smi240-objs :=3D smi240_core.o


Best regards,
Krzysztof


