Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549A8449842
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 16:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhKHP3e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 10:29:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4073 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhKHP3e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 10:29:34 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HnvyD3kXYz67PN4;
        Mon,  8 Nov 2021 23:23:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 8 Nov 2021 16:26:47 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 15:26:47 +0000
Date:   Mon, 8 Nov 2021 15:26:46 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: IIO interrupt mask access
Message-ID: <20211108152646.00004ecb@Huawei.com>
In-Reply-To: <BYAPR03MB4647767659DA0E143F9C919A97919@BYAPR03MB4647.namprd03.prod.outlook.com>
References: <BYAPR03MB4647767659DA0E143F9C919A97919@BYAPR03MB4647.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Nov 2021 14:29:10 +0000
"Hegbeli, Ciprian" <Ciprian.Hegbeli@analog.com> wrote:

>  for the ADE9078 (High Performance, Polyphase Energy Metering IC)
> which has two interrupts with over 30 configurations modes in two 32
> bit registers. Some of these flags can also be active at the same
> time within the same register for the same interrupt. While handling
> the interrupts is fairly straight forward, the challenge is to
> dynamical configure them within the IIO framework.

The answer to this is very dependent on what those interrupts mean.

I've taken a very quick look at STATUS0 and STATUS1 definitions to
see what we have.

Some of them look like they will map to triggers or possibly internal
data capture events that we don't expose to userspace as they reflect
periodic data updates (e.g. PWRRDY, DREADY)

Others look like they would be just about internal management of data
flow, eg. COH_WFBB_FULL.  You 'might' be able to map the start of
a waveform capture to the trigger interface. A little bit tricky to tell
without reading a lot more of the datasheet than I have time for today.
PAGE_FULL is something you'd probably not expose to userspace, but
handle as a signal to retrieve data from the device and push it to
a buffer or similar.

Others are what we'd map to the IIO events interface, 
MISMTC, REVRPA, RXIC etc Probably the timeout ones as well, though they
need some thought.

CF1-4 are something related to calibration frequency.  I'm not sure
if you would expose these as anything at all from this register.

ERRORX tend to be things you'd leave on and wire up to some logging or similar,
probably rate limited.  CRC stuff is driver internal, userspace doesn't care.

RSTDONE is part of startup sequence, don't expose that to userspace.

So it is very much case by case.   If you want more detailed answers
you should write a short description of the individual interrupt source
and how it is used in data capture etc.

Hope that helps a little.

Jonathan
