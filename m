Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5B07A122B
	for <lists+linux-iio@lfdr.de>; Fri, 15 Sep 2023 02:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjIOALB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Sep 2023 20:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIOALA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Sep 2023 20:11:00 -0400
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8C2100
        for <linux-iio@vger.kernel.org>; Thu, 14 Sep 2023 17:10:56 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38EKYfux029572;
        Thu, 14 Sep 2023 20:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=selector2; bh=iQpv07egPkleiPAOzCF4
        4B+NWZaSds+Gug+1B1kcw3Q=; b=tFwjN9ZixlroY6lmeQ95GxVv46MLRY7VAagm
        8uply9vr7Wi5mfJf5UZ0ekhjT1ZnMak/9qa74zFJU9fceV3PMExWUxYgEWNyDMyi
        t3OyDbCFqeQuCeSTrI3ouCnmucGhq+Rf8KGSWppSoyhoJzneOB1XWwbBs+H/CEyA
        tnvsVfTeqbv4/yj44xxIeZfbN/CYbpGzn3RzuUpelt+Pzsa+yuRkPM3ofDHcOtkC
        67lbZ9V+ke/7JW8iv0B7sVGwY91GpWC1w1Z8bomiDAgYWP+fYHEBUlG53SMv9oAd
        NNZzRnAtPzAp8xoG4+aXLT4upDly23fjWmKXjht3NGgzj0QPfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com; h=
        from:to:cc:subject:date:message-id:content-transfer-encoding
        :content-type:mime-version; s=selector1; bh=iQpv07egPkleiPAOzCF4
        4B+NWZaSds+Gug+1B1kcw3Q=; b=hlliSv8Sfkmx2kYp2ShS8GRSnUljTu9DxZvg
        mrRN/Nf65Ow2DzY5idXWPTnwEdzpjL5lM54RT8H6Fy9HBwCZqezL1TH0pB5MsqYj
        oQ+7eu/LFF1LVt7DsweTbsJJXwVdqn/r3LXy1VPx70wgHzlG0iE+7hdvnemRybtf
        Rghp+3bJfN+ojcX/oQ3YAWI39yfpQlob4FqapUDBNLadCGUi8xISY0ekSEPjamXE
        3hJXwXn5MReLkqr3yl+JC/hwgOS3NbuEpbAKOxcGB2dSS0oe8Dk7agGYftOB4pfk
        /gXcstix3l9sgv6OkN1UX8FSLrGdxxD5fk3j5bkmmjzQ+/qLow==
Received: from can01-yt3-obe.outbound.protection.outlook.com (mail-yt3can01lp2171.outbound.protection.outlook.com [104.47.75.171])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3t2ybea4rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 20:10:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktdODm08dOB3qsQO4jY3/+Rmn7Sy4ucwqZeOHonVsZFfBa+9/GujJ+d6mxu/Mm8mmML8dDkOEYxNfwPVeYsiObJKH7Zx31c8Ts0nvMrTwUFkC5kK020ushKTfnryJLVete2yXDHHgKXtMa4nCsMfRfxU5weq6QiplSEZh4fWGxCTd+YTB3KaB8SioMvCYhIfjz/yhBWYcRBEH3m/Zazbq46+hp4/WRcfoLoUaiNn4RjxHuuX3Uv7+R/D5UkplQzp9pSAaWycAsuIFr7hdohkebtBJ62FCfyD3It2yYRPQAZ8BCRxFzpVrDK5sg6isznNuIo+BNAqENYeh6JlXUUkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQpv07egPkleiPAOzCF44B+NWZaSds+Gug+1B1kcw3Q=;
 b=gs7gikJaG+USjr/3kpgK1uGoVqFYDxR30W1/79DdXMUn00z/D/ZITVk2bvAPCqjXGnprivIuqPqSL46QzpcTW7uMtDT605mwGchkqUuBlp0SQ6dxtSo9elDAgPIy89u3WF7Yr3F8WOxtSKa6jqJ30My2bnRFHCvhB7dtdFnCIt6ivQoaXzxei9gUvg6GgpR35+3kLk3dZk3nnf7fWnH5kw44sHf7IYpMEpPvENhkF4F8Rwc6bctKxybY+reoaOXUMFSJylM8/PDNufH1eNtfLfeL565dAHTq21WgFM2mfeHXtNF+euuebxpJUabBdy6oh7o82gg7otqN22zCbA5xcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YQBPR0101MB8912.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 00:10:33 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::cde8:7c8d:8d0a:8aec%3]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 00:10:33 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@amd.com>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH v2 0/2] Xilinx XADC fixes
