Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0E3FB41D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhH3KvB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:51:01 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:60584 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236324AbhH3KvA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2021 06:51:00 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17U07bVX002993;
        Mon, 30 Aug 2021 06:49:53 -0400
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 3armh0t7ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 06:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvX8DjCX2d8gAk8iiPSec6OnD0q9RRqOxL3b20cqvHkXXe4TtWsR+AD8/XT3fcrwbSLacyGgSok6APrL9sSuDkqgGx5BEn67r9vsEjGgM4Kxmeyl7RKGlK+Qk0fhEkQA/wi5dc74sUWJmVRg2b+WFnNWPvBlPCcPeIOn9V9KH9BRM4sPHCPTEVkh+lpF/l/lLMs7yP4LcYytAT0k9SYD3CbK/UPdJLVKKTYBPTlTBb+/35wEqbh4wSPgYhDFMVwnARjRAAsF1CwVgZHPJeD5sauzK2oemEPCScEjevs5HMmRfYhtYFlal63nc00IFHTinlKVg+hN6VFzyEOefYCafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdDtMYxAtR42+QR0r4ge/tP/E9uMhYm9dpnFp5Dlu08=;
 b=Kj2J8US2spuVfEBvtP6eCtcBSMnc0/PqOickTBQJqzmEsr0czzw89XB6tDT1mqIt04HH5s55O5n6Uk2Up6avcawcMxKXnTmRWAzmNJj1kAAk86ZPre88+HK9oguQCecm6PhvulPJYIqXkeQgz4CtwXztwWzrZt4JjclUvsPIOCFZ3gC0isk+XXy+ML2PTUZ/C6oRWddzjiRqcTkhv/0Gm5ruFIFw7xsD8xMUCu3mqhc0FYFjA/aENFsS426fxGZ+Y1OZaQci5dCyCTozKKWgc7NsL3uPWiSCMMbzTaIdooPuzgX6gYelxqiuah5NHs4lfksHqSd5zyH2Dk1rEL53lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdDtMYxAtR42+QR0r4ge/tP/E9uMhYm9dpnFp5Dlu08=;
 b=mn+pkNlru/QMl8VNgnHbeHijpEBLeWT5QvRlWD+SRHoQLOlggeUbxAUtOSl8NJ/Oj29/2oOh7oGObglv8SMtgm8BlEw6vQ2uWEBhKr/a2Cm9eqX8TvbG7XbmC8njDGq80yYDidFh2QsdcpNnnc4fmtjPGL+vV0oO5/EUGw+UDDw=
Received: from MW4PR03MB6363.namprd03.prod.outlook.com (2603:10b6:303:11e::10)
 by CO6PR03MB6273.namprd03.prod.outlook.com (2603:10b6:5:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 10:49:50 +0000
Received: from MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4]) by MW4PR03MB6363.namprd03.prod.outlook.com
 ([fe80::3c5f:4b91:b79f:b1b4%7]) with mapi id 15.20.4415.023; Mon, 30 Aug 2021
 10:49:50 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 03/16] iio: adc: max1027: Push only the requested samples
Thread-Topic: [PATCH 03/16] iio: adc: max1027: Push only the requested samples
Thread-Index: AQHXlCHZcvfItjMzgEq4yH/BqTkNM6t7+sRQgA/qxgCAAAouQA==
Date:   Mon, 30 Aug 2021 10:49:50 +0000
Message-ID: <MW4PR03MB6363FE3BAF40A383D244ADC399CB9@MW4PR03MB6363.namprd03.prod.outlook.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-4-miquel.raynal@bootlin.com>
        <SJ0PR03MB6359415E120CFD3EFAF417F599C19@SJ0PR03MB6359.namprd03.prod.outlook.com>
 <20210830110756.733d5201@jic23-huawei>
