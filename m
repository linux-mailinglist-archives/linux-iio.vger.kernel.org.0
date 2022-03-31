Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE214ED412
	for <lists+linux-iio@lfdr.de>; Thu, 31 Mar 2022 08:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiCaGq4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 31 Mar 2022 02:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiCaGqz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Mar 2022 02:46:55 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83DBB0A5B
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 23:45:08 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22V43aW1004361;
        Thu, 31 Mar 2022 02:44:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f1vkb23wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 02:44:49 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22V6V5eV011891;
        Thu, 31 Mar 2022 02:44:49 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f1vkb23wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 02:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR5wko3NaNN7emDSKIJNGLVHv5j5dyD2zQmh2HxKbqStIt4Re8c1oRj2JJVcO79FdY3g9H2VwNFpqQVowar5JOdIpVrBsn2PizB65P3j2UPY2tRA6X9AsU8RM596e4HLqT7sxkZfDAJPhYkQu9fXw/3pfW/07p7VIy8/A5MyN3b1MvchaiFIaDtNBvtgiNvVBBmWSdm3+4ImDhqxQ5F3CnqbFekpQrEcj97if2SOViQ9sMGwYWc8Zx3MnsEQ/Pg2JAZCZL95x0Un7WyPvDcz6FTL4nrCCDhfc5cB0zubkczZKEEWGOxLR9hkgtIQT8LEUlLFzerugYg1Z3AuFq/SYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1fZj9PC0L8Prnb1x4/V+bvAnVAVjn1m7eG3x8pCDEY=;
 b=K/hCyIsCmJ7PCw4JUt33+qHPvwU8ZL93u6gzJehDD9t2BJAfj860GYioMBHlErutINbN1kSuCuqY3FELLvtYtxTrDn83oBqZ+RRWkZGzmHsiYmuJlWvdQ8k6+nVbM0/9ckKPDmxgrnV6hx2oo8JsVyzTJfcWxfHg4zwQk2z8oHNqvU3KkAuH1mnnlfFPMyr99jpI14ZrPS+1D4mHHM9wP4PpYOS6rvohcCVA+1n3mSb3jMd9+zTV7I4IOb8znA7XaWo4Mt8hMlxkZHt2sEAhKmusyzB7lba6YHSGqbXX3XYB++neGbT9v6nxpEOJHB/MAc6MGSQnrOMhLPAS+vzWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1fZj9PC0L8Prnb1x4/V+bvAnVAVjn1m7eG3x8pCDEY=;
 b=1Xe5qtR0EsB7HWZY+Z6akRizaM21N+0pFudAZNf2gOdj7iJfWqpzimz32OaYG7yak7tfw9qUMuezhCxK9gj4JdJB+9SFj8GxIgYQU0Ue3WaO2nJLP3vk46UcWwtD8eRgwU3exXo4IPMbkszdN94TZrMWHR+JgcUY3NA7qmno0tI=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 06:44:47 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5102.022; Thu, 31 Mar 2022
 06:44:46 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Marek Vasut <marex@denx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v3] iio: core: Print error in case sample bits do not fit
 storage bits
Thread-Topic: [PATCH v3] iio: core: Print error in case sample bits do not fit
 storage bits
Thread-Index: AQHYQt2T9kwfASMfx0yfkshF41qOFazZD7NQ
Date:   Thu, 31 Mar 2022 06:44:46 +0000
Message-ID: <PH0PR03MB67865DC54EB9B033045B185A99E19@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220328195307.154422-1-marex@denx.de>
In-Reply-To: <20220328195307.154422-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMGMwOTkyNjctYjBiZS0xMWVjLThiZDMtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDBjMDk5MjY5LWIwYmUtMTFlYy04YmQzLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMjIwNSIgdD0iMTMyOTMxODI2OD?=
 =?iso-8859-1?Q?Q0MDUzMjc4IiBoPSJNNkFHK29CVkxDTW04a0o0QTdmSk9OODdwUnc9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUFlTDJMT3lrVFlBY2lQU2RvbVgyZWl5STlKMmlaZlo2SURBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19ba2892-15e0-483d-b6ae-08da12e1f221
