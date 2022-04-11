Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C873B4FB476
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 09:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiDKHUj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Apr 2022 03:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245252AbiDKHUh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 03:20:37 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0417C24BE6
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 00:18:24 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23B5NraD014161;
        Mon, 11 Apr 2022 03:18:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fb7w7t4vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 03:18:13 -0400
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23B7DM5c022735;
        Mon, 11 Apr 2022 03:18:13 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fb7w7t4vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 03:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZsh6/kvxuhi0Ig2ZsXaMxOiVsLJiXEZdE7wQMK0Yt3mLxV0AQI94my4g2hkOqc3cOanoi4pON5YClkPLugHxJw6xl8O9WFV89iHKZJsfjNnTBiFvZSDTnoQkRHwWU7o8qoIiejI31r7VGIGL6286H6A6i55Qp16twSGDWxNv4E84ztL1R4vDr1nkTH+sY6Ju3CQdGzVbRfdyJZdh5mMn3zWR0yFrb/LfK+kUtzVJG54PZDEQOWC0RrC7ie9rpHbk35MORda0AMzQv0IOd1OBSSF5hyXZ0juHnyuhyRh44CKocuZ3JP3kSuag4yYMd+jOGOmi3O1IH4MPNvAro0ffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbdu36p9BmRHFZl0qh3nVY8Oikdiq5JxfTAzmIHieTY=;
 b=JmHsJoMP8sL+E9rtATf8io0+EktQ6lxipToeYPJoWcZd7NHZX7PppztV8tgo0sApcQjM+01bHHifepB3xsvvGmt/7VwVb1J3O6XdOf7gzLjl2SlU+tFQhJeIp8/nkB39igCc7zne+eSwe7wYgdTDnvYgR1i1jaQEqUmwnutDAh0nYKPJnFHP+BR68WTgaBkzQD8ge4gP4yaWLrPt6ajJ2bmj99FzGeCZeNdYDTla8VYmjp4b/3UbtCFhQTMQ2AD7xsfCPSsbeuoH24AwAS8RF4hpTkW2sxoneZJEnzNHmw5tyP6c0vYRpwQQ3nPGSLq50/y2KvuYPPlgMHXUY6SLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbdu36p9BmRHFZl0qh3nVY8Oikdiq5JxfTAzmIHieTY=;
 b=lBIilL491FNBtYY436pSKsaH9f/ct6VvwlFWbWj7pkHB28HsDmjJtG5H4Q+u71UNfnkXjy2MgWHc1U5SHHBZwphOL8lY7amAs4LEF0psyS2ou0HWA4nzp2kSMIx8T+vEukLn6jcUcm0aKGiV4jJkXy27Mn7y8DmvOB+DDgsBH5Y=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by MWHPR03MB3357.namprd03.prod.outlook.com (2603:10b6:301:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:18:10 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::5157:6b0a:3e7d:e9ed]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::5157:6b0a:3e7d:e9ed%2]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 07:18:10 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH] iio: freq: admv1014: Fix warning about dubious x & !y and
 improve readability
Thread-Topic: [PATCH] iio: freq: admv1014: Fix warning about dubious x & !y
 and improve readability
Thread-Index: AQHYO7wYoCmgEBLZmUORBV3ZRFz1OqzphfUAgADkJsA=
Date:   Mon, 11 Apr 2022 07:18:10 +0000
Message-ID: <CY4PR03MB339994ADA257E9EA436FD8129BEA9@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20220319181401.136810-1-jic23@kernel.org>
 <20220410181628.084fcf3b@jic23-huawei>
In-Reply-To: <20220410181628.084fcf3b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04NzhiMzY1OS1iOTY3LTExZWMtYWM2Yy1kNDgx?=
 =?us-ascii?Q?ZDc1MDZkZGVcYW1lLXRlc3RcODc4YjM2NWEtYjk2Ny0xMWVjLWFjNmMtZDQ4?=
 =?us-ascii?Q?MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIyOTk4IiB0PSIxMzI5NDEzNTA4NjE0?=
 =?us-ascii?Q?NjcwMDgiIGg9IllEcFNPTTk1bFpWOFc2WC85Z2dVeGh6RURjST0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q0E3UTVLZEUzWUFYdWh0bmR5dHNKZ2U2RzJkM0syd21BREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBWFEvampRQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-dg-rorf: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fcb6532-184e-4a9f-04c3-08da1b8b6f11
