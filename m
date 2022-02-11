Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9954B229D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Feb 2022 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241825AbiBKJ7D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Feb 2022 04:59:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiBKJ7D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Feb 2022 04:59:03 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD37133
        for <linux-iio@vger.kernel.org>; Fri, 11 Feb 2022 01:59:01 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANqrRe027379;
        Fri, 11 Feb 2022 04:58:53 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3e4gc3fpkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 04:58:52 -0500
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 21B9uH5k016814;
        Fri, 11 Feb 2022 04:58:52 -0500
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3e4gc3fpkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 04:58:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOZGrX+G2wXyQB4YJjdgYINuD9vrDo7gInCMT1/4MvImTHsFs2vE9yQZyGGxUNknZUBlBaMiy03zzZYnLRaoAhrBarSoAq+acdsBo07CtzmhpA9wHKFI8/rrjmr7KTk/O0sAY+3Eyx1pzbq4w7E6eckBnFQP6ZdOKxobKlerj8UlryYbwY1CkW1TdNNiCpQVi4SQVJObeTfJPVEkdDkivMpOrAD5dfwMonejteojZnglkhGF/xeBjvzDZxS6Z6aSuI3xkIxPCYir00Z7SKBQnVSK6kPGDwjncKKVFxHIGHOt/wf7hPVNhKo3PyEAbqaglDcC5w6GhGUayqysq1tMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wipOTL2LkaeF1xnk4RB/XSjnl+iuymAR53K1iNY3Oi8=;
 b=FO3nKnQpD13KXnrwZNzpocBlTk2rCsIAv+RqdeYZ9sLRzPSWyH4ggmY1Kpr0qI/yjbtoXR8J8qOIBDwP87iy02wjW/RAjD7C5cqZi+mwN8DEQ4t2orTAlUecCkIBZG+M9mH2cdEnXpGFlJPx0wNp5NruR7kLq0BsymwDLrm2zGIlQHlVJrOVa5reiFJ+5EdbsqWtYDRRUBhSnJ96iIk0p2ikvIAcDqzG89sQy+B7218kjxoxYXfqMrJ390/rzTaReBL8LjB4oLvScTpWCCvHW7SldSacc197e7BzytPPUF+aWp1ew7T5inkz2ZQxJ1CT7o6j/13TLmnRULaZArjxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wipOTL2LkaeF1xnk4RB/XSjnl+iuymAR53K1iNY3Oi8=;
 b=gi5KqtJhEV1wrBSnlQyOc+7pw442/Jfw6thyxr36ilC7n+JT0ommSc1Js5/zWyjhHZgYmy04ndtAMpP80NAHIDEwgVAh/dAu2upF5D5Yga6rIbfWwnQMZAtIYIKhJlSPCLvGB1XlOCJ4XEx79AvevalFiMxY4lSatVLDpLVfN2g=
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by BN6PR03MB3393.namprd03.prod.outlook.com (2603:10b6:405:46::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 09:58:50 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::1964:eb68:12be:426c%6]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:58:50 +0000
From:   "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: RE: IIO driver/datasheet question
Thread-Topic: IIO driver/datasheet question
Thread-Index: AdgduFjWn19PlfAMTkepfo/fpjw6KgABgc4AAFvehFA=
Date:   Fri, 11 Feb 2022 09:58:50 +0000
Message-ID: <CY4PR03MB339905DE65243324B209DB959B309@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <CY4PR03MB33991EB004B66FE32A39F2F19B2E9@CY4PR03MB3399.namprd03.prod.outlook.com>
 <20220209140730.00007842@Huawei.com>
