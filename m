Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1B31F562
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBSHgh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 02:36:37 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27570 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhBSHgg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 02:36:36 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J7Zcdk011593;
        Fri, 19 Feb 2021 02:35:38 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 36pc9byu6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:35:38 -0500
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11J7ZcO5011588;
        Fri, 19 Feb 2021 02:35:38 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2055.outbound.protection.outlook.com [104.47.44.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 36pc9byu67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:35:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMEThY17Et0sMdk2HfQhuQEEOolP8PTJ2p9kg1uesVpds6pF1Y7sy6oqMsllOHBw7qRPOR+AfVoC8pFUJoDolt/m/J7PDJ3Vz/CB+X35soQbDjNhGuIL1D8GxkJH7xzl7yShVkui+wuvUAuzt6vDwo3S1s8b/XHhOhU1v1vuJjYfoPxCjdOiAk3AQn1M8ro32bGnVobO9OA/9o6ZUk+bLyI7SJB0rvzH2Of7AE7nohwY+G4UJGvjs/bDhkzqe95D6Q1rWN2A7JDfeVYq45XXoKzR/dqt4Bv4/EwufRcL9OPUZ2xQuMw8yDBVbuxQgQwvSLAViNea910/bAhw5BzeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7g1Hhj+baXRXay/Is5QliRmYwGK4axMHq5WoQr7xbc=;
 b=f20DidSVG+teOZOJdzZ39IX4Y5t71B7pTppTKadMdv0eaLYWhpYKAImjTgXtiFhyLG2FziIJ585uf65DvKcQ2mX4UnOIMya1FF4tpBFEXW/yHZnM7nesVPc4rau5V1KbUTKjQR8PjGoyvxpplc9/KLqs7lf5PdXkNX9QL63Wbrcpi9GMb1UIeDY+Fcbv/BIiC0Ta3EC7JSadf/+qeNcbLNlxEcetADqVs2k2lX0CaYNr4UAJOP4htzZgokZwrgJ2uuD9KYOkKafx9ihHEoQs8dXNUCnp/+kVUDZZdiSXavmxMx0OcdaMa+T2n82nbLr1dAVFw4N8WvXSU8pFr9Jxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7g1Hhj+baXRXay/Is5QliRmYwGK4axMHq5WoQr7xbc=;
 b=pRky5IDVOR9tg6ZgfQ/p1SuP55Gg9FMe9kEV9axN1cyYTa4vOTXZKdT/EWB8E4Tpbe3RQ96YjGN6VvR4OooT7gjw1o2/2Ut5J48ZNkvOdGdvXImrscGfn5SJUYOzBWCBMFCXaZYl9aE2iS2Vooc1DyQqKDdCG/X2hB+z5C7dgMU=
Received: from MN2PR03MB5199.namprd03.prod.outlook.com (2603:10b6:208:1e9::11)
 by MN2PR03MB4718.namprd03.prod.outlook.com (2603:10b6:208:109::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 07:35:36 +0000
Received: from MN2PR03MB5199.namprd03.prod.outlook.com
 ([fe80::659b:24e5:28f5:8e7b]) by MN2PR03MB5199.namprd03.prod.outlook.com
 ([fe80::659b:24e5:28f5:8e7b%6]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 07:35:36 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     kernel test robot <lkp@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: RE: [iio:testing 44/53] ./usr/include/linux/iio/buffer.h:16:2: error:
 unknown type name '__u32'
Thread-Topic: [iio:testing 44/53] ./usr/include/linux/iio/buffer.h:16:2:
 error: unknown type name '__u32'
Thread-Index: AQHXBUH5LJy5FeOLekONEADrwzLPDqpfGPwg
Date:   Fri, 19 Feb 2021 07:35:36 +0000
Message-ID: <MN2PR03MB51995BFEE1DA0E625D33D40BF9849@MN2PR03MB5199.namprd03.prod.outlook.com>
References: <202102172355.IQoU3jH8-lkp@intel.com>
In-Reply-To: <202102172355.IQoU3jH8-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWFyZGVsZWFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0wY2U2ODg0Yi03Mjg1LTExZWItYTYwYi00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcMGNlNjg4NGQtNzI4NS0xMWViLWE2MGItNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzNjU2IiB0PSIxMzI1ODE5MzczNDc4?=
 =?us-ascii?Q?MTI0MTMiIGg9IlBjbjNHUXhFOFdraFBHU2gzZkd0Ui9WSmVjTT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUlZREFB?=
 =?us-ascii?Q?QTkzRC9Qa1FiWEFadlR0OTRxOU1ueG05TzMzaXIweWZFRkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBeDRaa2FRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJ?=
 =?us-ascii?Q?QWFRQmhBRjhBWkFCcEFHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJs?=
 =?us-ascii?Q?QUhJQU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tB?=
 =?us-ascii?Q?WXdCMEFHa0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bafa57a4-e61f-4b49-93fb-08d8d4a8f2ad
x-ms-traffictypediagnostic: MN2PR03MB4718:
x-microsoft-antispam-prvs: <MN2PR03MB4718A34050B894170D08EA84F9849@MN2PR03MB4718.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:234;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOqdJCOxzaBhXTSZxjqxw1sjuMUocZ+zKKExK7ltBS42C60F1XnCfkgWOnyjI5jUgTCFpK+LSR7fUXFzUTk6z6t6CV+x3+vM/DTBM3L+2KAKUTNCRAzZOTwZemJrqoo7oeRKGtfZ/xexuYIx5Fh4jIjlrcRPPQ27nRHWspqw5YvHz7IFuLykIR4iwNnSiDZjQ/4V2OytCyXv/wC1kfpCShM0BPvRWzhV7udhwyCvcmMeaLuQIAl9WJuZIlkVSM37o3x5KgpYTNlc3R/7IeqvNd/IyaeqfwEJEf9YZ8VRR7Aq7SmBoiAHwLcb7X35Qui6L6A6Ex6qqr6YeEPRauDSZOANJholO6BDzKgrFuRnpQ+Ft6D3bAJy/5z4t0qYtShV6HkjMPvk889xs7AnNUHEeW8ErzxJ6PTZ2mnw37AtlVdTegd3Ycud3EQYqkq1Kngybd/5m+ZWJWQPdqP33/nC3EWpJHWUX8jrVKOWWEM04yhTk9N6j2zQWSW/PhZlQPZOIkTS43fmGMwzuxei0nBOE0cdaANLuCLzZJT5Oyf+zscQkmkz77LLOzPFXPx6ME3XYRPRsJP3r3HSJ6odeISzEvJ02wstoA7AdI5E/H8Txts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5199.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(53546011)(5660300002)(2906002)(186003)(66556008)(52536014)(71200400001)(83380400001)(4326008)(316002)(86362001)(478600001)(7696005)(8936002)(6506007)(33656002)(110136005)(26005)(9686003)(64756008)(66946007)(66476007)(55016002)(54906003)(966005)(8676002)(76116006)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RZr1tynhCDx+GI0LSNjuj1XqjxXJcbP3QJ01O9AFS/BPyd8QXgNIMoah/o37?=
 =?us-ascii?Q?UmZP+7hlOrKNxDc4AS7tSzywL4kbyONwrZxYdWVDlVdg+ome0RIwtatiWI2+?=
 =?us-ascii?Q?/ADFPGLQIiPttt+bbiJl4OJ94lswBqm0Aw27/FnciY6iJ14ekgyFJUf/3Qth?=
 =?us-ascii?Q?ojiTs3JmXsW1LwMP85xwpx8hklFljyzueAU6G8jOAZfW9BNFjaCj26A6IuwL?=
 =?us-ascii?Q?UxhNkybnZaJcFMzG94lJsVobLfKSxwcwn1+VjPfL+eALI06cMw6uqnDNW1dx?=
 =?us-ascii?Q?YfRwXjZlEw0BddpYJoDs6Qg//TiBydd3dwHpyV9NsZFNZnoaGrsaJerle+zN?=
 =?us-ascii?Q?bpPVwDGu5KI3CNbDzdJp9XvKRlTj+UpC3haUhj9NFXq6AleE0CwOZ/hb1Ivf?=
 =?us-ascii?Q?8Tkjfi1YV+Bo41Q7Yeta0gBdwyPPHo8ECLaPCd/25ZyeKmKcQoN0nUreOSPr?=
 =?us-ascii?Q?p51iGj2yF9Q8jDOKd3YqYYGzsZVyWz2i6kpC+2W2+fu0rT+FAsHHwG3OgmQb?=
 =?us-ascii?Q?nhvZ9HiU11kc27grFp8KA8wysbpjrqsVLQO0lnboog3tS9SCZYFudY2+revE?=
 =?us-ascii?Q?snqOcIIdyygg8k+LWy8wjltEqCf/FEAjCZhtqQe4nlYjq3WW6hH17M8zAZzF?=
 =?us-ascii?Q?Ak9jV3wAuZHf8FVUDeCW75ws0y8kHcDEnjXZgO1W+Fb+6m5i3Ph+4ATItiCx?=
 =?us-ascii?Q?YW4VifxI1xWq7bLXDdZfL1BDRiEp4pSr1p+fr1oYVGQqMeqtvKxdNeGkYSnt?=
 =?us-ascii?Q?hzO5TSd3oCLcpecVuqVj4MIkwsLWC3knZ6gd044LQ2bhH6H+wSG3DCEHW5AQ?=
 =?us-ascii?Q?30uefMERzpz83f/NdwIR2mYW8OqdYxdmSchBCfVqeml2Y4hDnsyCj33g+TrX?=
 =?us-ascii?Q?gVFQPgp0ny/ts1oVliwOLaVdxbtY9piXI3s1vXYNronpV4N4NKTZCdtNxq3i?=
 =?us-ascii?Q?i9QY0xZoo/0UJmkQrOa41AC4+QSDWIJZBuNrWeTToKecwpZaDWWRlX2zAhUB?=
 =?us-ascii?Q?GYHfoaGabB/q5k2Qs3rXqPMIF2EGorkdXVOUWy9AIMiepcL5nvkrBc9YVauP?=
 =?us-ascii?Q?dGldb4x9lS2HK7qcEqEgyz1D5LizFvVTfeIH8Gl/LkumijKc3ZqarpBewEC2?=
 =?us-ascii?Q?WiBvye+/dvBgjV+e9a6KtrgxmITIkn/ZoormOVeItQX0+vaHb9SeGRB4XGtF?=
 =?us-ascii?Q?1uJC/zPxOmThGUSLhqcqeZP2/LrLSC3c1PEoqDPKretWa7E1CQtTL8ANQUz4?=
 =?us-ascii?Q?l89IecCZWK7UK/ThcyfHxa1p0QjlPoOGp+5MsPfufS9i/mbnJk8Lv11Q90Ir?=
 =?us-ascii?Q?xTho0IOQIMCOHmC8e3zcZtSy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafa57a4-e61f-4b49-93fb-08d8d4a8f2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 07:35:36.2557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csaVWBHm8HEkYZP8BxfzHYStd+yIUGp8oLOb9Rdf1ulg2PGmt9YcpR9SIR4I5Ee1KnJ4lP75fgMw5xXdz1A15tAsG9YyDEriVNh8hWZ6W4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_02:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102190055
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, February 17, 2021 5:31 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: kbuild-all@lists.01.org; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: [iio:testing 44/53] ./usr/include/linux/iio/buffer.h:16:2: error=
: unknown
> type name '__u32'
>=20
> [External]
>=20

I already fixed this before the lkp bot.

> tree:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g=
it/jic
> 23/iio.git__;!!A3Ni8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7KOLcO
> J5ELyL-IHFus7OaIGGn4pRWiSFk665kw$  testing
> head:   0fd146b288591a8139220fec417dfc5652820480
> commit: 861a03649026b4c4ace807af241ba719976b90e4 [44/53] iio: core: Add
> mmap interface infrastructure
> config: x86_64-randconfig-c002-20210216 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=3D1 build):
>         #
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g=
it/jic
> 23/iio.git/commit/?id=3D861a03649026b4c4ace807af241ba719976b90e4__;!!A3N
> i8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7KOLcOJ5ELyL-
> IHFus7OaIGGn4pRWiS371BwdQ$
>         git remote add iio
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g=
it/jic
> 23/iio.git__;!!A3Ni8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7KOLcO
> J5ELyL-IHFus7OaIGGn4pRWiSFk665kw$
>         git fetch --no-tags iio testing
>         git checkout 861a03649026b4c4ace807af241ba719976b90e4
>         # save the attached .config to linux build tree
>         make W=3D1 ARCH=3Dx86_64
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from <command-line>:32:
> >> ./usr/include/linux/iio/buffer.h:16:2: error: unknown type name '__u32=
'
>       16 |  __u32 type;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:17:2: error: unknown type name '__u32=
'
>       17 |  __u32 size;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:18:2: error: unknown type name '__u32=
'
>       18 |  __u32 count;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:19:2: error: unknown type name '__u32=
'
>       19 |  __u32 id;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:36:2: error: unknown type name '__u32=
'
>       36 |  __u32 id;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:37:2: error: unknown type name '__u32=
'
>       37 |  __u32 size;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:38:2: error: unknown type name '__u32=
'
>       38 |  __u32 bytes_used;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:39:2: error: unknown type name '__u32=
'
>       39 |  __u32 type;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:40:2: error: unknown type name '__u32=
'
>       40 |  __u32 flags;
>          |  ^~~~~
>    ./usr/include/linux/iio/buffer.h:42:3: error: unknown type name '__u32=
'
>       42 |   __u32 offset;
>          |   ^~~~~
> >> ./usr/include/linux/iio/buffer.h:44:2: error: unknown type name '__u64=
'
>       44 |  __u64 timestamp;
>          |  ^~~~~
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://urldefense.com/v3/__https://lists.01.org/hyperkitty/list/kbuild-
> all@lists.01.org__;!!A3Ni8CS0y2Y!pWBrksmMpFBwc7SW9x0b7o7PB9Ca8mTm7
> KOLcOJ5ELyL-IHFus7OaIGGn4pRWiQdYNMyhA$
