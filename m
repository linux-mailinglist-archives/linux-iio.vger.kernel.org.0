Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4C1AD378
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 01:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgDPXwF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 19:52:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:53982 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbgDPXwF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 19:52:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GNkumC001014
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 19:52:04 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn7uqdmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2020 19:52:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxKXT/0Is9sWfvyhvLzB6YSfOpoOHpgyg+HcmPHlErx5bkvLQtHiaZjCIUCY9YX0Ao2JcMnnZw7VtP769zxAORDKz1cuGmafJNLzNLi8xLWIOkcKbefeXXLheO+t13fS/7STlVP41ThQcBig04k4hiANOX88/A9xsnygwE/ZTScwJH2GbegZAubCiTM19BCyeIdJ0I+F83n+6mBiP+C60NIQlYUvcFSwBynVRuAUPaPW6PVjxu0zLZtlrKr4xZEmhCNtEeFTloSt6cHMT0XUVj83T6ZedBwkel4D3n2/Ur6mU4v6VZrXzePjDWopfBzaq4FoDabWnUJ9y2aotN2D/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZzY9UlKNWG/cz71fCNE4xVkRe9XKbcSKc2rKuCmpZ4=;
 b=FPvvubSfUGxH3KJnxJNKfJBOvEok8MivSfcQwlTbyddYXRrf0Ik9F7mIKUWl0SNdbMaga5CNN6FQNDnLfd9xmTmbMtO8lXTY5/D2jVEeKOegwrqzm5kq3Ck8hSFOmmGOCHWwfcukH1AvagOidqVzQDJ3qhTNWCCEq5AuIjmF1WDMwUysqT3rmidGp+cXKWmGqkTKb2M5TQY6Sz/z+lIWOAyv0PPxN3HbbScIdKaeLzEGFRV+gyHaFpmp4vYEpcKsDDDw0bXnWV61DR0HintGx2f9hCL1yFbtBCPiasJYCJoMef6Ojpk+WBMWnRZ7gGPf+3ntpsEab6Xg1ep0xTC8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZzY9UlKNWG/cz71fCNE4xVkRe9XKbcSKc2rKuCmpZ4=;
 b=TIYMJ2KZ0oJK0BRrHw1nFajxHWXDyOFuREoAsoLK/4KKqXXsYPhisEJFl4KtJgmyYrGGXR5qU6+GqVD8N9mNL+hWGP5rNOSl8mF488rUVdWgGph95Tx0b5oRgUMvI4yc3mUA7nhXg+9jZhIzRT9dZgjOTFtLPi62GZbQCTJ2ukQ=
