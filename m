Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F46BE6D8
	for <lists+linux-iio@lfdr.de>; Fri, 17 Mar 2023 11:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCQKdt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Mar 2023 06:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCQKds (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Mar 2023 06:33:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA7637D3;
        Fri, 17 Mar 2023 03:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNBi3qH2JzvJqNhK1XCsk3YXfFTJgAYabvd+kDGFVD2g58XNumcG341cbcTXrmGuFAk/kn/Jsk39GPYfteHRpplHDW9Taw0J3iCJND6+TgO8xyxhUHovPiAnVXNmXIUSYX59ATFdM6e5DH27QyZ/a7lSbG5eoFYexOxrcbY5eVGE25ORZGL9KhuWpexZgsKds7nz6SM/d5gWRNyhCwYIhjhJDJZYY0eD6+nuW9wX1/J189ppR5WLV12WYQcfJXzPHxZMykHeuQciWXTC7t7H7HjvCs7AAa4B8+MHAzoeYCSvAJKDz8nAEM162MwsJXhn2XkYW2i703iKe/3h4J/wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpH89EnSxr7rEcdtBsoYimy48Gk4J00Ygp0DlPik1qc=;
 b=f69SVgAvJyi8ZQgNgFG1eikVUsetI8XMR7/amCgdyuOlRqPRt6cfS+04EO05W0abnFJzYrPw0slcM3nHwojpKhw8IjZQLsUK2gqVMsnDmF9ZhNPmgHvqZOdB9OMb+Zn15aHOG0lE1zycpHZjpZoaC2uUsu6WPL5YK4e5at9QFnoq8DLJvV9vA6QeDh+FUeks6RpzTbGPEmOogqnPsVr8ZmpcVzywj/swoNwYOVJhFyWXuOcbdFNopnf/zQUKQDZppNYvQj5+1q42d3STupbRGVHkm8+uLZJ5Kn1GNXzf2fKJWocS/2dl6jU8VBCaSCP/d/G997WVmlb003LXGmbh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chargebyte.com; dmarc=pass action=none
 header.from=chargebyte.com; dkim=pass header.d=chargebyte.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c4c.onmicrosoft.com;
 s=selector2-c4c-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpH89EnSxr7rEcdtBsoYimy48Gk4J00Ygp0DlPik1qc=;
 b=M1SbV9p50WOhRJP7g9lDhpQgDkOgd2q0Zsn05ZIh6Ae/R7JiPeFUa+8XkaMcyMz6STf+ZNzuZdYx2kN7YqsimvXIxGTdmueUcA/B1EUqBgnwejeTypVBo+FY121ViuUcynM6r0aB1gOMMpztFa+NiaoQ1gvJ92E/ZuhteWDYJTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chargebyte.com;
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33f::5)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 10:33:40 +0000
Received: from DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e]) by DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::92e9:73c9:940:579e%5]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 10:33:40 +0000
From:   Stefan Wahren <stefan.wahren@chargebyte.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Li Yang <leoyang.li@nxp.com>,
        Denis Ciocca <denis.ciocca@st.com>, soc@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        Stefan Wahren <stefan.wahren@chargebyte.com>
