Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DF469757
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 14:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244388AbhLFNpt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 08:45:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:48910 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240974AbhLFNps (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 08:45:48 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6C9jAm031612;
        Mon, 6 Dec 2021 08:42:17 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3csj9d8aub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 08:42:17 -0500
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 1B6DgHVM020437;
        Mon, 6 Dec 2021 08:42:17 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3csj9d8au9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 08:42:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5ffPnsd3JLcEYUqFXt2ZFk9R7BZD4FGavusAFFMEEX2xYdnHbvUhcbY9z2ndXdbL2tfttEvGDtwHF67a6IYl1Zm1Dg1bbL99ZwUsTpgbTKpY1yBgT9HG8ioOOaPizSvxqwc3WI1LTvI8Rr09yQI1kKGVN/uAnGqnZ6BB7xJKXFvNgbHTCpYEiyxn43Q0Hxd7xJbXOTKf95EO0T0aoMQ+HCGYOkte2dC4wNBkxqt2F3IYjTXhgwyyKTzBZG8WbkMIw6xLWnaQtrxHKzMhM/AJgV5rRs6EAYNss1XAJp4c+ZnbhoNK8APS51oppCeIkHh0W/+RnqdPjOpRWUGnwiQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80tmCg3WYVYmYXXbiG/ppNeUfdC3f6sqOqhFW/fgrxU=;
 b=mr66hxxNVsaIGCxzBh/EVJuRs3XL/iEzksG/+GN1QQiBpeGf1PtNpEjcxhCItOupANsC4OvYXeiqIuufQyHDNl3uiEIotuy7gudHoruFh66ffjvK+pZO55KJIUI1CRzRW2RF5buzDmKs6Mz+9zeWbtxKYhO2n5LZrmYdy3QuGB37lSGJXWkMuGGWvFhsXKHqcKYSgzwOfu4EguPE4g/O6r9Rsp15S/JiBXdm+f9nbnw+KYc93KoeAcHZE/RoOZYs25jXZWcqy6eifhyKaDXuis2qLaSA2mfSUQdSuugc0NZlGQpajG/ToZ4bP64RVEugYe0ZT6fku1WEgWmN4Ll7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80tmCg3WYVYmYXXbiG/ppNeUfdC3f6sqOqhFW/fgrxU=;
 b=6Xu+SLPhocGovwzZEw0pSRpwgVGE+GglXk5xn/mL74o+dQ/GTonfxq87TLsd3dZAgDEngvWl9tzxZeTPQKHTPHGlRI4Ri7YzWHB8rGa6bA0YQB9L1s0T4peE7mRWH00d1ovafV+4gmNoxtKPhsnv+X0gykQZM0gn8hFYcmT+uYI=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6592.namprd03.prod.outlook.com (2603:10b6:510:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 13:42:15 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::5d02:4f14:9f83:6055]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::5d02:4f14:9f83:6055%4]) with mapi id 15.20.4713.021; Mon, 6 Dec 2021
 13:42:15 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [RFC PATCH 0/1] LTC2688 support
Thread-Topic: [RFC PATCH 0/1] LTC2688 support
Thread-Index: AQHX1uthp64f7v0trkGvKxQpqJcVI6wAEu4AgAQrh5CACbdVAIAOPJoQgAgjw4CAARO1kIAALxeAgAAFMBA=
Date:   Mon, 6 Dec 2021 13:42:14 +0000
Message-ID: <PH0PR03MB6786E1066FB0F2113F41FC4A996D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
        <20211112161437.60dbc872@jic23-huawei>
        <PH0PR03MB6366BFFE85F122FED1B72BB499989@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211121121756.2297671a@jic23-huawei>
        <PH0PR03MB678687C50B21BD5E448E413699679@PH0PR03MB6786.namprd03.prod.outlook.com>
        <20211205180033.23eb58b9@jic23-huawei>
        <PH0PR03MB6786C1FB47402D1260A4A6C3996D9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <20211206131553.00006b68@Huawei.com>
