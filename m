Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270CD28AA6E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 22:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgJKUfZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 16:35:25 -0400
Received: from mail-eopbgr130114.outbound.protection.outlook.com ([40.107.13.114]:33229
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729100AbgJKUfY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 16:35:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcjOsxv57NYc5XeLOMgxGPmBfLssFKth7YaCz8+g4wi/J6U2oq4+LRnngQ2GIP0enUfMomiW9IOa689Ub4J7gM67dSF4JIH0zZOLe+RJhaY8JOdLyEgzmmysl05mJT9FKvxGdD2Nh2krKcZipmlsNbKPp4I0pUaH7sV3+u4Z0k6Y4Ise1SyqowY08nkycdy/93kwaU3Z6OlyZ36fFpEWN0bqLP4hH36q6oLxkAD+t0YaVqnIOjxM6d035fGsD03oNV86VG8w5ranA8zzXmuaG3bn1B5yUAdXyeVF/GnuxOq6vUQ3XYpS9Nzkjtyqnq5tcrgvW1qrlGQLmcop06T2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eITWTCxrPIFhybquRUXjSi01DPBPtOBnztzUYtnozyA=;
 b=FfZrj5SzJdoxYxVrGN2kBgaisbbUd2bZyiIq/F/BqKLMk93efJREKuYh0qziAQxn9T2xXbAyyEp1WQXrrjvbUzrLbC/XxTUFRBvNBneSi/6V9Urc9i7xj8zshlRgr8D4ESNg6YL0GLi+2sGTLZTLevN0x80Pj4SfrOXMgy0IV5MvkMqikEQPY5nNr6LMLGM0AX3yStjKUrUv3LhNBH6YZ/VuQxTCv+o5UKe2VRp3iVQen1Kt9AJOqTDJEYWXOfsl3gWG4kkd7kxMS9+5ZvW3Zwunuev0RfBwAfr9bYmhYRnCQHOANuHLqaw0VM93e73j9NMZnFRorfh4vfD44rkUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eITWTCxrPIFhybquRUXjSi01DPBPtOBnztzUYtnozyA=;
 b=N6pSG0AwG8PmRWu+cQUSWiTIgLPvg6vx9yluZOHecW5BQn8jIejvJ3gHAM0ud4d3GMlDkc850agEGpBLzfCOsJa4qE48WFQnExlL/SLUVYgVUvdrOM8/6jjMHSylwqe7ZzCOYWvZkpe2ixaLZydee5p6hO0+YopHS9gG5sFXsRw=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2165.eurprd02.prod.outlook.com (2603:10a6:4:45::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Sun, 11 Oct
 2020 20:35:17 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b%4]) with mapi id 15.20.3455.029; Sun, 11 Oct 2020
 20:35:17 +0000
Subject: Re: [PATCH 2/2] dt-bindings:iio:dac:dpot-dac: yaml conversion.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201011163031.240708-1-jic23@kernel.org>
 <20201011163031.240708-3-jic23@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5dc5133b-cd83-f754-caec-735124091b51@axentia.se>
