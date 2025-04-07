Return-Path: <linux-iio+bounces-17761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8550A7DF94
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CCD7A52CF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 13:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359618C03A;
	Mon,  7 Apr 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epita.fr header.i=@epita.fr header.b="OcFuUPQX"
X-Original-To: linux-iio@vger.kernel.org
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020143.outbound.protection.outlook.com [52.101.167.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD6A18C02E
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033090; cv=fail; b=eyfrECMCqrBqFYZJIWbxm7d4NgIiyaTLWGNNvmZ09izJ7/HWu9HX3cMntEMTRgDKGEBfpdd1+OxUnFqOw8qf0kwrk30W93pQR6oRRnAm5PEztMrjjSf2FnSrSZNcOG/SfjJzKRLldi1sf+VIOX+k2Al7oGLXpkiWg6SkvZPlQq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033090; c=relaxed/simple;
	bh=UiOCsmf6iOZTEqNuMDvtGwNjUjWm5KnkU645KSMckXI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=upixi5aab7oCPDh03sT2ZEZNRGWr6+OLuuzMxc0hMQy+TDNGfWhyIj6qpbmDzy0aISYhIetvWYI40xTAh+ex1yAk0dn9+qGkkuBKVm9gz3mOIuzyEvCTwKJk6vqpaGasXdykqkidyXaX0U82KAeR+U5LRv9BrXIIsALkH0ma6dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epita.fr; spf=pass smtp.mailfrom=epita.fr; dkim=pass (2048-bit key) header.d=epita.fr header.i=@epita.fr header.b=OcFuUPQX; arc=fail smtp.client-ip=52.101.167.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epita.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epita.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3mMl//8hEWU2ueaTUEMAZBbQMM45tmawRV13yWW6Wmfo21mFOYg6Eko0ukMVfI6VUcKcR/vjCdNhB7CDzlJpvusc9R0wr18pXbZamRZ8dxcuqScG/HsaADgcoQsgxQ+6fMfYOpse/syMul/y2Yl/uLnOyPBgY374KIOilcMQI/YYvDN99ahDvD/H3WMB7WAwyeXd7XMqpObmaFaYpHkwU1G3NXbxGKYkWR4/ijF2p0JqnpiKkMIL/YRMv9+WZXPh9Rbiw4tyNu9Itp9+MtAob5WlZsT0eWk0efnt8YgYKd4TbL6OORHfCp0hCZMMTu1ddGSGdPUBnrLxFOOzpgruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiOCsmf6iOZTEqNuMDvtGwNjUjWm5KnkU645KSMckXI=;
 b=ahnSjP8WOuW+2tpOo/F2tJoaSp2mx1AVkXAGcrpEqFFK+ISjJAowj+cjXxL5V/ZoAo1MFA37ZXI1oSzSaQ0rrO57uwXjJJpp3NAyOWNjVE05vKzKHw2sPVjeiDGSegAOSquEF05rxjzqidkSfn9Qmm0lSwh0YO0nLNfxAck4Gtb2KdbbzrJnTJWNcOMt7KZ53pPK14453xO356yxMSqokNcbqSGskXEKGePs+WaYNBYFLYJpv5HXkQVYbQ0imyXLH/q8y0+JA0R9GVFEoPmC3uywlZP91tRtIDBC3jZgD0sG6+M0gAtgTK2Ru/zCdZzbftdmWjw0Jum95LlkRPwa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epita.fr; dmarc=pass action=none header.from=epita.fr;
 dkim=pass header.d=epita.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epita.fr; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiOCsmf6iOZTEqNuMDvtGwNjUjWm5KnkU645KSMckXI=;
 b=OcFuUPQXNxx/QlfEWUxCxgqHeMaIgJrUFnuMRp66aeSGsyBQdJy2kEI2nIbh/7aK+ssYkMNOWfZxJnbwp1ceIRNc9j0NkBtxWONfBbSWQ2kh5vF4Mav1dOBNXZ1INnRcQjuDQNiJkU2Tq8Y1v/WTLGnzTG9LYvTqdrSxMf/nGD8h7QVhhYZOEY7ACZttDjszY1SIYXYFsRQuSNLv9P02xz/+GX1I7psUUJ8x5xKA+yrNwSMxQ9inizXzSkNr+ErJV36YfgxfciOOb2U97LFCDq9tDQrLSekcXZzM6IvDkpBGPzIBZfPodIdFRuEyeAG4sDBDs5aYo/3JaeM2sTyCXg==
Received: from PR0P264MB0811.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:5::21) by
 PATP264MB5557.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fe::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Mon, 7 Apr 2025 13:38:05 +0000
