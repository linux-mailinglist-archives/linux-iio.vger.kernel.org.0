Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5D2550C3
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 23:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgH0Vw7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 17:52:59 -0400
Received: from mail-am6eur05on2114.outbound.protection.outlook.com ([40.107.22.114]:20321
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbgH0Vw6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 27 Aug 2020 17:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQveaOybCAe3SFj52kw9B0GAZ+tJAmAOPnuO1BCJRfFCWjEYiJB9TIyWfcVwASrz/EsZRNvz4EGzqSfX8IDk5jKuSPvkf4UGTk+FUm5DsmKe+RPWQUmhBqf0aGyA+eqZWc/rJB80Jy9lXioitUhz4j1mPpyyqjs6lSOgu+bzAGkPhfGH4QBrpxXPlv4RBfYV51S6hZfpN+Vbbel0HP7HKu9uR3pNuPQE89aLoHNWDAsEujC1aC7Vm3Vp/4/XvTHywcbHwEe7RHyvdbH39POhd9hs8RUw4shBAvvv67zEYkZ4GpVthyScovHes3sc5u1/elZI8WyimtILaV3/Ee47lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfsLL6oheHoLMdXAsX/wDJUY2XmjCK4ogCvSShWIc5g=;
 b=Eeh4u9TnB1uwWhWCDP7T5h1tjr+wKE+9aiPUuMf7+gh858ZuGj5fJcG7tMjd3E/N6wGP1Nj4l0iAfjYGG8CX9qF+n3wP3fELNwo1q2IUpjLNOuEMVIzPYsbOD9mD5rapioa8mQJ/m7B60Ff2K4Ro8ZvX8yuKKy2G79wilm1EOVvWfTkBo4IXfbxAvyRsWC3o3CmCFhlS/eKEYTabLwQp5PDbR8zCO+wenwVtzj1kHIPu7IJwGDsWZXlNRxE+HcLfIL6ACNdO8mjfNGweTQW1RNmceVVBohZ5l1p0ZMi8K2SGm/oMPfB/+odd4EnlxpLv9iQjnnZiJSBLwkhWM+JReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfsLL6oheHoLMdXAsX/wDJUY2XmjCK4ogCvSShWIc5g=;
 b=PSfhP/nxpJPdDSlE8F8Mg7pPO2tsltCLp2npa2rNf2GPl8xFzEqodjXCQCv3LSBuo6eWtHLcerif1VCVAVfrJkmnbIlO+23UHin69+/FZehnGhjRZIPIkgm0bpTeL5qZcdW2PL2C46tTLfD7y63P2U8nQ7SKhUdXhyBQ+qrWNs0=
Authentication-Results: st-md-mailman.stormreply.com; dkim=none (message not
 signed) header.d=none;st-md-mailman.stormreply.com; dmarc=none action=none
 header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3176.eurprd02.prod.outlook.com (2603:10a6:6:1b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 21:52:54 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3326.021; Thu, 27 Aug 2020
 21:52:54 +0000
Subject: Re: [PATCH v2 18/18] iio: magnetometer: iio-mux: Simplify with
 dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20200827192642.1725-1-krzk@kernel.org>
 <20200827192642.1725-18-krzk@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <325481bb-64b7-b063-f210-65d167888ca7@axentia.se>
Date:   Thu, 27 Aug 2020 23:52:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200827192642.1725-18-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::14)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 21:52:51 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb212ce4-0bee-44aa-b583-08d84ad38cfd
X-MS-TrafficTypeDiagnostic: DB6PR02MB3176:
X-Microsoft-Antispam-PRVS: <DB6PR02MB3176F05D83B87F5FF26795A6BC550@DB6PR02MB3176.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Z33sRAWscyOK035iaeJVLTdnhzfui+/SL/dYZv+D5DJ8bxNsTb31/4fzrHpO7s9/veHFvKZPTnbUydU8LaoOZJWFu38YO2vfwz2/8ufHQE4SYQkkDYRt4JNpcSk0piCklIsO2KBW7GFMZRbuOeQPTdcCRJK2lsYRfNdAjTuYkeIMIpR+WoXHgZQZo/JxUy6wIn1S5mQKiX/vmUSFyS2hgb91RZzyeXuoTnvIbz82a5btN5qEXRu78hWDIA6Y4W2oZMCaTqmkJxseSAgydaLogj5ZL7sDSPeX7TG2bCYnpZHmRiZCIzMqOgkFosaLmhQTuZxCVJv/K4lbPOLKo9srU55sS3ePzo9QfsosrObQExpAK2zDIywFJATCogTN1I9tEvcW8cwLixCxhHFJyPrFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39840400004)(36756003)(16576012)(8676002)(316002)(53546011)(186003)(8936002)(36916002)(83380400001)(2906002)(52116002)(26005)(66946007)(6486002)(66556008)(110136005)(478600001)(66476007)(86362001)(2616005)(16526019)(6666004)(7416002)(31686004)(956004)(31696002)(5660300002)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: aBSuJ1Qg631JDAQY1otRa8HjN8rHjUEZweseGyn0E9YoyjyYpOukbSE77sVeIrkNeE5SWzQBHt2fpTRZZcx/EyfUqKmjbIn5D4MF/SKWq4VDT9PlHuHGts/t+MnIinyLByybW+5591ZUmfe9dt/inNeo2jnO9lDHESvq1IehnZE/Av7gXTioDmOxiRiux/ul8Q/saL9ih3IzxHOTkDCtOAAe3HJiJ1I5zlbV+uH4Jsjnpvc459eeZb7PpMwcxXvWb3mcYM+gYemcrxtjukBn+m38tPV7tMl0Gms6OxbjOiIDqlzAfeRqD3KrWXwIphcK3G+Hlm5dOQgQs6krdfcYJL07HijOn+tn9S7mr5zi8ilJDaalahI8GlM8BrsbGuz4iFMJg5JwtQ6oyyKl87kgzNyaLvYgtvisjAj2S/ygKd7pv/9h4NwYFSvEW6N166y62vwcpa1TSyXg7p1PiFTPAc8iZbRPPXw0koRh8Kw/n/H+qsTIOhMEIWwp0yEmiIQ6FLEYNHZFX3TexwcmWsMmDmqWXIZ2o+MZymLWFqPaUO+bnb/1c4zrUSwA9VlYjSUFioJVDNHAh/iuFRE7S4zZ1ZS1l20IM8EeeWhpCKYojwsY4gwBAYCGp9IreCr4n0oepRzBBF1krTQJis+yBR2EkA==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fb212ce4-0bee-44aa-b583-08d84ad38cfd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 21:52:53.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gp8pe3RxEyeZgAS7g3nmk73OTM7sKAfnY0UfGUdpnPD0Z5saWMFXnqGXSIN85j8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3176
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Wrong subject. Made me overlook it on the first pass...

On 2020-08-27 21:26, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/multiplexer/iio-mux.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index 6910218fdb00..d219d4a86657 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -354,11 +354,8 @@ static int mux_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	parent = devm_iio_channel_get(dev, "parent");
> -	if (IS_ERR(parent)) {
> -		if (PTR_ERR(parent) != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get parent channel\n");
> -		return PTR_ERR(parent);
> -	}
> +	if (IS_ERR(parent))
> +		return dev_err_probe(dev, PTR_ERR(parent), "failed to get parent channel\n");

As per the comment for 9/18, I'm not a fan of the long line here...

Cheers,
Peter

>  
>  	sizeof_ext_info = iio_get_channel_ext_info_count(parent);
>  	if (sizeof_ext_info) {
> 
