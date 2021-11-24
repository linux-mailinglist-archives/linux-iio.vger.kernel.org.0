Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5545B53E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 08:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhKXHXs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Nov 2021 02:23:48 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:38624 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhKXHXr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 02:23:47 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANJmWvR019947;
        Wed, 24 Nov 2021 02:20:35 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cg6mm5f0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 02:20:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJtOdFCOWu2PDP52Cus3NWetsOgW7aMrlfxuFHPu2UzsqJzBREVziRa35ZSScSR0Z4RHt+6GD0jpNJY/J2au61wMhyVXeC2pTMiWtHyqvl+PO7CiPuQNDN2CO8WCiDcl3d3gwHlynF7iETGDpjF7iz6b66+pUZEcG/Uz09fT2bH1wfuelh+SExBGM4DoHn2MpuYDDrO5qrVZEBjoEAPgr7qPN1zPwc9lWL7ZvyxlxD9cLpXelMYtpzznJV2qMng6f3bXxwlEIAG7MtP0aZ0BXdV62FzcqywBUP+4ojkSHDQPJENVSQ8bFoq0Y1Me8KmqtidK3ookQH0ZbD+1IvINJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/v1Q/jrI8tnjS+lOcYp9hrQ3i0YQLbIzcK0DIut5GY=;
 b=lJruvSaKKFz9MQNe48+bwuO+uHZVUmRWy4SzJ6236ISQsByc9XEac4flHTZug5G64fiXhHJG9fK7OOQbI23HSUPjc3VGmbsgKZq7MCUanD9Gp3iY2LVEgDNYhgU3fl61nE3gpNTG09FNn/V7rJrd+EbkZTYO/MbAbIxeGFm+QalejME+dWTG/7jtU10bbJN+LzA3QuEMmkNqf41gEdVU8wfH6ekQURbD7m+wfnolB6kGXjWBs4SAXFzrrpSLGeDZmCbW+Hl743kFnr6/InjTkcgyDKte3rCbCWlp12Zv8mbVTdKCOXcr8H7Uv8YuW+DFMJGasvW2GmsqJLpbKW2UYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/v1Q/jrI8tnjS+lOcYp9hrQ3i0YQLbIzcK0DIut5GY=;
 b=ScRxrOevWX31ma670ysqZ4faXYgvrXlFOPpmUSXjD1c9SOug3/7JZIMr2+uQGIadV8AaCN/+pc4m+evf2EqR3tGIa/uiYgLwTeCneNQlMmtV7AJFiXsy9/8NqZ2tk7T8POxgYXHPLtJ0wNnveiwMIsj+sNH8OSwnxaOXoxP2tWU=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CY4PR03MB2934.namprd03.prod.outlook.com (2603:10b6:903:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Wed, 24 Nov
 2021 07:20:32 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::70e8:1ee0:f071:3de5]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::70e8:1ee0:f071:3de5%5]) with mapi id 15.20.4734.020; Wed, 24 Nov 2021
 07:20:32 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     kernel test robot <lkp@intel.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Subject: RE: [PATCH v2 2/4] iio:filter:admv8818: add support for ADMV8818
Thread-Topic: [PATCH v2 2/4] iio:filter:admv8818: add support for ADMV8818
Thread-Index: AQHX4G+ENPdQLXiLFE+FDQuAu6pTy6wSAvsAgABCDJA=
Date:   Wed, 24 Nov 2021 07:20:32 +0000
Message-ID: <CY4PR03MB3399989F62B3CB6E86766C709B619@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20211123133900.133027-2-antoniu.miclaus@analog.com>
 <202111241151.J9kfWWOf-lkp@intel.com>
