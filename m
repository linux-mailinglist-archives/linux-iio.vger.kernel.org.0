Return-Path: <linux-iio+bounces-7844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C6A93B288
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1CE1F21D45
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 14:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D4E1E867;
	Wed, 24 Jul 2024 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="j3I+lQk0"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2054.outbound.protection.outlook.com [40.107.103.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893151CAA1;
	Wed, 24 Jul 2024 14:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830772; cv=fail; b=jUF/bKr5UG9BAJ7L1D6iK8ctIIAY/Ve3mBNlrEHnCjZMhyUYaN+IRvOCKBHp0js1L8CHtBh+ylLZb6mHAuPRFiIsETcK9J5mmA7dzaYFJEepgjuLsiW+HcuckdZcbfg5KBPXM76DCAaRA3niXdRxQ207RjCuBfky5qmGobHnCiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830772; c=relaxed/simple;
	bh=doU27+nxEq1BIg9Nfk0REljlPVomYV3fpEwlPgzOG20=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kjMHBNbgC+xJAbSscKKV4RMqwxTnL1Po50kv7dKx2W1EG/uj3mPdeIbPQA17M6TB7VjoJ8iWKCRV8gES3AKLBUiZfbG4lZ/O1aqSn7934E8bos/FaEBNwjCd6raNW/oQLoc9iqkrpvxTMXbL9yeCEKvpr6+SxSqXohLiXT1J5ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=j3I+lQk0; arc=fail smtp.client-ip=40.107.103.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyWgMSKTA3st2RVsh+zoHFUMcBhHB0BM2VIUebiTshEwIKMbcdUZ7YgYbk50Wuc8F8XDtjDllgmkj5jAWBzBjFF8YnkiQma05F2i8xiOX1GN/0+eXNhnbTdrElYKCoMH41q9dGTOey/AJfEMHE9phJqKtUpEbUU0UrErJWXgW+hMQ7GmwnH/J0nbnXpHjmgBrNFXdSuqP4CHzOaM5h+DT8UHu03NOgKjhTaAdnJnwOwGKqSyGcf2StKDrbh2C5zYuikB0/L3YkJE1jo4/qZTcV6dxwzXqurX1ccpUhnYwhr2tf8UUux7pwYNA5l76X4fjJaz45htua6xT7zvRbIB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eoow8jkCUNZP1ibIMKaz4vkggulpWlCjYEdpUFHHA0s=;
 b=mYbjFssQMqWusKxwuflO6ATaqWuh7xnV0eZew96vYq86Ip7nKdnwrdVZTQmfE5+qOW29sghsJOIVJGlfKCdb5A8lD8unJDWmVZvCjruB8GaTUFN08Ffi9L4dSRAQDkkwbqMxryvHj83JDt1urKK4ATvaL1cU4FGOj3lwEJeJZul2A4lGEWs0G6U1n1eGvrj8Ss9t2gBItu9H3jpTzlTsc1klm4Lyf9HCz9n24AWP7p/IBUzPeViEZLT4I3Hx1G+oK000E3YAJBFna1YWxjBWp1PWVdnifmbEEIEt/WPVylzpB1giO8pVYpdZXmyFDjaM3alBy28bFXZ4easFA0aObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eoow8jkCUNZP1ibIMKaz4vkggulpWlCjYEdpUFHHA0s=;
 b=j3I+lQk0Tb9QwzLK8WNEvgCocTAG0MWTUbnYeHP9JPN0qojqe96dbKcD2VT+dMcjt7Oeh7wjEsadMg03cDoDqACz40UC1SPjKJV89X2AOeR0c8jeRWh3KOuVPwf4QvdZ3H+CLYU4cw95z3+r4s8oFRlE30pdFnPV3Z4s5GXoUpojGgzrAfkFtjmhBTMOy9JX7FX713lOAK3FPZ42rAanle99Gtlt+97Nqe1zm0ZvUo7mstwgEyYeGv1LDBUPuTHb9ylOCL+pvrzGtwa0IWfTAzGpJySGmHY8k9ulyl9jkn0dQCFhOvx1IYmeB2jpBawaNdIRXNxGFbWtwrxHFaKRHg==
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:315::22)
 by DU4PR10MB9192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 14:19:25 +0000
