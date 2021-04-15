Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CD5360E40
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbhDOPNB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 11:13:01 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31626 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234775AbhDOPLA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Apr 2021 11:11:00 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13FEwYSY018403;
        Thu, 15 Apr 2021 11:10:31 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-00128a01.pphosted.com with ESMTP id 37xky9ru9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Apr 2021 11:10:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go0cOOcT+saz8VsC5oWjlqzdgJ/t0Rl9gRd0waFjx8RUzbNsvks85JdLXU5WG3djbQgZTR4sEiYtbQ3ogEWD5jGLSjZxXaaHqjN6YvjGOqT+C7gUcbZwuRCGReUgGF4/6Of5/2oYQOVdTIah6eWo6VhuGYxbcSjE99InErTP4n6JPSQJQyix29OvkNeOQwtBe1pENWlstxJ0zGIMea/lQDlfKXJmyQUVDuSAqFvS0tw7WexNjFO6pXXRY6ygUPHKiwaMzVF3U4xDiq10YpTlV6fqiLmUN4i2EedXhX0ZsVZe+iH3ns+Sb807TBFrf/oMNkjJP/EMZAEr2GUPYYM5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSVJKWN4179r9z32Atw0fLtlrnLkkxyZlu2+FtgYDWg=;
 b=mEIzXPzaAQKhMTpm/OiyMSW0UcQ8GFF01iF1awUnflXoZ+NqZUH/H3fPtUB1fp6cI/UWy/EvONuEW0oBwspFX+sir8e1rWbwzneoe6jkQqcP8xSGMvnkv00R6oENevVHqhywH1OfsNplSlpr93jPbBISi61wQXk8MruAd7Lt4dbAAGQAMhtEmkOpEJvhr2Y5N4wswlr8uH/6+yJ8WAEy2NlLwNWOFtaqO+PSDQojQ9MqphND9Wbyl/9Gett7i1DNME0GvYhPmkCY2JnbRIZrroQLn0f1M3nPVEHsbxWoh2/1rVfa3HiNoAZ4tN6zOsYlAW/tby3EkZoGYRixETdfyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSVJKWN4179r9z32Atw0fLtlrnLkkxyZlu2+FtgYDWg=;
 b=b2942mg2CBCDgkAWzGdAYZRvuSfBy6C2CIsPeHbqd3kShzcsbHECJ+28+zt8ysKynsta43nMQfPPvcDGCAd3zS3W8ELxg/OC4Ljl5eZItx0P1qQXk2nJugqafKTiQ8Ym+nxvR4TzSPi4wNdb8P+oR08QqofhFC94xAs2nKnKCzg=
