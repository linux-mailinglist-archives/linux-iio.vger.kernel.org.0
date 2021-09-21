Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3960C412EA8
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhIUGgw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 02:36:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35212 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhIUGgv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 02:36:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L4XxDn010310;
        Tue, 21 Sep 2021 06:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=EIX2992KKQfJZq1G0dsRoH7w58v5xSdKJ5RDFJdvNpE=;
 b=bdPNcRb3uI7IucpfdJFJp5naxTuVfXxlcrcIpQbU3CDbXiCPMGYPOP39OsfaqXQVSIPT
 lU5sTF8aVEl8Wm9jswOMXRn5L8l2MOVlEzYk4Kc9O3kLjrqP4v3TM1vRNZjiLafUUW3o
 gYBICrlatqlWRR+Tx8hMcL/iwsIKXp4C++eIKe62+NU1RuNrjB2NdQSkoU84pSlJIR+5
 d9jibsQiHdqGmENJCkc6nn6RnrriAcI9WCurbENY68ncuzr2VY5LaELTbUnwrBy8/IIG
 fvm1i1ixP3rBS1N9/2IBZNo6OyIzaGJXBm7rP8wW97rFwEBzYh3r6dc+yZbr9cJTIgDl lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b78fwgbrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 06:35:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L6Ylji080231;
        Tue, 21 Sep 2021 06:35:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3020.oracle.com with ESMTP id 3b57x51w3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 06:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inUPDErroN+pneM52FK7n85GMkzkqXz3hKrJ4oDAFbxtW4UegsYeVFSFtv6l/kUFCawJ3/OZHTiBPAxqHRrpYZZ3zzuiQYs99adc+EXoxZBh471kLf2oSruqhXGm3bheVP2uPKhP73Jljt0JYLul9h+Muz6KcJqtgthQBJKPwyK8Dm71CyhRamcKMw3raZgqoYfabKmF1sXB6/mQzjarRo3U5yw3FAJ2BPwE4Yf6BxMsdSZ4LidGnRoQNtAj5VG2JzG2dtGmeA99JXaNObNw22tSl9YqZKXHnVbyEX94n8QHo033U9GYV+bUvGSabUOenvtPkVju4KTF9E/FOuD0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EIX2992KKQfJZq1G0dsRoH7w58v5xSdKJ5RDFJdvNpE=;
 b=bruk8lcp1nwdPdqmVycUIm+zIU3yMnJWSoSEnbynVEn43qNo++UNE/k0YGtkBMoMPOVHMwctoJBAdLf3VncYPHHB7GbLB/v0Wj1K1R5c7gQ+7MiW2NA4pD6BkM/HydKjgnWdOs71VjmzFlm8rCZXo7wvhiOdPQeiPoxnZMNnI8iB2p54HqdUSorAZqcgbP8jnwN5GVrLcVdS/xo4SBl03owCSAFenVbBFKL1G2Q7RhfPok2n/9RzllsvFAUhVPZPjHMzGI/p9Gz72oJYJ2uuaTHt1XKrWt/XE7kydEKJgVbBf9Wb7O5H5V2E1aHqKyz3u+cGg09ZwLBw7fEK0woH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIX2992KKQfJZq1G0dsRoH7w58v5xSdKJ5RDFJdvNpE=;
 b=EliXNytmY+d+aC2BX2slKz/oCkbv+IiqkJ6jZK/OH2NGMRywJxW8Bj8PZ8+jWLQUnKdvsEgJbebtdxbOmEV9vO0IhPy36wqxpHEhmc3tNmf4RpEmHGCH9naWfg28t0A/zkxT6lS+5QLqcgfM8auIVGqch4UeHQf5onN8i3LauXc=
