Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A9D362158
	for <lists+linux-iio@lfdr.de>; Fri, 16 Apr 2021 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhDPNrB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Apr 2021 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDPNrA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Apr 2021 09:47:00 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F48C061756;
        Fri, 16 Apr 2021 06:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvTZNRtFLjO7Qy/a8C2agI1br5rV2fmdqpcQY8x4o6nDD9fuMiqkGgHCzJHERyzxnFd38ntFs0LYJUUmqU1XgccLw1T6UrjUNzjcZydZ0XNkiJ6pwXAytSFIZB2znEBEcEoUpUawXMgXlACi6I8fcROwklhwV8vc2U08F/1NZNIlHcbn3JXyc/n9lx+nDgRdM14XACHKSXUg2IE3XoTxnEedaLtg6Y2X47YTtthYHrBy9/MNO68CQSFdP1k+EK8h1h8R/R/bTjU+Zq7C4tcRePVRN8UIo3xLoX3d3uaWaOkpw3DokMDy0LhZXRVv1ohJ63K1L7hofQT6A+Z92Y+W9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqrOeBB3rmP7yI+OTdnza1yCH8OD9g14Tql9gGmbLt0=;
 b=PBuvc83Cs0zBh5k8GJFJGD8HtYESHXLHG/kJaoKdINSugHw6vUpOvGALW9n5DuJJdjbAMibMLV2wAvMda54xIFcfQF1/7rtXmYIOZEjvpsrtvW9fU7iJ4miXnb00zQXG5QH63L0Sr+1DpM+45xiX1gd1laJKFu9sLdXWcxGewJz6aW7RsgQhIuPnFh9oOrrRv+tN/RHZYwnbLu7tZgnQVTUe9UjDVgiFfV0Xsw49IolkdQbOBDYP0zBBWWx/aa6eO1rU9cgc9BD2c6CSbVfZXgwy1UQ+kgSbADjdx+4eqtwqjZN5GK5H8XsyOwGBTrp2QUC+h7YzPzHo2xXyfp2GBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqrOeBB3rmP7yI+OTdnza1yCH8OD9g14Tql9gGmbLt0=;
 b=C4faGr15I0GyPAwi34Y/kwSEeO4njzVx30BFQKmCN8PQcL7z/zu74ULxjf1G/8+ddqwsgKxTVxDP2wmvbir+aj6iu7ZssTSHEaGMtOSrT2vQPN5Oem0JeFqwj5o89wNuwRTMUuO4MMpmX3hHC3fJO7O+M/smVngLelZTU1PLe7/piRzy7TAupq0huVBQkny1pCyupKmxodvPTMsm3a9gS0XMJwRCtLziZuexE3YO7bx5l5AvoHTknL1rnc7wp4knI9tv9EjFZ+jcqSf6ZTCXBogU67jwe2gXGtRow8gteVyJgVY/btHW1Q507lq2wZRpUJdoZ9bU5QgnhkwlLUbumw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5568.eurprd06.prod.outlook.com
 (2603:10a6:803:da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 13:46:32 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::c471:1848:5f45:95a4%7]) with mapi id 15.20.4042.016; Fri, 16 Apr 2021
 13:46:32 +0000