In-Reply-To: <20210830110756.733d5201@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dFptUmtaVGs1WlRndE1EazNaaTB4TVdWakxUaGlPR010WlRSaU9UZGhOMk5q?=
 =?utf-8?B?TnpFd1hHRnRaUzEwWlhOMFhHWmtaR1U1T1dVNUxUQTVOMll0TVRGbFl5MDRZ?=
 =?utf-8?B?amhqTFdVMFlqazNZVGRqWXpjeE1HSnZaSGt1ZEhoMElpQnplajBpTlRFNU5T?=
 =?utf-8?B?SWdkRDBpTVRNeU56UTNPVFF4T0RjM09USTRNVFV4SWlCb1BTSjZlbmROUVdJ?=
 =?utf-8?B?dlpIUm5jVEpQU1ZSSmRYWm1SakJKWTNCSk5VMDlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZKV1VSQlFVUllWVVY2UVdwS00xaEJVUzlpY0daamVIb3lXRWxFT1hWc09Y?=
 =?utf-8?B?cElVRnBqWjBaQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkJWMEYzUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVmh0V21kcWQwRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJRVUZDYUVGSVNVRmhVVUpv?=
 =?utf-8?B?UVVZNFFWcEJRbkJCUjAxQlpFRkNjRUZIT0VGaVowSm9RVWhKUVdWUlFtWkJT?=
 =?utf-8?B?RkZCWVZGQ2JFRklTVUZOVVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBGQlFVRkJRVzVuUVVGQlIw?=
 =?utf-8?B?VkJZMmRDY0VGSFJVRllkMEpyUVVkclFWbDNRakJCUjJ0QlluZENkVUZIUlVG?=
 =?utf-8?B?alowSTFRVVk0UVdSQlFuQkJSMVZCWTJkQmVVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJRVUZCUVVGQlEwRkJRVUZC?=
 =?utf-8?B?UVVFOUlpOCtQQzl0WlhSaFBnPT0=?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e2d79e3-7368-487e-c58b-08d96ba3e45b