Authentication-Results: xiphos.com; dkim=none (message not signed)
 header.d=none;xiphos.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1551.namprd10.prod.outlook.com
 (2603:10b6:300:27::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 06:35:19 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 06:35:19 +0000
Date:   Tue, 21 Sep 2021 09:35:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lvb@xiphos.com
Cc:     linux-iio@vger.kernel.org
Subject: [bug report] iio: adc: ad7949: add vref selection support
Message-ID: <20210921063509.GA26209@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0040.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0040.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 06:35:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e381c28-6045-48d6-9896-08d97cc9fb14
X-MS-TrafficTypeDiagnostic: MWHPR10MB1551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB15515776C252D57B05968A568EA19@MWHPR10MB1551.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvSpfpX76l27eexa+bLQecX1IJ848ANRxWzoONyhp02t+gDVKHN74wo6RRGatklLM312mILP7VImjyLzINYqrOangSEbWvYFqiIIan/oqFLVuS1yudxUjZAKO5PQPwxaotSTIQqWU5yOW4Y/65EIAe5/cIk6u6vwGZy1oDc2EjgDpG5eaEwGi9AJp8W4JMUgBs9DIqPvUNNyUVC+i5c792wN1C3B+KmAP8yMYzOAGaCBIGxNlitvC1fVfBcZgAk0epu5bTTGVenSI6B1lJH1m5woYBbIoKqRfJZcuzQH22CJpdywuEdOtjVMq12gwTMU7jSKerL2Eowo0i/KInyK+mHlANYja6uOSc1nz+Zt8EnAlb3sp1Cv8Ruud1isoM2T0dz27OPAnYlCb0zGR7i5DNaaQqW91qVuyYqbPDDVxhuj/tQ24evV552i8ZqR6cZ36BItXQ0V6Ggj+6PfyvcgwY+MCnR1S2/R9WU17lxgoT5pWaqLnyDSg4K8P3Tw+yy6GW6hz0F4L8SJ24z5+/7NJ+DeVD9n7svRFkL3/YSeeLcey10iQL8SnwtK4FdTJMLClQFYrka4e7ZwIKFOL1RBddr6attv5bv7+Ww4YrAklWoOU3BEppjDV05gkcnN/8SWj7liNmBdM6OkkRgqr1h7K8gqVPdzWNUe1UU3pZAjzUVSAStDix1BozEtV95klxPfxX+4uPiqyNIjJ/MF8/si7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(38100700002)(508600001)(44832011)(33716001)(66476007)(2906002)(186003)(66556008)(956004)(5660300002)(55016002)(8936002)(66946007)(6666004)(9576002)(316002)(52116002)(1076003)(38350700002)(26005)(8676002)(6916009)(6496006)(4326008)(33656002)(83380400001)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V9EdMIeu6AnTawZ4RAL340vH85GK+r7BzNRoJtVmDxC+gtjL/O/R0BboIVfg?=
 =?us-ascii?Q?MB2aVUO9lhTw2Bo/Y5KZ3P125w/bMZgFZ+ORaq+Eu36+WwWcMzTaNC1qQZAf?=
 =?us-ascii?Q?qgMBP2xGc3u5nQXY6Bu5+Lw8WkFJYD0w5dZEp1nmycyLfy6q6N6Yz66IzT2Z?=
 =?us-ascii?Q?V7jpdWqtoB74mmhn+B06IoZ/EFVy+2nc4V1dMSVRwGeP1FS8dIT6qOrcYaXs?=
 =?us-ascii?Q?nCJq+shPiEeQQs1vbCbyGJsM9e/R/QzCs3+/JWCxvQ1WKIJciVaRLAt/sVCh?=
 =?us-ascii?Q?QIJpuuRk7OHKJIYOLt1Hzcf/bb4B7MxU1MtlP22JVx5BXfLhqysezhrtWgo1?=
 =?us-ascii?Q?NVR7jJCVleCHdoNvQ85Fm/hWExK/CYsU+tOWVRxtWdThLyWXq8XnIbf+3Pu3?=
 =?us-ascii?Q?GniHP+aaDVRFJ/2SA/WatKkHeAYF5zzcuXWfO/RSgoG3Hh8knxeBSvVMOD7l?=
 =?us-ascii?Q?xHbUzVf8ivmruQ185njNgo+Kaqw56Au1uhZJQhpBCz8YF76iMWCWH/T5gJfY?=
 =?us-ascii?Q?oS0N/BUwY+JhPTlYmwz6pQ7BmToxC1gS86Xoh8asBLahkCkZD7t2mr1yKMgi?=
 =?us-ascii?Q?PqZdGvxSYUDvnPInHbuyb0fajJXAawpDZ5v3rOhUbII6HRWpzl4EeCg8yXaX?=
 =?us-ascii?Q?4lCjb/bjBXO3klP38KuPUITeB0YV22w82KM26Af3EkJ5BItm2i9/9gyVjSLP?=
 =?us-ascii?Q?3MeUUKV6+v4pxwngVkZHRO+AFNtja7LSx/Fm3lq/6AOnG7I8bNDIGJK0l9ws?=
 =?us-ascii?Q?cfZg1fHDDp9kEN3OjDLIIpcJlANwaSpXk5hg9pLVy1dshCx9NQZvtx0E7xHT?=
 =?us-ascii?Q?wHZ3P29Rftp5xJTKkPRVfINJeE5ujR0GQ/gHJ4bIBzlC/ih1Qv+vEtXfRz4O?=
 =?us-ascii?Q?mYjAq8vvVlfD9l426+uxwczDIHOEM7rGz9Sdk/n6OGspCwWR/2qK3gC9jY+B?=
 =?us-ascii?Q?IARB7OAdf7wWbt12c6jPKQ8C6sMmhKDFRuNbevmAT8SK1saymaOO7PjlBmIx?=
 =?us-ascii?Q?BDs75a1cBSIVq+3K40VCff+OWb5/y1aKNjjjHzbdegk+2SR8m3Q5rqkH3g+H?=
 =?us-ascii?Q?D2qj1Fv/KtWhlb1R/MhdRzmSCvOMleXsEewyNuJF7ZfJ7CBjBiJGcrCXNE8x?=
 =?us-ascii?Q?w6cOTzGC4Vz757qlD1wkjAGrck35dg1cNAAUAaN8InokbkzG+C83nVzx7GK+?=
 =?us-ascii?Q?KEnpeASuR/+89/wtjVALfXyDaeimhmQxn+zsqF8FuAMaG9LgIpiMf+xVaEuJ?=
 =?us-ascii?Q?dsuwQtvvVt9C+oJs3g/kfLL2e9Rab9g7S5D74zEBfXKNUFx+WVW3G+VeOV/o?=
 =?us-ascii?Q?7afA2dPGzYRtfFrwnXMh+6Zc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e381c28-6045-48d6-9896-08d97cc9fb14
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:35:19.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDvnRSIH54X3mPaQNFWY8/VnbLGEM4WRQizg8mse1regiFoDOs6uBR4YaFzCMu2TGuvXinJ3/HZzCO/lWsVEY0YUPWhx1Uye0yL9xnX5kqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1551
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210042
X-Proofpoint-GUID: _oJwfalaNPS4LX08nPuSSLol8uR-Jfwl
X-Proofpoint-ORIG-GUID: _oJwfalaNPS4LX08nPuSSLol8uR-Jfwl
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Liam Beguin,

The patch 379306506049: "iio: adc: ad7949: add vref selection
support" from Aug 15, 2021, leads to the following
Smatch static checker warning:

	drivers/iio/adc/ad7949.c:387 ad7949_spi_probe()
	error: 'ad7949_adc->vref' dereferencing possible ERR_PTR()

drivers/iio/adc/ad7949.c
    309 static int ad7949_spi_probe(struct spi_device *spi)
    310 {
    311         u32 spi_ctrl_mask = spi->controller->bits_per_word_mask;
    312         struct device *dev = &spi->dev;
    313         const struct ad7949_adc_spec *spec;
    314         struct ad7949_adc_chip *ad7949_adc;
    315         struct iio_dev *indio_dev;
    316         u32 tmp;
    317         int ret;
    318 
    319         indio_dev = devm_iio_device_alloc(dev, sizeof(*ad7949_adc));
    320         if (!indio_dev) {
    321                 dev_err(dev, "can not allocate iio device\n");
    322                 return -ENOMEM;
    323         }
    324 
    325         indio_dev->info = &ad7949_spi_info;
    326         indio_dev->name = spi_get_device_id(spi)->name;
    327         indio_dev->modes = INDIO_DIRECT_MODE;
    328         indio_dev->channels = ad7949_adc_channels;
    329         spi_set_drvdata(spi, indio_dev);
    330 
    331         ad7949_adc = iio_priv(indio_dev);
    332         ad7949_adc->indio_dev = indio_dev;
    333         ad7949_adc->spi = spi;
    334 
    335         spec = &ad7949_adc_spec[spi_get_device_id(spi)->driver_data];
    336         indio_dev->num_channels = spec->num_channels;
    337         ad7949_adc->resolution = spec->resolution;
    338 
    339         /* Set SPI bits per word */
    340         if (spi_ctrl_mask & SPI_BPW_MASK(ad7949_adc->resolution)) {
    341                 spi->bits_per_word = ad7949_adc->resolution;
    342         } else if (spi_ctrl_mask == SPI_BPW_MASK(16)) {
    343                 spi->bits_per_word = 16;
    344         } else if (spi_ctrl_mask == SPI_BPW_MASK(8)) {
    345                 spi->bits_per_word = 8;
    346         } else {
    347                 dev_err(dev, "unable to find common BPW with spi controller\n");
    348                 return -EINVAL;
    349         }
    350 
    351         /* Setup internal voltage reference */
    352         tmp = 4096000;
    353         device_property_read_u32(dev, "adi,internal-ref-microvolt", &tmp);
    354 
    355         switch (tmp) {
    356         case 2500000:
    357                 ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_2500;
    358                 break;
    359         case 4096000:
    360                 ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_4096;
    361                 break;
    362         default:
    363                 dev_err(dev, "unsupported internal voltage reference\n");
    364                 return -EINVAL;
    365         }
    366 
    367         /* Setup external voltage reference, buffered? */
    368         ad7949_adc->vref = devm_regulator_get_optional(dev, "vrefin");

Apparenty it's really rare to have an optional regulator?  This function
is very tricky.  It should return NULL if the option is not like all the
other optional features in the kernel.  But the regulator code is really
not set up for not having a regulator.  If it were then there would be a
lot of NULL checks in the regulator code.  But since it's not then you
have to add them to the driver instead.

    369         if (IS_ERR(ad7949_adc->vref)) {
    370                 ret = PTR_ERR(ad7949_adc->vref);
    371                 if (ret != -ENODEV)
    372                         return ret;
    373                 /* unbuffered? */
    374                 ad7949_adc->vref = devm_regulator_get_optional(dev, "vref");
    375                 if (IS_ERR(ad7949_adc->vref)) {
    376                         ret = PTR_ERR(ad7949_adc->vref);
    377                         if (ret != -ENODEV)
    378                                 return ret;

Instead of returning NULL when the regulator is disabled it returns
-ENODEV.  How do you differentiate from an -ENODEV which is caused by an
error vs an -ENODEV which is caused because the optional regulator is
disabled?  You'll just have to hope that the errors are less common and
assume it means disabled.

You might be doubting that devm_regulator_get_optional() can return
-ENODEV on error?  Look at the code and prepare your heart for sadness.

    379                 } else {
    380                         ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP;
    381                 }
    382         } else {
    383                 ad7949_adc->refsel = AD7949_CFG_VAL_REF_EXT_TEMP_BUF;
    384         }
    385 
    386         if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
--> 387                 ret = regulator_enable(ad7949_adc->vref);
                                               ^^^^^^^^^^^^^^^^
Every reference to ->vref will crash if the optional regulator is
disabled.

    388                 if (ret < 0) {
    389                         dev_err(dev, "fail to enable regulator\n");
    390                         return ret;
    391                 }
    392 
    393                 ret = devm_add_action_or_reset(dev, ad7949_disable_reg,
    394                                                ad7949_adc->vref);
    395                 if (ret)
    396                         return ret;
    397         }
    398 
    399         mutex_init(&ad7949_adc->lock);
    400 
    401         ret = ad7949_spi_init(ad7949_adc);
    402         if (ret) {
    403                 dev_err(dev, "enable to init this device: %d\n", ret);
    404                 return ret;
    405         }
    406 
    407         ret = devm_iio_device_register(dev, indio_dev);
    408         if (ret)
    409                 dev_err(dev, "fail to register iio device: %d\n", ret);
    410 
    411         return ret;
    412 }

regards,
dan carpenter