In-Reply-To: <20220209140730.00007842@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0zM2RiMDE0MS04YjIxLTExZWMtYWMzNy?=
 =?iso-8859-2?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcMzNkYjAxNDMtOGIyMS0xMWVjLWFj?=
 =?iso-8859-2?Q?MzctZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSIxMzY3IiB0PSIxMzI4OT?=
 =?iso-8859-2?Q?A0NzEyNzIxMzU3NzUiIGg9IjFkMUJva0dUTnEwMmhhSUp2dXQ3VU5YV2Jz?=
 =?iso-8859-2?Q?WT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQmZ2RFgyTFIvWUFmbnZtclpJNDVZRytlK2F0a2pqbGdZ?=
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
x-ms-office365-filtering-correlation-id: 80a423c5-7b6a-496e-5247-08d9ed451a83
x-ms-traffictypediagnostic: BN6PR03MB3393:EE_
x-microsoft-antispam-prvs: <BN6PR03MB3393947FFB259411BB6191BE9B309@BN6PR03MB3393.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSFkucW/AJOQbLtUKnIF9JG3ZSMeJhc6821NxhUIR7xhbTffXAkk8qpk4LNAUctzT0uMq7Bn+8JQHXr5GbPfxuGDQPBFlVFfNSAFkMTlSb6uLDx2YZfD+VR5bkp1UvHeQpVzHkjvpFaHC5XcBKVJWDiqQDOaH150UJaNlWAkSRfRrsHZQlFEJoEk8p45uF4XQ7ogypKO/SnS8SsP5SGnwjtrAiEMHDcigKzAJFx+g/lYyf7N0KNvjHqsDHhbRufz5aHAJ62KxsxjYd2JY5osGxgPSNeUjpwc5XduhDcJfYnfHFryCuSOwnBeOilYi4xY+k5d9JB1lDDQEAlF6Lyoiv7g+KWVzsbPspZQIxYcSE3eRLpD3E5CaSHn9jDCyrZe+Hzd0YpjwaktQkYhxrUVF2iix1lWxG8wf9TXTLSo8AQ7tOlQUMX9sUem67a4fDgNOiJWd13gP2l++W9RwaPa2DWjuBxZhdTUQqaOozdGVxa0Nscse7HQuWILE6O0QAOWZFAmdg5qDbr7IhCmkJD/IDw2L+8PygvU+5/q04WHiQj0nmYOaj2di8uptYQ1ufH8gxf8WEW0uEA6i+A9tm3oXJE84WPLYquAnS6r5tp6VoFcwdjQ/nplB7wgELDLpNy0JcVtzSbk0CrvMRPvkr591f5GApIhJzBFDz1v5x5wXIdRkhIu2OwhEAhRvgVG/QTsHnbbWQnURw4X2f1CS1G2jA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(52536014)(54906003)(64756008)(26005)(66556008)(316002)(8936002)(66946007)(66476007)(66446008)(76116006)(86362001)(4326008)(8676002)(6916009)(186003)(6506007)(7696005)(53546011)(9686003)(122000001)(38070700005)(71200400001)(508600001)(83380400001)(3480700007)(33656002)(2906002)(55016003)(66574015)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?6U5eCoRXlfV4fOi3MOuOQRpxcxATVILkpXaCRZeBv+H5BIGpFjwu1qkYEz?=
 =?iso-8859-2?Q?OwtVqOZLYR2k+JWMW5det+//Kfsg2iWZzOSsdArfKg4Z0MBNxpSIlkSREw?=
 =?iso-8859-2?Q?IFdAM3HsO9Hx3u4J9nIOpu5warcIJDEpEDIftrxLxlzT+Kmgd15LhiR4hY?=
 =?iso-8859-2?Q?L/bQiWyxGmi2+b8ID3fHjHa1zy2UF4O3hjcdBDjPBd6t2PA/vvxM1IMUNd?=
 =?iso-8859-2?Q?2PTOinD3eS/fqRpEJj1FBTsK3wun7sKwwYue/D1B1TtvGcixSA27jTL9lC?=
 =?iso-8859-2?Q?uJbVuJ0ICWi/RGyNw7j6N5aRTCPhQsiob73/CvBkfHK7ri+x06DWqSIm0i?=
 =?iso-8859-2?Q?YqHh197E3R0AiZnJrbJ+Q6ufYZdcLCB6SMAez0P8OZa/GAZZ+n6N5GQaf0?=
 =?iso-8859-2?Q?Uo6FLU7PwA+miL6/E82yh1ADptn5SH2qEkPXy+fLm7iPdSEzqvOzUpoK+3?=
 =?iso-8859-2?Q?shqF99St0Q1Cr5RLdM272NsRAsWzEr+TPPjfUcVl1ikbHg8/Hrzl8ZXVXd?=
 =?iso-8859-2?Q?r5MJ1zxtAvoSG9RrguwmKw0Va2BHchE59lqSClg/FMULMwB5cKSSgsCHmy?=
 =?iso-8859-2?Q?I/gpOQOqNRAVYsSp5Xwy/NIIuPV1hjpgBj6Z78+E/ekau9eBNvLnZ0nGki?=
 =?iso-8859-2?Q?af1nLboO6hcAQ65Bbz1OtKLJN9s3BYhuCmVGwAi7bPaYN/p0PzgJO+ej1g?=
 =?iso-8859-2?Q?TqtILUrO3uQfRLSX6fIoDj5aMGP31iClR/SdYHOd8bFYPFhjcMqLl/9Erf?=
 =?iso-8859-2?Q?D8jK10mc2ygc4ryJ8/Fvw7ghZf5BDZAtF0lioj4Ks4wkxvYtloGcRdI0JK?=
 =?iso-8859-2?Q?Xv8JtDwgW06mPKZIarMzP/C2ZG3/5MdH1MFgOjUR2Wb4mEmq7+7wrxFTvB?=
 =?iso-8859-2?Q?dCK33VHjr3VGB68nolfVIUnOUf72/5bGJHDJDWPIUkmJzzHxCqXVg1u2xe?=
 =?iso-8859-2?Q?LFhkHyF+z9XwWU12/0++AR0gyAEOOzDeub543iAlElM3xPD/iyUaKj+e/b?=
 =?iso-8859-2?Q?uMT3XbWGduVpRzlW49B4RGdOlBRHpJxtOpWAlSn1nhBVzxSJ7bJ9UEGIou?=
 =?iso-8859-2?Q?MvpCDg6W87r9J8d+AkRfTOWiWoQEcSx+lBOdGiRCP7GP1z63oX33IqBUJc?=
 =?iso-8859-2?Q?LvSWHMZnU49gnMQ2/4SOaDj7J0LikenMT20GHvR9A10R3JRxx9G9apWOfZ?=
 =?iso-8859-2?Q?VNqqx6bcxuXe7F5lP9i2d6Pn/senQXk1QgN2dzOvgb3ZlnIzhBfIaZnngG?=
 =?iso-8859-2?Q?osjbtWyqewc+NnewGrn12HwLf6HAJ3F3MRVFB2XdiY2qRu5hPnc9iWASko?=
 =?iso-8859-2?Q?NyZURiX2AMworsmTR35mmLL56twQhAmN7C5V5gyOm5d3khcXv6mhBI/Djt?=
 =?iso-8859-2?Q?TR9oHLD/XdJS/2ZexduHr7kVs/81haYvS6HUF+SJLIVzqnq1Dkkg56C1bl?=
 =?iso-8859-2?Q?o3mFfeS8USonJZNvAsO869DvigIXweOMun0hnkZghl9UlhoT22hM5OwVk9?=
 =?iso-8859-2?Q?IpTnpQAA5dPJiXBClgI96OfaEcwHBa78J1B2eseparD+l5sUdhJ8M4DDZ8?=
 =?iso-8859-2?Q?2tUXzWX5XINM7/wC1zCa4x4XjojEg5jRqc8DPdkI8oLeFQ/yMa2RQsnBwU?=
 =?iso-8859-2?Q?V+MC28zyH2lU60tSAXzp/R29GUX7NWeJfYJwXWHfSjlfyTolUw4HgBDWWd?=
 =?iso-8859-2?Q?rVW9KRaaPI2A8nt3t1Wv+J5RJVp6muWEFZiQVeDSLTkgJDuwQHvHwx6NgP?=
 =?iso-8859-2?Q?4Dwg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a423c5-7b6a-496e-5247-08d9ed451a83
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 09:58:50.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+QCFJF/3y3+tmLgXpAw7bFJKASfGyDLneM0VdxaOxAZOpkaLjDugBdKLVH256pjO3iUjDup0b8pJPVYv5ag04gs7Kjjq/6wJyynR/osxDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3393
X-Proofpoint-ORIG-GUID: p9fKs8dKOsviOazSK7BEpk3KZWC6XtBD
X-Proofpoint-GUID: ltWfv7cgn40fBaKcU7oKLKnmJYaq_EOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_03,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110056
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan,

Thanks for the prompt response. I added a patch series for ADA4250.

Regards,
--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Wednesday, February 9, 2022 4:08 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: linux-iio@vger.kernel.org; jic23@kernel.org
> Subject: Re: IIO driver/datasheet question
>=20
> [External]
>=20
> On Wed, 9 Feb 2022 13:24:25 +0000
> "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:
>=20
> > Hello,
> >
> > Is it acceptable to send an IIO driver (ADA4250 Programmable
> Instrumentation Amplifier) upstream without having the datasheet link
> available?
> >
>=20
> yes.
>=20
> Though the disadvantage is you may well get a lot more questions
> as reviewers won't be able to check things for themselves. Also
> might get asked to add more documentation for places we guess there
> might be questions in future.  So review tends to go a bit slower
> when datasheets aren't available - hence it's great when the are.
>=20
> Jonathan
>=20
>=20
>=20
> > Regards,
> > --
> > Antoniu Micl=E3u=BA
> > System Applications Engineer
> > Customer Solution Enablement
> >
> > E-mail: antoniu.miclaus@analog.com
> > Mobile: +40 747 036533
> >
> >
> >
> >
> >
> >