x-ms-traffictypediagnostic: CO6PR03MB6273:
x-microsoft-antispam-prvs: <CO6PR03MB62733AB1C2A2C9C0CCD8CAF399CB9@CO6PR03MB6273.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9Ky3PGEYQ38N9Mmn2ureezu3HKKQbXzWLP636aDbOAp/IzcwMgV0xorKJdS41LALyRIcU9K8nvXvbr3JRMsoX8IWMu9I1nnGugHZ8//M9nZ+eaNRoXBJu7uHWSNHarStYoZxt5QDXrv8IHd+Zu205kkm23+B1T3vskSHPG41DPmbQp3VaUpDHDG2D8QyNFeVRD9jMAbewbIyGf6Pu8Ls6Bang38th9qPwZebo96E9zxIVsROZoDXAD7lmTg56i0spoWTN5eeOWG1NJ4BeIxAasplxTyPGvQ7EZiVM051TtcdYb2k4lskMRqzOAieltv7UV+RczCc8pL6obPKSCvwVJIl1+eiiXKIDTqIYArzaASpya26gy9fFufrBBTpugABtkuBrchf8q9ve0N9zUJpi1hUy5TLPuUGgJ1hZskzPeB2HCwwY6CJu29S+xEhCFsaTIZvnvK0K2YEf5taSr/EPr1vdTvgpwYPwH0679PsUdkIVeO5mIjPejbT4mAiVnvdL/KU0OvadlCx1KaNTXZyOxcvzLZrL3FJmUcPGkKhILmGzVBoaLdOzimhdsqA8Bl2yOZ44TAYC3ghit2R53C6kLKhBx7rCQV46Pdrru99PPkySzNw5lRsEOuhf5sWwZdKrYtYl/uld84vdxvyPrHoJThM4sS51Prriq94JrLNmSRvUaNlKycTDgByMwFNe+W5xQfcBTZy3J7Zx8X+Ml4hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR03MB6363.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(122000001)(5660300002)(6506007)(316002)(55016002)(7696005)(52536014)(4326008)(508600001)(186003)(8936002)(6916009)(26005)(53546011)(38100700002)(33656002)(86362001)(8676002)(66556008)(64756008)(66946007)(66476007)(2906002)(71200400001)(66446008)(9686003)(38070700005)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW5ac1c1alkvTkt5UlkrZTgyVGZqdS9RV1dnRm9PRk12N2xEeDBNd1NyMEJn?=
 =?utf-8?B?cEZWUGIyQXBKZ1JaMHFzd1IwQVBVd29lL1pmY0V0MEx1UXp2d0NPb2pqa2lU?=
 =?utf-8?B?eTNMWVhUdSsxT25udy9wV1FBR3NVN3NUbHNQQmdieXlwcndUbk9WQWZhZWhO?=
 =?utf-8?B?UnE0QzlzRFVPbXdqcjQ3cGRvM1lodTh2cDFPVGFSY0dVQml1VW5ndksyYjl4?=
 =?utf-8?B?eTBPRXFnQUtIUURGTUQrZ25zZisyRXdKUFJEZ2k3VkZKVjVVUnVGMko1STMv?=
 =?utf-8?B?VGJiZnNvb21INHMrMlcrclNXNjNIV1ZZVHM5QzlCTHlKKzdudDIxbkFvODJj?=
 =?utf-8?B?Y1lhYWk5MzZFQmtjdG0vMDRvdDZYUTBKMW5rSzBhd3pkcS9lVlp2WGRNL2RM?=
 =?utf-8?B?ZnB4eVhUbFk1UkRMZWVyNjJKMVc5czExdnJCQkxrekVqVjJnR0ptTzJVaDYx?=
 =?utf-8?B?RjVySHBTRGFyRWhOa3RLK0w4RklMczhtTi9LTzhTRUpOd0hnelM3TVZuOTJL?=
 =?utf-8?B?ci9Cb3AzckVsVy9OSXppdGVnTmVnQmw2K3MrSmJPSi8waXZrTndYVG5SbUpo?=
 =?utf-8?B?L2ZmNElLaklTUlJhbnhBd3FoUjYrS2g1R1JjWXFWdEtremI0ZVVKb0w5emlK?=
 =?utf-8?B?ODZ5ZUpZRmJkVitMbmpITkVvbGNGTTYzVy9lVVVBV1BBeWRYcjAvZmpEK1cy?=
 =?utf-8?B?Z2VJWFNycklBNHI3UGJPYy9pVmFZVjBSVTZFbmJvejVNdGUzWjNQcktJajdZ?=
 =?utf-8?B?MzcxVFNsYmZjYXhqUWJxQmNoSFBMZGZLcWprK2ZlalpGdTdCM2NnTUxJWWZV?=
 =?utf-8?B?dmdKbUpka1BDa1BDd2xNdjBhUEdYL2ZPckJLaG5FY1ZaM1crYWtXb3FJOGNz?=
 =?utf-8?B?cTBZYXMxOWk5TXJNcGUrNFNQeGJJVWJrR3hvcnMrY29wUitndDRpc3VvZ3VF?=
 =?utf-8?B?RjJ2VG9KVlZEV1FaN2RibVcrOUhJbWM1YTUrQU1CcmlTNXVINVlkUTBETG1v?=
 =?utf-8?B?TzVoZUpNTWoxT1hNR3gxU0RKWVRSbXpKZ3VNdVp0bVFWQStQaDRNckl2dWVu?=
 =?utf-8?B?NXI1b3RicG8rSTRwWS8xOHJCTDk2VXZTcjJlNjhkZHloTTViV2s4cEdJdkh5?=
 =?utf-8?B?M0xiUitmVCtiZkhZYm9Jd003T3NaeWppNVFvUlVta3BkZEdRRmdvRFJyS0s3?=
 =?utf-8?B?S25ZeFNvemU5SjVDZWRlenVtbkcvQTNUQ3FOVlplOWcwL0dCeU9uZCsxYWl4?=
 =?utf-8?B?U1JCMW85RFhpVVRxMlI4eDlTZzlRYlpzMWoxWUZSQ29HVXliWGMrY3ZLZHJi?=
 =?utf-8?B?dWRHakV6YSszd3poODRGZEdsZDZEWmpMRnhzaUFobU1sSjIwNzQ3bDNNSlQ5?=
 =?utf-8?B?ZDBVaUxwVStoRHBycXp5bEVNYW1VNWFOZ25tNGhqNWlLRnlzV25vSS83STRp?=
 =?utf-8?B?aC8xQVN5SjdkY0lRK0RHTDREQkRzblhVSHBkdlBqdmUycjQ0M1VKNVEzbDVq?=
 =?utf-8?B?Ly9WU2UzVU9OanBabzR6eDF1L3l4N0FSMUVISklqdUxFa3pFUHdlQmQ5WFJG?=
 =?utf-8?B?bkFpTmd4VkxpTHVteHU5b3o4M2dKRmIzQWF2d1FVVC9jVnI5L3lGL0YvRjEx?=
 =?utf-8?B?b1NEcW9xU1lrUS83SEhhU0orSkRmcFJSRnB2RnNpK2N0RDc5RWJiQ0NYUHZS?=
 =?utf-8?B?azRkOFRkdU1CMWFuVWN6bnA4M0hvaGRrUngxRzlLeDhVSHhZT3ZyNjRXNDFa?=
 =?utf-8?Q?Uq7Me52u1HFl3NVwKmn2sF1FJ49lB0zUZKGwJ85?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR03MB6363.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2d79e3-7368-487e-c58b-08d96ba3e45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 10:49:50.2516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fusnVfIybWTJ5WiYgDtIstgX7d4W3ZJxtIebcByUKGHfkks1psIaxRGhJC/r82x0ztpTqwjwZLXW2kLZ/Kb1HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6273
