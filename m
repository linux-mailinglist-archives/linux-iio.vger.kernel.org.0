Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FBB3EB14F
	for <lists+linux-iio@lfdr.de>; Fri, 13 Aug 2021 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbhHMHVy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Aug 2021 03:21:54 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:54900 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236982AbhHMHVy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Aug 2021 03:21:54 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D74ltL028534;
        Fri, 13 Aug 2021 03:21:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 3act2dw2gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 03:21:12 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17D78MRU000416;
        Fri, 13 Aug 2021 03:21:11 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-00128a01.pphosted.com with ESMTP id 3act2dw2gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 03:21:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIo7IBZTIgSHAo8uNCS2Gf4nhk6UOat3RMN1a1/B0ujivMoqUn3QHNXWftSz3vV5u530xlHFnvPHP0tRapdvRN83bW9VOksJpje3idnwbq+obZX/esu3KThly6EemaEpNT2iAl80iQFKeQoag8sQb3Q8MNVQ+CF90L1WSK24dek31Hc5WQqkMF1CwE2mBv8AIoahTkz2phVb5XVab+4bqfIxuI94QV9jzGM+k3vebLBnXyGtiQJ0ob/yGsVVu1E11zUTEigrTXRolvrklF0e9dPPI5mQX9BLoekc7hzcCW23UOWlhdSjPcpSZn+QkIYHdQ8PJVpmue1QM8YRFcy4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8jEoMifabycxXjbxMdq9Ru9ONqfoOX4wRqkuCCSLVo=;
 b=DKNNAPD47+k2FvkekoWYfNh+TEroMdnGNVZfS1WxcgY3CKEcg1/zAN21vCAFZ+hxIGL8p6Ii9s+l/u8yatVY1lfGs1roQzJDQZ8FO2RaIa19z2HlkA4E5C/uu4T/NvD05H49dJIxojHgXFfdrnJBdEHvwmljBqgKw3OEOyd/sg+VhTnIjGyz3G7cS2U9qq5eXAjkmqHsnY01cG7CD3BVY0F1n9gtVKpOsFTqMUkQxcs29faRIon3iAEXODGIVmMAwDvuRCyBAQpnKu2BOW8Rzg9a+VdcYXCyFP1BIwmt/jwJF1BjNApdp6S7AK5RNafaBYfhycK4F5Ipr1Nzbx5Tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8jEoMifabycxXjbxMdq9Ru9ONqfoOX4wRqkuCCSLVo=;
 b=svSxmesy9khXNCnoIsAK4QVN3AK0pzJXNl38YQFARd6+Vnw5QbekLfhCEBCmtup6DwRyNxTBGkec1RFQhsZuPXjOpNpeATRyZ76sJooZ0YxkaPFJPDaVeDPkbrrDcjD/XAxCQR/dsL+i1O74xMYqnwAQvZgqEKOIVfttO2EX0sY=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5912.namprd03.prod.outlook.com (2603:10b6:510:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Fri, 13 Aug
 2021 07:21:10 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::650f:685d:44ee:2304%6]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 07:21:10 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Drew Fustini <drew@pdp7.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v2 1/1] iio: ltc2983: fix device probe
Thread-Topic: [PATCH v2 1/1] iio: ltc2983: fix device probe
Thread-Index: AQHXjrT06XBzL4FKU0yXzNS476nY1qtuesgAgAD02HCAAMAYgIAAA22AgADVksA=
Date:   Fri, 13 Aug 2021 07:21:09 +0000
Message-ID: <PH0PR03MB6366402FDD22B81C72F713E799FA9@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210811133220.190264-1-nuno.sa@analog.com>
 <20210811133220.190264-2-nuno.sa@analog.com>
 <CAHp75Vfp_u9mbnUzcBXdv_RmFu9m4JK0=R5us6j3bquG4HzRvQ@mail.gmail.com>
 <PH0PR03MB6366AC51BA01533E28001A3F99F99@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210812191919.00000217@Huawei.com> <20210812183135.GA3120809@x1>
In-Reply-To: <20210812183135.GA3120809@x1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMDY2MmYzMDItZmMwNy0xMWViLThiODUtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDA2NjJmMzA0LWZjMDctMTFlYi04Yjg1LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMzA1NyIgdD0iMTMyNzMzMTI4Nj?=
 =?iso-8859-1?Q?c3Mzg1MTU2IiBoPSJHN1NIeXdhVDg4c1NWalpqM1oySEY3Mk5Rc2c9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQURFNDczSUU1RFhBZHdFbmhhZ0pLQSszQVNlRnFBa29ENEZBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFBV0F3QUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUJPWUdjZ0FBQUFBQUFBQUFBQUFBQUo0?=
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
authentication-results: pdp7.com; dkim=none (message not signed)
 header.d=none;pdp7.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c74b3e2-a54c-4994-2bb4-08d95e2aec9a
