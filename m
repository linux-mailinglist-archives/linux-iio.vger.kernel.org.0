Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61223B6F63
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jun 2021 10:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhF2IbR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Jun 2021 04:31:17 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:28602 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232308AbhF2IbR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jun 2021 04:31:17 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T8RhRT008435;
        Tue, 29 Jun 2021 04:28:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 39fmwasp8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 04:28:33 -0400
Received: from m0167090.ppops.net (m0167090.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15T8SW1G012384;
        Tue, 29 Jun 2021 04:28:32 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0b-00128a01.pphosted.com with ESMTP id 39fmwasp8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 04:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBFQ/bVnPJM8Gl/SnCsSBB2poCL7/gX2ryHOQxwFabnxm3nFY8dHT4kTBnVuBIsyyM4vUlhQEivnJnbvHahJcbzHcYnHVmPFfx6d3tXgj5DKIwQndJMo1JsmocZcZqGmhVex4CL75cn49L6p8eCvnjrxrj983Hrgs89DXWIrk8mre2vPqsh8+74DK0tNgag/F6lNw9OB9gFauXGkuAtBhUWBy0QhqS86EYg83Oweunc/qzha1lDIjjQOTmdrNnbgn+D1UWnJk7KhdFEI9LdxrC8V8bCSRHaFzXD6WEcXSzOLrWNos70KYZvK0utZNo2eV8kazBdRzgjRBhFN6n+2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgPGOToTMn5AX2ZXVUi12MuaaohhA5rIubdR8RLZpOk=;
 b=kD48aLrP12RH3/x5XPQ8ZBgJVG6Tcv5tfPGmuC4LaKQTIOY/SAhUCycu3Haj+DReSoEDwApn5sdZSx5TzhnerkobNDjrP5cwMBK1n+6nAVo6VAFlktm5nBnyWN03lkrr4/AaVjvuEzAwKRnkucqU57J1pkdBANaBn0Qnf8bCsP0bePiwHtuBsJ64KwZ6xn6BZRHzSWYR1MeYjFg5f1c4UhpXVrVIdp3L3M1HNxrNzRcO4+92/7XS8eO7YNzXKifOCLlg1vvVwWpjhmWoCOufS2QlgYmktPHZwLuh4G97VMwpAXS8qY2ixUZWMgoEvzWayjnV9nP0rCvQb6q6/KTu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgPGOToTMn5AX2ZXVUi12MuaaohhA5rIubdR8RLZpOk=;
 b=IJAfWsdVgbcRR7n/DqWbShX0daPGjHAKJsVBknEJpXrHQoSQZp4C2pL3HiV3oESzzmUO9gtpTfJlOGt7I1CIghMj0rbP1lBBJVyrfU9s82fNHdeI35YkRNEzwaaYFv9pxzEXkwejTafXEaJ4FknFNkux33I+RqsrRK0MzNi7sYU=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5704.namprd03.prod.outlook.com (2603:10b6:510:3a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Tue, 29 Jun
 2021 08:28:31 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Tue, 29 Jun 2021
 08:28:31 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ricardo Ribalda <ribalda@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        Michael Welling <mwelling@ieee.org>
Subject: RE: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
 documents.
Thread-Topic: [PATCH 00/15] dt-bindings: iio: dac: Add most missing binding
 documents.
Thread-Index: AQHXa3HH5fUld04HWUaH046H0XvfkKspANnggABvmICAATm5wA==
Date:   Tue, 29 Jun 2021 08:28:30 +0000
Message-ID: <PH0PR03MB63666D9D4DD53EBB08462B1599029@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210627163244.1090296-1-jic23@kernel.org>
        <PH0PR03MB6366F34DC0B3D7EB7A56B6A499039@PH0PR03MB6366.namprd03.prod.outlook.com>
 <20210628144407.0000084e@Huawei.com>
In-Reply-To: <20210628144407.0000084e@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZmE1MjEwYTctZDhiMy0xMWViLThiNjktZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGZhNTIxMGE5LWQ4YjMtMTFlYi04YjY5LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iNDMwMSIgdD0iMTMyNjk0Mjg5MD?=
 =?iso-8859-1?Q?g1NDkxODA3IiBoPSIySWh6RnRFYjIyZ3NVTExib2VQVXVET3NZbXM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUJmNnFtOHdHelhBYndQSXl0MXVMMXR2QThqSzNXNHZXMEZBQUFB?=
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
authentication-results: Huawei.com; dkim=none (message not signed)
 header.d=none;Huawei.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40a7bd1a-47fb-40fe-efc0-08d93ad7e09e
x-ms-traffictypediagnostic: PH0PR03MB5704:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB57049F1C75AF106DBFFF8B3199029@PH0PR03MB5704.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FAEFIxJ2LA1YzFFf/KgI358iisZgWpuRE2Ews0CABGoCFFedBtLSqWiTsqFo33YifRRXqe7BpFILCvQoH0F3lLsm5Q2L433CieOHf6duX5hHTgwUS6skGEuk3clQ9gGuTJeOmThYQVR2Sh3Xrewvwy/zsbSGNCSuP76fDzK14xSr66ehNa2Z0Qsw5/ph4qyIKxtAsRhK4Da16ScjFTqBts2sJoj/C4bMRBkl4LIZOmgJOVqGDUlQSxlivANZCS5pc3Yv6CdYCpd39iEiCwM75a7MY5SVzmPK1+7hqqo0N2NeFxgTucZqJzih9Llxm09ytS+mOfgbmHMg15lSxzWlQH3/dSTzWFjjXd03osieCUO5x/SmInlSIb8B/dj22lOF8aG1MLSNzzxQSjcKBbUEGooWlgJ2dipmjnlIOppBL/zqC2N65lP73hRoWvoTXN7Z2AQCnmPZxUmEaNFnnOR031z1smdH0z3nlGLiUiMLG2Z/iZQodj1mAbg8ULgQu7A1+pH4essW9l3+5ETIrOHgPdFAFt5QLin+ZC4TT1yxRQdWqtBS69lG0Bz3LUoY10T0k21nmjvS+QCXGgU8D07kHxcppjQ70V21qVDJMtLzTiwhWg1DhI6xHG595xDs7RBbQhxkQ/l3vaOXmfQh0QKFBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(55016002)(9686003)(4326008)(33656002)(7696005)(53546011)(6506007)(54906003)(316002)(52536014)(83380400001)(2906002)(86362001)(5660300002)(71200400001)(122000001)(66446008)(76116006)(64756008)(66556008)(66946007)(66476007)(6916009)(38100700002)(8936002)(8676002)(186003)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wcc2YjBkIq+zUgM0RPIC0g8UNmPaUhYAZNoPlz48AB/kbJ1RZEf27+bO29?=
 =?iso-8859-1?Q?IKwNNHweBXWDcsmmScWpTRIYFuHYAQolbDcA46DGo/wK2edJCIf+TpPFgp?=
 =?iso-8859-1?Q?GhqSK3Oc1sYfS2ZMkVjvL2GfaTRV3PrmCnSjx6J2KD3WIWPpEcmZdpgP+P?=
 =?iso-8859-1?Q?e29iMXb7aq+HlfFewhPGpBVuHwznYI7bLLkox48tr6vgvDx8uBEVOoyJVP?=
 =?iso-8859-1?Q?hPRI15fKggg7L2eCVPfDlo/ji1DcxlL2hh2WVf2whHLCpQzRI77BzTMa2m?=
 =?iso-8859-1?Q?FnboxFAMVcgY03lS9xEIwn4CJAuhNb1xmnQBlZ3hcEGWBQ53zZxwhVXO4e?=
 =?iso-8859-1?Q?Ae0b72x7LiYdGpqwSHR7Dnzasi23l0LM3MUztpiv5BWRWpKwYPg6iB7mx4?=
 =?iso-8859-1?Q?D9XnCaWgC2T8e+j11etKI9GD1/fB3nA+TlqsW8NpSI4XmkyvaBXS6lfPbS?=
 =?iso-8859-1?Q?1e21+Rn94Swow4WehlFk6UMScdrBFE7y7Fa2o758M36M8sfIPlhogW1yK6?=
 =?iso-8859-1?Q?s4zqssOULfoiFexqm84t2xx7KewEKzediD4FXVC9phOJe2QB3+JCMffPZZ?=
 =?iso-8859-1?Q?ii/OLTCwnyfKATmCIYhVCmN+nxKksKYU+YYLKJFpTsp1/1PntpxcE4VgX6?=
 =?iso-8859-1?Q?73OW8q+p6px5QrlCDpo3gVKBwMlvtHCJsDanBWPXRhlCVSUMQ9yO5kU0Yf?=
 =?iso-8859-1?Q?c3m8c9Tqh5CK1aYndWbWnO8U+jvdIqVQj9NE44HCxqeC+Q4w7V9n4vnVTj?=
 =?iso-8859-1?Q?e2uOh/uuDGMLJW9QUCXGCIpoiR9OX5RxdrI7MraYQD4neNT/jsy/1N4swW?=
 =?iso-8859-1?Q?YtQHuLms+pAXXPuenpUrB+O9tp/8AfwbE2hnaSGK2NsDcrlYzw2ZwmBYKI?=
 =?iso-8859-1?Q?7yojp+AsGMB7i2wQ7pkpv0YP8QC3uD0FnvDwTE043Lbfb4TylA4v28CmmH?=
 =?iso-8859-1?Q?372cVDmnCGdNVGdWPz+ANdX0xMEsMejZ9NTUaajnjzYFD7pbjovakqVBl4?=
 =?iso-8859-1?Q?L8WU/tENfHp/nFNo6gQVQ+zb2yRw+08KfFs+SathG8mB/hPwtMVrZxmQb2?=
 =?iso-8859-1?Q?jMeYZTpSJiGNS/FltSDO3hUP4CRxgP7jeeHYQfxL1rFBTqorGH6RTX0yVP?=
 =?iso-8859-1?Q?GoL1rT3dh8o9K6EM4lLskQmU3PrWMcbYCCzJUGIBSmkC0x0p7svbHpwm5I?=
 =?iso-8859-1?Q?bFDuh+T/VqLIwM7giBwJT74fpSZyd24q7b8iZ87DBP6eOUfhZgqWSmvFP3?=
 =?iso-8859-1?Q?7J/aeQla1+ftyaWl5ZAOXrHGDuzi1Gr6O/AQt3mwRzUl0zeiCPDwCrJ4nV?=
 =?iso-8859-1?Q?qq+CFkrsZDRBcjF2mW9qDN8M1YzWMkvcOB58+ROCyF8QQWs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a7bd1a-47fb-40fe-efc0-08d93ad7e09e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 08:28:30.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lW/Ps2TMOSS2G0Agl2xDZ0urruiGnARLMBVthlNcShEia0JLkG8aVOpjDI6uPfmB2P3esMZSWUkdXuao8ouAEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5704
X-Proofpoint-ORIG-GUID: J-ppTACto3kX3gN8BeBTm8IyerdsJ9ea
X-Proofpoint-GUID: GNhW31NHvCVIrIrVER3BSY16BdGnPZGv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_05:2021-06-25,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290059
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, June 28, 2021 3:44 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org;
> Rob Herring <robh+dt@kernel.org>; devicetree@vger.kernel.org;
> Lars-Peter Clausen <lars@metafoo.de>; Ricardo Ribalda
> <ribalda@kernel.org>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Gwenhael Goavec-Merou
> <gwenhael.goavec-merou@trabucayre.com>; Michael Welling
> <mwelling@ieee.org>
> Subject: Re: [PATCH 00/15] dt-bindings: iio: dac: Add most missing
> binding documents.
>=20
> [External]
>=20
> On Mon, 28 Jun 2021 07:09:18 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > Hi Jonathan,
> >
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, June 27, 2021 6:32 PM
> > > To: linux-iio@vger.kernel.org; Rob Herring <robh+dt@kernel.org>;
> > > devicetree@vger.kernel.org
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Lars-
> Peter
> > > Clausen <lars@metafoo.de>; Ricardo Ribalda
> <ribalda@kernel.org>;
> > > Hennerich, Michael <Michael.Hennerich@analog.com>; Gwenhael
> > > Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>;
> Michael
> > > Welling <mwelling@ieee.org>
> > > Subject: [PATCH 00/15] dt-bindings: iio: dac: Add most missing
> binding
> > > documents.
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > We have quite a few drivers in IIO that date back to the days of
> > > platform
> > > data.  Many of them either worked out of the box with device tree
> > > due to the spi core using the spi_device_id to match against
> > > device tree compatibles, or were updated to use newer interfaces
> in
> > > the
> > > intervening years.  As such, they mostly 'work' with device tree but
> > > can have some slightly odd quirks (particularly around naming of
> > > supplies).
> > > As we have no way of knowing what is out in the wild, we need to
> > > support
> > > these interesting bits of regulator naming.
> > >
> > > I would ultimately like all such bindings to be documented both to
> > > facilitate
> > > automated check of device trees and to make things easier for
> people
> > > trying
> > > to write device tree files using these devices.
> > >
> > > This series fills in the majority of the absent bindings for DACs.
> > > There are some outstanding
> > > * max517 - some platform data configuration needs porting over to
> > > device tree.
> > > * m62332 - this passes a consumer mapping in as platform data and
> will
> > > need
> > >   careful porting over the dt way of doing that.
> > >
> > > There is one 'fixlet' in here for the driver to deal with a case were
> the
> > > code was intended to allow the presence of a regulator to dictate
> > > whether
> > > an internal reference was used, but did not use the optional
> regulator
> > > get.
> > >
> > > I've mostly nominated maintainers based on original authorship +
> > > where
> > > I was feeling guilty or couldn't find anyone still active I've listed
> myself.
> > >
> > > I got bored half way through of producing brief descriptions of
> > > the devices so stopped doing so. If anyone wants to provide one
> for
> > > these
> > > parts I'm happy to add it!
> > >
> > > Future series will cover the c. 40 bindings that I've identified as
> missing
> > > for other types of devices.  I've also kept notes of easy cleanups in
> > > drivers spotted whilst working these out, so will probably follow up
> > > with
> > > those soon as well.
> > >
> > > Note I haven't tested all of these so there may well be errors or
> > > elements
> > > I've missed.
> > >
> >
> > LGTM... Just wondering if we could not add the adi,ad5421 directly
> into
> > the trivial-devices yaml as it looks to be the only one without any odd
> > regulator name?
>=20
> We could, but would probably end up pulling it out again.  As noted in
> that patch description there is a bunch of stuff the binding doesn't
> currently
> support that would make sense to add if anyone actually needs it.

Fair enough :)

- Nuno S=E1

