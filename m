Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6E32E408
	for <lists+linux-iio@lfdr.de>; Fri,  5 Mar 2021 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCEI5e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Mar 2021 03:57:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:50224 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhCEI5Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Mar 2021 03:57:24 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1258tnAk026525;
        Fri, 5 Mar 2021 03:57:11 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 36ykv96uu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 03:57:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjpoUOVKaXWmdYcwfzxpjHUE5lvJkraxKIKbBrvq/IvQuqIt9hdwhZB1sVZmCBMx07/BQa9VlzSZrxcobkuyVdUaDUkxAIbIgkAiy+2NGmDpyieHhzD6Rl23gkC/RcxgzHXPvAUMEzA9exmKTpSUC975iSWBHc/mKketDqoOLl4VfVJdK3z9n8MiHJ0xn7NIBK0nQlpadr6FiYsmElVtR7OVzCpkkDSVNojfwmUDDPnM1pq2ytjKFjf8VQ4kf0vHUF6CYNQi3wJMl07QruvR5dnduoXXf9mQSivaOWQ/p50ZVGndh+yiWKrtT7xQkiu8JMTj7YicO0wm6J/2vzE3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z2FI8Tx4MjiMdZFReDoTAIC/hObBhRhn05+cq7+ocs=;
 b=EglwA9DLYikFgr0RoPeSR+kWHO6R6CYeTc6CnsOuHshWkwttBQR22ir1Njdq3u8y3FuInaOemciVAirQx2Bdr6t2j1P/kxeAL+0Hn+jM28G3H0JYzjQVLpqjLw1SzeBQqKscneEXmI6rMEkbgGKQ4t3cjO1NMKVYsQaQz8oSVHUouo1zX8V8qOJPd7aofI4yjPjlH/L71YlxXivKbI2AyUx4GWVuenz8nXHhtMXvis+18eG70xGIBNXbcmUvmFuuS+ehvitLd0ygiAHsVlCp6cNk/9rDfZBtMYyyYh2USfwzUYtCcEH86NxWB+E4Le54C5/j6ISeDHYrPCQOXjyW6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z2FI8Tx4MjiMdZFReDoTAIC/hObBhRhn05+cq7+ocs=;
 b=wPli7lgPdv3jN6fzn34eBYJGBRQ0A8iqwexvusoLkHF+v0ofksvEJYH4kznzBzV5lxqtbg6GstrlP2QBLGzOTr/vGV/9ACc8AbCAGjg8YOzMNTlfaeOHLMfVibcMhOaz6ZmSKl/azJd3sz+RIHyXrTgU1DKUfqEoOCZpTyg7Sbg=
Received: from BN8PR03MB4977.namprd03.prod.outlook.com (2603:10b6:408:de::11)
 by BN7PR03MB3668.namprd03.prod.outlook.com (2603:10b6:406:cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Fri, 5 Mar
 2021 08:57:09 +0000
Received: from BN8PR03MB4977.namprd03.prod.outlook.com
 ([fe80::f173:1b63:12cd:58d0]) by BN8PR03MB4977.namprd03.prod.outlook.com
 ([fe80::f173:1b63:12cd:58d0%6]) with mapi id 15.20.3912.022; Fri, 5 Mar 2021
 08:57:09 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "zzzzArdelean, zzzzAlexandru" <alexandru.Ardelean@analog.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v3 0/6] iio: Add output buffer support
Thread-Topic: [PATCH v3 0/6] iio: Add output buffer support
Thread-Index: AQHXBrxjYGT6Yhi/UU6po2kwD27epKpihP4AgBKjMjA=
Date:   Fri, 5 Mar 2021 08:57:08 +0000
Message-ID: <BN8PR03MB497724AAAFA43E6555554DC98E969@BN8PR03MB4977.namprd03.prod.outlook.com>
References: <20210219124012.92897-1-alexandru.ardelean@analog.com>
 <20210221120106.00ae1078@archlinux>