From:   Tomas Melin <tomas.melin@vaisala.com>
To:     jic23@kernel.org, devicetree@vger.kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: iio: accel: sca3300: Accelerometer support and binding docs
Date:   Fri, 16 Apr 2021 16:45:44 +0300
Message-Id: <20210416134546.38475-1-tomas.melin@vaisala.com>
X-Mailer: git-send-email 2.21.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR05CA0269.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::21) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora-vm.localdomain (85.156.166.106) by HE1PR05CA0269.eurprd05.prod.outlook.com (2603:10a6:3:fc::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Fri, 16 Apr 2021 13:46:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfa81dc6-1700-475e-e9c7-08d900de0b19
X-MS-TrafficTypeDiagnostic: VI1PR06MB5568:
X-Microsoft-Antispam-PRVS: <VI1PR06MB55684C107745D438048AAE6CFD4C9@VI1PR06MB5568.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9P0D/VAP8eqmjC+QYJIccihZLA3EHPUopFq2/OWtvtaNRIUst6IQ0mKz9+eBmm8RSMoiFZmKqF+vPITgrzYiKKqCiaE0wzocGWWjopThCBh1i1d28aw1RI34a+pFn5o5f3cAteMIsZNdZjYPy62s7Bu2dhg1vX8r/GfPncFbbHIiTMZte/Aj1TsJPRD7zP4oMIJY2Ww1IMC332nfRlQ7MFRA4811VMkG6Xn2r2kqEwWJGuiYC1Ql7/FKw3aVBueN7RRi15DaSzCwAZkoUeUWASa4tsg45rPJ1iS2weaUaUu+jfMlh2nrr5TvBlqG1w995FAu2H2YweVWjGWwBVRzVRxqEfNM84U3BQ2lTlYkL9wzRv8L9gpN23SCJtFuZVk+QpYmwDAR3exMqX1F0bX0eUFushBoUvVEMZyVPOMNE0t1lufmxbjGPmMu6BvzQ2DwqXwRaKIq70+S26xxHaWkoGtXUq5IJhhTURD5Dris5+rezWUGqGFKlviMRYN93h1CJkdLJccAu6DSexzIAVonk60JYh8hXVbGEhvci8pqe6Ze0KzKHnSFJwtdWcnbSqUrHjGrlrTTikTxJkenRsN2XrmNaxPx5+yIy0FYjwI4PFl0MbzEqs+4WM5N2MuvmiRsGg48KFIookLdTm2/+tPUztJOBoYblBbQ8ykZxbVeLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(366004)(5660300002)(6486002)(66946007)(186003)(66476007)(956004)(66556008)(316002)(86362001)(6506007)(36756003)(6666004)(1076003)(38100700002)(38350700002)(16526019)(478600001)(52116002)(8936002)(2906002)(83380400001)(26005)(44832011)(8676002)(2616005)(6512007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4Bdg5n/BJftKD6pxjjfxHgMRs6SS/eZI/i4n7C6upNdUWRUWfACn1dSrYsHz?=
 =?us-ascii?Q?YuJTiLGLdBE5CVGNMaCVvEPDrC7Mng1khKKRxRkzsL96JSW+SimICoqpGQTN?=
 =?us-ascii?Q?QYPcsjU28J4juuLJFW57J+MaKObeLnsKv5Lucxc8Kb1419WfqU8hRUaqAXX0?=
 =?us-ascii?Q?osl2jG/6v5V4dKDKt/AQBvSwFgvEatuIBHVCV9eoXLtdcItWHVFALMNOs54N?=
 =?us-ascii?Q?+t6os663efpfNNzjMQB24YEkiKgdRksnxUsWSUN0vHljO8AkZNLck3h73hAi?=
 =?us-ascii?Q?DV3cS4+SE8ehU4EBOnMURpDuHeCwEOqyWwkx2cgtG0ghOfInQn2jUfvK8yQy?=
 =?us-ascii?Q?41+GM4o1xHs3ROQrKVE7dulweSxKDX1+/AcI8CkeWFDWRSypFYJURKcuGJ90?=
 =?us-ascii?Q?Qpyd/5XXigGboSG3ZnPoT+rqwaPyz82A2ufK7QWM9GCht0Xm+mE3IK8wtjzH?=
 =?us-ascii?Q?WkMoWVRlnUw1ykbbEE6aS42kr1ite1klZ32MbKNqwJzR01x/92JCDspuDlEJ?=
 =?us-ascii?Q?LZPoeoiRsFct9c0RAVVuZzhEytMJr35zO04Jzjhmsy+DCCtiBSu4b7ip3yJe?=
 =?us-ascii?Q?O552Nw4IphpAfoL6aGC2IWlfhuGEZGKNxVvQ1JmzjEthZrZFKr3unCcV0xLM?=
 =?us-ascii?Q?36SnrrkU3bjQK2PKVyFveZaIfOcv3AkitGPi0FhpyWih9jaqBC1Cf9EcrWVW?=
 =?us-ascii?Q?cBHfWC1H68QZM756sUfdSSi+ElkbK1xT5ic5Z2kLy+PV68wOdNG1nOUmHNa+?=
 =?us-ascii?Q?NjAe9r5ik7k+/k0YnzLtSWmZoMhWxEZ/QYFlpl5vmJr8WEC52t3DAiwDUj7U?=
 =?us-ascii?Q?FWi/SbsqWWDpfUiM1b20G48Jf9fvqtnud/7XA3j7yy0eTss0wlow5vT6NzsN?=
 =?us-ascii?Q?Yu/kEKCbp2ybzi8xeIUfZLZDOJWRpCLTLHqfXwvK6keRokwgCINzGTpIeZJs?=
 =?us-ascii?Q?bL130c2lN4DURH4ttkvZfAxe0LkUjX+pzKblh56SjzfsEaDAO1BU6NVj0i0+?=
 =?us-ascii?Q?505VTiCoUlZSr+BqfQdqSGP/W0UlbPb4/UTsH1NqwrNd7SgMRaHsVsOSVrRW?=
 =?us-ascii?Q?RUfPNaKLalkD0Yi3bR2EwzazjD59c3Q5vgajVDcDL4tnFKggOgPWYvoBp8Dh?=
 =?us-ascii?Q?Uf6ABMknQ7FKkkAkwDeBF53HlUA20B+XLWuiOymFzhumFlNJDtGJkQFVdGAy?=
 =?us-ascii?Q?WbNY7pRkleBiF8R38l3VmDmTRsfL4Q8VqIdyLAVPSnISMnvPJDMI0Brd4sOp?=
 =?us-ascii?Q?V81FOsCuZhwRQCgGpXwIbRj9MUOPNY6qjusxpkiNltT+WbRe/EA/66umOUuO?=
 =?us-ascii?Q?Pd94YsgZne9rdO7/SR5Oi8Nj?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa81dc6-1700-475e-e9c7-08d900de0b19
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 13:46:31.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCHz19apwKshDQ5Qv9KfNjvKZyviEFQ+gcI4h/tsaScTFfAbAeV/3YW94f77ZVg2wP5PQt7BNRQ0NxMqF01pDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5568
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,
Patch series adds driver and dt-bindings for Murata SCA3300 accelerometer.

Device is a 3-axis Accelerometer with digital SPI interface.

Patches are tested and based on linux-next.

Changes V2:
- Add manufacturer name to dt-binding file
- Update spdx license statement for dt-bindings
- Remove murata,opmode devicetree property in favor of driver scale + frequency properties
- Add copyright year for driver
- Remove X_READ and X_WRITE defines
- Add _available sysfs attributes
- Fix errors in documentation formatting
- Use ARRAY_SIZE where applicable
- Use get/put_unaligned_be16() helpers where applicable
- Factor out error handling to separate function
- Return only negative values from transfer function
- Fix INFO_SCALE to return multiplier instead of inverted value
- Change INFO_SCALE values to be actual scale instead of mode value
- Do not provide INFO_PROCESSED values for user space
- Add error message for failed data read in irq handler
- Move trigger handler timestamping as part of pushing data to buffers
- Document startup sequence, providing reference to data sheet section
- Convert iio_triggered_buffer_setup to devm_iio_triggered_buffer_setup,
making remove() obsolete


Tomas Melin (2):
      dt-bindings: iio: accel: Add SCA3300 documentation
      iio: accel: Add driver for Murata SCA3300 accelerometer

 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml |  44 ++++++++++++++++++
 drivers/iio/accel/Kconfig                                       |  13 ++++++
 drivers/iio/accel/Makefile                                      |   1 +
 drivers/iio/accel/sca3300.c                                     | 468 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 526 insertions(+)

