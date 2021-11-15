Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83AB450381
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 12:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhKOLfG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 15 Nov 2021 06:35:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:40070 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230288AbhKOLfD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Nov 2021 06:35:03 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AFBJWOc026296;
        Mon, 15 Nov 2021 06:31:54 -0500
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cbpjv81k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 06:31:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bt3khvSTuoJd3PTD5Gcev9Y7z3vUd0QVvX0fFyYFv/bhA25TzDwLDDPFwDwraXgpUt5iQfyRYvtSZNxXxm868hnpUEsjj4CUE+5PD+F7QO8elz384hgSJNNV05zPcAl22KPAdn0mD9SE3p51BZN9l+DgRWmEsGjzooMIlWReXVK6ct7CRrjxdwM2+hXkQTFfSW46jVe4q4z05Ie2pVVkfOVpUGGSlMrSAOBjnGEp6ooY/906GMYE8ReACwlVisXD5QUtGA/w2C1EZglnLr74kgPO9qRXiPRGI+0srl1yEg2q7iNqzYzlYCSi98YW3wGEFvz281wwsFwU/hoi0Pmx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGgVEYdvUYzy0Tcyi3hUWWv8WVMWFNBoOovGbXxS6BQ=;
 b=LTYnR5HlV8VBR/6FUA9FgkFpiGzihnw+erNetfhi0R+70r2aarz5E3updjoQs9aklq0jxUm0sHZB8xaZ8ia0up6BzcnS5hpwCyUHmsX43KPtMTg0hAptE93mbeKDemdV//0XyIvzH1iPcto0Vjszv6mxXM7WSbqZy+3FHLWVBRV1HbhsTmbixmHWVQqfOXJHSwQGHraiiYh9ck22aRnXIncKGa2xBtWSQoNHvR0KnI4L95M2KPCh2AJmBqdnFPru3oSUo59xkkyxv05cU9oPxNPWaAML/O/HW4l6eP0qKCYFANN5uz+d9avJ4j4ayeP4EJi4BHDqiiyo2TXllpNd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGgVEYdvUYzy0Tcyi3hUWWv8WVMWFNBoOovGbXxS6BQ=;
 b=5UF9A0ByoIKN9Ss/WEJ/Ti4G4yGtmBCWQW9jlbavhdNhofas94C4tutuCLb0cr6uaDlwcEP39KaCZOzN22vyKqMdVBfwuFi3M1o/lKEirIZ5vlKROfewdDjvZodIu54PN+aHdc7A6FZUmuF+Ifbvx8vjyadW7wUL02VoT2sIcIQ=
