Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9063CFB6D
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 15:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhGTNPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 09:15:25 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:59462 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238522AbhGTNGL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 09:06:11 -0400
X-Greylist: delayed 728 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jul 2021 09:06:11 EDT
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KDUHo6000309;
        Tue, 20 Jul 2021 09:34:38 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-00128a01.pphosted.com with ESMTP id 39wjfka5m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 09:34:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl8jGfp5Y1KgV3ciNqk5k5oSh6oTJNC1jvXXHomDm+Oe2sV1BQNRJDD/H+UFm3b8Gl0aQhdf2VMBBI7jNDA4dvBlkPARCmtqQemltINFmrfsJJGyCWRVjYFxKHJG+p2sOpgJnHQB37RxmgJwgwlCdkuzqNw/GADij82Cw/8XFtYC1WNhaSA7z+/E4jLDL8+b3gHL9GDSJkR4n/PI9jHzKGkYLGblN37tQkT5Kuk5JVgMDbL2qc0Zng/9OzOTHpsZdS0JkfGX0Da0WvFtSDUbU05ur/Pgebknga0OJQd3ehTEksUDeyQuy9ppafVQN+UEKUG+1BRih6vtMrnsQlw+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJzGbPyocxOywWpYvuRupA+ahD7v9ufoXHAfAlJOU10=;
 b=NxadESB46fyit3ndoRs53A1NpZyNn4EBCAsPBytY9PBnfoAppMafyCag9H3DBT78maEOQJ9vTxeY2g0UsGRna+1smX3JWHJyJf0PFFVuQ5p/BMiTS7ih1cZCROu6LU7RBQzUiRjBlb7C/Q0tERcSlL9a6ub/1VP1tL11OzvW7HPuiCLRNU5IG92tqgMRG8NRaw61hmBorjuip6x4dej1S+GAN78G6+1+/ce/Bf2vXOLRA7tLnL1yo6PWqXVS/4mWbAsRF4EGmcQC38rPfY9MSGHsbB7f3mbbeXvEi1IFcNQcM0HAjiQQ6/RQa6YqP6TsSrn96j2yS5qyzeeo28G7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJzGbPyocxOywWpYvuRupA+ahD7v9ufoXHAfAlJOU10=;
 b=8BytcmZ9DEPz0/5ybTtB7KwQadCHifljD+QStbXt1Hq+EcnusdA7S0Ma9+99SYF2KYIJaF3U/tNjiZsTkq74pnO6c9L0tgBnbsNjgTANjJ0SxVByxpjkq1/4Xsxe+9bOp4HpXYNQpWozHAs5i+65/2dBHoKXU5EXHKQFLZSAPEg=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY4PR03MB3317.namprd03.prod.outlook.com (2603:10b6:910:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.25; Tue, 20 Jul
 2021 13:34:09 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 13:34:08 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] iio: frequency: adrf6780: add support for ADRF6780
