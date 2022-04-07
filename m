Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE94F7B16
	for <lists+linux-iio@lfdr.de>; Thu,  7 Apr 2022 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiDGJN1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Apr 2022 05:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243732AbiDGJNL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Apr 2022 05:13:11 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850731B0
        for <linux-iio@vger.kernel.org>; Thu,  7 Apr 2022 02:11:11 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2376gTU0007713;
        Thu, 7 Apr 2022 05:10:46 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f6g8bb7yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 05:10:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1S0DtrS9BQDr4/XMej9RTIVME/fzsxiVScOhG2Ta9NcFlEqSkGi7gKSwbglfYfljKTu8BxHq2ePpOa07vzNKwE3QxWcfFMjD3kmOzooDKcAvLxHl0MuIaY0f84SN2NuraS1ODSzxfyO0Ebem33a6LdI/cegH/WoPVRs8QCGF/ADXPoD39sXT6d6rDfWzT/6bpOoTM5NLV00TeAYMV6ax/ZXsc7niw+oCWfl7ICBlZli4n6/V9DnkCX/1qgAb0ebcK5nX8OtbdssiQtee0uNyfEyqw7MSEQGvQWJBgXeotgQDBdyyqt7OSlIeHNwkWOgTa4ifsG8t+G+yRqD/Qt4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RHQ1yEWOsGnIlt7/KCJbEjy92QtX5/LJ2heiXkVcZg=;
 b=bHjlUXKV6A5wpfBkw7+ZeDipGSZ03Cvzbynk3A9uP28rMhxuT/BmOdvbLNyX60AD1L2fYFWIl9qE4yxOjNLke3hOih/p5NILoo4x7y33QKKmLZKOh/oaDCSABAEvOQpWLLiTlnKhTgnw9lSZNBuwp/X0g4H5Wyk44UPi/7NE9eV3iE3sNuSdCvj0SpH9RH2oX2tYepvo8LTLyozUs8QV4ZdOT6qn5THaYN1jdPvxaPoLn0o3iyPbkkhDVlRlA+ZhQ27+U/L1EDZH0gf1718zdCutsMNuVCAnGVrPGe0Kq/jjuvp2EzrIFzbGMht4xbWR1zlVWpyq/WhXHfqad2vD0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RHQ1yEWOsGnIlt7/KCJbEjy92QtX5/LJ2heiXkVcZg=;
 b=Sn6wMTy0IHRIivhiOFhFPgNV3GHjpWL9iDlpbqx3AZlQNOt7WB8qWUVq3f6Sb3AzcHCtS9aqlDOELf9zrMc2Mpjm0SZJGOiDUGCYjRNKd5Wx/wTXaL0lnCyXDlILuE3AZY5xVpMw8WQCtdFQEPVxQ1vTDXFliks+MsDegtmQHo8=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by SN6PR03MB3455.namprd03.prod.outlook.com (2603:10b6:805:3f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 09:10:44 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 09:10:44 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] iio: dac: ad5446: Fix read_raw not returning set value
Thread-Topic: [PATCH] iio: dac: ad5446: Fix read_raw not returning set value
Thread-Index: AQHYScPZNx6ZDrv05EWnql6mejtq1azkKvKw
Date:   Thu, 7 Apr 2022 09:10:44 +0000
Message-ID: <PH0PR03MB678619E8DF5A3A70B50DF6C999E69@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220406105620.1171340-1-michael.hennerich@analog.com>
In-Reply-To: <20220406105620.1171340-1-michael.hennerich@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctOTk4MGU3ODQtYjY1Mi0xMWVjLThiZDctZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XDk5ODBlNzg2LWI2NTItMTFlYy04YmQ3LWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iODAxIiB0PSIxMzI5Mzc5NjI0Mz?=
 =?iso-8859-1?Q?A3NTExMzMiIGg9ImR0aC9tSEpMNjRwM0YvQzZEMjF2cUI5dXhvUT0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBQ2RZZGxiWDByWUFZU2haanZJRW15YmhLRm1POGdTYkpzREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRB?=
 =?iso-8859-1?Q?QUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQm?=
 =?iso-8859-1?Q?xBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdr?=
 =?iso-8859-1?Q?QWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWk?=
 =?iso-8859-1?Q?FCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?iso-8859-1?Q?SE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtBR2tBWHdC?=
 =?iso-8859-1?Q?ekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQWN3QmZBSF?=
 =?iso-8859-1?Q?FBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0b5a3e7-af35-4a93-b1a8-08da18767f4a
