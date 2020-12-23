Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EEE2E2279
	for <lists+linux-iio@lfdr.de>; Wed, 23 Dec 2020 23:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgLWWkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Dec 2020 17:40:07 -0500
Received: from mail-mw2nam12on2111.outbound.protection.outlook.com ([40.107.244.111]:31201
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbgLWWkH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 23 Dec 2020 17:40:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klN5VjuG2+ILnwyUNx/WYjzhQh18CNZOm1zTlMiqr6QLeRNePbLn9bVa4srx06yndOiEnGZgHxAAtyi+wr3eV3rXym6+rKc5NbMSjsh80yaBMpwX0Lq3gJ3bRObnBCvMfJENBJIVICetedxeJKHx7m53AYh+sFjjqAD1fUCUUvkaqPFQhgsn6LM0RyTmPzxLt2DnkRYLLPIhIWruuACT3OVDCfVbb8uq3gePWlde0VV5VDK/gin9iSLdooMkQ+HAsXBLyC4W5ACs1lhvWZp2Ju1ZZyznlnoP6dZMBxjpZcAcxI35Jf5CU5tad12y7roYgt4KemhDoseoBWBTOdb8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwsI52sbyULxJXj44fKvb8/C/Kcfbjl8E1UXo8NtnlQ=;
 b=QrAI1Je94/uiXhmWRLBDSaOopmUlUBZjoDXRcqgujoIOKYVgtPaI2qmNjto0h6yG5ZQuoongAIsE9z36Z2jF9Yx1ozs+T/vuw/5THNT2hdlgsZ7M/jD6MjJK5HSlIzuo3kRtgsTKBnSztfMBb/qA/LkPl71JUC6JDQVzD1mZfyGtyRA2jhWZVnY0eI5poXiuyyEWsW7roCDARMGRyCUCFkMY2gKTMGlNnt6cumoOs0m9U7QjbIh2tVYOFml0TyAvTsYA6pytTDIfWejNryS8m92NP/hLPVvGi5ONhfi0Aj+PDiAO8bqwyvLhBLHOTHWTVzdok4K73L4Lqv0AhzsWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=licor.com; dmarc=pass action=none header.from=licor.com;
 dkim=pass header.d=licor.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=licor.onmicrosoft.com;
 s=selector2-licor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwsI52sbyULxJXj44fKvb8/C/Kcfbjl8E1UXo8NtnlQ=;
 b=RrvRw9votuNhRYKL6iaeqMnoYdSVKBW2FYNbMSpid3zBxbShfPKUZXXn5hvqMUf2ECGTISSO0cd9BJj8cPRwlTMLqbvWY9zhfxq3RkRPtAF5yrjcxAfx4scIOMHToVt5+geos750WvPeH4o1tfad/LnDrvD+KyXlBt7z2qoVOYs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=licor.com;
Received: from SN6PR08MB5565.namprd08.prod.outlook.com (2603:10b6:805:100::20)
 by SA2PR08MB6586.namprd08.prod.outlook.com (2603:10b6:806:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Wed, 23 Dec
 2020 22:39:14 +0000
Received: from SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041]) by SN6PR08MB5565.namprd08.prod.outlook.com
 ([fe80::d10:7b1a:5c08:a041%6]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 22:39:14 +0000
Subject: Re: [PATCH] hwmon: (ntc_thermistor): try reading processed
To:     Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201219224143.686074-1-linus.walleij@linaro.org>
 <6d339a6c-6f8c-4a5e-718b-c90a9fbb8c01@roeck-us.net>
 <CACRpkdZTVAoDbbJqTJbxv1ZDyAMsB_h9TAdKKbxqBYGp4-b_jg@mail.gmail.com>
From:   Chris Lesiak <chris.lesiak@licor.com>
Message-ID: <16895f93-d717-9213-9ed2-21531673d41b@licor.com>
Date:   Wed, 23 Dec 2020 16:39:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CACRpkdZTVAoDbbJqTJbxv1ZDyAMsB_h9TAdKKbxqBYGp4-b_jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2607:da00:300:7::2]
X-ClientProxiedBy: CH2PR18CA0004.namprd18.prod.outlook.com
 (2603:10b6:610:4f::14) To SN6PR08MB5565.namprd08.prod.outlook.com
 (2603:10b6:805:100::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bee.licor.com (2607:da00:300:7::2) by CH2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:610:4f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 22:39:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 722c295f-3d19-4e57-44ba-08d8a793932f
X-MS-TrafficTypeDiagnostic: SA2PR08MB6586:
X-Microsoft-Antispam-PRVS: <SA2PR08MB65867226E194CF99113B52EA9ADE0@SA2PR08MB6586.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6e/syNmSPrtNTfR1KEFQXKKvRHZJtu7sMm34FISmYX9F+DY0BLBsYIjLuyv4bFrA6HF9+4krMX5hnjh01EuPOWT1awx4/6U4uN2wloR1IhGPV+eN7QG+N2upH+MKVkaFXiWEYsylgyn4W3xxV7rO1xZBjxNBkYDUQ1rrAFHEfqY2G7yaNMTMCSWn5dNY7iVia0GjgXbMc3B+QQKwCUV9W6AUdVmV4Rw0jvJ8jfvm4FCjGCLbVCztzoViGTYeTU8yUqTsZ09nd4W5HwwMAo5fK/EHSUisMKG0Vw5Ju8vgMLAtm70w/LC0kZ03QL3b7hnvCIiyXGhRj982W5f26/iZqu7qAy4F0oZz2/cDCHWL75ChHEVe/bCh4rp/ggoQSpQoYk/YmfHw0k/N87xq1UKfG38nouJb/EMQRktl9vhLmS3PAjKSK+P4mi7YdqT+p/k04qjFQOkPJMnISuacZFbUxfcLyIZv1KUoJ6iI+RYiw0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB5565.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39850400004)(36756003)(110136005)(6486002)(8676002)(186003)(16526019)(31686004)(2906002)(31696002)(86362001)(8936002)(4326008)(66476007)(53546011)(7696005)(52116002)(5660300002)(66556008)(44832011)(316002)(66946007)(54906003)(2616005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V04vL2dmQ0RFNUt2YllZcmFuZThRRmZMelZsNWJJK09tdUVpYzZOY0NuV01y?=
 =?utf-8?B?cm81VlZ3NHM3VnpuOG5YODZzd0tYUnIxR2ZXOXZBZkR6eU5HckUvSzhjRStN?=
 =?utf-8?B?VEl0blVzdWdpM1lBdmdaODhnWjd4Rld4Z0NnODR5d0hPNldCWU9xOFVUbEFr?=
 =?utf-8?B?a1owVkdIdVZLY3BEZlNHWlNXNkV4cVNNbG5UcUhHWUJXR2MwWnlSY2lYaGwz?=
 =?utf-8?B?eEdmM0xxL1N0bkZkRXRpNDVZT1c4TU0zUVBobGlBQjdpZUt4bFFXZFg2SXUy?=
 =?utf-8?B?dk5SRmQ0SUVjWG5zVERQMTJRcUJveVluVk5UYjJHL0lyQThEcm55UjNqK2Vi?=
 =?utf-8?B?VkZXVTQ4TE42VGI0VlZ2WWFiRWxxMGYvRzQ0M3ppVnJCek1yZjk2TFlIcWlv?=
 =?utf-8?B?eEJrMkJJL0lNV0hmY0JYQVZBNUdUa0VpWEt4S0J6TVlGUTZwV0M4L3RTTDJZ?=
 =?utf-8?B?TUhUWjhRVjdIOEV0UUdlcExCNzB6bnJ0VWEwMy9FZGRXS3RYTkNsMS9hS1Ji?=
 =?utf-8?B?eW83TzljVjNQbU00NG1DZHplYVd2TTRrZTBtZitLVDM4cUpkQTFnZ09ZeTk1?=
 =?utf-8?B?QnFIWkl6Z1NDTUZhNk10WFBYUmZxa3c3OWNDZGcvL2FEMzVNUVh6MnlSRTNv?=
 =?utf-8?B?bVJRQXBoTVdhNU1laC9rN3VUSFNkaENoUlpRRkh1a3ZoUUZCN1B3bDl2cGc4?=
 =?utf-8?B?Z3J4S3F4SmVOYWsxOExPZEpXK1FFYjVpdmJ1bVhsWDZGNHZ6VS9uVU8vU2pX?=
 =?utf-8?B?VUdmUDl2emI4cjV3V1FWRmpvUmpZM0pBMUVyOWF1MFhDcDhhWmxoVDkxR3RU?=
 =?utf-8?B?dUt4eFhpajRlVm9XRHJMNGl6NWpFNEk5d1h2UzRJRUxKYnZmMmQwYnU4MkFM?=
 =?utf-8?B?ZWxhOEEycEVvVUhTVHk0L0xHdWFaMWZhbWlRN1E4M3NXNHczcytYcGJqcFN5?=
 =?utf-8?B?aXhRL29WajZEdUk5OHdVZnVqc24xdzdRMXhDWEVFWjR3RUhBb3FVbUZiMjMz?=
 =?utf-8?B?VkdLZnE5dTd3bmpqV2ZJdm5yeGpGUUpQVHF2Y08zZWM2NENPRElBeG1VYkd1?=
 =?utf-8?B?UFR0eTJjaU1GOTMya1R6UXBQcHBTdTVOOFBCT253ZTBYdU4zTWVQNEY2bkVK?=
 =?utf-8?B?UVhsU0hNUWtQb28rRzdEQ2VsZ1lHU2hvVGU0dHgySXlWdG5sVTkrdUgwY2Ra?=
 =?utf-8?B?UDl2ZGVjVHBzNU9FQml6V2twU1UxbWVTcHUwblBBMTRmck5zVGUyalk2V3Vh?=
 =?utf-8?B?WnE1VnAwV0t1VkxBakpRWWtSbHNQSjVSQVlCRm5VK2xlZkZqT25sYk9aWE9r?=
 =?utf-8?Q?7Q3tg0djgThQxdkYEgBbRZGft5x2t3MTXn?=
X-OriginatorOrg: licor.com
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB5565.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 22:39:14.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48c70abd-da5a-4c6c-86cb-5e003ca01574
X-MS-Exchange-CrossTenant-Network-Message-Id: 722c295f-3d19-4e57-44ba-08d8a793932f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+z9WlNcVBDikD1pcw1ySwLwFRv8qdct3g/t3zUX2OIkpgS7K35ZPIygv28tco5YI16No5p7e3UsuKUkzenjeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR08MB6586
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

First, let me apologize if some of you may have received an
earlier version as HTML.

I forgot that I was in my web email client.


On 12/23/20 3:08 PM, Linus Walleij wrote:
> Then commit 0315253b19bbc63eedad2f6125c21e280c76e29b
> "hwmon: (ntc_thermistor) fix iio raw to microvolts conversion"
> calls iio_convert_raw_to_processed() to get around the 12
> bit assumption, instead adding a 1000x scale assumption
> on the value passed in from the raw read. This just looks
> wrong, why would it be 1000 and not 1 like the IIO core does
> when we call iio_read_channel_processed()? It looks like it is
> actually compensating for a bug in the ADC returning
> the wrong scale: the author may have used a buggy ADC
> driver return a scaling to volts instead of millivolts and then this
> was a trial-and-error solution to that bug in the ADC
> driver.
>
> In that case it would be nice to know which ADC driver,
> so we can fix it! I suspect maybe an out-of-tree ADC?

I'm the author ofcommit 0315253b19bbc63eedad2f6125c21e280c76e29b
"hwmon: (ntc_thermistor) fix iio raw to microvolts conversion".

The 1000X scaling was not to get around a bad ADC driver that returns
volts instead of millivolts; it was to convert millivolts to microvolts.
The function ntc_adc_iio_read needs to return microvolts.

