Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8689B442B62
	for <lists+linux-iio@lfdr.de>; Tue,  2 Nov 2021 11:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhKBKL4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Nov 2021 06:11:56 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58092 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229577AbhKBKLz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Nov 2021 06:11:55 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A1M8Bdn019309;
        Tue, 2 Nov 2021 06:09:20 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c2g25mkcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Nov 2021 06:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzusQt8nEe8oR6mJvcD5I4WPg7t36FQbwEZi9XpXAmqE7jL+1EnQReYBfxneky8frS1/DnRJjtb1IFCq+o2enoBP3FEMkz5ZpK5GAaLkXEjw1GQvB/j3nSxf4pv9K7BgaqDghsqf29MBT96R3vPjEe6f2fx6I5bsA8fvoGxPcA/qYxeE/fCqO5t9ZpbOSL7Gjgp9Sp5rncL5gkeK97La0IgSrMCKENGMHbMGJr3xzsgahjqPvaurKU9gsM5Ln3vB3fmanGPRVDzzQ1vxGZinR6f8mUPmWldn5+ctBL/vjmZy4znMuOmEsU1g8pJKynX5hoL7PL9dhTrZdRauU7j++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qubVI11RI0eDJluHn8ZVsHIBPT/lKREGML0hIFCa/U=;
 b=jTx+UrTNo8BgidIEvQehfdzm5knA7702YJwL0CluR0YkiVaOpQ7+mnCsd8nn4CaGDvLlOfuJusXGiJdlOwfArygpxdyz3RlY/LZ47lVr3wb7jCZaqLH9R8vmBEYqQJ3j09p3B/xWz7XlApURHkuujPn4m14+bLWkdxLEilYdunULi421MNVezVWFD0QWRjciVBMP/zhubrX3QQVvgdmvFiSmue9sRQ474oyYkNIvixzcgDPHvQqjr6d2RGqxJVw+jxpP5KoGt5mdR/Q1Z/KnfgIX1XB4ZajhL1Um62XTi68hPDH/TQV5KZxVLe5C4i479VROA9/CZIY5Rp0/AxpNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qubVI11RI0eDJluHn8ZVsHIBPT/lKREGML0hIFCa/U=;
 b=8jRR2Sf2XXLHWSgT8q7ee+1BRlzThTBbjO9e1sc3V76gkYSkB1j8fcTn33EG+jA9FyGQoBZ4YTETo4asCpMvOZ//Wflwrpzbt157XIfTbw/d8ThazwcZa6SMXfJck9qMToH5S3/97MIzXQlTxjB8jdieKo9I9zbPyZX4TAHht5Q=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 10:09:17 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::e555:851:6adb:f73%8]) with mapi id 15.20.4628.022; Tue, 2 Nov 2021
 10:09:17 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Subject: RE: [PATCH v3 1/2] iio: frequency: admv1013: add support for ADMV1013
Thread-Topic: [PATCH v3 1/2] iio: frequency: admv1013: add support for
 ADMV1013
Thread-Index: AQHXzwfgGHROvFVBxUSS1cWk9SZT/6vwAwkg
Date:   Tue, 2 Nov 2021 10:09:15 +0000
Message-ID: <PH0PR03MB6366548C1CE5476989662F74998B9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
In-Reply-To: <20211101100420.70304-1-antoniu.miclaus@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZWQ4NjAzNzAtM2JjNC0xMWVjLThiOTYtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGVkODYwMzcyLTNiYzQtMTFlYy04Yjk2LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTQ0OTMiIHQ9IjEzMjgwMzIxMz?=
 =?iso-8859-1?Q?UzNjU2NTg5MSIgaD0iN0JvOEJ5emlvVGxFbDg5OUZUTjZxbmdaekpFPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBRW9DQUFDRG11Q3YwYy9YQVdqdkcxUURXTDg3YU84YlZBTll2enNEQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUVBQVFBQkFBQUFWSUV2b1FBQUFBQUFBQUFBQUFBQUFK?=
 =?iso-8859-1?Q?NEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYW?=
 =?iso-8859-1?Q?dCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBB?=
 =?iso-8859-1?Q?R2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRU?=
 =?iso-8859-1?Q?FaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?iso-8859-1?Q?MEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FY?=
 =?iso-8859-1?Q?d0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBY3dCZk?=
 =?iso-8859-1?Q?FIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7b6d55d-d128-48c8-722b-08d99de8d4aa