Received: from AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74]) by AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6748:a0c9:d73d:db74%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 14:19:25 +0000
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
Subject: RE: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Thread-Topic: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml
Thread-Index: AQHa3chB8xxiR7i0TkqCxVScMqlaI7IF2/MAgAAOijA=
Date: Wed, 24 Jul 2024 14:19:25 +0000
Message-ID:
 <AM8PR10MB47219903C83BA4F0AFE2DAA3CDAA2@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240724125115.10110-1-Jianping.Shen@de.bosch.com>
 <20a8ad37-f6ce-4342-a2f7-bf3495dfeb69@kernel.org>
In-Reply-To: <20a8ad37-f6ce-4342-a2f7-bf3495dfeb69@kernel.org>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR10MB4721:EE_|DU4PR10MB9192:EE_
x-ms-office365-filtering-correlation-id: f8e7cf38-1a34-425b-1a3c-08dcabeb9f24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9iTQ0GPty49JaWgP/E+L6/a2Gux8A/OVUKG0uflINYDAAXEa4iOzAaD0Tf?=
 =?iso-8859-1?Q?r9+zcqLcW/Mr63Zw3o1H/FsoT02UcV+N/Z36lh3UdrUn3Nzn2+sTqpKPVL?=
 =?iso-8859-1?Q?kG0e+iaOD5fCrXSw7oEs4VIDpdU6eRb1Z7mxZt0QV3L0o37sWMt5WMAvCs?=
 =?iso-8859-1?Q?LNWzUEtN7xOoP111H8rRramMBYfVNzTCbTi8AE7Nk5Q1XXUhw+XGx8zrOF?=
 =?iso-8859-1?Q?Pc/bzdKQcSg49ZcbDz8oi31hwf2p03P4uPe8lk/6gyKEgURx2pmY+midau?=
 =?iso-8859-1?Q?bBvryf6FfqXBkLwqt30mz2SDHrV6ICzVoz4MXbMT+HZ3BcnkWSCR6/nvbI?=
 =?iso-8859-1?Q?SNWP4MnNnLH7R+cn64K3+K1mAuaYrplZInSROOJxy8e93CadrdPKSQjID3?=
 =?iso-8859-1?Q?XfLj8NYykwRxCBYPxHNELDycuM1Btyvvj0S1uZS2ykaDzxeb03LCMPFSHh?=
 =?iso-8859-1?Q?/uSpTdanTuRMfBLyFh6fxl1JEvVqGvmFpT0BRkwYlYtgADsKABOaYwdxpl?=
 =?iso-8859-1?Q?7CCJ5mMacgTNP+liSiptFHAugdqMsuHCu3bIL12Jsqp2vXbnS4zAxsulDQ?=
 =?iso-8859-1?Q?PPsDmLS5YIkRRT7+1i7fLgbcMlBFFHYJzVvPLUn+qg3mguamFVv5xD1s9K?=
 =?iso-8859-1?Q?FADRfsU+QqLeBznoFvvow1+Zg1Mo4PwEGgtCe9TqPgHUlQ+zr23PpsmTFY?=
 =?iso-8859-1?Q?/XeguHkQU47KvWd6JescVaRnidRgff9vKSEgjzqIVYoX/KlgTNvNQZfDF0?=
 =?iso-8859-1?Q?ann18FtINl/7LYpx82X+WXLMLLDFWwRY25w4nexCQ5d0tnNI0K3ftmAAS1?=
 =?iso-8859-1?Q?W/Va3TwK4W9SO6MJP/2JbvovKRcnGvgybhjet/9Pt5Q9o/rB9LN6vXHKqT?=
 =?iso-8859-1?Q?GycIH20fyF2J9nR/rptykgeL532qwXNGFf2JFMtz69+bhcGJ5TnGznh+Q5?=
 =?iso-8859-1?Q?XFN5U0nanVXy/3OUFZFrzo646jByQkA6Kf0dRUvojH16W+H9qqt50cWng0?=
 =?iso-8859-1?Q?i/XSHCzCZz61YTr2VhExGXcubAot6RG24OLRMRepXVIuUYLNTCjIf5eBGN?=
 =?iso-8859-1?Q?h03/6Yk5lGveKkoJvT4u+3gUanr65EwTNvlv1KCYkkrIMg9J9iYethBbhE?=
 =?iso-8859-1?Q?VJ5DKVsDY0txVBK2nTF/r6qKAl19i/drGusxPFuJn7MXZUUsw9vF1tIuSR?=
 =?iso-8859-1?Q?+CkJmhs4BAMiNiF3JEpGipV2E6ijUYj8aWQS17TTaei5JdmpXrkNoiECJs?=
 =?iso-8859-1?Q?L6MSNe3cLG5us9wRsvaT39b7SWq9PqnDB8LsqZOe4Zf6QdTarWCu+pVj8l?=
 =?iso-8859-1?Q?UP62LnRN9qRmYQpSZJ5kXx+zXU5ixVqjM4rGroMjEUjPu/91ah2PmJwdyH?=
 =?iso-8859-1?Q?nQk9hQR4VFCD8L57wseUWTkAcVdjU9t8MvSwIK4ng86RPVbH9Uqdjr6OT/?=
 =?iso-8859-1?Q?DV9Xx1WOW39Fn9VR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OKVdj3qeM27OxLaSvd7Sl3RJdsJeNYY9i1jIYrBNT3nsRf0C1mNzkdQ1CI?=
 =?iso-8859-1?Q?LEzBJ5Ci1eo73DsTuPeluIvFB6kBOskrbIZjRIEu28SEDdnCm+eCoJKxO4?=
 =?iso-8859-1?Q?1LsLu6/9+AxWJwIfpO6atmMSIjOFnp05zZHhpU8DwDzGL/SrCOJz1XwUP1?=
 =?iso-8859-1?Q?aH7zh0THpKnk2/Q0Dv6sWeIcwOCPbjtIEWmqN3g7LpilpVZUEBAoQVCWLb?=
 =?iso-8859-1?Q?O42XR/38prnCtaB16OjKSMhve9Ap/ica7dYf1mFrKHpE6AWWGMDStEXZnn?=
 =?iso-8859-1?Q?P1jurt8xuYuZXM4QI1BERZ9ZIqYVosVDJoTpxe4J2e/ocejG4W9wO1kxge?=
 =?iso-8859-1?Q?gxuhHSsp+cpBNLraY3N0JGnLpIxwOGmkp/fTv6zh4Jqa2QydJola8tOppH?=
 =?iso-8859-1?Q?tUemeqG6SoVB37q7vaEBe+eC3Tk7ZEdLDo2gyGKcyjphZjDT+3MYU3iWpJ?=
 =?iso-8859-1?Q?6sxr65nzBxIotohhBPlPsW90vhsyeKQNDeDwux/BTFetwCcPIsBXLN0GY+?=
 =?iso-8859-1?Q?wIwHOJbBU4Pv6VdExyb/2Rn0TFGvQI/NThURw1ZyTTWmLempPPprltVcuT?=
 =?iso-8859-1?Q?hpIlX2LCJQOoBx3L3DNdV85B3sg9COBUfQNClwq4c4qkJ1UyE3QXZdQkG0?=
 =?iso-8859-1?Q?Tr12/nMcOYAh7Jjs2uI6tjrBW55HOGD0T0xE4dPWYZam+Cr2PnRnU6eEai?=
 =?iso-8859-1?Q?Ao9Wlu3t4hSPflD56r/4XKbvsvPufWwUCdEXwMRjkm2uOx4OR/7kiTKRm7?=
 =?iso-8859-1?Q?Htn/f395kxuU+b6jhCsiPsiI+7KorN7pLoT3Xpp78SNJSl++yCZS+pI41F?=
 =?iso-8859-1?Q?mfKR5otzJBGJI76PHp7SYgq3f+r5UvgMhh4wfYu+GEjzcAG5dgm88QaY9x?=
 =?iso-8859-1?Q?iBeXMY431kvZNItRpfJbGwMcIZ2P5godq1XdA23i3f0HqCQzkygtTNMKHA?=
 =?iso-8859-1?Q?m+Q9D8D7ZtKAVMvTofLDoL2A7NcoZxiJjUQkmJf1Q5+3w7tPwGd9W5bTXn?=
 =?iso-8859-1?Q?vpnTCtu9RzZI1N3ipEKA1YWXXX4mpkevmL18jPJv2bLVjlQeKfCKGY7rbz?=
 =?iso-8859-1?Q?qQdmdEQ96ZzZNqdvE6kKXSKESnuW00NmoCTbEfXJg3eiCXjU86TjmC7dxZ?=
 =?iso-8859-1?Q?9v36V5orp0SaDUOEYg/pQTjA5Xiwh2oj6Wb10zfWH8loaRfEO2rPO6iT4t?=
 =?iso-8859-1?Q?W/VPdQcDRTYxl9iPYzHkFj+y0dk2ZGU1Lqdz1dmPyVJLsiUmlb9xHFPnzt?=
 =?iso-8859-1?Q?ypSieMNEweFwHC7KQ7SU81CzZO0sbxGt2PK1jP3QwUri507Qo+Jr+VKm90?=
 =?iso-8859-1?Q?l+zmx/3/3knlQLy/MT/5/j7kAKXY7eDp7hWnjswvUowHwdQ/345pwhbZPo?=
 =?iso-8859-1?Q?wOcex5VApXYFaRWLHHWqMIeUV+c9yrB6MKCsW+SigfBp1d+E17QfhPPQxW?=
 =?iso-8859-1?Q?Gkj8wbuV0RjtzW1PYiTIUCn07dzednHW70Ix8s5uTxWcOROqwtvp8LOxR/?=
 =?iso-8859-1?Q?HkbWcV0UqcuTIfyavefr3NddP358cpJi7sVKcuUy8J+e2JQDU4KO4miNLF?=
 =?iso-8859-1?Q?JF4SRtoIE8/s4T3hLJhoPsHW7LOHkCoBuM4jK1YmEfGRq/UbX0FCLfpa8/?=
 =?iso-8859-1?Q?X2KjFetdHys+A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e7cf38-1a34-425b-1a3c-08dcabeb9f24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2024 14:19:25.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5/aMGjYXMwZTiPsIpaaKBkHCkA4cRkxTmwE1FzckMXhjwo1BgtbNYImTOqzc9brZunDGUn0yN0ssh0jBzAO1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9192