x-ms-traffictypediagnostic: BN9PR03MB6058:EE_
x-microsoft-antispam-prvs: <BN9PR03MB60583C2930B539D3A5A55D8299E19@BN9PR03MB6058.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VU5aaTNGPBmgvRYuFO1em2N3wOQsxvc3uIRSayRV0EbByQUg0HgEjqDuS2Bz4UBL3xZ9G8LCdgxzM5SOWpp9ugphlOR5QMXhWjzJb5Qp/xxtj4QBXlCg7VNAy9aWMs1KDezC0WYPbyf9Dyrh3HzfoOdbufMdkcGJtlbMk9P+tIiOGatQRgeFk6G1PZo+pMfZMl/j9q9SaMfcyBmZLHJO3v59Rg0StZacF9PSi/x6DUsVg19mFHmORK74W4AYVHpCDr78kjZuTXZgN/N+50djIL+LjAzn9r6Bd/8aahLO2YGbqmGN5WpoR9Ratlcn6Kqzvr+AlZR6eXFXhfiil9hrdGEKigc+k6sYgnxCHpD9ig4+PHmo4ESz5LN2kEWIQC+aa9lwAVufuP6tQCR9mu+eaHaJ24ROscFJSSjRgtK0PvpHvVviy+CeO+5s9b2JXh2N0DNpI0PCQ7PqeqJD9zBmpX57UJwCSHywMLTX8Yq/bBLcD31SjRQnE5Tn1Fz6zap9rI770Rd9C15QcS6nABFQXKx+ffi6yURQmKGaux2P8sEOBvsjYOPHUZ8vAOVrAm9lDWaaprZlR2d3wShtqwcPGgkqfuZWgU5/rRxwSsD5f4uruwrlg0NeV/hBNTCFz3QTBGNok93L0dxTHgvRlYgDQEh8Nj03kCHRFcJEGgCTG06zolmOjKJZdPYMRFRl52ZAvcFXxIgLbv8M1EKYy6fKog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(55016003)(38070700005)(508600001)(66476007)(76116006)(66946007)(8676002)(66446008)(64756008)(26005)(186003)(52536014)(9686003)(66556008)(4326008)(33656002)(2906002)(54906003)(83380400001)(5660300002)(110136005)(53546011)(86362001)(122000001)(71200400001)(8936002)(7696005)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c5t5T59I9Q0c7WmvKvPQ9Tdh5hjCF5gc6SaEcdi8+J2wBXU1RG/0dSzXLy?=
 =?iso-8859-1?Q?256QUCUbATvtujoLvWp/RtooL2jAY5vD0/dKgWcqbCAAgA8JFylRz+zP5m?=
 =?iso-8859-1?Q?QZ7vZBDWObQKXTrE3NoWHdeYw0GJSY+qQFZus9iA3HftttWqZcNy+w1DMU?=
 =?iso-8859-1?Q?JbfjSCt6FzwPlt61SLNI9TCg7/d5Z6Rc6O1D9aVGRaQsd7uECq/v6U3TPb?=
 =?iso-8859-1?Q?z1Da6FfcsV/Fi7159ZsCK1tX6md5bv0mbg6R0HVzX9NAjIyYNEG4lGl1uC?=
 =?iso-8859-1?Q?b2Md5bmBTr+0s/mV3yNgYsbFzmM2GcivWSbfVD3RqlsTryf/ic+nbS3gbJ?=
 =?iso-8859-1?Q?70X6tmrJiTO2V938mpQGMantN9OYYgrYeZDXXqhoNX2cebCshqHMk2LzaO?=
 =?iso-8859-1?Q?kljD0DZz+5y63SpOk4cDIxJS9oCpUBFWfcPq5GP1CsTs1S1fjYpEys0oVY?=
 =?iso-8859-1?Q?cBdosTMvtwMPM/gvG9vqHhkkPPyoMQZyUKJOTMPAfysgSy/CrKZ464J9Wc?=
 =?iso-8859-1?Q?o7/RlIEborts6dmEgO4Hyah+35xYmwPGsaRSJ9dvAhX+eebWzZY0KK47F7?=
 =?iso-8859-1?Q?8cWQ7ThvLuIXvxNL3mrLEaSNGySlZ8jNO645GAEasaeTWvc2aPvVgdbwmS?=
 =?iso-8859-1?Q?5qrSikN/xmS7W0mjDKVVZMoHzguJYjezlqNc5JU6dtJLyyzLfLB+Su20WN?=
 =?iso-8859-1?Q?EAk5/DS53yKdZ+hERHyO3MXMacIIosHkqT38hcB8ork9Kb+dHta6YkQ8Ry?=
 =?iso-8859-1?Q?j7eGUayuJ7cTKeX2kS3FRRGgY5L8yxX1A83qjrURK65FI11K5s28ffo9Ds?=
 =?iso-8859-1?Q?ttbqdDFo7xylgCxzFtG0acM00Yvmr3dGJu9e3PTWXLag8rlOMcbSOChSYM?=
 =?iso-8859-1?Q?S1+02rPKIHOdktWj6IRHSAS2x0TJIEpWyyC7/8wH9tY/U3ZPgTRA4O/plW?=
 =?iso-8859-1?Q?8DPHyHGC/cUaUklWqcMJSVN3DQYRmcqQD5JtvhkWEHpzU53rRqme4mjiVm?=
 =?iso-8859-1?Q?bd+woolPC8gyPePSYhSoTiuk+Ri0GOL6mZM5R39UrzpGyADVGSFV8SLTg9?=
 =?iso-8859-1?Q?4Zbo17jiz8QumpGYdVsU+L/cr6jFWYRtYXY9Rfi1gt1mN42dv2k5zg8jO/?=
 =?iso-8859-1?Q?UWIPQhC8uQ7ClbP1N0YewEbHXfnuMQyPor12IUSinBiTBSPVdk5SAKsEbP?=
 =?iso-8859-1?Q?FRURyuI4GN5bGutCaywt5++p6IzXyi3TQa3xpzbI/cJPxzqWJ4Fg5ZlfoO?=
 =?iso-8859-1?Q?QLkmdMylve77XnhUm7AsK2bJJvGeipY4a+aNoKxft8a7fQTPcb6yP84O1r?=
 =?iso-8859-1?Q?+wZEd/3/CsQrlitULz6ZM9lAMuCB/zM2gStFmZrYCE4oy9UzkMjfR2lK0z?=
 =?iso-8859-1?Q?I6wkcetzOUKDPM3SuRhHsgpfs/nzr3GsgM2rqmfPRrJo68hdvYon7UqNBe?=
 =?iso-8859-1?Q?wOwz3CHJbGN06H0mJNnsh5lUE49aPY4lfz/Mv/Z7Dcio+jz1Z9eE6aO4S8?=
 =?iso-8859-1?Q?tdhy+LWzfCGs8UUsQI4frLtoMOY7DoWROD8kymdWSFkIc/SaJgM9pop6NY?=
 =?iso-8859-1?Q?NF49N+vsdycW+llkthyonQdks8cvYm9B1BTt+nCpdbpcmipaVdpJPdxARU?=
 =?iso-8859-1?Q?dfbqnL9K9/HsJlqVj3JQJd7dStCHpa/fT361IfSlN+CSDaIR49moJQZpck?=
 =?iso-8859-1?Q?PWEtRzfTYom2/OKQ7/RGR38JzvcTXwvC7tFF1pF04J18w4ZSFOvXdd7byH?=
 =?iso-8859-1?Q?SYR7R4K8zp3+DL0/+0bgL6xbjnBnNHFVZQeM3gF8DhsM/Q62ERfXqLTKbk?=
 =?iso-8859-1?Q?hw3CPAT0SQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ba2892-15e0-483d-b6ae-08da12e1f221
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 06:44:46.4958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t+YiolKYVgxNCaFlWpzWW5tMUbFdwbl2vOGL+LVXY++aFl02Hem0gRdbhBXgxNZkHVAzF2OdExhlx96/bOnoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6058
X-Proofpoint-ORIG-GUID: XvuqsGUCxvDW5sptsMVFE5jTCm2KYmTx
X-Proofpoint-GUID: Tvh0I0Tm4V3X1B0FMoPdrDXNJ-eCVu4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_02,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310038
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Marek Vasut <marex@denx.de>
> Sent: Monday, March 28, 2022 9:53 PM
> To: linux-iio@vger.kernel.org
> Cc: Marek Vasut <marex@denx.de>; Andy Shevchenko
> <andy@kernel.org>; Daniel Baluta <daniel.baluta@nxp.com>;
> Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Subject: [PATCH v3] iio: core: Print error in case sample bits do not fit
> storage bits
>=20
> [External]
>=20
> Add runtime check to verify whether storagebits are at least as big
> as shifted realbits. This should help spot broken drivers which may
> set realbits + shift above storagebits.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> V2: Use dev_err() instead as WARN_ON() may panic() the kernel on
> existing machines
> V3: Abort probe and return -EINVAL in case this condition is triggered
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

>  drivers/iio/industrialio-buffer.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-
> buffer.c
> index b078eb2f3c9de..75a1c57b49102 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1629,6 +1629,19 @@ static int
> __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  			if (channels[i].scan_index < 0)
>  				continue;
>=20
> +			/* Verify that sample bits fit into storage */
> +			if (channels[i].scan_type.storagebits <
> +			    channels[i].scan_type.realbits +
> +			    channels[i].scan_type.shift) {
> +				dev_err(&indio_dev->dev,
> +					"Channel %d storagebits (%d) <
> shifted realbits (%d + %d)\n",
> +					i,
> channels[i].scan_type.storagebits,
> +					channels[i].scan_type.realbits,
> +					channels[i].scan_type.shift);
> +				ret =3D -EINVAL;
> +				goto error_cleanup_dynamic;
> +			}
> +
>  			ret =3D iio_buffer_add_channel_sysfs(indio_dev,
> buffer,
>  							 &channels[i]);
>  			if (ret < 0)
> --
> 2.35.1

