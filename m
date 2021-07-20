Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97713CFBB8
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jul 2021 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbhGTNcm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Jul 2021 09:32:42 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:13028 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239159AbhGTN1K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jul 2021 09:27:10 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KDtJiS001700;
        Tue, 20 Jul 2021 10:05:41 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 39wpv4sj3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 10:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjjkudX17ee4K26/CPNSie1ishLONOzEwhSLTD47sqWk3Hpc3iLl1rpIm7mp92kcdRJrQqmHXlzlDGoxdwsVVIbv86DJaReIHwx7YsVdB75KLVv6LTmfiNjx4t2SWXvGnBJJzMzzhMNyKSriMAr027UeGI3A85dnc9rquvWUW4BxJjFzNQmQ1TFJvbUITQUAlIS87mSmNFhOi5weWVYA9fBb5XDccd/d+kPPh7DfeYWsGuzsQnz0d/1NK0Cq6kByyiO//N76i8bJVZixXao7o0YJGi2MbCtdFEtIE6MKV0dnNgMho0PhNtJ3z7HxfgBrqy840HJUBUmhnWBcdru2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iwxD9Udpprpn6iHz9l6xyi611+bxTWMumnuj4ZYrNU=;
 b=GhfG5U6DBs5rruu7o9GWjphYRfadgRUDkrXY/yNxICYHG7PanJvnflis273snt9fJP6XajBm5Q2xFslBQBXiyDxPYujZUuDtQ50d9m4MkvXV/CYMZjkOGmMtfM2rdia4JVL2hivhjzAkUlcrnHzMKfCqUDm+uh+FoFf0bnHnPyb6xzvHlosh+TtXvqKYb71hCXmHcssMIiiusYJZPFwx0JC+HiBYsHoooKdCEAJqtP8Nu/2JnnTlz9XE9oqM9JzWinVhGz2XaUvwO5qyoiSgEWHcWkMz3iaSCBJIYjP5LkjYlsN7/e3+4Z2fHMjmDmoxkMatv3SjA1buapAsrJlReg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iwxD9Udpprpn6iHz9l6xyi611+bxTWMumnuj4ZYrNU=;
 b=UV6sZe4kZXJI/z+i4dbZgaQTZS7k1qDRbXH6yacYpUKRJSxhobXezdSUl6aNevNXXVERgv5Zdw/Ur3cWwS3Db68MMu+k3LZgMbeq6mYJpbPDmFrBm9okMzcO1y0OOdI08I7DMj2imcHUR/UyrF5qdDH0YoMDeqXLRk2F6N/br/A=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY4PR03MB2678.namprd03.prod.outlook.com (2603:10b6:903:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Tue, 20 Jul
 2021 14:05:37 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::d078:2202:7a5c:8e39%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 14:05:37 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "Thahirally, Murtaza" <Murtaza.Thahirally@analog.com>
Subject: RE: [PATCH v6 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Thread-Topic: [PATCH v6 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Thread-Index: AQHXejersv6azsH4QE2O3EtGyv01VatHObeAgASqeIA=
Date:   Tue, 20 Jul 2021 14:05:37 +0000
Message-ID: <CY4PR03MB3399B0CC076ED48608B681649BE29@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
        <20210716114210.141560-2-antoniu.miclaus@analog.com>
 <20210717152147.01f0cae9@jic23-huawei>
In-Reply-To: <20210717152147.01f0cae9@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Murtaza.Thahirally@analog.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04ZDBlODJjNi1lOTYzLTExZWItYWI5MC0xNGFi?=
 =?us-ascii?Q?YzVmM2QzMjhcYW1lLXRlc3RcOGQwZTgyYzctZTk2My0xMWViLWFiOTAtMTRh?=
 =?us-ascii?Q?YmM1ZjNkMzI4Ym9keS50eHQiIHN6PSI3MDU0IiB0PSIxMzI3MTI2MzUzNTUx?=
 =?us-ascii?Q?NTMzMjkiIGg9IklOK2dRRUxkZnBOSjZMV1VacENqMWlEbnpocz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUlZREFB?=
 =?us-ascii?Q?Q3h3NHhQY0gzWEFlSjc5UW8wS3lHQzRudjFDalFySVlJRkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRG11ZHRRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJ?=
 =?us-ascii?Q?QWFRQmhBRjhBWkFCcEFHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJs?=
 =?us-ascii?Q?QUhJQU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tB?=
 =?us-ascii?Q?WXdCMEFHa0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d319fb4-6804-4f8e-ed4e-08d94b877363
x-ms-traffictypediagnostic: CY4PR03MB2678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR03MB2678686B091B272ED1741DEE9BE29@CY4PR03MB2678.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnX5sUuLefp32XUu4cmjVGN39PkIDU0pnfxMgShsJJ8oCYVlMqx1p9x1FNu36dwn+W1i/qezyvA0oTydJqzmgJA0nHuL5UASSlCopy6FQdEo7QrRxfmGz+gFOrgwUOIfX6JMDaObWmj6nyteimbkuMxQt6AeHI3GB4iAdjdwvGXvuT8eCrRE0jYCqlTs4ST7QMXhPyW3XB0I3G4MX+YgI6WN0c5rDuRHWX3rhsB60wL9guGPYNYUqs+dtoSjhmbNYtRzUQIds8Xi/O7Kwo5LWMES4IDWF2lNNojezmXpTb698d5BWio+WEG87ZZPrVW1EQurizfrbE3k/YHufTilMXLiXSkxBf6iBHoqwyGlHtNkGcSZw1u60h1faY6bCdv0heXHSg9igTNW3DKODTjuvc0Oy0Tsj9s+R+E/76cH8qLCo3xnXrDADE+6UW8ElzOmbybLnSNKOMwNjRiv5W7i3IHUJbMK3aAiZqby+ts6apj+llNLCzp5bK4n3ttKoouZy+Yb3C7mF6cssPVVRqBx8PPvp8IGJOil+pCkn+FPpH9576khzBkr0Kwr1xeLZaAZjQKmRO9HDprVSpsIXYFP1RCp8HOWA+l0DmyQTOiWJ0ZswgOsTd5yRFIAXcbfsVHRrKpKDROUSkjFJ0f97+jyY1mDSw2REFniFwisOxcM8qdLqgH5b9y8vBgZRHBj3Lc/CuDDmqA9+bwn+YiEUF2LAHXa6EHieNryTeLnPHjPXodMNvNvIbOQZH16JrxA4+ZFVUg2zboaSxlURN6abKG9TzkSbE+JPz8X1psH3D7Ck3WE9JLa6b7w+VDmLwNytvW9tw3FFoX941uKdk7uxFc7ZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(107886003)(4326008)(9686003)(5660300002)(66556008)(76116006)(64756008)(316002)(66476007)(66946007)(66446008)(8676002)(2906002)(478600001)(33656002)(38100700002)(8936002)(7696005)(71200400001)(83380400001)(54906003)(6506007)(86362001)(26005)(966005)(55016002)(53546011)(52536014)(6916009)(186003)(122000001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SESOpZC8vbbyWyo9iIXHVggBoIx/p+N07JP7U8Vb2xA1IXV7RGyuheRPaj7H?=
 =?us-ascii?Q?MgLWmBZ5d+rmunF3voHrzU6uENkXCl47HFqoVXEJBWCMFNm/zFV8XYgntzV/?=
 =?us-ascii?Q?btoVhPhgolVWRni1a229aR6V1JcGJDdJdn+ksAiCkzpBPIA1ymeScgS55iIa?=
 =?us-ascii?Q?FeK4FhBgRWePRKxgnZ5Ne3Sg6Wpnnd9uCWcvIj7aPU6ZvYpz9o6JkEZcKkPL?=
 =?us-ascii?Q?OnpS72UXvKzkLY4BXVQnaYT52q8xokwq+lRcIadzLqa7llvDS+nyTy6r91vm?=
 =?us-ascii?Q?iHHw3S8WMKqyiH7lX5P6MhsP8NFTEKV7L82eyzeWEMLIAufax5hxBrFIcKeF?=
 =?us-ascii?Q?2HRtEhgASrHnzsKkAIUW45oeu6vMrfKqDiJ5BZVdb82OoY064c8WqY1Jd64b?=
 =?us-ascii?Q?kj+q6gE1PWaTo3wAYpK1z+zshtvhvVGxpv1N+bU51r/m1q5YJZhB82NxFuyg?=
 =?us-ascii?Q?z6U6fjyIqQu0vSJX7hcDcxHbZdvLZmCz3+9rU6RCsvduRWMp1xSGSH4sI/lb?=
 =?us-ascii?Q?/g/Q8dMpgHya+5rK6RUajQZcXDWT5DAqygDvSIB3x1hqBOwdJbiSkMjiivGR?=
 =?us-ascii?Q?yBvGUPBhoVqx6/8nqite72j4F60uppkzI0K2OIWWFBFOZ99vAZicKFBeMqhb?=
 =?us-ascii?Q?PUFfFS7n3673OlCFietZl9m+DDHWvil+KgftaURB7bp+MR5kIQC8ywqsRUov?=
 =?us-ascii?Q?MJ8HtCfRnDVFDeDwVQvXxBBNVMs8p8h2Bu1C2ETZ8/39HJuOCJ6+Ui3nL29P?=
 =?us-ascii?Q?iPRL6y9rHflBj9wwtPknillmNNcC6afSqywYrogjQUE51wrCt7VPAkZd9o7u?=
 =?us-ascii?Q?JdnZJOumRK4f4e2/UPNbh1/+mwnTUNQS8y90OpqvMRqrg6QYa2se983zQmz6?=
 =?us-ascii?Q?UX2cMX01xCtW+qrBEH9DBfJqceiBsO1KpINk6jzASsDoLAwO+c8UHWzbqJrO?=
 =?us-ascii?Q?XC2x7Bxj7Om6eH0YK6GIeyFC31u87tQiKVy2r6KKmlnDGhkqLEeaPbI1XrjG?=
 =?us-ascii?Q?rmdh8c2bOBTFhR1SsYG7PbQ3h/SU7Kl7q8oB+Lk2qL28LByyAYt4S36iGZB0?=
 =?us-ascii?Q?EhaRIlkSirGU3CVfym2RGE2Zx7CXGTiQ27KZLWBRx3qantjXPFEb0yiktE54?=
 =?us-ascii?Q?tP3Wla2f79qVHNyz0fpfHckoOzkAIeEaI+eByEQKk90nJ9qAhKckZjOyeLq1?=
 =?us-ascii?Q?xaZlLRG3nexVp84ALnpEH+TWoz3U6ctIUBKzdVrZ8l25V1SJakNhJishSH7P?=
 =?us-ascii?Q?+zySHI6f6O/2ZYXH5b6+dz/iuAG7bcul39ArvxOakLwG5cL0WaPSW4A2v3Dh?=
 =?us-ascii?Q?ZSbEgLon/c5nSviU3wKO8gbS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d319fb4-6804-4f8e-ed4e-08d94b877363
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 14:05:37.6673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34w3Xqc4wDEsEw7U6++BjUJgOqkt/kSyyDSySEVeYxUsCnY1tIhtU8zwwBYq9jTEZM1sqq+ATTbc9s1oghoQIir12lkQJGNsg16mjPHj8Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2678
X-Proofpoint-GUID: KUvuyPe39rqsHkjWSguekMjQlPXgDTQR
X-Proofpoint-ORIG-GUID: KUvuyPe39rqsHkjWSguekMjQlPXgDTQR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_07:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107200088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Adding @Thahirally, Murtaza, maybe he can help us with some more details ha=
rdware-wise.

Unfortunately, the current mail format does not allow me to highlight the p=
oints of interest in the conversation.

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, July 17, 2021 5:22 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Rob Herring <robh@kernel.org>
> Subject: Re: [PATCH v6 2/2] dt-bindings: iio: frequency: add adrf6780 doc
>=20
> [External]
>=20
> On Fri, 16 Jul 2021 14:42:10 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add device tree bindings for the ADRF6780 Upconverter.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> oops. Would have ideally gotten to taking a close look at this before v6 =
:(
> Sorry about that!  I don't suppose we have any other reviewers whose
> knowledge of
> this sort of hardware is fresher and deeper than mine?  I'd like more eye=
s on
> the next version of this if possible!
>=20
> Jonathan
>=20
> > ---
> > no changes in v6
> >  .../bindings/iio/frequency/adi,adrf6780.yaml  | 119 ++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> >
> > diff --git
> a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> > new file mode 100644
> > index 000000000000..65cb3bee4aca
> > --- /dev/null
> > +++
> b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
> > @@ -0,0 +1,119 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id:
> https://urldefense.com/v3/__http://devicetree.org/schemas/iio/frequency
> /adi,adrf6780.yaml*__;Iw!!A3Ni8CS0y2Y!tq2rTJBBpvfHI71YPxIn96552nFJvLYy
> U6rbHeP_e5sxgwDvLPHhZ_9NMjP_lD2kj1lJ$
> > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!tq2rTJBBpvfHI71YPxIn96552nFJvLY
> yU6rbHeP_e5sxgwDvLPHhZ_9NMjP_lJHL0noG$
> > +
> > +title: ADRF6780 Microwave Upconverter
> > +
> > +maintainers:
> > +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +description: |
> > +   Wideband, microwave upconverter optimized for point to point
> microwave
> > +   radio designs operating in the 5.9 GHz to 23.6 GHz frequency range.
> > +
> > +   https://www.analog.com/en/products/adrf6780.html
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,adrf6780
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 1000000
> > +
> > +  clocks:
> > +    description:
> > +      Definition of the external clock.
> > +    minItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: lo_in
> > +
> > +  clock-output-names:
> > +    maxItems: 1
> > +
> > +  adi,vga-buff-en:
> > +    description:
> > +      VGA Buffer Enable.
>=20
> Ideally I'd like any acronyms spelt out in the descriptions.
> (I assume this is variable gain amplifier?) The fun question from looking=
 at
> this in the datasheet is where is it in the functional diagram?  I'm not =
actually
> sure where it might be.  Perhaps in the VVA, so on the VAAT input?
>=20
> If you have a convenient path to point out to your datasheet people that =
it is
> undocumented, that might be good to clean up :)
> My guess is this is needed if the precision reference on the example circ=
uit
> needs
> a high impedance input, but I'm only guessing.
>=20
>=20
> > +    type: boolean
> > +
> > +  adi,lo-buff-en:
> > +    description:
> > +      LO Buffer Enable.
>=20
> What is LO and why might it need a buffer? (or is it always a good idea t=
o turn
> this on
> when using the device?)
>=20
> > +    type: boolean
> > +
> > +  adi,if-mode-en:
> > +    description:
> > +      IF Mode Enable.
> IF stands for what? Intermediate Frequency...
>=20
> > +    type: boolean
> > +
> > +  adi,iq-mode-en:
> > +    description:
> > +      IQ Mode Enable.
> > +    type: boolean
>=20
> I struggled to figure this out from the datasheet, but is there a circums=
tance
> under which
> if and iq mode might both be enabled? Nothing stops you setting the
> registers that way, but
> it seems to be documented as one or the other...
>=20
> For that matter, why probably want to describe this as "baseband IQ mode"
> given datasheet
> refers to as baseband in most places other than the register definition.
>=20
> > +
> > +  adi,lo-x2-en:
> > +    description:
> > +      LO x2 Enable.
> > +    type: boolean
> > +
> > +  adi,lo-ppf-en:
> > +    description:
> > +      LO x1 Enable.
>=20
> This is curious. I agree that the register write documents it as x1 enabl=
e, but it
> seems
> to be be enabling polyphase filters - what exactly their relationship is =
to x1 is
> not that
> clear to me.  Perhaps one to query with the hardware people if possible!
>=20
> > +    type: boolean
> > +
> > +  adi,lo-en:
> > +    description:
> > +      LO Enable.
> > +    type: boolean
>=20
> Would you ever have this off whilst running?  It's possible I'm missing
> something, but
> I think you need that frequency path to be enabled to get anything at all=
 to
> happen.
>=20
> > +
> > +  adi,uc-bias-en:
> > +    description:
> > +      UC Bias Enable.
> > +    type: boolean
>=20
> This being completely undocumented apart from the register setting, I hav=
e
> 0 idea what
> it actually is.   Any chance we can get some more details?
>=20
> > +
> > +  adi,lo-sideband:
> > +    description:
> > +      Switch to the Other LO Sideband.
>=20
> Switch what to the other LO sideband?
>=20
> > +    type: boolean
> > +
> > +  adi,vdet-out-en:
>=20
> So my reading of the datasheet on this one didn't lead me to a completely
> clear answer.
> Does turning this one effectively stop you using the internal ADC to meas=
ure
> the power
> whilst exposing the signal on an external pin?
>=20
> > +    description:
> > +      VDET Output Select Enable.
> > +    type: boolean
> > +
> > +  '#clock-cells':
> > +    const: 0
> > +
> > +dependencies:
> > +  adi,lo-x2-en: [ "adi,lo-en" ]
> > +  adi,lo-ppf-en: [ "adi,lo-en" ]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      adrf6780@0 {
> > +        compatible =3D "adi,adrf6780";
> > +        reg =3D <0>;
> > +        spi-max-frequency =3D <1000000>;
> > +        clocks =3D <&adrf6780_lo>;
> > +        clock-names =3D "lo_in";
> > +      };
> > +    };
> > +...