Anyway, please send bindings with driver in the same patchset.

-> It's fine for us. Nevertheless according to the Devicetree (DT) binding =
submitting rules 1.1

" The Documentation/ and include/dt-bindings/ portion of the patch should b=
e a separate patch." See -> https://www.kernel.org/doc/html/latest/devicetr=
ee/bindings/submitting-patches.html#i-for-patch-submitters

Shall we still put the binding and driver in the same patch ?

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
Sent: Wednesday, July 24, 2024 3:17 PM
To: Shen Jianping (ME-SE/EAD2) <Jianping.Shen@de.bosch.com>; jic23@kernel.o=
rg; lars@metafoo.de; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.o=
rg; dima.fedrau@gmail.com; marcelo.schmitt1@gmail.com; linux-iio@vger.kerne=
l.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lorenz Chr=
istian (ME-SE/EAD2) <Christian.Lorenz3@de.bosch.com>; Frauendorf Ulrike (ME=
/PJ-SW3) <Ulrike.Frauendorf@de.bosch.com>; Dolde Kai (ME-SE/PAE-A3) <Kai.Do=
lde@de.bosch.com>
Subject: Re: [PATCH] dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml

On 24/07/2024 14:51, Jianping.Shen@de.bosch.com wrote:
> From: "Shen Jianping (ME-SE/EAD2)"=20
> <she2rt@LR-C-0008DVM.rt.de.bosch.com>
>=20
> dt-bindings: iio: imu: SMI240: add bosch,smi240.yaml

