Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141413C20BD
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 10:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhGII0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 04:26:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38358 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhGII0D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jul 2021 04:26:03 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1698B9NP004712;
        Fri, 9 Jul 2021 04:23:07 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0a-00128a01.pphosted.com with ESMTP id 39p8udjr1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 04:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/bbp6RP1p3HNQhsYC9VgpXhO1qP+3orA/SiKF70kTsza+Gs7VQ1RTH/ut9CaOHY2gCTAgcp/d/5+R5th2/hw0i6AFlRhjbNU+jxiHjN3Mq9xw+IVyzlqu4c415YpAhUlxj+d2bNf+K3OVvFFZc8L/n/D4os8Mq0YSm7j2fo2FTYg3IKjFGPOv2839eYYJtXnnQnap2315CpE1xZ1J/JWucH0ma3Cq+dW11CIZHOPLpGCkwiESnoZveGwNMMd0emPl7VWVK9NXsZQd/gAcFwQODypVEdeZry8dgGGppPC5gPxKtPOmLCvjmc5xMMY8xVDVcW4AE5MZY2HOUPHYXfVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lwb9QZ00bluK49xKH9Vrg5JCRnY/7EC3HNqqbF9GVk=;
 b=oBWtjsOhN6oIowBXQIVrBWSlwA19RlOa4h8tEKnp7lkJnGps7uNxHY8WBTE02nTd2vkD/UzHmP0plhXbBTJc17VuIfmQUfOJm2L9o34SMIdMj2R6slFu4WPmQBGvO23Et1n/w+S5Y5hjRuwY/ESPaCQwVQFxdkxf39rPr3c2lQk8Kny7eIofOQqdVYG2tG5AqIcWOIvf2NQs4MDcLjw//sy/1ZCtnvSq3CjiHU48VM6xd4IpFM54pXbHE8eyLC3o8fTMHvtU//WTGVx3w21+E3mOrN5YCMx2moyedQb6G4w3KZG+VRxPQw8tkEqMnQCEciuoNjAL7Sb/K3cRIIKg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lwb9QZ00bluK49xKH9Vrg5JCRnY/7EC3HNqqbF9GVk=;
 b=2hJqB8rocGCzfrCNgBH7sNQUYZtFGC0lAsUzk5GhM8Yjgn0AHRSC5AfP5Itz0TpoE1uJC93O58JP/PRqQT8MepHDS9ckH+Mvhv3rZGDnDFLi3q73bxTOf8nyBnFD0OpNkd4KI/89+38CVRKRS6dRUVcusK917oQ3oechGcG8oJg=
Received: from PH0PR03MB6366.namprd03.prod.outlook.com (2603:10b6:510:ab::22)
 by PH0PR03MB5750.namprd03.prod.outlook.com (2603:10b6:510:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 9 Jul
 2021 08:23:05 +0000
Received: from PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891]) by PH0PR03MB6366.namprd03.prod.outlook.com
 ([fe80::4b7:376:c5f2:3891%3]) with mapi id 15.20.4242.023; Fri, 9 Jul 2021
 08:23:05 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "charles-antoine.couret@essensium.com" 
        <charles-antoine.couret@essensium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH v1 3/4] iio: adc: ad7949: add support for internal vref
Thread-Topic: [PATCH v1 3/4] iio: adc: ad7949: add support for internal vref
Thread-Index: AQHXdFTvvGOrg2VPB0ms5nxkbdI4qKs6Tbqg
Date:   Fri, 9 Jul 2021 08:23:05 +0000
Message-ID: <PH0PR03MB636680DD9F9530464FEBB7C399189@PH0PR03MB6366.namprd03.prod.outlook.com>
References: <20210708235618.1541335-1-liambeguin@gmail.com>
 <20210708235618.1541335-4-liambeguin@gmail.com>
