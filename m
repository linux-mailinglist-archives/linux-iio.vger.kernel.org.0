Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664AD256A6E
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgH2Vas (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 17:30:48 -0400
Received: from mail-eopbgr50091.outbound.protection.outlook.com ([40.107.5.91]:58241
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbgH2Var (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 17:30:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG3mCNDtxB2cXaXm2Lq0dDj0EcXssVpbgDyqNbYhxqub0vQBjkD29dRNzcO1XxrOld/qf90Pn3EgEdMrr4t7WB5OlSFx1o4bIKv3IiFQppbBYo4DYIkvkgwZhI5d+8LunmgPqMzSa5zEPulYDwH0D3mmmEALJS74Pd/f/ekuJVAv5yygXFKprHnYuuvr+Kaj3Wc39OoKlL2jcIKY2cGeCVg5Ibe4swH42ce6N6g29W4L36RwQjd+3QH6znQgvdi3RIbx/EiXLZxco/CvX5f0ij5h/EzoQYRbo3dwF2Kk/Bm5/cj6kuv+7fswaDO8FhZfsgO0RUKocMX/odrhLhvIww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oi1J4wd3y5TlCF6TlMOYxE9LsQWiMmri7Rg7agcDIQ=;
 b=GXLPnnzAfNDGF84uXmqZrJBos4VwdLE6nmnkpUtNrRNHx/SdLXIpniZEyVPkhIOFjB1dDkUH5ED1pfv/jA7XtAHBX3dr0//JbZqAxqCG0eoM2wVr1/Rxbwht9XIHAYatsxXEDCGxJmqZRj2K6jX4NohXWmIkWwvbFbGhye1a9iNXNMJVji5Du1mnzJvRUG9mkJTcXvLlJHqWzAvr6hTEzITQTVkJLVVPlW+Zv2u0cNKUQCm9/PQIxO/m6pl3y4iFzhmE1isSlCcEU2Tfu7YP4rcjV0P+kHLdUVRGZB956clVdcSaCexfz/7P+n7l6+qVUAXo9NpfMQCnQG22R0TEcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oi1J4wd3y5TlCF6TlMOYxE9LsQWiMmri7Rg7agcDIQ=;
 b=O1G0vLzuEOZuEqFLC2ga1QoL9cSvNKmYDoYYJt60J7ZuYOY0vKIJjDMaFntLDg+DLjRyMaKHsvzTz8SV+bFGU79vgEGNuPYghh8twKqGdRN7oqsAYhwTg1O8qo+sF4Ntwz++Fx/DCc9iX4UrD361iKgFoOPMU09m5WZydWDV3PI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6294.eurprd02.prod.outlook.com (2603:10a6:10:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Sat, 29 Aug
 2020 21:30:44 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3326.023; Sat, 29 Aug 2020
 21:30:44 +0000
Subject: Re: [PATCH v3 18/18] iio: multiplexer: iio-mux: Simplify with
 dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20200829064726.26268-1-krzk@kernel.org>
 <20200829064726.26268-18-krzk@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <01032a02-f06b-a952-4c2c-2147077cf850@axentia.se>
Date:   Sat, 29 Aug 2020 23:30:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200829064726.26268-18-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0212.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::12) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR05CA0212.eurprd05.prod.outlook.com (2603:10a6:3:fa::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Sat, 29 Aug 2020 21:30:42 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 317d1ec9-dd70-41d7-d5a7-08d84c62c934
X-MS-TrafficTypeDiagnostic: DBAPR02MB6294:
X-Microsoft-Antispam-PRVS: <DBAPR02MB6294D4AB1CB16B3838715595BC530@DBAPR02MB6294.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6spX94V5buMYNrKMMJm9dIzFu1VzWUspTDwPZHRYxJvQIgeA4TF/1EmFe2piOe3AjUF6XDITGSNAChrraJD3qYEseWkJDYThQ8AKO0uDdUiZgKc64utaeMvUF9Nvry+gJMdaoR6//REgFRJqjbN0ymZdjlUgzxiby2rurfW/+5CD+EKpFJ9diym6uEjGMgwnWA6KzCuGLD+MXlvdcykgdy2vMvlwP6UPi2USAD5WtfNJFkSYwrwlLoLHdGBGjnE66KB4RGnR8IFi08AkZFlPw6wKl+Yls3Y/nSHfEAiubPXKymhdPt3j5pEV7IXtJM4uBoKqe7vqSsgsJKoLw10/vGFiPP+CDNMeLuxaMUp7yanzYLYnWD6upv03mxBojmB6OiD4CWPEwZ7YMcdeGA5VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39830400003)(7416002)(83380400001)(86362001)(16576012)(316002)(110136005)(6486002)(956004)(36756003)(478600001)(31696002)(2616005)(4744005)(4326008)(16526019)(186003)(8676002)(26005)(66946007)(8936002)(36916002)(5660300002)(52116002)(53546011)(2906002)(31686004)(66556008)(66476007)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mmAH5NDY5Nh7ZE8DGqySqwfv8sOUZlSkbtKmAcE0+O3AVVVuPn/1XzCT8tY0fhWRC8AUgZnV9QWp3H6cOnFOWD1JXEEqMOik6tWQxtbTyguJ6MsDVcXgwVxndIvVTBc8zQZQOjL+wpL2BQQgfk7/GgJBwgijmljWunLv5nCkxF/xNrlEi4SbUZrU1+8etGm8fqyolOwovvOMOJ2UXfHpXe5MEvxyXnIQF4fwGIUYJzUFsRjuljqmB6AIx//Jr2qufUo+Z0wX1yUj/I0zNJ+UZB9FC0iVEyjmuWeUykX78JyDgo2d5eFtITb4aXmAQ0BDQ7lh9v1/MdX9hl9aCVKMzw7oAu+9PqKCZlyCFr2HOPT6oUZfo+rHgHT9dSN5KrackBU3V6ppo5gp178FvDcsx8QNZ1blxan/EaI/t1VTjTRIja9PR5HSst/Z0t2L44QITuBSGHEX9A4PiGOHj8dJUwSaxuivPSXaSCwiKXVUYmurN7w7quVizV+uRajZagbCQXj6j1WaDiZEeVgkwUpxAFPsewlIQlHd/vnN4DmPdnOxqAk8bpNLBJR3KmLUTiIeOK4JAVOMGB0gkKxdQQNJ4gHO+qTnDibLZSFWmPkb/G8Q/0aKTUnXbtcvTvgyWWf/m0cWXikzdImuix4C1cvR/w==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 317d1ec9-dd70-41d7-d5a7-08d84c62c934
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 21:30:44.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtRyF7mSyYizYqKLWxwRxiHob4DjebeTcG+gqw/FRe9bp2x/l4co8/6XHgOKguWi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6294
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-08-29 08:47, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

