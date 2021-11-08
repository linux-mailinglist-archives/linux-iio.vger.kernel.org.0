Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08A2447BD0
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 09:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbhKHIcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 03:32:12 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237976AbhKHIcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 03:32:11 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A87F3Pk020958;
        Mon, 8 Nov 2021 03:29:16 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c5pm6yu1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 03:29:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT+IuCtF3kIrZxiMOmb+4vv1Hre97Vk9ACpzwuZD2+kXhpl1AiB21GEFPYvoG6ILqcG6e2I1KtYgbl+dLHhz0buX5tK0XZ2gi74OhaSrdnbkXgx2HzX19KlhQQNQ2LEfBK10W+NBHCUrh07qlvUV2qzQkpHA5pwa74snZ2RUGXlN66Bd9x2lXgifNfnsd+TJW4tNICeuVDfTtFY1T3Uoh1eJG/m+ITo/97asRjsXHtaITUHLadQS+TWIIBl40ZyZaOz0dK+8qajML2uE/RAbWX/MIxq9oXRw/uWtZEPXOeDWcgNidh4UeiKsTqniNBx2R74eqLNGrnRgbdLEJzkBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mvb+vfbXZsB8RqEWQo18/82Qeipf8ZJguDbWysMAkw0=;
 b=l1Hj3Lv3NPZsszieyIM6gLsJ1mGibjRYigI/6eM0VA3BDVCte1kIUYakcO7maOVL0o23CKnyp67OmQ7Zzf68cNyzNfIbx/5eLCECPWyoWJggT31FwZucpJSuFJMa+I+BKdzpLvvDEpTDlm1G2kuIWE7hIO13DFcOvpXgH0oqURM7q9rxAwLJTGKfHLQhfqWHiCSEhcYsBgo3fYa8L0JQV9ypyFow09b2ELqvlRMgPE9lJ6HKjjybwsXfFDsHYbLptXt6TwlQVRxwTMRPGQHBWN8qNvY/fj2ngxHa7iOFekp2kiY3g1OP3tv5iKK5/IcaHdz9GcXQ2tz+xXReucepHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvb+vfbXZsB8RqEWQo18/82Qeipf8ZJguDbWysMAkw0=;
 b=EqNYZoBKIzgMSc7YPUwdd+aeEBUci9ZZcs/OK+CwdGeShxGltLeAwBUOw+grx05cFORcH/O3uub2DpK3HlzbYN6DynavbcFejT7nCgGP0IScrFRK7Fmnz5lXszmZx6m74580mhgqinoXxzNxYry1y3yBAjw0siz8/tKBJE6Fb74=