Thread-Topic: [PATCH v6 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Thread-Index: AQHXejemy+Zld3yeGkqXu4f9qC/DS6tHKjyAgAS3GWA=
Date:   Tue, 20 Jul 2021 13:34:08 +0000
Message-ID: <CY4PR03MB3399CAA3C32707CE3564A44B9BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
 <20210717142623.45f96a22@jic23-huawei>
In-Reply-To: <20210717142623.45f96a22@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0yNzJjNTU3MS1lOTVmLTExZWItYWI5MC?=
 =?iso-8859-2?Q?0xNGFiYzVmM2QzMjhcYW1lLXRlc3RcMjcyYzU1NzItZTk1Zi0xMWViLWFi?=
 =?iso-8859-2?Q?OTAtMTRhYmM1ZjNkMzI4Ym9keS50eHQiIHN6PSI0Njg3IiB0PSIxMzI3MT?=
 =?iso-8859-2?Q?I2MTY0NjU5MDMwMTYiIGg9IlVOaHVxc2RSdjZIUC9rTC80Ri94aXFpNlEy?=
 =?iso-8859-2?Q?OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUlZREFBQ29yYW5wYTMzWEFZaHUxSmQ2OThLeWlHN1VsM3Izd3JJ?=
 =?iso-8859-2?Q?RkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBRG11ZHRRQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJQWFRQmhBRj?=
 =?iso-8859-2?Q?hBWkFCcEFHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJsQUhJQU1R?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tB?=
 =?iso-8859-2?Q?WXdCMEFHa0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f6078f0-3482-4b8b-4672-08d94b830d90
x-ms-traffictypediagnostic: CY4PR03MB3317:
x-microsoft-antispam-prvs: <CY4PR03MB33174FAD37150AC9AEABB6589BE29@CY4PR03MB3317.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJoEC0fN+C/j6SaoME3F1tg3gfh8NEcXzRMYpSCUe3Wt7vcxh15quoc+4Q4az9SbYhyP+Z1y+Tf1hXMH7VMVB/H9euxs00XAWb9hr/LMg/xUlWMd3jPykUilLeYh4ElnXpOr8L5cfPFnZk7ommp8Ekqwvek0j+nw3hJc3mTlSrsQhL0qoFBioto23lQ2TiKWCnNqT0A+7W8DdELpy/UnRGa+dnSsu+t8f6cKEMmejsBjfA+hVdEMo3CS5CTD1k627E6iYGOWQ4+CsNfeX29VefVpMlL3FtiFRcSE43IXpkllYql30EUEW6tvH21u+L67tJ0reGyET55wn1SoxnwteJ9Yj7uBa16S+mtJFcwVHZOiHyspejRqUyxtsEEfgcxAflEdA+x+mnHetuF/DvodlO5YUipNbVeFzP58Ch25tUNfk4tehZae5qgosekxyjYc3Hi5XVPac7u3u3Wh/XceDNIP1WMK3oNYWs74YosBil5IB+RDIR78EUA+A83eFY+ZVrY1s4v3xj0gi6T06gySS/NkyWeoioAKZktq11q0XoUMGLdv/7OZTwI+d3GVyTiuJOarJamkY6ZZFilT/k03r1EhIflJwlaHnA2NeyWwfY2W8S9yhmanaNsgHrrTk0ba8dyNoJAaE/wc/gZDSSMU48RXsTah1DGlWt7bGCtz3zGK6Ds/WoPvT91sWzJpzIRBLXCQhp8WxbzgvcOFZr2mdqUOIfViAQt9DNQgaGXUqrgcXuQfqXbMocxF+6UEqQTrDfNjEqg6wgrdcABBC1NU2AY5595rsNsbCX8ArhUdk+w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(83380400001)(33656002)(26005)(76116006)(71200400001)(122000001)(186003)(316002)(8936002)(478600001)(2906002)(86362001)(38100700002)(4326008)(66446008)(5660300002)(66574015)(6916009)(7696005)(64756008)(66556008)(9686003)(54906003)(966005)(52536014)(6506007)(8676002)(66946007)(55016002)(66476007)(53546011)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?QygXgiThupRQaEyJ/edbkP7D3PgZYvk5xsgvWQsZLaLsKoumY3eObo1iR3?=
 =?iso-8859-2?Q?nS0Gtv+ttEmKg2BXqgXAxQ8YD6t1sy2/WXiXx1U2raqs6UXhojj1VBEUED?=
 =?iso-8859-2?Q?R/RQCjtgwmu2FIFxc0EATlnz/hgOwA00n+TjxMHEa2y8VZyv27pAK+zduF?=
 =?iso-8859-2?Q?B7EpvHgGL970rdpuU4tt1TkYdhaEFE5XLizuPYcCnvHgMY2XE6IaNBD/RM?=
 =?iso-8859-2?Q?wsXl9pl2ZBehnqG5vjPo+rSo+5bk39urMNBdFWw/HlPO1NG/V5Rf2AaIpt?=
 =?iso-8859-2?Q?BA3RcGMw7V4CBUYskDgDOhg6FPG4GAzLoN0XPDQl+dE/5Va33L5VRCJwuQ?=
 =?iso-8859-2?Q?Wo5RkOyLYSS41zIWs70EJo3yRQl2Uq9Y2rQ/3qkLt5uqRJWhTGj026/6w4?=
 =?iso-8859-2?Q?bATmeFp1CpCdYJd3UVsgLkuysVK5AEmuyzOsiX6fJkJ3oKlVdB7F2Mz4Mr?=
 =?iso-8859-2?Q?8kgqt11huRQSM5gUcUIsg6m7bN2llKbX0kTrUCaP7f/AOgW0YyHsnzym/a?=
 =?iso-8859-2?Q?FrU/pADwt9f8/YMD2WDNgPWvCcikPnNvdvutcsKQrcZ2BIjyYnzgQyOxpy?=
 =?iso-8859-2?Q?iIw3Cavy1Ueb0l4vjtkH2Th0SdCcKMjF8NfT1ywe5IO9MT0NXHGn3fwlcG?=
 =?iso-8859-2?Q?Be5BHG2RGEQlpA8kR/XnASZiDJZvly0NgJY+DZfdBG8GgDCLELPUlV+t0+?=
 =?iso-8859-2?Q?AczyuSMN7OPvDRYITGo0NZsiNqkMwGI5dUNxRVGaCf0Q1NSKBpflxGV9Uh?=
 =?iso-8859-2?Q?ckmoHyyR8Fp+JyXCv7vmramHeLbT9ATdP/YcQyUhWUeDoYzjDr2xyNA7jo?=
 =?iso-8859-2?Q?opdkGPCwH56RFYWznjGB6xDTqEwu+gpF61PkZn9YUd1zV6OyqCGFXgaFQ9?=
 =?iso-8859-2?Q?pOnxl2fYBaQ7Y6Yv0kRtEiDSu616+n1nqWbQ5Po1NSv4xhK1Xs/T/gnmkV?=
 =?iso-8859-2?Q?nbgqV9opVTdEX+7Vuq39v073yVsw2XGhQD2ghDdHKD9j30nbke/9eee1Jm?=
 =?iso-8859-2?Q?vB9byxZxfwW7KK9y0AsYZekja9zT4tooemEUHFQc2+hj68mEbgbLi0CSPG?=
 =?iso-8859-2?Q?JG0UKDKQGbeFpXGP7xxRe33draIpBU7qwEqTm5V3Ea8a10fbwF2vrRoTcx?=
 =?iso-8859-2?Q?k/193MRpgjDRiQgsH5FcvfdqpedmqyYQoBRnTZQv9mUYegJ61frBuST0EC?=
 =?iso-8859-2?Q?dA4eP67GFs91WcFuTxYQl2CK4sX0woip5oKn05EfgAyhf+X5s5Uy0X8k63?=
 =?iso-8859-2?Q?6RsPaaqxioU9O9/KtgI5yb3dXRij69Unf9rB3p8u5t8Sg37JrOu6wQ/S1L?=
 =?iso-8859-2?Q?qADkoWZGoBXmIVP1fbw2ikzTKBFKlk9Ig+Rnj435zUH5DREjnK8K3LiVdi?=
 =?iso-8859-2?Q?o5CI1fAL6H?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6078f0-3482-4b8b-4672-08d94b830d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 13:34:08.9444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WckTDJfVyLo9kZnM31Um0tr1MRcoLzjoAP/kFfRtz9aS+2fTTi2C8sP3EM3awAVKTQlzIpbDuufRThBHp8PEsknqzrk9ro2QncV/lKRpedM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB3317
X-Proofpoint-ORIG-GUID: PTaJ92YB2WrKs08ZXvt8IxdHryAh2xFk
X-Proofpoint-GUID: PTaJ92YB2WrKs08ZXvt8IxdHryAh2xFk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_07:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200087
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,


> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, July 17, 2021 4:26 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org
> Subject: Re: [PATCH v6 1/2] iio: frequency: adrf6780: add support for
> ADRF6780
>=20
> [External]
>=20
> On Fri, 16 Jul 2021 14:42:09 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> > microwave upconverter optimized for point to point microwave
> > radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> > range.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/ADRF6780.pdf
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Hi Antoniu
>=20
> As it looks like we'll have a v7, a few trivial comments from me.
>=20
> ...
>=20
> > +
> > +static int adrf6780_init(struct adrf6780_dev *dev)
> > +{
> > +	int ret;
> > +	unsigned int chip_id, enable_reg, enable_reg_msk;
> > +	struct spi_device *spi =3D dev->spi;
> > +
> > +	/* Perform a software reset */
> > +	ret =3D adrf6780_reset(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D adrf6780_spi_read(dev, ADRF6780_REG_CONTROL, &chip_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	chip_id =3D FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
> > +	if (chip_id !=3D ADRF6780_CHIP_ID) {
> > +		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	enable_reg_msk =3D ADRF6780_VGA_BUFFER_EN_MSK |
> > +			ADRF6780_DETECTOR_EN_MSK |
> > +			ADRF6780_LO_BUFFER_EN_MSK |
> > +			ADRF6780_IF_MODE_EN_MSK |
> > +			ADRF6780_IQ_MODE_EN_MSK |
> > +			ADRF6780_LO_X2_EN_MSK |
> > +			ADRF6780_LO_PPF_EN_MSK |
> > +			ADRF6780_LO_EN_MSK |
> > +			ADRF6780_UC_BIAS_EN_MSK;
> > +
> > +	enable_reg =3D FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, dev-
> >vga_buff_en) |
> > +			FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, 1) |
> > +			FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, dev-
> >lo_buff_en) |
> > +			FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, dev-
> >if_mode_en) |
> > +			FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, dev-
> >iq_mode_en) |
> > +			FIELD_PREP(ADRF6780_LO_X2_EN_MSK, dev-
> >lo_x2_en) |
> > +			FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, dev-
> >lo_ppf_en) |
> > +			FIELD_PREP(ADRF6780_LO_EN_MSK, dev->lo_en) |
> > +			FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, dev-
> >uc_bias_en);
>=20
> Here we are probably turning on a bunch of stuff which will result in pow=
er
> usage.
> Would it be sensible to turn it off again in remove path?  (devm managed
> should be fine).