In-Reply-To: <202111241151.J9kfWWOf-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy1mZjdiYzU5Ny00Y2Y2LTExZWMtYWJmNS?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcZmY3YmM1OTgtNGNmNi0xMWVjLWFi?=
 =?iso-8859-2?Q?ZjUtZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI0Mjg4IiB0PSIxMzI4Mj?=
 =?iso-8859-2?Q?IxMjAyODY1MzcyMTYiIGg9IjREcmpDUFozY3Z0eDRicmdzQ05zZ2dmNjdF?=
 =?iso-8859-2?Q?dz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQUFSdjdCQStIWEFhak96dEdaWUdtZ3FNN08wWmxnYWFB?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBWFEvampRQUFBQUFBQUFBQUFB?=
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
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f0b3328-0119-4389-2aca-08d9af1ae692
x-ms-traffictypediagnostic: CY4PR03MB2934:
x-microsoft-antispam-prvs: <CY4PR03MB2934FC968B298B0756F04A599B619@CY4PR03MB2934.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwooxSkzcLN0UzAvD2okTJkaHJchE9J4abMNVjBQw6AKrRfmfr2vgAiFKjn44KCdjPLlCDZ3GnEOpwNvPaUY6jQHcx4D3RC9SRqGUKBdU1PEWN62oUbQEHTUvPuVR8CT+dx3SLM+1SoQl21XoDnsWJBexPhTCEKHazCaz+k4OrVj2cnP4XecHChFDGYVTsl6kzmaSk6MVJG0eT20ftiLo/GtQBwHb2zU6tnI0VO3lHGIAgzQSdkw6ikpf1ZxvwxsfUJ/WWwu4ugql8KBpcPbfXu3UbCVNM3MwdiWORRairYaUxdjVp/5LyRfBwyauRu1HMk5Ag0DFxpK/REtDGaraZ2omp05BvTnT4sBhXC/BwTJy15PYZLQ7eanzJkPRY1wLMR6u3lFpXEvYNSMn4Y590G1GpdxGRW4tMj0tRA3exbO4gKZE/GHTs2QOuiW/atvDkDd1ZCpz2tzyw0Zfw2oRFa5lfu0SOMGLXF81Uv1LrgJ6a+hBajfb/aTvYoUOAFzcsaFM3Qk+nPGJ1hTP4XL1tbOu1HTAIux0qbQ1/+td+V/h14gb46nI46JISeFpITMlEN9WoHqUnkOjoWVfPsu9W5PEU0SF012nHvCyYTWJGc221CJIb8YA/no8tswdGX5X86TJL0U+/E4t6oxsVsGjkpJ5GJMaiTCnTlHptQqW/Mnp6nmWc2FKJ/YcJXL96qq1XqMVlSQseW+zK2x85vTFVsel5Segm/adXrqFW8y4kPeJ4/GjwFIldVShUgIpvNiutgqlnKEFYbzqPb78To5dsBbnDvCJPg3lbwulxMYeoxVlnFDfLAx+MYjNxT1BIKJPEHvFW7e/sWgU8TxSSmq+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(53546011)(38070700005)(110136005)(66574015)(83380400001)(7696005)(508600001)(316002)(6506007)(52536014)(966005)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(38100700002)(2906002)(122000001)(26005)(9686003)(4326008)(8936002)(19627235002)(55016003)(71200400001)(76116006)(86362001)(33656002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?dAwITuu6/6kQn231O09m93QjWgvWL6VEmNGxUQn3/NeekJCaG3klrH4oh5?=
 =?iso-8859-2?Q?ZxjWCtkcJe4X+TehbfvcMtKLs2eawhNz00fU5p7vz0+3rqZQLI2ivGWr2s?=
 =?iso-8859-2?Q?PMBwgAHqeF6x7QbRVM8RW6Wxkm7iCAM5P+tIGYI2lKIpj/836nZDqMpEV2?=
 =?iso-8859-2?Q?mRtc8Vm2leMyMn2J+tZjznkKGpec4BQFmRATuxWAnJlOD9IXjyPfOTuJzx?=
 =?iso-8859-2?Q?hTTZvf3jTb4iWoniXcA6KqhfeUiGo6813LJYjCpxKPxGS57gvf4CFmgwXt?=
 =?iso-8859-2?Q?aM9dn2qjHNN8IVwBsOo5oMuJMKqQAd7GmXvqAF0iElsRzparcfl7lOuvGf?=
 =?iso-8859-2?Q?B644mXXl6SuZew550BVfIwX4zyBhSTwjCQsrRM8girJunfLg+Q24wzKYhH?=
 =?iso-8859-2?Q?5urzFJ7PZzgU/DAflRa4bX+mnKZk+ytFqiaHDkToszlVhihyw9yAUywhsR?=
 =?iso-8859-2?Q?oaM+WRA7ACuvwFBN3Y2bGltSREjsOBFjrl3FNNxFXCpoi1TaXZMmDsuRRw?=
 =?iso-8859-2?Q?xLEZmicG242ldIqh56rQVpTwPOttxkVbYHXzjP7VSR6Z0Oio/dafz2iflX?=
 =?iso-8859-2?Q?BtSBEX8cBIrPBugeGgSj++1yhN2z7SpSCY/eNCQMuPrCXN58T/9WGOcXAw?=
 =?iso-8859-2?Q?/qNKiVxbxMCXHmRJsPPN+DsRgFqD3V8h0b15axLdq2Fvch+QPk0VQ6pjjf?=
 =?iso-8859-2?Q?gMzZVYz+HHj4wE69lhcfMajmL2cSD1m+Sp8gN+qy6o2yhH8fuNG0qKjLH1?=
 =?iso-8859-2?Q?DacACdu7l/B3pMRZKlqSyOOFV9QwLn6ALdJByOLBlvao/k7P0Ql5jwGDVR?=
 =?iso-8859-2?Q?9BlQT2jCYDHHjNNNtvzCUPAMoeCajHDLQTwpbr80MCHCNHKcJXHLn7NhMo?=
 =?iso-8859-2?Q?W7/BMGytoz0+xHr76Rpnnu+VEDXzSv6cI3p9tECj3ZyHMKNQAPml7R4CGE?=
 =?iso-8859-2?Q?mUOnQ6xNeGDa6ostdol1yGqMvzSfSKT72imFNxJHS67xyYR5Jn/Ki2CEH/?=
 =?iso-8859-2?Q?kYDvN/6kNCdOmeQFc6riZavgSueYvebEnSMBAgawtksTH2l+1uYZ6KNlJH?=
 =?iso-8859-2?Q?Gtku8WP3/8+Pc2ofL3zBmWHUtqpqxEstX4O1Sp4E+djo2XTg5taD0bebbS?=
 =?iso-8859-2?Q?18X5Bq8vEaXtth3RT5B4H9GodL9qUlW7ZLBTE6vXELUyWPyq79ZqS1I1gv?=
 =?iso-8859-2?Q?rui4Z3GCVrA1CM7zTfniTIgCpACAKt3NsU3Pk5tLis28E0jE9qP+08UIfM?=
 =?iso-8859-2?Q?fAy0mXVrMo+Zqkw3UAUCkNAuXWc2bvGwENZw2KD+uBtXwjUuAzaML4nhcg?=
 =?iso-8859-2?Q?aFjuCExM85KyX92h2f7ek1uJUvp5nLMyf8XpVzlpsJpYRW8J+c3KLsIPos?=
 =?iso-8859-2?Q?nneaMlWORYzKFRCl0JkyjyPNbdh4l+rmjUbBpcCEAag0+EM0YLhFRqU+QO?=
 =?iso-8859-2?Q?trMwkXspsohgeTSg5SQ1K69RlL5h0hBVMKVs/bw/QCVwYTJH7JMqHThveA?=
 =?iso-8859-2?Q?vGYRmVjiU9llHfAJbHQ9wXk1oGNcecsnl1oCvRZdv4/rQVwt1KQ5j8RYdl?=
 =?iso-8859-2?Q?vkOQBg5F2JjBNX1e7qUyJgPV4KxzHdvXko79PL+sQ+jkckKnvKJWyF5fAP?=
 =?iso-8859-2?Q?A7tVjgBwUHzNwMxschfqZRl+HMMnTbtfFZgc/l+e3dhH6IWZ5jyqbeyQWY?=
 =?iso-8859-2?Q?wpTPqRTHM+ILMulsmHiTeRh7jqFOys3Idmcj+J0X4rCHScYk60F2E4Vcs1?=
 =?iso-8859-2?Q?8qaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0b3328-0119-4389-2aca-08d9af1ae692
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 07:20:32.1075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRSoSHI1U4+EDoGFjggA3yVTBvBTpbNWNa2uuzzXMsPRPJZK4sr4P5QQZn/1UatTXMidZm9E1TH+1kaNOl8Coa+Ps2RT5EyPyL5VZOZRMWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2934
X-Proofpoint-GUID: B4BNaTnwvZn9ehHSYkGUtXMK3BdQR0vU
X-Proofpoint-ORIG-GUID: B4BNaTnwvZn9ehHSYkGUtXMK3BdQR0vU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240041
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Wednesday, November 24, 2021 5:18 AM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; jic23@kernel.org;
> robh+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: kbuild-all@lists.01.org; Miclaus, Antoniu <Antoniu.Miclaus@analog.com=
>
> Subject: Re: [PATCH v2 2/4] iio:filter:admv8818: add support for ADMV8818
>=20
> [External]
>=20
> Hi Antoniu,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on v5.16-rc2 next-20211123]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://urldefense.com/v3/__https://git-scm.com/docs/git-format-
> patch__;!!A3Ni8CS0y2Y!qezv4zARrMS9nlUF2pyY55iNqZQOzXhLKmtpaNcqkCI
> zWdlzlwyoRyKLHRxkS_1UDWEO$ ]
>=20
> url:    https://urldefense.com/v3/__https://github.com/0day-
> ci/linux/commits/Antoniu-Miclaus/iio-add-filter-subfolder/20211123-
> 214053__;!!A3Ni8CS0y2Y!qezv4zARrMS9nlUF2pyY55iNqZQOzXhLKmtpaNcqk
> CIzWdlzlwyoRyKLHRxkS3HtIozj$
> base:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/g
> it/jic23/iio.git__;!!A3Ni8CS0y2Y!qezv4zARrMS9nlUF2pyY55iNqZQOzXhLKmtp
> aNcqkCIzWdlzlwyoRyKLHRxkS8fYcXl7$  togreg
> config: x86_64-allyesconfig
> (https://urldefense.com/v3/__https://download.01.org/0day-
> ci/archive/20211124/202111241151.J9kfWWOf-
> lkp@intel.com/config.gz__;!!A3Ni8CS0y2Y!qezv4zARrMS9nlUF2pyY55iNqZQ
> OzXhLKmtpaNcqkCIzWdlzlwyoRyKLHRxkS7LldO4I$ )
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=3D1 build):
>         # https://urldefense.com/v3/__https://github.com/0day-
> ci/linux/commit/5785226a8e5139d7275a8213a19c4e8479eca28b__;!!A3Ni8CS
> 0y2Y!qezv4zARrMS9nlUF2pyY55iNqZQOzXhLKmtpaNcqkCIzWdlzlwyoRyKLHR
> xkSyLuvece$
>         git remote add linux-review
> https://urldefense.com/v3/__https://github.com/0day-
> ci/linux__;!!A3Ni8CS0y2Y!qezv4zARrMS9nlUF2pyY55iNqZQOzXhLKmtpaNcqk
> CIzWdlzlwyoRyKLHRxkS5pcjrk6$
>         git fetch --no-tags linux-review Antoniu-Miclaus/iio-add-filter-
> subfolder/20211123-214053
>         git checkout 5785226a8e5139d7275a8213a19c4e8479eca28b
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
> >> drivers/iio/filter/admv8818.c:469:74: error: macro
> "IIO_ENUM_AVAILABLE" passed 3 arguments, but takes just 2
>      469 |  IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL,
> &admv8818_mode_enum),
>          |                                                               =
           ^
