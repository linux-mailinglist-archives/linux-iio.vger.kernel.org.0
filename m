Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5E157D7A
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2020 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgBJOeG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Feb 2020 09:34:06 -0500
Received: from esa4.tennantco.iphmx.com ([68.232.154.87]:51057 "EHLO
        esa4.tennantco.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgBJOeG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Feb 2020 09:34:06 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 09:34:05 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tennantco.com; i=@tennantco.com; q=dns/txt;
  s=selector1; t=1581345245; x=1612881245;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lRIO3kTAOG6MAbOj4cUV3AExYD2MeIL1uqzcXrUzK1s=;
  b=lRbEgZ/SIZvIa5lYN5TZI2+P73zdvap/kdRpm9dq792AxoYl42Tx1GY8
   sM23zWSRWu4YDlSRhxutmBVPy5Y3tBRbpBDCv+D5pMw4DzkOdV3djYhpW
   mBjM6CTi4pzLt5P/NoZy1TPETgp13waSHFkj0YusOz0V1rFcVrqexfJMP
   Q0zMMN0B7GXOtWOH0ZE2m6Jh8GNLPDN1wLR/LcxrDo277ErsNxOKVK8V5
   sugoiBSoohInm9wAGVfJ70qgERu24FhbCzryh/3kU8UGfxQtfY+VW/Hgg
   alvYc4fzphG84TDdGNd7mCTAaBbyWbvnAwkL5JH/q3SUEE1uPSB1B/VDP
   g==;
IronPort-SDR: vwfrG8uqQ1lTw27IoZI8ATIPlMGXSfyuZOXv+MBtEhnv2Qp1mfbKgKqErbtiOLLUK0HI5AavLm
 MiOuSlQXF5CEAIXAJxb03IHg1OUAPlB0JIsE0Clnys4avFsuU70gsFvxlXJvjsbbvbp5hNUSng
 hD7C8HexklMcw58ogPnr/5j5l3uE4Kesw9qq3P6Zr2nMNIdJEK8tquTPqVNPaDPsfd0g0smVRr
 V+w+86uURC3QiHrVSFCn93ezEBZRHsl2el7CWWyOaDCa87YuWqPuum5yhybetSP+Ak63z5vWES
 0q4=
IronPort-PHdr: =?us-ascii?q?9a23=3Au31D6hAKYvsZzaxDAXxyUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSP36psWwAkXT6L1XgUPTWs2DsrQY0raQ7fmrBzVIoc7Y9ixbK9oUD1?=
 =?us-ascii?q?5NoP5VtjRoONSCB0z/IayiRA0BN+MGamVY+WqmO1NeAsf0ag6aiHSz6TkPBk?=
 =?us-ascii?q?e3blItdaz6FYHIksu4yf259YHNbAVUnjq9Zq55IAmroQnLucQanIRvJrwwxx?=
 =?us-ascii?q?fUrXdFevlazn5sKV6Pghrw/Mi98INt/ihKp/4t68tMWrjmcqolSrBVEC4oOH?=
 =?us-ascii?q?0v6s3xshnDQwqP5n8CXWgTjxFFHQvL4gzkU5noqif1ufZz1yecPc3tULA7Qi?=
 =?us-ascii?q?+i4LtxSB/pkygIKTg0+3zKh8NqjaJbpBWhpwFjw4PRfYqYOuZycr/bcNgHXm?=
 =?us-ascii?q?dKQNpfWDJdDYO9d4sPDvQOPeBEr4nmulACqQKyCRSwCO/zzzNFgGL9068n3O?=
 =?us-ascii?q?Q7CQzI0gwuEcwTvnrXotX6KLodXuK7w6bHzDXOdO9W1Svn5YTUbhwsu/OBUL?=
 =?us-ascii?q?RtesTR00kvEAbFg02ep43lOzOazOINuHWZ4epnW+OglW4moBx2rzahxsYsjp?=
 =?us-ascii?q?PGhoQPxl7G8iV4zpg6JN2jRU5nf9GkFp1QuDucN4tqXswiRHtktzo9yr0DoJ?=
 =?us-ascii?q?O2ejUBxpc/xxPHdvCLb4eF7gjsWeuTOzt1hm5pdKiiixqu80Ws0vDwW8233V?=
 =?us-ascii?q?pQsCZJjtbBumoD2hHd8MSLVOdx8lun1D2SzQ7c8PtELloxlafDLp4hxaM/mY?=
 =?us-ascii?q?QLvETYGy/2hF32jKiLdkU44uSo6/roYrHhppKEL4F5lgbwPrkylsCmHOk2Kg?=
 =?us-ascii?q?oDU3Gc+eunyrLv50r5QKhWjvItlanZrZbaKtkBqq6hGQ9V1Zoj5AijADe60d?=
 =?us-ascii?q?QYmn8HIEhCeBKak4jpP1bOIPf7Dfuln1uslzJry+jHPr3nHJrNMmDOnKr9cb?=
 =?us-ascii?q?ty8UJRxwg+wcpd6p5IEL0NPe7/V03puNzdFBA5Mgi0w+j9CNV604MTQWyBA6?=
 =?us-ascii?q?+dMKzIt1+E/OAhI+6CZYALuDfwMOQl6ODojX8/g1Ade7Wp0ocQaHyiAvtmJE?=
 =?us-ascii?q?CZbWL2gtgdCWcKohY+TOvyhV2AUD5ce2i+Uqwn6zE4Fo2mF4HDSZ6pgLCb2y?=
 =?us-ascii?q?e7BJJWbHhcCl+QCXfoa5mEW/AUZSKRJM9uiCYLWqSiS4M71RGjrwD6y79oL+?=
 =?us-ascii?q?bO5yIXq4rp1MJp6O3LiREy6Tt0AtyZ026XVWF0hXgFRzoo06Bju0N9xFCD0a?=
 =?us-ascii?q?9ij/NFC9NZ/+lJXRsiNZ7A0+x6DMj/WhrEftiXVlmmWNunDCopTtI03dABfV?=
 =?us-ascii?q?x9Gtu4ghDFwSWqH6cfl6aXC5ws7qLcw3/xKt55y3bH0qkhklYnTtJONW2nga?=
 =?us-ascii?q?5y7BbTB4HXnEWDjaqqdroT3DTL9GidyWqCpkZYUBR/UfaNYXdKREzQpMj570?=
 =?us-ascii?q?WKZLarBK4gNEMVy8+JcPBiadDzi1hCAvD5N4KNTXi2njKcFBKBwPusa5Xnai?=
 =?us-ascii?q?1J8DTZAU5CswcM8GeuKQU4AC6nv2nZSjdpEAS8MAvX7eBipSbjHQcPxAaQYh?=
 =?us-ascii?q?gkjuLtoERHjOGAS/4VwrMPsTsgrDMxBlumwtbKEITQ9RF5cvBaZtUwqBdc2G?=
 =?us-ascii?q?TVuhY1H6ToLrsqxzt8Ox9yo1uo0hx2Dotals1/gGIuxQw0CaWH3UJpaz6e25?=
 =?us-ascii?q?n2JrbQbGL1+UPnZg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2E8BwBSZ0Fe/2tGL2hlgkECgVIpJ16BCAMENQqEC4NHA?=
 =?us-ascii?q?QGFOoVEmnGBLoEkA1QJAQEBAQEBAQEBBwEtAgEBAoQ+AjWCNjYHDgIDAQwBA?=
 =?us-ascii?q?QEEAQEBAQEFAgEBAQECaYU3DEIBEAGBZykBcXEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgIBAxIRHQEBESYBDwsODAIFIQICD?=
 =?us-ascii?q?wUeCyA1hU8DLgGZewGBKD4CIwE/AQELgQUpiGEBAXSBMoJ/AQEFhHkYV4E1C?=
 =?us-ascii?q?QkBgQQqAYdEhG2BTD+EJD6HWzKCLJgMl2oHgj18lUQngjgBmFaLAp8HAgQCB?=
 =?us-ascii?q?AUCDgEBBYFZBi2BWDMaI4M8UBgNj0QBCIJDinIkMYEFJIJEiWsBgQ8BAQ?=
X-IronPort-AV: E=Sophos;i="5.70,425,1574143200"; 
   d="scan'208";a="17134535"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.tennantco.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 08:26:57 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESehEE7GaGUs17LMevi+5eXvq1TGuGvtN4jm9EtNIMIsUS+Wa20gRhBjHrzPbQ15G3scICt/wIOn57ja4NJGXC961nOpmxetFRn70cleNOgBqs8U3gUgj+ENGL6JJrK4gLyW3Gn4hfnXqc+HRCBQLOLigaQxo4Riab91uFbWgtNpH6ZftWvfAd56uV3nQtlRRq4qZVyFcdl1mGPpwywL4SPLoQpOEDCBNPLP7TPex+Y4DPrzPIoH4HZPI9GRqos6RxidShOkO0Luzesw8SrQjvPv5AkuCtrS9RkxBbPpFkqd/ZVpAKPn6R0LijD+ZMj1I8JEDSXdNIwliMH6qiYbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRIO3kTAOG6MAbOj4cUV3AExYD2MeIL1uqzcXrUzK1s=;
 b=OjessHYOvAS4vdlW1/B25XDGf/Q2s7dqbgjappqSLbNkwQLPC+OFlNd2xB77PF7/aK9YGMB51dRfeUDcLWvK9Dk2Izz079rnUa/yr23EBp1G6S/ljbTETyYMK5zRPcF/Oxu1Zz0bU9NF2FisNIMHQSaSa4lqnxRU5P6anitnbFhAYlEpMKbpbShZ2+7S5LPZbiT6Fx61h7hQg0g3O62KN3BfjpMBee2y/iqQhFWlaFpJt1Kr2ZAIC2v/DWqVJD4UEDxQfbMsc1pm6DQ0vIf1VwV/mXn6zXovc9pXaTcA6vw7SvUC3SuWzvAs/dgImT9abU/qR//+Yus9jWnn9IJbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tennantco.com; dmarc=pass action=none
 header.from=tennantco.com; dkim=pass header.d=tennantco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tennantco.onmicrosoft.com; s=selector2-tennantco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRIO3kTAOG6MAbOj4cUV3AExYD2MeIL1uqzcXrUzK1s=;
 b=FZiI1cISSrhIPAgbZKTv8HtlKMVBukZGb0kTjkgTfEpD+1wazZVyZPAl4jlTmcvxGz3uIIuiZxy72/y47jkdYyy6WZaUByseLYgTiVC85+CW6ohmou4kUQaE63APt043kK+pRGfP3SIXO9+CxbW8kGjl9rPj6t9U44LP1w7b9eY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Dylan.Howey@tennantco.com; 
Received: from CH2PR20MB3271.namprd20.prod.outlook.com (10.255.156.30) by
 CH2PR20MB3141.namprd20.prod.outlook.com (52.132.228.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Mon, 10 Feb 2020 14:26:56 +0000
Received: from CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1]) by CH2PR20MB3271.namprd20.prod.outlook.com
 ([fe80::b12f:4e2a:2a0:51c1%7]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 14:26:56 +0000
Date:   Mon, 10 Feb 2020 08:26:53 -0600
From:   Dylan Howey <Dylan.Howey@tennantco.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: Expose temperature channel
Message-ID: <20200210142652.GA22858@tennantco.com>
References: <20200205203240.13550-1-Dylan.Howey@tennantco.com>
 <20200208163154.4d4f6752@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200208163154.4d4f6752@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM5PR2201CA0024.namprd22.prod.outlook.com
 (2603:10b6:4:14::34) To CH2PR20MB3271.namprd20.prod.outlook.com
 (2603:10b6:610:2::30)
MIME-Version: 1.0
Received: from tennantco.com (198.204.33.200) by DM5PR2201CA0024.namprd22.prod.outlook.com (2603:10b6:4:14::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 14:26:55 +0000
X-Originating-IP: [198.204.33.200]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d610f0-621b-40f2-36c7-08d7ae3547d1
X-MS-TrafficTypeDiagnostic: CH2PR20MB3141:
X-Microsoft-Antispam-PRVS: <CH2PR20MB31417D29766D631BAE22336AEF190@CH2PR20MB3141.namprd20.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39850400004)(396003)(136003)(189003)(199004)(26005)(4326008)(36756003)(186003)(55016002)(16526019)(8886007)(54906003)(81156014)(81166006)(33656002)(6916009)(316002)(8936002)(86362001)(2616005)(956004)(5660300002)(8676002)(558084003)(2906002)(478600001)(7696005)(52116002)(66556008)(66946007)(66476007)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR20MB3141;H:CH2PR20MB3271.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: tennantco.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qvxMK/dYXG21B0vTmz/lG+snbYXWbRD9NVU3yHauvAQSD/DPwkHDWD5AJc+Mi89wKpOvvMvJuLJijh5PjPjHFRMJRp9QSg1ub+otHksBeRolNEvR7Vs3G7osAg7dk1UeTuF3/qutHBo4kH5vigxpXJnfZg8gIaD/80ueCm/lzB/U2cGBDTuYke26owCDKq8VCIfwIzOHaMkSzfNI7YN8CoXqgoupPxDBcWTi+6Gp/GpAE66y2BQZj4VlF2tdvRXd3P99+DJFWfJcjQZ1KsuBL7szucN6f9hfamlGd8a4Q6FX+1GlkbwYRL6lnHhNBAlxrNc7m7baQ/Mb3jvtLw/dWgOjd3MxAxFcwwiiIUTcU95mq1n6lm9YQ8DNkA+INi2oBNzTlaQ0y71d563cudJyMjrouZ4Bt4gG+6fWCIFAjcnZF8XBzA+Wq4QJgE/UOXE
X-MS-Exchange-AntiSpam-MessageData: 1yNomIl1pzUZmkZ3yfKkQUB+Wv+5YKbXRIO/0WMSX5JOtIevYFTmJYHBnkqlbcLYSwIiWlhV68gI286aLt7ufA83tPZcBhlufnH4B8DTPEq5gFPTYSsjtEB8677dtNbLLBgRIW5wLPrustAOUhRXFw==
X-OriginatorOrg: tennantco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d610f0-621b-40f2-36c7-08d7ae3547d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 14:26:56.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 854ee4fb-bf50-420c-8a26-5b96d626ac37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEjeTYrxaIiSR2bf/cWFYWn5txHE1uVCxr1982T7YjJ3YIAk3lXSoNLN4ZmDqEocDEwPLZWUXk4cdjENXgE7UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR20MB3141
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thank you for the quick feedback. I'll send another patch soon.

-- 
Dylan
