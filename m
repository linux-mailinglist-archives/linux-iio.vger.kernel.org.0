Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5266427378
	for <lists+linux-iio@lfdr.de>; Sat,  9 Oct 2021 00:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbhJHWNc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 18:13:32 -0400
Received: from mail-eopbgr50127.outbound.protection.outlook.com ([40.107.5.127]:5603
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231830AbhJHWNb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 18:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkCgLnxOl+IuzVqO3bb352qyFN87+Lqfdv7w1dLbQ06g8b9NzeJEXw4sSJqo+8WhKwDFHwdTxM/z2PTVXR36uTmKRCOAENi0f7mZe12+iOxQP4pq4JTVFC5F6MNoLbxGhgfJ3cs5bVJjPWlrQbOMngaHW0B2TK3G38buLeUB3L47jhuQn+bsEgFPs5wgtDFIpwf4u4LvY74uI2+m7ouLkpi4tCRz+pPktSpNiYpfpE86P124ad4lLjjz/LZbLOcYGxujUv66/VGHTQ++W4XBWSK1YLqsjOdd1BWj5ppskmioK7s/yka7GyPHoG0gRDpFNbKK8UUyduz/ne+Ca3jN1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wScP60kLnMBNdtYWoOe0OV6Ygo/ej0kMrUNG5u0ri44=;
 b=XjfKLSP4jarWgGtDNnAIUyloPz1xk0FFzVj38Q16kMubImjObdnpwzb12xhGZpIlILibRT4V6u6jLiOTMnmZWsMrDizJYhGPXIgzOULKbQLXRIupTWNaMhd8lv4Ejw9pkNGDPvtTTHhicww/FfvzNBUENMSVZA5yPN9YOt08DCbNe0NOF12GCFgkIiclpWnK+BUitMPJRNiGPDibONg0VHEYXoTTwve0yC0RPD6CerDVykZRFkXAtOkzsYjcW43C0qkpZTPsoQNkG1Ga8o3wttcjmgvFvTQTA8khD95FK3CvO4Qs2Hjt/7i626jHYLya81Lmgyvh4msyz1D6t3Td6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wScP60kLnMBNdtYWoOe0OV6Ygo/ej0kMrUNG5u0ri44=;
 b=CXGjsBLsNZVS81INbyWYPHfX3uooE+IWAWRGTNaP/4YgeLLgd//0dGUKt/fOwc96QLE3+fW/4WDyil/5t89fNIFV76xsarouQfraDMzZNj64s6FRT/EOILOrVYPmxxx8p4QElRk4P3UlB3IKVwpXTkpgoVUh2Y4KkHSppANVMWk=
Authentication-Results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7354.eurprd02.prod.outlook.com (2603:10a6:10:25c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 22:11:33 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 22:11:33 +0000
Message-ID: <815d858d-3c67-c184-2413-9d6b487a853e@axentia.se>
Date:   Sat, 9 Oct 2021 00:11:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 5/3] dt-bindings: iio: io-channel-mux: allow duplicate
 channel, labels
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, jic23@kernel.org,
        devicetree@vger.kernel.org
Cc:     kernel@axis.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20211007134641.13417-1-vincent.whitchurch@axis.com>
 <20211007134641.13417-3-vincent.whitchurch@axis.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211007134641.13417-3-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0058.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::47) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1PR0402CA0058.eurprd04.prod.outlook.com (2603:10a6:7:7c::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 8 Oct 2021 22:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66dcd91f-e3e4-4943-20c7-08d98aa8966a
X-MS-TrafficTypeDiagnostic: DB9PR02MB7354:
X-Microsoft-Antispam-PRVS: <DB9PR02MB73545341B6A2920D7B59268FBCB29@DB9PR02MB7354.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4XvWsyPz2Kwt3lAbkTlxKm89Kqjk2ZTUczjDQKKL1DcizN3hMEVexAIKC1LZ3GmMGl5bqgHbeMbog8X9YWfhgnp3w6WFobHvwS54ey+1d85pBOJ4bYN2CZarVikgOxtf8OJ9yPtQybrw2pqbwMb7g8lUP+U5xYIaV7z68PrqGNwXBOXBsGxRqJYBpVV52huh/SfqXDG3G0sce3jca9+s8jqIE/9UyKdpuTow/oBvaBC3SVUL+D2kl8zgX+fLhQ4lcBmEg+65t1Y+1FmTFfn7SoSS5IHmkkILr2a9Q4f7UZgJs7WwSwqlrsC78jry7nuYyPhq6TFiOfYAFl+w6eWs6WktjYoEPJEolqB8leErUSwRnxlnNcWkLwV5YsRotg3vaR8AiryR77xZenBfHZYKm/0LFWP0uZJIodqZUdRB3mPfCpQ8RwCa56Qv17QycLLodP96j7Yg9sVJUB1fsUdZK5aUXj+pWVWkxnoKSQmaH4eW3klEYQki6TvJ9MaRRhYHb03Jej2nNRGmA/EpmGOfjVVSbQSNmGt0RhuaszOO2A3qS41A4+TTvj844Ug9Z2trp3XnZHx3q7bluPTeE+KramlTwrfpUo642v3JGIpPbqHVAWVdOW2YdkV6dzSHkE+KJ5So73eyhX1qdeO3KcsaylGc9Z5pCoaNdlY0Q+g6Hwc5pzI/t2aneDW4DMWBvjP2ptLozwRaQD8q85WZNPRiS8Tv0R4M8vd/ik0pMwPsyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(346002)(39830400003)(136003)(36916002)(508600001)(36756003)(4326008)(86362001)(31686004)(2906002)(83380400001)(16576012)(316002)(31696002)(5660300002)(186003)(26005)(66556008)(66476007)(8936002)(66946007)(6486002)(8676002)(2616005)(38100700002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNKRE5FY1ZNajN1b1YrM0RCcDlvYWV3MFhEN1NaQWZPMjA2YTA5M2tldnRT?=
 =?utf-8?B?Ull0UTF4Vkg4T2tCWUJtRzcrQVA4dncyOFRqdzFXcWJmMlRRQVBpd1F5Sy8v?=
 =?utf-8?B?MXFlNTNzQ05VdUhuRDVvUmQrcU1sN3dvZU1pdmRSSllKSjdyVmtwM1BZTDhP?=
 =?utf-8?B?YVM1SmZ4Nm0zSmNXbUNaT3lXeEhDVWduRjB5K0JJZktObkpIOGVSa0ROaGx2?=
 =?utf-8?B?akR2Q0tBbU5HMGFOY3BqdzEzaGtlRnVlaVZra3E0TTlsYnJJL28zQzVGUDJE?=
 =?utf-8?B?SmxtUEg3dzVFM3ZkVDZYVjAvNmZYMkttODJLQzlsd2JYOTMvdG1sWmdDbTVo?=
 =?utf-8?B?bkl0ZVdOR2JHcGNKU0NUYnlrWms1T09HbFZmM202c0RmWEdsMCtjZTdZRm02?=
 =?utf-8?B?SXJ0cmFOdnR0VWNQbXovaUFaeHRZVzd4dmluRklBSFRsVldpY1NEcGk5Tzlm?=
 =?utf-8?B?b1VpbzJDamdYTE5Bc1h1RjJyNnVxQjRWRGlHbzdab1oyMlVINXdvQVFHOGNh?=
 =?utf-8?B?VEU0alNxQlpMbXVaY1d0b2k2bEVRT2dQZnhjQnd6QzFlTTYyTlVxbXNsSyt3?=
 =?utf-8?B?aUp6MEE2ZXBNeFhPTnFnM3FNZExhODlLT09qTjNNbjJobWFvd0JwSWR1aloy?=
 =?utf-8?B?ekE5V2o1ZUsyNUV6SEVFeUVxY2hLT3pIRVBTSkpFQTlQYXh6OXNHR2FWRWlw?=
 =?utf-8?B?dDYrV3V5Q0FkR1NLS08zbndlbVljaVVXQWhCNUowSUN6SVQ5ZjR1SE05RjRv?=
 =?utf-8?B?Ym84MjBXZDl3cU0yb29lYmgrSTlidVp1VDMvV08zT1g1ZkN3MU5qd2xQZS94?=
 =?utf-8?B?MEJCS3JRbWVxR24yanRuSFF2VlhEdE12cnhDc3YvU0xFT0V2Nis4OG5iZU9w?=
 =?utf-8?B?Q3p1ZHE3YzRSVHp1K2xXZzBmWi8vbWEvMThDVytGbmFZNXplNDlzcE5XRzZy?=
 =?utf-8?B?eTJkYUFNd2VVZEovOXpqakI0c1IveEhiUkJhMk80VVlYU0wwT0hVQ3h1amd3?=
 =?utf-8?B?ZjlsMC9Qa0JteXFvdThaL0dRK0hYSU1XZ25JejltbXN0OGpielU5R2ZZYmc1?=
 =?utf-8?B?UWg5c2l2N0FXNDFSVWxhSWd1cGZpWFhRVWdFUFgvOGltbGxBbXhsUE9weWli?=
 =?utf-8?B?SEFlNWpUbHowUlhmaTJvNGYxOVRsS0Izd0syRVJQSitaVmJvbERQUEhWNTFk?=
 =?utf-8?B?L05lQm1zandINDhmRnNTZjFaWk9jWmFXbWNQU3NiSWFuUzZYUHZIVEx5Nk5j?=
 =?utf-8?B?c3lSRisvZDVBdUo4ZU1hdlFQaUgwR1hTWjB4ekV5YWhUd2huaHg5Ynovb2dX?=
 =?utf-8?B?MU1rQjdjYUMwUnFEYjZlcDV4YVUyOEVNYTRZaVhHQ1V3YVBRMGhpa0FmdjhJ?=
 =?utf-8?B?RU92N2FXV3BRT09KKzNHbW13Z1c0SGsrTVp4RDQzUkdJbHhlQVJPVGt0anZt?=
 =?utf-8?B?aFhDczJFTjRFU1NpQjZPN0k3cTVPL3ZqcG5SV1NCdm1zclVTTVRtNlo4UHNn?=
 =?utf-8?B?MFpkaFdDQU1ZNG1RZ05Wc2pEK1RWMWZ4RVBOVWY5czBXUWF0MFhNQU5wdVJO?=
 =?utf-8?B?ZXkvYnBJZDZ3SE5MRTdpcnQvcGJxUkJpUmhPOE1rQ25NWUxEb2gyQlhKV1J5?=
 =?utf-8?B?M0l2Z2VHS0FiS1BWd0R3ZWRsd0dNWHA2aXp6dlM3cFNNQk5aOHM4OERSWW11?=
 =?utf-8?B?b1g4MW1lMFFTL2QyWVZaemZ2UmR0NnVvRVJVbGlGdUJJR2xCTnZJU3pNbTd2?=
 =?utf-8?Q?RZ+qw1FjxNFOCrAkSFR3el5nkiFwsG90y17YQ2r?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dcd91f-e3e4-4943-20c7-08d98aa8966a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 22:11:33.4720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTikPGF9vhoG1StR0qsaVdAv05oo4SNPPc5sXo084Zaf0DHcOlBwnW1A5X9sNZmu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7354
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is needed since an empty channel label is used to indicate an
unused channel, and there can be more that one of those.

Fixes the following problem reported by dtbs_check:
envelope-detector-mux: channels: ['', '', 'sync-1', 'in', 'out', 'sync-2', 'sys-reg', 'ana-reg'] has non-unique elements
	arch/arm/boot/dts/at91-tse850-3.dt.yaml

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../devicetree/bindings/iio/multiplexer/io-channel-mux.yaml  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
index 80b6229a6fad..611ad4444cf0 100644
--- a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.yaml
@@ -35,9 +35,10 @@ properties:
   mux-control-names: true
 
   channels:
-    $ref: /schemas/types.yaml#/definitions/string-array
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
     description:
-      List of strings, labeling the mux controller states.
+      List of strings, labeling the mux controller states. An empty
+      string for a state means that the channel is not available.
 
   settle-time-us:
     default: 0
-- 
2.20.1

