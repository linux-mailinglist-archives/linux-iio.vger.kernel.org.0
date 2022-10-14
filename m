Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7619B5FECA2
	for <lists+linux-iio@lfdr.de>; Fri, 14 Oct 2022 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJNKj1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Oct 2022 06:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJNKjZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2022 06:39:25 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257D1BBEFB;
        Fri, 14 Oct 2022 03:39:24 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E7Ejsf005574;
        Fri, 14 Oct 2022 06:39:00 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3k69k5jnhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 06:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U53cy/wZ3cOhh9r0cb9bwQBDbZDFHUeP/+WzAmG+E6vi640H2P0SRjNoBgjG+hWoysicWJ1nQt7h2tAEIVsmMRUN1uYta33T9yhIMJ2wd4MGPazcqIG/rqHmic+G+j2iZT0YPpjwQKJruJYSrxWbz0C5cOjxz6gsp1tkoX/6KetwdUb5G6O/BPVJJD9McNl71fNcguNrGLfdnDmtKkthzSFQmP4goS+JhUBZFrX33E3apPERUDhGtwq37PvFQeBw1x6IA6i5SoLrmUMkwk0N1E5pEzw42lrh2rCvH4ZyYEyzdDWwahZOfoKDvfVF9IvdbAhGnqo6L/pR1gObxrVEbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DheZ5t04aeX4XMfm6gWhxZxP8E2Av/5YwFPM+qVkWh8=;
 b=DjYpZ0psAsPlH8PyqUP6oZPK2xOj9/lTY1cXpFMbGqqL76hhgFzcKVEIq5NoPGiXJgXWyTtjVLxsQiqXRdF4QhPNf7m+LmJQmMCJn10nXyktqPzDav2PcmW+qLgS1Icw7SpC5f+tCeKrpWtV6uhssWAenTEULJ4qE8lasiO0LDpIlNs3vExmiJrCRzZKH8mzq/8GMtF96NXWGBGS8Dxlr22O318mDfKR1KY2/vvZGhcO0PP34tzb6oZv+5UvjUqdVGKOzKvn00w9XxX+t3YG33owLFesW1VzFEd7HvNU4AePOk3XjjVL9jcLmL4XBuOdQROVZtg+RxKMcSGc10ts/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DheZ5t04aeX4XMfm6gWhxZxP8E2Av/5YwFPM+qVkWh8=;
 b=HmRlwvtTTOnsM/ia86dOKY52erJvErtuaTkCinCrnVp+TPZVgxzM3sIQIqzX9m1lo5V6v1jLTmAlCdp0q/IXreKFLHK+UI+KZkghryMLL+NcSxGt3gZ7sh+YOmjj4CbDnTX1iyoiljzRpkbsJL28lsCN425FIRgUyJMGEHB///4=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CH2PR03MB5365.namprd03.prod.outlook.com (2603:10b6:610:a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 10:38:57 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::df11:95b:623d:6bb9%7]) with mapi id 15.20.5676.036; Fri, 14 Oct 2022
 10:38:57 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] iio: imu: bno055: uninitialized variable bug in
 bno055_trigger_handler()
Thread-Topic: [PATCH] iio: imu: bno055: uninitialized variable bug in
 bno055_trigger_handler()
Thread-Index: AQHY37ECGqFBH/T0jUyPO5FkIi52GK4Nsssw
Date:   Fri, 14 Oct 2022 10:38:57 +0000
Message-ID: <SJ0PR03MB6778B203AC1276C340A5995F99249@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <Y0kuaO9PQkSQja+A@kili>
In-Reply-To: <Y0kuaO9PQkSQja+A@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctNjY4M2M0MWItNGJhYy0xMWVkLWI2YjYtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XDY2ODNjNDFkLTRiYWMtMTFlZC1iNmI2LWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iOTk3IiB0PSIxMzMxMDIxNzUzNT?=
 =?iso-8859-1?Q?Q4Nzk5NTAiIGg9ImwvVS8vd0h5OW8yTnRDZmx1dnZPSThvKzlRYz0iIGlk?=
 =?iso-8859-1?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQU?=
 =?iso-8859-1?Q?VvQ0FBRE8vOXNvdWQvWUFZeWVNdmFUb2hXQ2pKNHk5cE9pRllJREFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFFQUFRQUJBQUFBWDVsMkt3QUFBQUFBQUFBQUFBQUFBSjRB?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CH2PR03MB5365:EE_
