Return-Path: <linux-iio+bounces-10675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB779A1BE9
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 09:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0F71F23624
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 07:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF28E1C1AB1;
	Thu, 17 Oct 2024 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pd891q23"
X-Original-To: linux-iio@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5513AD18;
	Thu, 17 Oct 2024 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729151215; cv=fail; b=DJfPXmYSklIKS5dKJekaMBVa6Y1B1RE0z4LFf0jSvmey23p1bXhTS3kY1hWPpcdDrZDHDRagR5FaGfd7aHDf9gO8mkSFjyyUBDWVYwneyvUhzMR/Gsu04CtKPpkknh6yGPIC8IyDxfrXIXcs2mBQ4hDjwhQOgxNSKi47a+eGDI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729151215; c=relaxed/simple;
	bh=9zXoCtsbcXgRAvUdGVV91sLDz4OpBCxlWCfWReslbVw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rH+KVeCTsUhOBQwWd8LgRKEwvXgyFiyOaHgvNC9XTypx9OrSbL/1+s/Fwgjb+OUhp5VQh8GNjK61WlCB0sLQJguRv4FSm2hP0Ib+j0k+XSJYSbbCXMD6mQXyd5NHjoQOEfyJDNclAzCkN0oZUads3hPdLlFNsV2n9m1BXj8wIbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=pd891q23; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnAVMIkptAG4iOj2tPSt/toSzWowKigCKZEftcrjCyYvxq1XeSheCAM+M16T492CKNUWCykKg94P5Tfqr7KhZ+RirASEP1CD+SZvDZiGkrjmMKIr2e1zj8/oJJRrw2ElpezvjCjN1SS5Xn5UYQw93kSXZJYWcA2fd98Mvm6Id02oXga0YiMYaiOzMJsSMLIydvtpll+n/NZyPSCp9RpiaBafn4RFUU73vYHqXW3DhO6iaJdUF1oS5V0UMRrgDqS0V5TmipBtNMUs9IinWfoerLQLO0cjUh7/aCRKB6MUoP1cSaAQtNL6CST1euiATnd9tEhT2M0HMOwUD1ej5kVVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6nhbr5VOHfa4NoViZ5ElfC1A9dCnVcguwmsTrDzM3c=;
 b=tqJwO5ar9FQkrt2U/0Q0pUmx6+rqToG926253O6e3WC30myvRloWGGM9iiBZm87zHjWrF4e4y1r+Y3EFrb3OXSNC74YzePGiPZ6L3ENqTqlkrviBpnqAKQ0OTAwmd4lm/IX2LUAmjF6nnt78ai5TmhYvGFkuYZPsyg9boC73QutcYp2fICviYuFvdk9Ex31U2mZhLyoIs6hp/VVcqb3goYwrivAOSMaL4ZqY1JgcnnnztAxozx8OdRMLXDikow0eFWO8GcC4t85jhYgEmQia40Oq+BU3a82ZzAIyO8I2YnzyfK1BqydSWncIMn7IzFJfdtSz2oB5yy1PPQPjbkDPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6nhbr5VOHfa4NoViZ5ElfC1A9dCnVcguwmsTrDzM3c=;
 b=pd891q23xke4lG46xc6HD9/RQcHsRHLOhYxEyL/wV20fWEnmVCZ/YPk5b1Z1H1n1DlHuy4Lw7eBKi885/V6tAZEfbtxuY4Qic8X5/OPhJeFtWa460J7OgY2D2rFwO4hBmWHS0zQq9yznBrbjv9bdpR//eKf2pZ6yjpGlaalzXZ9Wr7i2WdDxHXoEmi+BS6kukBZKQ0TXMO/9HE8hYJyVDfBgfNC+HLfcCV09PTdMsrxR8Hh4LJd6H9rwlxtaNkTS++OY7nLNyHHKtuefPt+EK0ZN1oB6Zv6p+jiZ8fVBnTWBPHOxLm23w5eFCpyMtsU9JZ1O69najvMKZ0v2ontFJQ==
Received: from DB9PR10MB4730.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:252::20)
 by GVXPR10MB9005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8; Thu, 17 Oct
 2024 07:46:49 +0000
Received: from DB9PR10MB4730.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d41a:c5b1:2c2c:26b4]) by DB9PR10MB4730.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d41a:c5b1:2c2c:26b4%7]) with mapi id 15.20.8093.000; Thu, 17 Oct 2024
 07:46:48 +0000
From: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Jonathan Cameron <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dima.fedrau@gmail.com" <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
	<marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
	<Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
	<Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
	<Kai.Dolde@de.bosch.com>