In-Reply-To: <20210708235618.1541335-4-liambeguin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZTEyOGQ5MTQtZTA4ZS0xMWViLThiNzEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGUxMjhkOTE2LWUwOGUtMTFlYi04YjcxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iNjc5OSIgdD0iMTMyNzAyOTI1OD?=
 =?iso-8859-1?Q?QyNjUzMzQ1IiBoPSJ6QUVidlh5dG40eXZibGFoTzExeEFsSHJhRHM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FJWURBQUNob0lHam0zVFhBVnlQaGxtRk5LVGZYSStHV1lVMHBOOEZBQUFB?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 257808ad-f18e-43e4-8e12-08d942b2c6e6
x-ms-traffictypediagnostic: PH0PR03MB5750:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR03MB5750587A5AC2B004A47C6ABC99189@PH0PR03MB5750.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qcBd/hFySBVKpUfKncq29PKgyVggWyUOa+UvgVIlGSJzw+v2FN09jb4nVO73+D/gVBwelsSZl4QGgnjn5EtKx8Zfqr2powVdI8E6ApR84myWtkKFmHIePJ/WYZhZ014ZDLV1QOOyY3C7y/S7xNyNw2O8N5rBXc+4Tjf/8RPTAxBRAEJpcoYADgEOkSf7ESopEwXf4Adjh/M6Ai9iHlYnL4ltMmXkKr0Z5iLu2xDiQ1BZpw0ftuCpElH3aQ8T+4cp/Tkscsv+1+Gj+oVG39ChEnat1CRFlXhubbXwzj/kmRWE73Ee/5wu/Z486qZRRiDmFlGzqam/eR+gMnkrZpu7mwsjKK8K0/6lqpKfrC5YsADUyXjy8e8JDd78GLIg+vz4d6RLuR+WC/g/bo7EXD9CEWtFebru+siSxp+qLqcO1d97xqjzY2hkBOPpKdkYxeGCnjUv2fQD6m4oBMJgnZPScnkq46hFprJuQ/YiKUPfLttnkLG6LLvqt/sAiq+nOv0J/Yq3Bi3uq5HDesumQ51IFccDLthfl1Yeybxfn2YaY/McgJ+fPQXkdkI3l9+1vMRLtosyLRbEOqMvejBnXCFnOBdXVzU7JEdeFw8j94zG1lTBsFbK827OYkBf2Big0HVceYe4DSyrDh85P7vsZ6O2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6366.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(6506007)(186003)(33656002)(478600001)(122000001)(54906003)(76116006)(38100700002)(8936002)(53546011)(8676002)(71200400001)(86362001)(5660300002)(4326008)(66946007)(66556008)(110136005)(83380400001)(7696005)(316002)(66446008)(64756008)(66476007)(52536014)(9686003)(2906002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aHGlQkP+GkzQQ9KTSiDZoSX4S70Wvqhx8XQcWOiHgWCU78Y6e7JHzGy8PF?=
 =?iso-8859-1?Q?D5yUIzF7QjXxKaDchi9rkKUkXtkTm3Pbe6ifCqeKJDuNO28PQxSR61f1fS?=
 =?iso-8859-1?Q?5G+nKDryMLF5ud5LXkAni7d5BflSb1vU8HK98Ds/asHR3gWW56dl9B55ji?=
 =?iso-8859-1?Q?Qjacc2ORJjE35v9+O/ggmkW87FWY3BBUPif6RMSID13M20Kf0dbUy6w0qC?=
 =?iso-8859-1?Q?/K++tCOw+2CueAlDBi7lSyyfCqOsrAs72VC84D5EXJDSQFhmMjADuLsSvC?=
 =?iso-8859-1?Q?jkn++O+ZibEhQ0thNBTNxM7mI0OtrCKTsW3msVz51+XAM7/3aKGXO8shJo?=
 =?iso-8859-1?Q?Jz5Axf2+SSrS/s+MoeAaqgYUBNf/tR+qvate5S+ZpXjjsS5HFT8n6Y8DYp?=
 =?iso-8859-1?Q?JyNHRadAUFdHs+/U2ECSW7wtBr21qINSTo/wIfbQa4XQ4GAuDRr0jBprhj?=
 =?iso-8859-1?Q?JoUZ/YWL+xlrDVyufyddcS0z6FUpJrf4w49sdmvyLmbviy1xi4is2gvt7O?=
 =?iso-8859-1?Q?XAwdtHG3Ejsd9Udaczd6GD3cc72PYVQ0FVLip3aSZTMH92xq4UAOqHcLTc?=
 =?iso-8859-1?Q?lR7TKeUrcQYSFkW/C14IYgsTteHkqRdgiwu9DFU9n/C/9/8BUg3CFnxR3h?=
 =?iso-8859-1?Q?9wC0dCysyAaYIFwAsSMBSN1IJGUEogtaYqf55pwK97iJfSqrYHG9MnAeJi?=
 =?iso-8859-1?Q?3po1HAmtM7i3hCAc7V0S9tg+XD37nzVVRIQ2YI6oce+oI978kyeJ83uu82?=
 =?iso-8859-1?Q?otjbBOohgBt2b7y7IP39aZU2x4BK6+1RgBOPEeeHxy7W1FKdo4Vp/cKNWn?=
 =?iso-8859-1?Q?uiLpE13A6chHaii3OQYuPbCLFFutBCwumfTHqIwESgyAngKOtTZ6nPtIWX?=
 =?iso-8859-1?Q?liwv8UckbItmAllmMOUuYMejXZqBfWYMm+gI2y67Js2mLrmfRforUNB21x?=
 =?iso-8859-1?Q?LkhpJnhNmHXGYIf+hvoXyofzNvODG/H4NrVG3CtvgXRFh02Lx5DatQ5ZHm?=
 =?iso-8859-1?Q?Id3QzvHYNIAYcMimeSNE9OycXQ3SOyS2DMpUuGssw9q5w6frPSToGt1DQb?=
 =?iso-8859-1?Q?G8FmJtqcUTZf33XBc3erK1a5SKvQA2wI5coNJ3PFWRrOEfvxxL41G31iSx?=
 =?iso-8859-1?Q?JIFzZHID+X+Xyy6q3T0g2xC2Ts8rFQQ1YFoWcSGBhlEZb2LxV+YvS5I/0K?=
 =?iso-8859-1?Q?dRebtdV9vzvg57a8TNCMlvOZvJ3b67N28nhbLsOE+DDY1tAP5Hw+a+CVR7?=
 =?iso-8859-1?Q?ZVPDzj5qToIGdCx08u636Je5Sbe9+loX3rQxkptIG3mvBn+fIelSM4QWzr?=
 =?iso-8859-1?Q?WDCdv0gZHrsiY0xQ1q6fwPIiMEEP8SrBdr2goqL0hy0Ni0vHQJ1iLqDvNY?=
 =?iso-8859-1?Q?9wJM4mF2yOD0K9HdcDvrOAVnK7g0D+2poIbmxC8o9ui2jjldRS26ODsYJ/?=
 =?iso-8859-1?Q?08VGZurziQjETCHK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6366.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257808ad-f18e-43e4-8e12-08d942b2c6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 08:23:05.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vsbd01+2Z3kECCBWDiRV30wHTwXnLV/J56xI18yCjSeb9iOPkxVdX6QooiMmvBllEEy06J4xopILtysra0TR5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5750
X-Proofpoint-ORIG-GUID: VFHvzckyoA09YE9s5Y3TOjNls_U5EMek
X-Proofpoint-GUID: VFHvzckyoA09YE9s5Y3TOjNls_U5EMek
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_04:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Liam Beguin <liambeguin@gmail.com>
> Sent: Friday, July 9, 2021 1:56 AM
> To: liambeguin@gmail.com; lars@metafoo.de; Hennerich, Michael
> <Michael.Hennerich@analog.com>; jic23@kernel.org; charles-
> antoine.couret@essensium.com
> Cc: linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org
> Subject: [PATCH v1 3/4] iio: adc: ad7949: add support for internal vref
>=20
> [External]
>=20
> From: Liam Beguin <lvb@xiphos.com>
>=20
> Add support for selecting a custom reference voltage from the
> devicetree. If an external source is used, a vref regulator should be
> defined in the devicetree.
>=20
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/adc/ad7949.c | 84
> +++++++++++++++++++++++++++++++++-------
>  1 file changed, 69 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index bbc6b56330a3..3c1293922d2e 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -31,6 +31,7 @@
>  #define AD7949_CFG_VAL_BW_FULL			1
>  #define AD7949_CFG_VAL_BW_QUARTER		0
>  #define AD7949_CFG_BIT_REF		GENMASK(5, 3)
> +#define AD7949_CFG_VAL_REF_EXTERNAL		BIT(1)
>  #define AD7949_CFG_BIT_SEQ		GENMASK(2, 1)
>  #define AD7949_CFG_BIT_RBN		BIT(0)
>=20
> @@ -40,6 +41,33 @@ enum {
>  	ID_AD7689,
>  };
>=20
> +/**
> + * enum ad7949_ref - Reference selection
> + *
> + * AD7949_REF_INT_2500:     Internal reference and temperature
> sensor enabled.
> + *                          Vref=3D2.5V, buffered output
> + * AD7949_REF_INT_4096:     Internal reference and temperature
> sensor enabled.
> + *                          Vref=3D4.096V, buffered output
> + * AD7949_REF_EXT_TEMP:     Use external reference, temperature
> sensor enabled.
> + *                          Internal buffer disabled
> + * AD7949_REF_EXT_TEMP_BUF: Use external reference, internal
> buffer and
> + *                          temperature sensor enabled.
> + * AD7949_REF_RSRV_4:       Do not use
> + * AD7949_REF_RSRV_5:       Do not use
> + * AD7949_REF_EXT:          Use external reference, internal buffer and
> + *                          temperature sensor disabled.
> + * AD7949_REF_EXT_BUF:      Use external reference, internal buffer
> enabled.
> + *                          Internal reference and temperature sensor di=
sabled.
> + */
> +enum ad7949_ref {
> +	AD7949_REF_INT_2500 =3D 0,
> +	AD7949_REF_INT_4096,
> +	AD7949_REF_EXT_TEMP,
> +	AD7949_REF_EXT_TEMP_BUF,
> +	AD7949_REF_EXT =3D 6,
> +	AD7949_REF_EXT_BUF,
> +};
> +
>  struct ad7949_adc_spec {
>  	u8 num_channels;
>  	u8 resolution;
> @@ -55,6 +83,7 @@ static const struct ad7949_adc_spec
> ad7949_adc_spec[] =3D {
>   * struct ad7949_adc_chip - AD ADC chip
>   * @lock: protects write sequences
>   * @vref: regulator generating Vref
> + * @refsel: reference selection
>   * @indio_dev: reference to iio structure
>   * @spi: reference to spi structure
>   * @resolution: resolution of the chip
> @@ -66,6 +95,7 @@ static const struct ad7949_adc_spec
> ad7949_adc_spec[] =3D {
>  struct ad7949_adc_chip {
>  	struct mutex lock;
>  	struct regulator *vref;
> +	enum ad7949_ref refsel;
>  	struct iio_dev *indio_dev;
>  	struct spi_device *spi;
>  	u8 resolution;
> @@ -241,12 +271,28 @@ static int ad7949_spi_read_raw(struct iio_dev
> *indio_dev,
>  		return IIO_VAL_INT;
>=20
>  	case IIO_CHAN_INFO_SCALE:
> -		ret =3D regulator_get_voltage(ad7949_adc->vref);
> -		if (ret < 0)
> -			return ret;
> +		switch (ad7949_adc->refsel) {
> +		case AD7949_REF_INT_2500:
> +			*val =3D 2500;
> +			break;
> +		case AD7949_REF_INT_4096:
> +			*val =3D 4096;
> +			break;
> +		case AD7949_REF_EXT_TEMP:
> +		case AD7949_REF_EXT_TEMP_BUF:
> +		case AD7949_REF_EXT:
> +		case AD7949_REF_EXT_BUF:
> +			ret =3D regulator_get_voltage(ad7949_adc-
> >vref);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* convert value back to mV */
> +			*val =3D ret / 1000;
> +			break;
> +		}
>=20
> -		*val =3D ret / 5000;
> -		return IIO_VAL_INT;
> +		*val2 =3D (1 << ad7949_adc->resolution) - 1;
> +		return IIO_VAL_FRACTIONAL;
>  	}
>=20
>  	return -EINVAL;
> @@ -285,7 +331,7 @@ static int ad7949_spi_init(struct
> ad7949_adc_chip *ad7949_adc)
>  		FIELD_PREP(AD7949_CFG_BIT_INCC,
> AD7949_CFG_VAL_INCC_UNIPOLAR_GND) |
>  		FIELD_PREP(AD7949_CFG_BIT_INX, ad7949_adc-
> >current_channel) |
>  		FIELD_PREP(AD7949_CFG_BIT_BW,
> AD7949_CFG_VAL_BW_FULL) |
> -		FIELD_PREP(AD7949_CFG_BIT_REF,
> AD7949_REF_EXT_BUF) |
> +		FIELD_PREP(AD7949_CFG_BIT_REF, ad7949_adc-
> >refsel) |
>  		FIELD_PREP(AD7949_CFG_BIT_SEQ, 0x0) |
>  		FIELD_PREP(AD7949_CFG_BIT_RBN, 1);
>=20
> @@ -304,6 +350,7 @@ static int ad7949_spi_init(struct
> ad7949_adc_chip *ad7949_adc)
>  static int ad7949_spi_probe(struct spi_device *spi)
>  {
>  	struct device *dev =3D &spi->dev;
> +	struct device_node *np =3D dev->of_node;
>  	const struct ad7949_adc_spec *spec;
>  	struct ad7949_adc_chip *ad7949_adc;
>  	struct iio_dev *indio_dev;
> @@ -315,6 +362,7 @@ static int ad7949_spi_probe(struct spi_device
> *spi)
>  		return -ENOMEM;
>  	}
>=20
> +	indio_dev->dev.of_node =3D np;

Why doing this? The IIO core will do it for us at register time.

>  	indio_dev->info =3D &ad7949_spi_info;
>  	indio_dev->name =3D spi_get_device_id(spi)->name;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> @@ -330,16 +378,22 @@ static int ad7949_spi_probe(struct spi_device
> *spi)
>  	ad7949_adc->resolution =3D spec->resolution;
>  	ad7949_set_bits_per_word(ad7949_adc);
>=20
> -	ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> -	if (IS_ERR(ad7949_adc->vref)) {
> -		dev_err(dev, "fail to request regulator\n");
> -		return PTR_ERR(ad7949_adc->vref);
> -	}
> +	/* Set default devicetree parameters */
> +	ad7949_adc->refsel =3D AD7949_REF_EXT_BUF;
> +	of_property_read_u32(np, "adi,reference-select",
> &ad7949_adc->refsel);

In case the property is given, we should make sure we get a valid
value and error out if not...

- Nuno S=E1
> -	ret =3D regulator_enable(ad7949_adc->vref);
> -	if (ret < 0) {
> -		dev_err(dev, "fail to enable regulator\n");
> -		return ret;
> +	if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
> +		ad7949_adc->vref =3D devm_regulator_get(dev, "vref");
> +		if (IS_ERR(ad7949_adc->vref)) {
> +			dev_err(dev, "fail to request regulator\n");
> +			return PTR_ERR(ad7949_adc->vref);
> +		}
> +
> +		ret =3D regulator_enable(ad7949_adc->vref);
> +		if (ret < 0) {
> +			dev_err(dev, "fail to enable regulator\n");
> +			return ret;
> +		}
>  	}
>=20
>  	mutex_init(&ad7949_adc->lock);
> --
> 2.30.1.489.g328c10930387