Received: from SN6PR03MB3709.namprd03.prod.outlook.com (2603:10b6:805:4b::23)
 by SN6PR03MB4557.namprd03.prod.outlook.com (2603:10b6:805:fd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 23:52:02 +0000
Received: from SN6PR03MB3709.namprd03.prod.outlook.com
 ([fe80::794d:2a7f:cb9c:6127]) by SN6PR03MB3709.namprd03.prod.outlook.com
 ([fe80::794d:2a7f:cb9c:6127%7]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:52:02 +0000
From:   "Getz, Robin" <Robin.Getz@analog.com>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Max lengths of device names?
Thread-Topic: Max lengths of device names?
Thread-Index: AdYUSgUH8EpKecgvQdqHo//mVYDggQ==
Date:   Thu, 16 Apr 2020 23:52:01 +0000
Message-ID: <SN6PR03MB37096772490859AB2C251938E5D80@SN6PR03MB3709.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccmdldHpcYXBw?=
 =?us-ascii?Q?ZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5?=
 =?us-ascii?Q?ZTM1Ylxtc2dzXG1zZy0zZTc5NTE2Mi04MDNkLTExZWEtODdlZC00OGYxN2Zm?=
 =?us-ascii?Q?NmViZTRcYW1lLXRlc3RcM2U3OTUxNjMtODAzZC0xMWVhLTg3ZWQtNDhmMTdm?=
 =?us-ascii?Q?ZjZlYmU0Ym9keS50eHQiIHN6PSI2OTciIHQ9IjEzMjMxNTU0NzIwMjQ1OTgy?=
 =?us-ascii?Q?NiIgaD0iaWNRbElhUGJjYlNWVVFPU1lmb1IvWTZ5Z01ZPSIgaWQ9IiIgYmw9?=
 =?us-ascii?Q?IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9DQUFDeW1F?=
 =?us-ascii?Q?TUZTaFRXQVZFalVhTkRNaHpiVVNOUm8wTXlITnNEQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QVFBQkFBQUFCdXBMUmdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFRQmZB?=
 =?us-ascii?Q?SE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6QUY4QVpn?=
 =?us-ascii?Q?QmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFH?=
 =?us-ascii?Q?VUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdv?=
 =?us-ascii?Q?QVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4?=
 =?us-ascii?Q?=3D?=
x-originating-ip: [71.232.172.235]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 669873f0-f675-4948-b441-08d7e26128d8
x-ms-traffictypediagnostic: SN6PR03MB4557:
x-microsoft-antispam-prvs: <SN6PR03MB4557BFFDCDFAB1CDE5338DECE5D80@SN6PR03MB4557.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR03MB3709.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(396003)(39860400002)(136003)(346002)(366004)(2906002)(71200400001)(66556008)(478600001)(6506007)(64756008)(26005)(66446008)(66476007)(76116006)(66946007)(52536014)(316002)(6916009)(86362001)(81156014)(8936002)(186003)(55016002)(5660300002)(8676002)(9686003)(33656002)(7696005)(4744005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzPreC4DB4wGKkqhExnmsdgeEuTQUZqiCybh54EjDx898OtZz8dyB6toQrCioQfnQ4yMf97lWYwbXykfuq+DjtQAUReWmemrB1ZnGvkj29MV0jxHsWy/CouR82ywhdFpgUV7XwV4no7vsQkEMaEtksVGh7iFPcVDS0lT8O6GlyAKEUw28InD9pPzgEixSks6u0nBI9X4iXMlwVKrVvpid0OT7vX3MBmL8KyZW5nH7l/hmDSTkjAnQsonK5RYxNmlqAH55oB79/nIj2yK+5GeDic6ngNnyNzzmW35izLvvUdOG14NRF7MJA5s9/OgL+78WbpbakelKMrnQXLguNvPy0TwHV/fst7E9NYFqZXlMOdoMVRF/M5+2bFr4mcqCwkJriEtCaCFisx0bEL+98rnwBjAG480tQKTbLMFwhYCNHSZItIoq2IAI9xbltkeui5Y
x-ms-exchange-antispam-messagedata: Oq54Rbx5+Hqf72vClUjikQT6WbC8iELCUioPfWhNfgpLmH+XenynlqKi9lLy/l29tkiifQNUWICINYluaP1DX6OB7MOwai6KVqYH2/YvXb0QVTpoeUK6X2thL+7J3sTQLv3OeXDHu0F+B8WnQSUeyA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669873f0-f675-4948-b441-08d7e26128d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 23:52:01.9950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbUB0uGqEBvm1SVAag14ybKwos8oQHYWZjvnnnTgRrketT43qD3xpu5x2pe5o69dAUQNOWOfNzevB/iuZCTV2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_10:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=707
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160163
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I was looking at trying to make some userspace code a little more robust, a=
nd needed to understand the potential size of things behind sysfs.

For example, I would think that would be a "max length of the string that r=
epresents the device name".

But I couldn't find anything...

I understand that some of the names are encoded in the sysfs file name, and=
 therefor are NAME_MAX worse case, but things like device name have no such=
 limit. It's not practical/useful that they are PAGE_SIZE (does anyone need=
 a 4k name?) but right now - I think that might be the limit (unless I'm mi=
ssing something).

Any pointers?

Thanks
Robin