Received: from CY4PR03MB3112.namprd03.prod.outlook.com (2603:10b6:910:53::25)
 by CY1PR03MB2313.namprd03.prod.outlook.com (2a01:111:e400:c612::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Thu, 15 Apr
 2021 15:10:27 +0000
Received: from CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24]) by CY4PR03MB3112.namprd03.prod.outlook.com
 ([fe80::4da5:ed3c:b627:2a24%6]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 15:10:26 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Sean Nyekjaer <sean@geanix.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RFC PATCH 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
Thread-Topic: [RFC PATCH 1/2] iio: accel: add support for
 FXLS8962AF/FXLS8964AF accelerometers
Thread-Index: AQHXMe48BgOnzTPNVkKybkvDFYrEQKq1qp9w
Date:   Thu, 15 Apr 2021 15:10:26 +0000
Message-ID: <CY4PR03MB31127BA6AD9A0F7DCF295ED0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
References: <20210415114614.1071928-1-sean@geanix.com>
In-Reply-To: <20210415114614.1071928-1-sean@geanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcGRh?=
 =?us-ascii?Q?dGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUz?=
 =?us-ascii?Q?NWJcbXNnc1xtc2ctYjM1ZWY5NGEtOWRmYy0xMWViLThiM2EtZTRiOTdhN2Nj?=
 =?us-ascii?Q?NzEwXGFtZS10ZXN0XGIzNWVmOTRiLTlkZmMtMTFlYi04YjNhLWU0Yjk3YTdj?=
 =?us-ascii?Q?YzcxMGJvZHkudHh0IiBzej0iMjg0MTkiIHQ9IjEzMjYyOTczMDI0NTk4NjI0?=
 =?us-ascii?Q?NyIgaD0iUXBrSEZGM2VLMTdmTkFrS1FmeitVUEo1MnM4PSIgaWQ9IiIgYmw9?=
 =?us-ascii?Q?IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSVlEQUFESHgv?=
 =?us-ascii?Q?ZDFDVExYQWVGdEdkSDUraXVoNFcwWjBmbjZLNkVGQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUhBQUFBQVdBd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QVFBQkFBQUFiSlBTZFFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQWFRQmZB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmhBSElBYVFC?=
 =?us-ascii?Q?aEFGOEFaQUJwQUdNQWRBQnBBRzhBYmdCaEFISUFlUUJmQUhRQWFRQmxBSElB?=
 =?us-ascii?Q?TVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQWNnQnBBR0VBWHdCa0FHa0FZd0Iw?=
 =?us-ascii?Q?QUdrQWJ3QnVBR0VBY2dCNUFGOEFkQUJwQUdVQWNnQXlBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFBPSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
authentication-results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3e3e8ad-d642-44f1-7c3f-08d9002099cf
x-ms-traffictypediagnostic: CY1PR03MB2313:
x-microsoft-antispam-prvs: <CY1PR03MB231336F3D15E682C9FC7013F994D9@CY1PR03MB2313.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOoo9ocs/QGBSR70bN2vXeUkaxzhXPwjcq2JzvPWV73tYqwFzRFnIObW85Aw64pnFshCLCEf18HokhUrbbU1qiu2q32SC2NEyWCDdMyNs5LCib8pT6sO1ME7QQvAesiLI3xJ1qIyCBAUrtcLGkOZWjFqRDRqPiYN3r14KqZxX9YVw84jgcsjBVgBmRfjaA8hzop58tGka9PsAmXVt5f7YhtERAahO2pkPJIS9hw3Ugs22ZqDWNdg4EZV7b81Xy14SvBtkl3jr6cojtjYHPTkzUBoFQsm9hmLHPyaBDo90roepwPU8wdmWjdLSZosLE53OAjfTQmRTNOI9D6kggUSRJzu7mNccgukf02ra8Zcz+urOIbA29fUP770BkSTLFu7EmigjLAVGNqWpa61yG9ovIjW3XI+vS1OtO9bbNQAu29dB6Ppguhk/509X05Udve/WOklFkkPomUygZH+yCNdpOW4KAwMVJUJzQ8MO6D5M9loZ5Pews3qQOm2SWw1IIDhLFb3kohxNUeOHJF7P5JZbiPRiTU5gbi3OEGP6oeWwygwLaXIqvknvMajDyRVCcjU042tcyk0fq2XH5A0r8quRdNUTVIEcDLF5qB/a885ais=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3112.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(478600001)(8936002)(52536014)(71200400001)(5660300002)(30864003)(26005)(186003)(33656002)(66556008)(76116006)(66946007)(38100700002)(83380400001)(9686003)(110136005)(66476007)(86362001)(7696005)(66446008)(8676002)(64756008)(2906002)(55016002)(122000001)(6506007)(316002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2MQfRA2gGcnpfAUS9gM5pKRtJlo/zPD1VMfDxQ4/+m91ZcZLdMxlTMklLZRe?=
 =?us-ascii?Q?u7nUN1KmEtv6zgdlCJWsXJe5AAZpSSaQkGdLY+j4JUxBCZgPnzSerewLExKC?=
 =?us-ascii?Q?YZ1fZQJ54eIAElaKkJiipmNuhR/fuSpHkIHlEhgiGVDCyk45OFoSMduUSu2M?=
 =?us-ascii?Q?hEvH1OR1WKs69quTbYmLqoxgCflYyuiyhC5jSjkBM+1DUOIBU0ySDa13W6zL?=
 =?us-ascii?Q?rWJ8as/G2nfemey2gNHXegq6wL8n2SIS+Q7tStM0e1FEUU8m0JLbZumL1cp7?=
 =?us-ascii?Q?3I5/jI0ap+IIpR8UtgEUexK4ReLHtnU50xqlD6/XQURVXz2L1tWjtRa4e7Nb?=
 =?us-ascii?Q?sYBQ7C+wOM9IzwVdkL2WZdvugKUIp3lYujOeTjdrTHNBcDUak3Y4ofPGIt1r?=
 =?us-ascii?Q?weSMUG4HPtY/l3eX4ZY0TEiEceDl7KfqYRhCQLWwHFNXpTtMu3H9skyXFXr7?=
 =?us-ascii?Q?1h6O5DFxK9azCPAoJkicZWALh9aYc9UDEbzo9E7toRnZ/Bcnc35DF394VDF2?=
 =?us-ascii?Q?OaAECwrMWiwAiVPZu19iThzjKSitgIZZuQmdwkUmCd874p9aiJd8oKh0Th1p?=
 =?us-ascii?Q?BFlARmnuI8TkmyZUUkpgOu8JTza+nAsFvH7tStLCpg0CWkGzrD8rs971XT5W?=
 =?us-ascii?Q?kc/+nXU200RlUACwLngpCNO3t4IjLWy/ApKim/etvUlKw8S7Q8XcDineNt+X?=
 =?us-ascii?Q?3wZBmK+t8GS5bKXkBZj7LzszjNdFUu2iRanYRxbebta9psPTvBHmF9O8Wodj?=
 =?us-ascii?Q?DOQ84NmEN+fDMVStxyDZV+zhig+9qyd8JKB2jcK8eOyvsEnj1g8J+Ge7TnMj?=
 =?us-ascii?Q?/eYhoK4tZottCSgwLJH5FgoTS3XXDLV28daDRroWDw3M3WCAUnczPtiLEj8f?=
 =?us-ascii?Q?f+Ltrrb+GaOGVztfOW6o+LA14/d2J3rAv/s9IkMpIXDu5sjlCVR6DVdFeDMb?=
 =?us-ascii?Q?pEeVIErQize1A5LZngItnl7b7+Y/85SllPIHBobIa9wunOPyfFO+45zivCV7?=
 =?us-ascii?Q?cHjmQ2gCestpJWCGgsdrbfjkENwCilnUk7Z/piPDHTFQtzYV6yAj2kcPkOTF?=
 =?us-ascii?Q?E0KxlF1++rD0LsPng3O1JhtOJ2i01JgumiFgAfT9+rYpf/X7rgue2yuRU0rN?=
 =?us-ascii?Q?Q64pPdtDYb/CpNY4K/qvoalXUcr/mNCWoKOrqLbuPkhxtZq7hVbxcCRX1NBO?=
 =?us-ascii?Q?J6PVwdzl+GO7BI7qqLzxZi6CIrDRsxax1lSroEYZBRJMaNs83TfLSvRMrk8H?=
 =?us-ascii?Q?k4BrbYXvayeXJc06RXPiMNgnEt44T+IVs1fAeZtH+LdKuwT5WAviTzPj+JqW?=
 =?us-ascii?Q?f0DAWSyEuoxG298GRGV37SgB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3112.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e3e8ad-d642-44f1-7c3f-08d9002099cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 15:10:26.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7yHPx0ZbPTjN9Fg1Kcj1yhhEI787LIMA/YCgnt7iIgBiKUTTiLgaSlXgscigeViH1WBVVuJKWRaEGDsxaiu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2313
X-Proofpoint-GUID: YzQy4pK77W5cDhkU8_WghGFH58I38t78
X-Proofpoint-ORIG-GUID: YzQy4pK77W5cDhkU8_WghGFH58I38t78
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_06:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150098
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Thanks for this. Lars already pointed out most of it. Just adding few more.=
..

>  drivers/iio/accel/Kconfig           |  22 +
>  drivers/iio/accel/Makefile          |   4 +
>  drivers/iio/accel/fxls8962af-core.c | 739
> ++++++++++++++++++++++++++++
>  drivers/iio/accel/fxls8962af-i2c.c  |  67 +++
>  drivers/iio/accel/fxls8962af-spi.c  |  72 +++
>  drivers/iio/accel/fxls8962af.h      |  21 +
>  6 files changed, 925 insertions(+)
>  create mode 100644 drivers/iio/accel/fxls8962af-core.c
>  create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
>  create mode 100644 drivers/iio/accel/fxls8962af-spi.c
>  create mode 100644 drivers/iio/accel/fxls8962af.h
>=20
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 2e0c62c39155..c4b42024de42 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -370,6 +370,28 @@ config MMA8452
>  	  To compile this driver as a module, choose M here: the
> module
>  	  will be called mma8452.
>=20
> +config FXLS8962AF
> +	tristate "NXP FXLS8962AF and similar Accelerometers Driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	select REGMAP
> +	select FXLS8962AF_I2C if I2C
> +	select FXLS8962AF_SPI if SPI
> +	help
> +	  Say yes here to build support for the NXP 3-axis automotive
> +	  accelerometer FXLS8962AF/FXLS8964AF.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called fxls8962af.
> +
> +config FXLS8962AF_I2C
> +	tristate
> +	select REGMAP_I2C
> +
> +config FXLS8962AF_SPI
> +	tristate
> +	select REGMAP_SPI
> +
>  config MMA9551_CORE
>  	tristate
>=20
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 4f6c1ebe13b0..3e48a9127863 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -40,6 +40,10 @@ obj-$(CONFIG_MMA7660)	+=3D mma7660.o
>=20
>  obj-$(CONFIG_MMA8452)	+=3D mma8452.o
>=20
> +obj-$(CONFIG_FXLS8962AF)	+=3D fxls8962af-core.o
> +obj-$(CONFIG_FXLS8962AF_I2C)	+=3D fxls8962af-i2c.o
> +obj-$(CONFIG_FXLS8962AF_SPI)	+=3D fxls8962af-spi.o
> +
>  obj-$(CONFIG_MMA9551_CORE)	+=3D mma9551_core.o
>  obj-$(CONFIG_MMA9551)		+=3D mma9551.o
>  obj-$(CONFIG_MMA9553)		+=3D mma9553.o
> diff --git a/drivers/iio/accel/fxls8962af-core.c
> b/drivers/iio/accel/fxls8962af-core.c
> new file mode 100644
> index 000000000000..daee5b07ca49
> --- /dev/null
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -0,0 +1,739 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Connected Cars A/S
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/delay.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/regmap.h>
> +
> +#include "fxls8962af.h"
> +
> +#define FXLS8962AF_INT_STATUS			0x00
> +#define FXLS8962AF_INT_STATUS_SRC_DRDY		BIT(7)
> +#define FXLS8962AF_TEMP_OUT			0x01
> +#define FXLS8962AF_VECM_LSB			0x02
> +#define FXLS8962AF_OUT_X_LSB			0x04
> +#define FXLS8962AF_OUT_Y_LSB			0x06
> +#define FXLS8962AF_OUT_Z_LSB			0x08
> +#define FXLS8962AF_BUF_STATUS			0x0b
> +#define FXLS8962AF_BUF_X_LSB			0x0c
> +#define FXLS8962AF_BUF_Y_LSB			0x0e
> +#define FXLS8962AF_BUF_Z_LSB			0x10
> +
> +#define FXLS8962AF_PROD_REV			0x12
> +#define FXLS8962AF_WHO_AM_I			0x13
> +
> +#define FXLS8962AF_SYS_MODE			0x14
> +#define FXLS8962AF_SENS_CONFIG1			0x15
> +#define FXLS8962AF_SENS_CONFIG1_ACTIVE		BIT(0)
> +#define FXLS8962AF_SENS_CONFIG1_RST		BIT(7)
> +#define FXLS8962AF_FSR_2G			0x0
> +#define FXLS8962AF_FSR_4G			0x2
> +#define FXLS8962AF_FSR_8G			0x4
> +#define FXLS8962AF_FSR_16G			0x6
> +#define FXLS8962AF_FSR_MASK			(BIT(2) | BIT(1))
> +
> +#define FXLS8962AF_SENS_CONFIG2			0x16
> +#define FXLS8962AF_SENS_CONFIG3			0x17
> +#define FXLS8962AF_SENS_CONFIG4			0x18
> +#define FXLS8962AF_SENS_CONFIG5			0x19
> +
> +#define FXLS8962AF_WAKE_IDLE_LSB		0x1b
> +#define FXLS8962AF_SLEEP_IDLE_LSB		0x1c
> +#define FXLS8962AF_ASLP_COUNT_LSB		0x1e
> +
> +#define FXLS8962AF_INT_EN			0x20
> +#define FXLS8962AF_INT_PIN_SEL			0x21
> +
> +#define FXLS8962AF_OFF_X			0x22
> +#define FXLS8962AF_OFF_Y			0x23
> +#define FXLS8962AF_OFF_Z			0x24
> +
> +#define FXLS8962AF_BUF_CONFIG1			0x26
> +#define FXLS8962AF_BUF_CONFIG2			0x27
> +
> +#define FXLS8962AF_ORIENT_STATUS		0x28
> +#define FXLS8962AF_ORIENT_CONFIG		0x29
> +#define FXLS8962AF_ORIENT_DBCOUNT		0x2a
> +#define FXLS8962AF_ORIENT_BF_ZCOMP		0x2b
> +#define FXLS8962AF_ORIENT_THS_REG		0x2c
> +
> +#define FXLS8962AF_SDCD_INT_SRC1		0x2d
> +#define FXLS8962AF_SDCD_INT_SRC2		0x2e
> +#define FXLS8962AF_SDCD_CONFIG1			0x2f
> +#define FXLS8962AF_SDCD_CONFIG2			0x30
> +#define FXLS8962AF_SDCD_OT_DBCNT		0x31
> +#define FXLS8962AF_SDCD_WT_DBCNT		0x32
> +#define FXLS8962AF_SDCD_LTHS_LSB		0x33
> +#define FXLS8962AF_SDCD_UTHS_LSB		0x35
> +
> +#define FXLS8962AF_SELF_TEST_CONFIG1		0x37
> +#define FXLS8962AF_SELF_TEST_CONFIG2		0x38
> +
> +#define FXLS8962AF_MAX_REG			0x38
> +
> +#define FXLS8962AF_DEVICE_ID			0x62
> +#define FXLS8964AF_DEVICE_ID			0x84
> +
> +#define FXLS8962AF_TEMP_CENTER_VAL		25
> +
> +#define FXLS8962AF_AXIS_TO_REG(axis)
> 	(FXLS8962AF_BUF_X_LSB + (axis * 2))
> +#define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
> +
> +#define FXLS8962AF_SCALE_TABLE_LEN		4
> +
> +struct fxls8962af_scale_info {
> +	unsigned int scale;
> +	u8 reg_value;
> +};
> +
> +struct fxls8962af_chip_info {
> +	u8 chip_id;
> +	const struct iio_chan_spec *channels;
> +	int num_channels;
> +	const struct fxls8962af_scale_info
> +	    scale_table[FXLS8962AF_SCALE_TABLE_LEN];
> +	int all_events;
> +	int enabled_events;
> +};
> +
> +struct fxls8962af_data {
> +	struct regmap *regmap;
> +	struct mutex lock;
> +	const struct fxls8962af_chip_info *chip_info;
> +	struct regulator *vdd_reg;
> +	struct iio_mount_matrix orientation;
> +};
> +
> +const struct regmap_config fxls8962af_regmap_conf =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D FXLS8962AF_MAX_REG,
> +};
> +EXPORT_SYMBOL_GPL(fxls8962af_regmap_conf);
> +
> +enum {
> +	idx_x,
> +	idx_y,
> +	idx_z,
> +	idx_ts,
> +};
> +
> +static int fxls8962af_drdy(struct fxls8962af_data *data)
> +{
> +	int tries =3D 150, ret;
> +	unsigned int reg;
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +
> +	while (tries-- > 0) {
> +		ret =3D regmap_read(data->regmap,
> FXLS8962AF_INT_STATUS, &reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if ((reg & FXLS8962AF_INT_STATUS_SRC_DRDY) =3D=3D
> +		    FXLS8962AF_INT_STATUS_SRC_DRDY)
> +			return 0;
> +
> +		msleep(20);
> +	}
> +
> +	dev_err(dev, "data not ready\n");
> +
> +	return -EIO;
> +}
> +
> +static int fxls8962af_set_power_state(struct fxls8962af_data *data,
> bool on)
> +{
> +#ifdef CONFIG_PM
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +	int ret;
> +
> +	if (on) {
> +		ret =3D pm_runtime_get_sync(dev);
> +	} else {
> +		pm_runtime_mark_last_busy(dev);
> +		ret =3D pm_runtime_put_autosuspend(dev);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(dev, "failed to change power state to %d\n",
> on);
> +		if (on)
> +			pm_runtime_put_noidle(dev);
> +
> +		return ret;
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
> +static int fxls8962af_get_temp(struct fxls8962af_data *data, int *val)
> +{
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +	int ret;
> +	unsigned int value;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret =3D fxls8962af_drdy(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret =3D fxls8962af_set_power_state(data, true);
> +	if (ret) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_read(data->regmap, FXLS8962AF_TEMP_OUT,
> &value);
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading reg_temp\n");
> +		fxls8962af_set_power_state(data, false);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret =3D fxls8962af_set_power_state(data, false);
> +
> +	*val =3D sign_extend32(value, 7);
> +
> +	mutex_unlock(&data->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int fxls8962af_get_axis(struct fxls8962af_data *data,
> +			       struct iio_chan_spec const *chan, int *val)
> +{
> +	struct device *dev =3D regmap_get_device(data->regmap);
> +	int axis =3D chan->scan_index;
> +	int ret;
> +	__le16 raw_val;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret =3D fxls8962af_drdy(data);
> +	if (ret < 0) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret =3D fxls8962af_set_power_state(data, true);
> +	if (ret) {
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_bulk_read(data->regmap,
> FXLS8962AF_AXIS_TO_REG(axis),
> +			       &raw_val, sizeof(raw_val));
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read axes\n");
> +		fxls8962af_set_power_state(data, false);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	}
> +
> +	ret =3D fxls8962af_set_power_state(data, false);
> +
> +	mutex_unlock(&data->lock);
> +	*val =3D sign_extend32(le16_to_cpu(raw_val),
> +			     chan->scan_type.realbits - 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static ssize_t fxls8962af_show_scale_avail(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +	int i, len =3D 0;
> +
> +	for (i =3D 0; i < FXLS8962AF_SCALE_TABLE_LEN; i++)
> +		len +=3D scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> +				 data->chip_info->scale_table[i].scale);
> +
> +	buf[len - 1] =3D '\n';
> +
> +	return len;
> +}
> +
> +static int fxls8962af_write_raw_get_fmt(struct iio_dev *indio_dev,
> +					struct iio_chan_spec const
> *chan,
> +					long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +}
> +
> +static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
> +		       fxls8962af_show_scale_avail, NULL, 0);
> +
> +static int fxls8962af_standby(struct fxls8962af_data *data)
> +{
> +	return regmap_update_bits(data->regmap,
> FXLS8962AF_SENS_CONFIG1,
> +				  FXLS8962AF_SENS_CONFIG1_ACTIVE,
> 0);
> +}
> +
> +static int fxls8962af_active(struct fxls8962af_data *data)
> +{
> +	return regmap_update_bits(data->regmap,
> FXLS8962AF_SENS_CONFIG1,
> +				  FXLS8962AF_SENS_CONFIG1_ACTIVE,
> 1);
> +}
> +
> +/* returns >0 if active, 0 if in standby and <0 on error */
> +static int fxls8962af_is_active(struct fxls8962af_data *data)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret =3D regmap_read(data->regmap,
> FXLS8962AF_SENS_CONFIG1, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return reg & FXLS8962AF_SENS_CONFIG1_ACTIVE;
> +}
> +
> +static int fxls8962af_update_config(struct fxls8962af_data *data, u8
> reg,
> +				    u8 mask, u8 val)
> +{
> +	int ret;
> +	int is_active;
> +
> +	mutex_lock(&data->lock);
> +
> +	is_active =3D fxls8962af_is_active(data);
> +	if (is_active < 0) {
> +		ret =3D is_active;
> +		goto fail;
> +	}
> +
> +	/* config can only be changed when in standby */
> +	if (is_active > 0) {
> +		ret =3D fxls8962af_standby(data);
> +		if (ret < 0)
> +			goto fail;
> +	}
> +
> +	ret =3D regmap_update_bits(data->regmap, reg, mask, val);
> +	if (ret < 0)
> +		goto fail;
> +
> +	if (is_active > 0) {
> +		ret =3D fxls8962af_active(data);
> +		if (ret < 0)
> +			goto fail;
> +	}
> +
> +	ret =3D 0;
> + fail:
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
> +static int fxls8962af_set_full_scale(struct fxls8962af_data *data, u32
> scale)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < FXLS8962AF_SCALE_TABLE_LEN; i++) {
> +		if (data->chip_info->scale_table[i].scale =3D=3D scale)
> +			break;
> +	}
> +
> +	if (i =3D=3D FXLS8962AF_SCALE_TABLE_LEN)
> +		return -EINVAL;
> +
> +	return fxls8962af_update_config(data,
> FXLS8962AF_SENS_CONFIG1,
> +					FXLS8962AF_FSR_MASK,
> +					data->chip_info-
> >scale_table[i].reg_value);
> +}
> +
> +static unsigned int fxls8962af_read_full_scale(struct fxls8962af_data
> *data,
> +					       int *val)
> +{
> +	int i, ret;
> +	unsigned int reg;
> +
> +	ret =3D regmap_read(data->regmap,
> FXLS8962AF_SENS_CONFIG1, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg &=3D FXLS8962AF_FSR_MASK;
> +
> +	for (i =3D 0; i < FXLS8962AF_SCALE_TABLE_LEN; i++)
> +		if (data->chip_info->scale_table[i].reg_value =3D=3D reg)
> +			break;
> +
> +	if (i =3D=3D FXLS8962AF_SCALE_TABLE_LEN)
> +		return -EINVAL;
> +
> +	*val =3D data->chip_info->scale_table[i].scale;
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static int fxls8962af_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			ret =3D fxls8962af_get_temp(data, val);
> +			break;
> +		case IIO_ACCEL:
> +			ret =3D fxls8962af_get_axis(data, chan, val);
> +			break;
> +		default:
> +			ret =3D -EINVAL;
> +		}
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			*val =3D FXLS8962AF_TEMP_CENTER_VAL;
> +			return IIO_VAL_INT;
> +		} else {
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 0;
> +		ret =3D fxls8962af_read_full_scale(data, val2);
> +		return ret;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int fxls8962af_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret =3D fxls8962af_set_full_scale(data, val2);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	iio_device_release_direct_mode(indio_dev);
> +	return ret;
> +}
> +
> +#define FXLS8962AF_CHANNEL(axis, idx) { \
> +	.type =3D IIO_ACCEL, \
> +	.modified =3D 1, \
> +	.channel2 =3D IIO_MOD_##axis, \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_CALIBBIAS), \
> +	.info_mask_shared_by_type =3D
> BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +			BIT(IIO_CHAN_INFO_SCALE) | \
> +
> 	BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) |
> \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> \
> +	.scan_index =3D idx, \
> +	.scan_type =3D { \
> +		.sign =3D 's', \
> +		.realbits =3D 12, \
> +		.storagebits =3D 16, \
> +		.shift =3D 4, \
> +		.endianness =3D IIO_BE, \
> +	}, \
> +}
> +
> +#define FXLS8962AF_TEMP_CHANNEL { \
> +	.type =3D IIO_TEMP, \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) | \
> +			      BIT(IIO_CHAN_INFO_OFFSET),\
> +	.scan_index =3D -1, \
> +	.scan_type =3D { \
> +		.sign =3D 's', \
> +		.realbits =3D 8, \
> +		.storagebits =3D 16, \
> +	}, \
> +}
> +
> +static const struct iio_chan_spec fxls8962af_channels[] =3D {
> +	FXLS8962AF_CHANNEL(X, idx_x),
> +	FXLS8962AF_CHANNEL(Y, idx_y),
> +	FXLS8962AF_CHANNEL(Z, idx_z),
> +	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
> +	FXLS8962AF_TEMP_CHANNEL,
> +};
> +
> +static const struct fxls8962af_chip_info fxls_chip_info_table[] =3D {
> +	[fxls8962af] =3D {
> +		.chip_id =3D FXLS8962AF_DEVICE_ID,
> +		.channels =3D fxls8962af_channels,
> +		.num_channels =3D ARRAY_SIZE(fxls8962af_channels),
> +		.scale_table =3D {
> +			 {IIO_G_TO_M_S_2(980000),
> FXLS8962AF_FSR_2G},
> +			 {IIO_G_TO_M_S_2(1950000),
> FXLS8962AF_FSR_4G},
> +			 {IIO_G_TO_M_S_2(3910000),
> FXLS8962AF_FSR_8G},
> +			 {IIO_G_TO_M_S_2(7810000),
> FXLS8962AF_FSR_16G}},
> +			},
> +	[fxls8964af] =3D {
> +		.chip_id =3D FXLS8964AF_DEVICE_ID,
> +		.channels =3D fxls8962af_channels,
> +		.num_channels =3D ARRAY_SIZE(fxls8962af_channels),
> +		.scale_table =3D {
> +			 {IIO_G_TO_M_S_2(980000),
> FXLS8962AF_FSR_2G},
> +			 {IIO_G_TO_M_S_2(1950000),
> FXLS8962AF_FSR_4G},
> +			 {IIO_G_TO_M_S_2(3910000),
> FXLS8962AF_FSR_8G},
> +			 {IIO_G_TO_M_S_2(7810000),
> FXLS8962AF_FSR_16G}},
> +			},
> +};
> +
> +static struct attribute *fxls8962af_attributes[] =3D {
> +	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group fxls8962af_group =3D {
> +	.attrs =3D fxls8962af_attributes,
> +};
> +
> +static const struct iio_info fxls8962af_info =3D {
> +	.attrs =3D &fxls8962af_group,
> +	.read_raw =3D &fxls8962af_read_raw,
> +	.write_raw =3D &fxls8962af_write_raw,
> +	.write_raw_get_fmt =3D fxls8962af_write_raw_get_fmt,
> +};
> +
> +static const unsigned long fxls8962af_scan_masks[] =3D { 0x7, 0 };
> +
> +static int fxls8962af_reset(struct fxls8962af_data *data)
> +{
> +	int i, ret;
> +	unsigned int reg;
> +
> +	ret =3D regmap_update_bits(data->regmap,
> FXLS8962AF_SENS_CONFIG1,
> +				 FXLS8962AF_SENS_CONFIG1_RST,
> +				 FXLS8962AF_SENS_CONFIG1_RST);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i =3D 0; i < 10; i++) {
> +		usleep_range(100, 200);
> +		ret =3D regmap_read(data->regmap,
> FXLS8962AF_SENS_CONFIG1, &reg);
> +		if (ret =3D=3D -EIO)
> +			continue;	/* I2C comm reset */
> +		if (ret < 0)
> +			return ret;
> +		if (!(reg & FXLS8962AF_SENS_CONFIG1_RST))
> +			return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +int fxls8962af_core_probe(struct device *dev, struct regmap
> *regmap, int irq,
> +			  const char *name)
> +{
> +	struct fxls8962af_data *data;
> +	struct iio_dev *indio_dev;
> +	unsigned int reg;
> +	int ret, i;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	mutex_init(&data->lock);
> +	data->regmap =3D regmap;
> +
> +	ret =3D iio_read_mount_matrix(dev, "mount-matrix", &data-
> >orientation);
> +	if (ret)
> +		return ret;
> +
> +	data->vdd_reg =3D devm_regulator_get_optional(dev, "vdd");
> +	if (IS_ERR(data->vdd_reg)) {
> +		if ((PTR_ERR(data->vdd_reg) !=3D -ENODEV) && dev-
> >of_node)
> +			return PTR_ERR(data->vdd_reg);
> +
> +		data->vdd_reg =3D NULL;
> +	} else {
> +		ret =3D regulator_enable(data->vdd_reg);
> +		if (ret)
> +			return ret;
> +	}

Hmm this looks odd to me. Is vdd the device supply voltage? Looking at the
code it looks like that what you want is 'devm_regulator_get() '. The optio=
nal
variant should be used for stuff that is really optional like external refe=
rences.
And when those references are not provided, the device will use
some internal one... A supply is typically never optional :)

> +	ret =3D regmap_read(data->regmap, FXLS8962AF_WHO_AM_I,
> &reg);
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	dev_dbg(dev, "Chip Id %x\n", reg);
> +	for (i =3D 0; i < ARRAY_SIZE(fxls_chip_info_table); i++) {
> +		if (fxls_chip_info_table[i].chip_id =3D=3D reg) {
> +			data->chip_info =3D &fxls_chip_info_table[i];
> +			break;
> +		}
> +	}
> +
> +	indio_dev->channels =3D data->chip_info->channels;
> +	indio_dev->num_channels =3D data->chip_info->num_channels;
> +	indio_dev->name =3D name;
> +	indio_dev->available_scan_masks =3D fxls8962af_scan_masks;
> +	indio_dev->info =3D &fxls8962af_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	dev_info(dev, "registering %s accelerometer\n", name);
> +
> +	ret =3D fxls8962af_reset(data);
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev,
> FXLS8962AF_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
Maybe add devm_add_action_or_reset() here and after enabling the
regulator and we can then ditch ' fxls8962af_core_remove ()'...
> +	ret =3D iio_device_register(indio_dev);
devm_iio_device_register()?
> +	if (ret < 0)
> +		goto disable_regulators;
> +
> +	return 0;
> +
> + disable_regulators:
> +	if (data->vdd_reg)
> +		regulator_disable(data->vdd_reg);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
> +
> +int fxls8962af_core_remove(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
> +
> +	fxls8962af_standby(iio_priv(indio_dev));
> +
> +	if (data->vdd_reg)
> +		regulator_disable(data->vdd_reg);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fxls8962af_core_remove);
> +
> +#ifdef CONFIG_PM
> +static int fxls8962af_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret =3D fxls8962af_standby(data);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0) {
> +		dev_err(dev, "powering off device failed\n");
> +		return -EAGAIN;
> +	}
> +
> +	if (data->vdd_reg) {
> +		ret =3D regulator_disable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VDD
> regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int fxls8962af_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct fxls8962af_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	if (data->vdd_reg) {
> +		ret =3D regulator_disable(data->vdd_reg);
> +		if (ret) {
> +			dev_err(dev, "failed to disable VDD
> regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D fxls8962af_active(data);
> +	if (ret < 0)
> +		goto runtime_resume_failed;
> +
> +	return 0;
> +
> + runtime_resume_failed:
> +	if (data->vdd_reg)
> +		regulator_disable(data->vdd_reg);
> +
> +	return ret;
> +}
> +#endif
> +
> +const struct dev_pm_ops fxls8962af_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	    SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
> +			       fxls8962af_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL_GPL(fxls8962af_pm_ops);
> +
> +MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
> +MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF
> accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c
> b/drivers/iio/accel/fxls8962af-i2c.c
> new file mode 100644
> index 000000000000..4cdbd9793df7
> --- /dev/null
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Connected Cars A/S
> + */
> +
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +
> +#include "fxls8962af.h"
> +
> +static int fxls8962af_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name =3D NULL;
> +
> +	regmap =3D devm_regmap_init_i2c(client,
> &fxls8962af_regmap_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to initialize i2c
> regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name =3D id->name;
> +
> +	return fxls8962af_core_probe(&client->dev, regmap, client-
> >irq, name);
> +}
> +
> +static int fxls8962af_remove(struct i2c_client *client)
> +{
> +	return fxls8962af_core_remove(&client->dev);
> +}
> +
> +static const struct i2c_device_id fxls8962af_id[] =3D {
> +	{"fxls8962af", fxls8962af},
> +	{"fxls8964af", fxls8964af},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
> +
> +static const struct of_device_id fxls8962af_of_match[] =3D {
> +	{.compatible =3D "nxp,fxls8962af"},
> +	{.compatible =3D "nxp,fxls8964af"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
> +
> +static struct i2c_driver fxls8962af_driver =3D {
> +	.driver =3D {
> +		   .name =3D "fxls8962af_i2c",
> +		   .of_match_table =3D fxls8962af_of_match,
> +		   .pm =3D &fxls8962af_pm_ops,
> +		   },
> +	.probe =3D fxls8962af_probe,
> +	.remove =3D fxls8962af_remove,
> +	.id_table =3D fxls8962af_id,
> +};
> +
> +module_i2c_driver(fxls8962af_driver);
> +
> +MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
> +MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF
> accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/fxls8962af-spi.c
> b/drivers/iio/accel/fxls8962af-spi.c
> new file mode 100644
> index 000000000000..976851863e82
> --- /dev/null
> +++ b/drivers/iio/accel/fxls8962af-spi.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021 Connected Cars A/S
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>
> +
> +#include "fxls8962af.h"
> +
> +static const struct regmap_config fxls8962af_spi_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> +
> +static int fxls8962af_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id =3D spi_get_device_id(spi);
> +	struct regmap *regmap;
> +	const char *name =3D NULL;
> +
> +	regmap =3D devm_regmap_init_spi(spi,
> &fxls8962af_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap
> %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name =3D id->name;
> +
> +	return fxls8962af_core_probe(&spi->dev, regmap, spi->irq,
> name);
> +}
> +
> +static int fxls8962af_remove(struct spi_device *spi)
> +{
> +	return fxls8962af_core_remove(&spi->dev);
> +}
> +
> +static const struct of_device_id fxls8962af_spi_of_match[] =3D {
> +	{.compatible =3D "nxp,fxls8962af",},
> +	{.compatible =3D "nxp,fxls8964af",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, fxls8962af_spi_of_match);
> +
> +static const struct spi_device_id fxls8962af_spi_id_table[] =3D {
> +	{"fxls8962af", fxls8962af},
> +	{"fxls8964af", fxls8964af},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, fxls8962af_spi_id_table);
> +
> +static struct spi_driver fxls8962af_driver =3D {
> +	.driver =3D {
> +		   .name =3D "fxls8962af_spi",
> +		   .pm =3D &fxls8962af_pm_ops,
> +		   .of_match_table =3D fxls8962af_spi_of_match,
> +		   },
> +	.probe =3D fxls8962af_probe,
> +	.remove =3D fxls8962af_remove,
> +	.id_table =3D fxls8962af_spi_id_table,
> +};
> +
> +module_spi_driver(fxls8962af_driver);
> +
> +MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
> +MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF
> accelerometer driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/accel/fxls8962af.h
> b/drivers/iio/accel/fxls8962af.h
> new file mode 100644
> index 000000000000..0cc6ff36ed7c
> --- /dev/null
> +++ b/drivers/iio/accel/fxls8962af.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2021 Connected Cars A/S
> + */
> +#ifndef _FXLS8962AF_H_
> +#define _FXLS8962AF_H_
> +
> +struct regmap;
> +
> +enum {
> +	fxls8962af,
> +	fxls8964af,
> +};
> +
> +int fxls8962af_core_probe(struct device *dev, struct regmap
> *regmap, int irq,
> +			  const char *name);
> +int fxls8962af_core_remove(struct device *dev);
> +extern const struct dev_pm_ops fxls8962af_pm_ops;
> +extern const struct regmap_config fxls8962af_regmap_conf;
> +
> +#endif				/* _FXLS8962AF_H_ */
> --
> 2.31.0