In-Reply-To: <20210221120106.00ae1078@archlinux>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcm?=
 =?iso-8859-1?Q?lcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1jMThjOTFlYS03ZDkwLTExZWItOTEwOC?=
 =?iso-8859-1?Q?00ODg5ZTc3Y2RkZWZcYW1lLXRlc3RcYzE4YzkxZWItN2Q5MC0xMWViLTkx?=
 =?iso-8859-1?Q?MDgtNDg4OWU3N2NkZGVmYm9keS50eHQiIHN6PSIxMDY1IiB0PSIxMzI1OT?=
 =?iso-8859-1?Q?QwODIyNjUzNDcwNTQiIGg9Ik5sVGJ4cXNlMVprM0dYdVNLMk12Q2Njd1Ni?=
 =?iso-8859-1?Q?UT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUlZREFBRHVzNzZFblJIWEFkZDFTUjZuU1lzUzEzVkpIcWRKaXhJ?=
 =?iso-8859-1?Q?RkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBbXcvdm9BQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJQWFRQmhBRj?=
 =?iso-8859-1?Q?hBWkFCcEFHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJsQUhJQU1R?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tB?=
 =?iso-8859-1?Q?WXdCMEFHa0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 539005b5-bfa9-4208-0171-08d8dfb4a8b2
