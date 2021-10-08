Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D3427406
	for <lists+linux-iio@lfdr.de>; Sat,  9 Oct 2021 01:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbhJHXL6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 19:11:58 -0400
Received: from mail-eopbgr20132.outbound.protection.outlook.com ([40.107.2.132]:44005
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231876AbhJHXL5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 19:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsL4SuV4DaS4BNQlRzzcCu+58lS31vP6JsNnyqfbnuYivlZiH7UGJt0uNgGtq48O1UjH/o87swM9A++cBJi4wyYTI3y+UHXS3ZrrlcRbTs+vDExGYeCO70Sn6xhnYhBpkNXesP1QlRnP63W523flRZ4ASaubJiL/09wwT6rT8BiBnBI/OsW+Vm76jFpi/n+2up7mm9DAnOzpH1PDeRyrmzablzmbJvd4SJbhKTOM5J/sPgTOz1crTVsk88CoW0W3AmqLJtPRo+YdgDp1WquvsCwgMLFHWipB/Ca2dnt2A+cIckwmg/1SB7rHhSBNCb32V6Ry4vYcOVLkwNrAK4MDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK5DWINpXLurBvWaNdifKHimua6khbTmzffvXtWRsng=;
 b=NLeT3FMu5D1p1I52yFVjFQaQdFNUZusLS2qlAyjoIgO08BtGwekAojlIS+ralkB791RItXlLZWU4BX+DVyRg3p7pDg61y0116l/1CGrElTQTF9V/aidJtObHiHxKDObfsrMc6CI0JirYg23gUSI/h4Co2oMRTanBfm4ZiBZcqbvRLJ1Mnyy0RY8JHMBSnhrToPVmjVD7NiQtPqte3FJQDF11eVuC003b50K7X/te49YFVm7RmdeuMIrWV/mU1DafO9bwdrjgsrPDbM4o4bK06QH10wSh1+G5j3GuQZMtDzBn5Obi6c945ZpdP6Ep1oArShHT9B39xdG6LzMwdCIYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK5DWINpXLurBvWaNdifKHimua6khbTmzffvXtWRsng=;
 b=cOQw1lncBYKhzMfKvo/qTnIejQ/+Zb1uzOWqyXTpoCRuQd90g3k/Asi6iBRdbnv0aJgPVLkRAHdx7xlrqdfDS5bpguxjxZzVOelyDvbUdhN1xN8+Jq7oLrAk9xJymMPbNt0tNq6R+Ktvhdlb0Hu7KMUae9ZRaKD/R/zEKNPII50=
Authentication-Results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4347.eurprd02.prod.outlook.com (2603:10a6:10:4b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Fri, 8 Oct
 2021 23:09:59 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 23:09:59 +0000
Message-ID: <7c14fabc-8811-5875-15a0-67884e2da78d@axentia.se>
Date:   Sat, 9 Oct 2021 01:09:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 0/3] Add settle time support to iio-mux
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     kernel@axis.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211007134641.13417-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0148.eurprd05.prod.outlook.com
 (2603:10a6:7:28::35) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1PR05CA0148.eurprd05.prod.outlook.com (2603:10a6:7:28::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 8 Oct 2021 23:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b08e5bb-9a7d-4204-40e9-08d98ab0c007
X-MS-TrafficTypeDiagnostic: DB7PR02MB4347:
X-Microsoft-Antispam-PRVS: <DB7PR02MB434779E49241A26938803B57BCB29@DB7PR02MB4347.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtgkboulxUu4+WGjgWujgvD8/4fvwrnkWZ8CJJl2X6H4xaDJrkYYlR83hLiokdpuzLh3Veor0zIgrvryhRT1feGu4rk6X7DThUGJtwtJlRoqF45LTL5mbEGi8uX2Ki5Jpn3przY0uqpB3qwscb+qRHg28eHqORnPMgPQRYfhSdZW/ZPV3/Bj0yD7hfTwTqnLR89xn2Hhh1di4j1x4TU1xVstJtG9qW3vJrUaBGM45YU+ZQp0wfEgcyFNzNEYcD1cW3w74S8LeNdCEi26StPhnD5Gehlh6Fb0eqJnqdjK4Gpi1ai1DPBCLp2WHe6FqoH5nWFlCHoII38A/AmUF5t8jayYjAlMpVLyzSxybW82kQcEjpMkSdTNd2xFUzKYoBtE37lG8mUtM7FF5+MwODRXVPqoCuej2NMK7Snm9fB98qN8Y7d1G2d4+AF7YJe4oCD8EMJMqk1mSAtzKmeEHYnq7rG+op5pLKT6rteiwzLn6dPn+fxWvox29iF/g00QNG6pc5uLrnYzT0+xAJBeG/ui724YpINHBCU0fTiZq++NglEv0VDAE3TUq4jfkMIHRA+b1nK39Oe8225lQC/50sLyh47qK+yKFi611/rYJrSk9BZ039yzRVt8ZrHuuT8c8IB9NbYCLdlEQ8xyN5PjwuGhhdDhdFdzwKh3igbTF0R6P5h/z7UVvVA1UfbWx7XVPyLfbUlNAXwDKhGQoVPxhCVitPWOk49xQTglN5whB3te/KWXGT8fcL9qOEWM7Ck2CP0LH2F37bx5z9RyOFBpimsMPgrPqbXRZQFxFR5N56fg8Sh3LRN86YU/ie+GuMyd02tdavv0shMPw/3bU9oBf5ZAVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39840400004)(396003)(366004)(16576012)(316002)(956004)(2616005)(53546011)(2906002)(66476007)(66556008)(31686004)(36756003)(5660300002)(86362001)(31696002)(83380400001)(66946007)(8676002)(966005)(4326008)(8936002)(36916002)(186003)(38100700002)(508600001)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVxMGx2THVWNFdqSTM3bFRzdEtLemNPeUVLMFZnMDhpREtGZ2hmb0dBODJv?=
 =?utf-8?B?dlFCSlVsdjJmTDNuTmtsb3VibURHTUcyVVoySnlFa2FBRGovYzFYQStwM2hl?=
 =?utf-8?B?WG04b3hka2E3OSszMWxtaHVZNmlickJKMEdwbUdxNTBMK1lGb3luN3Z2eTVz?=
 =?utf-8?B?ZzA5TlJuaUF1a2JDVUUyYTJ0NEZMTVVlRC9CMlpZN3VXa3pqRXpZM2lzV2VY?=
 =?utf-8?B?Y045SFdKV0JHSzVPdTFYRHp4eTI0WTA0ZXZ1eWZWSzRTLzY3OTd2aFI1OWtV?=
 =?utf-8?B?SUh5QnhvanVVWDlxVWhPemR5T05IS2xtNnNTM200VzRabXNMNnJhbmFMbXpM?=
 =?utf-8?B?R013cUZYSXpWeHg0cFlvcVFsVEx6bXpJMWljQURkdFg1S2p1OHYwUFVicmdN?=
 =?utf-8?B?UzM1ZmxReDk4NVRmdG43U3VTeElNeDNQanJmUWlGbDJJMTFNQXFKWkw3U1FP?=
 =?utf-8?B?TjhHMjI4YXo3Z3NZTGNVcFRxMjJha3dEanZ3b1JpZmhhdGJmV29IbmladWJz?=
 =?utf-8?B?RDcyRzRiVXpwcm1tUXhRS1diTVdoZXEvNlYxWVE5R1QvT083cnhTNlJYOWE1?=
 =?utf-8?B?aEJSQkpSNHBmbzhyYVJLalRDTEhWOVdYZnU1WWlGV3l4cnlwbVkyVkw1N0NH?=
 =?utf-8?B?MlNSS0lEYzYzQU9XNnAwWkJNMHBsTFpLUUdsS2U2ajY5M09KUnRLV0l5UnBC?=
 =?utf-8?B?cUNEZWdoSjhaRGdpdDExeUIvanM2UExpSnBxb2VoNDJJUFdPUUtUc2kwOUZY?=
 =?utf-8?B?SWZRSGVFdkU5ZW5mY282WFpmY2pLRmdXUnRVckI0YkZmOWZnSzBiRUI1TlI1?=
 =?utf-8?B?RWRTNlVZQmZQdnB6WGptS005WUZWQ1Bwb1Z2eUJ0RkV3KzNETXh5NDAzdnla?=
 =?utf-8?B?THBnZ3JMc3JNN0dnSkx0a3VQU3lMVVh2ZDZvNklKQkg1V3dwNXNPRTFpSU9B?=
 =?utf-8?B?azRmd0JQQlBvUi9LR0I3K3ExR09POG9FL3BESC8wMzRocm13TlJkci83OWZi?=
 =?utf-8?B?M0xNaGFYWEREcFd5bmtZZnp6dW8vZjcybFdiWTJTSUNrdXNFOWcxVk1oUEZU?=
 =?utf-8?B?ak5hM0h5M0IxSGJHVHRya0tYSUJLYWV1a3QwSjF1TTNmVVdyNCtVeGROaUp5?=
 =?utf-8?B?VHliTW9BMkZJaVJMRjh5aTVqMHdla0hjSnRXTkdlaTR3MkFkM1gzU2JWTHNy?=
 =?utf-8?B?K1krZWNSZ3c3d2J3SDZiTTV1UHVKUnJVTkZOL09kTHNKSGU5WDZmekZJREJR?=
 =?utf-8?B?dDZRTnZ6WVdqYlJwa1hWc2pEakJySVhuSkpCbGVSc1VjZ2ZZc21VNEJobkwr?=
 =?utf-8?B?QllwV1c0S1prY2pidm01V3JobDVndlR2SWQzV0o1blJsL2JBaTRKUmh5eWtj?=
 =?utf-8?B?eXRka1pndUQ5Y3p2Yis2NEpmUmZtemdJZEhwV3VmSG43aFl3UlRoK2MyUjd2?=
 =?utf-8?B?a3RncS8yTjlMSm43ZnNMZmVYVHZJUFlBdnpsSjUwSXUvWnNWMi9WZXRYcE9i?=
 =?utf-8?B?UW1jb1Bza244b1VDVU1zc2EyaWRYRVpLc015S3VXUG5KbENmVE9LQ0Z0VzJy?=
 =?utf-8?B?QUtWRWFML0RONjVJcWFmUTBIM3lCK0IyK2dXZlJwaFk1eWx1Z3hZWkNBeTN4?=
 =?utf-8?B?MTFUT00rcEdtTXVxcUt0U3d4YUVXZUpCOHFuRkZZODFFR0R6SVpGUUJ5d0cr?=
 =?utf-8?B?MW5yTU01TGtDRE15WXcwZ3lpTWhsdC9BbElLZ3oxZ2ZhNHl3cmxKc3BMZnFN?=
 =?utf-8?Q?h+S/u7Edt6sKsb0F2fo1aAk4uiCyWSVc3wCGBkP?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b08e5bb-9a7d-4204-40e9-08d98ab0c007
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 23:09:59.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EncLeFwRpTtyj7lg8aJi23+6Lf4R9P9kKxGZYeVJ4mdU9EM9sFQxbCO9X9dp34+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4347
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Vincent!

On 2021-10-07 15:46, Vincent Whitchurch wrote:
> On one of our boards we use gpio-mux with iio-mux to read voltages using an ADC
> from a few different channels, and on this board the input voltage needs some
> time to stabilize after a switch of the mux.
> 
> This series add devicetree and driver support for this kind of hardware which
> requries a settle time after muxing.
> 
> v1 -> v2:
> - Move property support to iio-mux and delay handling to mux core as suggested
>   by Peter.
> 
> v1: https://lore.kernel.org/all/20211004153640.20650-1-vincent.whitchurch@axis.com/
> 
> Vincent Whitchurch (3):
>   mux: add support for delay after muxing
>   dt-bindings: iio: io-channel-mux: Add property for settle time
>   iio: multiplexer: iio-mux: Support settle-time-us property
> 
>  .../iio/multiplexer/io-channel-mux.yaml       |  5 +++
>  drivers/iio/multiplexer/iio-mux.c             |  7 +++-
>  drivers/mux/core.c                            | 36 ++++++++++++++++---
>  include/linux/mux/consumer.h                  | 23 +++++++++---
>  include/linux/mux/driver.h                    |  4 +++
>  5 files changed, 65 insertions(+), 10 deletions(-)
> 

This looks really nice, thank you! The only question I see is if it should
go via my (virtually unused) mux tree or via the iio tree. Yes, the meat is
in mux/core.c, but I'm happy to just ack these patches and have Jonathan
handle them. But, I'm also fine with handling it in the mux tree (but I'm
getting old and forgetful, and it's been so many moons that I need to
re-learn the steps).

Jonathan, you or me? If you, you can add:

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