x-ms-traffictypediagnostic: MWHPR03MB3357:EE_
x-microsoft-antispam-prvs: <MWHPR03MB3357686D77398CA31D0D12BA9BEA9@MWHPR03MB3357.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pBhAw7ayNHS/8pbAMERI1mLnYVSCdCqj8GlV36vxUc1gZ/w0u1BUBzXk5zpfacl1u8XenFPKGeYlKcczX5RZpuD86hzynipsrToG+gWgJ5+CweLZmzS5Qy8PKc1SiK8XBnGiwiwd3f4vWiq9qwMBxJLKwJNSJqSR5+aXcuAq0BdunQ/+rpqqbCxzemj6ly6XKpLhTrPv69cHt7b4Ujs5nBe71cbfaAO6JMqSyJKRtiRNc/d7VIhFp4eNmACDtfeTpEol6goMjkf1oWbgwWI9iaQZJHS/mW9/DU0xe28LoMUMnCLW1gYgyaOotdj8Z3amqOwUg6g6f8+Uxc9GtyNW4euYzaYXOM6RhGkFY05YHw5LUWDUFPbpr3bnLWwMB4t2u6JrsseH70vxrNfTrY2eTgk4LstiaW4s4Qw73TRY+OO1PC+h2gq5N75923xTUXzzgfLHmpTlHGYmDnKLeTnNTyVNyjmqwsY+4ro7jJ01WqEd+C8g5XVVXyX8ssV6zmxiSoaS1eCgEmiDAYzF52LTyIn0u7JoZ0NGSWjrtONLuu8goItiT6Y+cLOw8Je63NEVcnXBZm9Ls9XAxA2Ymz8kbzAxtYJZg/byBH5PP4w3iq6T+PIkfRWzBUTAvL8yx4v4BWqKWi6LSLmC82TOn9Fem6nPN0kzdL7U71CVfOOuS9PUoZGqAdLAyjweumWyf8Rg2ZuJogVWiEtpVE/h+C+oJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(2906002)(86362001)(33656002)(186003)(71200400001)(26005)(55016003)(53546011)(6506007)(7696005)(9686003)(508600001)(76116006)(66946007)(83380400001)(64756008)(66446008)(66476007)(66556008)(8676002)(52536014)(5660300002)(4326008)(122000001)(8936002)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/HPpXjxmDkE6/Fqoc/8rPU8pfm+xujyvn3Lj708i0iSZ7oBpN2Z8yjp//Pgh?=
 =?us-ascii?Q?fKkLwpZ2Nq+iZq43IdYS5ra3BmxINGsjda0N3rQRD3tJdvgCkDnzWo5PVq3t?=
 =?us-ascii?Q?MN1zj0aqO0faBoGeJRHc5Ju/6d3HNWVsYaK6gKJhQowVkLQsghgQ9E4HPtZE?=
 =?us-ascii?Q?frlB4CWkDX9m6oypT/VEH2hiEtyTS1U1nN/YwKnLG4cU0M/pRSPm5U/XvX4H?=
 =?us-ascii?Q?JvEO8FvWG7B10S9H8TrZVrwXH90CBu+G78MJwyXRa6FgzbdLpopjk4comI6V?=
 =?us-ascii?Q?Iy4j4ZPlpGVCJRS7KT1NpG1YDbB2jK2rmMImmFSYBIGGTTVWnQPXCmwAiJlO?=
 =?us-ascii?Q?h1LqdjCbypEcThIuUoeQTU44iU7YBq/E5jP1ZySqmO8mFn9/nyO96EVJk63O?=
 =?us-ascii?Q?8ftVxFGr86E9KmT3FI5+yN4u5xb751Z/5VuLCz54z+ZmojFYvhpFWsV7ssId?=
 =?us-ascii?Q?Zk363Q3OEaIY7o/paDHvP+Bv+6ysRZLIDqmTSpSezHrGayId0E3PUgHAK4HK?=
 =?us-ascii?Q?PSEX3u0+L1aJhvwN+fHMyXjH8CfBqcYmjM5ZtAOFt0SWHaSZ1T063j/M88lQ?=
 =?us-ascii?Q?bEfViZIiks+s62E50OLxy23FpQjD1X23MmK/uHopNPF7Mkcfp+Kt03oVIoEa?=
 =?us-ascii?Q?4FIT02ASGzmWmhl632UukOSXwFkJKtwKjYrNkAH4VwB3iu1ERXYDX8a3qQZW?=
 =?us-ascii?Q?USWxoT1le7IG2E/ixyjCE92o+KUwFQxBtNh8M0PR5yJkayijsL3VvdFkV37X?=
 =?us-ascii?Q?s4us3qJfZKihCP0BF8uCol8JufmDx8uxN6lPQBKoZ3/8Qcr5ketCxhrrUKiJ?=
 =?us-ascii?Q?T6mfsVsodj3a5/p+L8VaCTU4SolIhOOub64K5muwtVw/COL9YeAlmL0slKs9?=
 =?us-ascii?Q?kcISUR02Z9Nx1GXx0AOLZ3+I8b9idcLNtJgBHjPAT1Q+GGPbuWW5hqk+xqQI?=
 =?us-ascii?Q?6crFM89AxAZ05XCidcoTJ1+ES6E+jdrKtSRF/nFUftZPTesNtiFyfYo1sumM?=
 =?us-ascii?Q?edg4d5ee8jieqzVen5CjTptT+HXi1gH+RSBAt6GipYdxdJnO35ZJxYDquB86?=
 =?us-ascii?Q?fgp9rZlY8Rwoe1Kx04JaoMn/u1jM82P1pKmUtylA3wWeJXe6hzNTw9dw/SSm?=
 =?us-ascii?Q?sSGL3UDe3xfvVIcOfMUo7Wu0xexZAWVb+h2TET+ULyUOs9HFeWNHl9tlrz6Q?=
 =?us-ascii?Q?xG83wS5KVhLRVM/7Bu+J70BzML1BoRqAIhx4dK9ao+aexPyHEiJd85RuMj45?=
 =?us-ascii?Q?Cb3PMonNmJ1fucTBm6OUXEu5OJ36g12dlH5wmgbas+VOnC/zIatmQEfQAYMY?=
 =?us-ascii?Q?kypfz1WlZms33dW2TGKnaPLXLqD8mZQ0+lBdXt0v82ZBQOk1iRM6nG+yIk2A?=
 =?us-ascii?Q?MiYuMeKtaHh3BVL4JJR3g82l15O4dWpTp5MUImAagfU0ReiV8MY044sZOiSp?=
 =?us-ascii?Q?iU4Rfmw7ApvkeLtRKkBidUgbyVJbL9CZ+EJBKk0o2DAvStrhZrgBHkGYiiix?=
 =?us-ascii?Q?J8KQovkiZ0omB+RzGJ1fODupTwBS48veF3Gl+OaEt5a4SwdvB6/P+y+V3Bn3?=
 =?us-ascii?Q?RTMpox79qcKEYinq41zpv77UtpY7c0kKxFO4UKBnT89Es1RqnQ0R4PzAuTYd?=
 =?us-ascii?Q?qUIBRCR8SNq6X8Z4GAshrl9Hnk17zOPIUsnGpRltIa3fm0YXIj66A0HyjY6Y?=
 =?us-ascii?Q?HoadYb4MBlpGYEY92BRRrPFSyoz4uO2brxWsziDR5S25KkocjKplnqBIjaGI?=
 =?us-ascii?Q?DZL/YEAQRwgytMLcOcx1HM4vZtU1eKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcb6532-184e-4a9f-04c3-08da1b8b6f11
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 07:18:10.3511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSY43sVNbJGWkMn0cyKuYOJw4C7KPCzz6dJBvK8Ape/NuYOt/+S0nLKWAkHsPpt/veooXsA0eBD5HTBmAAJR0Xq9j9xLK6nl40f1Xrimw/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3357
X-Proofpoint-GUID: j_IY6zVETQxBzszmZ48KvGNAVnEd-UBf
X-Proofpoint-ORIG-GUID: lqvp00erdXTUoIrStAlM-8iSKoO_-meZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_02,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110040
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 10, 2022 8:16 PM
> To: linux-iio@vger.kernel.org
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>
> Subject: Re: [PATCH] iio: freq: admv1014: Fix warning about dubious x & !=
y
> and improve readability
>=20
> [External]
>=20
> On Sat, 19 Mar 2022 18:14:01 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > The warning comes from __BF_FIELD_CHECK()
> > specifically
> >
> > BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
> > 		 ~((_mask) >> __bf_shf(_mask)) & (_val) : 0, \
> > 		 _pfx "value too large for the field"); \
> >
> > The code was using !(enum value) which is not particularly easy to foll=
ow
> > so replace that with explicit matching and use of ? 0 : 1; or ? 1 : 0;
> > to improve readability.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Antoniu, or anyone else who has time, can you sanity check this one?
> I'd like to clean up the warning asap but don't really trust myself
> enough to not have done something stupid ;)
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/frequency/admv1014.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/frequency/admv1014.c
> b/drivers/iio/frequency/admv1014.c
> > index a7994f8e6b9b..802835efbec7 100644
> > --- a/drivers/iio/frequency/admv1014.c
> > +++ b/drivers/iio/frequency/admv1014.c
> > @@ -700,8 +700,10 @@ static int admv1014_init(struct admv1014_state
> *st)
> >  			 ADMV1014_DET_EN_MSK;
> >
> >  	enable_reg =3D FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK,
> st->p1db_comp ? 3 : 0) |
> > -		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st-
> >input_mode)) |
> > -		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st-
> >input_mode) |
> > +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
> > +				(st->input_mode =3D=3D ADMV1014_IQ_MODE)
> ? 0 : 1) |
> > +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
> > +				(st->input_mode =3D=3D ADMV1014_IQ_MODE)
> ? 1 : 0) |
Hello Jonathan,

I think it should be vice-versa:
		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK,
				(st->input_mode =3D=3D ADMV1014_IQ_MODE) ? 1 : 0) |
		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK,
				(st->input_mode =3D=3D ADMV1014_IQ_MODE) ? 0 : 1) |

"To set the ADMV1014 in I/Q mode, set BB_AMP_PD
(Register 0x03, Bit 8) to 0 and set IF_AMP_PD (Register 0x03,
Bit 11) to 1."

"To configure the ADMV1014 in IF mode, set BB_AMP_PD
(Register 0x03, Bit 8) to 1 and set IF_AMP_PD (Register 0x03,
Bit 11) to 0"

Regards,
> >  		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
> >
> >  	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE,
> enable_reg_msk, enable_reg);

