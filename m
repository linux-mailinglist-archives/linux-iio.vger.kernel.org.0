Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510B57B8166
	for <lists+linux-iio@lfdr.de>; Wed,  4 Oct 2023 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjJDNy2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 4 Oct 2023 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjJDNy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Oct 2023 09:54:28 -0400
Received: from NOR01-OL1-obe.outbound.protection.outlook.com (mail-ol1nor01on2091.outbound.protection.outlook.com [40.107.224.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8A7AB
        for <linux-iio@vger.kernel.org>; Wed,  4 Oct 2023 06:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4jtRq/Z+Xhm/aVxD1RPqELeaMIWp9Y1GrW4XXM+A57AjU6IIoLm/La+InUeR8GO2s4tkZEXDxxEaj/Hr8YWQW2o8LPiJlZasU79yOAR/ysswUiK0M4DG+9cHAMC2PihFn7T2z9wuMmoBIrdpCOJKM6dkB/ECYOkEWiHcmpaou4X6UCCHZnhHaO0qlTWJIzJsr/8u555WnfU3MOE/q1Cfh2XYS4TgZ/ch3y3RDm0eXI5eHeJY3gnY1LPu7aONmq/Wb2aGS3OhSs/+xPebislYmNaAiNvoI3qimBEcbAcHmzhSF3glDY7TADULi3czsjlSLq5tyi5Ek7ndynTz9+Ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y0AaeJQoTGzzJbuB+FXznZIhEvg2g0h6ATwj1Lnrts=;
 b=ZFuylfzkLoqreRtz0nv2BHYkYz6/crbIlp6kaqcIcbVShDiVI4SPDF41LT/EHAZ5A+HfcgoL2QLkq4otQ9mDbrvTKGX/mAJRDLYSSK9+KywqzF1QckeZzEuSBEm3Z3f7QrN2d7maoK8UVpvQ47aepOwcFvZU2DCBT/gpyKIv4CTgvgRJ88tUv2lr6NxL90GoNcBELlQrK7brdZwmHcBQQgtAoZCo90dyJoliEkwEpkMOO+G6tgB4g48Z8XCV6GFo1V7BusxM/o8POvbyoOV1BSIGruL6XHDXOsMBytz0J7aCp6Ill7jDcvzY5dbX6O3x6m3z/5vh5Bz9MovqWag7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gustavsen.com; dmarc=pass action=none
 header.from=gustavsen.com; dkim=pass header.d=gustavsen.com; arc=none
Received: from OS4P279MB0449.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:1e::6) by
 SV0P279MB0626.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:23::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.35; Wed, 4 Oct 2023 13:54:20 +0000
Received: from OS4P279MB0449.NORP279.PROD.OUTLOOK.COM
 ([fe80::162b:cb0c:eae7:5b12]) by OS4P279MB0449.NORP279.PROD.OUTLOOK.COM
 ([fe80::162b:cb0c:eae7:5b12%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 13:54:20 +0000
From:   Hein Gustavsen <hein@gustavsen.com>
To:     "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Error "swiotlb buffer is full" when reading 8 channels using AD7923
 driver
Thread-Topic: Error "swiotlb buffer is full" when reading 8 channels using
 AD7923 driver
Thread-Index: Adn2yEzFy51I4/2YTTi0ifomqWHcxQ==
Date:   Wed, 4 Oct 2023 13:54:20 +0000
Message-ID: <OS4P279MB04495DA9652AF1D253D125E1C5CBA@OS4P279MB0449.NORP279.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gustavsen.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS4P279MB0449:EE_|SV0P279MB0626:EE_
x-ms-office365-filtering-correlation-id: 7bd4228f-1ecc-4a95-01c9-08dbc4e16896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9rRboWKgyLrscCM1K/Z+Q7xrDLlsuZceEilPR0OdYbooZVHwkrIJAXJ8VuVNvehLbL386BRfpW3KBmz/V6UjJemCPJ0dLiWSRMzmzLtlKhKdybq50pXEu0EqDmQC8vIqeS5ZGNdJQJMYd0SLfVfKaEbM9+qVpuYjjqZVkw5khN6/rVfC3/qyjBD3Mgznqi2eni7htpWyWmlnBazgu21awotXLPkCImP0RF8Ri/dDs8I9vkGSaoGZbGHbKcfs2Yb28LXrsZZAP5/GyygwbQXdn9VtQrOyLAVeY13aPi5DYysKJ/p6U1KTyz+zx6aWEOZJQohH3OngMBejTklaUzn/MXa/MecAb+iYjFFDIQ6awutOfPgQ2ndqsS0/sHE93hllwF/nOqfnrmjVKgT5+xT5bPlYzTc3ILfACcXax+D1sSgXWHxoDpifKAXjRneWPzjy4dGlB/QanL2K3CzJb0ZLbSN1NbS9jyg3T6mc3pWe9DEdrGyJ6FnhZVG3bfTFaKTL9o02iQe863dZg1z+n/Gx95j7OaobRJjtro7Vtb+mcOfZmNIGOTn/8eGX6nnhhVgGzVC9I99R+7dDFWhEn6Kw7C4R6sd2EkqPgCwTxzbSv1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS4P279MB0449.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39830400003)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(8676002)(52536014)(2906002)(4326008)(8936002)(41300700001)(316002)(6916009)(66946007)(66556008)(66476007)(64756008)(66446008)(76116006)(55016003)(26005)(71200400001)(7696005)(6506007)(33656002)(9686003)(122000001)(38070700005)(38100700002)(83380400001)(86362001)(45080400002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?olmkjo2yc8GPXR1jOJ3I2/88ZPX1+m2L9GkydZyfvRqaPfqyT09rMalK4FNc?=
 =?us-ascii?Q?VrxbYu4oJwJaLoQJ/dLFOYnzZiVk4PMdIjlXNxUVtznbv1SYUyfcitjxhS7s?=
 =?us-ascii?Q?k+7J3Nj5mXRNGV9Od+snVHHIJ4xQezsLglfQnpBsUxDMaXzPXJYbpXAT6pjb?=
 =?us-ascii?Q?6r0ZORUQnZQ8posd+GmMzr0i3VO7aOeDOuwElPWgHgQMFyeVKlF/rU2AcFo6?=
 =?us-ascii?Q?e/89QI5U5M1QMr07Plx4F9iJBaCNF0pYPKollvF+IUodtun3wZXw0Efc9ko4?=
 =?us-ascii?Q?aDb18htqmnk95D4W55wIPHuQnOMmo4Ycm3lInRsyz1Mg+kaokzF5shl/pBPJ?=
 =?us-ascii?Q?dCFv6Hwc73zNuEEp0lWf316d7SvB5k9DtPxs+0BzijjZDsy+LRyl2VukQTuS?=
 =?us-ascii?Q?XxsHnXgraFPbW12mQ0omsaxq25nBVMQEMLzV7ZCocUG5Aq0ZFXvIxgxWqxIh?=
 =?us-ascii?Q?pRivCI9tQOrz4bzDv/jConxOuL0/ZAgVaCFUsJ5OcJuYMsz4jFC7batP0WSt?=
 =?us-ascii?Q?ELrYuc1LbzNSoW3WnJ747mHpd83oECf4SkswycvmWRS2lZoV/B6hcyWzj5Aw?=
 =?us-ascii?Q?32ped8vYrG//z0DoRSTiRGjuK+RLrbZrN2RmfLFtIvik8x+/wSJuMLXxAwUN?=
 =?us-ascii?Q?MkGkhJy954bfbna4diTuzUrCUOLgs4xfmHxMSVj2NNXUsjDHWfRlLXmFnBYg?=
 =?us-ascii?Q?FTfA/BZO714uWGU/FNpbUFAFfTHYUNaC5jaCi6CTTxGGM4/qVZtm8cno/Qj2?=
 =?us-ascii?Q?BBvBOTWAFlTN8h9mWlupKn36nNTkdWINeUz9q6zYi+zS1hhY+JiAfkBImyoG?=
 =?us-ascii?Q?2ls7tVtzv2DwhxvAu1wMu7xyoCcb3LXkXuhyzmd3O3mTbMOTXMmQEDa0OZVL?=
 =?us-ascii?Q?QYYB/byUzH/C7oBveZizgSsDitQAJFZHe91WYmUZX4F/YM4Kil1gl6u0XRMr?=
 =?us-ascii?Q?dl9k2fNU6aP3GOBT/8SDjMfwy++pWBtbDRGKZbIeBhDrh9shZ7zg2JHYE1yT?=
 =?us-ascii?Q?mBBXJlGndDLxn/x52A1rvODRuUQo5LUTTas6xmB1codjkyPeQs1WXnBhoSfa?=
 =?us-ascii?Q?ITQ1Yr1yLy2gdUZgzFdzh6iTWv5m1LIz0EfZsBBhHkFV4HXMl6pN+IUjm3Rj?=
 =?us-ascii?Q?K5JBxGSxXICUQDotGW3fzE7rrAn0YsYXXGlYJK35d5+/2sajcDqZxok8CjEn?=
 =?us-ascii?Q?CMQJs+jQaig6eHT2e7ovkTBhrL62M2Dia+Ou2vy4cj5IGwMH3KDesNgTNWeg?=
 =?us-ascii?Q?Th5LuN0Z96QHNjUM37oT1xM5h6K1JNYUgrXDYrzOkY3Nrbue2lnoGn2o5ji9?=
 =?us-ascii?Q?kUFJWdLHgOcazxfjUhSa+//hTt2G1ekryD2CgN1QxrV2BSKuWuzGAURlbNGw?=
 =?us-ascii?Q?YGoq8TteO3clYZH9C5gC9jNzHvhRVLYh9YirzkUtiAZbJcA6G0MEjUc0lUJ3?=
 =?us-ascii?Q?0rKwsVl+k53LxzeXILTEIGmU4iuP32m+nR2A2I3RGzQUVgSZ4SI1UDjE0YEx?=
 =?us-ascii?Q?BTd4GCvMMMAlgBcs/jmxkFCKRkI82WuGadEGd2TOCI8KZpUNXVa7BIWTyuzV?=
 =?us-ascii?Q?VpTJ4nRXJXYyKjqdMAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: gustavsen.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS4P279MB0449.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd4228f-1ecc-4a95-01c9-08dbc4e16896
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 13:54:20.4088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5bb78fb-cab8-450e-82fe-f7d5992fd16b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bxb010epSPgRkiuNfGZx/0cvy6dPhlzoNvGPuOGanarA4YwhtUissZiDewqREDf9ctVKjSeqATKbsR9Ar4vx/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SV0P279MB0626
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

When I enable all 8 channels from an AD7927 chip using the AD7923 driver I get the following kernel error:

[   98.429633] imx-sdma 30bd0000.dma-controller: swiotlb buffer is full (sz: 32768 bytes), total 32768 (slots), used 32736 (slots)
[   98.431413] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
[   98.431425] Mem abort info:
[   98.431427]   ESR = 0x96000004
[   98.431430]   EC = 0x25: DABT (current EL), IL = 32 bits
[   98.431434]   SET = 0, FnV = 0
[   98.431437]   EA = 0, S1PTW = 0
[   98.431439]   FSC = 0x04: level 0 translation fault
[   98.431442] Data abort info:
[   98.431444]   ISV = 0, ISS = 0x00000004
[   98.431446]   CM = 0, WnR = 0
[   98.431448] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001073a1000
[   98.431453] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000
[   98.431461] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   98.437036] Modules linked in: cfg80211 fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine rng_core authenc libdes crct10dif_ce snd_soc_fsl_sai rtc_ds1307 imx_sdma extcon_ptn5150 snd_soc_wm8904 caam secvio error fuse overlay
[   98.459228] CPU: 2 PID: 517 Comm: irq/233-ad7928_ Not tainted 5.15.60+ge9858f40abc9 #1
[   98.467145] Hardware name: Variscite DART-MX8M-PLUS
[   98.474799] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   98.481761] pc : _raw_write_lock_irqsave+0x254/0x318
[   98.486732] lr : complete+0x24/0x64
[   98.490220] sp : ffff80000b43bbe0
[   98.493534] x29: ffff80000b43bbe0 x28: 0000000000000000 x27: 0000000000000000
[   98.500674] x26: ffff0000c0f179b8 x25: ffff0000c6154338 x24: ffff0000c198c370
[   98.507813] x23: ffff8000089f8b20 x22: ffff0000c6154410 x21: ffff0000c0f17978
[   98.514949] x20: 0000000000000008 x19: 0000000000000000 x18: ffffffffffffffff
[   98.522090] x17: 3233203a7a732820 x16: 6c6c756620736920 x15: 0000000000000000
[   98.529228] x14: 0009201c149cb862 x13: 0000000000000000 x12: 0000000000000003
[   98.536365] x11: 0000000000000000 x10: 000000000000021f x9 : 0000000000000000
[   98.543502] x8 : 0000000000000001 x7 : 0000000000000003 x6 : 0000000000000000
[   98.550642] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000008
[   98.557781] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000001
[   98.564923] Call trace:
[   98.567368]  _raw_write_lock_irqsave+0x254/0x318
[   98.571990]  complete+0x24/0x64
[   98.575130]  spi_complete+0x10/0x20
[   98.578622]  spi_finalize_current_message+0x168/0x1f0
[   98.583672]  __spi_pump_messages+0x48c/0x5b0
[   98.587945]  __spi_sync+0x234/0x26c
[   98.591434]  spi_sync+0x30/0x54
[   98.594578]  ad7923_trigger_handler+0x24/0x8c
[   98.598934]  irq_thread_fn+0x2c/0x9c
[   98.602512]  irq_thread+0x178/0x2c0
[   98.605998]  kthread+0x150/0x160
[   98.609227]  ret_from_fork+0x10/0x20
[   98.612808] Code: 17fffeba d5384613 521b0a60 f9800071 (885ffc60)
[   98.618901] ---[ end trace 9fd562a23b7ff000 ]---
[   98.623517] note: irq/233-ad7928_[517] exited with preempt_count 1
[   98.629757] genirq: exiting task "irq/233-ad7928_" (517) is an active IRQ thread (irq 233)


Six channels work fine. Increasing the swiotlb buffer to 262144 does not help. All slots are still used.

To reproduce, I run the following commands:

TRIGGER_NAME=trigger
IIO_DEVICE=/sys/bus/iio/devices/iio\:device0
TRIGGER_DEVICE=/sys/bus/iio/devices/trigger0
SAMPLING_FREQUENCY=1
mkdir -p /sys/kernel/config/iio/triggers/hrtimer/$TRIGGER_NAME
echo $TRIGGER_NAME > $IIO_DEVICE/trigger/current_trigger
echo $SAMPLING_FREQUENCY > $TRIGGER_DEVICE/sampling_frequency
echo 1 > $IIO_DEVICE/scan_elements/in_voltage0_en
echo 1 > $IIO_DEVICE/scan_elements/in_voltage1_en
echo 1 > $IIO_DEVICE/scan_elements/in_voltage2_en
echo 1 > $IIO_DEVICE/scan_elements/in_voltage3_en
echo 1 > $IIO_DEVICE/scan_elements/in_voltage4_en
echo 1 > $IIO_DEVICE/scan_elements/in_voltage5_en
echo 1 > $IIO_DEVICE/scan_elements/in_voltage6_en
echo 1 > $IIO_DEVICE/scan_elements/in_voltage7_en
echo 1 > $IIO_DEVICE/buffer/enable


The error message appears immediately after the last command.
Kernel version is 5.15.60 (https://github.com/varigit/linux-imx/tree/5.15-2.0.x-imx_var01)

Best regards,
Hein Gustavsen

