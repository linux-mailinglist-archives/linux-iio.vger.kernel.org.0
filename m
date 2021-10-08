Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657D5427370
	for <lists+linux-iio@lfdr.de>; Sat,  9 Oct 2021 00:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbhJHWNX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 18:13:23 -0400
Received: from mail-eopbgr50117.outbound.protection.outlook.com ([40.107.5.117]:51777
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231819AbhJHWNX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 18:13:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkWl+IVB4a6xqjqkxTyP71G7oUhAx3Pq6BjDkyV+tw1Y5FAkhTQ9jC+ahfkd3lKGkm+AJd5eW3262CX2TJtYMzD9KyiIUdgaRm0ZRApBKo40Bc7IDxvFbl0fyPwWU8scJEsv9M4IXxnnbpz5FzcWZSv99V8Q7RcdQ9u5QD15JleVkW5WZq0W2/2NIfZJgOzD9vRudA/+dRbtfHWAKCgV1XkPi9ymu9r2rt79yJjVRpFBwPNj/KjEPOmdEI9Xit2ltOiGrHsxEv5MHr/51qd6mTbkuKBBVPphpHEFG6sMHBo0nmXewtYZ+pRIi0BmA+So0ykDIC6xxQQMxzrCoEwx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SVLIiP85rEi7NwQZ2KUCmstoHY/WR6eE52aXba1XE0=;
 b=NhdEc9gUt5pc4gJl9u8mYiilyvzoY0FX1FZTF3KxvkncXuUZeRtPYeEd0dInaFGllj04Qx9peYkxcxeNHxWtaiJx/jt8qy30ACyXTBz9vWA3udOF3bCVP9PrssjVAOqIEDFKmjC8kdLQmpvYCaysXH7UVSzM3sHxDGtPVc0em604wrdShFPO0NsAkC1xxwJw6pQECk3tulLWBbPeWaumFdF/yQWgkNsM6e2hrPDQ0cR1lCXmw1ihU+0IlTtg3oSHk7VRKPZIE2XBMSGNzOHdlkk2qEczENIt7/2rXN4LQRr5S3cSAGIeoMkzd4vJSMr1f8jjRuBUXfnD1W7UYtDZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SVLIiP85rEi7NwQZ2KUCmstoHY/WR6eE52aXba1XE0=;
 b=afUFKcW5NP6+1XHihbuwBC51y7PpHoAZXLcKyIzgocUdvVGMYv+TItx2e/J4myx+nVfNK7toTQvGuZGEOQuF0EnWR9dm+sz+aWk8BCBe66v0vr8Kb/vplAQer7QvWKKZfvwmIIZZL5R9gmLrYk6GQVXTl7PZgKi8rFRzkiGTeW8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7354.eurprd02.prod.outlook.com (2603:10a6:10:25c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 22:11:25 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 22:11:24 +0000
Message-ID: <43e22ba4-0619-49bc-8062-b561cf19ca23@axentia.se>
Date:   Sat, 9 Oct 2021 00:11:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 4/3] dt-bindings: iio: io-channel-mux: add optional
 #io-channel-cells
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        lars@metafoo.de, jic23@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com>
 <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <1633661172.633248.1409599.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0034.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::23) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1PR0402CA0034.eurprd04.prod.outlook.com (2603:10a6:7:7c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 8 Oct 2021 22:11:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4276faa-1d5f-4fb4-3103-08d98aa8913f
X-MS-TrafficTypeDiagnostic: DB9PR02MB7354:
X-Microsoft-Antispam-PRVS: <DB9PR02MB735479297FF55FCBC42913CDBCB29@DB9PR02MB7354.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H4+2QtGe2CDXTNSrbvmxkYAzgXvYid9h+T1UMc0kxjRfCC/Z0Fb1PwNmCuafDKGRwhw9NPa2xN0HJMXxb5r9jb78Y5YcdR3kk/7RFBNmqVXvFnppBtAE1lIK9lZ8e6/c7Kya6im45RmoZPu/2DCym1pywyAvwf4AiE/pPZt7Y4HvAG8c/MiAYt+SrcOrfbtZq7vvcnQp0Ptz4DSlAi8DxzrYKfXv6+Q5tph2YIdxLQsqgYS4BHr5TqitMhvBEWq14fnQp2pARBQHU95IU+jQU1/QP+rZbQdXVKT9TCK6tyPC5uONc4+nMNtXxzxe3DIwQ3R04TXLI2horMiQL/rD3xhMfuAYu1K9pc6hcqC+oRgy70lCSMbQ7GfiptaG44WHiClGWDgT8K12tbDYnexiplj8jYqoNtW0VcRXPASKbFZ+DYvB9fbByK6EKOY/41pLEyLHdStUZhaBFcGCWnVor4EqfkrgpZdZmYHPe9YoyKhtkQdnIZx0A+L+9J4Dz8lix+GZJqZUcGZWsxQFeodKf09t4iohQTdaa+G2aSASaqajb//EWb0iHXfCMDUnYogRGjTavx4kg8WsZ851xONtE4yYc2dfQJyiy0MwfPz8IIMBKEaYGrul6RHlKL01tiNNqgAgwm4MsR3ZxXopKb10IhldsjkMf0ByFexEqdaFVXJldWRz8ya+7LV3riLgKsawuUlzHygT5xfWdgT4cFUG9P1lcqabV54M1/tWPxePvP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39840400004)(366004)(346002)(136003)(36916002)(508600001)(110136005)(36756003)(4744005)(4326008)(86362001)(31686004)(2906002)(16576012)(316002)(31696002)(5660300002)(186003)(26005)(66556008)(66476007)(8936002)(66946007)(6486002)(8676002)(2616005)(38100700002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRxVS8xaFZDb2Z0SC81NTVxODhGckxJL01jZ1FFL2p3NVNOYkQxNk1tNEVF?=
 =?utf-8?B?Y3dNSmRKTGRPbG5WL09EdkRhZnZjRUE2MFYxQnY3T2h5M1R5S09sYmFTemJ6?=
 =?utf-8?B?QlgzcXpjNC9wOGdFRHVLODVvZE1SSmZtNnF0WVdINURKWVp1QnY1U0JneFpB?=
 =?utf-8?B?NmxmVjJwbWc2N0VpbHRGcjhhcGdLZUU4QTl0SU5yanVxRDNoczJpMnkrTHho?=
 =?utf-8?B?bUlxdHJWSVlYN3RxSSs5M1RtaWhLUmVaWVNEUFdKZnFkVnJZUjVnT0w5b1ZB?=
 =?utf-8?B?U1Y3U1p6NnN3WkZCREVLVmhDazZTQ2Q0L1BwMXlrMDJVcXRtU2hnUnM3enZz?=
 =?utf-8?B?dFluWXVpeWFPTTY2djIzMEJYRFhUSlBWNUhtL1NNY0E4ekN4a0RXQkl3eFFC?=
 =?utf-8?B?K3FKTDVRTVA3Vlp4elZLRHZSUGwzdGhBNWxqS29FZkZaNDgxSTkrRFBpT2Y1?=
 =?utf-8?B?M2g0MHVpV1FOSmh0aWt0cWFUd1lveDZKZjFyc1ZsNFZ6TFMwY0FkZ0s2TzV6?=
 =?utf-8?B?dEJJM29PSU8wZXNYcmU2NzFVTnRUOGlraUpEaWFieHR6aWRoVTlDWlN3MWMw?=
 =?utf-8?B?eFpGOVpuWUNNMk1qTmtMTHJFL0wybHV5KzlVYldOUVNaZnVraEc1eVJiL3Vz?=
 =?utf-8?B?NTRKcXE0UkE2WWhBcll2aXQ5RkxraDEweUgrb0h5b3ZEWUgydlg5YW1jUTNl?=
 =?utf-8?B?QVEwbjlXamNuSDdLbG5YK0ZzcFcvNWtlVzdNUFB6SHUzamQvQytFV3gwZTZG?=
 =?utf-8?B?ZWorL01MOExCMzR0RWNxcUtVTlJnMWc2M1pqaDNqSHB3Q1lEbW03R25uZHI3?=
 =?utf-8?B?OVdpR2NQQUVaejBQRXBEWVM3Uy9xWG1FQS9Bd0NzOWFXSXRqTG1ZMUZNVGV5?=
 =?utf-8?B?R1lpNGJZNDNIMWd1eXJwRXdMV3NtL1ZJSDA0Z0RvclIwem9QM0JsWjFwNE5h?=
 =?utf-8?B?K3dNOTZPd0grbExRQm83WHFYZXA3eWpaN1VaVzA2dk1BRmUzV1RmSHlCdGdP?=
 =?utf-8?B?bjdHbE1KRHRVcGRvVk1QSndwY1l3Q2VIcGVSRTh1cHFyVStnOGF1OWJDci9j?=
 =?utf-8?B?Tml4NzFrTThQOWlnc3ViSGdHczcyZDlETWxxSGkveHY2czhYMFZuWTJkWldh?=
 =?utf-8?B?MldQMUFDRVVhZi82WUZjMWt2QStZY3F3djRuVEV0a0xvZldVdWphdFMyR2lR?=
 =?utf-8?B?ZytEc3lkL3JvazN4YkZ4cUtXSUtucmtPcENzcjRWOGxEeHhmYlhLT29rL2RC?=
 =?utf-8?B?ME9ONzFaRE9acE40QVhoZkh4ZmxVWWduK1NSbWI5SVpoMU9MWWs1YzhZRzZX?=
 =?utf-8?B?YlVGQWYzUXlwWWpqTUY4RCtMaVJVM2R4ODQ0a0dBVlVRL2k2NlpOWG9vUk9G?=
 =?utf-8?B?cmRidEI3TnlRcE9yc3RIdjdkV3dveWNob29pang4R24vdWJpQzJIWm9VT01S?=
 =?utf-8?B?Ly9TR0crdFBkbHNNWWZvYk5ON1VaL1JsSVdxR3NycEU1Wm0zZzFXSnkyZk1P?=
 =?utf-8?B?cGo5cWRxOUlpYVZlQjQ0dm0rUVpFVis3UUNMUTh5eEFtakNENDh5TTVsNVZ4?=
 =?utf-8?B?TlhiT0hMVU5jVXFUZXlkdTNBMk9mRWRZMGJFM0RpOU5ZS2Y3RWJmbTNTcDhh?=
 =?utf-8?B?NnMwdUJ6bm8xZGpZQmYzSEJDZW05KzRZeGRYYWV5TGFiczBlNmNGMHlrNWZF?=
 =?utf-8?B?OFR5cHY3NjVjbTR3U045WWxWMGtXdzZ0V1krc0J1REYvck9QdEU4R0NBaWdk?=
 =?utf-8?Q?wF/+Pvi63PcEtnIzblKcwUcdlPCCKwslpFgFj0Z?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f4276faa-1d5f-4fb4-3103-08d98aa8913f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 22:11:24.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOlmWqJ0RpPAadDULeigE3xn09JG8ZumnTCiJIgR6aMwgXiwTFsczM3rFcWFfTVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7354
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Needed for in-kernel use of the child channels of the mux.

Fixes problems like this, reported by dtbs_check:
adc0mux: '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dt.yaml

Suggested-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml    | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
index 5a7328042c76..80b6229a6fad 100644
--- a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
@@ -44,6 +44,9 @@ properties:
     description:
       Time required for analog signals to settle after muxing.
 
+  "#io-channel-cells":
+    const: 1
+
 required:
   - compatible
   - io-channels
-- 
2.20.1