Subject: [PATCH V2 0/8] ARM: dts: imx6ull: Add chargebyte Tarragon support
Date:   Fri, 17 Mar 2023 11:33:15 +0100
Message-Id: <20230317103323.7741-1-stefan.wahren@chargebyte.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:33f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5211:EE_|DB8PR10MB3863:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f58159b-bad3-47d8-beaa-08db26d3130f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULe4zf8M7nBle0seR0jKDiyU0JNBj3AxSgwcOwP3nAv5U8qvm3xOlq2n49ulHmWoYKWVhwe4QdDDNDJzu4vcLMwlgb5LzBCvcgT8LRGSiQvLWHZX7CAKWFz46RzLy+XzlLeyE56lqDYS6Wep4+eebUnPK5/gwwibE0IQaxaQg8bJh959zP96gRFU5f96QSLpJ9kMMpc7IfSkJ28k9Zn304gZOuZMThcsyY6gOzq65TYE7qhlUoaIX0+tBPzb3AryNeldOPHM3E35PHYsr3qBtMbMXVwtpph2F0iLMl6b0f54ZfeCr860yF8AyX8pb2Do8OitdiHGEK9vFVwp7tb8sIAlsScm2k5MScamd1GqzkRV1dOnfLYWmJuEGC2no8Sys3yLN3l0CmCdydZSwtRiD/o/AmtArOLfQSkCM4yaN+DDjdsaiiG48MvQcjhkf00C6gIrBfjtwjXqqcz6sdAmIVNIhzubiYn7uOeUs1lMSaOwLZRMp1Cnsc3gvLNQ0rFL+RchgMsRLjP0aOImbQYogsZYMyBRlOS1+en0vestpAgiGxxSslE28Vfi3O9bn0zk+2qQaM9Bn2sS/xi1kq0Tky17sN5Lg/HimykrfOS/a/dwVCUZP9OJxKJASw9EUyJ5emsqRuAuclK7P/NX5OijSI1/rKnRO2CMnLkPFRVo+leB9DHTsSKvews2bcioPEtyF9VeBh9F1+53TR07iUw6v90i845Oq/muh2JjU0n5NFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(451199018)(921005)(38350700002)(38100700002)(66946007)(36756003)(7416002)(478600001)(86362001)(4326008)(2906002)(5660300002)(44832011)(8936002)(110136005)(8676002)(54906003)(316002)(41300700001)(66556008)(83380400001)(52116002)(6506007)(6486002)(966005)(66476007)(2616005)(107886003)(26005)(186003)(6512007)(6666004)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+mmJG9Zqq/zogdrPaumuDmiTkNJpBADbXg2AwviJfLzSzycG5X29OkHMyf4?=
 =?us-ascii?Q?F508aOtA2VKh2vzXj8ZFG+Ble5ZrvfX9B5iCRdX+5zTcQzCOua03oh5akSGy?=
 =?us-ascii?Q?hl5za0n4U3N4imXDVy/Ak/6xBL/0qBR5hCJMY3x/VwB74lzeuIdsX9y7wAaU?=
 =?us-ascii?Q?dwLoKF7oUsgddh0lXA1rPu3qKljSQeCFP4sIUKNr+SoZ3AZ9e2MTzYmynGya?=
 =?us-ascii?Q?d4YGrt0QTan6kDIWpXxSlZW19onCzxxB0KO4M+0aInK7XquV8CjrdOfbLgEK?=
 =?us-ascii?Q?BfooXGpJuA07aivaGfaM4zDqdAAtPQGMpHtiN/PjFuJe1+EX0KgsuRZDtETV?=
 =?us-ascii?Q?xjjnpQl60b0GWr9v2XTJyJzwSUmiOIiaIaLdYPGyVeKRjjSMaVeJV2lWlHSC?=
 =?us-ascii?Q?fspLdFgaqzkADdySHUftOiWo6t+YnGrwIKfjfM0cRLx02wlkkSIZZkKIsWDi?=
 =?us-ascii?Q?mBE0iWatJ0v5wdW8qJXHHJhnyJrfDVvIgoWeRmCZ4R5WqAFsRstXwT/8IXVY?=
 =?us-ascii?Q?krQJ0xQ5YqzbhimkVT1ezpuUrhEmL2cQxAXSpcb9oG87vAL3RUZwwe2JGVm7?=
 =?us-ascii?Q?qS4zU3HOoqjJv+o8I7zIhJQ296IYN/KNgLc3j2eN3ESeXkF8sK2zTonxnosB?=
 =?us-ascii?Q?Fo+6PQQBg1G8oXsQcvq/g0GLuTCgoxdIP6EhGjSwqlTsk7whSyiY89tq4VR8?=
 =?us-ascii?Q?G3qUXQWOTRKSqUSRCS7W/AZ1dop+ZtkpOAgfe9gDqucyYEG3G0cx3Pl/0ECN?=
 =?us-ascii?Q?j+mO2BqyaoPi8KofSw6poOhAoSILnsEgL9+5pGu8+dJqdZBBJtAGd9LNEvLu?=
 =?us-ascii?Q?bfbX6Bgm7tQ4W8cpkqOI0u+0Fop0Rl9TPuEkXbMU8l5xmFrXitNZiqv7tr63?=
 =?us-ascii?Q?ev0O9ZviXWoA3pBMuedU6mkPr+vGK5CNNYmwgoBsFsdIY1b4nH3XifFxx9ak?=
 =?us-ascii?Q?TKGjc/DPBNLyfKsKY98y/VvmGgVms+aEYIc624JqrLTqYoIFAFSKyXrvvUve?=
 =?us-ascii?Q?GU/o2rwKjDmOhD5tytgfUWkpYWOPLyVSKuE/2QvfHuyWnl1CXoG7tGyO+AQi?=
 =?us-ascii?Q?GNSiqo4zStiDudl9FTornynfVXa2Txuv+BCucw2ETrimLhaGKmi3AgeE1LAI?=
 =?us-ascii?Q?Xz6UNTleweuVbOhtIX/3mDgI/pfNPps2i8swZkabB+swloz0fxzS7BA0PAHW?=
 =?us-ascii?Q?nif1fbvLsK7qdVFeQunShpAe10+CECjnGvv12skhQPivYzlYQeMVEdFn64Tt?=
 =?us-ascii?Q?k0lvQL7uP9H38vhlVdDVAW3SSELCzMrLxdX83AMXoLAKpz9taBiDuza8l+5i?=
 =?us-ascii?Q?rKneAiSdAsrL1Yz97GMAHGuctetYm2h1F48rhziPuCG9yucIou9jfcoSK4jc?=
 =?us-ascii?Q?JlbwbVVxBrKeovu32aRzWOz0+PN8OCtWob5nr8vu5Of30/DjW4pyqwVhR0mo?=
 =?us-ascii?Q?XKKAHIX7oNQtLBVL2JT9V6NVrp20zmKpC8SZQjstT2hTNE8JvRvHBie2xK+H?=
 =?us-ascii?Q?NnNaGe5vFt0rI+oDFpJNvAMhPvbxvJ9fZRd9bYrfZBzgVIFUwyAgq58AOZBL?=
 =?us-ascii?Q?M+bIGgxd4oMzjbq2XJsH1ic38s6T0Hdjr5ZG3s2apex+1Qu+qg1aOydN502G?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: chargebyte.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f58159b-bad3-47d8-beaa-08db26d3130f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5211.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 10:33:40.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 30547194-0d55-4a2f-900d-687893d3bdc0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkMqmCZ6h6VWV20du14wwrb12AxZcEFO2iSMsGX4iTVr3E/h9weclxTOwV4fqvOj2pv3Fh+UM8+b6bCFnxKromA5ExuzWZ6Z3bobi7GAci4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series adds the support for chargebyte Tarragon, which is an Electrical
