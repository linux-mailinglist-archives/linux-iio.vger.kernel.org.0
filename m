Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D452363C79
	for <lists+linux-iio@lfdr.de>; Mon, 19 Apr 2021 09:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbhDSHax (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Apr 2021 03:30:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:19682 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232023AbhDSHaw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Apr 2021 03:30:52 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J7TaR0025598;
        Mon, 19 Apr 2021 03:30:10 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0b-00128a01.pphosted.com with ESMTP id 37yseccbv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 03:30:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBxaOlrga/M3J9F0rnDaLdoGT0Oe0J6Lh9JqUw+bowtUHv5prT9rzepfTR8DER9SbbrgmcaQPZ27c81HQSzKO+AqnRL3OH+vUKTxWZna6z4tElUhHPKoLOdhiYKCAuHaEwUc3AY36AeramxbN1maLqHQ0aP9+uozqN9SlHqMDJSmQnC1nL6TeS3FAftnY8ANat0hOjx1ECYopAN0athB7+L4SeW+w1V81lhPrr2crUKRvKxKGOuYXD4pA+PBjjzhhIuuc1cACkkX6zEMMgjKk3s6e5F+UQMaMKp8Jnt0AarQC5rSnIO+xa2Hmms8VriqZGVJfyB5AzORZ1VCokIa7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa2LEio8n0n2qOvEHNTHh6IQKLVEzhz8llHrET5E2iU=;
 b=ZwnC7oAhW5ovaz4h6asQlL6ihBAfuNVeu8I33jxzQJZW9qIFfeQAMdzkEeHManAA9L4zdMUYmcQMrrL16GCL4XSiDa93k2lSUZH7jPam0OTQMnYY14UAOAcvPAZesY6vSUkrTqULY/4QSTVmNbXdm1LasuBEWoskj6qA/mB3xKRH7bgz+rMlx4Uad2DDb3g8lEl/ZpXdsmC1/HAckyOCZmWeb3BZSfcfPVyoSVlgresaaqZY9BQakgvyupfVk6Emezrx/nnpdircX3H4VLL81kM9wtw/hwWXnTwcDU3DU1a/3JdhF7G8O3Hr4gB0i+YpB+pX+nKaBphKM9UHWTCwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa2LEio8n0n2qOvEHNTHh6IQKLVEzhz8llHrET5E2iU=;
 b=XU+nOS1ZghTa5Z+ALw6qyIPo56bH3UMC+DdIpFrn35DMFnT+TNUtuqwBetvS6K1AYk0xNJrCyMNJV6sBut3+VKk2wluOpCa678lR9pZyWk6LRWh6nlAegBTqDtOcjuM+GWsA+RdC6nhPmEhMqbR6tr944z0/CEJ04ZsUJG1hw3o=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY4PR03MB2472.namprd03.prod.outlook.com (2603:10b6:903:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Mon, 19 Apr
 2021 07:30:07 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 07:30:07 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v3] iio: adis16480: support burst read function
Thread-Topic: [PATCH v3] iio: adis16480: support burst read function
Thread-Index: AQHXMEcIiDuRHQI5dUOcHVmanDyP5Kq6ELWAgAFqFUA=
Date:   Mon, 19 Apr 2021 07:30:07 +0000
Message-ID: <CY4PR03MB311238E89F7B05A6124600B599499@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210413092815.28626-1-nuno.sa@analog.com>
 <20210418105307.67fad41e@jic23-huawei>
In-Reply-To: <20210418105307.67fad41e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMGYwNDBkZWEtYTBlMS0xMWViLThiM2MtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDBmMDQwZGVjLWEwZTEtMTFlYi04YjNjLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTQwNiIgdD0iMTMyNjMyOTEwMD?=
 =?iso-8859-1?Q?U1MzA1MDQ1IiBoPSJhQjhlN0UzR0U4cHpxQkdRcDUvU1cxT2tmNU09IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJWYjEvUjdUVFhBY3l3S0w1c205SnF6TEFvdm15YjBtb0ZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQWJKUFNkUUFBQUFBQUFBQUFBQUFBQUo0?=
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
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCaEFISUFhUUJoQUY4QVpBQn?=
 =?iso-8859-1?Q?BBR01BZEFCcEFHOEFiZ0JoQUhJQWVRQmZBSFFBYVFCbEFISUFNUUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBY2dCcEFHRUFYd0JrQUdrQVl3QjBB?=
 =?iso-8859-1?Q?R2tBYndCdUFHRUFjZ0I1QUY4QWRBQnBBR1VBY2dBeUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?iso-8859-1?Q?Q0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [2001:a61:25ab:ca01:b4b4:5ede:e2f0:4573]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d413f441-b10d-4993-e30f-08d90304f507
x-ms-traffictypediagnostic: CY4PR03MB2472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB2472D5B2E8CB365BD6C5487A99499@CY4PR03MB2472.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mH3/8cDCAtG8WlJiT5NPb5Yt8i5XqkIC9Tcn7GsvWUek/hM+WOE84o8Rad8//nZ+cuSIyhhpf/kG4dpUaGWscd0fIOK4gVLqblWB3a1vYO+h6RhyPM83+DEFC+sYrAIPJ8hZUV94Bz7rsfPkQwuujeO0mRgyG3uTtZxRs+095v0bVMcmpnGPg0FFz36TVnTvxvhgj5AeUpiDx6TFQ2eci4mYNMuicZMbTwrdTj8zgLlVVMeQD6YPkEKwFErDojLOTdO+PW/T3IK4chBXhy/cv/QxSfFDujCvuLGJgFXIlHt2QjVnxARHdX2JApYJm21xKwNjo4KLOIqQHpozS49HDgW+6IB3Fby+EXGdbNWaueLXdNqTranq81i/pUUtcPJcPj4sIkcjTkCR3yJABS27HbtvCpE3DWhfUahhJrBfz+5sMmywu3ecpFyy1M+D7o3b+T+E8cItZ/AmxBVKV/kbnazR3sKcKaPHVxWLlB/EUK9xVoQNvAeTZHv7s8GUdgxc2UBb8FBy4HJw97cwkFrW6VLR7ybEsxoRlBIf6KdhCdqTdAK+VuJ5CBdy8DFiKDsnA7LO/rX+H5OcloAgYneclhLN/iY7H+Kw9ltKSRrpQQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(4326008)(83380400001)(8676002)(86362001)(122000001)(38100700002)(6506007)(8936002)(6916009)(53546011)(55016002)(9686003)(186003)(66446008)(66476007)(66556008)(71200400001)(76116006)(7696005)(2906002)(54906003)(52536014)(33656002)(5660300002)(478600001)(316002)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yUR4z3bmI+sueDsGPgNZu17u9ZglCMMUqRVcsj5Klc4ltdkWgdJt5eEevS?=
 =?iso-8859-1?Q?TyFXwWWG6p/b126Q2PiZK6g5PEuVpEH9xhJxiUT+Vguvd3oKka48U059Dp?=
 =?iso-8859-1?Q?ZyQ/LQtaV4lAfEu85VstpzAKeqXo2mjdkVPyJiT9L832T+GqHlrw9nB0+7?=
 =?iso-8859-1?Q?u4mCYk4q0m3WF6R+zL/V2mdAISxGaseZ3daefwJPBNNSAVdwpQLcbtqJYt?=
 =?iso-8859-1?Q?Vj4MBzSQPLuVCZsK0xPhtGGjA/9c64CT03lLn9pPbkoHCadiwvtqV2tDGG?=
 =?iso-8859-1?Q?lb7zmEvXJxTGBCr+pgXR8/yweqpiHx+d4wxR63wmrGTmmDATj3DCHWUo16?=
 =?iso-8859-1?Q?Ac3PSbmzIximvnY2mQa0BlbPWordKnVxixAiSCXJx4bDQv046WtgLshCI3?=
 =?iso-8859-1?Q?fvXUsJdwi6Pn3xB4M4foThq0MCprMbGPOX1eCJDJFr3Uc2NhQxLwHHEklE?=
 =?iso-8859-1?Q?+nh5FwJQ++Z61NY/OHf3TYphExiU0CDpc3TBQYfL7gm3qZul2zuZn5dNyv?=
 =?iso-8859-1?Q?4wcynMCSrwwnywuQxz0YM4JTW/rRTQy+zjtF51iLCAM0N4xrnbXN8Zb1kA?=
 =?iso-8859-1?Q?QThfYTefOJgpbRNewERSRjmZqA/rTu9TCzsFQfZEZ8zBtf0cdzSjQdu/2M?=
 =?iso-8859-1?Q?dze59uYkbhMGK9loleAoQkPijYX/s3ufVHQeR7l29RLTzke8BhcFtVTb7t?=
 =?iso-8859-1?Q?pstozl2Iif40tEQrDdA+WiMxlEkHCESQkrGdIdhYzCJ3mziSj1V28EnQh2?=
 =?iso-8859-1?Q?Zp6/2dzK7uK3Qz+ymkarrEL9CJoq9WQDzG+CHOlIyb76XzRxmljlodzI3d?=
 =?iso-8859-1?Q?ByVkhNHEAMpY6SbM4/Y8mGx8IASx2DlYoyEZjzvJeX8K0Tjdg+kR4MbABu?=
 =?iso-8859-1?Q?uybbIQY5yc3wIOrZ8j7Q03v42HuWxWi/+jWJGU1I40qqRaPjfpWKsakcjZ?=
 =?iso-8859-1?Q?6HainBNlMFY6LyM8Xqd5K0WJq3vfqLDt0STtcD/FUg6MobvuF9AJfy0Gxk?=
 =?iso-8859-1?Q?ww27ioG5+p4sYt/M2hWfSrCf+/5oRjJQJ2dtRiwPxhbutu/d0VRjbZDDeW?=
 =?iso-8859-1?Q?90cODXGhvVTDYRb5JNbDQq5hyEruTmPyTtFo7KwMN8yA/1mt4DDKoV3OE4?=
 =?iso-8859-1?Q?i42xUhFf7TbztQDPM/Ybeqv9fDiWnbdyqznNi277b6A+dc6OgMDEcF5wgD?=
 =?iso-8859-1?Q?9+pCyosZpz8j9wMsG27ORLStLK/nzOJq4Vr7IT8nLKob+TayTBqxjgb2OA?=
 =?iso-8859-1?Q?NPSDtiPIY2sgV//s/8XZB6BhkrdmruZnQnlz3NrBgz2F1WEoK8zYYoGpOT?=
 =?iso-8859-1?Q?nOTH6O/VPZ+z5xoQ5x+2+QHBulLAzdGk/TgT8Xja46Sqv66TAVwib81Z1A?=
 =?iso-8859-1?Q?1nR7LQIi142V9ulcxvVIOM37uK5Dn/2w+O9kcuQkV09PAYTuH0EqbzQKcV?=
 =?iso-8859-1?Q?UHlMTYlJnfo4o0SZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d413f441-b10d-4993-e30f-08d90304f507
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:30:07.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGqaX56EOGelpkm2lMIma2Ww9sn0zvrJrKx3BQp4W4qcQpCxloDyCoy/YTN7Nmv3qHPPf0vPltkoX7korKP2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2472
X-Proofpoint-ORIG-GUID: 1iJ5AikwsqBdLwwXlz-n3fnGSwYjTwkC
X-Proofpoint-GUID: 1iJ5AikwsqBdLwwXlz-n3fnGSwYjTwkC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_02:2021-04-16,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190050
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 18, 2021 11:53 AM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: linux-iio@vger.kernel.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: Re: [PATCH v3] iio: adis16480: support burst read function
>=20
> [External]
>=20
> On Tue, 13 Apr 2021 11:28:14 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Some supported devices support burst read function. This provides a
> method
> > for reading a batch of data (status, temperature, gyroscopes,
> > accelerometers, time stamp/data counter, and CRC code), which
> does not
> > require a stall time between each 16-bit segment and only requires
> one
> > command on the DIN line to initiate. Devices supporting this mode
> > are:
> >
> >  * adis16495-1
> >  * adis16495-2
> >  * adis16495-3
> >  * adis16497-1
> >  * adis16497-2
> >  * adis16497-3
> >
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> Applied and I've added the tag Lars gave for v2.
> If you intentionally drop someones tag, please call out why alongside
> your change log.  Here the tweaks were fairly minor so I don't think
> there was any need to drop it.

Ups, sorry. Completely unintencional...

- Nuno S=E1
