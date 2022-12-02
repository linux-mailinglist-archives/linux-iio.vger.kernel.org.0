Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E1B640595
	for <lists+linux-iio@lfdr.de>; Fri,  2 Dec 2022 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiLBLQK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Dec 2022 06:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbiLBLQJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2022 06:16:09 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2110.outbound.protection.outlook.com [40.107.241.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B19CCEDA
        for <linux-iio@vger.kernel.org>; Fri,  2 Dec 2022 03:16:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtQlAYx7x7lbEvrp46p+Q47rVm+epfJUemi+ggi87QyYSMYESp8Rd3vi785pX0elgKpGFJSi1iLSNUjna3e9GrLMRtFu39rfYrepKR5cmYkaqKbcraI9cX64bo/cOESUPVQp67uKYW85v1SPxycbBBuGlcR4AeYJSfh6Jc7dAoS+wCR+P9A37ouFWWQ7HU/7zWPyF8f1ifNlVh671ULRXhqi/+LAtbFnCU5ZTIY+OCMQ7TLJIdwIp5exY9QRJ0Rei0HtWFQOaSW7JEKbQE+xgsoWf+VvoDqQ0XGUzxT9oNtY8CFKMQIrBjDHVSJQ/XkdDFohj4STzxfhHr54aa/uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HukvezXjmxsu5xs1xqnu7OXyq0CkNaVIE9E3jVkSY08=;
 b=E/LobOIy0rsY7suEV37MZCPju3zzxTh9zmyPYdrvEh9lRU0kFhaqDjqse7QlVneVPTqjnnf8ppkEnrQShSvU2beihDRSXZd94A7lGSUyCGJTaYb0A2R3r9xlr5xvjarS6JS7VW82OyInthX/FCOurcdY1mm5zat3EQj4ud7JV7B3f0zmPNI5Pb71dYYa+6mpR1PuIxKsJ7ruehMrMqhPFPKFlFBZzJISbH9zil2kM2v7xA0xJhsTLxlnwHDYQ8eZeThzWHdqkre8lFrXFTv3G+VK8Cssi8HLABPoedBR/R8B/4ydIb7yEIItc0rJz5HTQd1jxVJPDwcJT4CYa9R7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HukvezXjmxsu5xs1xqnu7OXyq0CkNaVIE9E3jVkSY08=;
 b=mLYYzjrMSa63/b76vvRPFgB61rbOdo4VIa/IBhwIHW86duSP/SDBtIfGugqt+wNfSoGHAIWfhuF7ADzdl18LxcN4fnnPe7v0ZypreXSqSx+z3OhoHDEw9lxx0pvJhUWRp/c4HpYiQZITJUa8StCyAMuChqi+yACbPiu3S0jC6L4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AM0PR10MB3284.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 11:16:03 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%3]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 11:16:03 +0000
