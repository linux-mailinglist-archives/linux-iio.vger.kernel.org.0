Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942C5469799
	for <lists+linux-iio@lfdr.de>; Mon,  6 Dec 2021 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbhLFN7i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Dec 2021 08:59:38 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37244 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244970AbhLFN7g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Dec 2021 08:59:36 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B692c8e030469;
        Mon, 6 Dec 2021 08:56:02 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3csfhu0xkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 08:56:02 -0500
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 1B6Du2EC005671;
        Mon, 6 Dec 2021 08:56:02 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3csfhu0xkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 08:56:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ5O+EY9iRYSaIuCyUn+++gCjNvQnvLPqw3MxIs5EtbebzZn8R0+v5XdpzX5KghJAbCEP4YUnPCmJ1e9sp1+CAAtY3UvxAMmk9jaHtkrpMQM0/HvZASgI0duQ3HBKy1KJaNaoHfHAspaZQ54xbDLIjeW6M8DYkvNWfDhhjgnZxe4ozMNEuEd3/xQYD3b68VQ/ffj99tkHCp8bqB3kdd8I8wVLvnmHjLsJHrmqZKGBBjMjqhSfORSLTIP+P4FmdMypdUQodHcBa2l9fNXVcYn0Y4vk8msPV6tYlakIUwgo6RfYcoFNxyRzIPFO8R5hGOFhD6N+BPFuKJxuRwpFcnAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mDwn2Z+UV2EF/pmq8P4U6cGNihXjT3gi12oKp+rpzA=;
 b=OtclSz/FJgKIWb8GaZXCRQ7m4YArGjNaKWsIrIUSv/zDiFtjTsoyXXiFGOMJzlm+UgTow/dL1zDL9aD5ifw9bAzGoIEhK/LJhV2pXBe7cfkqBiISJUZEqRZyJgYrPfmHnYfMCHnsioeNVfabHYbaEBMPjjc9KS1KaoPEhY9vuNla41nzpYXXmLRf+VuNzPVKVGnKis+Pre966kksy7XDTwDBX6p4EMEIjTvcmxWslB4nzk1yHAzHTYVWuH+qx6BG6z2qewVQTElfQxVNZt6xFpOkqriU1NJhmS5Ed+Y3jzlDgTqeIIR7WhnP13e+DwjzIM15ItDpwf7xdSk/BIe8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mDwn2Z+UV2EF/pmq8P4U6cGNihXjT3gi12oKp+rpzA=;
 b=z7mr95k4qJesFRO5fdxvHm++y8CVVCtxZ7mXKpJ7mBKCdRyypsMtCXlNlCY3FjozLJHQ28K56T3XijMUROpYJBwBmcpbdihuUWzhhQroaV7SgF88iBk0cuwH/ZA8HAKxAQ9o68HPbYPH810FG55MS3PHfSJJqGMs/5kfZFVbpdI=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6528.namprd03.prod.outlook.com (2603:10b6:510:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 13:56:00 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::5d02:4f14:9f83:6055]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::5d02:4f14:9f83:6055%4]) with mapi id 15.20.4713.021; Mon, 6 Dec 2021
 13:56:00 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [RFC PATCH 0/1] LTC2688 support
Thread-Topic: [RFC PATCH 0/1] LTC2688 support
Thread-Index: AQHX1uthp64f7v0trkGvKxQpqJcVI6wAEu4AgAQrh5CACbdVAIAOPJoQgANCw8CABOHegIABGPvQgAAnP4CAAAmHwA==
Date:   Mon, 6 Dec 2021 13:56:00 +0000
Message-ID: <PH0PR03MB6786358A1D2608E2CB5EB990996D9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
        <20211112161437.60dbc872@jic23-huawei>
        <PH0PR03MB6366BFFE85F122FED1B72BB499989@PH0PR03MB6366.namprd03.prod.outlook.com>
        <20211121121756.2297671a@jic23-huawei>
        <PH0PR03MB678687C50B21BD5E448E413699679@PH0PR03MB6786.namprd03.prod.outlook.com>
        <PH0PR03MB6786AB0F1BE42523D0F2AC0299699@PH0PR03MB6786.namprd03.prod.outlook.com>
        <20211205180339.1dfa83b9@jic23-huawei>
        <PH0PR03MB6786E6E2CF68696C705A2592996D9@PH0PR03MB6786.namprd03.prod.outlook.com>
 <20211206130947.000070b3@Huawei.com>