Vehicle Supply Equipment (EVSE) for AC charging stations
(according to IEC 61851, ISO 15118).

The Tarragon board is based on an i.MX6ULL SoC and is available in
4 variants (Master, Slave, SlaveXT, Micro), which provide more or
less peripherals.

Supported features:
  * 512 MB DDR RAM
  * eMMC
  * Debug UART
  * 100 Mbit Ethernet
  * USB 2.0 Host interface
  * Powerline communication (QCA700x)
  * 2x RS485
  * Digital in- and outputs (12 V)
  * One-Wire master for external temp sensors
  * 2x relay outputs
  * 2x motor interfaces
  
The Tarragon hardware is bundled with a charging stack under the name Charge Control C: 
https://chargebyte.com/products/charging-station-communication/charge-control-c

This series is rebased on top of:
https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git?h=for-next

Changes in V2:
- after fixing technical problems send patches directly from chargebyte address
  and drop the related signed-off-by
- add Krzysztof's Acked-by
- improve commit messages (patch 3, 4, 5)
- make iis328dq fallback to lis331dl as suggested by Jonathan
- fix order of Tarragon entries in FSL schema
- improve Tarragon led node names and drop label as suggested by Krzysztof
- change Tarragon SVNS pinctrl settings after internal discussion
  with chargebyte hardware team
- drop broken-cd in Tarragon common DTSI which is not necessary for eMMC
- add no-sd and no-sdio for eMMC interface of Tarragon

Stefan Wahren (8):
  dt-bindings: vendor-prefixes: add chargebyte
  dt-bindings: Add DS2482/DS2484 as trivial device
  w1: ds2482: add i2c id for DS2484
  dt-bindings: iio: st-sensors: Add IIS328DQ accelerometer
  iio: accel: add support for IIS328DQ variant
  dt-bindings: ARM: fsl: Add chargebyte Tarragon
  ARM: dts: imx6ull: Add chargebyte Tarragon support
  ARM: imx_v6_v7_defconfig: Enable Tarragon peripheral drivers

 .../devicetree/bindings/arm/fsl.yaml          |   9 +
 .../bindings/iio/st,st-sensors.yaml           |   3 +
 .../devicetree/bindings/trivial-devices.yaml  |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   4 +
 .../arm/boot/dts/imx6ull-tarragon-common.dtsi | 856 ++++++++++++++++++
 arch/arm/boot/dts/imx6ull-tarragon-master.dts |  82 ++
 arch/arm/boot/dts/imx6ull-tarragon-micro.dts  |  10 +
 arch/arm/boot/dts/imx6ull-tarragon-slave.dts  |  32 +
 .../arm/boot/dts/imx6ull-tarragon-slavext.dts |  64 ++
 arch/arm/configs/imx_v6_v7_defconfig          |   6 +
 drivers/iio/accel/st_accel.h                  |   1 +
 drivers/iio/accel/st_accel_core.c             |   1 +
 drivers/iio/accel/st_accel_i2c.c              |   5 +
 drivers/iio/accel/st_accel_spi.c              |   5 +
 drivers/w1/masters/ds2482.c                   |   1 +
 16 files changed, 1085 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-master.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-micro.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slave.dts
 create mode 100644 arch/arm/boot/dts/imx6ull-tarragon-slavext.dts

-- 
2.17.1