In-Reply-To: <20211206131553.00006b68@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNTA0NGNiM2YtNTY5YS0xMWVjLThiYTAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDUwNDRjYjQwLTU2OWEtMTFlYy04YmEwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTI2ODAiIHQ9IjEzMjgzMjcxNz?=
 =?iso-8859-1?Q?MyNTAwNDA0MyIgaD0iQmx3aXcvYkxBQnF5QzJKL1V0enR6c2ZjM2JJPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBRW9DQUFBTDdiUVNwK3JYQVpYaCtmaVdwbzVXbGVINStKYW1qbFlEQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUVBQVFBQkFBQUFWSUV2b1FBQUFBQUFBQUFBQUFBQUFK?=
 =?iso-8859-1?Q?NEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYW?=
 =?iso-8859-1?Q?dCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBB?=
 =?iso-8859-1?Q?R2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRU?=
 =?iso-8859-1?Q?FaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?iso-8859-1?Q?MEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FY?=
 =?iso-8859-1?Q?d0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBY3dCZk?=
 =?iso-8859-1?Q?FIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bda95829-8955-4c71-d4d8-08d9b8be36b4
x-ms-traffictypediagnostic: PH0PR03MB6592:EE_
x-microsoft-antispam-prvs: <PH0PR03MB65927FF1D4067A0FB1BDC09C996D9@PH0PR03MB6592.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+jsiIrAkQtrVtTvLWwZy45zTh/x2l0XJJNbpLUsWdo5SCP/CwqfYy/0pqutgxVEISwxlUQxs+Hs/nu89cOJDXWJlny9QjcH173GCI1WsX6e/IX2GiiqMtBaMR+rwiNTrsqcplcckRhBQ85KXO2X1LmE5BdhTOi5iwnTP+NSvHojDUf2pT7O41TPEdiXCG23KcXdKWvJxscL80FArPGuT1uHZMKEnX/sOeXu2czQVAKGjy1gQdC/h4jE4RGlYZBfDUv9Fx0EsKIlaNosT/d1n1IIRvxzy0GcLdVaMqBclaP6cvMI+6n6p6sUm4Xxf9nC5pmQIyxWkUsjV9oF0E/wKhvx5iBmudTEgxCqrF8Hlchoe+0AhNzDs+usw0NR21Zs8bM9F3H2c49wcNQ46ECGulsRzakoZVgLuDtRhVGwdHbeVZHh8eDk/FFUWDxTuRg1CAOtIl5cLpKv95iPbvJjrsDQxnYAlGqsMI6Huo1By/zud9FLY+bk5fTETo1BmigJDPyVnlu11TCUqOE3NsPCwd/5vdjsGh9Jf8q5DVEAn90CcAd9wgcajhWQfHLjfJYvwPETP1ZsYJrO7mgLF/LzsjV55OhH/c/OA0PpkdsHLuoh8wBzDVdTkYnVH7z3MZmiKjygGn2Lcx/h70jlbxtJ/lidRt1uauezl6nRmSZo5+vLviYSqoRoi2uk9qs701rwvHAbOTUKuu9OqN+Gr5hWbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(33656002)(38070700005)(6506007)(186003)(71200400001)(2906002)(83380400001)(30864003)(53546011)(4326008)(9686003)(66946007)(76116006)(8676002)(26005)(5660300002)(316002)(122000001)(8936002)(7696005)(6916009)(508600001)(38100700002)(66446008)(64756008)(66476007)(66556008)(54906003)(52536014)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gTFOt5/2CACIjZVVq3z2mU5rJmE/1NlF5HypexfSH6hdwkC8pbypm99u9T?=
 =?iso-8859-1?Q?j+NnGFxjIPQAtwWHhoouTWpzKvsH4QC7huNEPqwQnfYJPsC28AdZx4gKBo?=
 =?iso-8859-1?Q?beOIymvHyZY9jVbYVy3g8hNT6tk3adYcxejuGzPa5HO3KtTKqoczzOqqMx?=
 =?iso-8859-1?Q?qatrI5W6e3+Q2QbPGDY2WcIVTXdOj59dDKzQr3+eccZzBLh1A8aw3Eu2Qb?=
 =?iso-8859-1?Q?qnTLhG9arEeIZbsW+dMuD3q9uFE62GEYLB+WUWFLMCVkmERyRJVu/5WHHN?=
 =?iso-8859-1?Q?rNGOD2digIiGKXU9G0M4jfk2GpxBxmBYZmkU9wDkJIL5iDGMWdziQmJpna?=
 =?iso-8859-1?Q?SDxq2StIpSeSFmqJ3F8FlYMwnqCzy0+KlTvH2XEoDCdg8/0IlrY6zMkQtJ?=
 =?iso-8859-1?Q?pOEuEfHncp8XjgckQvwnN/G4Uu8GjDxF+EkcogcwEvRBxlNePN96BlJxES?=
 =?iso-8859-1?Q?Xy8ORJ+Gu4OraEDrAelPmLc+VpVTEc36/gQmap3m5VEsy2rMM7gFcGvl4C?=
 =?iso-8859-1?Q?KlZXwdeoN47l2VZnEesJ3rR813JIdqIUdTdjBuBCcpO3scRXfTyj9x2rd2?=
 =?iso-8859-1?Q?XqALjU5EfYiMVDlmNDTHsvdQUMkv7Heavm5R/6MyA1+3GB92hqdpFD3lGQ?=
 =?iso-8859-1?Q?9T60on4SYbw/k+XC52PR5utTV4To6nmrucWZ/Y1TH/IrH4j7BOx+nAiwZ8?=
 =?iso-8859-1?Q?slO5Q6aPijpPn7TOrOAF0VajMmQK+K4bH+nNE+9d6aQMSpgc3w2WmAvLax?=
 =?iso-8859-1?Q?wZsu9wh8kfwS/KSGKDurWnT9C/ACyEBlaTVg+elNLns6ZhxCgTUToRwveS?=
 =?iso-8859-1?Q?t85pe9ZF/aNZcIQ6Dntt4eukbEG1W0L0XK4jjBLObVhgE+9HhYOgC8QM24?=
 =?iso-8859-1?Q?GDKYVMbWg7cGFEsjiO0AHPek+xj8oxlVYNgi8Fd87uvt68v7b5QIsYsJRy?=
 =?iso-8859-1?Q?vJytmPiKVvR5EFNyN7Wo+sGoWj+pQZU+e9j4K/b/2/a1RolvdV3vCaiMbN?=
 =?iso-8859-1?Q?QX4XiJ/LvsFq/zBtFXZGOjB8VvoQvZnYzzjh2WJKmkiJmWR5nAqr4497Ak?=
 =?iso-8859-1?Q?1h/rRgyYLpQA19PjHcfbZPz+11DnuFELdAZedDD+tosinPe+xbBiQvfjYH?=
 =?iso-8859-1?Q?Yulxc/72TSJjSkv1xVwvnxDKmtsMzDjnZc/fYi2806VhOGS/38NgWJWyIW?=
 =?iso-8859-1?Q?YKVFsCt+8PTkJVLdb/kTHGu4cLbOZqJnm62TwM2CwcL6bqwg44le9HyEMt?=
 =?iso-8859-1?Q?cSnu6fFRAx4Oq2LSO/POJ0uTtZMj4CdocYkqei91QkjuLtSSfFriuSBpp1?=
 =?iso-8859-1?Q?m5yXIm1gZMy0dWHecdOFE9AyvoSpCtWeSP40IR2YUQOQfwUlYWSdf8HXXy?=
 =?iso-8859-1?Q?DOke9sDdcovmvYaK9gzXBL04ePCshcZgKmdgMdGG23kspjVgUYUuMPH5Oc?=
 =?iso-8859-1?Q?Yr7/mPIv/yVIiQQlwGadonEi4Ue5VIPv/W6CBq/eYtD0uNv/uVBUC+nftq?=
 =?iso-8859-1?Q?K9cuH6A+s2VFcf7wYgInDOB1SMdLTe0Y6gCgEwd9cafNCCxYCJi7RtPXfB?=
 =?iso-8859-1?Q?4INzysCVjOS5Xa2NNtbvUV52iJ5yaTy5EG/cd15yN2yzkQw2OnWWdxMupU?=
 =?iso-8859-1?Q?k1mBXEtVolSWZskqointsLccB/s9xbvTUJT2OSSRooi+gko8xxjE2mkA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda95829-8955-4c71-d4d8-08d9b8be36b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 13:42:14.8831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocYZ1bifmweV22FEBrmlutMVtK1P1K7v3rzFLFK+Vy9irYN2d2zd1vnCFQy0Oa+V3Ohpzmh37M9cjy+6Mw1iTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6592