In-Reply-To: <20211206130947.000070b3@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctM2MxOGE3ZTItNTY5Yy0xMWVjLThiYTAtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDNjMThhN2UzLTU2OWMtMTFlYy04YmEwLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTU2ODAiIHQ9IjEzMjgzMjcyNT?=
 =?iso-8859-1?Q?U3NjEyMjcwMiIgaD0iYWs0bzZHbnNxSDJHaFJWdWgyT28rMjdUTG5zPSIg?=
 =?iso-8859-1?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVU?=
 =?iso-8859-1?Q?FBRW9DQUFCT0FZUCtxT3JYQWQ5M2xKcTY2OFhSMzNlVW1ycnJ4ZEVEQUFB?=
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
x-ms-office365-filtering-correlation-id: a51e3517-512d-4a14-57d9-08d9b8c022cb
x-ms-traffictypediagnostic: PH0PR03MB6528:EE_
x-microsoft-antispam-prvs: <PH0PR03MB652882E9EF82DBED643C401E996D9@PH0PR03MB6528.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dKwOJciV+SK++i6HidtLb/4tLB0eCMG5DNrDLZF+zzQ2Nlxdla7lfhlZLNBjIEJAx4Em/36rUOm8gAFyXwcVceg/nrs/sJo+dFcUHo1Jajd5hi3plGA8OzSsTdDob/QT55Hsvw5vTcZ9fBY1vzgOj504px6TDLRvXxCHQvyuIfGoMN+A9wevoMKpo0wD2J1T1Bw0a9y2cu9BWx5QOzzfwDVwQ7ElIC1Vd+ymlr01LiZQpqdWRSDU9LM2IGLVNtDO+l9186UIPxwOk8/UdHNDu15zCNpU7bPY5ftZQEPaF4agvv1aVxs+2ijEqVeDQ6eFbWBTXRGY6AbGScH+dee3QoLr0jxYr9R+JXb2RsxS7yWFynTGzc5uWlvmBIAaFKbl/eRzWhHu2EFJWcd2rmy2HuDbnfWXF3aUoIl/w1VpE99N+wxw8I0gPqEnKGpNTPKbcgseaxVMJkXpREW+6LLhd6MAbS+AsQg65QtFe+/+TG0GduiN3YiC9iV980/qWf8lZFfiNAGJAl626JBiqvCiUrO4lGxppStLob+FFo+Xox5oUtQc59DwFpCdVLIoiqpudFRuWuMGLLfnbCx/qOL68VYSflrdM/x66uSzqufURFPMU0ASWYIVDO99oBDf3I8Tm3fdgOUuFm+NjlxEyzbLYDvRlcO775ZhXE89a95S55POs2ypaMhpLEa9RU7p4KocaDNmtqOUBoP2f2FBJStwFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(33656002)(508600001)(6506007)(122000001)(71200400001)(53546011)(4326008)(7696005)(52536014)(2906002)(66446008)(64756008)(66556008)(5660300002)(30864003)(6916009)(9686003)(26005)(66476007)(54906003)(8676002)(186003)(8936002)(55016003)(83380400001)(66946007)(76116006)(38100700002)(38070700005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0d8lSETD0RPvYPbo+e65ZMiWTZuQLY5LWfUIjJqBwfYOyf6EQSMFPN0n/Q?=
 =?iso-8859-1?Q?dF3hHtLAGIiRwITJEjpHx6ac7chZNGtBm+dJvxwaVZ5CKxtCsUVc74bKK8?=
 =?iso-8859-1?Q?jRIr53nPOMy42jjAP7r0xxz+zyRFrGuAKz+WmDAAyd8TZrqXhl03bedHDI?=
 =?iso-8859-1?Q?jsBj4oofjXrPz3wc8UGHZM7GQVFl189WSA8w4+wNj416huhd4dAtdnA06k?=
 =?iso-8859-1?Q?NXHFc6XQ2jCr0pUq/chu85Pe8B28E/+kB08Ts0ByXe31YYMOBxlhrQMpHF?=
 =?iso-8859-1?Q?cSyvM7KCvtBlAg5iTlkQDAo+VViKE287BCaeLJqK2BVVq4KlMgV3DcCRPy?=
 =?iso-8859-1?Q?nl4lEwt33hROcqROLDWiS9EqlZnab6BZt30RD750iy9FdH16TJJEmlS/a+?=
 =?iso-8859-1?Q?4soapxHQzp4iH2axo+C6ECQV8FFEUd8fsm5ZqF1iiXO85bpvDL38h4iOuk?=
 =?iso-8859-1?Q?G7qi7sgCDNUVDZqeB7SjTzg5p1SGpGXeAYIl126vklAAs+VPKaEBnCcsGz?=
 =?iso-8859-1?Q?gz/ApHQGLRflGNDW4FgsTbhLyMdVZl7yjJ4cb8hfpgvoP6JwvAxWoIzfBx?=
 =?iso-8859-1?Q?jPy6o/672//h/qKkc2EguIa0VgIr21gCkOG91RJOnlv7Vt/kMPi56JwLAL?=
 =?iso-8859-1?Q?mCqhqGQWZURsVAuoU3JdB7QhmjQkAf319mFVG0dO1c3L+l3xHnmIaGkTSU?=
 =?iso-8859-1?Q?Hmtnaj2GSkuIT8Lpl+0Jkj83Eo6LilRypLMBRODqQBwP4QXPdCYmvoA29Z?=
 =?iso-8859-1?Q?Rj/b6uLnvfpFGEzupndd2u47ov976Uq/7zJZMKQK2S3IR+vo0E+jlnRReI?=
 =?iso-8859-1?Q?7U84G8VudZZqDywlKGxm2zEur8ITW6IKZgFCVsy6cnY1RVAst3y8DdubsO?=
 =?iso-8859-1?Q?lcZkT4h5k4Yo5aB4LU+RyBmWfUgBH+TrUw5sFjvFaRqcp3kwZyoSkFbnqc?=
 =?iso-8859-1?Q?igo3MHQa+LFn//r50ECOIXFCkegi6HhmqlHLpg5pmM7I6aqhE/YNHJlvsS?=
 =?iso-8859-1?Q?0W2Yq6qEGGatyR3VmjSrjPwkU3N7u5VUyxwOwlklw2pMIo5b/RaWLdjzqT?=
 =?iso-8859-1?Q?ZCjHYlr0PKS5Vt7EuHTyGAOg04Gmnq29wylBlWNwhf8RmWzb5IiRPfAJDb?=
 =?iso-8859-1?Q?fDq9+jJMN2MAjn6h9hkagZN6ghNNikkEBjmTTUR3k4bO+Mqu4ALxkIjK88?=
 =?iso-8859-1?Q?8iuX6K46KiE3Fmog73607ZbS5vVLfBNmqKww7tm5UGtv9FZErXgGsuQcYF?=
 =?iso-8859-1?Q?aRDcp25i31/fA50IBjSB1us7FnW8CganbIsnD5KKTmd5UxLMqzL6u7qDRM?=
 =?iso-8859-1?Q?YpuGL92byKcEP5O+/M2BkQhj5HJNHfcl4V8Iktxpxyfcc14SQ2azfLGUJK?=
 =?iso-8859-1?Q?HaWIeNg0jNyLpv77vcLG+poe+JWLtw7Xf8cwusq/0WIXeaWk2PCg++dBY8?=
 =?iso-8859-1?Q?oigCvGV+Au17gBqprfgSy5gLCbxmCgh7D7BHN4H++JS0V7yPiNjoiOhYJR?=
 =?iso-8859-1?Q?iTtdRX0Y4q+m8jvfQ0nz3WAwNdrSO3AwcLmrtBDMrkcvV46KecX2HXUwTt?=
 =?iso-8859-1?Q?IB6dF6tQJholxAcbJ/CdaGeMrVQKAOsS2gAtWRhGlu9dlCwwXvZt9aWYlA?=
 =?iso-8859-1?Q?KAZuS7YCB7Klg/rYaAti2b686EraAbvY72+5pJp7irvB32nz68yFYxAw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51e3517-512d-4a14-57d9-08d9b8c022cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 13:56:00.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWxKOMcIw+7VnAqhJvx8eFeYnSzdFxuaz5GGmRyamvh5kUWh9T6IzFvYtcSCR58hmy4K/0xr1TBIXYXyty17MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6528
X-Proofpoint-ORIG-GUID: wRi6LI9N73rM34cPXGAkWNkGfTD0j5cM
X-Proofpoint-GUID: jXdma_J41EQeEH6BntRzsoh0JxIUe2FJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060086
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Monday, December 6, 2021 2:10 PM
> To: Sa, Nuno <Nuno.Sa@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; linux-iio@vger.kernel.org
> Subject: Re: [RFC PATCH 0/1] LTC2688 support
>=20
> [External]
>=20
> On Mon, 6 Dec 2021 11:07:55 +0000
> "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
>=20
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, December 5, 2021 7:04 PM
> > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > Cc: linux-iio@vger.kernel.org
> > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > >
> > > [External]
> > >
> > > On Thu, 2 Dec 2021 15:37:40 +0000
> > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > >
> > > > > -----Original Message-----
> > > > > From: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > Sent: Tuesday, November 30, 2021 3:43 PM
> > > > > To: Jonathan Cameron <jic23@kernel.org>
> > > > > Cc: linux-iio@vger.kernel.org
> > > > > Subject: RE: [RFC PATCH 0/1] LTC2688 support
> > > > >
> > > > > [External]
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > Sent: Sunday, November 21, 2021 1:18 PM
> > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > Cc: linux-iio@vger.kernel.org
> > > > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > > > >
> > > > > > [External]
> > > > > >
> > > > > > On Mon, 15 Nov 2021 10:28:51 +0000
> > > > > > "Sa, Nuno" <Nuno.Sa@analog.com> wrote:
> > > > > >
> > > > > > > Hi Jonathan,
> > > > > > >
> > > > > > > Thanks for your inputs...
> > > > > > >
> > > > > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > > > > Sent: Friday, November 12, 2021 5:15 PM
> > > > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > > > Cc: linux-iio@vger.kernel.org
> > > > > > > > Subject: Re: [RFC PATCH 0/1] LTC2688 support
> > > > > > > >
> > > > > > > > [External]
> > > > > > > >
> > > > > > > > On Thu, 11 Nov 2021 12:00:42 +0100
> > > > > > > > Nuno S=E1 <nuno.sa@analog.com> wrote:
> > > > > > > >
> > > > > > > > Hi Nuno,
> > > > > > > >
> > > > > > > > > The reason why this is a RFC is because I'm still waiting
> for
> > > > > proper
> > > > > > HW
> > > > > > > > > to test this thing. The reason why I'm sending this
> already is
> > > > > > because
> > > > > > > > > there's some non usual features which might require
> extra
> > > ABI.
> > > > > > > > Hence,
> > > > > > > > > while waiting I thought we could already speed up the
> > > process
> > > > > in
> > > > > > > > regards
> > > > > > > > > with the ABI.
> > > > > > > >
> > > > > > > > Wise move as this is an unusual beast :)
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I still pushed the driver but the intent here is not real=
ly
> to
> > > > > review
> > > > > > it.
> > > > > > > > > Naturally, if someone already wants to give some
> feedback,
> > > > > > that's
> > > > > > > > very
> > > > > > > > > much appreciated :)
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Now, there are three main interfaces depending on the
> > > > > channel
> > > > > > > > mode:
> > > > > > > > >  1) default (no new ABI)
> > > > > > > > >  2) toggle mode
> > > > > > > > >  3) dither mode
> > > > > > > > >
> > > > > > > > > The channel mode will be a devicetree property as it
> does
> > > not
> > > > > > really
> > > > > > > > > make much sense to change between modes at runtime
> > > even
> > > > > > more
> > > > > > > > because the
> > > > > > > > > piece of HW we might want to control with a channel
> might
> > > be
> > > > > > > > different
> > > > > > > > > depending on the selected mode (I'm fairly sure on this
> > > > > between
> > > > > > > > toggle
> > > > > > > > > and other modes but not so sure between dither and
> > > default
> > > > > > mode).
> > > > > > > >
> > > > > > > > I agree on toggle vs dither definitely being different, but
> > > normal
> > > > > > you
> > > > > > > > could implement either as software toggle, or dither with
> a 0
> > > > > > > > magnitude
> > > > > > > > sine wave.  So might not be worth implementing default
> > > mode at
> > > > > > all.
> > > > > > > > No harm in doing so though if there are advantages to
> having
> > > it.
> > > > > > >
> > > > > > > My feeling is that we could probably have dither as the
> "default
> > > > > > mode".
> > > > > > > More on this below...
> > > > > > >
> > > > > > > > >
> > > > > > > > > toggle mode special ABI:
> > > > > > > > >
> > > > > > > > >  * Toggle operation enables fast switching of a DAC
> output
> > > > > > between
> > > > > > > > two
> > > > > > > > > different DAC codes without any SPI transaction. Two
> codes
> > > are
> > > > > > set
> > > > > > > > in
> > > > > > > > > input_a and input_b and then the output switches
> > > according to
> > > > > > an
> > > > > > > > input
> > > > > > > > > signal (input_a -> clk high; input_b -> clk low).
> > > > > > > > >
> > > > > > > > > out_voltageY_input_register
> > > > > > > > >  - selects between input_a and input_b. After selecting
> one
> > > > > > register,
> > > > > > > > we
> > > > > > > > >    can write the dac code in out_voltageY_raw.
> > > > > > > > > out_voltageY_toggle_en
> > > > > > > > >  - Disable/Enable toggle mode. The reason why I think
> this
> > > one
> > > > > is
> > > > > > > > >    important is because if we wanna change the 2 codes,
> we
> > > > > > should
> > > > > > > > first
> > > > > > > > >    disable this, set the codes and only then enable the
> mode
> > > > > > back...
> > > > > > > > >    As I'm writing this, It kind of came to me that we can
> > > probably
> > > > > > > > >    achieve this with out_voltageY_powerdown attr
> (maybe
> > > > > takes a
> > > > > > bit
> > > > > > > > more
> > > > > > > > >    time to see the outputs but...)
> > > > > > > >
> > > > > > > > Hmm. These corner cases always take a bit of figuring out.
> > > What
> > > > > > you
> > > > > > > > have
> > > > > > > > here is a bit 'device specific' for my liking.
> > > > > > > >
> > > > > > > > So there is precedence for ABI in this area, on the
> frequency
> > > > > > devices
> > > > > > > > but only
> > > > > > > > for devices we still haven't moved out of staging.  For
> those
> > > we
> > > > > > > > needed a means
> > > > > > > > to define selectable phases for PSK - where the selection
> was
> > > > > > either
> > > > > > > > software or,
> > > > > > > > much like here, a selection pin.
> > > > > > > >
> > > > > > > > out_altvotage0_phase0 etc
> > > > > > > >
> > > > > > > > so I guess the equivalent here would be
> > > > > > > > out_voltageY_raw0
> > > > > > > > out_voltageY_raw1
> > > > > > > > and the selection would be via something like
> > > > > > > > out_voltageY_symbol (0 or 1 in this case). - note this is
> only
> > > > > > > > relevant if you have the software toggle. Any enable
> needed
> > > for
> > > > > > > > setting
> > > > > > > > can be done as part of the write sequence for the  raw0 /
> > > raw1
> > > > > and
> > > > > > > > should
> > > > > > > > ideally not be exposed to userspace (controls that require
> > > > > manual
> > > > > > > > sequencing
> > > > > > > > tend to be hard to use / document).
> > > > > > >
> > > > > > > Yeah, I thought about that. I was even thinking in having
> > > something
> > > > > > like
> > > > > > > *_amplitude for dither mode. In some cases, where we
> might
> > > be
> > > > > left
> > > > > > > in some non obvious state (eg: moved the select register to
> > > input b
> > > > > > and
> > > > > > > then we failed to set the code;), I prefer to leave things as
> > > flexible
> > > > > as
> > > > > > > possible for userspace. But I agree it adds up more
> complexity
> > > and
> > > > > in
> > > > > > > this case, I can just always go to 'input_a' when writing
> 'raw0'...
> > > > > > >
> > > > > > > > However, I'm not 100% sure it really maps to this case.
> What
> > > do
> > > > > > you
> > > > > > > > think?
> > > > > > >
> > > > > > > I think it can work. Though out_voltageY_symbol probably
> > > needs to
> > > > > > be
> > > > > > > shared by type to be coherent with what we might have
> with
> > > > > TGPx.
> > > > > >
> > > > > > That's fine.
> > > > > >
> > > > > > > Note the sw_toggle register has a bit mask of the channels
> we
> > > > > want
> > > > > > to
> > > > > > > toggle which means we can toggle multiple channels at the
> > > same
> > > > > > time.
> > > > > >
> > > > > > Using that wired up to buffer mode might make sense.  You'd
> > > > > provide
> > > > > > multiple
> > > > > > buffers and allow channels to be selected into one of them at
> a
> > > time.
> > > > > > Each
> > > > > > buffer is then tied to a different toggle (TGP0, TGP1, etc)
> > > > > >
> > > > > > The same could be true for the software toggle.  It'll get a bi=
t
> > > fiddly
> > > > > > though.
> > > > > >
> > > > > > Perhaps this is an advanced feature to think about later...
> > > > > >
> > > > > > > It works the same with TGPx if you map multiple channels
> to
> > > the
> > > > > > same
> > > > > > > pin.
> > > > > > >
> > > > > > > There's also the question on how to handle this if a TGPx is
> > > > > provided?
> > > > > > > I guess it will just override the pin... But most likely havi=
ng
> them
> > > > > both
> > > > > > > at the same time will lead to non desired results (unless we
> > > have a
> > > > > > > way to gate/ungate the clocks)...
> > > > > > I don't follow this bit.  You mean TGPx and software toggle. As
> far
> > > as I
> > > > > > can
> > > > > > tell it's an either/or thing per channel.
> > > > > >
> > > > >
> > > > > Here I meant that if we have a TGPx pin bundled to some
> > > channel(s)
> > > > > we
> > > > > do not want to also dance with the sw_toggle bit of that
> channel.
> > > >
> > > > Just a note on this. After starting my tests with the device, I can
> > > actually
> > > > say that if we have a TGPx set in the channel settings register, th=
e
> > > device
> > > > will pretty much ignore the sw_toggle settings for that channel. I
> > > could
> > > > see that the output voltage was not toggling at all. As soon as I
> > > removed
> > > > the TGPx setting, then dancing with the sw_toggle started to
> work.
> > > So, for
> > > > the HW this is not really an issue as it just ignores the sw_toggle=
.
> On a
> > > SW
> > > > perspective, I'm still not sure if I just ignore this and write
> whatever
> > > the
> > > > user sets or if I return some error code in the case a user tries t=
o
> > > toggle
> > > > a channel with a binded TGPx. The first one is appealing as it
> makes
> > > the
> > > > code much simpler while OTHO it might make sense to be
> verbose
> > > here
> > > > otherwise the user might think something is happening when it
> > > isn't...
> > >
> > > If we are in a static configuration (see below) then just don't
> expose
> > > the
> > > software toggle control.  Not having a big red button to press is the
> > > best way to
> > > tell userspace to not press the big red button...
> >
> >
> > Hmm, I get your point and that's valid if I have the sw_toggle as a per
> > channel attribute. Right now, I'm doing it as shared_by_type. The
> reason is
> > the sw_toggling is done by writing 1/0 in the toggle register and that
> register
> > is a bitmask being the mask 16bits wide. This allows you to toggle
> channels
> > at the same time in the same way you can do it if, say, you map 2,3 or
> more
> > channels to the same TGPx pin.
>=20
> Hmm. That will be tricky to support in a remotely 'general' way.
>=20
> >
> > However, I'm also not happy for having this as shared_by_type attr.
> One of
> > my complains is that it makes it look like a dither capable channel wil=
l
> also
> > support this (and we already agreed that sw_toggle does not make
> sense
> > for dither mode; so do not expose it). For instance the output of
> > 'iio_attr'  on a dither enabled channel is:
> >
> > ```
> > root@analog:~# iio_attr -c ltc2688 voltage0
> > dev 'ltc2688', channel 'voltage0' (output), attr 'calibbias', value '0'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'calibscale', value '0=
'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'dither_en', value '0'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'dither_frequency',
> value '32768'
> > dev 'ltc2688', channel 'voltage0' (output), attr
> 'dither_frequency_available', value '32768 16384 8192 4096 2048'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'dither_phase', value =
'0'
> > dev 'ltc2688', channel 'voltage0' (output), attr
> 'dither_phase_available', value '0 90 180 270'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'dither_raw', value '0=
'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'dither_raw_available'=
,
> value '[0 1 65535]'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'offset', value '0'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'powerdown', value '0'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'raw', value '0'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'raw_available', value
> '[0 1 65535]'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'scale', value
> '0.076293945'
> > dev 'ltc2688', channel 'voltage0' (output), attr 'symbol', value '0'
> > ```
> >
> > So you can see that symbol attr which does not make sense to be
> there. And it's
> > definitely not something wrong in the iio_attr app as the attr is
> shared by type.
> >
> > Also, as you suggested, not having the symbol attr when it does not
> make sense
> > to have it also makes a lot of sense to me and that is one more plus
> point to have
> > this as a per channel thing.
> >
> > Anyways, I will probably send the patch with things as I have now so
> you can
> > have a felling of how it looks like. Unless you already tell me to just
> not have it
> > as a shared_by_type attr (which I'm getting more and more
> convinced on my own;
> > I guess I just need an extra push :D).
>=20
> Shared by type indeed doesn't work as it's a subset - however we
> would need
> a means to indicate what subset is used if we want to allow single write
> to toggle multiple.   Mind you - the moment we get to multiple
> channels
> this should probably be using the chrdev route rather than sysfs and
> I'm
> not sure how that would map to this at all.

If someone really wants to toggle multiple channels through SW, one route
would also be to use TGPx (mapping it to multiple channels) and use some
of the host GPIOs to control the pin. Not nice as we would still need to pr=
ovide a
dummy clock to make the driver "happy" but it would be a possible
workaround. This would only fail if all TGPx are already allocated for dith=
er
channels but that's very unlikely. OTHO, if we are doing the toggle through=
 SW
maybe our timings are not that strict so toggling all the channels in a loo=
p is
not that bad...

Well, this is just wondering and playing "if" games so better to keep
it simple and worry about this if such a usecase ever pops up.

> So for now maybe take the view that software control of this is a weird
> feature
> anyway so make it per channel?

Agreed, will make it per channel and only expose it if a TGPx mapping is
not present. I was leaning in that direction anyways :).

- Nuno S=E1