Received: from SN4PR03MB6799.namprd03.prod.outlook.com (2603:10b6:806:217::7)
 by SA1PR03MB6580.namprd03.prod.outlook.com (2603:10b6:806:1cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Mon, 8 Nov
 2021 08:29:14 +0000
Received: from SN4PR03MB6799.namprd03.prod.outlook.com
 ([fe80::6476:8d95:cabc:ca31]) by SN4PR03MB6799.namprd03.prod.outlook.com
 ([fe80::6476:8d95:cabc:ca31%8]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 08:29:14 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Subject: RE: [PATCH v5 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Thread-Topic: [PATCH v5 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Thread-Index: AQHX1Ho2pyvidWqOtkOuCwDisYTFAav5S56w
Date:   Mon, 8 Nov 2021 08:29:13 +0000
Message-ID: <SN4PR03MB679988CBFA34DF338C85549699919@SN4PR03MB6799.namprd03.prod.outlook.com>
References: <20211108082447.116663-1-mihail.chindris@analog.com>
 <20211108082447.116663-2-mihail.chindris@analog.com>
In-Reply-To: <20211108082447.116663-2-mihail.chindris@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1mMDkwODQ1YS00MDZkLTExZWMtODQwMy05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcZjA5MDg0NWMtNDA2ZC0xMWVjLTg0MDMtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSIxMDk3IiB0PSIxMzI4MDgzMzc1MTE1?=
 =?us-ascii?Q?MTA1MzYiIGg9IjNDY3RHTVY3TGN2SzUxVUNQYmRtZWtVTXhEbz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QUljcFcwZXRUWEFTRENOSVZZRXJISUlNSTBoVmdTc2NnREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c93865d7-6f3b-4355-e178-08d9a291d8e2
x-ms-traffictypediagnostic: SA1PR03MB6580:
x-microsoft-antispam-prvs: <SA1PR03MB65801E3CDF811D3BB812124299919@SA1PR03MB6580.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VrO5FLBPbVfYBim7OLhzQgmNT3k3XZ5QCT1DsuP0ld7hyblk+b9iXH1aduwC35gWIYm3CTNfwRBkOQbe4qciG5v6Vv5YTkkMztQGTkoQKG+VXG49rsPdMfT4M/C2BmwOvosmJXqBLUGroDEoASfcWr7zewhhMwAOsCM8/RyESrt497Q/zPZYV1pmw66xuV6gEPdda0SRAJPSku5uC/sDP/fxSzmrml/E39iBieCOcxFVxsk//eJEylniL/ijPYJH3deQUEgsURlxHnWpSagYFlBLSqpGp5GjyaJeO9u+4Y9nsso0WEUy0d/W1KNaULJEIGbYdJG+HZRRJbM07bWbbQCv9/obp1urAqCTKZZePc1zdDOxLobBOF7VHZIeWRTdfwe7F79bv0T/Jpfh6zCHM6I9pp9KqZ+jPEIl187SNAHeA2inIYJCF1VIzotxvBAuLhzVWR06qIeNEe7SJUUI4iOAoRLpzX3VOUWz112pvRDrl8075G4ezsCsQcar5i2PX+DK86pV+Nsx9tOVTzki8+OoUI9hzWrkSVXJYw/uXQUtiUJmY5+2zPyfEPCUMghr5Wq9e8Eal/bxLAH1BOI88ZJgRh6yvWLXrRTESIPkCe1aic7Q7Y9D954YpEXctk3dN7LKNnFyElO5gfV0+uKJf+PV61QX+0RnSAVLN55ZZd9K6uVOgiw60ByIZV0JRpQLXloV6bhPqslrSmJigHQZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6799.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(7696005)(9686003)(316002)(38070700005)(5660300002)(83380400001)(186003)(71200400001)(2906002)(76116006)(8676002)(55016002)(122000001)(4326008)(8936002)(38100700002)(6506007)(33656002)(508600001)(52536014)(66946007)(4744005)(66476007)(66556008)(64756008)(66446008)(86362001)(54906003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+zg0Ezaojh54jRpMMbY22l2X5x4DuxWpqnuYnQBIK9JLPTPmSf0vhiw7Uc+3?=
 =?us-ascii?Q?+l9DgpSNpZJdnUwDNMP5/e8KBe5PiIpp/dVyEQi2Qd9tX4t5VjtOaPvsEoru?=
 =?us-ascii?Q?SU/ZjJw8SaCysd6Otu2dB8HKvAOBH3pb77eWtYA4tsTXi+yVTG/DQQsjOrcb?=
 =?us-ascii?Q?DtsQ05orYvQ4KqbpqenaRpn3DP+w5BghnitQzIUv9AsgOgPXlVBUAUqMZKg1?=
 =?us-ascii?Q?jqMEM/p30XE5rL+2PqRKeIpqyPju6Y48eKZTWRM3H3PqWJsSREBlwtAWg/YF?=
 =?us-ascii?Q?hrK+JHCEEKujnRRsRckXbnJek5I2xIZO5RChDytxxnDq/H+saRhHauOoMQoa?=
 =?us-ascii?Q?owxCiyzEZBmPEqSx+o1dYDtKyBX10c6L0PVDdTK2Twbcrmlg30qKMG9746uH?=
 =?us-ascii?Q?QeY18WlqKjUEP7jdhpW728Llw3z0oSdBiyRraZevTO1ASDuDxCJ7nYt31PsT?=
 =?us-ascii?Q?kW+XH8W1d6bPQ6XE5uKvdphfDUpygCa/3e0WocU7D8j525f/23jD2r8Ume1D?=
 =?us-ascii?Q?5K0UAf30p3WzgyFDWEz+/H245HKKB2Z89TjVYtaOdYAZ82tSi3hwjx+u6lEN?=
 =?us-ascii?Q?qnF8V66wWMhu0ejic6fzxobs2ZHcZLvGTxhhZqzTjaWfwN/UGxZnRiNJRqlo?=
 =?us-ascii?Q?kP5waTVtpqorCGyaxH5JFU9nfiLKe8e9QBrphONvmYMpYyfUkTpaT0q8ESh0?=
 =?us-ascii?Q?PtKy0GSYaDioD692WQp3zMVty7tpiHYU7mAiiCNAcNchef6beYKXAowiyg6/?=
 =?us-ascii?Q?C37ZqQCl8GXR14JgCjTs5dvAMQp04keDqLyIghcGuE+e1VFa+A/vjgoNBbbB?=
 =?us-ascii?Q?EUTn5yYOn1e96rfcH9c7Hp75jCVa4otOeYZDw0T2DyRAvo778dUf7WV4LC+k?=
 =?us-ascii?Q?1CUEnAjQYf56Fm4+D0yiBDneQkJDvAu0mYXjBk5CQPvkJ2OXo+whLl8YgKlo?=
 =?us-ascii?Q?6KTWywYNrspBRuqma8IbPfrS+5OWeFB5m4Cz/Tf7FzgwUxknqQ2oWtqYbY+C?=
 =?us-ascii?Q?WYcXK4xLnLyzQC/9XIUGyLYEATgfe7R9WFXrYZqT7xbDRv6BJH8cR2v97tRq?=
 =?us-ascii?Q?tspcemF9Sbq3QaBukQGp7ss04edO+BDhMhdl388GX30Bg81hKvfQnMc04CZY?=
 =?us-ascii?Q?gEH3yy44aRBXKDVXZX0+pEnYQYQhBBOPbe02OM8Ow3EriMfisppveO5hocTx?=
 =?us-ascii?Q?OMckrbUZD8Iyo3uCnsVWOdXI/AIZD0sPuvOyZp7nNB7bPxbHuXL+mEE4yxPo?=
 =?us-ascii?Q?0gYOh6/jn+ZAU//NM+E46WwVHCkZHPaTYgz0FqbI5FhWxSPJGH9w0MBvh9Hc?=
 =?us-ascii?Q?Ax8Evu2xlc1FOfCC7ElJ4bthHz9kQlmOFeyNlte/IG9LoHgrL9+mlqosb8xY?=
 =?us-ascii?Q?LnXAW+Gc+pJfUi6fYQXK8SM38qotMJqHxCEZJOIgCue6fxArT9PGU80iiCfV?=
 =?us-ascii?Q?29Vy667iJUMsdSoMTE1xrVM+5XBQVU//g46QkQoOGMPxMJADW4XLz5oezrVo?=
 =?us-ascii?Q?GHasgNnyKVoLm2fOko/4U9FazPIEJolVAgH844MK8n+Yz62JVaDUEqDZJWza?=
 =?us-ascii?Q?dvswh2uxWFb6P5JKXMjfK6BJfVfPIv33Gdx5exAJ/jY6PAjDWDfNNTwV8BZt?=
 =?us-ascii?Q?uu1qU7L8t5p3xDcrqoWo8X3kbdTfHssHTthuYJ2Ynt4/zm/ZZKjejP0kNUt9?=
 =?us-ascii?Q?54HnTiHYi3tiai5evX/K0izXhy75h9fu0f3AFqpk4jhQyR8RRsUWvbrRPE9F?=
 =?us-ascii?Q?FUi6GZDGWQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6799.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93865d7-6f3b-4355-e178-08d9a291d8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 08:29:13.9443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kI/4h1mW8gCXOjdYcewyIsynbBP2jVHXzOAAI0tBnvx6BbJRERu6N9M8mgpsLxXpedfqvauRPzTKlPwL3gxQ70h9zo6aMHMs+XvwMV4dwiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6580
X-Proofpoint-ORIG-GUID: 4kd3rpvzbcOsA6vlYB00Y_933Emm9Bk8
X-Proofpoint-GUID: 4kd3rpvzbcOsA6vlYB00Y_933Emm9Bk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080053
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> +patternProperties:
> +  "^channel@([0-1])$":
> +    type: object
> +    description: Configurations of the DAC Channels
> +    properties:
> +      reg:
> +          description: Channel number
> +          enum: [0, 1]
> +
> +      custom-output-range-config:

Copy unanswered comment from V3

> > >=20
> > > Not a generic property so I think this needs an adi prefix. =20
> > > Jonathan
> >
> > I tried with adi prefix but I get weird errors while running dt_binding=
_check for properties with adi prefix and with type:object
> > Do you have any suggestion for this issues?
> >=20
> > Mihail
> >
@Rob
Jonathan

> +        type: object
> +        description: Configuration of custom range when
> +          adi,output-range-microvolt is not present.
> +          The formulas for calculation the output voltages are
> +            Vout_fs =3D 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.03=
]
> +            Vout_zs =3D 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.03=
]
...