Subject: RE: [PATCH v8 2/2] iio: imu: smi240: add driver
Thread-Topic: [PATCH v8 2/2] iio: imu: smi240: add driver
Thread-Index:
 AQHbDbXQJyb1UEtvh02vtlWF5Bgo7rJtd3WAgAf1bqCABDhggIAGe/cwgAAqSICACmbswA==
Date: Thu, 17 Oct 2024 07:46:48 +0000
Message-ID:
 <DB9PR10MB4730F796051995DDAFD03DBFCD472@DB9PR10MB4730.EURPRD10.PROD.OUTLOOK.COM>
References: <20240923124017.43867-1-Jianping.Shen@de.bosch.com>
	<20240923124017.43867-3-Jianping.Shen@de.bosch.com>
	<20240928181121.0e62f0ad@jic23-huawei>
	<AM8PR10MB47217960E30212DC62ED7821CD712@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
	<20241006121025.50802061@jic23-huawei>
	<AM8PR10MB47213230C6E43976AF244587CD782@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
 <20241010174259.00003742@Huawei.com>
In-Reply-To: <20241010174259.00003742@Huawei.com>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4730:EE_|GVXPR10MB9005:EE_
x-ms-office365-filtering-correlation-id: b930bcdc-c806-4253-67b7-08dcee7fdb1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IDmrtjB0YCTh50dG/k9A7cRO3RwMOhM9PTXK3dVp0Vgx6LtxQgj0Rk+dENmY?=
 =?us-ascii?Q?paT91KYYIalP1mVG+HK0+Ty0WFXB7EuAaDUFtayudZK3RXnWgZ25VI8AizzB?=
 =?us-ascii?Q?WUXx5ZI7VxOFTJ5N9haleNsh9jQHg4LlwHOJi2Xl8XQv3TV+elsc7NStgSNV?=
 =?us-ascii?Q?euVPTnDsMiqJruSFZciwhj0dzY6tDjLkGL/VPlxrCJgwms6BkLOSsJRyDVDc?=
 =?us-ascii?Q?Y1isUBx3vNTQ9+wwSLhUTQ+94o/JvWCGF0b6dH3+xg+6gQPKdba0Iz/w/N3l?=
 =?us-ascii?Q?UhAnPLX59xOOviCo4SwCaQISpNBzuGshgvY+3wKjQA2dE6ixbd97Tc0EQHSh?=
 =?us-ascii?Q?8QFMMqB+msSt/0rNNdYwe0ct7xdPf7S/OKm5ZdmPoXmiiKLVdBuv3ciq6meE?=
 =?us-ascii?Q?V1Fwz/hjlR51970qCVdK5yqHKxARpfzIZuuAtrLtIbI0JzVPUEkI4e+SeoCG?=
 =?us-ascii?Q?61wE/VtH/gYnRzm9/FGeiQfXeidCfSmheeCP3hqeq7pzAzyVrrjNsvJxq9Lv?=
 =?us-ascii?Q?mFBPIXCJUyl6xeN8zZTsJuUojkUm6bt9J2tIYBNHJyDVJmV+jKOmmDaEqyQg?=
 =?us-ascii?Q?u7vPnCbW6g1AwyVcONE3LQCmfRWASsjHRuTKqTxcPHfNkASB1pR1cB0oTDQc?=
 =?us-ascii?Q?CfI7MKMTm9Yl0Hpnmj41XpMjajeq0KXEoJx5ja6FANoyCvjmFZZpP9N6J6TW?=
 =?us-ascii?Q?eSyxH0f8tgY478IJYosRJrO2tGM9RDnU87gjbErqzSWaamwMMd2uWnmxSHDq?=
 =?us-ascii?Q?eZvABDRZyuzJIw5JQfVV9l4HoU7cAE2fMG/g4jr42MhTJ484tB0sbVAu/L0N?=
 =?us-ascii?Q?91OU3UEkYh6+ig7X2JqQXUa36cPJk5G47hFPCDLMHP4Jh8EOJwrwCAxGkIn1?=
 =?us-ascii?Q?Ev7DJepm3yxD1HcCKPQocbse/scwDF0JxOAbWWOmeNSVZUO6SygFH6ETEPFD?=
 =?us-ascii?Q?iyHNWmnA0mkWl19skiX+R6tcQJYs0+3L4RS4WfttK38AP10kvaVH0tVevHLY?=
 =?us-ascii?Q?GQSt1kvkfyDSB94/St0dzvX+CN4A8mhbgjVQamjNYY4Nm2tWt5az7f/UTEVw?=
 =?us-ascii?Q?GTPFHRm1ncebX3YOop2gH7krH9fJMNAsm78uepAO3z622RuPFA678Zm7ZsAE?=
 =?us-ascii?Q?47sD5864I1E4sOVWkNANC7IlqyYuBFSB371hpwDrl7r+IDHmg4AASQhI0BQi?=
 =?us-ascii?Q?d5lcXHG890cpJAOO07LzEtBf+JLh6kONSU4lWdN3OarnxLKNJbM1aW7bJ7oP?=
 =?us-ascii?Q?9/v+j2f1h026aF8ihAbVpg7KfV6LeIrMvXwuOVwpeIrDcHve43xXiSCTM9Cg?=
 =?us-ascii?Q?j5xHdhdBQdxD+UAXXJ5wcuZMXV8M5JErgfoBzuR5DEVmCUi4U2e13Jnuu5hQ?=
 =?us-ascii?Q?ovTdGd0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4730.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RXqAz6lv89oqOed+kPoh3D8pNvOhQTF49iKZ3nQhMW5pT+5fbMbzsVaAF6TY?=
 =?us-ascii?Q?+29aHJiZ5haDZbuiKWatna7bgrsFDpVbhk+lL3Lu53YFIO65t1dtZn5ySEQr?=
 =?us-ascii?Q?1En1Io/DrheQrFmQl4W5JUTWTm3hJNxKxYPnI/3mSFtRMD1VU8QIGbL47My9?=
 =?us-ascii?Q?L46Fz6DRcPr0KeaKaBz5WuppuXJLeV0fH2opEeoppW+7FYJ3EiroqhVmXZyo?=
 =?us-ascii?Q?wWufItHumgMBL0OJRWnWkM/kEmtDzc8UfWrl9JFNhJbiObhUcCbbUKWDkILV?=
 =?us-ascii?Q?xxmieMM3wjZ9Hjuh/+an8TepADpAdLxdXBsNiGyyeDDJm7UJSzGXH0BRybdE?=
 =?us-ascii?Q?igSGR9luGLZvCeqfaPAn6TVbC5H2JYXSDbgyde11UuFXGg33d3VD5u+uIiwt?=
 =?us-ascii?Q?XYUAaNk93oeQZQDhTljDEdZ6MdWa59Tcnq0SX6DeN8CvtT+VemeHzl5b2kZZ?=
 =?us-ascii?Q?5gof6+huHvo654774SrsjjhT6ol7Z5oJgGgotAN6gpwPN4hSFxtLXVwhFbLq?=
 =?us-ascii?Q?Tm5+EiR0c6MKCMKjGwJtg5vwRZJXcjkHfQ2AFmOrq9EfyVloDKxz+6P1hhuk?=
 =?us-ascii?Q?RmXq2FcRypYKrSmtofxSz7lbhubRYu0tASYNkojJbuGUciYresvXksW9hn5Y?=
 =?us-ascii?Q?6FWgFGR9LrEzZkdFOEcrGWqVy7I3x/64mxCzX3/4OqRHrc9yD+siVHGqj7Hs?=
 =?us-ascii?Q?tsjolM8A4ClQjxM309X/BahDdwW7nmgeOI8vTQUr27VlboK456ZMylcSPBrI?=
 =?us-ascii?Q?Rk/EjBe+u01qV0GeQIKQMQbB+Q3zhZ6kXBsI4qYPFiXJOlxR/vcBtGHn5pn5?=
 =?us-ascii?Q?4NXt0TIzziSSrzyvA36JL5XPzuLTmjDYI3PaRnRrOLucJhFWVVkloTj2j97m?=
 =?us-ascii?Q?N/aF4X0WkIYpep3Qbb6NQZ0IM60jyU+JqlGSBULBL+7+VtqY0MEYGsO+iheG?=
 =?us-ascii?Q?lhCDXU7dW19wtIMjNQna2rckZb7XJ41OIuQnxhwEdmOUmlmrZq99ajQ89uAK?=
 =?us-ascii?Q?UKClbZt4lOFtO0q+vdBO6I+A94N3de0Wfi0Os7zjUmMK2If4fgxIJ8B4rdTg?=
 =?us-ascii?Q?IthV8eahsfUF1Ye7sexz7fXW4rTv8R9mCdtsMAJUHtIQmuaEltsG8YDStak5?=
 =?us-ascii?Q?jGmi8voRsZDoTq6THVEhocp2AwomPvyPxqN3nmMckaPgG2xJ5u+ZDNpBC0oP?=
 =?us-ascii?Q?+85uSyXAnP8C+hdpHI3hXArL3AyqeNTlvsyS1nvgRTxl/k6srJJZ4jkDbxcV?=
 =?us-ascii?Q?PLKblIHE/5VCyZHIelGfCxnzn0ZDmiOT6LmfAR6ICDMYOFmT5Hvc1yZsBVYd?=
 =?us-ascii?Q?9Qv1NeTWl7n8+qphpOmwA6tszcOKtkH/t4E43HgfCFdYcR1hpZNsiRc9T4W+?=
 =?us-ascii?Q?lNfAYSQD2lRxgytvK2dY3Iu6gYL+yUI+ipUm0+dZp874qMbE4V6sdWlBFBe5?=
 =?us-ascii?Q?Dj3TcJwNlJRTimbyIou9dcIcspgmFmtumEKsGUF4LNv8FXFgiT8gqfdSACjV?=
 =?us-ascii?Q?iSxNG8LmQN0WsSJ3MQBknMcb2o65jUczhxWJKhH1AQyX2CC2haDBz5vodY/l?=
 =?us-ascii?Q?TxtNlxwDV7wjUvs1rUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4730.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b930bcdc-c806-4253-67b7-08dcee7fdb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 07:46:48.4051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: is5x7dUwi4KSG8/KYEVnyEYlEkp8le3c4CKv8Qvga/HsHeeDst21Fhndp1Vz6zWBRYKUBxICTc7p9KbsPIVw0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9005


