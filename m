Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740564481C8
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhKHOcA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 09:32:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28656 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240490AbhKHOb6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 09:31:58 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A89IS6p019662;
        Mon, 8 Nov 2021 09:29:14 -0500
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c7156serm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 09:29:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7Z9V4yK00I3/1j8vTlwstbFDYdolZWzVp+n0jWv4VFpo/gWVcCeB/q/1/jzseCtu9nMozktabbVHwXMO+do0t1FTrU6qLa4JGFtZZpdoF1qRMw9MYNnj6tL/X3utYcMW5blwUez4TrKoQHdbXePNsDhLDcaH5MdIlvtNnBrfGkMFZJjA2dFhRL/rCSBz/tVVUSMJz6KmSddvNKLTpRXoN0My2MqclyH6a0gUs3JlkbBymZh1/k0EdwLTPEoxU2zESMeI/Sn/NS77ImxUMImwuA5uAAMN4w5CBzxS9+C8gVVUPAExUDzzJso2BdcZBcgl1nevMcaKdKc0bni1muYxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9L8/lIvuLm6HBZO3qr8N7fWsq5WqdWrpbPMr6i3Xqk=;
 b=E9kAZaEoduzes+yrq4GRQpY7Xx4IlGYvHdDTM0hINkyu6oPif1tv8pKiYM/emxBhnjmLuaD7w6Iqww4pc5AI+Glz2nvbwU6+LkDW12Lg2TsEG4X6+vgUDHqE2urp/B9SJMo6tXd0gbFxPh4s+ctCIKRjA/sJbiYNfvWnhcwTW984nj74U01m3fs9CnFHvbvEAQPm92E8XVndxXyOsg4FQHWV9sRyebTsJdzVFi2rdItlXBRVE18cvrXoH2lXvuSWvkDh/3Jj/yH/MP8iyLk6Mh3+VWROKfYlS1upGs6NS0uwPw+rLB14+RmLYf46Sjg3hmf3uqXOHu1r8wo7aBqxnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9L8/lIvuLm6HBZO3qr8N7fWsq5WqdWrpbPMr6i3Xqk=;
 b=nPlamucybFGmUaC2DRais+INUumowvrMGy9cvIwNX64y0CWxWS+//j0rPS59cJIipGk6y0om8tM8xgAGyozqzi1c0FhOp32K6WB4iglYtP5pJJEf2H4FeVvLWnVJvGhNp/KjPU2HxGi8R0asURzBeOu+s7kulfXGipUm606LzMI=
