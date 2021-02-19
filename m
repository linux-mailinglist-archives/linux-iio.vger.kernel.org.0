Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364B031F55F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Feb 2021 08:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSHds (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Feb 2021 02:33:48 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:61764 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhBSHdr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Feb 2021 02:33:47 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11J7PGB6030130;
        Fri, 19 Feb 2021 02:32:50 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjb1h4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:32:49 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11J7TlO2013313;
        Fri, 19 Feb 2021 02:32:49 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 36pcjb1h4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 02:32:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsplpz6mk6IIviOJ4YT1+uT33SochCZW83mAHDNM+Kxw9/UKVRAuzse6NKOkeWEIdUOfJXXJ5p1x599iUIWFbjYoc+RVt4oud4KPBrBxHTlYSNXLZyo3sirhLoL0Z1SH3SJaI0AHQSwT3B/TRcP+Gk4N+MWpv6A3OT0DOhJFKoDStyNa9FcQVOXKHLCYjxsLjoe1yF2lzLFbMBZxbpQXMrerJq642Hj2pFpEKdl5yTmQdfNGOE3N1FJFbFkmnBjA47UB80baAQ3qovpYggS9VYYqrobUfdgBsrZ4Las33bEiSmp5KDgt0AFxuzhoryfVSI2B7K0T3K8Ftt5u9i/heQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwlSaTUu7wct9qD5Yy+20dmlor6Gu+ZFc2wvRyY0Uuc=;
 b=hK7X5Gfh3EVDYLHvOHYzq0IlpTZU3jgpviqqK7CJQ65M+JAh69hmtKWJuHOt7dD2BPxOt8j6ha+sHqI28DK6FwqSHfLpxO0fhwKRF2rLTn5llNYd5/PFhNQueKeKHcuWysP9+r7q2qtDILioo6XyM19pFVZa/gFgnjIdKdwYiKRWviLrEuqvR2SM/qWqHgwEZ4vnzAa53n/PijYMHyUMr1JsU+RHqAdXqSWBRvfO2EMxn7/O1ocHJewpDvFXgVT91hxQi66t5L846zECDNEq8WJ/nrC1thaiFrXPL+YLcP1qvABMeU+jKqHf9RbYznaZwgBK0zNUH+wNgTEFhg2/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwlSaTUu7wct9qD5Yy+20dmlor6Gu+ZFc2wvRyY0Uuc=;
 b=1H6ZZQ0ue3a3dZFyLmEudwaHs6ovwErHkzFc/ZAySP+FIdF5w+mV39HEk/4w6WSJ7IvXPtqr0/DpW201z8pO1ehE6zsgrLMpIXh2gDOsGipPUwLgWXo2KwnJdovIMA+88HPZ322iPDpXGYYVdMdaDOj/WjsYox7k/WiJ8qFiCdw=
Received: from MN2PR03MB5199.namprd03.prod.outlook.com (2603:10b6:208:1e9::11)
 by MN2PR03MB4718.namprd03.prod.outlook.com (2603:10b6:208:109::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 07:32:48 +0000
Received: from MN2PR03MB5199.namprd03.prod.outlook.com
 ([fe80::659b:24e5:28f5:8e7b]) by MN2PR03MB5199.namprd03.prod.outlook.com
 ([fe80::659b:24e5:28f5:8e7b%6]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 07:32:47 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     kernel test robot <lkp@intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: RE: [iio:testing 47/53]
 drivers/iio/buffer/industrialio-buffer-dma.c:669
 iio_dma_buffer_alloc_blocks() warn: always true condition '(i >= 0) =>
 (0-u32max >= 0)'
Thread-Topic: [iio:testing 47/53]
 drivers/iio/buffer/industrialio-buffer-dma.c:669
 iio_dma_buffer_alloc_blocks() warn: always true condition '(i >= 0) =>
 (0-u32max >= 0)'
Thread-Index: AQHXBUj3KcpGQiTXJEWoXz5xuBcyq6pfGBvA
Date:   Fri, 19 Feb 2021 07:32:47 +0000
Message-ID: <MN2PR03MB519937427766A81BCAA38F7FF9849@MN2PR03MB5199.namprd03.prod.outlook.com>
References: <202102180028.0AN3Cfyt-lkp@intel.com>
In-Reply-To: <202102180028.0AN3Cfyt-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWFyZGVsZWFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1hOTIzMDNmNy03Mjg0LTExZWItYTYwYi00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcYTkyMzAzZjktNzI4NC0xMWViLWE2MGItNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSI0NDAxIiB0PSIxMzI1ODE5MzU2NzQw?=
 =?us-ascii?Q?NTQ4MDAiIGg9InY0OEFPMGpydGZNUWovV1lXU0FoWXJxNmhVcz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUlZREFB?=
 =?us-ascii?Q?Q1FXSHhya1FiWEFhOTlkWUpkMG9sWXIzMTFnbDNTaVZnRkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBeDRaa2FRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-dg-rorf: true
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b018a06-33d0-498f-a348-08d8d4a88e48
x-ms-traffictypediagnostic: MN2PR03MB4718:
x-microsoft-antispam-prvs: <MN2PR03MB4718BA953BF9FA121661B26FF9849@MN2PR03MB4718.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:33;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: izx6mFLryciceLIiwndlU9tuET0mjBp+VQnQxeKh9A12brmpDazklDeg+kK7KSn8qnDF+x17GzFRem4Caj9/QlmyEi+pT54kBVwylO8CDRThCZPi9BUz6ykCN6L0dEGkjoFbC7fMMj85V4sMpApkeRQ+NpLOgLmln6aLRJfwLjm0d80Llzhx1FNoSXnYd86CgK2OKCwMvZDXZDgGKIkl1Zd+10g2h+OGF3ac+MnAdmHex8OHWkBgYNkLbQnXDAD+RcssleXAKm2OXp1D8OQ4pofp4FMwJxx5hVVRXzvSDLIQXHPnG74cjd53ZKp5zxJSp5kvKO4EJXGvDm4GCzhuzGQKQv1l3T5YbhmWWPD99sV/1kReVdqdj3QaS0EhoamkQg+bhXck0B0I+iEZaK7HRL1Mu8wrlzFORI8wXYIyE4zTgVxyXJx30IpqPDsKVfT+1lqalWpeIobcztg1H4ToNwS7R/Q1E3Prta6qpYh5Lx+TD9X9b41AaE19WZCxMtBOvdi7+8RsqZ+A9mqADt3GpalESjeGYSP/0PxZ1vPPDhb5ateyhAOihnwWrrMrw8/q4uiKKPxl6J81SDesXqsVY7Ux/ak4Nf7X47vkP3tiPHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5199.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(33656002)(110136005)(26005)(9686003)(478600001)(7696005)(6506007)(8936002)(966005)(55016002)(54906003)(76116006)(66446008)(8676002)(66946007)(64756008)(66476007)(66556008)(186003)(52536014)(71200400001)(83380400001)(53546011)(2906002)(5660300002)(86362001)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nYaxNvBzkLvMK++78ofnpttxUVYsfwcSSnR7QSAN0xFmcNQFJ/CnzE8dKH7E?=
 =?us-ascii?Q?UQ/XZSqcskMrTZNaZtA9QVrkbideZIAX63wr9kuoYFMZ7tgJ/1N34ul0SO2a?=
 =?us-ascii?Q?IjsFiMmOUwD5l0kRSN5NPwz2CmJgvam3mz0gtiTs23wQrN/D5i1ajSgrcF+t?=
 =?us-ascii?Q?kvL6XINRrSp20GwNdGg9pIQWNJPV6UlERqNCC0TTOW+xumOew6R1bP5qJF6m?=
 =?us-ascii?Q?+wgcJHISVGtK1Tq40ujRGp+3uM+i7iFii9CRBoxh1jmRMaTTdxXWk0+JyvE8?=
 =?us-ascii?Q?QDSfH8hv/hD13sCprDUfQ4sIQB46gRf1L6NGohiSJJCvxxa0knbq9epD7on+?=
 =?us-ascii?Q?v72g2Dd8RreeDYu1vm2MONnI+9X1GJA0mQJPyqSV1HOmIRoIEFGePfoHaVsS?=
 =?us-ascii?Q?+an+D+1LSDWWWAteqtB4BuMr912iufKu42LC0tIQ/B0J1BsQh/FmFu7StzRO?=
 =?us-ascii?Q?6AiEFDjGFD1Ii76U1s7AikMSMnU+W9kPWqZGpuLNZeolU9JJFRyesBrwZV+u?=
 =?us-ascii?Q?RImxFjrlf5BggZro8xDFGck1Gx9E4WGtHvLTctcIbKvryl9p9i9OCMnGl1eQ?=
 =?us-ascii?Q?WJqwxi6Ui7ePBC501/mHw3nneFIrW6CzkaAPyEzxvgTX/6b6s4b6P70F0yzr?=
 =?us-ascii?Q?tsr0o5v6r7WOdu4pfVZChM4N4slfX2hJqf2ljtnYVnHO+KwfRXrruezuvcYm?=
 =?us-ascii?Q?yb3xtjPPny/qeAqykIU2j4/oOfOTqG3ODayYjocNgIS2d320dq8apsY2oIH/?=
 =?us-ascii?Q?7zM/w4Iu/fsRbODDphhP3N/Jit1Q3OAT0yaE8LoNwbzo7mOK5jms/LQmpxg9?=
 =?us-ascii?Q?zb0HVdBdkEQtahH3Gye3921MJl5MympQOukHyIX/VgPMEMlV12RmqxzQ2s82?=
 =?us-ascii?Q?ST6d27haWyjlIoT0S1FTucX70X/l8gCku2iz0istlKIE2TwQkUQShmKzeowE?=
 =?us-ascii?Q?gxQQlhXDyivmjTIvxCRIHIT/5wah9grCv04e6hNjVa6jAg55A1ybBjjZzHly?=
 =?us-ascii?Q?2Owchg3CkwJddEJbrYyLEUmbVvJl+Qrzfo8bVe741nJcW3dtfuZ5iLQdAZkZ?=
 =?us-ascii?Q?+J/fsJten5R+O3rbvkM6drfVOfVUmhdfc2iuHL/xo3tjeWnCCa40Cp/Hidqb?=
 =?us-ascii?Q?eA5cCcYOS3uKSkwbqXZmY8ATvo+Aq95n7jt8YzTtw6UHHNnKE2CLkPiogUOe?=
 =?us-ascii?Q?ezFDqrPGsWJUjtbsVbgxW8bhz7HPUT8bwaDIuvQzelxIvyHWgBp5qloqWH9f?=
 =?us-ascii?Q?bYksnidX3TCDLVqThmw5tPb2M+/vYGSYywwuBMdzV13avoswvh0X+eWunUnL?=
 =?us-ascii?Q?jZY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b018a06-33d0-498f-a348-08d8d4a88e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 07:32:47.8549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v341HXnk1e06Nk6BsxQSqfTD/qYAaFkJCRLQT7eJKA8viMQps6BKgrNu2HAJUvxYLmfnXqW66GLj5J8Dv8oHCJPmCog8H1ZTwWdA+pRJi5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4718
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_02:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190054
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, February 17, 2021 6:21 PM
> To: Lars-Peter Clausen <lars@metafoo.de>
> Cc: kbuild-all@lists.01.org; Jonathan Cameron
> <Jonathan.Cameron@huawei.com>; Ardelean, Alexandru
> <alexandru.Ardelean@analog.com>
> Subject: [iio:testing 47/53] drivers/iio/buffer/industrialio-buffer-dma.c=
:669
> iio_dma_buffer_alloc_blocks() warn: always true condition '(i >=3D 0) =3D=
> (0-
> u32max >=3D 0)'
>=20
> [External]
>=20
> tree:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g=
it/jic
> 23/iio.git__;!!A3Ni8CS0y2Y!r0vJx0FTiLi3bS6LugAUkUV4m4kSgQvuRql4XvRJBxLk
> EhqwktjO1ekJmXEVppxQ7ZPMsA$  testing
> head:   0fd146b288591a8139220fec417dfc5652820480
> commit: b9ad66ba4db6f349aa795ed59c3e42d4208844fa [47/53] iio: buffer-
> dma: Add mmap support
> config: x86_64-randconfig-m001-20210215 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> smatch warnings:
> drivers/iio/buffer/industrialio-buffer-dma.c:669 iio_dma_buffer_alloc_blo=
cks()
> warn: always true condition '(i >=3D 0) =3D> (0-u32max >=3D 0)'
> drivers/iio/buffer/industrialio-buffer-dma.c:669 iio_dma_buffer_alloc_blo=
cks()
> warn: always true condition '(i >=3D 0) =3D> (0-u32max >=3D 0)'
>=20
> vim +669 drivers/iio/buffer/industrialio-buffer-dma.c
>=20
>    603
>    604	int iio_dma_buffer_alloc_blocks(struct iio_buffer *buffer,
>    605					struct iio_buffer_block_alloc_req *req)
>    606	{
>    607		struct iio_dma_buffer_queue *queue =3D
> iio_buffer_to_queue(buffer);
>    608		struct iio_dma_buffer_block **blocks;
>    609		unsigned int num_blocks;
>    610		unsigned int i;
>    611		int ret =3D 0;
>    612
>    613		mutex_lock(&queue->lock);
>    614
>    615		/*
>    616		 * If the buffer is enabled and in fileio mode new blocks can't b=
e
>    617		 * allocated.
>    618		 */
>    619		if (queue->fileio.enabled) {
>    620			ret =3D -EBUSY;
>    621			goto err_unlock;
>    622		}
>    623
>    624		/* Free memory that might be in use for fileio mode */
>    625		iio_dma_buffer_fileio_free(queue);
>    626
>    627		/* 64 blocks ought to be enough for anybody ;) */
>    628		if (req->count > 64 - queue->num_blocks)
>    629			req->count =3D 64 - queue->num_blocks;
>    630		if (req->size > iio_dma_buffer_max_block_size)
>    631			req->size =3D iio_dma_buffer_max_block_size;
>    632
>    633		req->id =3D queue->num_blocks;
>    634
>    635		if (req->count =3D=3D 0 || req->size =3D=3D 0) {
>    636			ret =3D 0;
>    637			goto err_unlock;
>    638		}
>    639
>    640		num_blocks =3D req->count + queue->num_blocks;
>    641
>    642		blocks =3D krealloc(queue->blocks, sizeof(*blocks) * num_blocks,
>    643				  GFP_KERNEL);
>    644		if (!blocks) {
>    645			ret =3D -ENOMEM;
>    646			goto err_unlock;
>    647		}
>    648
>    649		for (i =3D queue->num_blocks; i < num_blocks; i++) {
>    650			blocks[i] =3D iio_dma_buffer_alloc_block(queue, req-
> >size);
>    651			if (!blocks[i]) {
>    652				ret =3D -ENOMEM;
>    653				goto err_unwind;
>    654			}
>    655			blocks[i]->block.id =3D i;
>    656			blocks[i]->block.data.offset =3D queue->max_offset;
>    657			queue->max_offset +=3D PAGE_ALIGN(req->size);
>    658		}
>    659
>    660		req->count =3D i - queue->num_blocks;
>    661		queue->num_blocks =3D i;
>    662		queue->blocks =3D blocks;
>    663
>    664		mutex_unlock(&queue->lock);
>    665
>    666		return 0;
>    667
>    668	err_unwind:
>  > 669		for (; i >=3D 0; i--)

Oh crap.
This is actually serious.
Will fix this

>    670			iio_buffer_block_put(blocks[i]);
>    671		kfree(blocks);
>    672	err_unlock:
>    673		mutex_unlock(&queue->lock);
>    674
>    675		return ret;
>    676	}
>    677	EXPORT_SYMBOL_GPL(iio_dma_buffer_alloc_blocks);
>    678
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://urldefense.com/v3/__https://lists.01.org/hyperkitty/list/kbuild-
> all@lists.01.org__;!!A3Ni8CS0y2Y!r0vJx0FTiLi3bS6LugAUkUV4m4kSgQvuRql4Xv
> RJBxLkEhqwktjO1ekJmXEVppzqskxNkQ$