>> >It should still need to place the two bytes of that 16 bit value in the=
 correct order to send to hardware.  That may be handled via a 32 bit word =
length on SPI though.
>>
>>
>> This is the most confusing part.  During the request preparation, we foc=
us on the bit order not the byte order. We need to bring the 16 bit value i=
n the correct bit order, to the correct bit position in the 32 bit request.=
 This is automatically guarantied using FIELD_PREP. FIELD_PREP shifts the d=
ata 15-0 to request 18-3. We shall never manually change the byte order of =
the 16 bit value. The byte order (of the whole request) becomes important w=
hen we send it over spi, which will be explained later.
>>
>>
>> >> In the SMI240, the register address is 8 bit and each register is 16 =
bit. We do not have any register value, which is bigger than 16 bit and nee=
d to be stored in multiple registers.  Therefore the device does not need e=
ndian. Neither big endian nor Little Endian.  To access the register, it is=
 important to prepare the request frame according to the specification.
>> >>
>> >> A request is 32 bit
>> >>
>> >> 	ID	ADR	W	CAP	*	WDATA	CRC
>> >> 	31-30	29-22	21	20	19	18-3		2-0
>> >>
>> >> ID: device id (if more than 1 device)
>> >> ADR: reg address
>> >> W: write/read
>> >> CAP: capture mode on/off
>> >> *: reserved
>> >> WDATA : reg value bit 15-0
>> >> CRC: check sum
>> >>
>> >> To prepare the request properly, the bit order is here critical. We n=
eed to put each part in its bit position. The request is created as a local=
 u32, with help of FIELD_PREP, we put the value of each part to its bit pos=
