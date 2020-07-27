Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5322E9F1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgG0KYX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 06:24:23 -0400
Received: from mail-eopbgr80127.outbound.protection.outlook.com ([40.107.8.127]:65166
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbgG0KYX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Jul 2020 06:24:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af1Gv+dCJbZEJ20hPSwKj+eo0t++VyoW5YyIf7ELgXlb3eZha6G9IeW/ork5hBppdvoiaDVEbjqLu0P6gEYv/D49bfbuaNR0vHebcxlp2ZUYLJN9vqgjD0QAxDCqhvistb31wHYmH2plQdmFWbvZHCDL+p4owpL+ynbZAuJbR0sTWvwphOjD/Vj3ciY4GUVUD4bYGVq33MyB2IzxkP1FWRcE+07HwlJKxLH8lpts1LqFzNyHrqMm6VNb5+7n/vN6w2e5GFYpWl7yDeMEGUvSCp7Ro2QSqUlMpYPL/yGtIFt9OpceIYVrCYrQdUwwgrZ/NZRygLejjMlejc11HxTzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WZV233ZBu6WoCz0ORVvzF5G5kadcWYvPw4wFeIU/tE=;
 b=L/mecF+uTSEjAzH5sRpDRLvpftMe6qCflLyosdEV75UbGDFubQkLGlGB0Awl0luvlSrZPdO/sipKBmOJIoBmeUNNLgHanf2DzU16Ir7weT+414+k6eGHl3kNio9ctIIRFo2gdsnPDKaOlhDjxvxLwO67HQtgaNgHD/6vcUjdFfmW/hqxGHrFXoydxMFUBfdNfYE8inZqn45A8XBnFJlmr61vdFr4QNUPUqQy4EXR8AJin674tEeH0lg+6A/Y17ah7RvjEX/U6HrSrywf0xgE8F0XW6VMv7E6Jtj3pxRcST1fZM8sls3crnrsDeZq4S3JTpjhy7pqO6O/p9+mMU+67A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WZV233ZBu6WoCz0ORVvzF5G5kadcWYvPw4wFeIU/tE=;
 b=Ihcv7gnRXJvfnK+ZpHdhqBrxBbSzgeLNMtw+IeZbCoL2ESNOw9Cwfk7qw1y9GBu7xcOzZI1MTAmPV8FfO7gsjYoRjS6XxgCALveGm1NmHDrnKJdN51CWDKo5pBwugR/+SZ4c1F+gKFbnfEcJq8IT/leiADoYZU5duGhXDBhkBz8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3175.eurprd02.prod.outlook.com (2603:10a6:6:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.31; Mon, 27 Jul
 2020 10:24:19 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 10:24:19 +0000
Subject: Re: [PATCH] dt-bindings: iio: io-channel-mux: Fix compatible string
 in example code
To:     Christian Eggers <ceggers@arri.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Kosina <trivial@kernel.org>
References: <20200727101605.24384-1-ceggers@arri.de>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <cbcf578d-37a0-b807-134b-f7cf2d3d9e02@axentia.se>
Date:   Mon, 27 Jul 2020 12:24:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727101605.24384-1-ceggers@arri.de>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0093.eurprd04.prod.outlook.com
 (2603:10a6:7:54::22) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0401CA0093.eurprd04.prod.outlook.com (2603:10a6:7:54::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 10:24:18 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a59f8169-9c55-47d6-778e-08d832173913
X-MS-TrafficTypeDiagnostic: DB6PR02MB3175:
X-Microsoft-Antispam-PRVS: <DB6PR02MB3175B4E645E386D86ACB0EDFBC720@DB6PR02MB3175.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Svx3a2akVsgICuqiHLkStWW7YU0H+4l0HC4Llqxi3QfH0UbSMRWeK87dboj7x0l/6dRhYXRsk0OjkH64P6sF+DOKI4ZxnSVgxF6IlD8vw41nlUvTluvP5PvXACgh6x7b/2esRbepWGc7uRjUM1ftSLTnFB8h1eU6S1GmN3hfVE8mLu7BG6OjT79yr4qCux4/lEdoPLCtPesv47E19vZvyKZ2oMFJI/5EunGmg44Wyl73/eXF6W+xOdkkjt1fGhZyhhnnQY5lPuMKb1Yf2Dn6zCTkF8RtCpl/Acrf07tB646pPA09v9WHkjjbhgw+CeomEbv1JBdOscVICb5clp/B3WTVF/vUC8TLEkSMPhxv+aqDi7QA9TVBy1o+deXUmJ94
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(39830400003)(366004)(376002)(16576012)(31696002)(508600001)(54906003)(2906002)(4326008)(31686004)(6486002)(86362001)(2616005)(110136005)(66476007)(16526019)(52116002)(36756003)(5660300002)(186003)(316002)(26005)(53546011)(66556008)(83380400001)(8936002)(36916002)(8676002)(956004)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +twvtkTLDeXHjrFWPweizBQlxZGUsbu5bFXSUy7d8hYeOStSQUDc52U8dKeR6hFiCsqzGJ780ynh2ILYy7RCqjQIAclIBEY2LI4e7W8iz9wT5Z+rjabNmx5o0uQry8Q1Yu34VXhNqTBCi4XN/mh3tX9xAqeZYR15JeabH9IyOKduvd/d1gM2N1XSEdJPE9MtDju5iEvPAj8ipdGD9yW6hLybCmIwO7zEiXkeGo2c+fQaKhXlpMVGvPj4DIsvX+8Uuqb5Xa74193uTbixIgSLrcu5eqUy1oigXxU53wC8c0jzjWkSOeuCF0nR2ST1dIl4RGmf69+5kPgoIPHEmiaz829dW87T8mNstDvCzWHZbdwUkPLbrVNigjLSdRyCZsAeaZuzRucINmn/wJvQuDwiFa51TcAJPdodRpbke5ubVgq7Qu3bGu0zBLk8o2xMRVeveOnBefB9xShzB8086Y+FEWBCTenwAcv2w4oLWx/WD2M=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a59f8169-9c55-47d6-778e-08d832173913
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 10:24:19.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l3QDToJKjQcp42Whs7uluk0aqYElNgfLvTZevn3yNgudEcoHrbBJv+jMz5yJxlT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3175
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Well spotted, thanks!

On 2020-07-27 12:16, Christian Eggers wrote:
> The correct compatible string is "gpio-mux" (see
> bindings/mux/gpio-mux.txt).
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> Cc: stable@vger.kernel.org
> ---
>  .../devicetree/bindings/iio/multiplexer/io-channel-mux.txt      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> index c82794002595..89647d714387 100644
> --- a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> +++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
> @@ -21,7 +21,7 @@ controller state. The mux controller state is described in
>  
>  Example:
>  	mux: mux-controller {
> -		compatible = "mux-gpio";
> +		compatible = "gpio-mux";
>  		#mux-control-cells = <0>;
>  
>  		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
> 