Message-ID: <b9e4c447-6bd0-9450-7410-6fb0b872dd36@prevas.dk>
Date:   Fri, 2 Dec 2022 12:16:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US, da
To:     Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: run-time change of configuration of ad74412
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::16) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AM0PR10MB3284:EE_
X-MS-Office365-Filtering-Correlation-Id: 2794596b-477a-424e-a482-08dad456996d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTI+aoVKwl1qlEsH+RBZbBIQ1O60c3169cLprWF/sDSlSiXdBl/6LKDAfWgdBZg2ULxbrHqNOA571k3aXokK4j4jPhqdQ/JpCE4ihOIbJq9lY5eQqP+5XISVEH1ITdGgqGT5JjEll0/b5jtB2EyQmmCIZmY4C+WjkrxXLpZRXkPbJxeJ4NQMPlXADiZR4QIskFQLeucy4jICy8/8KmtU/lN+RorRAj4wxdRsgyaitTEwkZeBYOcCT7cIzyuOGEWqN3AnQvs9WHzxXFoSu0jKauk70IWIOEu/HsrwJJ08LrpZtRwR0qes59Zl3UQfcSgeQqil+AZyhaI7bazIcGYyYt418mkKaGgNnW0YhhizGbjjZUFcDvrp/TX2LXwS+7a3IZ3YXK4HAiL6IzcmbsvEwFCYMvdb+EFY3IDYEsTiD4rFnCxUmswOQanlEmlt/VSeukw0Cui1Y7u33pZaj1f0s1q+IPJMZVRgJ2YTlhMGs0SFiR4KwWjTXedHlSO92nBSj2FYp4uDvTqVKLXbA42B0xwf1dLOTI0lTB6nYV4wgfUDFhqxXh03bpRMAoWI84XWPO6KjzG3pyvqnHP5ZQRnpW2vvbmTvoZjd0tu1E+YhRKnlgeY4a+8laE7gy+s04MeI9P7z0WPVmiu6Ztz7KvvGhkBaYrQ37v8ecfXWknia6CORepNLEaVtiFsydljfLceva/ugUhkpfj4JUKkSfHhGX6VB9sOxF8hPszhulcnqIwMVfHVrD/PTRcwJHV+2WcI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(136003)(376002)(346002)(396003)(366004)(451199015)(52116002)(6506007)(6486002)(6512007)(186003)(26005)(478600001)(316002)(110136005)(66476007)(4326008)(8676002)(31686004)(44832011)(66946007)(66556008)(2616005)(4744005)(5660300002)(8936002)(8976002)(36756003)(2906002)(41300700001)(38100700002)(38350700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXQ3YUdzMFFvbW1kR0dqRWJHUjZ1enI3cGlCako5Nm5rOC9Cb1pmbFNmOXF1?=
 =?utf-8?B?SnphZWg3TlhnbVZaZkNxN3A0OEJPY0hObnNqZkVKd25ZTkplcXFVM3dRUGRu?=
 =?utf-8?B?M093OFMzeGk1Wnh5bGIvL3l5VnkrM0pzcXpLRmhmS0VqUHdjQkszWmR2MGV2?=
 =?utf-8?B?aUFMYkFaTWdKY1VMSVpKWnJzVGZSb2FEYUswN2NCMUhGQUV6cjhITkVNNThw?=
 =?utf-8?B?a1hxa1BNblEyQTRDZlJDRUVJb0RNWmxwWERsRjJlVEFDVlRiUE1pbk10ejcw?=
 =?utf-8?B?L1VjZTJuak50b21qVUN1L1pWSytHTkVpNVNsLytaYkxDQ2h2RUd3V0lRalZJ?=
 =?utf-8?B?aWFtTzNsS1BJcUk1dkxZWHhyYUh1b3lONUZNa2I1bEtmc3RmZGpnQmx2V1RN?=
 =?utf-8?B?eUlPYWlWZ1FVWU1tSVV5U1V4VHVIbitrRWV1ZmhaTVRaZFR4Z3h4Q1FxYjNm?=
 =?utf-8?B?VmQyUjRPU2lBckU3eit4WEk3dFNGMmQvYjFVUnRIblkyZCtQbEYvMkNVLzRq?=
 =?utf-8?B?OWxOMFJlREFmZXJTOGt4dk45VWd6MFc4SkJCUmFvVTlTT1k4QVFSYy92elk4?=
 =?utf-8?B?NElMNkpEUG9EMHpjaGlodU5UdHJ3a1RlbTNyWll6UjBFUk5Nblc0YURnUHhw?=
 =?utf-8?B?OVVEZE4xUDFFTWlzbzB6OFZwRTZTY2tSeHVnQi9Uayt5cHdPMTBwdzVuK1Ft?=
 =?utf-8?B?Skd0Y1NPdWxxQng5dFBPWVNWMHJWRDJBRkR5dlpsTzhVSVpxWEZ5UlJxZDlH?=
 =?utf-8?B?ZlBZWjdJTE9QMVpSTVM1b0dYc3lLTVZROHVndWdMcVZxRmhSMmJVSnlwRGZh?=
 =?utf-8?B?OThOV0hmY3F2ZUhpdHhkZmZsNFpuWnZQSVZubUtDUFptcU1FOHF6bFBNWDFx?=
 =?utf-8?B?NU9yK2M5VGxFVzhNdmpjTElPdWFHdlFRRnFXUkdlTTBPNmpXUkdIdVR5QURi?=
 =?utf-8?B?RzY2clJCSjZzeU5OY1lXS3o2ZWd5WjROVTN6aDEzRUh0VVFiUC9ZZExKbXRP?=
 =?utf-8?B?K3A5M3IrUmNlNzVwU0haOWd5YkxINVVlL3FjbWNKTnY0emp1dzhldDRJeXMy?=
 =?utf-8?B?UWp0OU00N0NKcWtJZ0JRRWRFRzFBTmQ1NTdnUlh4NzdaQWwyTlYrYUhXRkxY?=
 =?utf-8?B?ME5SUDErUEZLWmRoRUlDaWxKMVpiRTVWMDVlNUNnaVJYRlpBampqTk1ZTll5?=
 =?utf-8?B?WS9peEVQUmpPNG9lSEJyQ2hmVW1WOEJjaUhhZ2Q3ajZYSG5GUmQ5ZjFmcXMw?=
 =?utf-8?B?SHlpcUJLdlUxM0tFQUgrS0s5dGZjdWJYM1lmamNDaEM3K3ZuUmMxY3hvN1JP?=
 =?utf-8?B?SG1QNHduUUhaWkRnSWVPL2hCOEdSVEpEbHpocVZSYlhZZGZWT0hSV0R0UGMx?=
 =?utf-8?B?UXFsU2J0MkZsN0JRdlVHZER2RkRMQUNnQUIzeEtzQU5vRHM0VVpVbG4vNjRh?=
 =?utf-8?B?aCtqNjFtS1hvSnpKN1FjbmRWV2sza3czR1h2eXJucER4RzhNMlQxaGlKNVo0?=
 =?utf-8?B?L09IaGZZL1oyTjV1bFhMR1dLb25ieUErNUlDSkNJMEdPNjlkNmE1RkFITkxO?=
 =?utf-8?B?TXdFYzdtUEk5T1ZVeDhvTUg1T1BQS0tyV01hNjZTOW5neURoQ3RpL3NQZ3Bp?=
 =?utf-8?B?QkJqaTV3WnJ0bDRZSElHUklyVndBY2UwVUdPck14NWhTb0lZeXdOL25Yd0pz?=
 =?utf-8?B?ZG90N2VVM0RRRTlFOEQ4dGswMGp1dUNRVmhLcjV4bmlEWHMycmdBSTBCNjJY?=
 =?utf-8?B?UGh5NXZuRnNNSXVmcTBxUzFGSll2dTZCclBaS05yNStnMHF2NitTTG53bzJL?=
 =?utf-8?B?cGNFNTE4SlhEUFpCai9qTU9sSUhvSnNLWExrSWdZQkx1OHlnc1RmVEdkT3ky?=
 =?utf-8?B?bDNqckNwZjY4RUFJWGZRdmh3MnA3cktYL0ZLTUNVOHNlR3I3cUxqSkVBM3Jm?=
 =?utf-8?B?ZDl6NFo5dTRyTWpZRmcrV0tROXhpMzM0clJ0MUdSZXV3cTNDTW9WL0JDVGJ5?=
 =?utf-8?B?QXErZVhLZW5YaUFZeFpBVDBVZEM4QVgrR0VRYWpQdTcxd09xZ2JKZ2xuWHQw?=
 =?utf-8?B?eVJWTm45eHVoZ0w4SitRWERMdEd2Tm1TWTVjUktYeUNYSDRtTXcyRnhZemZv?=
 =?utf-8?B?Tlh5eGkveGoxTHJJVTZISHBCaVN4YSthMXluMU9zeExCbUtxWmlVdmhmR3ZT?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2794596b-477a-424e-a482-08dad456996d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 11:16:03.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5odcDHgwfLzvP7q+3SJaJ/RVHihmInkhddPIHjWNI1nW/GNAP7EJmvh6XO62kO5AqQHFCf4fAI7XXCGzWkeYaJj4zJl4yci3709+gdIEriE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3284
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

My customer wants to be able to change the configuration of the four
channels of the ad74412 at run-time; their board can be used in various
scenarios, and having to specify the functions in device tree is too
inflexible.

Is there any precedent in other iio drivers for such a configuration
change, and/or is it feasible to implement this in the ad74413r.c driver?

I do not need to be able to change it continuously, just once after
userspace has come up and before anything actually starts making use of
the device, but it is not possible for me to know the correct
configuration in the bootloader, so having U-Boot patch the dtb is not
an option. A somewhat hacky way would be to build the driver as a
module, and allow module parameter(s) to overrule whatever is in
devicetree, but that doesn't really work if there was more than one
ad74412/ad74413 present, unless one invents and parses some weird syntax
to have certain settings apply to $this-chipselect on $that-bus.

Rasmus
