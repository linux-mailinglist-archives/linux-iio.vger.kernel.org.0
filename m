Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEFE3957A6
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 10:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhEaJAJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 05:00:09 -0400
Received: from mail-am6eur05on2116.outbound.protection.outlook.com ([40.107.22.116]:58079
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230315AbhEaJAI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 05:00:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBqOgyq80fzZRjU75wUhqd/fIRffs7nVyvhG5/dOKqRFwChOgLx6WforBI82P837KNSMnDrWuoW9Yx5B++Qi7/sSZSHBiZEEvoECYZEhMVAHfFJypKP04K7lptdIUO5tGzJS/IYu/MoMUM9Az5kNcr7swpB+YMi6TVbadykYTfvqeF15GJMfteduDF4rTp7yyWnPCcuN5sqyDoKFXFgodnbOXBYG6T7sazx642cC74+R43D8FZJArybVvkZNkIzTFzkoFazmM7h+5Cmy/4a2fyitOH5Q9y1WK478XPJceYa+ZGvYWkMn+ulDjlZPDHKo3NCcVVXRun/aIC2boAo2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvPEIjTBvhLOVfibOhfmDQjyR7hCXJe4+6e8Q97Gndk=;
 b=iMOFSI00ybvj7QfmGWoXHTMuyH2kahOnRyj/+hy+yOwsu3TW70uwlqJztEKsu7pm95E/hLrrJs48I0hN16crUGZyHl2a3/7EH/ISOKxCZUNNmXtvBgouxw8YBd3KqyRSw4qZrBSyn4rE0Qn6hKzpOY6IidP6ScgkUJvydu6yRasdxVZPdO8hi6tDOp78Z2r/JE0k5L2V4o+uIUxBQCRT+Q2cmiFrZipgsWkzRczdJwUZQ5w8FRBCvqHg/q6wyjQjz9TtjXWGTHAsRTxaxbUmYbHfCdkd6rG+xdZA2b/ZGaB4+ofCjnR/knc9SYFnwrldDDrNlR2QrtcbaE3lBXdtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvPEIjTBvhLOVfibOhfmDQjyR7hCXJe4+6e8Q97Gndk=;
 b=Ol5b+EvO0HfkZP3hLwUdHvC3sUxFY7Nmk59UHwlK/xMWP3vF8JCQu0h0Lt1qYj+djTtdQFnwquO9oWZyBmWzmQmJNvj55mhWN61aU/XVw09iyvrmZXUkFg3rcb+EQdG77h9NNljiNuRKzIe2mSM8SXhz61Sjf5tDitcv/t773CQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2166.eurprd02.prod.outlook.com (2603:10a6:4:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Mon, 31 May
 2021 08:58:26 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 08:58:26 +0000
Subject: Re: [PATCH v1 8/9] dt-bindings: iio: afe: add binding for
 temperature-sense-current
From:   Peter Rosin <peda@axentia.se>
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-9-liambeguin@gmail.com>
 <9f38ad0a-0a08-458d-b721-f4d424cecc6d@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <fe79916e-8ea8-5059-fd68-0e0ec621a2e1@axentia.se>
Date:   Mon, 31 May 2021 10:58:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <9f38ad0a-0a08-458d-b721-f4d424cecc6d@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AM6PR04CA0022.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::35) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6PR04CA0022.eurprd04.prod.outlook.com (2603:10a6:20b:92::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 08:58:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9746284c-2230-4e33-ac08-08d924124081
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2166:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB21665CB7D1DFB4A7DB3F8CBFBC3F9@DB6PR0201MB2166.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBcSrpeyw+XXdvadHMYGOHR1jSZ5bQGHOz/Ghx1MDR/wfwOt7wEoX5oW4pLAcmCOL6CNRsb5d8x04y/h0vPt8+N40lZuXZIpeXqe5IjQl8XAu4qAlXHZpOfhFnjwxC4eS0PYsYClBVjcTUIDCj8ypkxlWtOH85yPa9kWZ+wuFmXEnDI/jLSiazN9zWcVUpLdz5bsxuGf+fMmRgGxDmwJFkKTYR6MhQYafFDVyPUodYdL5DZEDpcu5CShOwF0LyK9+oaJOwXUlGXYU4AJjtPXTzBYXPV+k1jVM4mxtwOJqDz56uZYRX5wqk2MPCnNpKh2IHbJDE3LxWdSCmVOD6ko6Tw6RM5o7qnoRbc/iqTftxsO3I6KIyaMVhuaehakVKLCedBDNinrJdjkRxH13k15JV+Gunm4yaYuYExyE3fLwp+2o/ZCrpg3vEdKs0YSEtcyX+XkI2pY5iChdhV9vmvKzxXc+WqC4Nm4GQCC//v8j9EULg0jVVTUGgzncwfyPF/dwJbAT0EDo+qjthPLW1QEbqujteNnN9UD+8cZlbuXaP/syIcjREP3X2aaCTvBT+psQtib5TC7ze4DK1VU6ogzWurAQBL826hcfid2yCTN+6Nh9gAcHatgI46O8b/uMsmF2wOX1avQMaQDZiss5nV+OH0Dczu5TlXb/siQXL3J6hswlODQtEsBOWADvf+wquVc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39840400004)(366004)(396003)(346002)(86362001)(8676002)(31686004)(4744005)(478600001)(4326008)(2906002)(16576012)(53546011)(31696002)(8936002)(316002)(2616005)(956004)(36756003)(16526019)(26005)(186003)(5660300002)(66476007)(36916002)(6486002)(38100700002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1NFRkRtWWZxTW5TZ3dVS0QzUW9HZXlOSkI1TVAwaGJaa0hkeUNBVWtRN09n?=
 =?utf-8?B?RlYweWdyNFViR1NoMGZWWktMNjNib1hrZTF3aGFVVm51NmZiajNvRnZLZENC?=
 =?utf-8?B?Zms0TlpJUXNHZGk5SC9XU1gvcFZieEFKdlpZanhJY3VMaHpOcHNSamR6SDRY?=
 =?utf-8?B?ZXRCVGlNVE1pTVZNZklncHEzL1dTN09sZHNXOGRQWEF0NHVVblVmM3Nrbmgv?=
 =?utf-8?B?R2pvcDM1YUtGc0F5bUY0R08rMWczRWs4dm9CZmpPd3g3T1RQSjcydThWK0dJ?=
 =?utf-8?B?UGRvSEZXMjBUNWhKMzBRQkhINUd4a2FwMFJtYTg2cUxkYXlsNk4vNEdqdUxr?=
 =?utf-8?B?a0U0QnlZRUtQL2NNc1VSTG8xZGQ4bCtwT3pVL2I0MEg0blJjWlpEZDd1U1lq?=
 =?utf-8?B?c1I3UzJhOHNwTnRVS215Y2x4UTc3Y09WNE9Ubk5DaUZ2SGh2UllnWGpDVDQ3?=
 =?utf-8?B?SUdGeU5VNnBDVGd0L0Fqb3Yva2t0Q1pJMCsxbVRHRU50SmRtZTFtK2Z0UVRP?=
 =?utf-8?B?NFpxY2txaGhkdzlpZU9Gai8rV0YzMDB6SWdmL0J2aWl6L3RFcTVsZTNINUNZ?=
 =?utf-8?B?WnBReDlxNjFNOWZGVmhBRzFWNUllMWdQWTFrNHNRWkpKU3hHR0thOVo0WEkz?=
 =?utf-8?B?ZG12SXh6dzJkMkJQU1RGN3oyNVFmK1FMMjhIa3RWSERac0RveGhKK25iNi9O?=
 =?utf-8?B?RExlOGlkamgveXFqaUpGMXQwR0lEU0ppb0Vtamc5dzNjaWY3MFZZWGEwZisz?=
 =?utf-8?B?WnZpT0JkUjU1TS9rRS9MUXB4blMrK05ndzJSL0pOQ1ZTa0ZCM1ZlZzBmbjNZ?=
 =?utf-8?B?cUlNdHliZmxVUTY4TktuYzJPcSt2Sml2UktXdHZZTkhCWEU0NDlhOEN5MVFU?=
 =?utf-8?B?dmtwTWUrSWxCeFd2WEdDVHgwYTZ4UGlpRGNSVHFUdk1yTC9OVzVlcXMzNWk1?=
 =?utf-8?B?bkF3TUsrWkhaNGZ2WjRzLzhxdmI1SFgzM0hhQ0hiRElvaTBINEFWTWFhWE9M?=
 =?utf-8?B?amh3RHY0ZEhwOGJrZWFmSkp0eFF3L3RwSU1kdlVnYTFzdFBHSkpQTFc2THNm?=
 =?utf-8?B?K0ZrRzZ6eXZIeE1WWTFJM3Vvb3ROaXQ3K3hpOEFvQjYyYlJZTDdrU2pvb2xz?=
 =?utf-8?B?WDYvZEFvTU1CaGJKODh1MDVBTG4wTkFiYm1IZ3NwR2JyUjkzYlZ3bFRvL0VY?=
 =?utf-8?B?elB0Z3p0RXZYQTR2bmFtM2xRRGFsSENzYlVWUUlLeWtraHNweDhHU29hTFVX?=
 =?utf-8?B?b1RDa1dMYXJwWkRuWGJURnJFUDFaYlFPZHRXdTRON0RRZGpEL0hrb2pGTHdq?=
 =?utf-8?Q?bVtS+xhMbt?=
X-MS-Exchange-AntiSpam-MessageData-1: +8Nrdte3TNvIxEm7Z8qudaDOHG0P3SWN4lD1HmF+yZYVUson1ACVXHwFaY5JTrW8bgY0WefGCu8jUFnD+GMg1t6B/+nBQsYWsEsGMJB/ftdAUmSBRK7FDce/zJfCi9UtEWtbj44FO9D4RZvzcN9XXreXSW5/DQHBc8dX03rZ6XfKhTs2gvNa2dEGm/MhzOhRfnP4VYzvCc49Jq+IHPYjhkwjlt9a0/WndicV9kBdoVErwKupemXzwPaKb/cQr6PwYYHh+n5ZfpwQbP0I3NDz5wg+HaD6ooXBuHE+Vk3+YDPfDfjIe9EVtjIiY7x6zN4W9aJ471MBXCAe6+0XEtcUGD4z
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9746284c-2230-4e33-ac08-08d924124081
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 08:58:26.0916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsG5LmwH4dXOHcp9RKRXelw0toKFDHstiIoHVuIE7qZnDIASb0uRBgUZbLcaK6Og
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2166
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2021-05-31 09:28, Peter Rosin wrote:
>> +  use-kelvin-scale:
>> +    type: boolean
>> +    description: |
>> +      Boolean indicating if alpha uses Kelvin degrees instead of Celsius.
> 
> It's "kelvin", not "Kelvin degrees", and it's "degrees Celsius".
> 
> But what exactly is this property for? We always want degrees Celsius, don't we,
> and any offset can be handled...with an offset. No?

Ahh, I hit send too soon. I now see that you calculate the offset in the driver
instead of requiring the devicetree author to do it "by hand".

Cheers,
Peter