x-ms-office365-filtering-correlation-id: fb9c791e-0096-44dc-d1e2-08daadd04caf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AeE9qDezmnY3jOYR1r9CuoHSXXQntLes0gye8FYtOblcDJe4CB0MTtaWBP59g6RaJb/efRokCle+2AjkCkIOe66mCcIER1a7wR9UsCmLtMvripsH6msqXc7jtVAUuEVY02rH6RY6qWjoQdfItxG89O/glDT8RknUFw8GBqUC8VDPV6nr1VFQG2YlESrKQYGHHnzVDfYwTfarTv8G5a7KbuiNV7nixx8LL0/7Z/xWZl5m5ifaqV/f/Y5NLezLEb9DjbW993vdEYNqZdNXXZkojgrewtHiU+X5UCa8mXtjp7BMcA9ZUDUjFGPCW4eGkDz9D2bQtfqZP28RQkAQaBeBLfI+FElcKRwOIKku4TPMcUtIuCfPwztkn3YPHrq0qDJKBAp2dsKDWjMILcglZ5LhJa4gwTbxyhirZbinFyQfw+iZBLCZqumT92xvaBQPPtD0C6UAsacn97XtnLf48aNdQyXHobrq65Ct0rqopsgPD9mzVI8/eSQPhbGHuU3sN9sNHmpTkGvqiz6jQb8RjTc9bDVjiZBeTyG000bC4TCL4uF+7Sk0eoa4O+RCk+iNX5XPGkYe6qJz/InvNVozC/mAwfXqj1kBfeXDCTXeM6VInwqCD0QtRKAQCFi3f5JHS6blKkj5IThczzTlYUgPC5TFnl59s+QWrpni/ujbYsBZFbWpEr8hAzZiqy3xy71TEPJZlzzSn1W8mUL4I3qCtlpKFfIWXnEvbe5swQVLjStf+PuHs5KDupSYHBKjGKhMQVuV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(9686003)(4326008)(2906002)(26005)(55016003)(53546011)(122000001)(52536014)(66476007)(316002)(8936002)(54906003)(186003)(110136005)(64756008)(66446008)(86362001)(66556008)(8676002)(76116006)(66946007)(6506007)(7696005)(478600001)(5660300002)(71200400001)(38100700002)(4744005)(38070700005)(33656002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?w/FM6K2TxLocGYUph8csYIntt8eAb+z+rIqkHJBR/3rl8/3aL5wu98EIli?=
 =?iso-8859-1?Q?lZT4vv792UtBsFx6zu2Jqr9ULhQWQoY+uy0zQmGMpT6lq//ZDwKocpwonM?=
 =?iso-8859-1?Q?nSuaUKd4UBVXpSCO7b12P2XgfHj3IC8KKRylfq4owvm0S1TmQZYOPtJHRB?=
 =?iso-8859-1?Q?Z1t0nwVZfaAdn4N5hBMaOGJNPdxZV56PORHzID3YexJPTidpximeE+LyM5?=
 =?iso-8859-1?Q?fYvi4rGaIOusTwcn49az9/PsfxADOGaicqUaRX5ln0xQqQcaR2Abb2YgpP?=
 =?iso-8859-1?Q?+i096Fsw5U6BCaVAbGp7CT91GxD2uO949x3ZxnVfIrXNB/nu2BuhE5VzTl?=
 =?iso-8859-1?Q?PqU3+DZ6YgL1dvYQRZAm9jd5PEitr5UiMOfgTLlbOA1TRVFhWtBIexCbwr?=
 =?iso-8859-1?Q?WugnlTxaOS4/5zPvEOtXBPmf2KivJAuaWnWNBo+xhg+dyi6Ziw9Ai0P6z7?=
 =?iso-8859-1?Q?JnuBwUFlODjKi1qOHPOtxL/j6ON5/Ve0SbPyqaIY0atTIWpQ6EAhGqiRCt?=
 =?iso-8859-1?Q?ANCbDdZfpLOsBAErAJDPuPyAclUABGi5ZujwKiCgB9hbnDlqs/z4QOSsVT?=
 =?iso-8859-1?Q?jh5D1dvDLdwO6nalpZnPjJCg85EoZMyeZVKcr+hTBOvYP/nwl9XdnwVDnC?=
 =?iso-8859-1?Q?23AxMDh5uC+SckHUpqHuY5482rYG8jd49RvDUdb9hAvVw6DaDnbxcgxUlo?=
 =?iso-8859-1?Q?duRPPhdFXJVMBT6LrT/w8dXWI7tRlz7yTBtwQkSrfhL4q+Gd3M+Iv07P/6?=
 =?iso-8859-1?Q?J6V3QwJMIW3bBL7K7I4jl3pP5ZBCwCj2xhe2UUKTfHttEIjg/vWdIXOWEz?=
 =?iso-8859-1?Q?7cJelGykOiF1M++olf+l2LlKKb35lhrfmeHFXE7KFUODeKkKI+SGSsxGmS?=
 =?iso-8859-1?Q?2bgMTd5SGqN0yKdOu7HA5flYlEb80D6dZgabtB5GteMThiWHaWxivPtGfK?=
 =?iso-8859-1?Q?MAooZEXe41UvY08Z303e/34PyTFPd3bYoitc3yP1ufzvh7HNvnwy2rVLBc?=
 =?iso-8859-1?Q?HcbvCTaS0lpG5Yen+6LJTXfgbo5EonWa3SISdupxWoaBgJDnBbo4eOfpdA?=
 =?iso-8859-1?Q?kxk67zX91oGY18Idl5QSb5achjN/QkqS6gWz2VdmXu5R4qgtTWaAMFsKI8?=
 =?iso-8859-1?Q?bAfCg6v7aW2itL6EjrTWrGiigVc2Y2pisQi38orFvGbGyIGIPZ3Fv5Qd3r?=
 =?iso-8859-1?Q?IJt+e4dm/zBlJjoEwFoMPDpgM9YyWkVMx+N5leKMlXB3MewzeGIJqo/tHd?=
 =?iso-8859-1?Q?v23vprP2G78JvI2jVZmL05CwhNwlhPZT/HHYNVY3kfszww/MVgrujs4X/r?=
 =?iso-8859-1?Q?txpgX/uOL0kwh1JtjdAmehwoQYYli0Ct8L9Vi4yURz73A+quMCdLIkrXRy?=
 =?iso-8859-1?Q?/bc0B4SMRKBwl/ayC17wsDc0XX567lLshD0VAyuOZrwC8g5UVjGtaFxMTp?=
 =?iso-8859-1?Q?JM+0/M6PP0k250DnjQa1OGwJ8Mm+kQ87YXKt1Iv05sx6tnILl3Jj46uwkH?=
 =?iso-8859-1?Q?dd+HLZYc6QkVkh7Dgyb1t3Rtzm9g6zJ7pUmFlQqzvZt79bg1BjRPQOX3Zx?=
 =?iso-8859-1?Q?DUG4gqL058WDVdRIbgfVlEYCd6SWIY8Ss5O8A3Ncl3pT/LMi3D20mouUVt?=
 =?iso-8859-1?Q?Cfip+XrlQyHmU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9c791e-0096-44dc-d1e2-08daadd04caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 10:38:57.7427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqD9xywtZtJtN7QqEqU1bmqUtDDJ22uq/OJ28i93H5IKCgF8h81WsiRdlAXq0S1eM7pIvfgcR3mdQgr9+kU8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5365
X-Proofpoint-GUID: nTLaThuC4FmwR37QJx3PwOU5hMVOCmnr
X-Proofpoint-ORIG-GUID: nTLaThuC4FmwR37QJx3PwOU5hMVOCmnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Friday, October 14, 2022 11:40 AM
> To: Jonathan Cameron <jic23@kernel.org>; Andrea Merello
> <andrea.merello@iit.it>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; linux-iio@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH] iio: imu: bno055: uninitialized variable bug in
> bno055_trigger_handler()
>=20
> [External]
>=20
> This bug is basically harmless, although it will trigger a runtime warnin=
g
> if you use KMSan.  On the first iteration through the loop, the
> "best_delta" variable is uninitialized so re-order the condition to
> prevent reading uninitialized memory.
>=20
> Fixes: 4aefe1c2bd0c ("iio: imu: add Bosch Sensortec BNO055 core driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