X-Proofpoint-GUID: 6gvaFpBfEXSu3d6zq4y7dP1aklSFqayy
X-Proofpoint-ORIG-GUID: 1L_w2meRq1KeU9M0i55eiFyxWsx-Btvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_04,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060085
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, December 6, 2021 2:16 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org
> Subject: Re: [RFC PATCH 0/1] LTC2688 support
>=20
> [External]
>=20
> On Mon, 6 Dec 2021 10:49:17 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, December 5, 2021 7:01 PM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio@vger.kernel.org
> > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > >
> > > [External]
> > >
> > > On Tue, 30 Nov 2021 14:43:25 +0000
> > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > >
> > > Hi Nuno
> > >
> > > Hopefully I've not lost the plot on this!
> >
> > Not really. I had some days off so this was also set on hold from
> > my side.
> >
> > > > > -----Original Message-----
> > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > Sent: Sunday, November 21, 2021 1:18 PM
> > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > Cc: linux-iio@vger.kernel.org
> > > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > > >
> > > > > [External]
> > > > >
> > > > > On Mon, 15 Nov 2021 10:28:51 +0000
> > > > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > > > >
> > > > > > Hi Jonathan,
> > > > > >
> > > > > > Thanks for your inputs...
> > > > > >
> > > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > > Sent: Friday, November 12, 2021 5:15 PM
> > > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > > Cc: linux-iio@vger.kernel.org
> > > > > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > > > > >
> > > > > > > [External]
> > > > > > >
> > > > > > > On Thu, 11 Nov 2021 12:00:42 +0100
> > > > > > > Nuno S=E1 <nuno.sa@analog.com> wrote:
> > > > > > >
> > > > > > > Hi Nuno,
> > > > > > >
> > > > > > > > The reason why this is a RFC is because I'm still waiting f=
or
> > > proper
> > > > > HW
> > > > > > > > to test this thing. The reason why I'm sending this already
> is
> > > > > because
> > > > > > > > there's some non usual features which might require
> extra
> > > ABI.
> > > > > > > Hence,
> > > > > > > > while waiting I thought we could already speed up the
> > > process in
> > > > > > > regards
> > > > > > > > with the ABI.
> > > > > > >
> > > > > > > Wise move as this is an unusual beast :)
> > > > > > >
> > > > > > > >
> > > > > > > > I still pushed the driver but the intent here is not really=
 to