x-ms-traffictypediagnostic: SN6PR03MB3455:EE_
x-microsoft-antispam-prvs: <SN6PR03MB3455F4385BBCB755F3F35A0A99E69@SN6PR03MB3455.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vAVDqDMzyTmMFsias6jwW/FF+xPFlRFBeewdpVUdpfCGsN4f/Abx84/1eG6srTTcoW39EAMT9DV3ebCzPG9RsWKqzYMg9SdzK6PE5L3w7s3212THvRhv/jVMORhU7Q7i/9IXrLvoMt21YSYFnMlF8BHNzFjJ/zBnnlmNNXrXKKDajO4Yj4wLO3krUVFtaUNtpnp3jURC349CKgjUWJXCAzJL5ve4RJUmei49v0A8Uxn29p/LR+lANL6mVPOqPREZTvNqh04jftvBTM0H5n4cuItAK7A9iIBrN4E0AjrWWLa0dhTqfNd5+Sd2s/+A4Jr54+VWXMMEHW7A8e6fZvnQVfBSzL+jC9H/zaLZC4Jx64vHc8X3JmF2rYS1iuVCscZQmH2wEQqK/zFv1Z/cDmnQNzwZsEv6RZogwSFUetVoGyglM6anfr4DaVJBZcyeGYxZIHl5QRdsJbSUPmDUoRUUDLMdLfFNWC2jlkhiMJvJT67ImhHMaRJcJLYyKEaMG054bxVtPfUVnE6JLLJ3I6ej2kjLTPFUV4zwq5RsicF6+0pTfpK+N9uA4T5s7tas3Z83MRSZDE9TgpaonmzmKLoZbjcU3pEJFOAl0BNgSvb5slpQQk31r0mRa5n8FD1V5ufG/pxLvDFO7ZfE/at4Tvm8CM/Bn3X05+AaSOLLzgi+oQCpTxfSzcRg/qJ9czsSnAfzvaSP32du2mj+fs/pXe2PHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(83380400001)(38070700005)(26005)(122000001)(186003)(38100700002)(5660300002)(8936002)(4744005)(52536014)(66946007)(66556008)(508600001)(66446008)(55016003)(66476007)(4326008)(64756008)(6506007)(7696005)(53546011)(9686003)(316002)(71200400001)(8676002)(2906002)(110136005)(54906003)(76116006)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BsNLLtK+4FyQsjzE/j4ckiUtmC21krgltjgiekiZDjCQw4b7N4N8UfDqAD?=
 =?iso-8859-1?Q?c0/qnvkVDEE4WAo8KIx+dJA6phKo202Gn6kkDwS7wLowdwFFUIGcnfLkSc?=
 =?iso-8859-1?Q?OgeZy7at5gZUM7qwdlx4FJhQyFHMCCqSkUKC/U+L1TJGHLIx2ts1QmDafT?=
 =?iso-8859-1?Q?xI3/9Vzotkm9kpg2x0QZSWoquOCiyGuO/3WagXgT3KsVzvTBWVcwgDKB1X?=
 =?iso-8859-1?Q?q/L4cbTHqA2mkeAnLHAIvKUe9VV/baLv1RnygTOkt3qPy8EEXY6xe67VlU?=
 =?iso-8859-1?Q?6KhVggjD2Wub1Wd6fFbLRI8ipayTJysFFCUJjsg5Zs1Ss53pJM4/c8B2eX?=
 =?iso-8859-1?Q?Z0S5jZt0gzmF86pnJhLlI/JIh9W5D3b0cW6Q/R9V1+WQwS4hibt6xySA5c?=
 =?iso-8859-1?Q?rRcJmvAKXwy+f8ZQu9bleT0MnFauviwRJyMYOKBpFvxrvSv68/Ephhbjwo?=
 =?iso-8859-1?Q?zbTGudgxnxR56NmoB7WQ7mJMmWDrqHKMTTzRYNav/qNOSDGZAisLHMIflG?=
 =?iso-8859-1?Q?cZOnLG/3WhhDi0FvrRNYn/wUZnr3MTnk1A/K5tqPt18nN5V08Moc1tpfBZ?=
 =?iso-8859-1?Q?iogKU3BzHPoCLPqw7gMC6j+nAbnEaPCkvwW26rn8ydd6ByQX5Z62VxfAkw?=
 =?iso-8859-1?Q?BkavHDCjP79E8hFdwU4WEHxxFg4boklutqACQCQwV68VWDdWj89xr12gJh?=
 =?iso-8859-1?Q?oEDqvtGMlkwqHZe2baEMPgvLrCaS2go2QT4yIR/0VO8xK1QdSh78dNENq0?=
 =?iso-8859-1?Q?P6XowavMPf8Mp47bSvT+ehrSzdZTzkHyYCsssXvbxtRgrd/uacZhhvBQRn?=
 =?iso-8859-1?Q?w46Uvt8sT7c354/1BZGNMtwPZP+6tafH+sFYTaxGwAR7QONnAwEVvf+hPH?=
 =?iso-8859-1?Q?a86Gum7gLIXnIT9FV9rV25EHKhLKVGED3vP3Vfg+r0ls8xXh0Q1DF+76LQ?=
 =?iso-8859-1?Q?o9pNVO4p3v9fOpaX9U32P1obxvtGnJ3HfZaF9dAO3XUQfyOsICglKVtcUI?=
 =?iso-8859-1?Q?p9QkhFLN+oG4h+SrT3XEb8CuAueqrnfGltagihHo5q5t9do2PmB0cDWop4?=
 =?iso-8859-1?Q?oui+VKmQJ1hgnU17+0rV54u8Zl0yZVzrROpgTF9WzMIP4LWn7uQjyFF8QW?=
 =?iso-8859-1?Q?exMkEAv5MHyRBUzRNyLAcXPvXrtRgUl3PHEeKlkI7nkPCpTTFTl0Gkch5P?=
 =?iso-8859-1?Q?neKC2CDTDkbH6N9sQpKgi7lRiyoAXmuC2ahEJGzS55QL/2dIVfbX1a8SMy?=
 =?iso-8859-1?Q?ceJt4ijI2R3ZyOE1UMWz4JjJZ+l0KlV7zPTHGe1ZCywg+vdCywnjFQ3Fj0?=
 =?iso-8859-1?Q?VZzDRtCnjlI8YdiPXb4XvF/As0wrlsd1CuWCGQ4ltGlEx6KMXCgAh3/kJn?=
 =?iso-8859-1?Q?qGTsrECkcJacsHquEMHxwiyqi6xbK1UxXld6Am5uttc/iuT9qaG8+Wrgoj?=
 =?iso-8859-1?Q?vTh40TKcoNN1zF60pNePv92jk0/oqNwI8JOEP8ls8zqwmIL9FVN945B+9P?=
 =?iso-8859-1?Q?m5QfdeSeLGflu2KjIQreNtIhVu8v1xXvNTkJ7ChVAgkYUIfJjKRsdWIkkX?=
 =?iso-8859-1?Q?pYuIEIRPJgHgwzFO6Ug+qaXQLacQHAwsUv6ttpdIBngksmXor0tA6ZErfB?=
 =?iso-8859-1?Q?B2H/qOJ/LWhko6frkKPj5HXg6k3bNqebVtNnPHECRaiG6cxtq2x3SN9xTQ?=
 =?iso-8859-1?Q?OaZ5u4XiG4gosDXD0XCPoeopgQkwrFtxjqYEDahbVPrGglqc+BvNk+LL3r?=
 =?iso-8859-1?Q?9DHUOuAuvVbx/2lc60/rmRdLEWI3837LqFThZWPl/0ucWzId/O9GdYknKw?=
 =?iso-8859-1?Q?9dh+Uc6gkQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b5a3e7-af35-4a93-b1a8-08da18767f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 09:10:44.6530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkN0bonQzqkbUTT1nGGaGfBvKO2A5m/qtVYH1342a/uoQKPyMZZXkww00bTHid2HGIqiyxJTR/oSco0F7fIIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3455
X-Proofpoint-ORIG-GUID: zd7lU0Uw82acyCuErmtKhjMASHCLj0F-
X-Proofpoint-GUID: zd7lU0Uw82acyCuErmtKhjMASHCLj0F-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_13,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=804 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070047
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: michael.hennerich@analog.com
> <michael.hennerich@analog.com>
> Sent: Wednesday, April 6, 2022 12:56 PM
> To: jic23@kernel.org; lars@metafoo.de
> Cc: linux-iio@vger.kernel.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>
> Subject: [PATCH] iio: dac: ad5446: Fix read_raw not returning set value
>=20
> [External]
>=20
> From: Michael Hennerich <michael.hennerich@analog.com>
>=20
> read_raw should return the un-scaled value.
>=20
> Fixes: 5e06bdfb46e8b ("staging:iio:dac:ad5446: Return cached value for
> 'raw' attribute")
>=20
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>