x-ms-traffictypediagnostic: PH0PR03MB5912:
x-microsoft-antispam-prvs: <PH0PR03MB5912B02F368E9BA9FA75A75E99FA9@PH0PR03MB5912.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8nZL0Ut78xc+8ygRNHVKw3BrY9USY3REfGzkeZ4TaiunDjZ4gcrBFQoq/gNjXTPyEBlW4dF0U+dvveZN/3bijJmxnVXoeCIRNr9ZyDQqgWJXUU6KuCony5EhF0xoFy8g3be75RR9ZN1Y6PHW7erNASsklzVWPFCwFEHLo92pjlYzm05spli87zuvrQmOeroShphWigmz482i7Z0qLFAZ2f2siyNTFzf4ZATrrExiIA/VHKAHsQ/TslfHCr0MvrutgoOgS+pBj2k5iubHyGQ46tVTy0xBWq/FEqTdPZtqjHhy7dKFFincFR5BiMiouyukwT+0yjw8WTgrVAg6PEB7+VfswB+Xs1K+g7ij8vCzoZi2eFWlrcIf1DDZ9lnXvGkc4jMWyLWFizG4TO1dX72rzW25BGuy7i23wpUcT4KKk5DTyFqw1R5zOlRqaC4zEytPCsIqwKD05G1X90d8Fa78wDcvrxZJmq1eFenOfU/anYs7MsVOWb2aqGj0SZAMue33t4Ai1ji0ImSetJTz7ND1CiCy1s6GDXfJ9yaDkVDcw7VGDU38lPQDPv3rIzKufAqKTdEBfShDXaCB8wUBIJSmqcy5S6FkiJA4MaY4LoUDXvtjUNiROzybZ5FkBswSMK5SpYcEKRewU3b2u4TXGZDsXwwc5URRSqHiKQirJirVfXQnw5lSnZZHLFatCtvzbRK904WIhNsR6/7m11apTrWJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(55016002)(9686003)(2906002)(38070700005)(54906003)(26005)(83380400001)(7696005)(6506007)(53546011)(110136005)(478600001)(186003)(8936002)(8676002)(316002)(71200400001)(4326008)(122000001)(38100700002)(76116006)(86362001)(52536014)(33656002)(5660300002)(66946007)(66446008)(66556008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k9D6XYOp6+BRFCTjJaNdCFI1Dd3n8mu8GG7qRPOx9E8NxMh0gd/TdBdsh3?=
 =?iso-8859-1?Q?F0mS6+bE+E4uBVkrdGdMMdPyTergDuoTSj6Rp3FnZomIbfqODY2na3oONP?=
 =?iso-8859-1?Q?k76vGl2JOcM3vlDhqluVydByCkp4JrLaXNTt3hmtG7CkpcrYuCguSrcYfX?=
 =?iso-8859-1?Q?swM4DoWzzxeyN3iJN/cspuvUYK5vTLc5vFaIroL4tuuappWeDda0/zbh7n?=
 =?iso-8859-1?Q?+oNefQjRYfmC6Hi9z8HvsNq1H5CKxFpAWj/GEoSgGxw71k6DZUwtXOCwK/?=
 =?iso-8859-1?Q?BBYtn+QOfvEDh0wEQ+SKmcC5JRWMvDFJhMU6LuOjDryTYEI0K0vf9NfDCd?=
 =?iso-8859-1?Q?KrECNarobIZum90tKTN4F4a3opLaG3LmAzBVZItveMUIGZ89iMMRqdU+n6?=
 =?iso-8859-1?Q?HzEBpdbV18Ljne0wPrkmyJSnU6LXHh9GwOfQuZmHXeB91JNby8WtcevJcG?=
 =?iso-8859-1?Q?msrFj8p/yKgTWOMBpG9oWZk90Ii6GmA+FjYq92DAvWRUctPjagKNA/cpov?=
 =?iso-8859-1?Q?Ewy5madBj24xgJ4J7rBIyDh+x8tlshZpd3guKbTbiE37oO9XIMNDDZ+B55?=
 =?iso-8859-1?Q?I4qz/t7bE8uFl4Z2tj4MnjSITm6wivrQC4pwBGMtuzbfiGXkO26Ra0Dxmh?=
 =?iso-8859-1?Q?Njev9r614quv47jCd6a4zgYKT3zBd+K4iD7YzGIoue92q+xeun+cNdL1Sz?=
 =?iso-8859-1?Q?CuTwxbpKczbPtpUsEIokqHkUnjfHevp9cWA8kIgG6SxdWtIuh149NO1wfF?=
 =?iso-8859-1?Q?WTtc3CNaGiDfbjvUvgo4euPWviCVbU7PA2aPhMMe7dhHrQC/Q7l5Y6fG5c?=
 =?iso-8859-1?Q?xppSo0sSXmVnezIbyqiZ2BhldTEw7CVgCs8rk+7cUPZZswCJH68NeNbG1k?=
 =?iso-8859-1?Q?A35MIJwj6bvsJJ1DubP6dM8/kj7kwXLeavUBpDLgPPtTaPU2unruh31d9x?=
 =?iso-8859-1?Q?cESEReyoZd6lD168K3a6OxVyqG4TlQ1ou23fbzkPzL6/2ygIZngwkkCwEs?=
 =?iso-8859-1?Q?iStVwU7itfUuTPIe2OTNrGof7r+KSBb8ILdcry+rItKYM8uSgINLirEAFH?=
 =?iso-8859-1?Q?Qg/4s4H5UylnUMvLqk3eHv1m2PM48nyLQloX7gKDXLjJG3WTz81BW6cpRg?=
 =?iso-8859-1?Q?q32avE6xUdOo+Acb14h8DcKgOPuGw5bU65XhM5m9FJyiZMcl2cU/yYqsuz?=
 =?iso-8859-1?Q?QA1bOl+8QXs57yYI3uFpJzPrsm0dcwXb601EPt5smqelVNXg6NsGflR2Wz?=
 =?iso-8859-1?Q?xHKC9Z0DqhTdjfniV5NG86u6nZGNWaGVUjIgEOkilmgv0R+/YJfivA6sqF?=
 =?iso-8859-1?Q?Gaiz++dZq1xxL6NpNk9I2FOl36ELDq0J+KYyTYxmUin+RLL36kqzb9iXcF?=
 =?iso-8859-1?Q?ih7fe2VDhF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c74b3e2-a54c-4994-2bb4-08d95e2aec9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 07:21:09.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlfMk8By09Ap5Ox8HCDemvLeBTKKxqern+57uI085kgz1BTHcK4EHcFoMjiG85jMzZggeqMcykw69evxTe8I5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5912
X-Proofpoint-GUID: 0v6KJ--d5zBqfsHB-K0C-hcKcouuyOw2
X-Proofpoint-ORIG-GUID: BgMSsd0JKWGx9voVP2q78pErmPfXJ6UA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-13_01:2021-08-12,2021-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108130043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Drew Fustini <drew@pdp7.com>
> Sent: Thursday, August 12, 2021 8:32 PM
> To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko
> <andy.shevchenko@gmail.com>; linux-iio <linux-iio@vger.kernel.org>;
> Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>
> Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
>=20
> [External]
>=20
> On Thu, Aug 12, 2021 at 07:19:19PM +0100, Jonathan Cameron wrote:
> > On Thu, 12 Aug 2021 06:54:13 +0000
> > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> >
> > > > -----Original Message-----
> > > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Wednesday, August 11, 2021 6:15 PM
> > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > Cc: linux-iio <linux-iio@vger.kernel.org>; Jonathan Cameron
> > > > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>;
> Drew
> > > > Fustini <drew@pdp7.com>
> > > > Subject: Re: [PATCH v2 1/1] iio: ltc2983: fix device probe
> > > >
> > > > [External]
> > > >
> > > > On Wed, Aug 11, 2021 at 4:32 PM Nuno S=E1
> <nuno.sa@analog.com>
> > > > wrote:
> > > >
> > > > Thanks for an update, my comments below.
> > > > Depending on Jonathan's wishes it may or may not require a v3.
> > > > If you address the minor issues I commented on, take mine
> > > > Reviewed-by: Andy Shevchenko
> <andy.shevchenko@gmail.com>
> > > >
> > >
> > > Thanks for reviewing... Yeah, I will wait for Jonathan's feedback
> before
> > > sending a v3. It might be that he can apply your inputs when
> applying
> > > the patch.
> >
> > Patch looks sensible. I can make the tweaks whilst applying when I
> > happen to be on the right computer.
> >
> > Having glanced at the datasheet, I wonder if you ever had the
> > reset pin wired up (and perhaps decided to drop that
> > complexity later)?  The driver rather oddly
> > include of_gpio.h and has no gpio accesses which makes me
> > wonder ;)
>=20
> I'm sure Nuno will have something to say but I wanted to mention that

If my memory is not playing tricks on me, I'm almost positive that I never
used the reset pin when working on this driver so my best bet is that the
header is there because of some "stupid" copy paste that I did.... Though
I also wondered why I did not added support for the reset pin and
possibly vdd regulator...
  =20
> I
> was initially thinking about this.  The reset pin is connected to a GPIO
> on the Zynq-7000 on the custom board I am using.  I added that gpio
> line
> as an active low gpio hog under the gpio controller node in the DTS and
> that worked ok.  Though I had wondered whether there would ever
> be a
> case in which the driver would want to reset the LTC2983.
>=20

Yeah, since I have the setup ready I might just add support for the
optional reset pin. If given, we force a reset during probe. Then,
you can remove the gpio hog...

- Nuno S=E1