Date:   Sun, 11 Oct 2020 22:35:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201011163031.240708-3-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.207]
X-ClientProxiedBy: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.207) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Sun, 11 Oct 2020 20:35:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab23965-1270-4404-de34-08d86e252a33
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2165:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB2165ECFD5AE16C13E7399705BC060@DB6PR0201MB2165.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5kkmj5zJRKAO3o5smu+2c2Z5IgtLQtXw58hk+XcF78/1GzmdJd7Ro1EvLTDALFi7AFe33HNanb3HmEPH4luWFv9zQZLmGPDM4xYHj9KCFW9qJ+ZVgFtOSl5WeFQ6PsoutZ+SEx+py4VaHPthKWtgLFJUtoKm1ksCABak8g3Y27jdcxvY6mpOjXHhHVVWToLa10CTTHVlbkKJt/YclblMpfEyKmxQwLhgSW69ckLnAf8mNFw7G6C+o6T7fwqIed29LTYWHinSp2PKqJz0+jzEsCb7Lv0o9zma++WfhH2vSyiUK/C4W7z/5GKvi0dqkypZBdzb09Vi9UhLxH0F+NOWtAjUWPRLN4ShO87GohSNP409qWFLub4/6GEW81qJ4OutDo9gQRRhf57H7+aQDTLBD7Cb825u7vWOh8p8vrGml4HWqxo6RQ59QUmQ3Wa2TlhUrs+uKZCZP6sZ1ZzQjUg3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39830400003)(396003)(366004)(346002)(36756003)(2616005)(53546011)(956004)(26005)(186003)(16526019)(110136005)(4001150100001)(86362001)(31696002)(31686004)(16576012)(316002)(66556008)(5660300002)(83080400001)(2906002)(966005)(66946007)(478600001)(66476007)(6666004)(4326008)(8676002)(6486002)(52116002)(36916002)(8936002)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: l9iVOVZ+dKrsBB9mDISF7IC+eo+bpl0L0sayTiUHqHCB2waKJ6nfRtPPxhtsiWOr6tA/1xrG+g9n9Jp4LCJjgodMUUULoYV2JDEA48ifN0XM9hAM6NAZkhPALGvfQBWG26CYtBKQVvyZslzijmz6fInzxbi5c6ywygNaiEyYs2KHDwxIy6X/hnWaHaFdjSy+l95fjWRR0UGl3T2fW12LT/YzePKnVQ53nadp6w2qm0f6khfRJhx4SDT1dj24kxa1P/I0Ce/O33INr4zYB/mweTR/7vbYBXoZNktvIr22IkVP1br2zSEoZ7gJsdj1VhvOGPr01J2Vnv2w82eT0euV9DHONZGY2uTAHrzyOqlt2iaDtufLCK7XhHfGf3mv1WzVKDmiTW9qcApNPwCPhRxo7XaxYn5gF5p0aTa2X4xA65FVzaD/FGXAc0eFmUesfPw16eDW+wd+tejortcz7WRAlicmeH1PCVdMEr+ZH7+VF6K5stIkrj4MgiEuF3BDQNCZ9rXQmUqyCVOmuAtgajWGmjHWRdzi8JfTXrI5MResnu32j7ebjrdDDgCt5aiQcF62c6+BgeBeWpATA6wmG37LrwehAls/HZnYs8gZPx3p6MNBj9oX0Sbniye2siQjjjeWCqTSC6y92wLBdCYX9u1tMA==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: eab23965-1270-4404-de34-08d86e252a33
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2020 20:35:17.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbcXb2rqzEBA9Ir0rQl57I/DBddfPuAfuDKM780rXr7yVxmTg5LVDT0I7eUg2wQ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2165
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2020-10-11 18:30, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Txt to yaml format conversion.  I dropped the example section
> describind the measurement ADC, as that isn't strictly part
> of this binding. Uses a reference to the new iio-consumers.yaml
> binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Peter Rosin <peda@axentia.se>

While not being competent at checking the yaml thingies, I can at least
ack the zap of the irrelevant part of the example and generally support
the conversion to a more strict representation.

Acked-by: Peter Rosin <peda@axentia.se>

> ---
>  .../devicetree/bindings/iio/dac/dpot-dac.txt  | 41 ------------
>  .../devicetree/bindings/iio/dac/dpot-dac.yaml | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 41 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt b/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> deleted file mode 100644
> index fdf47a01bfef..000000000000
> --- a/Documentation/devicetree/bindings/iio/dac/dpot-dac.txt
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -Bindings for DAC emulation using a digital potentiometer
> -
> -It is assumed that the dpot is used as a voltage divider between the
> -current dpot wiper setting and the maximum resistance of the dpot. The
> -divided voltage is provided by a vref regulator.
> -
> -                  .------.
> -   .-----------.  |      |
> -   | vref      |--'    .---.
> -   | regulator |--.    |   |
> -   '-----------'  |    | d |
> -                  |    | p |
> -                  |    | o |  wiper
> -                  |    | t |<---------+
> -                  |    |   |
> -                  |    '---'       dac output voltage
> -                  |      |
> -                  '------+------------+
> -
> -Required properties:
> -- compatible: Should be "dpot-dac"
> -- vref-supply: The regulator supplying the voltage divider.
> -- io-channels: Channel node of the dpot to be used for the voltage division.
> -- io-channel-names: Should be "dpot".
> -
> -Example:
> -
> -	&i2c {
> -		dpot: mcp4651-503@28 {
> -			compatible = "microchip,mcp4651-503";
> -			reg = <0x28>;
> -			#io-channel-cells = <1>;
> -		};
> -	};
> -
> -	dac {
> -		compatible = "dpot-dac";
> -		vref-supply = <&reg_3v3>;
> -		io-channels = <&dpot 0>;
> -		io-channel-names = "dpot";
> -	};
> diff --git a/Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml b/Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
> new file mode 100644
> index 000000000000..b4a8073a3a3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/dpot-dac.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/dpot-dac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DAC emulation using a digital potentiometer
> +
> +maintainers:
> +  - Peter Rosin <peda@axentia.se>

Heh, I don't know the first thing about yaml so I will probably need
help with that. I still want to know about changes though.

Cheers,
Peter

*snip*
