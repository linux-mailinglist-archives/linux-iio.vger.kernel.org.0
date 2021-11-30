Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8832D4630BF
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 11:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhK3KN5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 30 Nov 2021 05:13:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4179 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbhK3KN5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Nov 2021 05:13:57 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J3Htf20ztz67lKF;
        Tue, 30 Nov 2021 18:06:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 11:10:36 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 30 Nov
 2021 10:10:36 +0000
Date:   Tue, 30 Nov 2021 10:10:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Kunyang =?UTF-8?Q?Fan?=(=?UTF-8?Q?=E8=8C=83=E5=9D=A4=E6=8F=9A?=)" 
        <Kunyang_Fan@asus.com>, Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>,
        "Jacob =?UTF-8?Q?Wu?=(=?UTF-8?Q?=E5=90=B3=E6=96=87=E5=82=91?=)" 
        <Jacob_Wu@asus.com>
Subject: Re: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI
 IDs
Message-ID: <20211130101034.00001827@Huawei.com>
In-Reply-To: <CAHp75VcfcG55FB7uRKozKUnb6ZGQ_v=L71bTND5+5vcjgQaBOg@mail.gmail.com>
References: <20211003162417.427260-1-jic23@kernel.org>
        <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
        <HK0PR04MB307480DD560E45390BA4F081F6679@HK0PR04MB3074.apcprd04.prod.outlook.com>
        <CAHp75VcfcG55FB7uRKozKUnb6ZGQ_v=L71bTND5+5vcjgQaBOg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Nov 2021 11:44:17 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Nov 30, 2021 at 6:22 AM Kunyang Fan(范坤揚) <Kunyang_Fan@asus.com> wrote:
> >
> > Hi Andy,
> >
> > This patch would affect the ADC function on AAEON x86 products: https://www.aaeon.com/en/p/developer-board-intel-11th-up-xtreme-i11, we need the ACPI ID to enable ADC device ADC081C  
> 
> AFAIU Jonathan did that patch (and it's applied, right?) exactly for
> that reason, but the main issue here is the process inside AAEON
> company regarding ACPI IDs, can that be fixed please?
> 

I need to do a v2 with changes as you suggested, so not in yet.

Jonathan