ition. FIELD_PREP will take care of the cpu endian and always put the value=
 to the correct bit position. Before we send the request via SPI, a cpu end=
ian to big endian conversion is required.
>> >
>> >So there are two possibilities here.  Either the byte order is just rev=
ersed for the device in which case fine as you describe or perhaps the SPI =
transfers should be using a 32 bit word?  You'd do that by overriding the b=
its_per_word in the individual SPI transfers.
>> >
>> >
>> >> Since the spi bus transfers data using big endian. When we get the re=
sponse from spi, the response is big endian and need to be converted in cpu=
 endian.  Any other manually endian conversion is not required.
>> >
>> >The SPI bus itself has no real concept of endian as such. It just sends=
 bits in the order it is fed them.  The device may require a particular ord=
ering of course if we assume it makes sense to break the transfers up into =
byte size chnunks.
>>
>>
>> Yes, the device expect that the 32 bit request will be sent from MSBit t=
o LSBit. Which means the ID shall be sent firstly, followed by ADR, W, CAP,=
 *, WDATA, CRC.  If we consider the 32 bit as 4 bytes , then the MSB need t=
o sent firstly, and followed by the LSBs. From this perspective we can say =
that the SMI240 SPI protocol requires big endian. On the host side the requ=
est is a local u32 (4 bytes). To make sure that the MSB will be sent firstl=
y we need to convert the request to big endian before sending it over spi.
>
>Understood.  Try a 32 bit word size for the spi transfers. I think that sh=
ould make everything work without any need to make it big endian.
>
We tried to use 32 bit word size for the spi transfers. Nevertheless not al=
l the spi libraries supports 32 bit word. A number of spi library just supp=
ort 8bit. Therefore we will firstly provide a 8bit spi transfer in next ver=
sion.=20

Best Regards
Jianping Shen

