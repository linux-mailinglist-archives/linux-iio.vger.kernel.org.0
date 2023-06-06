Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A405C723FD3
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jun 2023 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbjFFKlt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Jun 2023 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjFFKlK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2023 06:41:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2124.outbound.protection.outlook.com [40.107.22.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C0AD3;
        Tue,  6 Jun 2023 03:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Moh6fAuybGLvk0vehIIn0xGbBjDmzTOuAC7uhq5ppym7twdsWHZxMD6nJ0yDtTcS9UgrBY/1yIAbbel19twy9uuy75shRpiqQCuT+ssOq9SlUYULm2yybKaDn/0Vc0rWCUBnoWBT5L5PbQJ7a/oO5YfqXoaRk9KHumrX4gk79Jn28cjPucmomZnYvD8F92e0cJGL0TER5B1pT1lEzkVlTcV9KktMXqYRhi8Afn3L+kP6o6R9pD8pbl/XEsqzwKLEUnApvI+M9qpLc4DoIoPmibNmNWkGmfsnCm4Tx+eMw6XnRLiAtCE8moakG0fnMZtdCfNnV260F86EUmXr82510g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLnLwixFECpdUGD7Xlh//bwcbT9vqCFeRxxkxFe+eI4=;
 b=N35h4miXFqcCKf59XTiBg49U7llT1HPH3IYQa25NGl8Q8UwKC5o+ifvJGmH0RIsyHj+FfQ4ZMXNvu8/he77T04ogmAt3EdmnNNPsWBz74L9pvlxG0seSJnkSAVk6KBWWKH5wyn3cpH4fP7/4ZF+IakOf/uWgk08ksAHCELXW6xdlP166H1f4rwQeWuHgt/r7MHkcQd26v1OQq451TDhPn5bXajHjJbS8srAMDfAsUmzQM4mWO5gY/vTlfTNubQCHR+QeIJuPqNBqTeyNODizy0eNrImo0zTvdhwDY9v9XA8YMhUAAWd9MOkzFQOIjfmqdjRd0XMJh1K7c5oiS5MqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLnLwixFECpdUGD7Xlh//bwcbT9vqCFeRxxkxFe+eI4=;
 b=KLmf/KYuaReGp+zJhzSk4Mnh6WuJvIjtCuVVbRzC4ySf8Nrix7UhxPj05lBSlPuDUjnPSqXJB95CcdVAS0/OHPaV7EilW+TBTPrWU1kCZ9ToMknohMhVnb1hIjNF5G5HXPT3VAAPH9+a3CtOhsdZk2E+HsghmuJli3dtRcvCwV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com (2603:10a6:803:ab::28)
 by PAWPR02MB9221.eurprd02.prod.outlook.com (2603:10a6:102:340::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 10:38:38 +0000
Received: from VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84]) by VI1PR02MB4445.eurprd02.prod.outlook.com
 ([fe80::b703:24c6:975a:bf84%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:38:37 +0000
Message-ID: <f5e1ea82-75b7-8164-f82a-5ad6054ccb5e@axentia.se>
Date:   Tue, 6 Jun 2023 12:38:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Spelling
 s/curcuit/circuit/
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <a8597e54b55dedc51025fe3073d25ef0d659d0dc.1686045793.git.geert+renesas@glider.be>
Content-Language: sv-SE
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <a8597e54b55dedc51025fe3073d25ef0d659d0dc.1686045793.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0049.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::10) To VI1PR02MB4445.eurprd02.prod.outlook.com
 (2603:10a6:803:ab::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB4445:EE_|PAWPR02MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: af974ff6-ea41-4a34-56b0-08db667a2f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Un8Do94W4K3/i+KTQOM28pTgtYpq0Ccl98zHkZK8wVJ25F1NSJrfNgZRzN7M53HIjhoP6+9DFDmScJbXanpO4aO86VIwHMbRFoAWgGFPiICQrobR+BxhNqZK/69HcCQgH6rz/3IiPT3aBFoGgWBv17RAIMNgEqbn09z+o3tOHEyI3ztp9+kNGycZfiY1xBX5k50Mf5cuWj7LC8lGTLD3o8Ns7RjRjBmrxLz0nQ5MC1f6p09wnVEeLpEhhs1u3rD26uH+e6e3BWW7d1SpGhCDMtLPvwNkiwh7/ThXlKA/Q0RUxJDVJ7n4P0paO0VTQPtNt32h7+JI+5a2+TKCu4S+pE5gilHuwoicMBGeBBL9ivmGQLDRg8x9Dtvh+rTjLApq1v7jTfHOh0KizNKSKTytUTTlIT86KZCLe68dYVwVz4nbNzwaPwewzJIR4oskMuh9W9obcBiV4Ds9bh0qRAB9t8+Wbd16kK4fhYU3urWhwc+qyTGv1aQKMu55KrIeZrFTXYqyCHofiJJewJuaHD4VJiKAxSDr4acH150l/3hiplLgieAcZA6cOAR3I0yys0at0LvEbnVmtT13yiygYTPNo9ajPpCE2hbrNKSUxCrBc2mdHQi51b0xgF0ySYp++FvX58zRAX2FxN7/OzCAAPPHWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB4445.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39830400003)(346002)(451199021)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(31686004)(26005)(186003)(478600001)(110136005)(66556008)(66476007)(66946007)(316002)(4326008)(5660300002)(8676002)(8936002)(31696002)(2906002)(86362001)(558084003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFXNUZOZmxxSzVna0tNWWo0YVFBWHhodG4wRm5pMEljbkFFV0U0Mm1uQzVR?=
 =?utf-8?B?QXRoaTlTazlNR1JUMHBhMzZQQ042YzNoQVhibzNCc3YzcHMvTGpOQ3pqem9w?=
 =?utf-8?B?SVJUMjdFSWprc25IaTh3d1luRjFhMkJzTDRIYjZWbktDcFVCRk1jOHJEMkV3?=
 =?utf-8?B?dmtvZnZETmN3MEFnQys2SmFPSHNETnQvSThTMzJWSEQ4L0hSWHJBT1piRXZ2?=
 =?utf-8?B?eDU2elZoVm1lU1ZKaGdDRWFkZFhLVE0zL3NmT0F5QldsZTFOS0I5dzY4Mjhm?=
 =?utf-8?B?NTh3RVNvRitvK3ZURVIwVDd1QVZpeFZ5Njhxb3lpK0Rvd01IeG9TTVlDZG4v?=
 =?utf-8?B?MFJ4NmNscVZ2dGdrUitHMDFxUGNxZXYrcWZMckhnNmJWd1lsRDlrd3ZCQ2Ez?=
 =?utf-8?B?WnIvN3dVaThoOXI2clVGLzBTZS9ydWRWdFdiSjdVTVhCNC96TlhuZHZiMHR6?=
 =?utf-8?B?WmE2VDZSNmtxSytrTi9kZkw4c3BIMXhPaXp4M014TFNMS3cxOW5FWEgzTnN5?=
 =?utf-8?B?SlE2b1FUUG16YXREUkRGN3k3RFRaNFV4ZDFIMGpJdTdscng3Snl5enFIbmUx?=
 =?utf-8?B?TDlyMUVMZUhkdFFzSDlnY1U2WmhwRWtJaFVJNFYrMjduTmhMSkFiM1lPWVBv?=
 =?utf-8?B?YnIvQjd2RUZOTkNmaW1zQVR6Q3lmMmVEWS85eHI2RjNSQ0E4YW11d2tvOG1O?=
 =?utf-8?B?OXJiZDJtU29YeGJScnpXRC9GTWhSQ3pwL0c4dHUwRGFycGtmZ2RneWxrcU90?=
 =?utf-8?B?UkFpa3R3QUZBZWJjRnNHTkRNMGxqbWsrK0w3REQ5RnRWczdUcEttc1YvMzhp?=
 =?utf-8?B?dnA0QmhTVE5RRG1scGwvR1d3MlY1SUFaTU5qMWRNdmUzb3hydWM1amNZSHds?=
 =?utf-8?B?a0lYMjNHK2FpT01yOEFxRUY3ZDdhWVpGUlJ4djdkRW8xSmYzL1BoeUJrRUFu?=
 =?utf-8?B?TGhKK3NYSVN4QW5IZDllMWxHV2hlVW10WmhNTWNMWHFSOXlySjVOeTFiYTdh?=
 =?utf-8?B?bUhYVm1HKy9pajg4VmtkQ1NHVzZZS1RIckFkR1p3Sm5oZGRLRE9kSUxnb3Z6?=
 =?utf-8?B?b2JVbWVmRTZqc2c1Q1FGZkkwQ2Nla083Y2N1VzJURjdKV3NlU3FxYkFEaTMr?=
 =?utf-8?B?bGNsZXJMTHNPWWoveVgvV2ppaXQ2ckR2S0JOb2RhSCt3bVVzZitKc2ZqTkVj?=
 =?utf-8?B?U3B4c25lcVcvekIrVklPTmRlbHBZNzRaMFlvUXk3WWE2aEtMcHpXWSs0QXIy?=
 =?utf-8?B?cjBDNnNoVE9zUVZ4bVFVNW1Nc3M2TWUrY0g3ZGx5dXBVWWpaL2RDTFNqY0ND?=
 =?utf-8?B?b294UG5uaXFrbm1TeVVmVmpxdnZFSDFVY2NLVzZybHl3UittQVdZTlhYU2xK?=
 =?utf-8?B?dzRxNTRCQzZTZzVORnVpbWtvUk9VTHNhL1I5OGlBUkVMNVN4ZCt1UDRXekFn?=
 =?utf-8?B?eG1FeXBHbGZMZDNVSERDUWFzeE1FRllieWdsSFc5SkttdXpmNFdZRFpqcGZ6?=
 =?utf-8?B?ZllGeFZqbFNmNnBoUk9VbU1lTEl6MmcyNXlCRkw0WjlYSWRTUzMweG1FZjVB?=
 =?utf-8?B?VXl1NXZsQ0poQW03K0dDQlNNU29qazh3M09hV21ncU1FZkl3amxiVlIwZ1hu?=
 =?utf-8?B?NWZrMER6K3VRZzJ1VTd1a0o5Qi9TbUREbk4yS3lxZyt3ZVR0dEFPNStQWWsr?=
 =?utf-8?B?Vkc4UEtEOURmTTFXVEJyTThuejh2MVc3TnE4ci9pTzJDUTJXOEY0aVhZTVBS?=
 =?utf-8?B?YkIzTTczY3lraXp5NVl6bU1WZUJIZWZoNndDMU1YRzNGUzduTnhqa2dSdkwx?=
 =?utf-8?B?Tys2bSt2aU83UTduMWJjaE5ud2RlOWpxTFlybXk2R1d0MWpMSVBLaERqSVpW?=
 =?utf-8?B?Y3RkRkZyWVp5WEpadGsxWEJrZXJlLzVrL1ZqenkvWXl6Q21aQ0tOUjV1OWVB?=
 =?utf-8?B?dXpRWFYzamZORFNUMkpkTmxmVnA0dUltZEpISUJrb0NoL1FtZ090VVpqR2Vy?=
 =?utf-8?B?NmNBNFRjbkJ1OE5GZXBNc3ExRVByU1BvVjM0azBlL0FKUXBYdUlyVjNDR3Nz?=
 =?utf-8?B?dXVIZFE4SHVyaWlMVk5NQVNBY3g1ekE5czV2VU0rTjFLZTUyTVBXWDNOeFhz?=
 =?utf-8?Q?2qSJ4FpvUqLo2UzIATJbs/WaE?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: af974ff6-ea41-4a34-56b0-08db667a2f8b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4445.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:38:37.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fut20HtC9APxJv8DFOff3kQTog1FKz84hMAMw8UVqklrN8Mp/IGP+IKVHoTrfKSh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9221
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

2023-06-06 at 12:03, Geert Uytterhoeven wrote:
> Fix a misspelling of "circuit".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> -  a curcuit.
> +  a circuit.