X-Proofpoint-ORIG-GUID: _2rwPhYHZFsFl5UTlXHDE9TqFMDjqill
X-Proofpoint-GUID: _2rwPhYHZFsFl5UTlXHDE9TqFMDjqill
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-30_04,2021-08-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300078
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBBdWd1c3QgMzAsIDIwMjEgMTI6
MDggUE0NCj4gVG86IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+DQo+IENjOiBNaXF1ZWwg
UmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPjsgTGFycy1QZXRlciBDbGF1c2VuDQo+
IDxsYXJzQG1ldGFmb28uZGU+OyBUaG9tYXMgUGV0YXp6b25pDQo+IDx0aG9tYXMucGV0YXp6b25p
QGJvb3RsaW4uY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMy8xNl0gaWlvOiBhZGM6
IG1heDEwMjc6IFB1c2ggb25seSB0aGUgcmVxdWVzdGVkDQo+IHNhbXBsZXMNCj4gDQo+IFtFeHRl
cm5hbF0NCj4gDQo+IE9uIEZyaSwgMjAgQXVnIDIwMjEgMDc6MTA6NDggKzAwMDANCj4gIlNhLCBO
dW5vIiA8TnVuby5TYUBhbmFsb2cuY29tPiB3cm90ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBi
b290bGluLmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDE4LCAyMDIxIDE6MTEg
UE0NCj4gPiA+IFRvOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPjsgTGFycy1Q
ZXRlciBDbGF1c2VuDQo+ID4gPiA8bGFyc0BtZXRhZm9vLmRlPg0KPiA+ID4gQ2M6IFRob21hcyBQ
ZXRhenpvbmkgPHRob21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+OyBsaW51eC0NCj4gPiA+IGlp
b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1pcXVlbCBS
YXluYWwNCj4gPiA+IDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPg0KPiA+ID4gU3ViamVjdDog
W1BBVENIIDAzLzE2XSBpaW86IGFkYzogbWF4MTAyNzogUHVzaCBvbmx5IHRoZSByZXF1ZXN0ZWQN
Cj4gPiA+IHNhbXBsZXMNCj4gPiA+DQo+ID4gPiBbRXh0ZXJuYWxdDQo+ID4gPg0KPiA+ID4gV2hl
biBhIHRyaWdnZXJlZCBzY2FuIG9jY3VycywgdGhlIGlkZW50aXR5IG9mIHRoZSBkZXNpcmVkIGNo
YW5uZWxzDQo+IGlzDQo+ID4gPiBrbm93biBpbiBpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2su
IEluc3RlYWQgb2YgcmVhZGluZyBhbmQNCj4gPiA+IHB1c2hpbmcgdG8NCj4gPiA+IHRoZSBJSU8g
YnVmZmVycyBhbGwgY2hhbm5lbHMgZWFjaCB0aW1lLCBzY2FuIHRoZSBtaW5pbXVtIGFtb3VudA0K
PiBvZg0KPiA+ID4gY2hhbm5lbHMgKDAgdG8gbWF4aW11bSByZXF1ZXN0ZWQgY2hhbiwgdG8gYmUg
ZXhhY3QpIGFuZCBvbmx5DQo+ID4gPiBwcm92aWRlIHRoZQ0KPiA+ID4gc2FtcGxlcyByZXF1ZXN0
ZWQgYnkgdGhlIHVzZXIuDQo+ID4gPg0KPiA+ID4gRm9yIGV4YW1wbGUsIGlmIHRoZSB1c2VyIHdh
bnRzIGNoYW5uZWxzIDEsIDQgYW5kIDUsIGFsbCBjaGFubmVscw0KPiBmcm9tDQo+ID4gPiAwIHRv
IDUgd2lsbCBiZSBzY2FubmVkIGJ1dCBvbmx5IHRoZSBkZXNpcmVkIGNoYW5uZWxzIHdpbGwgYmUg
cHVzaGVkDQo+IHRvDQo+ID4gPiB0aGUgSUlPIGJ1ZmZlcnMuDQo+ID4gPg0KPiA+ID4gU2lnbmVk
LW9mZi1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGluLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGRyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMgfCAyNSArKysrKysrKysrKysr
KysrKysrKystLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9t
YXgxMDI3LmMgYi9kcml2ZXJzL2lpby9hZGMvbWF4MTAyNy5jDQo+ID4gPiBpbmRleCBiNzUzNjU4
YmI0MWUuLjhhYjY2MGY1OTZiNSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9t
YXgxMDI3LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tYXgxMDI3LmMNCj4gPiA+IEBA
IC0zNjAsNiArMzYwLDkgQEAgc3RhdGljIGludCBtYXgxMDI3X3NldF90cmlnZ2VyX3N0YXRlKHN0
cnVjdA0KPiA+ID4gaWlvX3RyaWdnZXIgKnRyaWcsIGJvb2wgc3RhdGUpDQo+ID4gPiAgCXN0cnVj
dCBtYXgxMDI3X3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gPiAgCWludCBy
ZXQ7DQo+ID4gPg0KPiA+ID4gKwlpZiAoYml0bWFwX2VtcHR5KGluZGlvX2Rldi0+YWN0aXZlX3Nj
YW5fbWFzaywgaW5kaW9fZGV2LQ0KPiA+ID4gPm1hc2tsZW5ndGgpKQ0KPiA+ID4gKwkJcmV0dXJu
IC1FSU5WQUw7DQo+ID4gPiArDQo+ID4NCj4gPiBJJ20gbm90IHN1cmUgdGhpcyBjYW4gYWN0dWFs
bHkgaGFwcGVuLiBJZiB5b3UgdHJ5IHRvIGVuYWJsZSB0aGUgYnVmZmVyDQo+ID4gd2l0aCBubyBz
Y2FuIGVsZW1lbnQsIGl0IHNob3VsZCBnaXZlIHlvdSBhbiBlcnJvciBiZWZvcmUgeW91IHJlYWNo
DQo+ID4gdGhpcyBwb2ludC4uLg0KPiA+DQo+ID4gPiAgCWlmIChzdGF0ZSkgew0KPiA+ID4gIAkJ
LyogU3RhcnQgYWNxdWlzaXRpb24gb24gY252c3QgKi8NCj4gPiA+ICAJCXN0LT5yZWcgPSBNQVgx
MDI3X1NFVFVQX1JFRyB8DQo+ID4gPiBNQVgxMDI3X0NLU19NT0RFMCB8DQo+ID4gPiBAQCAtMzY4
LDkgKzM3MSwxMiBAQCBzdGF0aWMgaW50IG1heDEwMjdfc2V0X3RyaWdnZXJfc3RhdGUoc3RydWN0
DQo+ID4gPiBpaW9fdHJpZ2dlciAqdHJpZywgYm9vbCBzdGF0ZSkNCj4gPiA+ICAJCWlmIChyZXQg
PCAwKQ0KPiA+ID4gIAkJCXJldHVybiByZXQ7DQo+ID4gPg0KPiA+ID4gLQkJLyogU2NhbiBmcm9t
IDAgdG8gbWF4ICovDQo+ID4gPiAtCQlzdC0+cmVnID0gTUFYMTAyN19DT05WX1JFRyB8IE1BWDEw
MjdfQ0hBTigwKSB8DQo+ID4gPiAtCQkJICBNQVgxMDI3X1NDQU5fTl9NIHwgTUFYMTAyN19URU1Q
Ow0KPiA+ID4gKwkJLyoNCj4gPiA+ICsJCSAqIFNjYW4gZnJvbSAwIHRvIHRoZSBoaWdoZXN0IHJl
cXVlc3RlZCBjaGFubmVsLiBUaGUNCj4gPiA+IHRlbXBlcmF0dXJlDQo+ID4gPiArCQkgKiBjb3Vs
ZCBiZSBhdm9pZGVkIGJ1dCBpdCBzaW1wbGlmaWVzIGEgYml0IHRoZSBsb2dpYy4NCj4gPiA+ICsJ
CSAqLw0KPiA+ID4gKwkJc3QtPnJlZyA9IE1BWDEwMjdfQ09OVl9SRUcgfA0KPiA+ID4gTUFYMTAy
N19TQ0FOXzBfTiB8IE1BWDEwMjdfVEVNUDsNCj4gPiA+ICsJCXN0LT5yZWcgfD0gTUFYMTAyN19D
SEFOKGZscygqaW5kaW9fZGV2LQ0KPiA+ID4gPmFjdGl2ZV9zY2FuX21hc2spIC0gMik7DQo+ID4g
PiAgCQlyZXQgPSBzcGlfd3JpdGUoc3QtPnNwaSwgJnN0LT5yZWcsIDEpOw0KPiA+ID4gIAkJaWYg
KHJldCA8IDApDQo+ID4gPiAgCQkJcmV0dXJuIHJldDsNCj4gPiA+IEBAIC0zOTEsMTEgKzM5Nywy
MiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QNCj4gPiA+IG1heDEwMjdfdHJpZ2dlcl9oYW5kbGVyKGlu
dCBpcnEsIHZvaWQgKnByaXZhdGUpDQo+ID4gPiAgCXN0cnVjdCBpaW9fcG9sbF9mdW5jICpwZiA9
IHByaXZhdGU7DQo+ID4gPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYgPSBwZi0+aW5kaW9f
ZGV2Ow0KPiA+ID4gIAlzdHJ1Y3QgbWF4MTAyN19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19k
ZXYpOw0KPiA+ID4gKwl1bnNpZ25lZCBpbnQgc2Nhbm5lZF9jaGFucyA9IGZscygqaW5kaW9fZGV2
LQ0KPiA+ID4gPmFjdGl2ZV9zY2FuX21hc2spOw0KPiA+ID4gKwl1MTYgKmJ1ZiA9IHN0LT5idWZm
ZXI7DQo+ID4NCj4gPiBJIHRoaW5rIHNwYXJzZSB3aWxsIGNvbXBsYWluIGhlcmUuIGJ1ZmZlciBp
cyBhIF9fYmUxNiByZXN0cmljdGVkDQo+ID4gdHlwZSBzbyB5b3Ugc2hvdWxkIG5vdCBtaXggdGhv
c2UuLi4NCj4gPiA+ICsJdW5zaWduZWQgaW50IGJpdDsNCj4gPiA+DQo+ID4gPiAgCXByX2RlYnVn
KCIlcyhpcnE9JWQsIHByaXZhdGU9MHglcClcbiIsIF9fZnVuY19fLCBpcnEsDQo+ID4gPg0KPiBw
cml2YXRlKTtpbi8yMDIxMDgxOF9taXF1ZWxfcmF5bmFsX2JyaW5nX3NvZnR3YXJlX3RyaWdnZXJz
X3N1cHBvcnQNCj4gX3RvX21heDEwMjdfbGlrZV9hZGNzLm1ieA0KPiA+ID4NCj4gPiA+ICAJLyog
ZmlsbCBidWZmZXIgd2l0aCBhbGwgY2hhbm5lbCAqLw0KPiA+ID4gLQlzcGlfcmVhZChzdC0+c3Bp
LCBzdC0+YnVmZmVyLCBpbmRpb19kZXYtPm1hc2tsZW5ndGggKiAyKTsNCj4gPiA+ICsJc3BpX3Jl
YWQoc3QtPnNwaSwgc3QtPmJ1ZmZlciwgc2Nhbm5lZF9jaGFucyAqIDIpOw0KPiA+ID4gKw0KPiA+
ID4gKwkvKiBPbmx5IGtlZXAgdGhlIGNoYW5uZWxzIHNlbGVjdGVkIGJ5IHRoZSB1c2VyICovDQo+
ID4gPiArCWZvcl9lYWNoX3NldF9iaXQoYml0LCBpbmRpb19kZXYtPmFjdGl2ZV9zY2FuX21hc2ss
DQo+ID4gPiArCQkJIGluZGlvX2Rldi0+bWFza2xlbmd0aCkgew0KPiA+ID4gKwkJaWYgKGJ1Zlsw
XSAhPSBzdC0+YnVmZmVyW2JpdF0pDQo+ID4gPiArCQkJYnVmWzBdID0gc3QtPmJ1ZmZlcltiaXRd
Ow0KPiA+DQo+ID4gU2luY2Ugd2UgYXJlIGhlcmUsIHdoZW4gbG9va2luZyBpbnRvIHRoZSBkcml2
ZXIsIEkgcmVhbGl6ZWQNCj4gPiB0aGF0IHN0LT5idWZmZXIgaXMgbm90IERNQSBzYWZlLiBJbiBJ
SU8sIHdlIGtpbmQgb2Ygd2FudCB0byBlbmZvcmNlDQo+ID4gdGhhdCBhbGwgYnVmZmVycyB0aGF0
IGFyZSBwYXNzZWQgdG8gc3BpL2kyYyBidXNlcyBhcmUgc2FmZS4uLiBNYXliZQ0KPiA+IHRoaXMg
aXMgc29tZXRoaW5nIHlvdSBjYW4gaW5jbHVkZSBpbiB5b3VyIHNlcmllcy4NCj4gDQo+IFdoeSBp
cyBpdCBub3Q/ICBzdC0+YnVmZmVyIGlzIHJlc3VsdCBvZiBhIGRldm1fa21hbGxvY19hcnJheSgp
IGNhbGwgYW5kDQo+IHRoYXQgc2hvdWxkIHByb3ZpZGUgYSBETUEgc2FmZSBidWZmZXIgYXMgSSB1
bmRlcnN0YW5kIGl0Lg0KPiANCg0KVGhhdCdzIGEgZ29vZCBxdWVzdGlvbi4gSSdtIG5vdCBzdXJl
IGhvdyBJIGNhbWUgdG8gdGhhdCBjb25jbHVzaW9uIHdoaWNoDQppcyBjbGVhcmx5IHdyb25nLiBU
aG91Z2ggSSB0aGluayB0aGUgYnVmZmVyIG1pZ2h0IHNoYXJlIHRoZSBsaW5lIHdpdGggdGhlDQpt
dXRleC4uLg0KDQotIE51bm8gU8OhDQoNCg==