Received: from SN4PR03MB6799.namprd03.prod.outlook.com (2603:10b6:806:217::7)
 by SA1PR03MB6595.namprd03.prod.outlook.com (2603:10b6:806:1ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 15 Nov
 2021 11:31:52 +0000
Received: from SN4PR03MB6799.namprd03.prod.outlook.com
 ([fe80::cc8f:54b9:681a:ad06]) by SN4PR03MB6799.namprd03.prod.outlook.com
 ([fe80::cc8f:54b9:681a:ad06%4]) with mapi id 15.20.4690.026; Mon, 15 Nov 2021
 11:31:52 +0000
From:   "Chindris, Mihail" <Mihail.Chindris@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "alexandru.ardelean@analog.com" <alexandru.ardelean@analog.com>
Subject: RE: [PATCH v5 2/2] drivers:iio:dac: Add AD3552R driver support
Thread-Topic: [PATCH v5 2/2] drivers:iio:dac: Add AD3552R driver support
Thread-Index: AQHX1Ho57nuMSHzMWEG/6CFZIEaVkqwDCEaAgAF2WDA=
Date:   Mon, 15 Nov 2021 11:31:52 +0000
Message-ID: <SN4PR03MB6799D1FA928E3F712E3799A599989@SN4PR03MB6799.namprd03.prod.outlook.com>
References: <20211108082447.116663-1-mihail.chindris@analog.com>
        <20211108082447.116663-3-mihail.chindris@analog.com>
 <20211114130745.6ba386a1@jic23-huawei>
In-Reply-To: <20211114130745.6ba386a1@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWNoaW5kcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy05ZTlmNjFjOC00NjA3LTExZWMtODQwNC05OGU3?=
 =?us-ascii?Q?NDNlYTZmNDhcYW1lLXRlc3RcOWU5ZjYxY2EtNDYwNy0xMWVjLTg0MDQtOThl?=
 =?us-ascii?Q?NzQzZWE2ZjQ4Ym9keS50eHQiIHN6PSIxMDM5IiB0PSIxMzI4MTQ0OTUwOTI0?=
 =?us-ascii?Q?MjM0OTQiIGg9ImgyK1VvamZ1YlJiTlYrc09jV2w4MG0xMXc2Yz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Qkd1d0ZoRk5yWEFkK2tHWG1uK0t5eTM2UVplYWY0ckxJREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVklFdm9RQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
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
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 048992ec-e71d-4e7b-ca95-08d9a82b8549
x-ms-traffictypediagnostic: SA1PR03MB6595:
x-microsoft-antispam-prvs: <SA1PR03MB659577226504BDA2393AFF1D99989@SA1PR03MB6595.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vViTD4yaPb8qvMX2zIiDbQRVc5PfsKc0DjShzVFKbkYhkotSdbheztiHVBGR60BsoArzfsRpAGeqvGLcVQzWyA0ipElf2e/exJxcA7hMry/I8h9fPrnp/WqbxiswXcelxgkT/S8ztv/Tmf9UFnkddRUOE9poIYOM0VfnX+f0NbCRov5lqniIltV4YdT2OWbZPxr9E2EoRYJWvesULr4Ahe8ROOGUNRqDBV8i167oB0aUlfZTGUjBnO4cI5YCe1LOu/U1TF9eJQgiBqGctZYsrUmDc30T8uIN0xF3lb+G9TQ3ZIMYBDLr5gSr1NfJT9leDiaM2egS2aXi1LTvnHckgIDSyTinQ8CEtZ3vLvvEMbHs1zN4SNIdAXjtIs+L50y3HBpjI1GUtgaM/22/lKnIPGFLbd7JgfjBjp88J7Wndb7nxwlM2XIXFkDxeY0XlBw2sbghWthj/e+ffPRrebgnMyG/z7h5nXsp3qktcdywqDTynfjE5NxjpikeUcL2skijf44qXeMl943+jzr9XW5X/SSZV81OD7XVZ1GlNKTh6tN2xjL3mJpByAWiXdKXup/sQMWKjvSQnoifwzmO43gLqIDS65ITaOru+GJ23DmObxWDQy0KQTUNznFU5oJO2nRudEvJHHcBflbqgWCMvdF42JZ5kBQYBDzJPQrScfYWdbtvEi3U9f0pKhQn/vyJyth3/K3hZWn2850RLY8tPdfpKZiUGqDSrJgO8DF6kQXTNwAgenJS/c8zYcAWK8F+Zrqa29dzs1fBtptLqJF6FKNABlhaUt/KGmWsjzCfR10+Z7w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6799.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66946007)(55016002)(33656002)(86362001)(9686003)(52536014)(64756008)(966005)(38070700005)(6506007)(66556008)(4744005)(2906002)(186003)(66446008)(76116006)(71200400001)(107886003)(4326008)(54906003)(316002)(5660300002)(38100700002)(508600001)(8676002)(7696005)(122000001)(8936002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lM4yPo2mMeCaFpdugNd7JxEeg0Hc9nLoAZBjJbtyxxjKeYhluOxzp8jqt7xY?=
 =?us-ascii?Q?5qTNjsglD5Bc+QD9zsX7s/4n7OGEW/NF4REBB/7NzFx34Nn489n8+mAyl1z1?=
 =?us-ascii?Q?EnEefUVQEIqe3nuCOhYBocw/UiSKBM64Urywan/sFkAPFUC/w1w0c2IFtQoa?=
 =?us-ascii?Q?iWj9Yl/HkjCaa4fl3bH1/YXVM3K1I2rHbvu3FhQNyCyUK1VKz6mRNGTHnsI/?=
 =?us-ascii?Q?2xZpTS9vaHtSxMi03mVzkLMw+zT/sNcmmRsiTiSS+x0gDarDgKzvPHGcDrtX?=
 =?us-ascii?Q?Xm1OmL/JJkCtiqnXQ+OH/ro1EF6uXh3rkBEBAPEvHm8qpJu/sIqctl9GCyfx?=
 =?us-ascii?Q?c/3Q7Pb6+q4xRE5VBUet1AezDQRFln5dejYxTKRiy70FeJax8h0MruBtTIwB?=
 =?us-ascii?Q?nZ5lZ22h9wUPHjTWRJsFo4iZH1D7ZXchKV1+N/zCwCWfDt3TNuxgtqjVgTYJ?=
 =?us-ascii?Q?X39qI0I0njD3cbv/H5+EyfmX4HAsp3N3tAw1yhG+6/jgwLJVbjoNNp+prmz1?=
 =?us-ascii?Q?G8uH4LApd9bJoqcQiqFVm73fRLCF+JG2GA3RGRunuFxDr51SGCaRH55cYi/Y?=
 =?us-ascii?Q?m3XHEwfO8zDtrpbOXgd/jHrRC/qsQ+SwsfAdAMY/e/Mg4sbBRGp6Fh0mY/+0?=
 =?us-ascii?Q?ufbg2gWT+mHr2qrdIoxfPKjxGlCOdqK0gjW7UGC859fS0XJDeIP/XpZUFipo?=
 =?us-ascii?Q?rTd0YQfavCyKlCWp0y5ihSt/G1GshLzYk/rZ3YQQXkPkP2idqjYI33VSC7Ij?=
 =?us-ascii?Q?ssU1WvWkBbvpImxY1kaIik6XanYHlwOE1Jfq/AbuZFJSRc9BIBIdhNPmop9d?=
 =?us-ascii?Q?RaaaqBlaDohhDa/8rPXoHROyOjZOUn0Yom5H+XyJh4DcTLd7Z4TdFuhVDDkq?=
 =?us-ascii?Q?L+WZqKOd/CsrKcFknhdbC9XDK5E5q0o9wElseEy7aQe69Kl0UXPUodNIgg7m?=
 =?us-ascii?Q?V3STn6+2+3MXoeNr0ts5B/rG++tdTZGRtV70iR3l9R1sSLU5rHqMpd5nO1Dz?=
 =?us-ascii?Q?KfZnl8b/afeq0HaB03bMPerGF3k4HRtePelRhreeJwaI0eBpMAwA8s7yKf4W?=
 =?us-ascii?Q?DXTUMGv4QC0nopvwJ6xfHULqozYrBQkJM+2bkpLlEVsiSRmL/ObxrOxAIRNH?=
 =?us-ascii?Q?tXZwgaEFtbzBhku0oE1ixNpwSnJC9M7OtPcNd+aa5BGfsegXrZUvw+5XorEw?=
 =?us-ascii?Q?lGjwxTYBw8M7cQ6ghY1jX5ZGP94eWf4+PGZksGQqc6zYXT0tYqZaTOx6SL4D?=
 =?us-ascii?Q?4mB7Kwz1tONrniKBRSY+/EyZeNySW4xaW+aWZlr67VU6gjSRF9pjEK0MrdoM?=
 =?us-ascii?Q?e2LPPTHX9zBZ09T6dvg+pjY42DnYEPnzF9+PviCbbsZy3mu6kousONjQv4O0?=
 =?us-ascii?Q?FSnpG/Sow5s3cjjO5W3ITHIYhWNa4b+UwwTK3hVE8lzipYBBkbRJ+ZD5s56e?=
 =?us-ascii?Q?yGA56DvTgSMlW+R4fvCNo5n+TkW55Xs62g405jPjd+Zm96AcB1UJv2lGDHh0?=
 =?us-ascii?Q?udAuGcHcHRPyblgZb2TKmsfQmcAPWip9IaJwlernmaOahrDFdr/D4tScSPEu?=
 =?us-ascii?Q?GYFZHw0jFbw6PBsq2lAogt3e26ZJQ6pVo6mP6CYiJVjOGU8qroDJyYBj1wir?=
 =?us-ascii?Q?vy2xz/GAVJwxIRs6NqC71M8Qrp2PL+jQHtZzdLmqSLKPLv8U2n38ZbII+Lku?=
 =?us-ascii?Q?WaXPZ9ll2IHouf3gx8d91ttyWyVbMTrlgXlVDAOhYNUXIF88nmxXb+AwXi8q?=
 =?us-ascii?Q?ZzVIjKXbXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6799.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048992ec-e71d-4e7b-ca95-08d9a82b8549
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 11:31:52.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIG078qz6fhgxsn5q4eq0SHBMhcnlX8I4rawjBDsVO9NJHOXFjBoshdKTU0btzvS8Ahht2YIdpSNqJfN7FBceR1VnoYFQa9D5KA5saqHYCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6595
X-Proofpoint-GUID: eJZKMISHpHOQBV2XNW6-EMySnswrOlnq
X-Proofpoint-ORIG-GUID: eJZKMISHpHOQBV2XNW6-EMySnswrOlnq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_10,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111150063
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> > The AD3552R-16 is a low drift ultrafast, 16-bit accuracy, current
> > output digital-to-analog converter (DAC) designed to generate multiple
> > output voltage span ranges.
> > The AD3552R-16 operates with a fixed 2.5V reference.
> >
> > Datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-
> sheets/ad
> > 3552r.pdf
> >
> > Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
>=20
> Hi Mihail,
>=20
> Main thing here is to give time for Rob and others to take a look at the =
dt-
> binding but in meantime I thought I'd give the driver one last look and
> spotted a few minor things.
>=20
> Jonathan
>=20
Hi Jonathan

As per Lars' comment, it seems that the issue was similar and if I understo=
od correctly the replay, it seems that the naming is ok.
Anyway, I implemented your latest suggestions locally and I will wait for a=
 feedback on the device tree to send the new version.

Mihail

...
