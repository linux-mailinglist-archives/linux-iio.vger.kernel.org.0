Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF63460A67
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 22:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbhK1Vxz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 16:53:55 -0500
Received: from mail-eopbgr80127.outbound.protection.outlook.com ([40.107.8.127]:64000
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231842AbhK1Vvz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Nov 2021 16:51:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n33Z3W6QVk6DZmMiJvKAtV/ooYt9XMSx2qgBuQ+LS/SecPTWIPYxfuVMyz4oVAFuFA1KEK+1EDlcUz9xuIzQ+CLUGqUBDY64cVwybyex+MgdMU/2F35QpYl5jrk2xcX1Ivwxxa6VNboYDntVA1FSDt5bNQLSuo4h3bTaIJkYq/1UTkjZV/U+LkjuTYbj2ULikkcy9A3/wTE777lcV3CM4H3jA6duxwojmn2vyiKbg6OlUofYL7D1mse1S8rZizcSyJJ4l8gBvedpIsbk0LnVXub9xcfqXa9eZJlJ3TF2KU0ZEmFf4x2PBjAV4ESgDUzEpWzI6S+hYVbpcF55ZK5xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqwlwj69dPIXp8QCejfqZNQ/g9VJyE0z9QfqHN01ZFE=;
 b=kKC1Mw516x8Yes8JDjGO708AX0q2xxf82i3G8YmgmvyHrtdcW6rOSH4KQfflGRm39QxxNDXvPi3DZxZCYo5h539AzjLLg8zKfqb4aJCTP4D6xVWyIoYPVUVMDZrCx1TTDB5wREWfRzZa8qQML+9NEQzgc8J/uOwoF7OnQzPpdeba/jfiqCJ/ZHO2hde6A295LbLglDE1IqwLSTnMrj3b9pZj0lkkvrDc2tcDnlYCWPT70rKYi/uXTQMx2c+Mm+7wtjlWakrP/caI6tFbuYPxDHLDYr6C44BeVCes2AebYvUupl6ZKRqD4op/JoPTUSSzUGqzw7zggm7LiOJkeHWdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqwlwj69dPIXp8QCejfqZNQ/g9VJyE0z9QfqHN01ZFE=;
 b=ebxZhC33+6QDPIqb7HJhbgsNMQkKNuKieOxlQMno3O89YyVjvxhMXZmhNry48EpjEakkJoXlo8JKvx7fJEBnLmUl6ZyB/8ou+EtR2+9UfPnK+qvYsTLsfJA5E00PCO2DDmd0rKek1pvoPXJqPPZPxFz/UclZFmwq2O3j3IXN0uY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2392.eurprd02.prod.outlook.com (2603:10a6:4:37::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sun, 28 Nov
 2021 21:48:02 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.024; Sun, 28 Nov 2021
 21:48:02 +0000
Message-ID: <7fac848d-38f3-ed5c-66fa-39e063b0af38@axentia.se>
Date:   Sun, 28 Nov 2021 22:48:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 10/12] iio:adc:envelope-detector: Switch from of headers
 to mod_devicetable.h
Content-Language: sv-SE
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211128192635.2724359-1-jic23@kernel.org>
 <20211128192635.2724359-11-jic23@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211128192635.2724359-11-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::26) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0033.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Sun, 28 Nov 2021 21:48:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe915cce-9ea6-426a-7908-08d9b2b8c09d
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2392:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB239248DB7FC8A349380722A7BC659@DB6PR0201MB2392.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+c/UncnOEeu1fJFQaGpWoglDytmPRoU8OXBcuBd52OQrUf60JdDHU85AbigYOO47LCPqkw/GrCF9zdinI45rV0AlQbefyNMTxwNotJCN5LEyv1a9tjPFDREC1kZcqk051eCmD7oaGp70YXMCX5xPElUYZur/HOE76UXd3NzS7dcmsmRjur0bJQ3uCEO8MyUhiQTOBemcm6m964PEpt41ZNU1I55FbyKMz0Rt8QXW79OQjfPTpzKaM1p7MCiuxIvnQSh1h44M7vIM3f8dIDN/H4SuHxL50/WVdjqtf4IVXu7zCmYR327Ovy4alw3PKS7KZYYFI1QrRXUSDjsjak4JoLggMr+9xBwMCtqD6l5CllePLozjLetYW4977pBkRI2RzbWOwfgbpsszTDxg9xcA/jD6fQZH4M/EU3Tu/hck86FSlF9/iF4cXW7OWA5dpLsRmfiZfyBpz7ydj3oTOChDz7PaJq9O9IbfYsEFBwWyEiPZUh8Ta8Ze0gTA5xDwcbJuRtK9AdHevowypiBKBQVwkGWqXz7ziKkW/w4qUA9j626p9wNRENgFLUCwV4nSE1Zx9joVDb4aqrOgEqrLRyr1r2ngJFt3cbMUHFzO1JH4/v205wfWL9gjR4S8AeV88vr0YYm38xCELbyr+pIruN5ZdkOVUZ1rIjQ38Drs288jBd+bw/AsVNMS9KAi8Nh41Q1DsVqd/tr5+kAoYC32cD2Gc58xeSLYlotEXZUlgaT3P8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(39830400003)(136003)(366004)(66476007)(4326008)(6486002)(36916002)(508600001)(956004)(31696002)(26005)(86362001)(5660300002)(31686004)(4744005)(36756003)(66556008)(4001150100001)(66946007)(186003)(8936002)(316002)(53546011)(16576012)(2906002)(2616005)(54906003)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDFwRnFkS2JRYzhiRy8zZHd3OXFJZ2hocitvNkZhU09rbWZTMnY0YXJmMDh4?=
 =?utf-8?B?cWpHc3ovRW5udnlQRkNoU1o2SVJtbWEzcEMwQ2lQR29PejB5M1hBVzduMjIw?=
 =?utf-8?B?NnhFQzkzTHRNbEYzMXVVL3ZMYmQ2K0R4VlBoeDYyQllZc0YzRXlrZzVnWFpF?=
 =?utf-8?B?ZGFnZjlOdVJDOEIzWnBuZU9SWnIrTEtWUE5sNEtqWlhjbHZnSWZ4Qm9BUVF4?=
 =?utf-8?B?alJHUExkVWpUaENlNDNENGhPa0N2TFk4WUxKOUVEVTloc1d1S2h2djRaZm1u?=
 =?utf-8?B?eWhaVU93Y3NJeWIwOGNUMmpKS2w1ZGdmYmx2U0l1T0gyNFg4SWNSRDlBcE1V?=
 =?utf-8?B?ZjFCMGtQRkxTM05ZRCsrUGg0VVprcTBFY2ZDbElueWNwd1l6UmpLTitzYnJv?=
 =?utf-8?B?Mjg1UVpzdExOZVQ5My85U0VwbUN2dlNkMktISEVlN011WWtNaVQ4YTRHMHhk?=
 =?utf-8?B?RXgxaWtPbnplSHp2aG43UGR0RWpyRERGT29IUVFQNTNKVGN1VGhOMUJhZTdH?=
 =?utf-8?B?QVMrUzZrR3Q3WEgvTUlXNHhWSTNsRENoWmdtYnhQcVRhakk3b0ZOSFIyenhy?=
 =?utf-8?B?dFFBZ1BoWE5kTzFYc2c2amdQWDRGTVd1eEtXSnVoeVN3bzhidklOa0V0SmZo?=
 =?utf-8?B?SDdOcVZQRUJZSU0yTVZjTU1vNU1qY0Fvb2owS2tvWDlMQ0lCMWJpTTFaeFJO?=
 =?utf-8?B?MFpoc2c1cGdPbjNnZ3FlZUh3cEJsNkRhRlZkQjNrcnBNZGp0NHVzNVYwNWNw?=
 =?utf-8?B?cGo5QXBobUZKS283SU1DZ0hOaHliTzRRMERyL01IeDYzei93KzBSNXRnb0hi?=
 =?utf-8?B?U1JZTEdRYXFsTmN0ZDdqOUtpTGpSNmNicHV1N09vbVhpcktnSHJPR0w3M3RT?=
 =?utf-8?B?WktzS0RiU3BHakYxT29JUHdtK21raGNLKy93YWV1Nkx6d2IyRE5DU1dwbnZN?=
 =?utf-8?B?TzdZeW1mcFBVZkNNbC9OSTlOaUViWTQ1WXgxdk9qbFNVbUlVT2tNVUJxVi9w?=
 =?utf-8?B?TWlQVHpqNE80d2h5RlFXUEJhVGJSWlhUSFVJRCtXdHNBaFZHNlgrb0ZBZGVQ?=
 =?utf-8?B?UUFHQkpzZ1B3SktnZ0pleHFoRE1JTkxwU1JMR2ZGdFliYjgzK3ltZWpFRFNP?=
 =?utf-8?B?TWh1T3N4LzY3RE9oTWh0bWlXS2s3VGdWZXMxaW9uNDVENmMwMUM3Q3Q1NnR1?=
 =?utf-8?B?ZXJUS2s5TFRNT1ZLbW10RkU3YlBhb1dxd3kyaGVIbGpLSFp1MzAwOG9tVG9v?=
 =?utf-8?B?aXRTd1lyazJlZzZ0WGFFdStkMWoyVkV5YkZKZnVGWXFKZU1SL1AvSlkxcFk5?=
 =?utf-8?B?STVNMnFWOVloSTByTTB2cUp6Vm4ySFFUcEZwZFF6c3JUZWFEVXFHZUJHVkJS?=
 =?utf-8?B?MzVpblQxOXNUVWNFRTBuaXNmVjVGVTFZQmg5Q0kvUjRVL2l1TEg4aHJVREhv?=
 =?utf-8?B?a2JMUDR3bUpwVU1qM2NHUWJJRnE1aFVlY1R3UG50SzdCc3B6ZTdtOThVcG9q?=
 =?utf-8?B?ekVKVUZXYVhyMENwWHJiUW50QWlCeGZURDBCeFBNUEZZbE0vM2ZzM280RlpT?=
 =?utf-8?B?ZVp1QTVHQzBvK1pJbFBzYUIrb0RpUDZhVDVZNmZZMTI5OHM0RFBXNGROQ3pt?=
 =?utf-8?B?ZlFmaFB2VDNPRjdFSkNERFVDVmwrNXVBd2NoQXRGbWc0eXNBYzBQN1ZTVzhr?=
 =?utf-8?B?ZnplekpBeFJra0Y0SGN6d1oxZDBTVVdjNS82QzQ5d2l0UDJHdlNmMkN0T2pt?=
 =?utf-8?B?V2V6K3llN1cyZGZYZTJadEFyTVNONUxlUGZvMnU3bG5nNHlPY0NRaFJnS2RU?=
 =?utf-8?B?OEhzWUlxbmVPMjhOblZ0eWxPWWwza0pNZFJjVzVQRFZjZlJMME1zVGNKL3h1?=
 =?utf-8?B?eklJdk5DcTQxamZqN3VZa1IvV25JS3RucHd1OVVLYjJTUHpwaHFjN3c3K1lk?=
 =?utf-8?B?ZkdNajliUUJIdlVVbjhDYjluOElXK3N3UFBtRWZ5MjlyaFpFcUEyNGtHTUlq?=
 =?utf-8?B?Zy82empHNGxCM3p0cVFNRXoxSm9IUENoNFZBcU1yY1YrR3JuMnVLcVR0ejVQ?=
 =?utf-8?B?QWJOSnFrQXBOcnFycEZheVRSRGM5R2VXZHM0c1h2OWVFTzVzSngvdUQ2K1da?=
 =?utf-8?Q?56FQ=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fe915cce-9ea6-426a-7908-08d9b2b8c09d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 21:48:02.6487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faJvIfjAE9ZZrnckAcf0CPcS/fQ0eLlT+Gmcl9epe1XucFULE6uEsd93X6NUK9Px
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2392
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-11-28 20:26, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> There is nothing directly using of specific interfces in this driver,

interfaces

> so lets not include the headers.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Rosin <peda@axentia.se>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