x-ms-traffictypediagnostic: BN7PR03MB3668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR03MB366832D63CAAE8B08BC8A4178E969@BN7PR03MB3668.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkNVYEImSe6EMLD7y37+V7wrz3FOVdUu/onsD4FBT4udMd8GiZuz9s1Z9YkFum07G+N2qepxZp8PhO7mj6LHIUWkxBdwB9Pnb3btuu7mpSeB69L8N/SjWnD3mD0g2baRhDPYXhk0AjxPg8xa5q7CTKMMFEEMu5lAKWfjjfrw2+BElNmLHSj9Raas/aDUC8Qp5W1M//SJgyFbiH7mXopnqrDkfijDLbkyuV4Gd7KAPRaPtOQzvcut3yHoYZPYawSodAmce/zlKR6vYoJjlw/LpJEFsQl8mwUrOHZK8m3Lq8T/UIFrRasiIZdzcGYyvYOj/ercUkSRg8qdYzefQ43MoGpurqbUnBJrCr5wdPow+Zp1NQxODMdibMzaO75sqYcSm7LtXxVm7Hi5OJzcFVGpp1B7vY/KoWFZlseFekMiz35MAxOogIFfb0IPnQAMviFi/XydnSmERsI924DfUq3ERfoF7ilU58Xid5rq43FBab/2q3rQ5071/rbKCXPfHztR5LHupZqr+U/kjRsABvRghQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4977.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(71200400001)(66946007)(66556008)(66476007)(64756008)(5660300002)(52536014)(4744005)(107886003)(66446008)(26005)(76116006)(4326008)(8676002)(8936002)(186003)(478600001)(33656002)(6636002)(2906002)(7696005)(86362001)(6506007)(316002)(110136005)(54906003)(9686003)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?S6BPoZE/A6B6gOhTPMSPXjJeQC3FSnd+zYfEFfkxJ1UmPAYWNaICkqLcs1?=
 =?iso-8859-1?Q?pRoKKSIB1vQyMKFxDtNKM8v3TArwAZjk287rWeOqThzcj19pPa2QjhGP7+?=
 =?iso-8859-1?Q?g6o05ddBigMWPtwqE4BxGyd1o7S88rv2TNVR+TP+60HEFLu6b4sL4Acrs4?=
 =?iso-8859-1?Q?rcVuQsHPU5OXPzq4pBtHezxPKDsABDSTzKbsULjn8ltAkqrXvAC3DTJzNi?=
 =?iso-8859-1?Q?nHdrhff+f11Ip7UJGIdgn71ZgzQThrJBpLzLscgIm1z20YUVwSkQxD3LEm?=
 =?iso-8859-1?Q?GaIrdZlIi1f/MLnSkoLqJBfe83KtvabbRh9qOIkHZG4XD7BwU0soqYW1Mg?=
 =?iso-8859-1?Q?JNr5BJ99wjhII8YBtJgVGiCgBYU3R8veGbkM9sHLCvtxjEaY5eeM4mfJzV?=
 =?iso-8859-1?Q?KwOzjJKK7ukTMcYuxwNNNX3ZC/5vY3O8rcmbUqbzfnQf/o1RwLS6eP8rRd?=
 =?iso-8859-1?Q?B/RgD0m4ZkIyh6p7sTksA2FeqmjYQXTWIKatXF3Wq0AUIqV0zyPW/kJdGn?=
 =?iso-8859-1?Q?c+bhjQ3nuV6hmy877n3q6KWphvESlysc8xLV4ZYAgZLBM1HJzAR2g4nDbD?=
 =?iso-8859-1?Q?ivlQD9cXDTFgqDaaHIBcYzXp3sEcZ+pKAiNsRkFcxzvlLMFBEV4M1CXppl?=
 =?iso-8859-1?Q?JxExAFVpbBWFGalLsEidPAOy1HuHeDqp/lJrjzmLCYSP6iK3un36BxhhLK?=
 =?iso-8859-1?Q?jUuUXpLkQSupQHmHaXQQwPygBE9AI9pVB1Wt9WYYsJ9qYWry7MEonkbtKD?=
 =?iso-8859-1?Q?RB4XNymQz57m+uKcfxddNSUxX38A8FaH6XUYfqgN6qahf1BmK6af0wr32A?=
 =?iso-8859-1?Q?BimAyKaEKiPE6h9AWoCLz8pjkAA+nCJ/tPMd5irOXavk49tdfmkdO8z0wv?=
 =?iso-8859-1?Q?ywBgZIWkxUDC4Z/I6kcOXcAylzruuHp9XgGShRwvgn6w9FTm+tKRxDZz4F?=
 =?iso-8859-1?Q?RvjPNHbZAr6r90dSN0tp0yzHfFhG/4A78QXhP17odyInxWYhaDu3CbAeon?=
 =?iso-8859-1?Q?rYkY/Tk7+I90d+wbmHy315hATPKWMgRpXF3sd1drAMDCrAUfnqT2CXIjPr?=
 =?iso-8859-1?Q?rwVrlPwTXAlk776lZJTUgDzXKDEdjpoWotu2s1gFq27ERp+GQt6uJDxd2X?=
 =?iso-8859-1?Q?yYxrVwH6JJY+PpcraI+LXzya547kVPoUi+uCwQFVogg0R1yOBlXOE5JXa3?=
 =?iso-8859-1?Q?leBpDDy7NkmzGyxNSxVLRxo7gbW2WYrMtE+AXC7Hun+W0QbRpSyp1JRT/f?=
 =?iso-8859-1?Q?nt7nLzpU2Ml5Mmnt/H4m/KMY18902lwLtrRfGYU5N2go55T0KLSpLmqULb?=
 =?iso-8859-1?Q?Ctpw0fKw4pGw0PHCmeddNeSJUOU81iUGVDii4swcMOAElvs/bXyGBLRb3b?=
 =?iso-8859-1?Q?3vW3wl7OXJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4977.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539005b5-bfa9-4208-0171-08d8dfb4a8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 08:57:08.9563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FahSl3zMGrP/rlJr0qpvcXHSHrQtGQW5TNwX5JPNJ8ni4J3UuDYa8ilConQjeecjA8btL0hXd9LxGCNh5rUfUyZtIpzR5qgAZiq1co9Jdts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3668
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_04:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan and others,

With output/dac buffer support the semantics of the scan_element type may c=
hange.

Today the Format is [be|le]:[s|u]bits/storagebitsXrepeat[>>shift].

While shift (if specified) is the shift that needs to be applied prior to m=
asking out unused bits.

So far so good and it sounds universal.=20

However, we use the right shift (operator) for that, which makes sense for =
capture devices.
For output devices the more logical operator would be the left shift.

I'm not proposing a new Format here. I just want to get some agreement that=
 for an output device

le:s12/16>>4

is understood as a left shift of 4, since the unused bits are then on the L=
SB.

Thoughts?

Best Regards,
Michael

Analog Devices GmbH
Michael Hennerich=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=20
Otl-Aicher Strasse 60-64
D-80807 Muenchen; Germany

Sitz der Gesellschaft M=FCnchen, Registergericht M=FCnchen HRB 40368,
Gesch=E4ftsf=FChrer: Stefan Steyerl, Michael Paul Sondel, Yoon Ah Oh