> > > review
> > > > > it.
> > > > > > > > Naturally, if someone already wants to give some
> feedback,
> > > > > that's
> > > > > > > very
> > > > > > > > much appreciated :)
> > > > > > >
> > > > > > > >
> > > > > > > > Now, there are three main interfaces depending on the
> > > channel
> > > > > > > mode:
> > > > > > > >  1) default (no new ABI)
> > > > > > > >  2) toggle mode
> > > > > > > >  3) dither mode
> > > > > > > >
> > > > > > > > The channel mode will be a devicetree property as it does
> not
> > > > > really
> > > > > > > > make much sense to change between modes at runtime
> > > even
> > > > > more
> > > > > > > because the
> > > > > > > > piece of HW we might want to control with a channel
> might
> > > be
> > > > > > > different
> > > > > > > > depending on the selected mode (I'm fairly sure on this
> > > between
> > > > > > > toggle
> > > > > > > > and other modes but not so sure between dither and
> default
> > > > > mode).
> > > > > > >
> > > > > > > I agree on toggle vs dither definitely being different, but
> normal
> > > > > you
> > > > > > > could implement either as software toggle, or dither with a
> 0
> > > > > > > magnitude
> > > > > > > sine wave.  So might not be worth implementing default
> mode
> > > at
> > > > > all.
> > > > > > > No harm in doing so though if there are advantages to
> having it.
> > > > > >
> > > > > > My feeling is that we could probably have dither as the
> "default
> > > > > mode".
> > > > > > More on this below...
> > > > > >
> > > > > > > >
> > > > > > > > toggle mode special ABI:
> > > > > > > >
> > > > > > > >  * Toggle operation enables fast switching of a DAC output
> > > > > between
> > > > > > > two
> > > > > > > > different DAC codes without any SPI transaction. Two
> codes
> > > are
> > > > > set
> > > > > > > in
> > > > > > > > input_a and input_b and then the output switches
> according
> > > to
> > > > > an
> > > > > > > input
> > > > > > > > signal (input_a -> clk high; input_b -> clk low).
> > > > > > > >
> > > > > > > > out_voltageY_input_register
> > > > > > > >  - selects between input_a and input_b. After selecting
> one
> > > > > register,
> > > > > > > we
> > > > > > > >    can write the dac code in out_voltageY_raw.
> > > > > > > > out_voltageY_toggle_en
> > > > > > > >  - Disable/Enable toggle mode. The reason why I think this
> > > one is
> > > > > > > >    important is because if we wanna change the 2 codes,
> we
> > > > > should
> > > > > > > first
> > > > > > > >    disable this, set the codes and only then enable the
> mode
> > > > > back...
> > > > > > > >    As I'm writing this, It kind of came to me that we can
> > > probably
> > > > > > > >    achieve this with out_voltageY_powerdown attr (maybe
> > > takes a
> > > > > bit
> > > > > > > more
> > > > > > > >    time to see the outputs but...)
> > > > > > >
> > > > > > > Hmm. These corner cases always take a bit of figuring out.
> > > What
> > > > > you
> > > > > > > have
> > > > > > > here is a bit 'device specific' for my liking.
> > > > > > >
> > > > > > > So there is precedence for ABI in this area, on the
> frequency
> > > > > devices
> > > > > > > but only
> > > > > > > for devices we still haven't moved out of staging.  For those
> we
> > > > > > > needed a means
> > > > > > > to define selectable phases for PSK - where the selection
> was
> > > > > either
> > > > > > > software or,
> > > > > > > much like here, a selection pin.
> > > > > > >
> > > > > > > out_altvotage0_phase0 etc
> > > > > > >
> > > > > > > so I guess the equivalent here would be
> > > > > > > out_voltageY_raw0
> > > > > > > out_voltageY_raw1
> > > > > > > and the selection would be via something like
> > > > > > > out_voltageY_symbol (0 or 1 in this case). - note this is onl=
y
> > > > > > > relevant if you have the software toggle. Any enable
> needed
> > > for
> > > > > > > setting
> > > > > > > can be done as part of the write sequence for the  raw0 /
> raw1
> > > and
> > > > > > > should
> > > > > > > ideally not be exposed to userspace (controls that require
> > > manual
> > > > > > > sequencing
> > > > > > > tend to be hard to use / document).
> > > > > >
> > > > > > Yeah, I thought about that. I was even thinking in having
> > > something
> > > > > like
> > > > > > *_amplitude for dither mode. In some cases, where we might
> be
> > > left
> > > > > > in some non obvious state (eg: moved the select register to
> input
> > > b
> > > > > and
> > > > > > then we failed to set the code;), I prefer to leave things as
> > > flexible as
> > > > > > possible for userspace. But I agree it adds up more complexity
> > > and in
> > > > > > this case, I can just always go to 'input_a' when writing
> 'raw0'...
> > > > > >
> > > > > > > However, I'm not 100% sure it really maps to this case.
> What do
> > > > > you
> > > > > > > think?
> > > > > >
> > > > > > I think it can work. Though out_voltageY_symbol probably
> needs
> > > to
> > > > > be
> > > > > > shared by type to be coherent with what we might have with
> > > TGPx.
> > > > >
> > > > > That's fine.
> > > > >
> > > > > > Note the sw_toggle register has a bit mask of the channels
> we
> > > want
> > > > > to
> > > > > > toggle which means we can toggle multiple channels at the
> same
> > > > > time.
> > > > >
> > > > > Using that wired up to buffer mode might make sense.  You'd
> > > provide
> > > > > multiple
> > > > > buffers and allow channels to be selected into one of them at a
> > > time.
> > > > > Each
> > > > > buffer is then tied to a different toggle (TGP0, TGP1, etc)
> > > > >
> > > > > The same could be true for the software toggle.  It'll get a bit
> fiddly
> > > > > though.
> > > > >
> > > > > Perhaps this is an advanced feature to think about later...
> > > > >
> > > > > > It works the same with TGPx if you map multiple channels to
> the
> > > > > same
> > > > > > pin.
> > > > > >
> > > > > > There's also the question on how to handle this if a TGPx is
> > > provided?
> > > > > > I guess it will just override the pin... But most likely having
> them
> > > both
> > > > > > at the same time will lead to non desired results (unless we
> have
> > > a
> > > > > > way to gate/ungate the clocks)...
> > > > > I don't follow this bit.  You mean TGPx and software toggle. As
> far
> > > as I
> > > > > can
> > > > > tell it's an either/or thing per channel.
> > > > >
> > > >
> > > > Here I meant that if we have a TGPx pin bundled to some
> channel(s)
> > > we
> > > > do not want to also dance with the sw_toggle bit of that channel.
> > > Ultimately,
> > > > that's on the user responsibility but we could also add some
> guards I
> > > guess.
> > > > I'm not sure if it's an either/or thing per channel... IIUC, we spo=
ke
> > > about
> > > > making dither and default mode the same. That might complicate
> > > things a bit
> > > > as:
> > > >
> > > > 1) We should not force a user to specify a TGPx pin for those
> > > channels (since
> > > > it can also work with dithering disabled).
> > > > 2) Because of 1), we should also support sw_toggle for these
> > > channels since
> > > > someone might want to enable dither mode (at runtime) and the
> > > TGPx pin was
> > > > not given. Hence, we need to have a way to update the DAC
> using
> > > the sw_toggle.
> > > >
> > > > Did I understood things wrong? One thing that comes to my
> mind, is
> > > to return
> > > > error (eg: EPERM or ENOTSUPP) if someone tries to enable dither
> > > mode and
> > > > no TGPx pin was selected for that channel? Hence, we do not
> need
> > > to add
> > > > the sw_toggle ABI  (out_voltage_symbol) for the default/dither
> > > mode. Or
> > > > maybe even better, we just expose the dither ABI if a TGPx pin is
> > > given over
> > > > dt (I try to explain the toggle/dither modes below; that might
> help
> > > you in
> > > > understanding my reasoning here)?
> > > >
> > > > Alternatively, we just keep the approach I have in this RFC and
> we
> > > keep the
> > > > 3 different modes (being mode a dt property; in the current state
> I'm
> > > using
> > > > a boolean to say a channel Is in toggle mode)... Maybe with the
> > > difference
> > > > that we allow sw_toggle for toggle enabled channels.
> > >
> > > The corner I'm not clear on is what we do if for example all TGPx
> pins
> > > are
> > > specified in DT.  Is the mapping from channel to TGPx things in
> toggle
> > > mode
> > > always a function of the external circuit or do we want to make it
> > > runtime
> > > controllable?
> > >
> > > I'm absolutely fine if we just make it a dt property - particularly
> > > as those TGPx pins may well not be visible to the host processor.
> > >
> > > We probably do want to provide some options in dt for what they
> > > might be
> > > connnected to on the host.  I'm guessing potentially a gpio, or a clk=
?
> >
> > For each TGPx pin (from the point you bind it to some channel), I'm
> > actually making it mandatory to have a clock (the reasoning being, if
> you
> > say some channel is controlled over TGPx [being for toggle or dither
> mode],
> > you need to have some input at the pin).
>=20
> I'm not really sure what the usecases behind toggle are...  Using a clock
> with dither makes sense, but toggle might not be fixed frequency but
> driven by some other type of event.

Taken from the datasheet (usecases for toggle mode):
"Examples include injection of a small ac bias, or independently switching
between on and off states". A clock seems to fit even though I get your
point that it might not fit all usecases for this. In that case, maybe sw_t=
oggle
can be enough :).

Anyways, agreed that we do not have to support all the stuff at the very
beginning and it's probably a bad idea specially in cases like this where w=
e
are not sure about all possible usecases.

- Nuno S=E1