Date:   Thu, 14 Sep 2023 18:10:17 -0600
Message-ID: <20230915001019.2862964-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::32)
 To YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB8838:EE_|YQBPR0101MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d36ad05-b896-4b26-8453-08dbb5802dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRizgdktNN/xXCRQ5OtIZgpi0SF1i/Zi+jCA29TA+v1PqFcOEOoC6BZu8Nho96/IXKI933/Sy88RrbnZGGFYiaWyMaFv8393rsa5R/bQlfqwUhgY6BgFJTKyfkvZerFNliR2Y1eHQ0SOarcQRmVMQoZYEJtrwSGOK5X60VP1LCtaogSEkcnwAQKigkGIiANsa5AnCUA+gV8MFWzjlk/skB8GEFWebjXkqrnMGRNpfAqmFJvgtbOtTwgdDpNkhNz2sXM9i/3KJB/U81FIUFpNDKhRrW0tQWRblo7L/eF4KqvN6Sq60Bn0V6S6vee/1c4TMqujH+OP3AHxAfSby0oDF6SDfVW1gG2P+ZDMvzS5fyXGLcAXKD07uDHfxiQXA06uQHj2FWCBKAz2l6PbAQcicqh32GyktjrdgsDNld42p4wftT0Rnyox4USiShx78IhpiBTGlr8d81moUx2ECTEvxMfTv9kWrDK/JPJIP/mbSqbqr21uSSOUyYT0VJZg6Yfdx+gO6HR34kAKFMoScMNOOPt7gGRYZd5nc6gd/wy5AXngg+BGMiXmW7tM9T5ubOViHxcx99MdLQuxVKb3dFvlbo+XrRGYGVWv0IWqufzrwmZ66eOZeHtgDxuct+6VVBD7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(186009)(1800799009)(451199024)(41300700001)(1076003)(107886003)(2616005)(26005)(6506007)(6512007)(478600001)(52116002)(6486002)(36756003)(6666004)(38100700002)(38350700002)(66946007)(86362001)(66556008)(316002)(66476007)(54906003)(6916009)(83380400001)(4744005)(2906002)(5660300002)(4326008)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WTAOGnhswsCYfnY6Si60ySRmvDF9kvX8jjnSscHySlVj6CJAzKNRdHArXtdg?=
 =?us-ascii?Q?UKkbWDJh6mfJ+XxAMO9CMoEZqYLXjd2+9dTwSYSREzRcs0FUC/V0WSNF2zvX?=
 =?us-ascii?Q?cbzv63t588GGspkxJktl7Rl9UGlHomp4K182QH0ti61QHBfWkb0LJNYTDyx7?=
 =?us-ascii?Q?hi0ahFuntZNNyB2w4cKyezjLXCWuGO1eZTScMTQNi/kLGiif3x6aRTEiGzs1?=
 =?us-ascii?Q?Kwxd83ugPygKX7w1G2gbVFsbTkA5ZzC9y+ZWfhFkzvXVMJbC+c6U7DSpyrov?=
 =?us-ascii?Q?RlpM4nc68+gU5Eiyy2Y05v2NAiDKcjkK+Juxm6mZn8K8Gr24lYqV6kM7lHqH?=
 =?us-ascii?Q?LQVLIzbILKxkrFYdJsgFEKrlyA+FJQVPzsmc/p0N2tR0su6lhgTqB36nhvKf?=
 =?us-ascii?Q?5tkez3hvDlJ3PZzluPX59SfVVbtdYHE4zJQ2gyK5Llxl+I+B2/NEcwlfWYVS?=
 =?us-ascii?Q?V7GPXE2Ge75qizrqUlV1N4zUqTSZxdxfpxD9IEfICXgM1clD6+n/khHJVgNg?=
 =?us-ascii?Q?wRPE5tCtVIHr5Ys6GRMVsztyZnURLmbNc0URMW0QOAP/DUq5jL2e/k66kvjK?=
 =?us-ascii?Q?f6dsKpbSnLuq8KNwmCgX5aNArmW9qoxrebKoTTItkKU838KaTfDDukxUVqa2?=
 =?us-ascii?Q?dmjfpJcLFlH1x3ioX5POi3o82PvB9DbkrDw0g7uR1az6ihzUzHDzulUhKIKX?=
 =?us-ascii?Q?yjbY3jl9ZZkAxhNdoZgqynHrSIQFPySFqlfTG/Q/NJ4N+cAUlqXJFygEcy7K?=
 =?us-ascii?Q?SXXfK+42bfLg96eXU7gLamCrPB1HiwIjjN/TBs49qiyHGokPANJmy5IvEbPD?=
 =?us-ascii?Q?HGyF5LXPh1orCBTHgvmLhiej1N/HHyUidNce0KfyGFvay5W2bh9hSvm6jyQJ?=
 =?us-ascii?Q?S6m5SeEL4ns26YWGR/ooOxiRA0IlrS1mJ+iHUYE3YidIqcEjxghqgmm6eEqZ?=
 =?us-ascii?Q?xL6MGmCfZa8vroTIg96a0FyhaIQvxJFXtaaVM9FiVAKC0I+UpnYWMv/QfJwW?=
 =?us-ascii?Q?chgf/M8KC9y/BoOxtv1nQVQB1xXkWwx+81/B1bGNDvpY3SCg0x2hw7oYTVlY?=
 =?us-ascii?Q?4i3RVEVWRik2VHnjgyvR+z4NLWBoa3mc5UsE49bQ+A4Sx1DsuWPNseBx80dq?=
 =?us-ascii?Q?+EKxAqEAUB5IYeLsoYqWv/WMaQX/Gme8pWIkAT4UY1EUYm7VTCdO1qF+nwXD?=
 =?us-ascii?Q?/kPyiTMZhg4g2Tiv7Zxm1odZjEzezcnSTeI2Ty3748D+/kx5hvzGaUEKTfzS?=
 =?us-ascii?Q?WqaMZ2UFOeJiHgcD2wjoHkdYfHJckFm4hS/i6ht7JepAuRjEAAO8NKP3SRxY?=
 =?us-ascii?Q?MuAvyawkds+/OQJZCEJ+6fPTJTlSPIsE9nmdzYxhErUS9yl5E2KAcvu5rOlr?=
 =?us-ascii?Q?aXMjdD2GOycsrwjzgSkzMsl9jeZ6Y/pVT4hmKIy64bP+dOs2SBIdm5yRxuQO?=
 =?us-ascii?Q?ICNgIA6WbEKr0fTgZYb6CrNf1NVIXeSH/59f3W6pkaTqB1L6hszRQApnzbs+?=
 =?us-ascii?Q?OUR9AQGRscNRt0WkUK8syenep6xe4Eaf5cKnJyMLAi/1fa+HsuUb22sB3ln6?=
 =?us-ascii?Q?laqUBiNg7Ek36b1NWv0ScZXxzYxFTkHMcL4UqEsFHkt6xo9Z27CEGLt1QiCU?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: k550n0E/92vW0ZV60SWEZFnNJpTuoIQPMyVaAftMIn4eFiTjwFh2V6SzBuTEq7Cw9KeR75Ws0xC3wwVQy/OC+OvxVK/hIP9ZghpzDl2uL86Eh8bOH5/RrRR5KpGjM3HFUWFfTkkPh9wt8sAYC679HWnkh5a7fQ+KbVplCfbvCBBu6o3IcADU9fSE7WiMg84CnQakyJ9XSo0Ut5517qBzRVoIS+C/eFmueJs3cP2oA9fSmf+SbpXHs8rCt1/EEs0ddeRrWIFMTFxtwcuwFRK5IQtEN8wiD4R2CWkloLzrcmPihARVskLKwSXZ9v61ZYNbtA0JXuaA/XUTPb8JFkxQoCaAHomm6ODa14L28a+WkH1jvKnFvQ1Xgb2f8nnxiSu19IghHgvfFr7/v+Q5JNAKWZy5nNRbYnfMu7PK+3Ctl2Ms4/wR2CWpskzGs8XHcRu249zt2mjxU3GI33lzsfoU/C0Tl6ip4c+4Qds8qLyFTCtFY7Twt5aQQw3GoUppWVBeBLuxvTId2j6ogx4MSG5AsGn4VLbwAg21QGaJ0Zc5pwOO9gYFljClKbKr+E6oqYftFGRB22of+CPjIoJfE/Lgrwnu9kqadX90PBDPhnsq1PMJpe435ZsEZdHLljQbRnNIKdEn+gkFiqXqmk0PaOzeAzhnZkTH3NxSvWdJyzv9r05ZGZTlZK4dwRC6tFLRDoKd7eo92tgAfREtTIb8bcdR39aIBM/r66fxd4BLsfmUVDXWyT0gJ78jmt/1kSRk5iVRM2DikCGkMS41LJSxajigI8c0L3p9k1Umf3+QbStO6Pw+nksdw09+HUQM++Z4Y9B1StB7elQSd/XuPl6FjfpU5H1tN3BKDDOAUO3asz7WYk8Jr0rgcPC3kSqHda88E3HImUfOjIDmpk6BvvuoJ9MCREj8llQ+XDfyjCjXv3x5yCA=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d36ad05-b896-4b26-8453-08dbb5802dc6
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 00:10:33.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwEnj68ChJxceVBeCKP8yIqG5tNi6rM7/c76enXXL3R00hVrNZFnqMmat0cr8gDaoudzhd4FRY6fc8mUNtbgk1zN89FSWGXmOpe/uxdIupI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8912
X-Proofpoint-ORIG-GUID: 8X7DsCyDozdmoqzQlwi9WxtlQKc_7UhW
X-Proofpoint-GUID: 8X7DsCyDozdmoqzQlwi9WxtlQKc_7UhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_12,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: orgsafe
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes for a couple of issues in the Xilinx XADC driver: one where
preconfigured temperature/voltage thresholds were being clobbered and
potentially breaking overtemperature shutdown, and another for inaccurate
temperature readings on UltraScale family devices.

Changed since v2: Updated to also remove disabling XADC alarm bits.

Robert Hancock (2):
  iio: adc: xilinx-xadc: Don't clobber preset voltage/temperature
    thresholds
  iio: adc: xilinx-xadc: Correct temperature offset/scale for UltraScale

 drivers/iio/adc/xilinx-xadc-core.c | 39 +++++++++++-------------------
 drivers/iio/adc/xilinx-xadc.h      |  2 ++
 2 files changed, 16 insertions(+), 25 deletions(-)

-- 
2.41.0