x-ms-traffictypediagnostic: PH0PR03MB6235:
x-microsoft-antispam-prvs: <PH0PR03MB62351FA659C30273C8421884998B9@PH0PR03MB6235.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIIUFayFMh0FwIv6unSRjaNPOKzqUG2wujIaAlmOrq/CduFGPMk1p7KRhMVpy49a8SVMVvh20BLLGlI652bgB8aS17jz8TJQfoApWnQlWRRAR76WobE58DKJ4Cah1aFxcayhtN90bfxDrq1TOPa1/l6H5VUSIUSXs1AHqMVjN2C1f9zqD++I6eVJRq4tIVAS3wSeVInTO0HggLTZpY80uSMH4WFcl2JkbFo8SMMSQprubCSrL1GaMtzhBEl09pw3qnqLLhiV/c6zHkOX6Vq3LK4k1qRm5623XmBkH7hnRiDSOYePOJS0fmuY4mMx9FeKxlx9ZQcETsUTkchBAZshOpvR5lmn6oPh+bSW+mHKgyKO7mifatARkmqJvdE8no5F/tfvjHnITCNoso4ZJu6wABg/P+1FQyx3WSi01Ek4IKrmmfzDI7eRAdHFulFWvJviAybZrCE28zLoQ0j49OvtgFOb3limngafYfuDdgUeUWtBapj/R5UzEhaxGsGnm62LMgFl79+EI7pOWafVKeKgm8tHA/gVY/v7c8KKHj1DSm17kbGIpooI3L6GVdZEEawPABb60bLfQlebeGGnl3EE7HHn6vedmxcSJLq4urGkvBtN597V3AvUiXXdMa5K/IIA86CyP0gjj4qFCowwiY7Ve1hHmsKGAqZe2EUQGAeeBNR6ROyxzCHn+7/FJNv1G/UxikYEgfgL7XVfQ3B/4vlpmNO1ZN+0uI1WsGuQDaCY0QJbQhAqg2FAtSoyS07QLxhpDSqqVD2SinFeSD089dXggDWrun5C4vRaM8/6UdRrBPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(186003)(316002)(30864003)(2906002)(966005)(38100700002)(64756008)(122000001)(52536014)(66476007)(66556008)(66446008)(86362001)(71200400001)(38070700005)(66946007)(26005)(5660300002)(4326008)(508600001)(107886003)(76116006)(53546011)(33656002)(55016002)(6506007)(7696005)(83380400001)(8936002)(110136005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RoVRPE2YhMb/iYBhTpDoib1YR2pkAJGP/+VFNWnytS3wLI+IIYXLWDymdH?=
 =?iso-8859-1?Q?18FOXXosJYApoxxa+pWrmdaj57iMACaR/8l1zZ5WbNAJxil/AnOdyaL5nd?=
 =?iso-8859-1?Q?091yp6K3fyQVAVOIh1m0rqPhkfRB8L5tXYzDwYqiwiZKpMsL1lClChEanB?=
 =?iso-8859-1?Q?xOJwqXl1Pd+xPUTzLqPJiX6cr+TIcZEC2X7NnvTaaMV/1kV6U/o/c2AcPn?=
 =?iso-8859-1?Q?CL99a5ZWz2FhU8wUwhHYdFlANVMD7V9nwMcwezCOesNsBUf7LmegBqaATg?=
 =?iso-8859-1?Q?DmGnsXpT8a1zUfTJxFh8mMNCvHHpOr838ay0XIibJOBQlZgqwe6q412UFc?=
 =?iso-8859-1?Q?1GhQD4xGfVqid5jOM8yTxLAiX4QbhadURc5XLYz9h2yJASvXHbcjBr/P5n?=
 =?iso-8859-1?Q?BRD5udoy51gubfZ/94YAWJd8dp/wxGmav6CQ6P5Y7n6G8AilE+ZUf0Kjt/?=
 =?iso-8859-1?Q?NNFWj277jnpSqYANzht2WquVhPxYvb4BR3lEYfnlTADq19n8fdJHXFyYEA?=
 =?iso-8859-1?Q?3Cubf+kwN8E0MJjPli1OnT+r4TS5TZyMpOg+hKPJfXFxqZ0o2kTgFGQ845?=
 =?iso-8859-1?Q?rl1DLMcKAhxrLf1EmzXflZo6ukz/NRYoDstAzeu6oIUcy5XO3+eKcBpp5s?=
 =?iso-8859-1?Q?2kmNfzCvSQpIZq8cdrpfd6inuT7KAek7aZB5ZTvVcdiwbHVZ8bsjaEcsmt?=
 =?iso-8859-1?Q?otOX4UA1/RG6RrsuKcfY3jIntWlf10AKy9zJnObWEnSrXyLoufZjdVzAwr?=
 =?iso-8859-1?Q?ZYldbXMdaOfdE9uClaF2giF1OggjO8svAzmJy4f9v6eEcnEDXNsg485TJa?=
 =?iso-8859-1?Q?dGJw0YfbnhQyCjk3xrcE1D/Hg/Qkht9p/f1tZiBu/f71CRA+4swzCE/8vN?=
 =?iso-8859-1?Q?PdCZi1Mc0Xm4iECpWAz/X5t6XCx8bkkYXyZ7rpbONSWohaEIcLTSEqXXEc?=
 =?iso-8859-1?Q?dYs2rQxJGodPtBGBesMArOEfr40gey4a/Z47unX7FXIzEEYHiu+PZf3Olr?=
 =?iso-8859-1?Q?Z7LICbfIE/6Fi5r48L21CY5pbPwuNmYGxrRvPLiXp66nyfE36sFDXRx6J7?=
 =?iso-8859-1?Q?6u4LGLapZHveNrn8nB06L68T38uWSOVPbBVfTVL9BeLTTJTyeUEQbIgKxe?=
 =?iso-8859-1?Q?VY6w4w5wRDkaFUG+Lw+DJnoiHpsN9BmcAMXuw5nET+enL4w9csCu7982RY?=
 =?iso-8859-1?Q?3VZMa89OFSJk4XRHs+LE4cZgkdUrQJgBCKjIJb+ighxb4KmLlu9zuOR+b4?=
 =?iso-8859-1?Q?c04wDRIh/niWFI4a6/P8njWJFUuAxb9aLHaak3z1aqmEC+zI5nkAlUOAdL?=
 =?iso-8859-1?Q?bZYid96D7uWdR47Vr3fmgFZYnTWtPjK7ybe6b1j8gMiVR2Smbhu32RayIS?=
 =?iso-8859-1?Q?9xNxhhqq/goId0uj3nv5w32n6Eze6FKRzB4DcfN0RVoc9QiQoKmswfv5Mw?=
 =?iso-8859-1?Q?V/fEVW7mCFMw8uHdzbuVaj7P8XWsIWfIxrG1gz7/Jti0K0Q9UDWUq1Ak4W?=
 =?iso-8859-1?Q?WZGhD/2nSFUr4xqG43SbhAv1LyhD9M+boW4VSWIOmDR1cxLGFsdUBceBBE?=
 =?iso-8859-1?Q?nHFNEe+hnCQ3Hk+HkNUAc2fNhIpZYSt8uRYFU2uskkgy3zrYe7LzYlf6x0?=
 =?iso-8859-1?Q?4qGOQ8I1hQLYoCJoJaev1MvQxTwFelf3gfP2nZ0NDerWPgU8BSu27Eeg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b6d55d-d128-48c8-722b-08d99de8d4aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 10:09:17.3777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GG0Wmm4yv+yhOP/uZ7qqKSeMxKLgr2YUEL51yAjONWVwQxUELFs3Jze50sZ1fnA9g7F4bRifh9/MNpaxZySag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6235
X-Proofpoint-ORIG-GUID: RVENKa4eTjzceohpIle1YlWPO_ybe-NY
X-Proofpoint-GUID: RVENKa4eTjzceohpIle1YlWPO_ybe-NY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_06,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111020060
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Sent: Monday, November 1, 2021 11:04 AM
> To: jic23@kernel.org; robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>
> Subject: [PATCH v3 1/2] iio: frequency: admv1013: add support for
> ADMV1013
>=20
> The ADMV1013 is a wideband, microwave upconverter optimized
> for point to point microwave radio designs operating in the
> 24 GHz to 44 GHz radio frequency (RF) range.
>=20
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADMV1013.pdf
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> changes in v3:
>  - fix includes
>  - make masks more generic where possible
>  - improve mutex attribute description
>  - rework IIO channels and remove IIO_VAL_INT_MULTIPLE return
>  - use HZ_PER_MHZ macro
>  - improve readability in the `int admv1013_reg_access` function
>  - use `devm_clk_notifier_registers()`
> ---
>  drivers/iio/frequency/Kconfig    |  11 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1013.c | 571
> +++++++++++++++++++++++++++++++
>  3 files changed, 583 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1013.c
>=20
> diff --git a/drivers/iio/frequency/Kconfig
> b/drivers/iio/frequency/Kconfig
> index 240b81502512..411b3b961e46 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -49,5 +49,16 @@ config ADF4371
>=20
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
> +
> +config ADMV1013
> +	tristate "Analog Devices ADMV1013 Microwave Upconverter"
> +	depends on SPI && COMMON_CLK
> +	help
> +	  Say yes here to build support for Analog Devices ADMV1013
> +	  24 GHz to 44 GHz, Wideband, Microwave Upconverter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv1013.
> +
>  endmenu
>  endmenu
> diff --git a/drivers/iio/frequency/Makefile
> b/drivers/iio/frequency/Makefile
> index 518b1e50caef..559922a8196e 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,3 +7,4 @@
>  obj-$(CONFIG_AD9523) +=3D ad9523.o
>  obj-$(CONFIG_ADF4350) +=3D adf4350.o
>  obj-$(CONFIG_ADF4371) +=3D adf4371.o
> +obj-$(CONFIG_ADMV1013) +=3D admv1013.o
> diff --git a/drivers/iio/frequency/admv1013.c
> b/drivers/iio/frequency/admv1013.c
> new file mode 100644
> index 000000000000..6451a2cc7c52
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -0,0 +1,571 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1013 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/notifier.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +/* ADMV1013 Register Map */
> +#define ADMV1013_REG_SPI_CONTROL		0x00
> +#define ADMV1013_REG_ALARM			0x01
> +#define ADMV1013_REG_ALARM_MASKS		0x02
> +#define ADMV1013_REG_ENABLE			0x03
> +#define ADMV1013_REG_LO_AMP_I			0x05
> +#define ADMV1013_REG_LO_AMP_Q			0x06
> +#define ADMV1013_REG_OFFSET_ADJUST_I		0x07
> +#define ADMV1013_REG_OFFSET_ADJUST_Q		0x08
> +#define ADMV1013_REG_QUAD			0x09
> +#define ADMV1013_REG_VVA_TEMP_COMP		0x0A
> +
> +/* ADMV1013_REG_SPI_CONTROL Map */
> +#define ADMV1013_PARITY_EN_MSK			BIT(15)
> +#define ADMV1013_SPI_SOFT_RESET_MSK		BIT(14)
> +#define ADMV1013_CHIP_ID_MSK			GENMASK(11, 4)
> +#define ADMV1013_CHIP_ID			0xA
> +#define ADMV1013_REVISION_ID_MSK		GENMASK(3, 0)
> +
> +/* ADMV1013_REG_ALARM Map */
> +#define ADMV1013_PARITY_ERROR_MSK		BIT(15)
> +#define ADMV1013_TOO_FEW_ERRORS_MSK		BIT(14)
> +#define ADMV1013_TOO_MANY_ERRORS_MSK		BIT(13)
> +#define ADMV1013_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> +
> +/* ADMV1013_REG_ENABLE Map */
> +#define ADMV1013_VGA_PD_MSK			BIT(15)
> +#define ADMV1013_MIXER_PD_MSK			BIT(14)
> +#define ADMV1013_QUAD_PD_MSK
> 	GENMASK(13, 11)
> +#define ADMV1013_BG_PD_MSK			BIT(10)
> +#define ADMV1013_MIXER_IF_EN_MSK		BIT(7)
> +#define ADMV1013_DET_EN_MSK			BIT(5)
> +
> +/* ADMV1013_REG_LO_AMP Map */
> +#define ADMV1013_LOAMP_PH_ADJ_FINE_MSK
> 	GENMASK(13, 7)
> +#define ADMV1013_MIXER_VGATE_MSK		GENMASK(6, 0)
> +
> +/* ADMV1013_REG_OFFSET_ADJUST Map */
> +#define ADMV1013_MIXER_OFF_ADJ_P_MSK
> 	GENMASK(15, 9)
> +#define ADMV1013_MIXER_OFF_ADJ_N_MSK
> 	GENMASK(8, 2)
> +
> +/* ADMV1013_REG_QUAD Map */
> +#define ADMV1013_QUAD_SE_MODE_MSK		GENMASK(9, 6)
> +#define ADMV1013_QUAD_FILTERS_MSK		GENMASK(3, 0)
> +
> +/* ADMV1013_REG_VVA_TEMP_COMP Map */
> +#define ADMV1013_VVA_TEMP_COMP_MSK
> 	GENMASK(15, 0)
> +
> +struct admv1013_state {
> +	struct spi_device	*spi;
> +	struct clk		*clkin;
> +	/* Protect against concurrent accesses to the device and to
> data */
> +	struct mutex		lock;
> +	struct regulator	*reg;
> +	struct notifier_block	nb;
> +	unsigned int		quad_se_mode;
> +	bool			vga_pd;
> +	bool			mixer_pd;
> +	bool			quad_pd;
> +	bool			bg_pd;
> +	bool			mixer_if_en;
> +	bool			det_en;
> +	u8			data[3] ____cacheline_aligned;
> +};
> +
> +static int __admv1013_spi_read(struct admv1013_state *st, unsigned
> int reg,
> +			       unsigned int *val)
> +{
> +	int ret;
> +	struct spi_transfer t =3D {0};
> +
> +	st->data[0] =3D 0x80 | (reg << 1);
> +	st->data[1] =3D 0x0;
> +	st->data[2] =3D 0x0;
> +
> +	t.rx_buf =3D &st->data[0];
> +	t.tx_buf =3D &st->data[0];
> +	t.len =3D 3;
> +
> +	ret =3D spi_sync_transfer(st->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D (get_unaligned_be24(&st->data[0]) >> 1) &
> GENMASK(15, 0);
> +
> +	return ret;
> +}
> +
> +static int admv1013_spi_read(struct admv1013_state *st, unsigned
> int reg,
> +			     unsigned int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D __admv1013_spi_read(st, reg, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __admv1013_spi_write(struct admv1013_state *st,
> +				unsigned int reg,
> +				unsigned int val)
> +{
> +	put_unaligned_be24((val << 1) | (reg << 17), &st->data[0]);
> +
> +	return spi_write(st->spi, &st->data[0], 3);
> +}
> +
> +static int admv1013_spi_write(struct admv1013_state *st, unsigned
> int reg,
> +			      unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D __admv1013_spi_write(st, reg, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __admv1013_spi_update_bits(struct admv1013_state *st,
> unsigned int reg,
> +				      unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +	unsigned int data, temp;
> +
> +	ret =3D __admv1013_spi_read(st, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	temp =3D (data & ~mask) | (val & mask);
> +
> +	return __admv1013_spi_write(st, reg, temp);
> +}
> +
> +static int admv1013_spi_update_bits(struct admv1013_state *st,
> unsigned int reg,
> +				    unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret =3D __admv1013_spi_update_bits(st, reg, mask, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int admv1013_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct admv1013_state *st =3D iio_priv(indio_dev);
> +	unsigned int data, addr;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (chan->channel2 =3D=3D IIO_MOD_I)
> +			addr =3D ADMV1013_REG_OFFSET_ADJUST_I;
> +		else
> +			addr =3D ADMV1013_REG_OFFSET_ADJUST_Q;
> +
> +		ret =3D admv1013_spi_read(st, addr, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (!(chan->channel))
> +			*val =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_P_MSK, data);
> +		else
> +			*val =3D
> FIELD_GET(ADMV1013_MIXER_OFF_ADJ_N_MSK, data);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 =3D=3D IIO_MOD_I)
> +			addr =3D ADMV1013_REG_LO_AMP_I;
> +		else
> +			addr =3D ADMV1013_REG_LO_AMP_Q;
> +
> +		ret =3D admv1013_spi_read(st, addr, &data);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D
> FIELD_GET(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, data);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1013_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct admv1013_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (chan->channel2 =3D=3D IIO_MOD_I) {
> +			if (!(chan->channel))
> +				ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_I,
> +
> ADMV1013_MIXER_OFF_ADJ_P_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_P_MSK, val));
> +			else
> +				ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_I,
> +
> ADMV1013_MIXER_OFF_ADJ_N_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_N_MSK, val));
> +		} else {
> +			if (!(chan->channel))
> +				ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_Q,
> +
> ADMV1013_MIXER_OFF_ADJ_P_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_P_MSK, val));
> +			else
> +				ret =3D admv1013_spi_update_bits(st,
> ADMV1013_REG_OFFSET_ADJUST_Q,
> +
> ADMV1013_MIXER_OFF_ADJ_N_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_N_MSK, val));
> +		}
> +
> +		return ret;
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 =3D=3D IIO_MOD_I)
> +			return admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_I,
> +
> 	ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
> +
> 	FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, val));
> +		else
> +			return admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_Q,
> +
> 	ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
> +
> 	FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, val));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1013_update_quad_filters(struct admv1013_state *st)
> +{
> +	unsigned int filt_raw;
> +	u64 rate =3D clk_get_rate(st->clkin);
> +
> +	if (rate >=3D (5400 * HZ_PER_MHZ) && rate <=3D (7000 *
> HZ_PER_MHZ))
> +		filt_raw =3D 15;
> +	else if (rate >=3D (5400 * HZ_PER_MHZ) && rate <=3D (8000 *
> HZ_PER_MHZ))
> +		filt_raw =3D 10;
> +	else if (rate >=3D (6600 * HZ_PER_MHZ) && rate <=3D (9200 *
> HZ_PER_MHZ))
> +		filt_raw =3D 5;
> +	else
> +		filt_raw =3D 0;
> +
> +	return __admv1013_spi_update_bits(st,
> ADMV1013_REG_QUAD,
> +
> 	ADMV1013_QUAD_FILTERS_MSK,
> +
> 	FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
> +}
> +
> +static int admv1013_update_mixer_vgate(struct admv1013_state *st)
> +{
> +	unsigned int vcm, mixer_vgate;
> +
> +	vcm =3D regulator_get_voltage(st->reg);
> +
> +	if (vcm >=3D 0 && vcm < 1800000)
> +		mixer_vgate =3D (2389 * vcm / 1000000 + 8100) / 100;
> +	else if (vcm > 1800000 && vcm < 2600000)
> +		mixer_vgate =3D (2375 * vcm / 1000000 + 125) / 100;
> +	else
> +		return -EINVAL;
> +
> +	return __admv1013_spi_update_bits(st,
> ADMV1013_REG_LO_AMP_I,
> +				 ADMV1013_MIXER_VGATE_MSK,
> +
> FIELD_PREP(ADMV1013_MIXER_VGATE_MSK, mixer_vgate));
> +}
> +
> +static int admv1013_reg_access(struct iio_dev *indio_dev,
> +			       unsigned int reg,
> +			       unsigned int write_val,
> +			       unsigned int *read_val)
> +{
> +	struct admv1013_state *st =3D iio_priv(indio_dev);
> +
> +	if (read_val)
> +		return admv1013_spi_read(st, reg, read_val);
> +	else
> +		return admv1013_spi_write(st, reg, write_val);
> +}
> +
> +static const struct iio_info admv1013_info =3D {
> +	.read_raw =3D admv1013_read_raw,
> +	.write_raw =3D admv1013_write_raw,
> +	.debugfs_reg_access =3D &admv1013_reg_access,
> +};
> +
> +static int admv1013_freq_change(struct notifier_block *nb, unsigned
> long action, void *data)
> +{
> +	struct admv1013_state *st =3D container_of(nb, struct
> admv1013_state, nb);
> +	int ret;
> +
> +	if (action =3D=3D POST_RATE_CHANGE) {
> +		mutex_lock(&st->lock);
> +		ret =3D
> notifier_from_errno(admv1013_update_quad_filters(st));
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +#define ADMV1013_CHAN_PHASE(_channel, rf_comp) {		\
> +	.type =3D IIO_ALTVOLTAGE,					\
> +	.modified =3D 1,						\
> +	.output =3D 1,						\
> +	.indexed =3D 1,						\
> +	.channel2 =3D IIO_MOD_##rf_comp,				\
> +	.channel =3D _channel,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_PHASE)		\
> +	}
> +
> +#define ADMV1013_CHAN_CALIB(_channel, rf_comp) {		\
> +	.type =3D IIO_ALTVOLTAGE,					\
> +	.modified =3D 1,						\
> +	.output =3D 1,						\
> +	.indexed =3D 1,						\
> +	.channel2 =3D IIO_MOD_##rf_comp,				\
> +	.channel =3D _channel,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_CALIBBIAS)	\
> +	}
> +
> +static const struct iio_chan_spec admv1013_channels[] =3D {
> +	ADMV1013_CHAN_PHASE(0, I),
> +	ADMV1013_CHAN_PHASE(0, Q),
> +	ADMV1013_CHAN_CALIB(0, I),
> +	ADMV1013_CHAN_CALIB(0, Q),
> +	ADMV1013_CHAN_CALIB(1, I),
> +	ADMV1013_CHAN_CALIB(1, Q),
> +};
> +

Hmm, If I'm not missing nothing this leads to something like:

out_altvoltage0_i_phase
out_altvoltage0_q_phase
out_altvoltage0_i_calibbias
out_altvoltage0_q_calibbias
out_altvoltage1_i_calibbias
out_altvoltage1_q_calibbias

To me it is really non obvious that index 1 also applies to the same
channel. I see that we have this like this probably because we
can't use modified and differential at the same time, right?

Jonathan, I'm not sure what should be the done here... From the top of my
head  I guess we can either:

* drop the modifiers (not perfect but also not that bad IMO),
* tweak something adding extended info (not really neat)
* or handling this in the core with a new variable. Of course, we would nee=
d
to be careful to not break existing drivers...

Not sure if labels could also be something to use... Any suggestion from yo=
ur
side?

- Nuno S=E1