Received: from BYAPR03MB4647.namprd03.prod.outlook.com (2603:10b6:a03:12e::16)
 by SJ0PR03MB6256.namprd03.prod.outlook.com (2603:10b6:a03:303::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 14:29:10 +0000
Received: from BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f81f:4ef7:1c77:aed4]) by BYAPR03MB4647.namprd03.prod.outlook.com
 ([fe80::f81f:4ef7:1c77:aed4%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:29:10 +0000
From:   "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     "jic23@kernel.org" <jic23@kernel.org>
Subject: IIO interrupt mask access
Thread-Topic: IIO interrupt mask access
Thread-Index: AdfUrMxt4cno/gvSRMageMvNb4Tpjw==
Date:   Mon, 8 Nov 2021 14:29:10 +0000
Message-ID: <BYAPR03MB4647767659DA0E143F9C919A97919@BYAPR03MB4647.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcY2hlZ2JlbGlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xODIwN2JmMC00MGEwLTExZWMtYjZkZC00MTU2NDUwMDAwMzBcYW1lLXRlc3RcMTgyMDdiZjEtNDBhMC0xMWVjLWI2ZGQtNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSI3NDMiIHQ9IjEzMjgwODU1MjkxODE1MDMzMyIgaD0idERCWEZMM0p0WGw3bm1VOEtjaG1iNElIcUlRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c2706b9-8008-4869-9601-08d9a2c42112
x-ms-traffictypediagnostic: SJ0PR03MB6256:
x-microsoft-antispam-prvs: <SJ0PR03MB6256680E966FF9B755981A4597919@SJ0PR03MB6256.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GiJAsMQo4jGAsg4zw0G8/TR0yL5w7LDPZvAnD4Z2h8LvdNEYLF3T42m5J+UBB4wQcZJT7HwFkFPv04famr+XNkhmA1HPe2ESdNeqVslTXKC8SVHTyFfBMg7bWv15MFih4y31P2PQfF/hzb9mL3A2hpf2gX41pXuRVzSm9eHkZATUD4FdsCHNVce5B9mkkZ+qIvlZeNFZCf7gg59UKsfRUuG4V/0Il4DiTuOsSsyIawoc5XzGpmLawGjAWkJ9mxmhgADXQCri6U/WfB3X4vcZjT9utzo7omzVSbV27onXnPSvWxo1ZBt5nRvUwk9pJj3c3xxHq3Qygcw94VGKJL4KkJPIY8+1Y0iMRYQHRIs+uXj3khKbl2ddUYg6bsPZ8NIZA92uZIXB1Xj5x7tPQ8Nsn3Mj+i/eBCPhg2LG5bM/uy4eAn25/FNMkxJJf3iPTNpls9R7yvkMaq8CjA36HLuKJeOLX7RKGL66lyLceWN5PP0Q0BA+y3CpN6xgznu1E9cPV+0ZBWvIw5hDASuE66Ku9ooNnsdHyHSmxzxid7h80veDzBTazbdnmQGJjVjc7+3CTXzi2lhQQtjq3GNmBuiGJeQnxeNvUNe15bvnb8PyUHMjq0FuP0QqiWjLG8cjrvbI4iSMx74zID0BTz2EITPDk/AKru2h9FBOo5vMpz6SXnrehTdGgqEmJiLfuoLUfmbDrsoA2F3eg2UXnc5LjtPZWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4647.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(6916009)(8936002)(3480700007)(186003)(316002)(76116006)(66946007)(52536014)(33656002)(26005)(64756008)(66556008)(66476007)(66446008)(4744005)(9686003)(38070700005)(5660300002)(71200400001)(8676002)(86362001)(508600001)(4326008)(2906002)(38100700002)(7696005)(122000001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyUIGbDwF7qiET5m/MjJpaKtbww+qDEfuZBLsIeZapXzEg4s3LRnejE697nX?=
 =?us-ascii?Q?n4NjwwPwvamAJcNT5NrBZwXPzbCcoRitF/HPb2hEUQRqkJzX+yfIiDYQLCzP?=
 =?us-ascii?Q?ct7drabpgFl0QmCvN2wE8P/yrzlMn1Yecpv2FpEt2HVcKztVOfasYGELuNLX?=
 =?us-ascii?Q?sjHR7ivDPso0IsPVCp58U9JlMCLl4FdNPqK5yoHWrXJrrAQgnsFJhIdQdkHO?=
 =?us-ascii?Q?qTA4+0zCjGj3O9xW7j3gHlWvuKg/f8OoAGaL0xHbxVzBtdAZw2CVWGf3cJE2?=
 =?us-ascii?Q?8v5rt4B3Gv6S0JsnXATiaQIPUB4kNjq6/N0krsnPw3p9zMVZ/fxGghBUtcRC?=
 =?us-ascii?Q?gYm2HxRa+BCUTVhVKc8tY3W1pqWaT4lFX7zR2T93yJsLmWubxK+CTgS6zFgh?=
 =?us-ascii?Q?NZC/bGZtZ2sql6OJiM5sQxYTPAEJJpJ6BIhfI2owHwGgA/rS3rnh3LsPxNT5?=
 =?us-ascii?Q?Z/xCV6PDerB/J29GnoL61m0cZoQ5TR6FDNu9gVOTHWYkpWNNzD4hi1ZXUHmN?=
 =?us-ascii?Q?UzweuKPERtjxBYyBlTqNsiGvr9pS6Z6FpUpG7+uyCY/Wyzu0/MrUVel2YJpq?=
 =?us-ascii?Q?Rgtkm5VpLGGuFxCZpeABpNThyDys/uk58PGp1C3kBySgOhQrucW5fOadkRDi?=
 =?us-ascii?Q?hCLsOjUA6Nur4/07mfik/HZRf2rVeVsOncNMI8pT5mMXuh1gJYi52RVoc85p?=
 =?us-ascii?Q?z7uKDnzhm8Il3IperwKrE+NI7PjvhwnPEaMHDvG0CCiUM8FtCZerTQYVchS9?=
 =?us-ascii?Q?YFuyDlPOlkwA/pH4FAKZnK6G94qoonvFA+Q8RKWyuiSizr0o6ysFI1af73AF?=
 =?us-ascii?Q?/oKuHcZRcCMHoUB8QnDuOYVwyAuoUfUeGfY4jPcnVBPlcL0ZpqHq2GPYC4bS?=
 =?us-ascii?Q?cfxWPT2Pz+ROKPWEzAih5fJ8+UWpB3/CipYLXdNQAruWkQQa+V9dZVUiIUzz?=
 =?us-ascii?Q?Gje5dcDLYCpRj6l+nEGSLRxZjK1QK3tJ0DLxo4QAk5tyC8V26MJ4RzyGYv0/?=
 =?us-ascii?Q?P753dZoSL8nWsK0+zz+UU+4fslNGjndPoP0xPMD6rb6CBasKuOMUDMUDZ+dj?=
 =?us-ascii?Q?ll0Ci1ehZil1q1BXOcJvEl81XA2pgiYU3Fhr7h5PtxVw6ONcENaXIS939fjc?=
 =?us-ascii?Q?HuSI3S+QUVUBETEjbdzhlZFwL3/SZ59/nzdNFCNA0tv4c+JEaA1iEjHyj0OB?=
 =?us-ascii?Q?uQqeZrel5Q9hErZOlHicqocShAMfOU6EHeFLxU45pZcGauuxf1SZb13eyPGD?=
 =?us-ascii?Q?Ls+qh3gCr5qTCwUdRBoJVwrGAkn0rqle5RKHt7uUXfEmsYeQoE1TLH+hQLPS?=
 =?us-ascii?Q?FsoPrb1yAX2sD4SQngkgifj3dPwsfHzJD6lIMaInBWIwOo1N9CwSGt84eFb0?=
 =?us-ascii?Q?RF5UNuaG2DeHrCBFTeMYTrql2ECYdLs05OvG+XThTHsKqcYGc8Kh85KYPdii?=
 =?us-ascii?Q?P7esBqqeZrUbJZw45hF9XOPW5ZBCAoYlhWdnUe3oXiTR5QvSUcUI6PnBnaqh?=
 =?us-ascii?Q?Soq4r9KAaKz18b6WAw5W0tYXfpeEsk1xHDIXzfm1SwPjdi+Uv0L8KX6ftjYj?=
 =?us-ascii?Q?uJDc/FjYy/flW310bfhSwNaH1xrYvv+FsPklIp749NOr94NeMUdlmslXy6kw?=
 =?us-ascii?Q?6VVYKViQCGKmgKKJpU3DLHbnvlpekhDz+Pigz4g/ldliPOLHNsAHd/OOGcvJ?=
 =?us-ascii?Q?JhBHjg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4647.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2706b9-8008-4869-9601-08d9a2c42112
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 14:29:10.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIdli3WXbC+Y3bj/GLBrVko2KWL3xZz/5yLrb1Eo0Hqdc72H+vTgLk2O0DArOXQ0IcaulDsOXbQTbEbGrfsVjmnRjq40F3KXH+c3pZnejQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6256
X-Proofpoint-GUID: OyHx4iZBjv-eJI2x3sDE3fEmX2WKj-OT
X-Proofpoint-ORIG-GUID: OyHx4iZBjv-eJI2x3sDE3fEmX2WKj-OT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_05,2021-11-08_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=209 spamscore=1
 clxscore=1015 mlxscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080090
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I'm currently writing a driver for the ADE9078 (High Performance, Polyphase=
 Energy Metering IC) which has two interrupts with over 30 configurations m=
odes in two 32 bit registers. Some of these flags can also be active at the=
 same time within the same register for the same interrupt. While handling =
the interrupts is fairly straight forward, the challenge is to dynamical co=
nfigure them within the IIO framework.
I want to offer the user the possibility to enable/disable these interrupts=
 from within the IIO framework without having to create custom attributes s=
pecifically for interrupt configuration. Is there a recommended method to d=
o this?

Regards,=20
Ciprian Hegbeli