Something got corrupted here.

Anyway, please send bindings with driver in the same patchset.

Limited review follows:

> Signed-off-by: Shen Jianping (ME-SE/EAD2)=20
> <she2rt@LR-C-0008DVM.rt.de.bosch.com>
> ---

Missing changelog. That's v2, not v1? Provide changelog under --- and versi=
on your patches correctly. b4 does it for you...


>  .../bindings/iio/imu/bosch,smi240.yaml        | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
>=20
> diff --git=20
> a/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml=20
> b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> new file mode 100644
> index 00000000000..5e89d85d867
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> +---
> +$id:=20
> +https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> +cetree.org%2Fschemas%2Fiio%2Fimu%2Fbosch%2Csmi240.yaml%23&data=3D05%7C0
> +2%7CJianping.Shen%40de.bosch.com%7Ce4bd3cadbf5f4b17bf7308dcabe2e9b6%7
> +C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7C638574238283264004%7CUnkn
> +own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWw
> +iLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DgbcSKWPDSDT0qTWo5L%2FUYxlQDunqNl2l
> +L7JAxwHhNJY%3D&reserved=3D0
> +$schema:=20
> +https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&data=3D05%7C02%7CJianping.Shen
> +%40de.bosch.com%7Ce4bd3cadbf5f4b17bf7308dcabe2e9b6%7C0ae51e1907c84e4b
> +bb6d648ee58410f4%7C0%7C0%7C638574238283281959%7CUnknown%7CTWFpbGZsb3d
> +8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> +C0%7C%7C%7C&sdata=3DkW25MDdZz9c3ePA%2BUrGXSWsBWlDxb6UAKjOeLSnFEXU%3D&re
> +served=3D0
> +
> +title: Bosch SMI240 IMU
> +
> +maintainers:
> +  - Jianping Shen <Jianping.Shen@de.bosch.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The SMI240 is a combined three axis angular rate and three axis=20
> + acceleration sensor module  with a measurement range of +/-300=B0/s and=
 up to 16g. SMI240 does not support interrupt.
> + =20
> + https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> + w.bosch-semiconductors.com%2Fmems-sensors%2Fhighly-automated-driving
> + %2Fsmi240%2F&data=3D05%7C02%7CJianping.Shen%40de.bosch.com%7Ce4bd3cadb
> + f5f4b17bf7308dcabe2e9b6%7C0ae51e1907c84e4bbb6d648ee58410f4%7C0%7C0%7
> + C638574238283298041%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> + IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3Dd2%2Bk
> + j8GzUms9o0Nbdu9QpTzZwujQnjJMp0GFp%2B5MrB0%3D&reserved=3D0

This does not look like wrapped according to Linux Coding Style. See Coding=
 Style, so 80.

> +
> +properties:
> +  compatible:
> +    const: bosch,smi240
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: provide VDD power to the sensor.
> +
> +  vddio-supply:
> +    description: provide VDD IO power to the sensor.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        spi@0 {

That's not a SPI controller. Your description suggests "imu".

Best regards,
Krzysztof