Most of these attributes are enabled by default after device reset.
Taking into account this statement, is it still worth adding a 'custom' rem=
ove path?

>=20
>=20
> > +
> > +	ret =3D adrf6780_spi_update_bits(dev, ADRF6780_REG_ENABLE,
> enable_reg_msk, enable_reg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
> > +
> 	ADRF6780_LO_SIDEBAND_MSK,
> > +
> 	FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, dev->lo_sideband));
> > +	if (ret)
> > +		return ret;
> > +
> > +	return adrf6780_spi_update_bits(dev,
> ADRF6780_REG_ADC_CONTROL,
> > +
> 	ADRF6780_VDET_OUTPUT_SELECT_MSK,
> > +
> 	FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, dev-
> >vdet_out_en));
> > +}
> > +
>=20
> > +static void adrf6780_dt_parse(struct adrf6780_dev *dev)
>=20
> Trivial nitpick, but given this is all device property based (great)
> the dt naming is now misleading.  Perhaps _properties_parse() ?
>=20
> > +{
> > +	struct spi_device *spi =3D dev->spi;
> > +
> > +	dev->vga_buff_en =3D device_property_read_bool(&spi->dev,
> "adi,vga-buff-en");
> > +	dev->lo_buff_en =3D device_property_read_bool(&spi->dev, "adi,lo-
> buff-en");
> > +	dev->if_mode_en =3D device_property_read_bool(&spi->dev, "adi,if-
> mode-en");
> > +	dev->iq_mode_en =3D device_property_read_bool(&spi->dev, "adi,iq-
> mode-en");
> > +	dev->lo_x2_en =3D device_property_read_bool(&spi->dev, "adi,lo-x2-
> en");
> > +	dev->lo_ppf_en =3D device_property_read_bool(&spi->dev, "adi,lo-
> ppf-en");
> > +	dev->lo_en =3D device_property_read_bool(&spi->dev, "adi,lo-en");
> > +	dev->uc_bias_en =3D device_property_read_bool(&spi->dev, "adi,uc-
> bias-en");
> > +	dev->lo_sideband =3D device_property_read_bool(&spi->dev, "adi,lo-
> sideband");
> > +	dev->vdet_out_en =3D device_property_read_bool(&spi->dev,
> "adi,vdet-out-en");
> > +}

--
Antoniu Micl=E3u=BA