>    In file included from drivers/iio/filter/admv8818.c:14:
>    include/linux/iio/iio.h:111: note: macro "IIO_ENUM_AVAILABLE" defined
> here
>      111 | #define IIO_ENUM_AVAILABLE(_name, _e) \
>          |
> >> drivers/iio/filter/admv8818.c:469:2: error: 'IIO_ENUM_AVAILABLE'
> undeclared here (not in a function)
>      469 |  IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL,
> &admv8818_mode_enum),
>          |  ^~~~~~~~~~~~~~~~~~
>=20
>=20
> vim +/IIO_ENUM_AVAILABLE +469 drivers/iio/filter/admv8818.c
>=20
>    466
>    467	static const struct iio_chan_spec_ext_info admv8818_ext_info[] =3D=
 {
>    468		IIO_ENUM("filter_mode", IIO_SHARED_BY_ALL,
> &admv8818_mode_enum),
>  > 469		IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_ALL,
> &admv8818_mode_enum),
>    470		{ },
>    471	};
>    472
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://urldefense.com/v3/__https://lists.01.org/hyperkitty/list/kbuild-
> all@lists.01.org__;!!A3Ni8CS0y2Y!qezv4zARrMS9nlUF2pyY55iNqZQOzXhLKmt
> paNcqkCIzWdlzlwyoRyKLHRxkSyoFmbJO$

Similar to ADMV1013, this patch depends on:
https://patchwork.kernel.org/project/linux-iio/patch/20211119085627.6348-1-=
antoniu.miclaus@analog.com/