Received: from PR0P264MB0811.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c3e:89ad:a15e:454c]) by PR0P264MB0811.FRAP264.PROD.OUTLOOK.COM
 ([fe80::5c3e:89ad:a15e:454c%3]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 13:38:05 +0000
From: Lyes Bourennani <lyes.bourennani@epita.fr>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: GSoC 2025 Proposal: IIO Driver for ADE9113 chips
Thread-Topic: GSoC 2025 Proposal: IIO Driver for ADE9113 chips
Thread-Index: AQHbp8Iq/D6d6ewirUqbSSv1FG5ZWg==
Date: Mon, 7 Apr 2025 13:38:04 +0000
Message-ID:
 <PR0P264MB08119CB8A7505C0B447ADFF08DAA2@PR0P264MB0811.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epita.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB0811:EE_|PATP264MB5557:EE_
x-ms-office365-filtering-correlation-id: e3d6a385-9072-4034-637f-08dd75d96cc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018|3613699012;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?nhbVFQHuBDld1C9cG8ZGqFKMl4iaX2jAdmxzY1HyqtdKEHTIhYVqY5vL?=
 =?Windows-1252?Q?8WLSbenopJ8xpZOSJqVExsRLQ7kCRQcgbF0c4KPh2IvOplJPrgUVI+kD?=
 =?Windows-1252?Q?NYnsUsBjkbK8fv4ZmD7E5q97K93cCnr1E2FV4f/Gwrrt4QUCm8wxjUAW?=
 =?Windows-1252?Q?WOwOlgxckMVBuU7xEwdjr7qD9tELr2KCE8bRwBRAy7zuiGYj7tTLTuA+?=
 =?Windows-1252?Q?osRn6AX+cPRJERXOrwOIb9nLaxPJlg5dQamXxEO2pCvKklBoLGweFs2Z?=
 =?Windows-1252?Q?ebFGngeUJkoQ9Knp2nhYh0yBuWFjiiw9O04KM1SN/xW+9MeDxrace8lx?=
 =?Windows-1252?Q?LGfC3Yl00FkXvOxUYO1rFXbW3enT9vTNb3iCDHVu/Tk0et8C0zrirLnj?=
 =?Windows-1252?Q?LZ9vh6Dl6TbisiHUkKBNlj6bAGal4mvx3MjrjpC7T9wFV8DYibicbMqZ?=
 =?Windows-1252?Q?qaNmXrhmLE66iFGVqVe8Z1fTkUOx0N/VQYkgRJmE5w/wi9mkfOTqxjLB?=
 =?Windows-1252?Q?+uLJnc9GiNVQGkPGghnBOFx7lucelF68e8vsUaNXKn9i2ng4ry5gxROc?=
 =?Windows-1252?Q?4SEAa4ad9oAHG6a68TsaDmDCJj+KUjp6k7tArx01sBUE6K0vbQF51bBV?=
 =?Windows-1252?Q?q4O1tHQjBcxHCwWqKKBxcPa/iILvpmoSRiMW1eBttBC+s1nYxX0VWnbd?=
 =?Windows-1252?Q?IzJFLfO0cBmWw/1NlbH7pWGq34O4++3D3l70YWI0ba5X1P8mnQ9tNG3v?=
 =?Windows-1252?Q?uonwp1m8Az+ePjeU6Zc+hL0/BZGJbMnhEZmGjCtqrVRdM5aikg70l2I+?=
 =?Windows-1252?Q?M7Prdxzbylc/oaXG0GGM0ujb42tmUORqp26gTrBXEWIMHNBdxfFP/Xe5?=
 =?Windows-1252?Q?n0eVxu6DhMdJS4ee1/lql+2wzn8ApkIppQ/mexlIx7uh4G7V0c99jwXF?=
 =?Windows-1252?Q?wsBmsx119DHHPyHpZppEnOMJIUMVlVzvYa8flqzWHLekXNMmwrayHRmY?=
 =?Windows-1252?Q?7C8lEpjKjZa8ceMisiJjAF6HDPNaxqOSzMIzUsuwQ8nUw+E9Ngu2k9wJ?=
 =?Windows-1252?Q?D4oYYK65UWpYmHZl9fBV3/QDNJ0oPRvbXH+XmQznZ9LBkCZazpcsrgai?=
 =?Windows-1252?Q?NK/5gobneFiECCqI5/XddXITNB3GnhUZmWxYOyJ/SnkA6o7rRoe/pioh?=
 =?Windows-1252?Q?+HIuSXqtUfrbQYPZi5F/C6KD2wzFOGBaXsqE4zRLweMyuf+jUU2o6DfR?=
 =?Windows-1252?Q?EfG6OwAlMkkN0EzRvEhMeSLThZH1BPc2HQLF3aY+4ahpDC27h+Vwkkka?=
 =?Windows-1252?Q?vpr7Ru4Z1+3ODMunmQ4OA78xd23BgeE1Zc997P1YuAzCBkzscqfw8iCF?=
 =?Windows-1252?Q?xZaaUnqD2xslDE239b6ambQYW2gdBDSB73nfMUeXaPtaUHfqKbf7TxI2?=
 =?Windows-1252?Q?dXGrcT+XspPmftqbPqhHA7sxNjKEehqdi3XqUCD4RWY1DqNWoAyZsV6c?=
 =?Windows-1252?Q?hNb4gChl3P/SlTINbMgiqQi8DHY7nA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB0811.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018)(3613699012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?KCRkTjvzPA7i/vhFJ2xqQKgFKceB/xeoYulw0iPWXraqk5AAh1A45Z6r?=
 =?Windows-1252?Q?e0gOct/awNtUZFYXMNO2z/f/74q5zhtT3d3bTkKqi6GVm2Xh9N72edOs?=
 =?Windows-1252?Q?44IMV++ugl+ABLkpBqJB3nIB9HTbthL9lRAsfxuII1GMVpWMEwwdF+SG?=
 =?Windows-1252?Q?Og2RlXEta/QdiIhDBMwkuuiZ3h4e7NAs//8VirH9BlI0OkUIs6y76Fk3?=
 =?Windows-1252?Q?6v+zo1NejXmDec5GgoKFbahjfV72JDJD0tVkN8oTLaX8VelGM/3sPTiY?=
 =?Windows-1252?Q?994Jlld3GQZrfg2fHSkom+e8kCEu3ejZYaOKWv/aH6iC5eHOr4CHAFdC?=
 =?Windows-1252?Q?ppjtJD6E9z6AHw0IONHuOfIN0pd/exVTbr4UD8/pUaXkAQU2k5PgVWLc?=
 =?Windows-1252?Q?nzLarAjsgDf3Fwq70aMFiHEGxU+iWu0EHPgdsVqIXII2i+//dLHDzx5O?=
 =?Windows-1252?Q?QdPwHN6kURSx6BB3ma8UBhh6fgSK/L9vYJBdnJHjBfZbkt6j84JeqGvI?=
 =?Windows-1252?Q?KDuvi7h+Fcdz9EB+ZKd4Q4ud3GCy5eoPsXpglNtJi3hhnV8dpawdGYiR?=
 =?Windows-1252?Q?36ulCZk2Rz8/FjvviQ+IB3wf/IjA2lElfApkC5zS45UbzVWgeDZgPpsY?=
 =?Windows-1252?Q?WX3EutWbkk1sCV0a+5jhWHMdMxoMIIDJZVus/KICqcrXfDyx3ZpZQQxK?=
 =?Windows-1252?Q?0exFXEougHheW93Rzl4U4jc/VJ+lbJpfwnXzle08+osAQD8uWA0ynAKA?=
 =?Windows-1252?Q?aNAQd7ewTwE2e3C6DqDqpV9tF0OOTEtk94rPIi9j3xkvgST2t23d1o2E?=
 =?Windows-1252?Q?KjlMNVowcS1YmwQ6BhflXvDdLK9IcPID/xh++zgvw9SSZqpUuXdWOmX6?=
 =?Windows-1252?Q?/OlAX2mDc2Pm1oyLMwmovJHahicARIRz6bFTJawCD9C8DfsYdbmcwsii?=
 =?Windows-1252?Q?TLStXlXnqmLRKbq1jZStLu/gdJiF6MtjsROmOiTgMUDfU+STxUEbj/k+?=
 =?Windows-1252?Q?/t4iW8L8BWjvXbMKD+MSeWd6OKJ19Vz7r3iColTVml8TCgX/94R79/dT?=
 =?Windows-1252?Q?z+zHzn7IsdEUR8OfSUFyMprUVygHb5PQvnYKLyHX6euGYzwp0KvpQ4Hp?=
 =?Windows-1252?Q?B5TYeJQPxyYOKw+XII5gYgTCBYBdXbANLEfl2qKgw53mXnW1kE+x2seS?=
 =?Windows-1252?Q?vc+kyqvREIEa9GtVtM0DtJr7gC8sdUvQwssmXdVFIDqNe/7p6lo+5751?=
 =?Windows-1252?Q?wGN8My6T9A8dbalJZNi9IRWSS9ai4AvDNItIJmW4hyNOeZhjZjyKgQry?=
 =?Windows-1252?Q?12Rx71nSNSDiZ1TCFr3jy6/VPbzNGqvNNPPp1mXyWkN0+uhL4u1+B9ob?=
 =?Windows-1252?Q?Es/e9BOlnp2pnKQo2L/h5RguA6UJ+9hF2VWs6PmoXnMWsQ0K8oH+hSFv?=
 =?Windows-1252?Q?U1t9Q3iaSeouaNxR01CjeAR3jSO+g61ci5eTSqNFk/bCAIRuKr6fXsQ+?=
 =?Windows-1252?Q?P/Aoth2pnyq9ir5/mqK4LlNkAzmzp7qzEEnv3xtgxVB53bt1B36YG6Ys?=
 =?Windows-1252?Q?mrlHWO5+h/NknnRL1BZXyJniS9/nS0DKDRHseQG/Jwhc514JJywbXYMb?=
 =?Windows-1252?Q?HMn8HoC/eZTlk2u/d6nz/W+qGYDUCaWy7lLKFKUaOK1LKmugXDIEkiU6?=
 =?Windows-1252?Q?SFYfB1ojXTNCNEk3RT2I1QHBIXIH2e4LHDHZ0F73nN46ho9Z1AAKo9RX?=
 =?Windows-1252?Q?bXvzemnCvQIv1W7Bi8rlJGRbtZZgLEEvX0aAPeuE?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: epita.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB0811.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d6a385-9072-4034-637f-08dd75d96cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 13:38:04.9570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3534b3d7-316c-4bc9-9ede-605c860f49d2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYg0RICANmhWYLlwWFGvQHocUcGkHlDLYtwYGfkA2/e38SpeV3eT7qGMbYwnBt6HCvusIyaNYt8ufmE7PsPEmq0dT/PfJ7ehPnBvg7DLxmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5557

Hi everyone,=0A=
=0A=
My name is Lyes Bourennani, and I=92m currently in the 4th year of a 5-year=
 Master=92s program in Systems, Networks, and Security at EPITA, France. I=
=92m very interested in working on the IIO driver for ADE9113 chips as part=
 of the GSoC 2025 program. I=92ve prepared a proposal and initially tried r=
eaching out to the listed mentors via email, but unfortunately haven=92t re=
ceived any responses. I now understand that mentors may not be expected to =
provide direct feedback on proposals.=0A=
That=92s why I=92m reaching out here via the mailing list, albeit a bit lat=
e, to connect with the IIO community. I take full responsibility for not un=
derstanding the process earlier. Still, I wanted to express my enthusiasm f=
or the project and make contact with the community. Even if I=92m not selec=
ted for GSoC, I remain eager to contribute and get involved.=0A=
=0A=
Here is my proposal :=0A=
https://drive.google.com/file/d/1f1nq32dWJD5P4sJAa3IQPHazrbCNnr94/view?usp=
=3Dsharing=0A=
=0A=
Looking forward to hearing from you.=0A=
=0A=
Sincerely,=0A=
Lyes BOURENNANI=

